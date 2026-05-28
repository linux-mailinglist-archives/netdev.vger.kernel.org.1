Return-Path: <netdev+bounces-292612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IJpNKYIGGrGaQgAu9opvQ
	(envelope-from <netdev+bounces-292612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:19:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D770D5EF771
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2B2B30920F5
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC93339EF2C;
	Thu, 28 May 2026 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQcEWlkw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lQeLQuYm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E078439FCB4
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959178; cv=none; b=hyGsR5BELjfw0mTXO8oRFafSgAazVRGX/Mu2H3F51SY2HxOfAm+DbNQ62oh1g3Vhu7LLKj8Lic8DNN9pduOqSRFTkZdem9sMyALIxaoakTNfPFEZ/T7eNc/i+GLYDtFaB68Qfl2GGS/ipdU9UcBJylXAEeQp8Eb9F/kUtwD77vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959178; c=relaxed/simple;
	bh=YY8EWyebk0SOmJSAYZE22d11en6G2zeids67aOJkdqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cw2juxDs8O0irK4UOd/6S8jr10p32Byn5YO6mk1O+VHls25dDW7f8FKPkt0rg0bTazYRjp1nS7+J+H15KvXqfai/wFCyqWqHNma1KlR9l6+NkvZEqBf2a4u+EKkONe1KYROIi506WNa88rEFHwLTgT/5KwK4pQmE2J2xe8X0PGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQcEWlkw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lQeLQuYm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779959173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6pYU/IqCkjL+VFBm6flzj1TF3LtL/WQ39XWA/vMkHTQ=;
	b=EQcEWlkwOFCTHN9c4pQB0vG7ZXVDbE08DuHdmWjvQnzs8N/UdtaMrRdBMEz+VIK3ogc/0v
	ImfE1MbBkNw71Iq2dBQw7WeLamLoo2Iz7qKptovTq8gKzN4lyA9d+60ggrOjNCcAM7DGnb
	NaYHhCu+V+8pHMzxzf5ilQ5hfayh04E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-xcKSTYiZO8W7X9HK7Hkqxw-1; Thu, 28 May 2026 05:06:12 -0400
X-MC-Unique: xcKSTYiZO8W7X9HK7Hkqxw-1
X-Mimecast-MFC-AGG-ID: xcKSTYiZO8W7X9HK7Hkqxw_1779959171
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49045243094so85359945e9.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 02:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779959171; x=1780563971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6pYU/IqCkjL+VFBm6flzj1TF3LtL/WQ39XWA/vMkHTQ=;
        b=lQeLQuYme+hM4eLbD+grQ8i2h1FsYt9DZFgFepsDxXsiE8nacrHvCw04DdAoTC7mpq
         GwWCE+1ic7AThbhdfJoWoYtzdSCDSicPjg2IlZ+RR/M4Tyc0xkCyACSnmaHYjdtAbadF
         gslk9wNJ6pzdoFtePfb9JsHLbMDm9DB/aZkAcpNe56qxUCc8/Lji0agG0+bU9nv3dNvW
         oKe14xD0obgEaFvvgejBrQjhs4WCiTpkgZnPzj9R1AHuYXra5mUxwTb7Yecjl61fYdJY
         h+X1d2hNEhM/6H1LkDDNq2NKqG2+nLTXu62YVM2iODwrQiphOLDgfECPaM0se+2pIuFM
         8Knw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779959171; x=1780563971;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pYU/IqCkjL+VFBm6flzj1TF3LtL/WQ39XWA/vMkHTQ=;
        b=hb9cFykrlI6PH2lJeFXDj9BvvgLr6yVaqSKpDYj3vcFl4RM+nO9NB2gPepDV6NRXOs
         2LQKEcQeZHrfK2R9Ry+VHyhje/3L9XrnSDFRMvw7izf98HX5dpV28K48wI7fFl7UM9ri
         7UXZF3UTlFPE9zMIl235qTnkhBFa5y1kVVrKs43WSa3MbWDiH7Ks3lAoBztDIaomEBgA
         0JxaVYaMsb6lCPNDb4W0niMEvA7v8oJbn7QFYd0J+5GaKOsCgKlLcxyl4AzkyF56F5HD
         AdcyrAIEt2/0zGPzHKOtJgNR75hVRjJoyoljWUsiSvjgVPUL4PHMCW7uxMNMUw49hCDN
         uYag==
X-Forwarded-Encrypted: i=1; AFNElJ/k8dhfAq6EBsOPCxtZzEFtXpAX5MGjGLJdVSAwPG2ftNNRgrFjRMC+Xq57fG6Aq8GypSUaUp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhqDB1U+1HIrugVOU6mNnJOoN6TS76CHVCBa8CgLKxRpJgAlPu
	o2u1Li2xQUtUXn35V8SkvT652oZunYSqGBipAoynfb0bwVT7xxXI+zltdIfElJIIJds15coyeD7
	4SjEKz6mxj44j5WWyYFcmBtv0yrSG5X+7H64sWQvSAFB43W1pZy9QNKCYOw==
X-Gm-Gg: Acq92OFsjmaMn+yWP+bKYpIuxGe+DdS56KpN9tZeBPZ8OwHI6dH+jyJxA4WazFRQP4O
	SPja5oEA19n9CCQxS3nSeh3fW7FpecY6icLjQ21sDLGkmKPKsEbSYkX1X1vSJn1BEc/UwG30ZrJ
	daGpxRkL56EAe6WXzbUG/p+6+kw2mLhXzeWNEBdmhugMF8hUME49TLRpsot8BvW1FLln8XDppdj
	FcIqAwpZmtEL1NyNbwxul8QScBeE9X2ZnsKFdpggsFdvQK/ltc5fuaXD+VL1TC9ThLBKgn6uFHj
	qKkDafJkAYzGxbqDYDW8KFYzEOeNApCOj9mdmyh/FLo+YdOIpB6Tbrb7cRFrHt2fjtEbWxZTLwB
	pkANp0iUZ6m7pNvc8Y+/y9biIIi8iZh5eEvXDQSM5+uUmu0HFDc+EJfMqqoUL7Iou1Q==
X-Received: by 2002:a05:600c:3581:b0:490:482c:4391 with SMTP id 5b1f17b1804b1-490482c4586mr468142555e9.23.1779959170885;
        Thu, 28 May 2026 02:06:10 -0700 (PDT)
X-Received: by 2002:a05:600c:3581:b0:490:482c:4391 with SMTP id 5b1f17b1804b1-490482c4586mr468141755e9.23.1779959170408;
        Thu, 28 May 2026 02:06:10 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909294cafasm27786035e9.11.2026.05.28.02.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 02:06:09 -0700 (PDT)
Message-ID: <b0b0ac82-bcbf-4aef-bf6f-7340f9517fc6@redhat.com>
Date: Thu, 28 May 2026 11:06:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 net-next 0/6] net: hns3: enhance tc flow offload
 support
To: Jijie Shao <shaojijie@huawei.com>, Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, shenjian15@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, huangdonghua3@h-partners.com,
 yangshuaisong@h-partners.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260523105449.661848-1-shaojijie@huawei.com>
 <20260527095930.GI2256768@horms.kernel.org>
 <c6dc79ef-5f6e-4c97-97da-fa50eb1d1370@huawei.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <c6dc79ef-5f6e-4c97-97da-fa50eb1d1370@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292612-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sashiko.dev:url]
X-Rspamd-Queue-Id: D770D5EF771
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 3:12 PM, Jijie Shao wrote:
> on 2026/5/27 17:59, Simon Horman wrote:
>> On Sat, May 23, 2026 at 06:54:43PM +0800, Jijie Shao wrote:
>>> This patchset enhances the tc flow offload support for hns3 driver:
>>>
>>> - Patch 1: Refactor hclge_add_cls_flower() to support more actions
>>> - Patch 2: Improve unused_tuple parameter setting for separate src/dst configuration
>>> - Patch 3: Add support for HCLGE_FD_ACTION_SELECT_QUEUE and HCLGE_FD_ACTION_DROP_PACKET actions
>>> - Patch 4: Add support for FLOW_DISSECTOR_KEY_IP and FLOW_DISSECTOR_KEY_ENC_KEYID dissectors
>>> - Patch 5: Add debugfs support for dumping FD rules
>>> - Patch 6: Move FD code to a separate file (hclge_fd.c) for better code organization
>>>
>>> ---
>>> ChangeLog:
>>> v1 -> v2:
>>>    - Fixed warnings similar to "warning: restricted __le32 degrades to integer",
>>>      pointed out by Jakub
>>>    - Fixed warnings related to
>>>      "warning: diagnostic behavior may be improved by adding the 'format(printf, 5, 7)'",
>>>      pointed out by Jakub
>>>    v1: https://lore.kernel.org/all/20260518093526.1109595-1-shaojijie@huawei.com/
>> Hi Juijie,
>>
>> There are AI-generated reviews of this patch-set available at
>> https://netdev-ai.bots.linux.dev/ and https://sashiko.dev/
> 
> Hi,
> 
> I'm sorry, I don't understand how to use https://netdev-ai.bots.linux.dev/, it seems to require an API Token?
> I find it difficult to locate my own patch-set in Recent Reviews.

The nipa sashiko instance has the same web UI as sashiko.dev. The full
URL for the former is:

https://netdev-ai.bots.linux.dev/sashiko/

You can lookup your series by the cover letter title or you can use the
direct link including the msg id for the cover:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260523105449.661848-1-shaojijie%40huawei.com

> Regarding https://sashiko.dev/, I checked and some of the issues are pre-existing issues,
> not caused by the new features added in this patch-set.
> 
> Some others are related to the solution, which is the same as the ethtool -U  already supported by the driver.
> I suggest keeping it consistent with ethtool -U for now.

I'm not sure which comment do you refer above.

This one:

---
> +		if (is_zero_ether_addr(match.key->dst))
> +			rule->unused_tuple |= BIT(INNER_DST_MAC);
> +		if (is_zero_ether_addr(match.key->src))
> +			rule->unused_tuple |= BIT(INNER_SRC_MAC);
Should the "is this tuple unused" decision be driven by the mask
rather than the key?
A tc-flower rule that explicitly matches an all-zero address, for
example:
    tc filter add ... flower dst_mac 00:00:00:00:00:00 ...
    tc filter add ... flower src_ip 0.0.0.0 ...
    tc filter add ... flower src_ip :: ...
produces match.key->{src,dst} == 0 with match.mask->{src,dst} set to
all-ones. With the new checks above, those rules now have
INNER_{SRC,DST}_MAC / INNER_{SRC,DST}_IP added to rule->unused_tuple
even though the user asked to match exactly that address.
Downstream, hclge_fd_convert_tuple() short-circuits on unused_tuple:
    if (rule->unused_tuple & BIT(tuple_bit))
        return true;
so the tuple is not programmed into the TCAM key and the field is
effectively wildcarded in hardware, with no -EINVAL or extack returned
to the user.
Real-world patterns that rely on all-zero addresses include DHCPv4
DISCOVER (src 0.0.0.0), IPv6 DAD/NUD probes and DHCPv6 (src ::), and
deliberate matches on the all-zero MAC.
---

and similar later ones look real/relevant to me, and IMHO should be
addressed.

/P


