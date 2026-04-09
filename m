Return-Path: <netdev+bounces-276853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF6rGN9M12lpMQgAu9opvQ
	(envelope-from <netdev+bounces-276853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 08:53:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FB73C6B5C
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 08:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3583D3008C06
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 06:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B7234BA5B;
	Thu,  9 Apr 2026 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0sVVUjI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BE134B662
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775717595; cv=none; b=qkgQgIVt0NGif0k4A0GClKBcwEXEJcKgYaHiRtqySM6Q2UpIYsmE8q2ThcIiAVf7gMLCghDx++FWWU2KxFkUoLmB3icqp7Af7TNuUAzYuVT4RB0xGvSv3ocirJYTbZqw8GnqiYfTVSrNyewbvI7dM20sc7Sx8UUHFieyALgRia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775717595; c=relaxed/simple;
	bh=X7q02TaveIgo8tUtf9tdeL+P/9/qUb/ts4JvovVQIc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dl4rgh4fevSuEUad1494xJU5sBAmHU6d4cMz4qDBATQLDZIniqyPi4yZWhUeDru4m+oC7tpJO/Vn7PIwq7xj/poZbzdNfp+d4yC4MgESrrV64pjupuwJN1YytnySrRfbnWh+uIX9LZpnx5SWi5ML2LiYsT8SgGNEeHSdlt4G5Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0sVVUjI; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b982b0889d8so68532966b.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 23:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775717593; x=1776322393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LEVLQCZHmh70OU78RKU7olNdbY2ojZc5P1foaiZqYkA=;
        b=T0sVVUjIpNdRsvK1FCheamFbddmm1Cs8RLNaCQAuCWkiAaWkE7LDSkaJW9CF+RvRdL
         dTOYgiaJ4FCWlWFDU0iGN70cCd9MB+Q12pQ3XDRVyEG5q2KlVg1dO3jsJ2oaZzmk3fYk
         CHKTXw8k91Vm0aM7tl1ZwrPQWv3BP1ZbDRwkFXKy+l3Mx65RjEJtMCHKJu94bx5kxL+t
         ZVX6snA95BioecPcwDLXWs7i0q/wkFFxA23g9lyuDAV2UIAdWdI0N6gReQU2gfiOMYbd
         ZUec2wNrrZVyPnF22fc8r31R0yd3nqPBSYt9u7NsEMxvUwDrzjA2S4y9pSq+try3hUP2
         R5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775717593; x=1776322393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LEVLQCZHmh70OU78RKU7olNdbY2ojZc5P1foaiZqYkA=;
        b=DDn3vUTu2skiR/SM1z4lonNtwdzgZhk/+3HlHaa7lsA014ycGffGGOZpOQ0Ex0UEKw
         egMGpD1jQR31ZRwqSW1VadIHZzYNACleO3uW96TAcDae8Zpzb99CsQgQdc1q5srn95ct
         4IeyuRulBzv8+5jnIo6M+BM31ln5fMbv6XJt8meEM9HezbMsgy+f0g9pOgIMJ5hUXd5I
         UwEPQhUNTJSMpKyWANemvzG8VubgNLPWvolh4yEMXBlEHYZ61/RytMcK86qdnIlGy4E5
         SJdJE4uM0i9p+bfTF3oaSV0S8qw5j1+zmr26RCjf/h//74179j4jgM34Gloczt6VEYOA
         G+vQ==
X-Gm-Message-State: AOJu0YzCzm9UyG0HApQkEZekVJZGoFp6Gzi0wCyXQ0RVyKy12UX+ys+/
	hLSURra22ed3b1imZsvZ7KXKAgIfz4UjEygPPlLOqnJdo4BPosbTFqNO
X-Gm-Gg: AeBDievsF9+101VDo0BXwmELDAm6TShkL2S8g1wzv4IVuV2+l53heU4Dbg+4gsDjnco
	SaTXFkznxUe/o3FryYfaycc2LkQukm0p3bpm98Mbd2dEHJRARtYan67pj5XDRw4PfJBmA6uwXhZ
	jLa917vnvScs93QQm3Tm7zeZZTPut6mVRJbl6qCy6CVaGuqr1fSZn0fSt1wFrvBeYvQXCI35VHd
	m3YrzxOe3NWw6mMprwvTxKC2XyIOjc0VoduLAXmX1yXGK7QqUjgXeOxuaJNwgnzNMPejiACB6bi
	+d6bbQ8FfXoo3fAmwxEGO7UCyT1HVcobtdc/3PlNEzRhyXCnLkPkDf9HaboE7s650vc2Z37ZemT
	qQuBtZowaS0a6ZOkxkdk+8Q8NVJtBwtrWiyLnSastiO7cblhXF0GbJ2ec9Nr1iNRNOe+dExkDEV
	umu78+8dO/MwRYqSntkgDEYx7pQbav/PvKULaSrdnHx9BiLehCc0zNrjMmZoRhM7gF7BgA4FNyj
	YTTtTs1+MvR
X-Received: by 2002:a17:907:94c1:b0:b9c:cc42:9c73 with SMTP id a640c23a62f3a-b9ccc429ebamr762990866b.30.1775717592269;
        Wed, 08 Apr 2026 23:53:12 -0700 (PDT)
Received: from [192.168.0.2] (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c97218esm707340366b.9.2026.04.08.23.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 23:53:11 -0700 (PDT)
Message-ID: <6631e1e7-8728-46a4-9999-ea9910a1abfb@gmail.com>
Date: Thu, 9 Apr 2026 08:53:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 0/5] bonding: 3ad: fix carrier state with no valid
 slaves
To: Jakub Kicinski <kuba@kernel.org>,
 Louis Scalbert <louis.scalbert@6wind.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, jv@jvosburgh.net,
 edumazet@google.com, pabeni@redhat.com, fbl@redhat.com, andy@greyhouse.net,
 shemminger@vyatta.com, maheshb@google.com
References: <20260408152353.276204-1-louis.scalbert@6wind.com>
 <20260408201341.68f31247@kernel.org>
Content-Language: en-US
From: Jonas Gorski <jonas.gorski@gmail.com>
In-Reply-To: <20260408201341.68f31247@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276853-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonasgorski@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07FB73C6B5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 09/04/2026 05:13, Jakub Kicinski wrote:
> On Wed,  8 Apr 2026 17:23:48 +0200 Louis Scalbert wrote:
>> The current behavior is not compliant with the LACP standard. This
>> patchset introduces a working behavior that is not strictly
>> standard-compliant either, but is widely adopted across the industry.
>> It consists of bringing the bonding master interface down to signal to
>> upper-layer processes that it is not usable.
> 
> Is the only problem the compliance? If so I don't think this qualifies
> as a fix. Please drop the Fixes tags and repost for net-next. Please
> keep in mind the 24h reposting period (also I need some time tomorrow
> to queue your patch to the CI so that the selftest passes when v4 is
> posted :()

Signalling link up too early can cause issues for some protocols that
may change behavior in the absence of PDUs from a link partner.

E.g. AFAIU RSTP may decide the bond is an edge port because no RSTP
BPDUs received and put the bond in forwarding, which then temporarily
creates a loop once the bond actually starts forwarding packets (until
it receives the next RSTP BPDU, which may take up to two seconds).

Best regards,
Jonas

