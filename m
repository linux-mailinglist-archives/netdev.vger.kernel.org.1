Return-Path: <netdev+bounces-266179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJguK4QxsGkShAIAu9opvQ
	(envelope-from <netdev+bounces-266179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:58:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 161E8252B53
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28D6E33679CA
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC9D2DC76B;
	Tue, 10 Mar 2026 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1drF4fH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE26299A84
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773152746; cv=none; b=n5zKT1Bs12xOKSxObzoIwXz5V8pzp0OyqRmNutvJcAmQpyfEMjghwe5QLVy0Ae5JuPYaeq5AxYQ52Nz8ZKVID+ifw6xjFHHH6YOk6DzXYb0Bjn8ueEFe5+Y9Q0Eu/FYtsWzo0z3j9fSwoJ7AgR3LeZJ7oCY3uw/q/VgQUlri03o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773152746; c=relaxed/simple;
	bh=BRo1R7FLUt9wGUx965N0k9ZgMgTk3OzCILYQeQGtP6A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YTwTVl3Mw9zF3CL1g4UC45WDWejMM6RtWjC7gYNTOrAovjT7mVS4/blcT3GpkzTRMZ66U5v7Ewb2wKqTJCkopsbArWjb4YQxvyssURnxamr3O7JTYAVbgRtD/IzW2rxV0EoD5V37zqYtkb/QZ7sCkRV2UKxaRmJg7aIZJ+hqjkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1drF4fH; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cd7aab92dfso341862885a.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773152744; x=1773757544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rf7g1Z7W2ajIKmG0A1EyBZJZa0v3yYkcRJRaRvtJ0q4=;
        b=h1drF4fHLbm8AAfpMr/WgUdBfzWBXKJc20IPRae++WLQcUTCELIda7vyoAHPH4Jk+8
         pmCAyaxP5UrZlWfORpPIjbZNSWlImQV5FgPvQaNEYqGjavLshtugDSllFBAG9FCpED5E
         A/qWZkum03fK/bZ4ICYptCNuBkf+YIoAFtTKA4dg4y/jqoZ1PKPohF9uNL1TQZVc8sYH
         rqFC2cO6JPumsOF1S7XJs2imS0iEVpmyTaZTxb3SXumLoDOiEgXYMeo1s7TIMnz/uIKe
         GmVlBVR0NCJqFGjCS3/l6ldkSWYt+TJusMZCnF0D4mOOjyOmeRFmhKyHXLLqgGQPiXTI
         +OzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773152744; x=1773757544;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rf7g1Z7W2ajIKmG0A1EyBZJZa0v3yYkcRJRaRvtJ0q4=;
        b=wbUtg9vTyNvKw/YaH3us+FNcFjxxbhzwSvf5vt4GBjTN1HfUOTVfYZMjMlZQyXpdU8
         ywkwPDmkvyGFA9Awg/ksbPeu1TyoCO2b8uGQ0MEykhZA/gXVFchGFlgxlqI1+noh/EHT
         gAtGZMX1RcnAQjG+AZReiyAf/kniKnfGnCMFqj6OeAHpk3+Uu/W1Kakxs9wX/iemKThw
         RVif4TvdXrMeSjSryuxgoae2FLv+0ajv4HbE3YQDAJO4FOcl1fW5dMtIJZ9gsYvUf3TH
         Dr34hG6IOG7YXammIltie3S2HxJIXbwBs1EuLZRfbmw4lxAabejzCrUD6bhE4eUe36HH
         B+/g==
X-Forwarded-Encrypted: i=1; AJvYcCU7Z3YauG0F7BNngkGnOAnJTsFaKenjt+tZssEg0E9uD4+YkCYrzOtSrPtrKtpyukrkfV7G6ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPb7S+/G86TO63S5H6VUSPNnawAOlyP5ehxLc0haVOeyDFVzjV
	ioj8j1kjudH7JlsSlR6s9KsRjP294dwtOYhFtv32v+sAgwoEgv7lXW9g
X-Gm-Gg: ATEYQzwQgwCGp3x6ZfBJat3zMLmwF5Dbagk1IavJFiXGDptoPafMEfbQVfb5e8912DD
	81g9yF4BCRhkwL11dxbSHuWpaII3fytSkMvuddiFyMvOIDNfIL8X9jwydY7AnfuervWdgsOQqeO
	vLeT+l5Ud7vxx7THErZJJCBGpOlvrs/iMn+vJ05wM/1gbcR/amN3MNK/qYlOItJun8wTDZIUQYc
	kBDUv4tOCBWfiJp/1Vgo1B3TytJyG9r/8R4r2exf1MMo4HB+YCoQ5i9m2ZFhTZLE8XBjPFw2ECp
	c69mh11MdE+9HbuOUk9w9Q4sLGo2xkZbrZagYMMACn6dABHUpkKu9IUgmQl5FJbJPImPvDTcges
	2FKq2jchQcEpfLKnDDudDgAPiV/c5a/r949zt+WduB/Y5EVAgVi16LPzX0hszc37RURMeWBcNNY
	cskLMVyBEN6U90JmI1c3o3BQEezJJ8U6kaCjyhrgf6cVibrKp6OC7BcJjiSMQXKfUjFg==
X-Received: by 2002:a05:620a:f03:b0:8cd:937f:1402 with SMTP id af79cd13be357-8cd93b5e69amr383623385a.13.1773152743986;
        Tue, 10 Mar 2026 07:25:43 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:3c5c:86e0:6cbd:e5d8? ([2620:10d:c091:500::1:4b47])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd8d4cac0esm361001585a.36.2026.03.10.07.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 07:25:43 -0700 (PDT)
Message-ID: <f316780b-141f-4a91-b517-71034a02aef7@gmail.com>
Date: Tue, 10 Mar 2026 10:25:42 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: Re: [PATCH v3 net-next 2/5] psp: add new netlink cmd for dev-assoc
 and dev-disassoc
To: Wei Wang <weibunny.kernel@gmail.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: Wei Wang <weibunny@fb.com>
References: <20260309183454.2872967-1-weibunny.kernel@gmail.com>
 <20260309183454.2872967-3-weibunny.kernel@gmail.com>
Content-Language: en-US
In-Reply-To: <20260309183454.2872967-3-weibunny.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 161E8252B53
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266179-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/9/26 2:34 PM, Wei Wang wrote:
>   +int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct psp_dev *psd = info->user_ptr[0];
> +	struct psp_assoc_dev *psp_assoc_dev;
> +	struct net_device *assoc_dev;
> +	u32 assoc_ifindex;
> +	struct sk_buff *rsp;
> +	struct net *net;
> +	int nsid;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_IFINDEX) ||
> +	    GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_NSID))
> +		return -EINVAL;
> +
> +	nsid = nla_get_s32(info->attrs[PSP_A_DEV_NSID]);
> +	net = get_net_ns_by_id(genl_info_net(info), nsid);
> +	if (!net) {
> +		NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_DEV_NSID]);
> +		return -EINVAL;
> +	}

hmm, well I guess I still have the same comment from v2. If assoc_dev is 
in the same netns as genl_info_net(info), then userspace would need to 
create a self-referencing nsid to link them together. It might be a 
better uapi to change PSP_A_DEV_NSID to an optional attribute, and if 
not present then look for PSP_A_DEV_IFINDEX inside of genl_info_net(info).

