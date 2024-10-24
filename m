Return-Path: <netdev+bounces-138582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC289AE33B
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 13:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A511F23432
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 11:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541461C4A31;
	Thu, 24 Oct 2024 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="oM8ACwCC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XmqD9Nim"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203251C9ECD
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 11:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767742; cv=none; b=OJ18rA7l4l3A6+FT85zWIgQdRIX7xMqaqfIkQREmsvcTCVT4ecg4eVBv1Jg43p8J+7GKgPWxhrJcujVbRxdrruQFfxJ2E2A9CqjZZEBSUmN8L4TS3Og+Jig6nAJQZNbDo7LcApvChKh0/ch6pvHlqHEer1qs+aiwamInas1L1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767742; c=relaxed/simple;
	bh=jojXZXqVAoeJiiE0qE5SBA6J6/tjFaOx8MsDaM22Qhc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=P9t23bqqP7tQvdMvrbFIXL5VcaiOTAi9bN7mFm01uBGEoVz7UUaTf7+6OrUBvxKLYdk8zcO8K/kxCNs0OQ6JVf1FN2e+CurZGgDZf5Ns9wfH0HbTGNiVoqIjvBfV0Ec84ZBBtnaOE6E6F1h9yzIk6mxzRlHgoAtITOOHotnIkqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=oM8ACwCC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XmqD9Nim; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 16D811380261
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 07:02:18 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Thu, 24 Oct 2024 07:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1729767738;
	 x=1729854138; bh=jojXZXqVAoeJiiE0qE5SBA6J6/tjFaOx8MsDaM22Qhc=; b=
	oM8ACwCCb7FsbrllY+c7vQpxQZqe1w4v8HZfqMXY8yqVjdUQyTMUP889pKfff+Hz
	ONBvQZzaXjDRkICo0ic87bZPoc2dKE+ztrMDMaYoSmO316BEgBbAvBm4vgxqGBgz
	PRRMNUggkVQ04ikqVkB38U4YlO7JNMjwCL8xxd210pOTSgYRZUOBcrHZK0okKYg3
	jmM7o/YAC7wLNWxCLL3JBh8ZqLb083okFde4WOx9Sel6O5s2ogXbKZgukUBIK26i
	E0GvK3KoaJl4wGa84t3+huYHqAIMsU2oEUF2of6l5jkES1OG6ymO1FvSG3REa+Md
	CyNxbkKl7fZPO/1/QPArHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729767738; x=
	1729854138; bh=jojXZXqVAoeJiiE0qE5SBA6J6/tjFaOx8MsDaM22Qhc=; b=X
	mqD9Nim59d7YaftEK7NL4KgnQQ/FcGznsrT7EEB4wZWmSjbvtewhW/CAOuxxW2n3
	4PBGHxWC+X1IJ1FADGPlqJ5T9R1A0xoaipymWnfbbsIam/2p/0dJULOtckgFuY9d
	NCtGLA+FQjsJMmMh8yPc1kG2IdhgGk/smnQd1li9PDsn/CuCr8EgqLa7OqbHbgUX
	APIHdrTLfAwZhAMMmstGrdudxFfBV6A4kIBJLLuPeomLXwi99a7EEeY9dUTr5Bc6
	VIxOzKiOdIa72rTJcWEk7rChxPO2eihod5jyQjbyeW7AMPJaJAdczJyzBbiYLudb
	3dDZrI3v3QM0ViXUzWkMg==
X-ME-Sender: <xms:OSkaZ5UupfzLB_4b71c2KagGdgb7SPxzOZUX4x6EE28oZSPlKFf6Rw>
    <xme:OSkaZ5nPgGkHj-Z9qIbpZHRKdr4rzqYyy4oYRiAcdPSyogcWu0g0MoZ52lgvmua1P
    ErPR30YdPEoqs3-S6I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
    hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeet
    hefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
    thdrtghomhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:OSkaZ1YyyKx0TpyfuP6GwwghbwbIvnaVgK2bjaSAcvdd5WT_3gLang>
    <xmx:OSkaZ8Ueoq69qSCsQDV9RtrP09qOr7kWcgxAWS2e2ff62MHL9mgJ3w>
    <xmx:OSkaZznci3JuyenKkKS8hpSiW6lYTuGhiuC6dXl5s2s44e7Je7R--Q>
    <xmx:OSkaZ5eW2mDvag30QFomfBFadM0CO8s_pOaqWRMoGSye_xBGK-mndw>
    <xmx:OikaZysEzXW5s8f4lwyyzopqxeQzt4TuhUYpWV9SjVroZ1jMJp1tcthO>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B60F31C20066; Thu, 24 Oct 2024 07:02:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Oct 2024 12:01:36 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Serge Semin" <fancer.lancer@gmail.com>, "Jon Mason" <jdmason@kudzu.us>,
 "Dave Jiang" <dave.jiang@intel.com>, "Allen Hubbe" <allenbh@gmail.com>,
 ntb@lists.linux.dev, "Andy Shevchenko" <andy@kernel.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Kory Maincent" <kory.maincent@bootlin.com>,
 "Cai Huoqing" <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org,
 "Mark Brown" <broonie@kernel.org>, linux-spi@vger.kernel.org,
 "Damien Le Moal" <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 "paulburton@kernel.org" <paulburton@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Arnd Bergmann" <arnd@arndb.de>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 "Yoshihiro Shimoda" <yoshihiro.shimoda.uh@renesas.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Andrew Lunn" <andrew@lunn.ch>, "Russell King" <linux@armlinux.org.uk>,
 "Vladimir Oltean" <olteanv@gmail.com>,
 "Kelvin Cheung" <keguang.zhang@gmail.com>,
 "Yanteng Si" <siyanteng@loongson.cn>, netdev@vger.kernel.org,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Guenter Roeck" <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
 "Borislav Petkov" <bp@alien8.de>, linux-edac@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-serial@vger.kernel.org
Cc: "Andrew Halaney" <ajhalaney@gmail.com>, "Nikita Travkin" <nikita@trvn.ru>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Alexander Shiyan" <shc_work@mail.ru>, "Dmitry Kozlov" <xeb@mail.ru>,
 "Sergey Shtylyov" <s.shtylyov@omp.ru>,
 "Evgeniy Dushistov" <dushistov@mail.ru>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Sergio Paracuellos" <sergio.paracuellos@gmail.com>,
 "Nikita Shubin" <nikita.shubin@maquefel.me>,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <91609bd7-da45-4fea-9e23-91e5f85b3c05@app.fastmail.com>
In-Reply-To: 
 <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
Subject: Re: linux: Goodbye from a Linux community volunteer
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B410=E6=9C=8824=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8A=
=E5=8D=885:27=EF=BC=8CSerge Semin=E5=86=99=E9=81=93=EF=BC=9A
> Hello Linux-kernel community,
>
> I am sure you have already heard the news caused by the recent Greg' c=
ommit
> 6e90b675cf942e ("MAINTAINERS: Remove some entries due to various compl=
iance
> requirements."). As you may have noticed the change concerned some of =
the
> Ru-related developers removal from the list of the official kernel mai=
ntainers,
> including me.
>
> The community members rightly noted that the _quite_ short commit log =
contained
> very vague terms with no explicit change justification. No matter how =
hard I
> tried to get more details about the reason, alas the senior maintainer=
 I was
> discussing the matter with haven't given an explanation to what compli=
ance
> requirements that was. I won't cite the exact emails text since it was=
 a private
> messaging, but the key words are "sanctions", "sorry", "nothing I can =
do", "talk
> to your (company) lawyer"... I can't say for all the guys affected by =
the
> change, but my work for the community has been purely _volunteer_ for =
more than
> a year now (and less than half of it had been payable before that). Fo=
r that
> reason I have no any (company) lawyer to talk to, and honestly after t=
he way the
> patch has been merged in I don't really want to now. Silently, behind =
everyone's
> back, _bypassing_ the standard patch-review process, with no affected
> developers/subsystem notified - it's indeed the worse way to do what h=
as been
> done. No gratitude, no credits to the developers for all these years o=
f the
> devoted work for the community. No matter the reason of the situation =
but
> haven't we deserved more than that? Adding to the GREDITS file at leas=
t, no?..
>
> I can't believe the kernel senior maintainers didn't consider that the=20
> patch
> wouldn't go unnoticed, and the situation might get out of control with
> unpredictable results for the community, if not straight away then in=20
> the middle
> or long term perspective. I am sure there have been plenty ways to=20
> solve the
> problem less harmfully, but they decided to take the easiest path. Ala=
s=20
> what's
> done is done. A bifurcation point slightly initiated a year ago has=20
> just been
> fully implemented. The reason of the situation is obviously in the=20
> political
> ground which in this case surely shatters a basement the community has=20
> been built
> on in the first place. If so then God knows what might be next (who=20
> else might
> be sanctioned...), but the implemented move clearly sends a bad signal=20
> to the
> Linux community new comers, to the already working volunteers and=20
> hobbyists like
> me.

Hi Serge,

I was shocked by the way senior maintainers handle that patch when peopl=
e put it
under my radar. Then I scroll down it and see all those familiar names i=
ncluding
Sergey Shtylyov and you...

This is certainly not the way things should be done. Even if legal requi=
rements
necessitate the action, there are far better ways to handle it. Instead,=
 the most
absurd and shameful option has been chosen.

It's deeply disappointing to me that, when doubts were raised about the =
process,
Linus resorted to personal attacks rather than addressing our concerns. =
As a hobbyist
driven by the ideals of free software, with Linus as a role model, I now=
 find myself
questioning my own beliefs.

Where are we going? Where should we go?

>
[...]
>
> Paul, Thomas, Arnd, Jiaxun, we met several times in the mailing list d=
uring my
> MIPS P5600 patches and just generic MIPS patches review. It was always=
 a
> pleasure to discuss the matters with such brilliant experts in the fie=
ld. Alas
> I've spent too much time working on the patches for another subsystems=
 and
> failed to submit all the MIPS-related bits. Sorry I didn't keep my pro=
mise, but
> as you can see the circumstances have suddenly drawn its own deadline.

Thank you, Serge. It's always a pleasure working with you. Your professi=
onalism has
been truly impressive, and our discussions were consistently constructiv=
e. I
especially appreciate how your bug reports and review comments are alway=
s backed by
detailed reasoning, it really stood out to me.

You'll be missed. I'll see what I can do here for your work on MIPS.

>
[...]
>
> Hope we'll meet someday in more pleasant circumstances and drink a
> couple or more beers together. But now it's time to say good bye.
> Sorry for a long-read text. I wish good luck on your Linux-way.

I'm happy to have a pint with you if we can meet someday.

For now, take care.

Thanks
>
> Best Regards,
> -Serge(y)

--=20
- Jiaxun

