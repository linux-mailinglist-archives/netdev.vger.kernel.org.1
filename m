Return-Path: <netdev+bounces-292364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN1OFUYXF2px3wcAu9opvQ
	(envelope-from <netdev+bounces-292364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:09:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB82F5E77D1
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 413773066AAE
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277A73128A3;
	Wed, 27 May 2026 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Y5u43nQ/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mxnny7d3"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CCA83A14
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897717; cv=none; b=bIVHjUNMZGME2RkswkGlK7CyjqBR7KWzch71L33XvGZLAUIHLOLDTK/HE/KUYMJOfiytC9IPuH6M/iI7ocJR+/Kh58NsUzoY13f6tEO87TFeQ9HTDddpWuphtuZmag1rgZijj9vqkzkfaYe3SWAgKDf/Af7/RiQT+f+nnHR3Ezc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897717; c=relaxed/simple;
	bh=UWZmGfX14Wsf3E+sb2AYYiMPkB89DwZq2hYjelGdyg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MU8a0iwmzpPYMH92A2N0nE7Wz5Nawtqpmvf/gIzZqkesQgbwqUlOcCzlErPklG2NKHuN9iZb8Zes6ROvCbg+1LzIU7d4+1wkaTSZtXlvaiYhgjJnw8WKZa4/ZSQaRkZEWB6lv2rdX3Mxyso3x6yDfoAAUgDscWFBlCCuS5mpV8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Y5u43nQ/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mxnny7d3; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0BD9C1400134;
	Wed, 27 May 2026 12:01:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 27 May 2026 12:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1779897713; x=
	1779984113; bh=EGiiw28n4iAu8SxxDGLlNevoj8r/P+Cnm8rYvxwf2RU=; b=Y
	5u43nQ/ueB589NXFhmKQH4aQmAFYRCez+zmU6CZb+xIdQfLLcu19juzPqbl9sGIl
	mowJLPUJPXyCuPrBJHQ+yYk2TivLpS/6p/CA1kmpNbuUABWpUWnx2xIDq+fCWBIL
	rkrfpuWEm2bER5vhSDGKzMuaTBLnZtPJWgOV0wIUQkrdLpQU2ONOBOc/A+pl8XyZ
	1zlqigxvJRGxf/rkXNmMaWOwZt/rKrneJe8OMwJyJhN+VLSaK2oI/ozo8dNiI9sZ
	YFT5bxm1/P9pLd8xdbrWBmwC5Kcxuo2TlQSsH9kaXAylYl6OPY101OX1YQ7IJjvp
	OSy0ykIjNgj1tGmhuYVnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779897713; x=1779984113; bh=EGiiw28n4iAu8SxxDGLlNevoj8r/P+Cnm8r
	Yvxwf2RU=; b=mxnny7d3sUYufdxjk41a6qz9a3O3sWlg5D65G9Go+m782DWpzsA
	T2axPgme+78wuIHVyRe9AAdVMglNf1q3EsLWnsdC57LgazhQzf+mK8xznOtUz8li
	1skSXeI9XBlO0a9TGlz0auIrEUfezYPqpP439TxIQaHEGOaBlEI4rioJYeZ5iBAz
	XSWRMLRFrNGhnrkYcXMADWNeef2CJ2dJfKCLCqVFmMz+DyKw3EvWEy+ghhp00yiP
	G+CxlOqoqqSzruiNqMvzIQChFpItWXLlQk5I7T7/wFpBlK9I4gTJbwivNi19m5xJ
	tqdbmgGK0mzg3N/sO5E2MWw2QITjY/wy16w==
X-ME-Sender: <xms:bxUXaufUiRpSe6JFTYwpgpyGFqogFse5LxQJhRR2u4XuO7RVUs7Epg>
    <xme:bxUXahKK57xkkcnK6V_XjBl-AsPyw2D2lfJdISjjUuFW1-YKsFrRbHxiFBmcnY1Uy
    BMgC9PlYV6MmiJZmFWzZSl_lHkUuPn0W6WuiOUJIWY2uAjh78qFb7Il>
X-ME-Received: <xmr:bxUXarE9c6_G_lP8iF2Hw6srxnwxO3BZnSXWegBpTbxzMasMPPQGYeE57pTeFOzEfQm3HZu9CMuNFB40G_s8_cQ>
X-ME-Proxy-Cause: dmFkZTGUohCGPrIb8d/pC/RnJmn1Mu2U/J7Qb4HFyxMjMz3MPyu4OYioPzBZtGMHhBe/g5
    354lA0t8phvmeq7IEpijNArMEmKmpoKTLJ12o04Un8Wqr8bLskazzMC9Sc1FMhYVb2uXrW
    HJZQSaHM2Sdwc4VRuv2qCnJP4msjZgKFzQUvSUZd+k2s/71lH7eSQtXS+NSUO7ddGplkVh
    VnLVNk9Yw6fIgmU/pj+E2K5yYtd1htslzv6+HAHUWUAwrOPGaR3mH2Kg67ZJAS6iyIEPpC
    UxZN76o9lQGx/Of8NM2Ssre2DA1klgczVY0Bc/L1JxJjx3/cQZIiMFEmGlKOjNOn9X8iO6
    cswDwOWLmodvJ8/g3p+H5m7jnJG1oVfmlz5fXrPBGseknRVGf4OfouAn89nNiM+qqYAQwh
    IrsVHfjpd6/bz5CqWYzAZMh0rqidHt9pKVIeRbkH699kQQO2sR4qnr7JZFdTbJDHlV/Vx2
    M3IiSSgeAWxB02qorCfjrsdVZtmQw98uwti+vjTefjgLJqnEu9ON8cj4Ca7rLMQgn/hxoM
    MFN7GFZaaAjpgEbzqjZB4f2mIX6qu9hujzGRYiWtMv4zFHldqu7t7ldeTHptiAHF09w+wx
    s9xT/Jpe2LRP+al9xNplNq3fPIlIeAzFTZ3jRNuh0pVynWE4m/xGjpNqZS+A
X-ME-Proxy: <xmx:bxUXasCLG5LVTXco6CJMHY3d6vqTadDr6sBHN8shphiy4sM1weKqBQ>
    <xmx:bxUXam9bDJORtvgO9jtm8OEhTiM9EurF0LOVo06fUZRF3-0Bv4D4QA>
    <xmx:bxUXagAYqia2biYUdbNfqEBVzP1ZW19wMp3Ne4jG3WGoGQ3OLNzPKQ>
    <xmx:bxUXajQHcs7Kd6iyKP-pS3agA86oKswA2VsJ7Hyl7vigUuX3AWYtPw>
    <xmx:cRUXanuczGdyGCoFVCVxldbPrkyLhTFq5dbaOmHazrCwjW4PKkivRnR7>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 12:01:51 -0400 (EDT)
Date: Wed, 27 May 2026 18:01:49 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Petr Wozniak <petr.wozniak@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, davem@davemloft.net
Subject: Re: [PATCH net-next] xfrm: fix xfrm_dev_offload_ok() returning true
 for software SAs
Message-ID: <ahcVbeG79PibbM3M@krikkit>
References: <20260527140948.21162-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260527140948.21162-1-petr.wozniak@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-292364-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,queasysnail.net:dkim]
X-Rspamd-Queue-Id: AB82F5E77D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-05-27, 16:09:48 +0200, Petr Wozniak wrote:
> xfrm_dev_offload_ok() reaches the ok: label when the SA has no
> offload device (dev == NULL, SW SA) because the guard condition
> "(!dev || dev == xfrm_dst_path(dst)->dev)" evaluates true for
> dev == NULL.  The explicit "if (!dev) return true" at ok: then
> incorrectly routes the SW SA onto the GSO offload path.

Incorrectly? IPsec in SW with GSO is a valid setup. I think you're
breaking that with your patch.

-- 
Sabrina

