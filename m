Return-Path: <netdev+bounces-289432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLmLCaVPDGrwegUAu9opvQ
	(envelope-from <netdev+bounces-289432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:55:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C04C57E1EB
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5DBE3074BD8
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4E9335BDB;
	Tue, 19 May 2026 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUJjFg8W";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGlowHMk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDAE334C0D
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191432; cv=none; b=lJA+S5w6nDtdaHQFVP3Sme1WO+5a5N4RxEVE31J06YLGaUjspk7QMpHgy5Xzg96rpUe+rEdZUG/l4NsRalj0CvnT3atnLXA+xspx0okyj/xeb9fC6tFIDPgj6UGzi/s+hoQi4l25EK0bYtpeHKf6Z8tV/A/bbmVpYyQ8tVgjWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191432; c=relaxed/simple;
	bh=OyQsX7idgcssptZstX5vigLcVRwLwRvmK9vB4BIKGSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlwcFV66tQl9ooHhkPOjHJ7pNL1DNyPSZXUHucdq8dS8p4415gXtqHSbm/Bok56/cNQHCSDB42nJA1612Sm8qGRBYVhQ1kK/Ys+pDHdTUTAJ5Y99CrkqPpyuzpITiUvUfsmHknCoewF0/+6Wws3PRVJFb8z6X5/3jvxmU4o4Y2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MUJjFg8W; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGlowHMk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779191430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68OnP1gNsBAUMWfzpESCPcyej0kcUsoOiuP1lXrMSLc=;
	b=MUJjFg8W5JSJaOnyjC86PxJ5AKUKWB27ZkiFTd6izkXPYKtctwQaFDhmkzfOjMdko6tX5x
	n41amXiAcwBoNkGb387jisDOkuOJ+5WKAPMlmqDOVEZ92O9+dTa142oYR758EVOu4Nej8g
	7LPrEE7UFJS715lhcDr+BuaIA8UzXgY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-8v9lCWmCOPa9ZVcEpD842g-1; Tue, 19 May 2026 07:50:27 -0400
X-MC-Unique: 8v9lCWmCOPa9ZVcEpD842g-1
X-Mimecast-MFC-AGG-ID: 8v9lCWmCOPa9ZVcEpD842g_1779191426
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45e55c44ac1so2800729f8f.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779191426; x=1779796226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68OnP1gNsBAUMWfzpESCPcyej0kcUsoOiuP1lXrMSLc=;
        b=CGlowHMkrDqnYZVtzqh5YmcKyeF60j6zCXQ04TtzzlTDmsjtjbJE4Y/twakWRsp3Ss
         MNaQSr2gQk95xWnECW5txxQ33wrquCfKXBttuBAcrLUcU7bGjWa0nBReF+e9NUu0IFMy
         YtgSn7xxtDvNwhAmQhEhPqSK/0FASz5Q8hQCY3+7u0FqgXQsqpz/tpl7agsZJwQ5DXMd
         FHBuErzWt3t2h7jX+66/n6/6tneHJjsqli1quoZfYyMkwGtXwJXlkQ34IQmaE7RakdVE
         lL5xdmM8Orl8cNolLKG2wF5ouTaw1z+9c3QwJXG+OWaQd3JQmSjlqVWoEkNZ5wdYJJw4
         2Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779191426; x=1779796226;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68OnP1gNsBAUMWfzpESCPcyej0kcUsoOiuP1lXrMSLc=;
        b=si0FfKVZ6EHH3IPXgJhgvX6MasitfIXfvetZiLgw2A/pUd4fGwrOI7byHCSYj8m4ww
         FklMQbqxOzQsmxyz229+No6T+EpI09bW+qaBHBEspfqNMGAAvZE/vfRgQuYXxxGK45OG
         KX5qZbB2HwxPQR7n+HgNWJw2rQWlza1a1VRSdhWDse4p84+j3/7RA60OL23v6MvZ99pH
         gyLpFYWw8/RFalnAbVePT1iUNQjDKuvfB4RApaKSmf4wciGW37m//SpEKzv1AdcmSfzn
         7dJFtN1BbyIQKJGavURzQ8hM3VOxFav5q6QEMhbvdDWH/j4WE/nWbVCWtLw6KWgokn0R
         0o5A==
X-Forwarded-Encrypted: i=1; AFNElJ8QPeCm7w53Y9AMtfqgVEVEbROQfwYJ1ndYMmQSTTi3a/MVNiQrn0plF3i48HS5XbqEXx2W0II=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUbo1YG+Y7/v7xNOYY7pfUlpGdjYE+NTymi7pLi/yG8GIuEs1v
	wVdgnojySIGVqBisb71bTAgHA0XLiLB6MIjmRZGzIKqsB8kutIM/8GUX1gFDyX7d85rKZiwgq3p
	PGaoYyODJIi26+f6qZ7w3c/RM7ZJQX8I//YgnqM1gAxv5WqE1ZLeSZmCx6Q==
X-Gm-Gg: Acq92OEnfWukVqm7RtMbRVK63Y3uAyL8cCLBQgDUNPQGNJ9eU3BnX2DC+mUsRmeFWp0
	WQX29H4ujKlqUvtsIBgQ/ZrawvCSfQhXFSkVn8E72W7PuxeHKEUHYAdQB9ITj7pkKkXbKmbxGSS
	8QJ3BnnNUeHdY38kAphp4IFo2gX2dbCqBAFLmo4ztCHGFKqN9zcCZ8vyDTr4qIs+tJSiyeNK28g
	kScGH4tflyTgbrcwqyXwlJCz6CnMdNB3Dd+EJqd5+/3iJxVsnH5WYsA9gbsAUKm02DVHhQvksDs
	H6elQOW+lM20lIMwVpWEd9CYiMl+R5ywhvALOplmfg+9YvmtlzgfsjRgJwAfiJsDFaUET0UWsXU
	KoqPUewD+6wM8Ze8gL60yxTP485B5pnZqE+PuD1d5OvNV72a/Ym9GhOE+D+ZXs/BhAw==
X-Received: by 2002:a05:600c:4e46:b0:48f:e230:8cab with SMTP id 5b1f17b1804b1-48fe6626cfbmr300401605e9.31.1779191425784;
        Tue, 19 May 2026 04:50:25 -0700 (PDT)
X-Received: by 2002:a05:600c:4e46:b0:48f:e230:8cab with SMTP id 5b1f17b1804b1-48fe6626cfbmr300401245e9.31.1779191425353;
        Tue, 19 May 2026 04:50:25 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5e9d5d9sm376170905e9.15.2026.05.19.04.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 04:50:24 -0700 (PDT)
Message-ID: <98bf6672-334a-40df-a21d-c53fac584314@redhat.com>
Date: Tue, 19 May 2026 13:50:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/5] pull request: fixes for ovpn 2026-05-14
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Ralf Lici <ralf@mandelbit.com>
References: <20260514231544.795993-1-antonio@openvpn.net>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260514231544.795993-1-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289432-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6C04C57E1EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/15/26 1:15 AM, Antonio Quartulli wrote:
> Hello netdev team,
> 
> This batch includes a few fixes for net. Specifically:
> 
> Patch 1 fixes the remaining of the selftests in order to avoid
> TCP failures on slow kernels, where pings cannot be always
> delivered on time.
> 
> Patch 2 fixes a RCU deref outside of the RCU read critical area.
> 
> Patch 3 fixes a potential UAF in case of a TCP peer that fails
> to be added to the hash table, while being fully initialized.
> In this scenario, potentially ongoing TCP socket syscalls would
> attempt accessing a free'd peer.
> 
> Patch 4 fixes a race condition betwen interface teardown and a
> new peer being added via netlink. The race condition would lead
> to the "ghost peer" endlessly holding the netdev while the core
> is waiting for it to be released.
> 
> Patch 5 fixes dev dstats updates by ensuring they are always
> performed with BH disabled, to avoid concurrent updates on the
> same CPU.
> 
> Please pull or let me know of any issue.

LGTM, but sashiko idendified a number of pre-existing issue that could
deserve some follow-up:

https://sashiko.dev/#/patchset/20260514231544.795993-1-antonio%40openvpn.net

/P


