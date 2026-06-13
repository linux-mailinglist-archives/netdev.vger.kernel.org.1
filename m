Return-Path: <netdev+bounces-298938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uMOBGN4lLWofcwQAu9opvQ
	(envelope-from <netdev+bounces-298938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:41:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB21767E430
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:41:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="dZ/k41Bt";
	dkim=pass header.d=redhat.com header.s=google header.b=hb9PJcCP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298938-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298938-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B81F4301388D
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 09:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4FA3B42D6;
	Sat, 13 Jun 2026 09:41:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7938B390606
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 09:41:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781343706; cv=none; b=hwZVaJvgtGeKTfsak1lb5ySPU4cJPnuHE0F2vyD6FwxRkmnkV6hfQBRwOctovruTUCxRPpDbulE5S5zLtTzTPucNY8r7S5QdD1hU5oVjT9NG6Ysas0grBCppUODYWEJ+TmoHyRgjqMwUPnsjt/DBR4K+WAiTySbmEfjs8CRWEKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781343706; c=relaxed/simple;
	bh=slkPTQP0GUAzugTi7HSwhXdUpK5pYAR+DDb+GFxuwxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rkhici77rprIHCk/MyAw7BRg6LvNWF6AYxgcidnxfC5Ldgaqq1suqNArzY+DCcWhFQss6DDkmV3/hU+G9Fi6txMhELnT6G6HuilzGBYmgCHe67SCzhLhZEPzAUq1vOU5j/mD4ezx3KyoNngidtwb4yn2mcZa5JtLDayPwUJUcCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dZ/k41Bt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hb9PJcCP; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781343702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1Muu3EVJ7pyT2NuvlAQQeuqH4o2Rs15B/UE1Gwhg5A=;
	b=dZ/k41BtFhHxPfn/kKzqriJTUKhpuhIoKBZpAchvNzw+gAho1v0rX5GQ2hU5JU+gQptKVq
	rP1pUJeO74IL6yRssZ5aDvDuSHS0nGmuB99ja/li3cCrD/Q3EcF8Q2NMbw6sCm2e7zNiSN
	8bw6IZWmX0H1OED+OKbJfoGVlxnNh48=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-plz1xdJMNsW7Obhk9XrMFg-1; Sat, 13 Jun 2026 05:41:41 -0400
X-MC-Unique: plz1xdJMNsW7Obhk9XrMFg-1
X-Mimecast-MFC-AGG-ID: plz1xdJMNsW7Obhk9XrMFg_1781343701
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5174a23afcbso20456431cf.3
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 02:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781343700; x=1781948500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K1Muu3EVJ7pyT2NuvlAQQeuqH4o2Rs15B/UE1Gwhg5A=;
        b=hb9PJcCPrwUlQrCoNS8pxg3wYbb+Vk+SfuwnXJFGF9K5iwIgeb0nNnD9wfzuPp1nZx
         CwZMLSxdnZg0+gB5x0YkOOJZ1LQF0QJh6WoB9iTEJb+UV2QbMruRelKOb/UuCMTmEsUM
         h2qUH4oAMtw4G14SfF7rbGftnu22DJVyIuiQlSqp8/FSppOOgK/56LvzuZccrFHIp0D8
         zCXUfzG2HVERdqptIw1QRf8bYAqSOXiCNtYJmafObGxktjR1D3k7PIlGJsS6DExtltX1
         kIHV22YgsobOwxdKEPtrVKPJznwMp8exSrKR4fvMi2flH7bnRzCjvouOOHSFibQrIa+P
         Pphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781343700; x=1781948500;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1Muu3EVJ7pyT2NuvlAQQeuqH4o2Rs15B/UE1Gwhg5A=;
        b=IzHGpQADDVGjKpZ11T0SAakKQJXNAp5rfM2kzo2gvhQgVhc8IQGoY/7z+B2VJo2+nN
         KrNPZa3hTsUBC4pKA0bRM7tc+O2g2MLjG+7ETwPFrZjgCEOt390nvYSURLrnsxQQzI2d
         SwINI0I7BNm0Beubojq86xXDd5ftUFWRPfuIlYzLLTkanqWLZWvhxTqRKX/nvD9xxW9x
         1SmtvRgtSO68gsTrat4SeC7BskiDUtUXxz+QNa7zE+4Km+AVjvZ3LEcB+g9dpJOApwJa
         SzDfXMi3SypyxP8YXnp41JZY1xds1nvVPwc6ez4Fhdd2m0bPa1vVTUR413EUzBICT5nP
         Kkww==
X-Forwarded-Encrypted: i=1; AFNElJ9gfEkCX18el4nWOtR7RphGKdIlXpK1F96aByYkSrsxtajrb1Sxpllc/WsH8SOOKn8pt4FhnvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPKNbgkIZ26RtNxymRllNXaZdszkYJEz21GBPZQhFRfzkhoY8X
	8fMWmuN7IaGnF+9GXx06YyXu6GPT+MiiGZOHpOfRP9LQwXapM6kwsZX6iBI/ObiqpuQF9DKkbkL
	aLljYkoR7vIYkOMqg+cwrire+b+oszHiVKBTLLhHyWYa+Rq5UmJeiGrAoyw==
X-Gm-Gg: Acq92OFAHDhwovt2CuT9zmVPb5s3qmBu2Lyl6Mcm08p+xjUPebeNYz5+Oqxcz3bkjE5
	EWEmpzhfVXjDXzUbRLxFqT+qCHkQRJu93JbUJaQVI2dgBgGEOlfrmLEpJQUxr0Tx9oEkwzBRNpK
	gi1OY/Z5U3hjh7AhYNMn2gO3XSZkVbDQMb3tzqfsCqLfFmN14V7awV+8S6gsr6gvrn4beuLOGR0
	iNMtqe3lywb+Y+HDIa6BTpJprDRALWiRkzg/WLrA9vl+ToTDmAczGrc63N+/a78EOpPxyWwAsOJ
	72o4os/e6AWE/3DUFCsap+zuPRWcNVLZcGpWK7KStFX71n3Z28IMOAeFw1iS3MSvzHS8yWGBB6r
	AUnDdl/krlUTm3mk0RsdRNf5bIbfFg1+DU7I5KzjCsh8hyewPS3Z7Sj8=
X-Received: by 2002:ac8:7d89:0:b0:517:7b37:1b81 with SMTP id d75a77b69052e-517fe60324fmr88759561cf.48.1781343700459;
        Sat, 13 Jun 2026 02:41:40 -0700 (PDT)
X-Received: by 2002:ac8:7d89:0:b0:517:7b37:1b81 with SMTP id d75a77b69052e-517fe60324fmr88759301cf.48.1781343699797;
        Sat, 13 Jun 2026 02:41:39 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.72])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d30570c305sm47232006d6.48.2026.06.13.02.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 02:41:39 -0700 (PDT)
Message-ID: <12adb61f-47d4-4199-af64-cc89c0602463@redhat.com>
Date: Sat, 13 Jun 2026 11:41:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 00/10] enic: SR-IOV V2 admin channel and MBOX
 protocol
To: Simon Horman <horms@kernel.org>, Satish Kharat <satishkh@cisco.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sesidhar Baddela <sebaddel@cisco.com>,
 Breno Leitao <leitao@debian.org>
References: <20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com>
 <20260612105224.GE625020@horms.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260612105224.GE625020@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298938-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:satishkh@cisco.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sebaddel@cisco.com,m:leitao@debian.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB21767E430

On 6/12/26 12:52 PM, Simon Horman wrote:
> On Tue, Jun 09, 2026 at 09:32:26AM -0700, Satish Kharat wrote:
>> This series adds the admin channel infrastructure and mailbox (MBOX)
>> protocol needed for V2 SR-IOV support in the enic driver.
>>
>> The V2 SR-IOV design uses a direct PF-VF communication channel built on
>> dedicated WQ/RQ/CQ hardware resources and an MSI-X interrupt.
>>
>> Firmware capability and admin channel infrastructure (patches 1-4):
>>   - Probe-time firmware feature check for V2 SR-IOV support
>>   - Admin channel open/close, RQ buffer management, CQ service
>>     with MSI-X interrupt and workqueue-based polling
>>
>> MBOX protocol and VF enable (patches 5-10):
>>   - MBOX message types, core send/receive, PF and VF handlers
>>   - V2 SR-IOV enable wiring with admin channel setup
>>   - V2 VF probe with admin channel and PF registration
>>
>> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> 
> Hi Satish,
> 
> There is AI-generated review of this patch-set available on both
> https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
> I would appreciate it if you could look over that with a view
> to addressing any issues that directly affect this patch.

At very least the scheduling while atomic issue in patch 9/10 reported
by both sashikos looks real and should be addressed.

/P


