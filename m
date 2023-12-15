Return-Path: <netdev+bounces-57765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 083A281409B
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098281C20DE4
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6601FBC;
	Fri, 15 Dec 2023 03:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLbWrGGs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E1346AB
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2F4C433C9;
	Fri, 15 Dec 2023 03:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702610640;
	bh=dUb3lYiz6viYzCIQIpCfmLZdwe/9D/jSYzX3aaPNveo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cLbWrGGs2vLpxocTFLqjZBOSqp46ZohkGAgSiPSt77TteDv1xl3+KsvANhwDZ9TbJ
	 Pb8WgRuSO3TQU8MD/f32EZPEUQOlVvadnAPpnHuvzpV8POmiESeYu79acPugXmKS1V
	 te4CnKZhD8WAUDTq+EVGxGN8h8UMD9JNpAfNrkiko+6VsjLizfltFRt8sJwMFm59nR
	 m8slEk5ZuxAym0KpG/cgH7DyncmpQvXk1DvR7p6pM5OJ6hlPPEGnOo0Hn5ecnRlYTu
	 bjgwOql+xJ5gnfa+iPGP9a4bIe52ihSZqLMCk95VJaxB/KWJO5ekSu9+uEywq118fG
	 lYt4QQRWwFfSQ==
Date: Thu, 14 Dec 2023 19:23:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
 johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
 amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org,
 przemyslaw.kitszel@intel.com
Subject: Re: [patch net-next v7 5/9] genetlink: introduce per-sock family
 private storage
Message-ID: <20231214192358.1b150fda@kernel.org>
In-Reply-To: <20231214181549.1270696-6-jiri@resnulli.us>
References: <20231214181549.1270696-1-jiri@resnulli.us>
	<20231214181549.1270696-6-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 19:15:45 +0100 Jiri Pirko wrote:
> - converted family->sock_priv_list to family->sock_privs xarray
>   and use it to store the per-socket privs, use sock pointer as
>   an xarrar index. This made the code much simpler

Nice! 

FWIW I think I remember Willy saying that storing pointers in xarray is
comparatively inefficient / slow, but we can cross that bridge later.

> +void *__genl_sk_priv_get(struct genl_family *family, struct sock *sk)
> +{
> +	if (WARN_ON_ONCE(!family->sock_privs))
> +		return NULL;
> +	return xa_load(family->sock_privs, (unsigned long) sk);
> +}
> +
> +/**
> + * genl_sk_priv_get - Get family private pointer for socket
> + *
> + * @family: family
> + * @sk: socket
> + *
> + * Lookup a private memory for a Generic netlink family and specified socket.
> + * Allocate the private memory in case it was not already done.
> + *
> + * Return: valid pointer on success, otherwise negative error value
> + * encoded by ERR_PTR().

nit: probably better if __genl_sk_priv_get() returned an error pointer
     if family is broken, save ourselves the bot-generated "fixes"..

> + */
> +void *genl_sk_priv_get(struct genl_family *family, struct sock *sk)
> +{
> +	void *priv, *old_priv;
> +
> +	priv = __genl_sk_priv_get(family, sk);
> +	if (priv)
> +		return priv;


