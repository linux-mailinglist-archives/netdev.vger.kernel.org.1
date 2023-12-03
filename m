Return-Path: <netdev+bounces-53303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E871802292
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 11:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8F11F2109F
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 10:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B0D8F65;
	Sun,  3 Dec 2023 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niFuO8i6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92C22F27;
	Sun,  3 Dec 2023 10:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A62C433C9;
	Sun,  3 Dec 2023 10:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701601075;
	bh=43f8bUPZp0iGFDUL0GcDc58JQwF/ijHhb/27pEEGxts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=niFuO8i67ZUQKhOErcUDpenEFCIDxGsu17E6g4mMYektxGBjZFge02x7adZtgs+hb
	 LJPH5bHC7hdMZqY3N4EJfXUrBDgilT08Kh/MayXl+hKeEklwvicQDJx/GdRA9QVQt7
	 TXojEbpzQ+it7+EzQDTfmM+Mr3B2M+sptI/aEJJYeGR0qAxH7ORisaZYr/PT+PDo0C
	 x7ni2z1iQUkHOhBM02mefMWwnr2lmiM78Ox7TcPlqJvkP8WAiHAzaiINKriQTTU9B5
	 e2BBq0WNEc36rvtV+6vvm6d3NDTygX3u3xcb/YoNHF+NeZx/oCQwOlN/N5AJISCwrb
	 uh4EUPRCheGwg==
Date: Sun, 3 Dec 2023 10:57:48 +0000
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 1/3] bpf: make common crypto API for TC/XDP
 programs
Message-ID: <20231203105748.GD50400@kernel.org>
References: <20231202010604.1877561-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202010604.1877561-1-vadfed@meta.com>

On Fri, Dec 01, 2023 at 05:06:02PM -0800, Vadim Fedorenko wrote:
> Add crypto API support to BPF to be able to decrypt or encrypt packets
> in TC/XDP BPF programs. Special care should be taken for initialization
> part of crypto algo because crypto alloc) doesn't work with preemtion
> disabled, it can be run only in sleepable BPF program. Also async crypto
> is not supported because of the very same issue - TC/XDP BPF programs
> are not sleepable.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

...

> +/**
> + * bpf_crypto_ctx_create() - Create a mutable BPF crypto context.
> + *
> + * Allocates a crypto context that can be used, acquired, and released by
> + * a BPF program. The crypto context returned by this function must either
> + * be embedded in a map as a kptr, or freed with bpf_crypto_ctx_release().
> + * As crypto API functions use GFP_KERNEL allocations, this function can
> + * only be used in sleepable BPF programs.
> + *
> + * bpf_crypto_ctx_create() allocates memory for crypto context.
> + * It may return NULL if no memory is available.
> + * @type__str: pointer to string representation of crypto type.
> + * @algo__str: pointer to string representation of algorithm.
> + * @pkey:      bpf_dynptr which holds cipher key to do crypto.

Hi Vadim,

a minor nit from my side: something about @authsize should go here.

> + * @err:       integer to store error code when NULL is returned
> + */
> +__bpf_kfunc struct bpf_crypto_ctx *
> +bpf_crypto_ctx_create(const char *type__str, const char *algo__str,
> +		      const struct bpf_dynptr_kern *pkey,
> +		      unsigned int authsize, int *err)

...

