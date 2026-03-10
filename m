Return-Path: <netdev+bounces-266312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEYVEZB4sGnLjgIAu9opvQ
	(envelope-from <netdev+bounces-266312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:01:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C87CC2574BB
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C519E30789FA
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 20:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F623E275F;
	Tue, 10 Mar 2026 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqfcngR1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443F51F09A8
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172807; cv=none; b=iXIwsO1C3nbNsPIlcgU3/aAfWrU77q768iOMu97TM6auY4PsfIRqJmnBhqN8y4kvyy4Wxu/fKP/9MjAijHtd9WL8hqALmxM634MJw2hs5W5Z7/yQ8e2+rq7PYMDIiGO4JuD9WbW6feYMB/ojkE/OLM+LBzqMGOkj4LEnFC886pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172807; c=relaxed/simple;
	bh=37ogc63rPdpHxIOhvYCoihD84+aO/3EJ+XgDvcKd8IA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfNxa67HLG8zAW0Dg1NkV2Z2LCiHSmi9iVt4TyFBv6rX2mTTfHvfc4EEgAlo2X5ZIEfczAxzYHEWR/vE7ntZ3/+gC5OUWJeX9OUElxxkkOytBX9WpvDrupneQL54v3ZSSMnwlLP5S5EWmiAMXCcquJnBKUQpxwm1mHTzyffTgGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqfcngR1; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439f59dfda2so648597f8f.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 13:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773172805; x=1773777605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lptrZFdTw0Mmg/964QBMpRcVUiqY4xZSvMcx33nPZWE=;
        b=KqfcngR1LO53EPTk/GoHHThdzBcK/uNgbJ+MG6/2/OufKhaXVvpVerdj2sni0SmxUz
         JKFeBLj9NV1KP6aTH9u2sBbRFwrN2mBS1gkh1LYR8TtBtFxH5xIJ7RptoAynIMr6RVDB
         0WvdanuBxLjhudur7Od/fEoVvSPkiK88yz9OHgfP6LU5KfaovxCOZwQ0OSVH2DLktwTR
         +71iNZgIhLQ33EMKPi7mB6LMXoew+hsWKu+arHj2L0ndPhJX3L+ixxfH9i01WKx3g0Mc
         FAMPAwXvbVYEI6QZhl581CeKYs8H9TodC5dnWHJoOHgp5g1UUXwIBRyYKXczj4Cgpu64
         6EFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773172805; x=1773777605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lptrZFdTw0Mmg/964QBMpRcVUiqY4xZSvMcx33nPZWE=;
        b=GjSO47dcphB3pQUtkjlrCOXomsJxfSLDGy6bqIEWIRpdCepfjR3rvul69djfBhZ4ka
         3y9ABYdR4bgcCjtwrvAOnyM1Js+VSVS4bxuDT1V1Q4UVoUKZHCBtCIk5QRwavb0A7IdM
         AI6DJa8Yyn2X44G7Yp5hnqoxF/puzO4O3uXL0p7Y0dPJFlwpGeT+VuHJAoSQK0tIv0M+
         CdM78tGav7+l4EJlrPbCpoP1g6NXbMpj4e9WJrR/eM4M85rjS6f78ZmqEXkukYPRNa79
         VRhXJ9MTMOlOM5Q1sBg6AUNKLAIkiGDneGKj6yzrxOdZpRBmtqx0UZVZxOJCMS02hpXe
         e7dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjWKZT9tQE3sE986kv+Ij990nWyFalPHJzdSjHvwk9g5euM6n5nFVs4NCednfpSARxmuzbY7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywme6DPy1gcHal0x4FAAeRU1gMcIzvizAEo5T1/oZaE+d1YoAWs
	1G/OGtS/hF1wEA4S4X6K0C8BjsAznsST3RuVD4c+tKKNeRexxqCeKmG0
X-Gm-Gg: ATEYQzxoRg+BgROMLdFs6xP1izAhWExKPit82ZY7oz3ItNiZ5nEANJsE3v3dSPv7Yh6
	4Ohz6BTKNL/ZzQ5GdJpuAQmPEs2g3EAHkvFRtdBBr20+z8zw/1hRlxI2VPjwwmbZECOE4kggTYA
	PPUceG2/BNr1g4aHSY5OPa+IHUx+xRT9vmzz+R5+QPXAnFh0u5ZzXU3wddEv68UB9KNSXiw/LWo
	lRTUN7AZ4tx5+WhyDHlXindkurAqj0ao/hKcNJcjOV1WK6+ez2+KOSetGeDl/cI55906KRhIePY
	6ku9GQNPEXTYJFRQq4plKU0qMnO2q221aAAG7Hs+4FYkMQUUYtryUhiN3UosrLtXVOAmR37JRhI
	p1/v8Wnrbl/K8WLOCNtVgsxUpHZVfIg1Ab0ZRA8GilxGpzvK3FnjeXLS8eOIgnQ+KVh+TLeE1Gr
	c55VeQhKBNugs2QH+cGpcu3QPAnR34AhyMEr8Gxzm1Yf7BITv3xPzG19nyn6TG8Pce
X-Received: by 2002:a05:6000:1a8f:b0:439:afea:aff2 with SMTP id ffacd0b85a97d-439f820514bmr277725f8f.23.1773172804461;
        Tue, 10 Mar 2026 13:00:04 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a0480sm494267f8f.12.2026.03.10.13.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:00:04 -0700 (PDT)
Date: Tue, 10 Mar 2026 20:00:02 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern
 <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Florian
 Westphal <fw@strlen.de>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH v2 net-next 07/15] udp: Remove partial csum code in RX.
Message-ID: <20260310200002.579c7bdb@pumpkin>
In-Reply-To: <20260305215013.2984628-8-kuniyu@google.com>
References: <20260305215013.2984628-1-kuniyu@google.com>
	<20260305215013.2984628-8-kuniyu@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C87CC2574BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266312-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,strlen.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu,  5 Mar 2026 21:49:53 +0000
Kuniyuki Iwashima <kuniyu@google.com> wrote:

> UDP-Lite supports the partial checksum and the coverage is
> stored in the position of the length field of struct udphdr.
> 
> In RX paths, udp4_csum_init() / udp6_csum_init() save the value
> in UDP_SKB_CB(skb)->cscov and set UDP_SKB_CB(skb)->partial_cov
> to 1 if the coverage is not full.
> 

Is it worth completely removing the code that defers the udp RX checksum
until the copy_to_user() and the corresponding TX side code that checksums
the data being sent.


I'm not sure what the 'killer application' was for the RX side.
I'd guess the userspace NFS daemon - long since dead.

With most modern 'performance' NICs doing checksum offload you don't
want to 'waste' cycles doing a checksum during transmit that won't
be needed - and you don't know the interface until much later.

I also recall that pretty much only x86 actually tries to do the
checksum and copy together - most architectures checksum the buffer
fragments (of the iov[]) as they are copied - even though the kernel
buffer is linear; so has to handle more fragments.
ISTR there is a bug where 0 and ~0 get swapped.

Even for x86-64 the fastest IP checksum does 12-16 bytes/clock (I think
you can get 12 on Intel and 16 on AMD), and the copy will do 64 bytes
per clock (on recent enough cpu and once it is started and with an
aligned destination).
So even there separate copy and checksum may be faster.
The only time copy+checksum really helps is for buffers that spill
the L1-cache - which is why I think NFS's 8k UDP datagrams are why
the code was added at all.
(Last time I asked about this Linus couldn't remember.)

	David

