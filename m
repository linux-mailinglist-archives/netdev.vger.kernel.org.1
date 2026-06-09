Return-Path: <netdev+bounces-297007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zgf5BwvrJ2rq4wIAu9opvQ
	(envelope-from <netdev+bounces-297007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 12:29:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A1C65EE8E
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 12:29:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=TcKg+O8S;
	dkim=pass header.d=redhat.com header.s=google header.b="R/5OQ6BI";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297007-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297007-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23CF5308FD88
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 10:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847A73F484D;
	Tue,  9 Jun 2026 10:23:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F5A3F39F9
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 10:23:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000632; cv=none; b=hKgfGutgHOSzUL7NXz5ZKTgbVaoAP1uH1f3YOl01/pTCHsfJnQEETab4OeCUCTU6vgmk50Oubuo/vWu+fpCsqiwDBLHTLB8aMXBiYeF2KjAc5LaRBkz4S8R08je3OMMCnXVrV3MI9POQ8QcE2wKfMYd3P6V1J6So7N6by59liWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000632; c=relaxed/simple;
	bh=DsAPMvK1q5MvOezA4jpsh8gZnYxwxhG9chRJt8+cysU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SrEq2Br8o6SRQmRkHXKrToYV2azKUBJpjXYpR+M48/51D0VeoSnOQgevGKlLYzaEGyLK1vADqKsdFctUu0cy2Z9zQhXWb3G4OFgAm/5SBbNmMB35hG7pCzF0sVm3oc2ZTSg9F1JOa14/8Ii17xjXTNMQWpxlrHwjARAQKmBWMj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TcKg+O8S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/5OQ6BI; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781000630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cXZk4k2k6EZBTKlJ5PyGn/p9m59BVNFUwlqXim4fTfo=;
	b=TcKg+O8STSW7ASJqO9Vann0wUHd2ihWY+cRBEEkyJbJvHHzXxLS42Wkl2juC/JOEqbqTnw
	6kecM9lB+bA7jtiDaIJfLIIIA68Ssu3lm/9PiMfKyXGceccLH1iwq/kZ+af1qF2JxSHPmg
	bw2ajJk4WMLsJDz+bahVBRjdM3vmJ7c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-iqMl8zp0PlSkRR1w3eMb5w-1; Tue, 09 Jun 2026 06:23:48 -0400
X-MC-Unique: iqMl8zp0PlSkRR1w3eMb5w-1
X-Mimecast-MFC-AGG-ID: iqMl8zp0PlSkRR1w3eMb5w_1781000628
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45f3d008865so3753001f8f.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 03:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781000627; x=1781605427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cXZk4k2k6EZBTKlJ5PyGn/p9m59BVNFUwlqXim4fTfo=;
        b=R/5OQ6BI6f+cVVVgVAmkpxXl4zXWChy/CbDurfZ2UmvIixdqsGGiFjDOExf25UhdEZ
         VuQxUJX3rsWJkHrIX8T6+rzjEueymho4d16nVqBYZUlPOEBsXp0lH0eCj7h15ouGukxD
         4bpJLMLMwkW/z+jyGoVlhvNs8ZKv/dtNXtQGe8hFw2ft6FlJgR8+XNNhMJWlt/2XJ3N9
         7o+YL1RP/QJqTVSWOQpn2I2BQP8Vv+EQq9qs4BCViy8oxnvj5oHltRi4ElTlZbp1AIY8
         ujxy0wXtju67BX3k9cIdtZq0ga/MmgX1qGYy/23Ar7xDHDNhpoompAl8BrSjt4ylbbT7
         R46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781000627; x=1781605427;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXZk4k2k6EZBTKlJ5PyGn/p9m59BVNFUwlqXim4fTfo=;
        b=dNdKnHFDcDrP1sJXdtwG2E096qIfcE874p5G5FGrjg79VO9kXyXnBJ5mYBlilzOAcK
         UkdWa+v1GZmm2hVZ3FNFKW29/wP7ENCtQzA+ckib4tBg4cKrl+/wdo1lIojfs7NAqfQ+
         MNlm8cReoZGO+u3kHr+89bDULc4Bm856jTtIS/c8G9xv7P34i8Nz5O2a6Byyzs9yvQ3c
         qDvU4HA7oMSB06W4vNTSVjkk6ZEAYFcY55pxHGrAyY5HMoyF1EcIyV0GMada+vLdSUlL
         IE54xoDwSQNCd+/B5hCyO4MtkOB2z79yvVI5Lh1HI2zrIM7Q9QH/nE7uv9xKsD8K0K0/
         01BQ==
X-Gm-Message-State: AOJu0YzHJ/dzsquuXEAy4L8ZfDlOTWqYyYXxYPbUI63T41a0MntuDp5y
	SJ0qvDriBtCg3NEH2HoHKhdrEGus/YgQDbBmKGkssqvO8TkCs4AYDph7Q3Tis0XMHpG4r0DMYQC
	x8ZgRUJiMZckPrIlr7M1MHXW4s+vNog8E7cZk72Rc5i3B7T7chf3vV/UWxw==
X-Gm-Gg: Acq92OGfTN631ZPjVCnwOwE8mypKjiEZEZC6Iqtb11GIbZj8f646TG6u4FxP2EJtybF
	8E3kYCCDCqWgNz6PtxXu4gIxsyiCFX5sFbVdlffMx7+PDLfYXu0z14SMi7rPtuEjJS0HhH3RA8B
	M/7Y7PYkoGsemGlcoDwGa6Eb/Vod6/3mHJ2mW3yFyUwEHGZPcnNbOF7RTiwWEXF4fXdyJSncQfY
	ICLe5YYsIHE7XI4GEsccd/fMWZhuIXo9RM2BjWZ4MLUOVTdgGn1H1aRPbdXG+nfpzSnEJB2ELaI
	lKFL/YYWvBBwKLQRSKj0AT5+b01HFnky0ryqJTlFbkzV1A0sbce735xCM/A4F759CzRHiNh/Njl
	spjGNi6wFczhIFSzN7YwsAdfvJecC6aeSNnzU/FiFizQIn4lSs0apfyVYwev9ZvuqNQ==
X-Received: by 2002:a05:6000:1aca:b0:460:15b7:769b with SMTP id ffacd0b85a97d-46032810ce6mr24624562f8f.0.1781000627603;
        Tue, 09 Jun 2026 03:23:47 -0700 (PDT)
X-Received: by 2002:a05:6000:1aca:b0:460:15b7:769b with SMTP id ffacd0b85a97d-46032810ce6mr24624531f8f.0.1781000627257;
        Tue, 09 Jun 2026 03:23:47 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f67c6sm58456915f8f.16.2026.06.09.03.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 03:23:46 -0700 (PDT)
Message-ID: <3ff13fcb-1587-43d2-b749-ef8ec14d5ba5@redhat.com>
Date: Tue, 9 Jun 2026 12:23:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: drv-net: gro: signal over-coalescing
 more reliably
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, shuah@kernel.org, willemb@google.com,
 linux-kselftest@vger.kernel.org
References: <20260607002401.212976-1-kuba@kernel.org>
 <20260608195320.007b34ad@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260608195320.007b34ad@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297007-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shuah@kernel.org,m:willemb@google.com,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2A1C65EE8E

On 6/9/26 4:53 AM, Jakub Kicinski wrote:
> On Sat,  6 Jun 2026 17:24:01 -0700 Jakub Kicinski wrote:
>> +	/* Signal over-coalescing explicitly, it's a hard failure, unlike
>> +	 * under-coalescing which could be timing- or loss-related.
>> +	 */
>> +	if (num_pkt < correct_num_pkts && bytes_received == bytes_expected)
>> +		error(EXIT_OVER_COALESCE, 0,
>> +		      "over-coalesced: got %d pkts vs expected %d (%d B)",
>> +		      num_pkt, correct_num_pkts, bytes_received);
> 
> Sashiko complains that this condition may mis-fire if we lose a zero-len
> RST or ACK. This is true, tho, if the device drops pure acks ignoring
> failures where ack disappeared puts us back at risk of false negatives.
> Happy to respin but feels like we only have bad choices here..

My personal take here is that packet loss at (very) low rate in a
controlled environment should be threaded as fatal: I think the patch in
the current form is the better option.

/P


