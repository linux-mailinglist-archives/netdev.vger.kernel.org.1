Return-Path: <netdev+bounces-65703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E40083B669
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 02:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607451C232BD
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 01:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD49A3D;
	Thu, 25 Jan 2024 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xXgyw593"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8CB1388
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 01:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706145048; cv=none; b=WHbK/PzaoqqW3lNsNoK8uX5jvWVopsc3/UbxTvkNwSWMjUtRIYocXGEl8IFNIJph0LujYcQO3Kfu+27UiiLnqjrYGPT+scKsqztWxDSur5paTFowJmXn1AQssVTNNdapz1avbhDpCbkdZ9Jsgaig2pajD+AtKMN5XnDWaI6lcR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706145048; c=relaxed/simple;
	bh=YSmNdao5oCJmifyqKsSslrmcBNw0WJeOD4CISXYXUEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1nVhiCP2zlZvqIYCGcd7us/KFbfjgrdEtSerS6oehdw1BvSg6LEEMg6JDmpjW7j/XjxGAMyIcSti5wtf661W6EVd8o0lQB1341JpvtaNmhfiwUueDkxg4AmFEWh33QRm2f1WLKnvotyV+Eqfjl8qgxR3U7epiAN/O8qaKnZunE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xXgyw593; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3d2d5f4e-c554-4648-bcec-839d83585123@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706145044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mug9Qt3e1sskjplGiWS6K0cXwUdVu3n5UfoIEbNRZc4=;
	b=xXgyw593u2RlFddy2YvBUGv52hw1nKqfSIKQWusNjz6ctTrMaKSoOyFHEouf3gqRQXTXk6
	fewoo4R2i8f85gVcUQ8lvCGPc4oJO+nLIY8ylG7wdu/rLakC+nAaQCEP+zCfAMS6dCtKs2
	QgW79OlVLFCb3as9auJudWD1SGHulas=
Date: Wed, 24 Jan 2024 17:10:36 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 1/3] bpf: make common crypto API for TC/XDP
 programs
Content-Language: en-US
To: Vadim Fedorenko <vadfed@meta.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
 bpf@vger.kernel.org, Victor Stewart <v@nametag.social>,
 Jakub Kicinski <kuba@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20240115220803.1973440-1-vadfed@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240115220803.1973440-1-vadfed@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/15/24 2:08 PM, Vadim Fedorenko wrote:
> +static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
> +			    const struct bpf_dynptr_kern *src,
> +			    struct bpf_dynptr_kern *dst,
> +			    const struct bpf_dynptr_kern *siv,
> +			    bool decrypt)
> +{
> +	u32 src_len, dst_len, siv_len;
> +	const u8 *psrc;
> +	u8 *pdst, *piv;
> +	int err;
> +
> +	if (ctx->type->get_flags(ctx->tfm) & CRYPTO_TFM_NEED_KEY)

nit. Does the indirect call get_flags() return different values?
Should it be rejected earlier, e.g. in bpf_crypto_ctx_create()?

> +		return -EINVAL;
> +
> +	if (__bpf_dynptr_is_rdonly(dst))
> +		return -EINVAL;
> +
> +	siv_len = __bpf_dynptr_size(siv);
> +	src_len = __bpf_dynptr_size(src);
> +	dst_len = __bpf_dynptr_size(dst);
> +	if (!src_len || !dst_len)
> +		return -EINVAL;
> +
> +	if (siv_len != (ctx->type->ivsize(ctx->tfm) + ctx->type->statesize(ctx->tfm)))

Same here, two indirect calls per en/decrypt kfunc call. Does the return value 
change?

> +		return -EINVAL;
> +
> +	psrc = __bpf_dynptr_data(src, src_len);
> +	if (!psrc)
> +		return -EINVAL;
> +	pdst = __bpf_dynptr_data_rw(dst, dst_len);
> +	if (!pdst)
> +		return -EINVAL;
> +
> +	piv = siv_len ? __bpf_dynptr_data_rw(siv, siv_len) : NULL;
> +	if (siv_len && !piv)
> +		return -EINVAL;
> +
> +	err = decrypt ? ctx->type->decrypt(ctx->tfm, psrc, pdst, src_len, piv)
> +		      : ctx->type->encrypt(ctx->tfm, psrc, pdst, src_len, piv);
> +
> +	return err;
> +}


