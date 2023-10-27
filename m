Return-Path: <netdev+bounces-44852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4907DA21D
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F5E282549
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 20:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513D23D383;
	Fri, 27 Oct 2023 20:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jb/rCVvC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8311A3C084
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 20:58:43 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919C61AA
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 13:58:41 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 012261BF203;
	Fri, 27 Oct 2023 20:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1698440319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOCsjhN2awknGo5pBlXRMM+M86Or5ct0FJt+fQPYItw=;
	b=jb/rCVvC0bUZIVDk76vxqa5l84U5AlmuVSm0uxO1Ymb/JI+N6EF3twM4m3Y/b3QEtNFlva
	R7adzus77K9z/T82BdpO6UKr4C+0mAQ89i7P9v90WR85vcd8WzHUcVvCvmjTGIiiBdH9yv
	W6Q78d6NzpKvRmtSpTs1wn7hGbZkwLKJK48+H7+kp1N5uMfVFvjjWFgh6z55G0CXKLH5F6
	KohheqQlb2rTfYPAxqpctBHwVaZOnRQBN6VXu0sfxHg5vEkT4ymLdcVxnRF85QhsY5Mrgk
	Uw/4ahX/8PnvXxGW3Bu7koEKS6b7T51cXKpTZ1rGBX66BrBMgXWwveuSX/cYNw==
Date: Fri, 27 Oct 2023 22:58:36 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Wei Fang
 <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, Russell King <linux@armlinux.org.uk>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-imx@nxp.com, netdev@vger.kernel.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: Ethernet issue on imx6
Message-ID: <20231027225836.11594bd5@xps-13>
In-Reply-To: <4736f0df-3db2-4342-8bc1-219cbdd996af@lunn.ch>
References: <20231012193410.3d1812cf@xps-13>
 <8e970415-4bc3-4c6f-8cd5-4bbd20d9261d@lunn.ch>
 <20231012155857.6fd51380@hermes.local>
 <20231013102718.6b3a2dfe@xps-13>
 <4736f0df-3db2-4342-8bc1-219cbdd996af@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Andrew,

andrew@lunn.ch wrote on Fri, 13 Oct 2023 17:51:20 +0200:

> > # ethtool -S eth0
> > NIC statistics:
> >      tx_dropped: 0
> >      tx_packets: 10118
> >      tx_broadcast: 0
> >      tx_multicast: 13
> >      tx_crc_errors: 0
> >      tx_undersize: 0
> >      tx_oversize: 0
> >      tx_fragment: 0
> >      tx_jabber: 0
> >      tx_collision: 0
> >      tx_64byte: 130
> >      tx_65to127byte: 61031
> >      tx_128to255byte: 19
> >      tx_256to511byte: 10
> >      tx_512to1023byte: 5
> >      tx_1024to2047byte: 14459
> >      tx_GTE2048byte: 0
> >      tx_octets: 26219280 =20
>=20
> These values come from the hardware. They should reflect what actually
> made it onto the wire.
>=20
> Do the values match what the link peer actually received?
>=20
> Also, can you compare them to what iperf says it transmitted.
>=20
> From this, we can rule out the industrial cable, and should also be
> able to rule out the receiver is the problem, not the transmitter.

I've investigated this further and found a strange relationship with
the display subsystem. It seems like there is some congestion happening
at the interconnect level. I wanted to point out that your hints helped
as I observed that the above counters were incrementing as expected,
but the packets were just not sent out. My interpretation is some
kind of uDMA timeout caused by some hardware locking on the NIC by
the IPU which cannot be diagnosed at the ENET level (the interrupt
handler is firing but the skb's are not sent out, but we have no
error status for that).

Here is the link of the thread I've just started with DRM people in
order to really tackle this issue:
https://lists.freedesktop.org/archives/dri-devel/2023-October/428251.html

Thanks,
Miqu=C3=A8l

