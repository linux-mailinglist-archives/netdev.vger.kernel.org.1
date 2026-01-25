Return-Path: <netdev+bounces-253192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IgEDeFodmmyQQEAu9opvQ
	(envelope-from <netdev+bounces-253192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 20:02:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7553E81DC6
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 20:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAC2F3003EEA
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 19:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D96B223323;
	Sun, 25 Jan 2026 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M61kLgwo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ej4Vxawt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9991F7569
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 19:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769367774; cv=none; b=cH1APG8T1cV4Rq4TuRw19CtUOiqrQm/8TW3Tkx580FlTYl2b+VmN3Yo6CnJp/UDj/BgH0qlvf4SBIvoWKvr2ON0ENspa2jJFlrIiP2ORMj7QVLk4X/6K6XHQu9oU6x17L6vMcpQBKMJlIsvf9k11rrkoFpN+pOHQVRSfVMLGa2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769367774; c=relaxed/simple;
	bh=ObrBqY8nI6RD2MKtWnQHqIHyCsLi8ljGPLEOZ4U6uKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mPDijYmfqDI1QCJdZeakk1iLRl0Ri1zV89jSFps+lgs8m4HRNn/wLM0a+R9KGbnR3ECOmy2c4WFQKNBd+u6H33pzf6lUVLbShwa/SIFxKmMAqUbdq2kQVYeLAbMG4zlEM/Y0/GSuSsyvwKpAleEZitBoXNv46BPxw7Rz0Z3O/LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M61kLgwo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ej4Vxawt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769367771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7TQ4nfYitOBKJx/MenO2YB6rZeebDkLTTaa5ZaUbToY=;
	b=M61kLgwogyN4HaMvtN9/deBjeaNYqS4nhglgWG2MWGXN0ziW2Ufuv9X/MdsvuOg4Rc48LQ
	h86zsFxYh+Ko0Qm6HIuFVz7ilZf0lcg2APOrsDNZAEb3kGnbWYQ+2Kl+ZLqpgEyajdNxre
	IZ8bQXMijz2N27TEzggRZvuuZWU6+Ys=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-xHw-uDKXPgeMvRH7Kq94OA-1; Sun, 25 Jan 2026 14:02:50 -0500
X-MC-Unique: xHw-uDKXPgeMvRH7Kq94OA-1
X-Mimecast-MFC-AGG-ID: xHw-uDKXPgeMvRH7Kq94OA_1769367769
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430fcf10287so3259616f8f.0
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 11:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769367769; x=1769972569; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7TQ4nfYitOBKJx/MenO2YB6rZeebDkLTTaa5ZaUbToY=;
        b=Ej4VxawtPXZDWCa251OLYTH5phzRONSOFq+gYLZq6SdafhCPe10a3S9mlbYbHthtlA
         0ukwF8urK4S5B3Nu4yRrY+UCN3Je0JHF5BW7MFC77vG6NF5vVK/Evx98xl5wo6W5Ol+2
         uCaSxuOlJ4IyVjxiI742Rpvti0btSVlumTALNeEWYxy2F9CoblDgjv1CgBPr8gfy29O7
         bwq5gTD05UTCLp0F9sY63xU5zspN7zGgbxgrzB2ou2suxAfzVZ7q5Yuy4kPBtnEPCp0s
         x324w/GZwm34XL1/upGn8U6QHi3ZYOGepfIgg3yrLRX/YEJ44mAwJO6nWMPp3RpkoL9M
         YVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769367769; x=1769972569;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7TQ4nfYitOBKJx/MenO2YB6rZeebDkLTTaa5ZaUbToY=;
        b=Lw94ikmJFqxntXQ1kYA4ALLbWbDJKpRw5m18qCbyEz/H/tahjl6sIVDDk+I/mumi7O
         /Z1HlzhnNXG76erJ2N8npaA9+0upKUXEGhbrzfkBPuXvKzZEdrp3IoEwEu+/VJwnoZhk
         kvv1MeUc066313M6wby5VizR5xhoaQWX1kfHfl8xMSZNRZPPFx3kGWQLXwrvttqK8+hw
         u/QAyO+P/u3Kw9VLF4mF53ec2F/kSQ9zrMgJiUSc236e/4zfPfSl4LNoPRtsckyeMmia
         nqUzW+v6fpXvfnU96BsgjlbeSxc0+f1Ua52l48KuOJ8RaKnrXo5t5RUw/Lz6tC9h4SQU
         fGcQ==
X-Gm-Message-State: AOJu0YwTY+geVWPA8zhYaHVrIyJ9uLoD5HQCtnRMHNM/L71R0XUHoIeR
	hLbkncInVB1nXdnC0h+hcl6EfeUYhgs15FsgDG8enD/E2i8XhZ21MKJ7KNKun1Nkt3rNAx0x4UG
	jKAEuHCBN6r22RBoZ3hCkC4F2rgXxBorQeDqF4ZAAcHvZ5kLK5mAkPhDwCw==
X-Gm-Gg: AZuq6aKUGCm32MUARKi4KGw4ZZSNbnX9MlHvaJwt5KQlTixTUQKArfIfloWchEW074M
	oeS/hhBkNDKY9dR/+318wGQHqLmR/YoVQTKsLjDkIi5gNtoWB0G1hdpjz24wEWwv/Lythe9XCmQ
	CIh89KvJysSST3VXcr0ESeVSvGa3UdXG+AnEMD5AwyfWSgQoyU3jPDUwipvsqt9t0DBswni0MM9
	o/Cy3vqvdtInlLzesxchusSy2cldHkX+8AVLSEXFpCAATJUBI2mf8xUnTyvIP6iXdVMONO3Gw//
	GgIlaYVo7fcR36YinCuJ1sg7JKQkudsR8SD4DF48Mg93bkmOhc2d/9eOHSZRDqjLQH1RftW+8m+
	huObwidRabbR0hXqd2B5sSYVmRQd8eU1ZDuHxPUPTVt4drNI=
X-Received: by 2002:a5d:588b:0:b0:432:c092:ee3b with SMTP id ffacd0b85a97d-435ca1aff1fmr4203827f8f.62.1769367768796;
        Sun, 25 Jan 2026 11:02:48 -0800 (PST)
X-Received: by 2002:a5d:588b:0:b0:432:c092:ee3b with SMTP id ffacd0b85a97d-435ca1aff1fmr4203784f8f.62.1769367768328;
        Sun, 25 Jan 2026 11:02:48 -0800 (PST)
Received: from localhost (net-37-117-189-93.cust.vodafonedsl.it. [37.117.189.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f745c5sm24565438f8f.32.2026.01.25.11.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 11:02:47 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 =?utf-8?Q?Th=C3=A9o?=
 Lebrun <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 3/8] cadence: macb: Add page pool support
 handle multi-descriptor frame rx
In-Reply-To: <840fd286-779e-4130-b544-913116c97a29@lunn.ch>
References: <20260115222531.313002-1-pvalerio@redhat.com>
 <20260115222531.313002-4-pvalerio@redhat.com>
 <4c74c2c4-7a47-45ff-be17-485e0702cc37@lunn.ch> <87cy315lru.fsf@redhat.com>
 <840fd286-779e-4130-b544-913116c97a29@lunn.ch>
Date: Sun, 25 Jan 2026 20:02:38 +0100
Message-ID: <87qzrdecs1.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253192-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: 7553E81DC6
X-Rspamd-Action: no action

On 23 Jan 2026 at 12:04:55 AM, Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, Jan 22, 2026 at 11:24:05PM +0100, Paolo Valerio wrote:
>> On 16 Jan 2026 at 06:16:16 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> 
>> > On Thu, Jan 15, 2026 at 11:25:26PM +0100, Paolo Valerio wrote:
>> >> Use the page pool allocator for the data buffers and enable skb recycling
>> >> support, instead of relying on netdev_alloc_skb allocating the entire skb
>> >> during the refill.
>> >
>> > Do you have any benchmark numbers for this change? Often swapping to
>> > page pool improves the performance of the driver, and i use it as a
>> > selling point for doing the conversion, independent of XDP.
>> >
>> 
>> I finally got the chance to get my hands on the board.
>> 
>> On the rpi5 I simply run xdp-bench in skb-mode to drop and collect the
>> stats.
>> 
>> Page size is 4k and stats include the driver consuming a full page
>> setting mtu such that rx_buffer_size + overhead exceed half page and the
>> other way around for 2 fragments.
>> 
>>              |    64     |    128    |
>>   baseline   |  533,158  |  531,618  |
>>   pp page    |  530,929  |  529,682  |
>>   pp 2 frags |  530,781  |  529,116  |
>
> I was more interested in plain networking, not XDP. Does it perform
> better with page pool? You at least need to show it is not worse, you
> need to avoid performance regressions.
>

I retested with iperf3. The target has a single rx queue with iperf3
running with no cpu affinity set.

|              |  64 | 128 |
| baseline     | 273 | 545 |
| pp (page)    | 273 | 544 |
| pp (2 frags) | 272 | 544 |



>      Andrew


