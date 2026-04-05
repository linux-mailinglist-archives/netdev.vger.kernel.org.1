Return-Path: <netdev+bounces-275468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOG1FGuX0mlWZAcAu9opvQ
	(envelope-from <netdev+bounces-275468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 19:10:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EFB39F1D0
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 19:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48D4330071ED
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 17:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F71131815D;
	Sun,  5 Apr 2026 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG/tdmjd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC06E311C32
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775408999; cv=none; b=uP/maXTVmVtbr4ZHCsLGqOhxkIhiSILH6OjnS5yK8Ype7PyfgxHF0nUdBDL1egpxGI9k4PrIl5OVU9HTPzkWJdkqCSjPz7LnRxWZQZy/xOQ5goU3nxSKsHbeBD3R6dRKZODmmtq+rMvNnQczeAkYlOC4095wIlf9O2jxECzKXrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775408999; c=relaxed/simple;
	bh=3Utr4O8hPBuwFLLFeR8T9L20/U/xBAsHvv/5vKBxW5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFUSHYOJcwBtS6CsuVHuAcmKBBrQn6/u5EW4XDkGCqdnnGvRiVNB65ZWKOI2vqke0gGGB0jQtIAgimweo2085jt5bav4DHZJPjH9p+tx0c7WHu6iN46wYK9IABrYreQE2CrjE0EhBj6SJ/+haNwkoSFAYqagEQZ+N0ZxjezuXbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EG/tdmjd; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-47018d3416aso875464b6e.3
        for <netdev@vger.kernel.org>; Sun, 05 Apr 2026 10:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775408997; x=1776013797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rf6fQnUDBvhchXpYYavW2XdCN8dQGkC2j51Q5ZbRMFc=;
        b=EG/tdmjdlfaZd6MxdfJsw3+O+nJTTTvFCNGbzB1w1fAzqsyMXnCHIVsQRoPyMJKW46
         7wMLQ5tdrS6wGrcG9Z1gUqqDT13wNdJPsM6XoOijvMrf2GYDLJ1r529bD6Jj52x+pwYP
         3RQugIVXLdVb/Wbk9b7+ctEexpV0y9XqmnDLCsi5BpOFE5wvvoE4hnaRlS9mEBwzZVQ7
         ozpC8t2rFHE6Asn06VxX9hWddlC/p2YhnSubQXzudorgzRwkEdChFBo4BHAECj5XMMQX
         0p6NSEPb616Q975KfoXXTIJorg9wGCXhCch35AlN1El1wgZynoInlozyXHU7Tm8/gr4N
         rTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775408997; x=1776013797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rf6fQnUDBvhchXpYYavW2XdCN8dQGkC2j51Q5ZbRMFc=;
        b=ELg/5BG81/8YvsmIh4+OokpZQazwsAu16rAVFPFcXOhIMrkweVpsAUM+cMVi/MjUzj
         DT0ORk9gTvKUYSRbTNLAt/h5NBeAWnrinZwnNux7B07BjAV/OMX6yZDo6qnEJAZz/tOa
         5qujNtQkZ4rtfCGtgsIbWJPD55avgsp/mQWNAupDjmNaG3UmSwhnkN/5lUQRDa7jNjKS
         a0WVSMKMJ47HpVrwrwYoB2LtAFpLzMeXL00EMqB09cGp0oR4TaCfBuoYQ9NP/4VI+5Hk
         c1KrOtHuCQepnU+uGWxrJSa2v2aGS51FjkTGECQLgGQAdtFu2RS0v5UVus3TPRVoMCnf
         FpRg==
X-Forwarded-Encrypted: i=1; AJvYcCWVCqB91bYU2P+w/qZDnvDRSjuBwILs1LXmNsX+WAHC8/K50OFltXM/UWBUFZI/29WzsZUlK/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvu36rTZEYQYynNLW1RiXAGztgGK0DQMXv2VbVdElT/bOaXZNr
	EgQg0qTvF/po3vPRyo3/lEMfw5fAXt5SYy8fnqzvONrAykX0BTGP7Xfl
X-Gm-Gg: AeBDieskY9xfXrXhGQE0XNC7QJfMwuSNyRVHWHiS0dumRdatOC8Nx/AGrNl2Tr4dI/h
	qEvTfJHgclkzb6v+II82ob+hAtC6HJN7uymWRWKjysa1r09Vl9ZJA8Yl77RUgO0qZkCvqbeLuZo
	SW1OlSN/o5tn+KfhSgTMCJMMfImoabjw+Hd4FB1fhxMAJQtxRWzOPX565hLqsez9iAwLc3n9YJU
	V5FCVQsQ07ZDnDH6KqLrDO+TeIplcVvouK6Br0Vf0KheIFb3uETMM/23pgmWURiexSjYYLGlO2G
	7eXdDww6Kw2crWfIxadb69XJbt8xXOKgDiKH4mVrvXJQdIZS2lhCPvv3ZvqVJJ+T+aNPGajEgQ4
	phdY1GeOPXs2LLerCzm+MsRUDr944HZ8WIPbiKy4d093zkIG5FB7nPRktMnTIbhm52IQYfYwZ8B
	wutkNIpjh/dPRvCNN+xSJSC0Iup9R7ojnVu35rPKvpggG45AnPxlE4EbR24EvHNfb2U+F/w9LGb
	6Bb9e9/M3Tg53I=
X-Received: by 2002:a05:6808:c3ec:b0:467:4939:967f with SMTP id 5614622812f47-46efbce4c33mr4572207b6e.48.1775408996659;
        Sun, 05 Apr 2026 10:09:56 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:18c1:5de:49ee:63ea? ([2601:282:1e02:1040:18c1:5de:49ee:63ea])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-46f0f4e16a9sm4651092b6e.4.2026.04.05.10.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 10:09:56 -0700 (PDT)
Message-ID: <a441f862-1ebe-4fd9-9ef5-aac718fb008c@gmail.com>
Date: Sun, 5 Apr 2026 11:09:55 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute2-next 0/4] Introduce FRMR pools
Content-Language: en-US
To: Chiara Meiohas <cmeiohas@nvidia.com>, leon@kernel.org,
 stephen@networkplumber.org
Cc: michaelgur@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260330173118.766885-1-cmeiohas@nvidia.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20260330173118.766885-1-cmeiohas@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275468-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: A0EFB39F1D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 11:31 AM, Chiara Meiohas wrote:
> From Michael: 
> 
> This series adds support for managing Fast Registration Memory Region
> (FRMR) pools in rdma tool, enabling users to monitor and configure FRMR
> pool behavior.
> 
> FRMR pools are used to cache and reuse Fast Registration Memory Region
> handles to improve performance by avoiding the overhead of repeated
> memory region creation and destruction. This series introduces commands
> to view FRMR pool statistics and configure pool parameters such as
> aging time and pinned handle count.
> 
> The 'show' command allows users to display FRMR pools created on
> devices, their properties, and usage statistics. Each pool is identified
> by a unique key (hex-encoded properties) for easy reference in
> subsequent operations.
> 
> The aging 'set' command allows users to modify the aging time parameter,
> which controls how long unused FRMR handles remain in the pool before
> being released.
> 
> The pinned 'set' command allows users to configure the number of pinned
> handles in a pool. Pinned handles are exempt from aging and remain
> permanently available for reuse, which is useful for workloads with
> predictable memory region usage patterns.
> 
> Command usage and examples are included in the commits and man pages.
> 
> These patches are complimentary to the kernel patches:
> https://lore.kernel.org/linux-rdma/20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com/
> 

applied after fixing up a few nits.

Please clone the ai review prompts from:
  https://github.com/masoncl/review-prompts.git

Run the setup scripts and have ai review patches before sending. This
should really be part of both kernel and iproute2 development workflow now.

