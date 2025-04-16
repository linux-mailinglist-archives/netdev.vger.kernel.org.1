Return-Path: <netdev+bounces-183171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732C7A8B450
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141493BA989
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4574E22F169;
	Wed, 16 Apr 2025 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aNqFtwSc"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E208C22AE59
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744793343; cv=none; b=s17gvI0cDMfcZbDheC/1c2qPeZWf8eKmpZtiBr6Gh4VKJdl17t+/824hkGFmSM6IID4lqQ4tNl2qkvX+y9T3UeJjBhgfll+4Hk7G4KOLhXpqjYDWaxGAFrAtNZkwOL99ocz7X/0AO7vTHUmraKPfkRF1QjrKi9a+2Toaett4AFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744793343; c=relaxed/simple;
	bh=wo5bTTP84bYwAWBSuk6Jk+kr6J9UHNO3BRIkezh0fGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RW8s12Lh78kgSi1zgCdq8ZZP1hJGI35H7Wxv3/p3RAYwBtHeGbyrEqwDRVgeCDHe6CkoSOoXRTsFbfhkzMx+SASgM5AgEPNW36K94RfRgGpHQWCUf+7WzXJ0sVqIQ0fh6KLYMmcrCws1hIPuH1SoCVxUYh6ePR8KAzlrBScGETw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aNqFtwSc; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 38713432FF;
	Wed, 16 Apr 2025 08:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744793332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nVvr6rcLERr5+8C01/FE5xf/NsC+eqK+KOEEzxrbVYA=;
	b=aNqFtwScR2aN7gwxy5amx2oI7v2jD8cpgZZv8Ro191dnSfpfocQcyVYW4ehTNicBbHMqrR
	LbQHacS3H3pWbzxK91D1dd5UO+suyf2xsLwPsSz1F8CzQvXfl+ESwCR+gIYbYPVtmvbpyQ
	3Ih8LqX9JiAGbaEuhjh9NU1pO9ToLrQlkDNhIHNsqB1pM7ZmAMhSU7nJbXuTlawlQi91ED
	w/79GeciDXzjmLDRzOXjyuqiT3KJ8ypMYC+bHHgipF14uoKwkmtvLzi9RVCEZQauxnoOsf
	mcyi/i6IAUwo9XL8ViGLzD8vY1yFofN75kHPEf9y1rW8TwOHLG2g27R+dvqqAw==
Date: Wed, 16 Apr 2025 10:48:49 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH RFC net-next 2/5] ptp: marvell: add core support for
 Marvell PTP v2.1
Message-ID: <20250416104849.43374926@kmaincent-XPS-13-7390>
In-Reply-To: <E1u3LtV-000CP1-2C@rmk-PC.armlinux.org.uk>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
 <E1u3LtV-000CP1-2C@rmk-PC.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdehleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqheftdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfejveefgeeggefhgfduhfehvdevvdeukeelveejuddvudethfdvudegtdefledunecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheprhhmkhdokhgvrhhnvghlsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtp
 hhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com

On Fri, 11 Apr 2025 22:26:37 +0100
Russell King <rmk+kernel@armlinux.org.uk> wrote:

> Provide core support for the Marvell PTP v2.1 implementations, which
> consist of a TAI (time application interface) and timestamping blocks.
> This hardware can be found in Marvell 88E151x PHYs, Armada 38x and
> Armada 37xx (mvneta), as well as Marvell DSA devices.
>=20
> Support for both arrival timestamps is supported, we use arrival 1 for
> PTP peer delay messages, and arrival 0 for all other messages.
>=20
> External event capture is also supported.
>=20
> PPS output and trigger generation is not supported.
>=20
> This core takes inspiration from the existing Marvell 88E6xxx DSA PTP
> code and DP83640 drivers. Like the original 88E6xxx DSA code, we
> use a delayed work to keep the cycle counter updated, and a separate
> delayed work for event capture.
>=20
> We expose the ptp clock aux work to allow users to support single and
> multi-port designs - where there is one Marvell TAI instance and a
> number of Marvell TS instances.

...

> +#define MV_PTP_MSGTYPE_DELAY_RESP	9
> +
> +/* This defines which incoming or outgoing PTP frames are timestampped */
> +#define MV_PTP_MSD_ID_TS_EN	(BIT(PTP_MSGTYPE_SYNC) | \
> +				 BIT(PTP_MSGTYPE_DELAY_REQ) | \
> +				 BIT(MV_PTP_MSGTYPE_DELAY_RESP))
> +/* Direct Sync messages to Arr0 and delay messages to Arr1 */
> +#define MV_PTP_TS_ARR_PTR	(BIT(PTP_MSGTYPE_DELAY_REQ) | \
> +				 BIT(MV_PTP_MSGTYPE_DELAY_RESP))

Why did you have chosen to use two queues with two separate behavior?
I have tried using only one queue and the PTP as master behaves correctly
without all these overrun. It is way better with one queue.
Maybe it was not the best approach if you want to use the two queues. =20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

