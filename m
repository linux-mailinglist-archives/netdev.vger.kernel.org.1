Return-Path: <netdev+bounces-283423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CElLE/8K9mmKRwIAu9opvQ
	(envelope-from <netdev+bounces-283423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 16:32:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBDA4B280A
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 16:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9D4E300B058
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 14:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9017126C39E;
	Sat,  2 May 2026 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSqXWXEh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342282AF00
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777732347; cv=none; b=RH6uOrgGQ5qnoG4+IbiQf9YScrKpucMLEu/5LkcfFDE9aOvoNcneScgKzAwdMTGLp8OE9oM148aiewYu6jyQvk3Wr1H9hvsYr4jGMb+GbDWaSM0IilzrhwjAZ0hIrwIFKyfhVpRErs09t02x5pEhDM7N6YN1W1k9/Xx/oVaZPeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777732347; c=relaxed/simple;
	bh=N/XPMInqv5OZa0Fvk2VTuDxWNnjkJZaKdeU93sEOsAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eETbVlqcbJ81GjJCVSEnyVsJeMpDyq/O1LJxsfk4zA10O8x2tRJRVy8VTVhzOwWgWi48hLucwQ+h82S1y61tG5ueUELD8XfqnGEQhRBH5tTR+vcDOB0haba54yOC6Q1fHs5d6DQ+TQL0Rqh4OLww/tE81wX//ZozZXS9pHwjlyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSqXWXEh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9c01854477so393949066b.0
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 07:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777732345; x=1778337145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNukY4PmeCg7FKGx81K7eNPEaOWs4PcoTd8UP3BQrGc=;
        b=lSqXWXEh/oxOO38WZb03jhT8SzBlaDVYlrWJFv0T1vsOCRMEUSifXNem1TkVmseM0o
         amy0R9dB3IM7TMAu5nbQU4ZH7nUs4I8P1FFQ6Ij0Ffbzt4PF4g8HPK949wS7Sc/UuQZl
         uANw3NeBIxLBnhTFI64zfXzZOpuXtsWFqrCk/W8vzP9FqIbm9wW1uIcQaKVFhhB6H7ap
         Jdjr8qONgWLfVBlWqOqqLxbgAedozRcOhRaqWEJRRl7pcnD6vQ1Lh/+hXYNXL8ZieHbE
         ynwr7uEulSnMQnhYVjX3RKrvsAFQ5D3TiNOpcUehaylRCUETwRrhLtJ+2ZVuh+75q1si
         5gHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777732345; x=1778337145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNukY4PmeCg7FKGx81K7eNPEaOWs4PcoTd8UP3BQrGc=;
        b=tMbPSM5lOJudp73fqkb/RK9+vngiBFnXsvWWjylZaO3R26hHz3z00+k8UpRBwcEX53
         em1ESqhyRwB9wpWKoe6aHxL4U2yWw7esKz12rlc6dPCfnCkJda9KmJwGx1kMbrAuiAqq
         pscMo1UKSKE3Zll3rXyI71FSfgNNV8gVsSmEhIPK4MtOGQeqo0o/Rvz473jtZvYpddl2
         Pm/50qzWqw2aJyWlOmlkRVEU6EyPmJuw2i2RQZ9qKhBKgpTd/sXe1pQUkIu5FrG7P/Nx
         08lBmkZwoT/UBSEW4Kzv12aw5+N5NwEV7n9nRioLdDjhUHMuyeuZtfRMz5QWlPJE7/AO
         1w7w==
X-Forwarded-Encrypted: i=1; AFNElJ+FAyAfjHhAYZbNgKGcjJihsLrOMq9v6sN24D9njVZlwMKw4C5yt0sHewvqhlgHR/0xbcFfQ4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFCkjrJuk6EeVKfym6l+XjRyMhr1HY+hfkMyv2AAMPeITfYGbh
	5JROv/emTb/xl+rZe+BNhFNbRLktYwtjlg12lVLG0obHVGTpTQ9sZjz1
X-Gm-Gg: AeBDiesh4N8s9qiZS58JZh+b1/jmCz8isVl0mB2N3k7VOrj/04JIwbXX67styDmb3Ri
	tczp5do5CYUFvVy3IDCTojo1Fjy32xkxiZRXZSHbad7NHzuHKSB1xdpWlRO6R78pxet9TjciRTe
	sDzwGay7N7Kg7ShbWDdopsl/vpacawth630+jP22JqkHrxUncflXH9uyTsYRC+kj7M7yT672riO
	Q14RiZ/uDNr1r87ElwvqS7QPDJGXjBckBpkqf9KGkfsygy/3+JnTluvGP/9YQ4SuuQtqqkAmX7s
	sZeQXDq3VP+FFvD1Iu7d8GJ02c9CUSZ1qCU30SijFD1nWMH3dn8XsMHpT/a8WtVF7WayLE5WIKL
	HKJ0j3AzuRljOgZfx2BeUdJcZXNOUR1B8OtFHUHncw9sB7slCuzMT5J2WNqIdcKU1XiTgRN1Bk4
	pef90G5GFDQ/IFl2gsEIW2VuLxg9q/cyTgf2+RBLLktDbQe1SxuyYTtTPnkx0cQnwWHVY1NxrD6
	xnb2pQ4zF6heOa86iTuhENyOMF+Uq38RjoCriZ9J8+CWbxBh4ffsyvPY+ihXvX0X8C0nwu5IKh4
	vVewtm4I
X-Received: by 2002:a17:907:c02:b0:ba4:8288:b464 with SMTP id a640c23a62f3a-bbffab330eamr157929066b.6.1777732344365;
        Sat, 02 May 2026 07:32:24 -0700 (PDT)
Received: from [192.168.0.2] (dslb-002-205-016-203.002.205.pools.vodafone-ip.de. [2.205.16.203])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b85e292adsm1732314a12.6.2026.05.02.07.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2026 07:32:23 -0700 (PDT)
Message-ID: <e3d96025-550b-4268-8e13-ec45d25b0f31@gmail.com>
Date: Sat, 2 May 2026 16:32:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: switchdev: fix duplicate word in documentation
To: Andrew Lunn <andrew@lunn.ch>, =?UTF-8?Q?Bj=C3=B6rn_Persson?=
 <Bjorn@xn--rombobjrn-67a.se>
Cc: Wang Zihan <jiyu03@qq.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, kuba@kernel.org
References: <tencent_93F8CA2FB714A80C571AC978F39E51D6E506@qq.com>
 <20260502132446.5b2c51cf@tag.xn--rombobjrn-67a.se>
 <a5482c59-2a35-44ce-b112-9c07e8ca7892@lunn.ch>
Content-Language: en-US
From: Jonas Gorski <jonas.gorski@gmail.com>
In-Reply-To: <a5482c59-2a35-44ce-b112-9c07e8ca7892@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9EBDA4B280A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[qq.com,vger.kernel.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-283423-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonasgorski@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 02/05/2026 16:09, Andrew Lunn wrote:
> On Sat, May 02, 2026 at 01:24:46PM +0200, Björn Persson wrote:
>> Wang Zihan wrote:
>>> @@ -162,7 +162,7 @@ The switchdev driver can know a particular port's position in the topology by
>>>  monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved into a
>>>  bond will see its upper master change.  If that bond is moved into a bridge,
>>>  the bond's upper master will change.  And so on.  The driver will track such
>>> -movements to know what position a port is in in the overall topology by
>>> +movements to know what position a port is in the overall topology by
>>>  registering for netdevice events and acting on NETDEV_CHANGEUPPER.
>>>  
>>>  L2 Forwarding Offload
>>
>> This change claims that a port is a position. The preceding sentences,
>> talking about "a particular port's position" and a port being moved,
>> make it clear that a port is *in* a position *in* the topology. The
>> port is not itself a position.
> 
> I assume this is a fix to make a bot happy, without actually checking
> if the bot is correct.
> 
> Maybe to prevent a recurrence of the bot driver not validating the bot
> output, a ',' should be added?

I'm not a native speaker, but I think moving the first "in" would also
work:

"... to know in what position a port is in the overall topology ..."

Best regards,
Jonas

