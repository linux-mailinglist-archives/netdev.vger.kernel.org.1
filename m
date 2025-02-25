Return-Path: <netdev+bounces-169318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CAEA436FE
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3C9188971C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 08:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5622580F4;
	Tue, 25 Feb 2025 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UFc+8kXi"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2326721577D;
	Tue, 25 Feb 2025 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470945; cv=none; b=rL9vpfOMSAW0eoBgL5EHNhET7uRYvoe+KaE2dWp3smmOCokz1JuQDaXehU1V8nT95YS3l/Mx/y8RcTJ0n+M3d3LgCQlMADlcoiknynSg3jl7qNvWoohhI70tV0MNpns1687XQQar+BDXCM+J/9ieZ/u+bBW/tMD3Xweqb73z1uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470945; c=relaxed/simple;
	bh=if/K5ifJjQhGo9fJAHtECjgZfMv5sn7c240Wxr1rsio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHRXO5wfW/R9AQX46Q5jEpUt/aGScqro/VsLXSIhZ5GZVh60su+Z5XFW8cpC7hM+FSnc3mZtwZ7eWXRg5TaFCiM3EGYQJ674cOsvM23LkkfP5lGUN0Fj+tP+JAwxbt6MH0/pZMNc69VJMR4tjrmfFmfZ/39sBec/mdkRIZMIpWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UFc+8kXi; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 40EB12047A;
	Tue, 25 Feb 2025 08:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740470941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ri51JMHrUhsyawDrOSXF+WzWQ8+V6f2roN/j/66SbI=;
	b=UFc+8kXijIJ/vi7zxnkNkRIzfmWZ7pnrziCRqHE8qfs2iLJxD8wIR66Z/Ym1V7odS7ky7w
	Mak7jwgVTdgOMPyEvig0rQn9+xrfErJGhMo0LTDB7XekV3Bdr+i4moz81Sabov+jR6Bpl/
	BWCtj2gLtbXSyL5thGbpqFTwP1wWOfpTGrpjwkBVdElQ4868XmfilTLWc07c9dz61d9LZ7
	BhnJbJLoEcgiAG00Mj4AArpufJbo4Djsn2/b8jfw/IYih/H6cMzxYsEuiqwFV/j5wwvdWT
	2ZBqP5mqAfLviIGq8waUgTAiadwDQIBajJo1Zprfrng5IGyZ1OgWaKeFpQ/+6Q==
Date: Tue, 25 Feb 2025 09:08:58 +0100
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
Message-ID: <20250225090858.0d07cc24@fedora.home>
In-Reply-To: <20250224172407.32a2b3f8@fedora>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
	<87r03otsmm.fsf@miraculix.mork.no>
	<Z7uFhc1EiPpWHGfa@shell.armlinux.org.uk>
	<3c6b7b3f-04a2-48ce-b3a9-2ea71041c6d2@lunn.ch>
	<87ikozu86l.fsf@miraculix.mork.no>
	<7c456101-6643-44d1-812a-2eae3bce9068@lunn.ch>
	<Z7x4oxR5_KtyvSYg@shell.armlinux.org.uk>
	<20250224172407.32a2b3f8@fedora>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddulecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepsghjohhrnhesmhhorhhkrdhnohdprhgtphhtthhopegurghvv
 ghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Mon, 24 Feb 2025 17:24:07 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> On Mon, 24 Feb 2025 13:48:19 +0000
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > On Mon, Feb 24, 2025 at 02:31:42PM +0100, Andrew Lunn wrote:  
> > > > What do you think will be the effect of such a warning?  Who is the
> > > > target audience?    
> > > 
> > > It will act as a disclaimer. The kernel is doing its best with broken
> > > hardware, but don't blame the kernel when it does not work
> > > correctly....    
> > 
> > Indeed.
> >   
> > > > You can obviously add it, and I don't really care.  But I believe the
> > > > result will be an endless stream of end users worrying about this scary
> > > > warning and wanting to know what they can do about it.  What will be
> > > > your answer?    
> > > 
> > > I agree that the wording needs to be though about. Maybe something
> > > like:
> > > 
> > > This hardware is broken by design, and there is nothing the kernel, or
> > > the community can do about it. The kernel will try its best, but some
> > > standard SFP features are disabled, and the features which are
> > > implemented may not work correctly because of the design errors. Use
> > > with caution, and don't blame the kernel when it all goes horribly
> > > wrong.    
> > 
> > I was hoping for something shorter, but I think it needs to be expansive
> > so that users can fully understand. Another idea based on your
> > suggestion above:
> > 
> > "Please note:
> > This hardware is broken by design. There is nothing that the kernel or
> > community can do to fix it. The kernel will try best efforts, but some
> > features are disabled, other features may be unreliable or sporadically
> > fail. Use with caution. Please verify any problems on hardware that
> > supports multi-byte I2C transactions."
> >   
> 
> I think what's missing in this message is some indication about what is
> actually wrong with the hardware, so :

I realise that I have formulated the sentence above a bit strongly, of
course this is a suggestion :)

> "Please note:
> This SFP cage is accessed via an SMBus only capable of single byte
> transactions. Some features are disabled, other may be unreliable or
> sporadically fail. Use with caution. There is nothing that the kernel
> or community can do to fix it, the kernel will try best efforts. Please
> verify any problems on hardware that supports multi-byte I2C transactions."

Maxime

