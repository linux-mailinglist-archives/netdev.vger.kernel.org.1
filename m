Return-Path: <netdev+bounces-263982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCLULFp2qGnxugAAu9opvQ
	(envelope-from <netdev+bounces-263982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:13:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20690205FA1
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB98E31F8645
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 18:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBBB3E0C57;
	Wed,  4 Mar 2026 18:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wu0Xtm8Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662553E0C49
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647439; cv=none; b=JzmZ6LmXoU1k5v2OtTQegCdB3eOWMr0yl3O/xxyIH+eFsoz7/0/1TJ9I5KUZJ31aPYGCd5fpGcjlW3Y6AYDtyOFG+/UzAmBxFJIWfF2h314CG8SouSiXNs4Ex0qyeGAlqKxaJHgIGJweKkrHMyNk8Bd2WBoA9d+0ZuRyzwYLoUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647439; c=relaxed/simple;
	bh=3Z5FIlxlpEZmdO3CmgYk4J1O9YL3EbPw9phnXp2eaCQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=LDWIc9/aImVBhC4vbM/ffVXIjSf0r0OwseMmLDXGwNOMgXqXYCXHvD8RkffLRKyaSaeRkECS7Nw8J287V0pyyi9zu4wZGEEawcYDHV5WjRis3md7Jt+YqdoN15/kTuZQwRA2N+AMOHITO65AFY6EzRFyyG/dcUs/othU196K1Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wu0Xtm8Z; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb5138df1aso688073485a.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 10:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772647437; x=1773252237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Pu2Xcak2dY0RHwZ0e8cqpDefL3wJvEKE5gvRk2RdGQ=;
        b=Wu0Xtm8ZDt44MnhTH5vt52kdnf4f9CQueFOBA4KCDgdPFLo6s8QAnQjPmMmMxvy4wX
         j77PbIsNjmU6Oz+1/YV3jbBEmra24AuK+z8BlSDZ0UgaH7iOuk3scJUEK5PGVZ7ZzhDX
         jm+zNPC7tZHPJfMZvXXAb5gBXFHaohUJZpPexzOi1vgIDcEinMv9xTdt3CN/9JvkvJb5
         aAVx60XKUWM6n7fJGsjvT86283O8q/RvzpMUKn255629OY4/OZK9osW7GE6gkKcKoMih
         tuK2VCFvmuG3Ai7a50cu5YnKmMWn/c/H39ZDuOoukcramzOr3balRltgkeSUCJ/Ez2vr
         3LjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772647437; x=1773252237;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Pu2Xcak2dY0RHwZ0e8cqpDefL3wJvEKE5gvRk2RdGQ=;
        b=NX9JzY9W4CR/Mx2v5CWKcLy18RM7etE6i6BN/+JnoWNEWN48Vvxz2hJW3PQHgfurjQ
         BGlBHva6fRtwU7f3ubAK0XSObBF5O2R30uCdbD/Rm2MgI5B1RDbyRyVN9v0iL+4EWSIo
         jbf8ZDRSNP3kg2kh3cGuB2LyuwBGw9WPVNNBFL06walw5dBVWmJGK8NwKmCykgf/sZ1C
         OClX9LTxxSxXxe77WgSwKOV2CsSFdM3mYQwCY4dzd//Fsn6h1U453tOLqW4LBuIIC2i9
         bf7RxpdmqKCKKhbULgNoazNltRvZbLz7oOjYamlOC8y6Xo8ec1A0ztNRhRc+Shn4cElE
         g93Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1iI4yP+fYwY2B7Wl+88/op9PXcecFkBvwkafVVBNK3m8bYIp4P8vo2R5w8EPpgkCnNDpVGLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQIX8XppotDAksjHOayG4urbDdBdoaQHPGUy0AQgYeMny70xid
	1U7F/+55YL6UM/I5SugOyGSca2oJ/EPxX1pJGnfNDakL2zDSdfuX0brz
X-Gm-Gg: ATEYQzwOCP/qMtY9aCCsgln3T0KCNMkXOinv/NMrMHhxmj0iOLvRZPakBDDYdVtaF5N
	7AHG62qdw5ffbe3djlq/yVThRH8FOAdeAacEfswyUQTkQ1L1kNCRoIu+B9CaZ4m3A2I8SSiOIL5
	K6irDYPGGvJrVgoPn14No2mno4Hxm5mUEQJlVH0sfs3guT0A6TbYdHzfr+v1qs6afeUEshK070o
	jkUHNHtYqvjT1+h/m2PZIgsGS2+b5lJLhn9/8JfrT06zCO3XuIFRIIanzQX+VqJX6Ztoleam2NQ
	MbXoobQUuf3yMiUw0a8qm/a04HaPSpJvy5OndDcJz+bHRlJTdvoHbvO/0ZpJduBNnEG8U5Dl15D
	2Jq+ZH/uLbaT6A0y0t0K+YYkFRTMeewvxKprPW5xQI2b/hiPFXh+6KLpr2N4M0CRrgvrZGUd3sQ
	MxpE/+YnDYb6o0mVb3sEdyPphtfxa0hsoV0WIKgumKZ/46lhtPo5Ex
X-Received: by 2002:a05:620a:31a4:b0:8c6:a539:55cd with SMTP id af79cd13be357-8cd5af818b8mr376591385a.41.1772647437304;
        Wed, 04 Mar 2026 10:03:57 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1145:4:d19b:d485:ed5f:e15b? ([2620:10d:c091:500::3418])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6f5c41sm1658775585a.24.2026.03.04.10.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 10:03:56 -0800 (PST)
Message-ID: <1d2b02b2-0541-4a17-af2a-95345395d2b6@gmail.com>
Date: Wed, 4 Mar 2026 13:03:55 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 5/9] psp: add unprivileged version of
 psp_device_get_locked
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Wei Wang <weibunny@meta.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>, David Wei <dw@davidwei.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20260304000050.3366381-1-weibunny@fb.com>
 <20260304000050.3366381-6-weibunny@fb.com>
 <willemdebruijn.kernel.2c99d96277de8@gmail.com>
 <SA1PR15MB5817C41068E5167A39F4CBD1BD7CA@SA1PR15MB5817.namprd15.prod.outlook.com>
 <94f9ac32-b476-40e5-bebc-37a954884396@gmail.com>
Content-Language: en-US
In-Reply-To: <94f9ac32-b476-40e5-bebc-37a954884396@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 20690205FA1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263982-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[meta.com,gmail.com,vger.kernel.org,kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/4/26 1:01 PM, Daniel Zahka wrote:
>
>
> On 3/4/26 12:42 PM, Wei Wang wrote:
>> _______________________________________
>> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
>> Sent: Wednesday, March 4, 2026 8:25 AM
>> To: Wei Wang; netdev@vger.kernel.org; kuba@kernel.org; 
>> daniel.zahka@gmail.com; Willem de Bruijn; David Wei; Andrew Lunn; 
>> David S. Miller; Eric Dumazet
>> Cc: Wei Wang
>> Subject: Re: [PATCH v2 net-next 5/9] psp: add unprivileged version of 
>> psp_device_get_locked
>>
>>> Can you give a concise reason for which operations to allow from
>>> another netns and which to deny. Also as forward looking heuristic for
>>> when new operations may be added.
>>>
>>> Btw minor typo in first sentence of next commit: associcate.
>> Thanks for the comment!
>> Yes. "unprivileged" means access from the main netns as well as any 
>> netns with an associated device and is used for commands like 
>> dev-dump, dev-get, rx-assoc, tx-assoc, which are user-controlled 
>> functionalities of the psd.
>> While "privileged" means access only from the main netns and is used 
>> for dev-add/delete/change-ntf, key-rotate. This is more like the 
>> admin-types of operations of the psd.
>> I will update the commit msg in the next version to make it more clear.
>
> I think Willem's question is more: what criteria did you use to decide 
> if each operation is privileged or not? I think one reasonable answer 
> would be: operations that have side effects on the psp dev's state, 
> e.g. key rotations or changing the enabled psp versions.

well, now that I sent that I realize that criteria is so broad to 
include things like rx-assoc and tx-assoc, which obviously need to be 
unprivileged :(

