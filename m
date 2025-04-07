Return-Path: <netdev+bounces-179674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43782A7E0F0
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC701688DD
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6152C1D5AA9;
	Mon,  7 Apr 2025 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IDpfbumC"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A83A41C85;
	Mon,  7 Apr 2025 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035364; cv=none; b=gGGuKSc0p1hK3wpgePUaqoJIEU0ky3FNalDBfa+UE8f7B2dRWjipyqDLwpdmZeSOzsso8XtS/CqIKSeQGCVV5lMGIWHKaWGto77Rrx3dGLT3d1GX6sKWKxTRfuF33bG0Ta+77HA3QCNlwpaPYvFQyk+2I86gX/6RycSaVBsq580=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035364; c=relaxed/simple;
	bh=jR66UXo5ZVKut0sbF/SRuUmB0izWiNSoiQu6bDTszjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQQKR+I0JIndY+qe10XmN2Lqy7ullB25C2c6ebLv+qm0b6W97RCg/Urm8as0kSfgrdNoEopOFqwayP7IPzu3oywwaAwUdoB05kzwAxUv8ac9qmZrFaAi3S8hNUo9lXWAf+ayNdPZnmZXCiBwJ075uRtFea/AohEt1fyu3CneCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IDpfbumC; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F78242D43;
	Mon,  7 Apr 2025 14:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744035360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jR66UXo5ZVKut0sbF/SRuUmB0izWiNSoiQu6bDTszjw=;
	b=IDpfbumCalcmtKvU6N1suTF7lcu3WGPE7QQSTh8Z9hLYufjCd7a+yUhhONDrEdVwAmpa0M
	n7tyIavyE1+yCU8oxYU4Cp7Cjk5TQSwsoVmVqsB5EJwFW8QPo71L4JuXMXKc14o2JL7rTt
	E9IUPyLx7ipUePYbJ5tZhOVRgBNKm1FyB6vPquQ4pgjGX+Lcex7UYZqNW6My/8EZAlwGOs
	+Adpwxx609sGWlsKRLiSuZHaW4jxRu3Uroul546t3DfcIAxzu2zAhEtpnNLHD0HrOWxBu/
	32IxiuPrS2h9uBoEO73ZzAmurBTmQTeRZMuVXlUHOTGv1lBvzdC8ryeDcomYGA==
Date: Mon, 7 Apr 2025 16:15:58 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marek =?UTF-8?B?QmVo?=
 =?UTF-8?B?w7pu?= <kabel@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add Marvell PHY PTP support
Message-ID: <20250407161558.30655bcc@kmaincent-XPS-13-7390>
In-Reply-To: <20250407-feature_marvell_ptp-v2-2-a297d3214846@bootlin.com>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
	<20250407-feature_marvell_ptp-v2-2-a297d3214846@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtgeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguu
 hhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehkrggsvghlsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 07 Apr 2025 16:03:01 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>=20
> From: Russell King <rmk+kernel@armlinux.org.uk>

It seems b4 is automatically adding another From tag is the Author is diffe=
rent.
Sorry for that.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

