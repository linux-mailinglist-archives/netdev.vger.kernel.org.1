Return-Path: <netdev+bounces-169072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9628A427D6
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75889188E5F0
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 16:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369D2262D3B;
	Mon, 24 Feb 2025 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CLF47tr8"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA3B18B46C;
	Mon, 24 Feb 2025 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414256; cv=none; b=ih8mEqPiv1SF+m7mR3CSqBP3alHw1QQkI7FrvA8WTY6RyLPUkFE6cQEdVITFpVZVbWRrAUwB24duwr3Ec4ULMNhwIv5ciDLuZtw2KLk6vByNFUZi3fu7Q0B3WAumiuSrosGJy3mHgUA0mje6hkQ/2OaCRxU/0fMIOkxL53A/pDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414256; c=relaxed/simple;
	bh=jh88f9FMyhQG9aI3smhoQsjejSXMGTGNffASA2+8FDU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJlQiULpUWzebJT1k3yge1BfQGJI+Y4LLqRrgCITKqUXX85TFvIgnfsAEKKvmm19Mnf1RpDASTv3rimqNMU9Sh9p0/NBKlGilTsc39zgK6RQ3kPJpOCBe9h1orZ3jUyLMLH1hriy4SUnejnrLIHtHwhhpEfze/9etdEu6RoT13E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CLF47tr8; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 74A9244298;
	Mon, 24 Feb 2025 16:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740414251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6fHqsJjE5FU2HQs1fUAHuBgc7rwcnsg86Qu7M/d+dE=;
	b=CLF47tr8TXZns94jpkQUaOOpx2InLNym8oyc3q/K+kC6WRpjgARcGkFW9l42w9RJbp3sUk
	/OKQ3SHC8RV8iZ+3jve8GgOUR+FK7YRQ6ZDsomC3V7uml9SUZenZEBc5mZPM76/nJflXVE
	4VNoFEeuUEEsAZ9H6xtXftOQ6eJkL8orsw8DaiNPiBAvqeHSHvCJ2RjiXtg+ktdw4AXpii
	3a8lGCUVT8eeJ39IhQXlsrxKBHVIzIiBts9uPwK6iKXOa1qRUETEqcM1M1Y9qOpCLiqOr9
	rKQvRT+QWq8MvckoRzDFO108lhV1LG5J589ILnfKxRl3MDL5uws5RYJxx1FtKA==
Date: Mon, 24 Feb 2025 17:24:07 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
 davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Florian
 Fainelli <f.fainelli@gmail.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Simon Horman <horms@kernel.org>, Romain
 Gantois <romain.gantois@bootlin.com>, Antoine Tenart <atenart@kernel.org>,
 Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: phy: sfp: Add single-byte SMBus SFP
 access
Message-ID: <20250224172407.32a2b3f8@fedora>
In-Reply-To: <Z7x4oxR5_KtyvSYg@shell.armlinux.org.uk>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
	<87r03otsmm.fsf@miraculix.mork.no>
	<Z7uFhc1EiPpWHGfa@shell.armlinux.org.uk>
	<3c6b7b3f-04a2-48ce-b3a9-2ea71041c6d2@lunn.ch>
	<87ikozu86l.fsf@miraculix.mork.no>
	<7c456101-6643-44d1-812a-2eae3bce9068@lunn.ch>
	<Z7x4oxR5_KtyvSYg@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejledvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepfhgvughorhgrpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegsjhhorhhnsehmohhrkhdrnhhopdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgo
 hhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

On Mon, 24 Feb 2025 13:48:19 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Mon, Feb 24, 2025 at 02:31:42PM +0100, Andrew Lunn wrote:
> > > What do you think will be the effect of such a warning?  Who is the
> > > target audience?  
> > 
> > It will act as a disclaimer. The kernel is doing its best with broken
> > hardware, but don't blame the kernel when it does not work
> > correctly....  
> 
> Indeed.
> 
> > > You can obviously add it, and I don't really care.  But I believe the
> > > result will be an endless stream of end users worrying about this scary
> > > warning and wanting to know what they can do about it.  What will be
> > > your answer?  
> > 
> > I agree that the wording needs to be though about. Maybe something
> > like:
> > 
> > This hardware is broken by design, and there is nothing the kernel, or
> > the community can do about it. The kernel will try its best, but some
> > standard SFP features are disabled, and the features which are
> > implemented may not work correctly because of the design errors. Use
> > with caution, and don't blame the kernel when it all goes horribly
> > wrong.  
> 
> I was hoping for something shorter, but I think it needs to be expansive
> so that users can fully understand. Another idea based on your
> suggestion above:
> 
> "Please note:
> This hardware is broken by design. There is nothing that the kernel or
> community can do to fix it. The kernel will try best efforts, but some
> features are disabled, other features may be unreliable or sporadically
> fail. Use with caution. Please verify any problems on hardware that
> supports multi-byte I2C transactions."
> 

I think what's missing in this message is some indication about what is
actually wrong with the hardware, so :

"Please note:
This SFP cage is accessed via an SMBus only capable of single byte
transactions. Some features are disabled, other may be unreliable or
sporadically fail. Use with caution. There is nothing that the kernel
or community can do to fix it, the kernel will try best efforts. Please
verify any problems on hardware that supports multi-byte I2C transactions."

Maxime

