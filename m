Return-Path: <netdev+bounces-263981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OPBNGt3qGnpugAAu9opvQ
	(envelope-from <netdev+bounces-263981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:18:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C76C206269
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DC1731DCEA6
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 18:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26C63D5221;
	Wed,  4 Mar 2026 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USnvi9S6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F9C3D4127
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647285; cv=none; b=sSq0bqEFqZYcjvOY7eBBw6ko3brydL3jkPqHeg7DYLcRtD6bI562++fD86R20ttJjx9TlKe7Z7qDTREpM31sAKdN2/u6t28d6ZIm2grNYOsNabTsCmWeR5zBQ9O3ltRZLEZn4u4pBQz9xDT/3E0EteGOC/7jB7A384KPzsZZVDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647285; c=relaxed/simple;
	bh=Ou6L0pMl9jYIR60KLII5nv/F3ChEh3DbCIgzewtEwTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ALVqOrVbUgTGOAmWNE+KsAEnAYTKwVZKQj5cTN1na1b15XvswKVSZvh1GE9mKB7VsvUxVZEvroQhn9ygkhZQmFnaXoOGT5eUzDcVZxdErr1VSQEIymFR3hzbJcJ76D5wz0ZDHjfspiOVYQvXgIwkspDU6DqkGenzofUbW9HJA74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USnvi9S6; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-899fa9610bbso56688876d6.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 10:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772647283; x=1773252083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AJU/rVsBQexajS4q3Y9/JWE6ZYsUQ0Dpsl2G/U6kYnw=;
        b=USnvi9S6ZAZoiwqRrKv3+kjiF3nK/3objk9RMO0I5XjVKMnjp9ColCEuvz4mazgWzj
         tYdMnFlvAs10ENeyfCaxHyr2Dl7HbHtEBjetmi4S1FvskVjjdCF3YpHb9s1vD4x8NNwD
         BpbXlxfmYjudcaByt+0mhKbkzdvoZd0Cd5nxLua5RfpLnWmKK7tcUIqJ7nyVOybSuan9
         Y+LoCybnRcPsK/aXP5xIE2MEVLTYPk+PtSUj+VMLqOaCj4DVi9R1Wb4BWgLDFKkQBzlp
         2lxVQR63+9mgBkpZhcjkcGCZUkQON09e+0TfqxFaxzko6TOyfv0pQc5MZwHIdrnp/B0j
         RwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772647283; x=1773252083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJU/rVsBQexajS4q3Y9/JWE6ZYsUQ0Dpsl2G/U6kYnw=;
        b=URRnOmcAvFrpPz2zYwdtaL83JD8bgj4R3+G5Cqf8isofprp1Tw1DZtHy5ixjRH4ykn
         ZP4Wgz31NkR6qVfCmD8XJgZQjSMikxz6evgxAT9BTAOlm4Oe9TACVLaj3d8HBLEjYRME
         w5tLjqmTstrHlSlXUA0K9FdHB28ffviHkWBuHY6iRZH70mQnXORRJeGqsx3wBM7ZKcks
         +kkCpje05koqQXzFqxvIrxjN50SR1ZvOBOC6OUqaLADDbITCtV/7aQv+s3loNaJZwGmF
         MwpSoI9ng5QXBzng0qcj3FbbFlbHEJoGhYSvRiZ33nWihnjhBgmcK347Oy4nHlaKv3R4
         lxeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDvDTVHNvmRKU8g0r8osFazk56lLTyNnbta6YLhF2XJqdsdoHZYdOhFu+if5fkXk0t4dnTHVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywir6zaDyw5QSkfg6VDsV1AIqpjP+uzJdyDltZWEYUqtN4JPrCu
	um4H94CgvcV1nXARyxKwxDafHevnMDzK5h8gmPqqbSBXDvZLEYMn8FNb
X-Gm-Gg: ATEYQzw9zTKj5VvMMrgmuYrSVQzYisREmrWPYxq2dsZPIySk+kSdlsI5llH9ay4HF7z
	PfJqnNnWsKJh+Xr58/0eGj+iIRnMJJg2zcluBfHQcwIp9RUgbojcMHw1DqUp6LAJ55Z4y/zUxhm
	/CLm+TgDbhfIGJ5OuYgu7DwGaMKv416GitGRgMvJMwz75yYraVVxxH+rteIyOUTE8ptkQSvBaMc
	ry9hTzZ+pMoFk0bMMV86FdyP/yjFqMVR9Hb1iktqAPZaRmHRec4ui1PV+tiNvw7Zj7VLmykDKal
	kqHh5tvdShpetkoI6z2N3TbjSG8dLGtdD9cpOAbFh4ZQchlD2eSbC9mix4UsChZWDzfh73KtRpt
	ihSJOvrBa/GCqL0w8hCxMmff/afDIV3icVX0eZS4yxLEIyk4B9ndI3/uwrX8l9jCZh+ofLzvbPd
	57dZvaA/qvgE2C9/72/9ClI8gpv5EKEK3yZR7yTQr3KG8BgNbPzGwY
X-Received: by 2002:a05:6214:3004:b0:89a:216:6c45 with SMTP id 6a1803df08f44-89a19d22e0fmr38647836d6.62.1772647283290;
        Wed, 04 Mar 2026 10:01:23 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1145:4:d19b:d485:ed5f:e15b? ([2620:10d:c091:500::3418])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50751256df4sm132967631cf.16.2026.03.04.10.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 10:01:22 -0800 (PST)
Message-ID: <94f9ac32-b476-40e5-bebc-37a954884396@gmail.com>
Date: Wed, 4 Mar 2026 13:01:20 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 5/9] psp: add unprivileged version of
 psp_device_get_locked
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
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <SA1PR15MB5817C41068E5167A39F4CBD1BD7CA@SA1PR15MB5817.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5C76C206269
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263981-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[meta.com,gmail.com,vger.kernel.org,kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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



On 3/4/26 12:42 PM, Wei Wang wrote:
> _______________________________________
> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Sent: Wednesday, March 4, 2026 8:25 AM
> To: Wei Wang; netdev@vger.kernel.org; kuba@kernel.org; daniel.zahka@gmail.com; Willem de Bruijn; David Wei; Andrew Lunn; David S. Miller; Eric Dumazet
> Cc: Wei Wang
> Subject: Re: [PATCH v2 net-next 5/9] psp: add unprivileged version of psp_device_get_locked
>
>> Can you give a concise reason for which operations to allow from
>> another netns and which to deny. Also as forward looking heuristic for
>> when new operations may be added.
>>
>> Btw minor typo in first sentence of next commit: associcate.
> Thanks for the comment!
> Yes. "unprivileged" means access from the main netns as well as any netns with an associated device and is used for commands like dev-dump, dev-get, rx-assoc, tx-assoc, which are user-controlled functionalities of the psd.
> While "privileged" means access only from the main netns and is used for dev-add/delete/change-ntf, key-rotate. This is more like the admin-types of operations of the psd.
> I will update the commit msg in the next version to make it more clear.

I think Willem's question is more: what criteria did you use to decide 
if each operation is privileged or not? I think one reasonable answer 
would be: operations that have side effects on the psp dev's state, e.g. 
key rotations or changing the enabled psp versions.

