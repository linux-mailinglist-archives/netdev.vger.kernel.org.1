Return-Path: <netdev+bounces-50208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C308B7F4ECE
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 18:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BE952813F2
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205DA58AB0;
	Wed, 22 Nov 2023 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOR2PKrT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE00758AAC;
	Wed, 22 Nov 2023 17:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD0EC433C9;
	Wed, 22 Nov 2023 17:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700675727;
	bh=NKrLhVxDSneYqBCgaVREfOa2yycpjhLMjCDFnhPnIpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dOR2PKrTFmPPs9/0hWB9mt8n2ESvpeM8wedLTWtBwke6lEOhjDVyFWNHvwr2IK0aZ
	 YgW3ENr0qW1JAdGvsdxaJYdSAPeMnVhVn57X7EEqN5yyx1jQbLeVTODDy1LtyHZYMM
	 YlW07D5wXxGE9SYU1aJNMsckLmGb91ESFAjhaTsn40tiHiK22RQex/bbRZxOcQnGRi
	 Bl7DNCE+4JG/7nTxehf5ML6n/+Kiqx6vLNSBQHnvirnmGt4uafJdfcfOfVRucczSj4
	 glznnW5TNdm61zY+kocAbaHsQbeSXSrJkeojrZL26mfQYWzd78x5z9SMRsJ0LKb98z
	 z3jzNIaLyS+OQ==
Date: Wed, 22 Nov 2023 09:55:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <20231122095525.1438eaa3@kernel.org>
In-Reply-To: <20231122165955.tujcadked5bgqjet@skbuf>
References: <20231120115839.74ee5492@kernel.org>
	<20231120211759.j5uvijsrgt2jqtwx@skbuf>
	<20231120133737.70dde657@kernel.org>
	<20231120220549.cvsz2ni3wj7mcukh@skbuf>
	<20231121183114.727fb6d7@kmaincent-XPS-13-7390>
	<20231121094354.635ee8cd@kernel.org>
	<20231122144453.5eb0382f@kmaincent-XPS-13-7390>
	<20231122140850.li2mvf6tpo3f2fhh@skbuf>
	<20231122143618.cqyb45po7bon2xzg@skbuf>
	<20231122085459.1601141e@kernel.org>
	<20231122165955.tujcadked5bgqjet@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 18:59:55 +0200 Vladimir Oltean wrote:
> I wouldn't be so sure. The alternative interpretation "for PTP, give me
> timestamps from both sources" also sounds reasonable for the distant
> future where that will be possible (with proper cmsg identification).
> But I don't see how to distinguish the two - the filters, expressed in
> these terms, would be the same.

We can add an attribute that explicitly says that the configuration
is only requesting one stamp. But feels like jumping the gun at this
stage, given we have no other option to express there.

> So the ptp4l source code would have to be modified to still work with
> the same precision as before? I'm not seeing this through.

We can do the opposite and add a socket flag which says "DMA is okay".

