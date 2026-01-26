Return-Path: <netdev+bounces-253623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EjEKw7+d2lMnAEAu9opvQ
	(envelope-from <netdev+bounces-253623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:51:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A698E52D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CB46302515A
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA5D2D8797;
	Mon, 26 Jan 2026 23:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fc8FdtsH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pu8/yd3j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8526F3101AD
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769471498; cv=none; b=uA7kYmaPvjR5s/AnUR0C2GROKpig8Aa/a9pt4LXzbmbWKkkAm/0ph8rJ5Jz+m+pt3Gaw7ol0rRF3VFgHBNNjSzHrhH99Mk6EJtTmc+kqD/oPD3HvavEY8mh4sBfaCcX9xDWGlW14R3EDqfTRG8TnYEe4UlTnkicWP6ySwB6Mzwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769471498; c=relaxed/simple;
	bh=OjU/7JhA8qUHmEpEs1JgdlhPZhwmLp5tz6UYre4Y1d8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gnvzIX09vXXP4ouUU7T4m1fMO1N5Qv84M2Ndtx0KivDyfaFoNZwZXQxU4OF4qvuDvRaHcbiuFEa/8MjrxPLa1dUdHJRNwtl/70Vns/TJ+Gn64v+IOA0P4c8rtrxdkypjRLBLuu72IDzZ6pYEdJpUbdqUqWAG9LM1gK1LGyVTTn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fc8FdtsH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pu8/yd3j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769471496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3kmfSlY3SgRnOI8Edolh04QRXvpI2DRREc7GD2/Dpk=;
	b=Fc8FdtsHWasiAYX/vMFghcffRJ+XWoEuVRFVkCIQeAuAK9HMwJ7d1QUHWvxm6dUZQGzSm1
	0yNIxvyIyF9f2WadpS+RFDRP/KwNMRCcAeRpYvjpvYTS7WkAZi8FNROvudv3IHOO+6imOw
	5vn3X5ufcImFJmziT3PtHI5q/IQ61lc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-FjADGHpONOyeESWM3_fOFA-1; Mon, 26 Jan 2026 18:51:35 -0500
X-MC-Unique: FjADGHpONOyeESWM3_fOFA-1
X-Mimecast-MFC-AGG-ID: FjADGHpONOyeESWM3_fOFA_1769471494
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43065ad16a8so2996633f8f.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 15:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769471494; x=1770076294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3kmfSlY3SgRnOI8Edolh04QRXvpI2DRREc7GD2/Dpk=;
        b=pu8/yd3jHwnp6D+plZzQvAD/KF0IhUTPmRmxyEzGOdbDE0qwtGm6wdzWNaV9+7zc/H
         XagJT//yJwAyDRVBushIo1AAwrdfTvwOTBjyTlNm3wnkyEStlUgx1WdQgq9AG2aKbVgk
         iwiqZ0Vcdxw2Pe8r2Eih600MC6W5X5CLfvEa3SK24q8lUZ0HLBmOgUp8i15usdNFg3oE
         Jmd2LCsf1zHNB0hJ1HU9/blIQlLUA2DX1JXBVvdCVcLSdchoWk8OGemszNKXUGiTPyZF
         iVcswDc8w8uFQSHTErurnZp8bX2vyWouc0zO0fcMZWRYrvfusZroR41RakcFEXFRo2Xu
         9RbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471494; x=1770076294;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L3kmfSlY3SgRnOI8Edolh04QRXvpI2DRREc7GD2/Dpk=;
        b=lFHG3oJDjDveG+yxNsztxGm7KMsRwbKePO/0sGGCR0Y54Bet//AXn0Y4MtbIozIHUs
         sZdt17yMHOjyr1GQvtDcYItYX8SrxV5QY7I0bSJOTsYm2VNhChIBV6S5RUvkgpyI5YvS
         fBVKpsW460bh/jPClBQU0gN2Yw8VNRvuA4CeDGxuuN3QGFwD5VJJZdwgZnFSzsTkWnS6
         OxcDXFbRg54en3M0VM5QoXpGLuRcC9pRQnu9m13LBKJKbWlYPl6y22k1PU7gl/HDfnxG
         6LeFgcaYgdL3U4Lawq2qIINtbw2jPkP4nJ97MgOR8zZg//cXSJpHzb4oGGy5VlJAmJ0z
         PcSg==
X-Gm-Message-State: AOJu0YyUzVEWZeLOKBcEyTb2n9YOXH/llZ88sTc7+vpg3lKE2PTaZ1jf
	bndDKjYrsluvRji6WROPdyQUXuumcGPn5ww+crLhdYYQc3cWzAauxqDmK1rCvXchy8CaO1xqHKy
	Xwu4M6R9duf/KDqBJkXDEsx2/nmDcK6rPLiByNkbLlZVXWozzLZ5zjyYkwA==
X-Gm-Gg: AZuq6aLXhHnGxNu3/OtnmbWkVUw6gjSPCQFOroE/gjYJ6cEdJHpNl2HNth8/FGVh5cO
	kVtiNx3i/2ACbXNPWFP3D8HGEGb56qXCuUR4psxUHD+Hcry0d5yCV6p1OwszZDvJAQ0qBye5lG7
	4fa3Cyaq8hpIJvbyZwCrFvzUcU7ntn9sDjoEFsSSwJS0TwTlcsCD4Ot/6a2p2pDoiEG9kQd+pPp
	Uac/a9GlgAqgUQ09O8fXFrBrKfxH7fs8nlMNeniOeNrjKCmqbQvH3CDzkUAl/2F0NO+eC6wgO3W
	J9mJUyEm7WkKHvrF8yZRqGZ5qLt3PEd7I0k8HVXiug/0F2sk/JEVUi8oBa+cGRjeEP6uQvpcJ2Y
	IvD5EdUYQFR6x/tiNsedxgXo8/Dq5XrpGNA4MltfVfr7csaU=
X-Received: by 2002:a05:6000:1a8a:b0:435:a594:33dd with SMTP id ffacd0b85a97d-435ca1a7a43mr10414602f8f.46.1769471493906;
        Mon, 26 Jan 2026 15:51:33 -0800 (PST)
X-Received: by 2002:a05:6000:1a8a:b0:435:a594:33dd with SMTP id ffacd0b85a97d-435ca1a7a43mr10414579f8f.46.1769471493514;
        Mon, 26 Jan 2026 15:51:33 -0800 (PST)
Received: from localhost (net-37-117-189-93.cust.vodafonedsl.it. [37.117.189.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02dd4sm33234258f8f.5.2026.01.26.15.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:51:33 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>, Andrew Lunn
 <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>, =?utf-8?Q?Gr?=
 =?utf-8?Q?=C3=A9gory?= Clement
 <gregory.clement@bootlin.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net-next 3/8] cadence: macb: Add page pool support
 handle multi-descriptor frame rx
In-Reply-To: <DFYQS9RIPCSY.25SHGGC3VM2M3@bootlin.com>
References: <20260115222531.313002-1-pvalerio@redhat.com>
 <20260115222531.313002-4-pvalerio@redhat.com>
 <4c74c2c4-7a47-45ff-be17-485e0702cc37@lunn.ch> <87cy315lru.fsf@redhat.com>
 <840fd286-779e-4130-b544-913116c97a29@lunn.ch> <87qzrdecs1.fsf@redhat.com>
 <b0bff7a8-a004-4eb7-bf1d-2137182e59f9@lunn.ch>
 <DFYQS9RIPCSY.25SHGGC3VM2M3@bootlin.com>
Date: Tue, 27 Jan 2026 00:51:21 +0100
Message-ID: <87ldhkexvq.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253623-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27A698E52D
X-Rspamd-Action: no action

On 26 Jan 2026 at 07:45:29 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> w=
rote:

> On Mon Jan 26, 2026 at 3:29 PM CET, Andrew Lunn wrote:
>>> > I was more interested in plain networking, not XDP. Does it perform
>>> > better with page pool? You at least need to show it is not worse, you
>>> > need to avoid performance regressions.
>>>=20
>>> I retested with iperf3. The target has a single rx queue with iperf3
>>> running with no cpu affinity set.
>>>=20
>>> |              |  64 | 128 |
>>> | baseline     | 273 | 545 |
>>> | pp (page)    | 273 | 544 |
>>> | pp (2 frags) | 272 | 544 |
>>
>> So no real difference. That is unusual, it is typically faster, or if
>> it is always doing line rate, it uses less CPU time. That might
>> suggest the page pool integration is not optimal?
>
> One more data point. I get line rate with & without page_pool so below
> are CPU times from /proc/stat:
>
>          upstream    pp
> user            1     1
> system        179    91 (!!!)
> idle         7874  7303
> softirq        35    37
>
> 16K pages on Mobileye EyeQ5 (MIPS), 7 fragments per page.
>
> Paolo shared 64 versus 128 measurements but I am unsure what those stand
> for; I doubt it can be packet size as xdp-bench does not have it as a
> parameter. https://man.archlinux.org/man/extra/xdp-tools/xdp-bench.8.en
>

64 and 128 are packet size in bytes.
For the first test I used xdp-trafficgen on the sender side and
xdp-bench (skb-mode) to count the drops in pps on my board.

For the stack test I used iperf3 (UDP) similarly with 64 and 128 for the
length option.

> Measurement incantation:
>
>    cat /proc/stat > /tmp/a && \
>    iperf3 -c $IP && \
>    cat /proc/stat > /tmp/b && \
>    awk 'NR=3D=3DFNR && $1=3D=3D"cpu" {user=3D$2;sys=3D$4;idle=3D$5;softir=
q=3D$8;next}
>         $1=3D=3D"cpu" {printf "user\t%5d\n", $2-user}
>         $1=3D=3D"cpu" {printf "system\t%5d\n", $4-sys}
>         $1=3D=3D"cpu" {printf "idle\t%5d\n", $5-idle}
>         $1=3D=3D"cpu" {printf "softirq\t%5d\n", $8-softirq}
>    ' /tmp/a /tmp/b
>
> Thanks,
>
> --
> Th=C3=A9o Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


