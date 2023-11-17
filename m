Return-Path: <netdev+bounces-48701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A187EF4E7
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 496B8B209E5
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF713035F;
	Fri, 17 Nov 2023 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="auW2A490"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162A2D56
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 07:09:32 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 649A6C0009;
	Fri, 17 Nov 2023 15:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700233771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXuNjUVN/i3SDyFOHUKZtsOeHvcsrFLBDRIHM+JisT8=;
	b=auW2A490Mc6Ork0k0BQPL0UgqqtwKKXb0WYiRcnxmEtIr3/zW3sqJ/OC7+gk8K1crrHu5L
	ukiJSC7kDfuzGKpa9Vd6TKvKJFWquw4yYbq99M01GuYu/STpuT2fkD5v3AjoBt5Ephemwq
	etThRVgND/bsidndu8yUSLWrNOghB3qsnUxQyqaGeVStdiH+Q8diZx9DzVdz58YxpHdPJt
	BuHw6UKAplKQcZi7Gx8qrUxnXjaUdHlPLPCdJ2/UVJbyxc0AhM4quzDTc7itr7p/01EQVY
	YSJ6NXlz8EhJEjuYUXhYYvmKMv3g2d2QQ0w9yg08Frl/t7DSNCY4eBN3+h/86A==
Date: Fri, 17 Nov 2023 16:09:28 +0100
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
Message-ID: <20231117160928.04ba5359@xps-13>
In-Reply-To: <20231027225836.11594bd5@xps-13>
References: <20231012193410.3d1812cf@xps-13>
	<8e970415-4bc3-4c6f-8cd5-4bbd20d9261d@lunn.ch>
	<20231012155857.6fd51380@hermes.local>
	<20231013102718.6b3a2dfe@xps-13>
	<4736f0df-3db2-4342-8bc1-219cbdd996af@lunn.ch>
	<20231027225836.11594bd5@xps-13>
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

Hello,

> I've investigated this further and found a strange relationship with
> the display subsystem. It seems like there is some congestion happening
> at the interconnect level. I wanted to point out that your hints helped
> as I observed that the above counters were incrementing as expected,
> but the packets were just not sent out. My interpretation is some
> kind of uDMA timeout caused by some hardware locking on the NIC by
> the IPU which cannot be diagnosed at the ENET level (the interrupt
> handler is firing but the skb's are not sent out, but we have no
> error status for that).
>=20
> Here is the link of the thread I've just started with DRM people in
> order to really tackle this issue:
> https://lists.freedesktop.org/archives/dri-devel/2023-October/428251.html

For future reference, the thread mentioned above unfortunately did not
lead to any discussion (I admit it's not a common topic though) and
further investigation pointed at the DDR configuration. I had a hard
time making a link between the reset pad of the DDR controller being
misconfigured and the Ethernet drop rate, I still fail to do, but in
practice this very little change apparently had a significant impact and
totally solved our issue:
https://lore.kernel.org/u-boot/20231117150044.1792080-1-miquel.raynal@bootl=
in.com/

Thanks to all of you for your help and feedback,
Miqu=C3=A8l

