Return-Path: <netdev+bounces-281039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKaCA16+62ngQwAAu9opvQ
	(envelope-from <netdev+bounces-281039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 21:02:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D16462A41
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 21:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 767FC3020876
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 19:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A8C3FA5C0;
	Fri, 24 Apr 2026 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBOmyvSp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B433F9F52
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777057371; cv=none; b=X/IGWTa/2vWocyDAuVW6jxmzvUI3LXr476SyBJl4V85HIbaawSvkGq3XBzfXKGFoBYG9/O40Bxz3ImRzwqm84XuPIt/YAdFgmktczMXSrbthHfVPQUIWNJx2F3/wV2OFfyM1rixaobzmHa+MdVXv49xiwYeitWt3LCbMSpa2jK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777057371; c=relaxed/simple;
	bh=gb45/oqhAOA3WMHez4z8ZFzbFW8uPRkRLGqn5ya+m1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uvlo7bx1nyuu+yF1JNUxuYyN/CiX69kiLmh4xtPNF5za1YD4TWDDflpA8Xr9KpC7cggFCceAY0mLeVV7lLQTyU5z2ciUYhX+nhuFJLox6jAn0u2DxWxSOHz5Ajbk1aKo+UcrKxvYcElneU55lPRrk3VD3xfazRw4n7U8INnLxmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBOmyvSp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so104810905e9.0
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 12:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777057366; x=1777662166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/1TWGPl8GQ6EGftPy9BnY4YxVrgEeuJpqvfXBBU0i7s=;
        b=JBOmyvSpXcnzFjBljjAnMoDJHBK402+VoMqf9MEXfGX3Vi7YePdRJwiM0HXhLVBATO
         w4tm5iUzVseO5yFHBa8GvIzD2TjT2iGtCaNePcOUIE5zSLDwEj8IZ+hMKrZhl27yOQWR
         ha7Q00zvkqzACD31Xkd6XjmGJr0cPrdljvpuUYMMAcvnG4GZuS17cbyfhIjZuEh4fjnb
         yAnmjxiNt008jhOVVG3zU+rcmJI0DsCOfGVzBSxKW8wQ58bX0lYhYfQ23OEXaEv+vXoG
         M4ZaXuTpm2On5s1Cb1dpHGqDoCwRqMnsnX0Psi2cf6oumjQNssUet3Yn1LZGdzDWOodE
         A1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777057366; x=1777662166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1TWGPl8GQ6EGftPy9BnY4YxVrgEeuJpqvfXBBU0i7s=;
        b=tOIUUfR6F4Nj2rTL39Fxf0C5k8n4KGdktOs8EQDEbjlwOSuebZN8nyDgZ+LZjGE4vh
         60wB/5Fwaov1n9DARM7VR8WFmrncRo+M8u5Hl5CXDZ2AzCiOXIHC8lWMcb4ae3Is/Wjf
         6Lz/xjNpABdQcIXTkCRWUjAw+JTOuklEzd61zM9HP0E4rm1pyIghe97uPTGWHHvTVPDC
         FeR9qm9WUemQdQYwyasrQatic/PeOPd8cs4IpV1cIs6GtPuXrH0CGu+T0H86IBZO8VLj
         1oVVooE6cPo8vs4fG3Hy0PuWBg+JsPdrmXziR4/l+7o0JyDJUAdm7VmTo811AshWIeak
         +zlw==
X-Forwarded-Encrypted: i=1; AFNElJ/BR+ya3LTkNfcLKs/T6DtwBSiOo45qsg3wwoPvccwF4wZl39p2+H77d/5vnCT70/eRrshAI+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0pbj3FPl8DmU7itLDPBEJCZLpqeqKy0iq7PhGWEnhdfcGPNKT
	ON/QCHSA8zDZcAFg5miZIuDtppoMs5MH3rmWz36sK7udm3iCWhLrfW5H
X-Gm-Gg: AeBDiesqCKpXUNAsWhx3dWoIPBnzQWtbzFoZy2FLeHmiS6N00hWLjZ+MG17D46pX3Fg
	o0kvqHm4ksq7qk9td9hv7rpEc2LR+CQSqPp6NmGivVy5paSG3qQbrZbPIGUpy/cJBV5hbWpBRMt
	VW6dSA6UDba9hTZOLlIv/cNyyBk/3yZyjeIVTRdfQUGTR9X4KN65MrEUDXHGEwg9aSDp/UiFBLZ
	zeznx3N0sX0C6o8NpzPHOTUOzD+5J3SqWJhHBc804t53fr5obvYAx8EHApmH1M5+gfB9hckFAF7
	P4GaO/YFfm765rMm+Ja3STPemjsV4OCspEawL64+/fUzCivnUOmarSyOj4ASo6rzbNCLokbpJya
	HB8Lbg6tiAsJ9aO45eNyCZ+fLffLNmijeHjdv/4xNdYlf/ey/sk8+lK2Oli8ZqR111HtRZWwhqK
	Shd+wWjqRVelnGEvR8DdRhkPgOgBJEWj79j4jagaERC77wmagML9dalHdoXgj7A8HP6/4RGU5De
	9UONHT9f6boWaxAuC4DMQ==
X-Received: by 2002:a05:600c:2d4b:b0:489:c57:75da with SMTP id 5b1f17b1804b1-4890c57760emr224728995e9.31.1777057366253;
        Fri, 24 Apr 2026 12:02:46 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a52d232afsm106937625e9.31.2026.04.24.12.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 12:02:45 -0700 (PDT)
Message-ID: <68e42b44-d77c-4bbf-b808-9927de9dad48@gmail.com>
Date: Fri, 24 Apr 2026 20:02:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v1 1/1] bpf: Fix sk_local_storage diag dumping
 uninitialized special fields
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@kernel.org, kernel-team@meta.com
References: <20260423222356.155387-1-ameryhung@gmail.com>
 <8cc73c03-afb6-4b7d-97ea-e05d9cc56c2d@gmail.com>
 <2026424184430.ui0Q.martin.lau@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <2026424184430.ui0Q.martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 82D16462A41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,meta.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-281039-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mykytayatsenko5@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]



On 4/24/26 7:49 PM, Martin KaFai Lau wrote:
> On Fri, Apr 24, 2026 at 12:50:34AM +0100, Mykyta Yatsenko wrote:
>>> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
>>> index 14eb7812bda4..b50d26a542ed 100644
>>> --- a/net/core/bpf_sk_storage.c
>>> +++ b/net/core/bpf_sk_storage.c
>>> @@ -558,6 +558,7 @@ static int diag_get(struct bpf_local_storage_data *sdata, struct sk_buff *skb)
>>>    				      sdata->data, true);
>>>    	else
>>>    		copy_map_value(&smap->map, nla_data(nla_value), sdata->data);
>>> +	check_and_init_map_value(&smap->map, nla_data(nla_value));
>>
>> I think check_and_init_map_value() should be moved before the
>> copy_map_value(), because copy_map_value_locked() already uses
>> spin lock special field, which if uninitialized can deadlock?
> 
> The src (sdata->data) lock is used instead of
> the dst (nla_data(nla_value)) lock, so it should be fine.

Right, the lock is protecting from torn read, my bad, thanks!

