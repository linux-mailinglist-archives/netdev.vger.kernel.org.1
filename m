Return-Path: <netdev+bounces-190129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A52AB541C
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC971B46338
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45621255E4D;
	Tue, 13 May 2025 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fFbje9LC"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FCD80B;
	Tue, 13 May 2025 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747136935; cv=none; b=pVX41OVbmzchZ7ZfqEFXBC70gWQgLVY90WHq2FXc9Ys1OINZCVBAGSteVCY64JtptsxDU5yNtTTSmnZLr9604sYB+FClSnrzagZrV3NgsmCkOh3JOM76+JewB+G1zeqW4MvP1ZRva3uDQYnT0H3oe2Ln2ncHloKuEFJzxuxrYhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747136935; c=relaxed/simple;
	bh=PfHDASGae7GwzCjj5rJNhR8LKba7dyTry6KYd7MXJfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pz9MYgIqDYYwQwxnV78cCYdTIEonBWct0KpPhhOIm/s7OLPg8stutt1Q10K7WQ2UteVAVZe/F1cIzTGGnp5cJYYxemt9uNwsDwSbTQEanum1Zn9diTbMn7+Clz9ILFnswiBKJR9EciwPE4ulA7FuX6moaEjBx/MsebEdUrvTVZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fFbje9LC; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4BB8543224;
	Tue, 13 May 2025 11:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747136925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfHDASGae7GwzCjj5rJNhR8LKba7dyTry6KYd7MXJfo=;
	b=fFbje9LCo6l6XU2zxFRW5hVpKZrp8WzQUh3eW+UpxYIan3ddHX1xVjmBw90aIIxFvKC/tp
	nKoQCCddeRToqSi/ByA5DoYeL8SEqxlz6pKwPssNtTZI5ThN9vtZTxkwTJCr0Uw6uC+Svq
	bAtETBQghcEAsuW0f6vBqorqw3Ms6/HmSbxtJPKV+gx0Ftrv7OtjsiQqeFfeUZ44xHdGvu
	iuODVwB+44/tmcRpSjVdZKmtIwuMFKMpsozrJeW9z9DhS5WZ8LyZhSTmmqWOnXrJXHfUf6
	ZZIJslOKFeN/fcH9iNmPbUTGbEIMZtBMDyhc9iHkPyjS+T862lsBs0mBHJG7Jg==
Date: Tue, 13 May 2025 13:48:39 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Piotr Kubik <piotr.kubik@adtran.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/2] Add Si3474 PSE controller driver
Message-ID: <20250513134813.579ff90e@kmaincent-XPS-13-7390>
In-Reply-To: <bf9e5c77-512d-4efb-ad1d-f14120c4e06b@adtran.com>
References: <bf9e5c77-512d-4efb-ad1d-f14120c4e06b@adtran.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdegtddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudgrmeeiudemjehfkegtmehfjeekrgemfhelvghfmeekkegttdemieefsghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdurgemiedumeejfhektgemfhejkegrmehflegvfhemkeektgdtmeeifegsfhdphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepphhiohhtrhdrkhhusghikhesrgguthhrrghnrdgtohhmpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhop
 egrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 12 May 2025 22:02:52 +0000
Piotr Kubik <piotr.kubik@adtran.com> wrote:

> From: Piotr Kubik <piotr.kubik@adtran.com>
>=20
> These patch series provide support for Skyworks Si3474 I2C
> Power Sourcing Equipment controller.
>=20
> Based on the TPS23881 driver code.
>=20
> Supported features of Si3474:
> - get port status,
> - get port admin state,
> - get port power,
> - get port voltage,
> - enable/disable port power

You forgot the series version in the subject like this: [PATCH net-next v2 =
0/2]

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

