Return-Path: <netdev+bounces-224497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E286BB858CA
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A65B582FF8
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F021241664;
	Thu, 18 Sep 2025 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="ldjrcqNK"
X-Original-To: netdev@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3202216E23;
	Thu, 18 Sep 2025 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208762; cv=none; b=mgc8fMrLkUh4/JZjw0qCAzcnoeBkVXDPYtu4a7PUFsX7RQ5VuyrSnNfrUeF5k1LKI3BXGiZZPidJIsIomiklr85TVgd0imv7yHTbSWoly89V6ytFxCQOeVQ0bR/VhFdIUG5+/0mmnQdZXlMpRtIkmf8hz7jzqpfiYCOuSQyCj+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208762; c=relaxed/simple;
	bh=ODKeyvBG1vBr+X5ZJl7s3aq1FEz5JDOLGucdV3c5Eqg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gPERhDfu+GZ5IgiCe8AKZQH589BKcuDK1tZypLocKcicoebsdfOg8GHPtV94tW8NwzQ8HKamDUMk+82Mn5sevi7HoON5eAIM3oif6WcgWbFUQHMeHbdgP2cwNIW/pnQ9sjLa2FNlBCvXZRWsThtAsLoQHETET0VhlasfVO1hxKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=ldjrcqNK; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from ehlo.thunderbird.net (ip-109-43-113-85.web.vodafone.de [109.43.113.85])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id A67753B0;
	Thu, 18 Sep 2025 17:11:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1758208311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODKeyvBG1vBr+X5ZJl7s3aq1FEz5JDOLGucdV3c5Eqg=;
	b=ldjrcqNKd/wlUw9uYe2QvZAMnXr+wunB/3oGFizlVFUwzwsNFh0KXvHzv2rRbYnrpeZHWX
	F2YvYdkbLBos5RJi8c+M2SMrxW6FJDmiQiejkBB6PS+TQRfKtiijCoiZIon1IKnNXDOC9d
	ZEFst0UKYM3l7ojpslLqxRM2y72CbSg++odxfsJfrd8BpNjhVP43lvOH6AvqDJb0E+vgav
	ZZx8oVblyiylZNHkSaZtEBJyCHVIYNzcv78OEAERzCfHfvsnW4jiuNo/9Zspf47iEdQ675
	5aLk9tzWpltzbPQ8kNO7PZmOa9LJNx9l5yLsbwx5RAV7w1RSO0NlwmqevIwgVw==
Date: Thu, 18 Sep 2025 17:11:50 +0200
From: Michael Walle <michael@walle.cc>
To: Jakub Kicinski <kuba@kernel.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC: Michael Walle <mwalle@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Andrew Lunn <andrew@lunn.ch>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Roger Quadros <rogerq@kernel.org>,
 Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next=5D_Rev?=
 =?US-ASCII?Q?ert_=22net=3A_ethernet=3A_ti=3A_a?=
 =?US-ASCII?Q?m65-cpsw=3A_fixup_PHY_mode_for_fixed_RGMII_TX_delay=22?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250918075651.4676f808@kernel.org>
References: <20250728064938.275304-1-mwalle@kernel.org> <57823bd1-265c-4d01-92d9-9019a2635301@lunn.ch> <DBOD5ICCVSL1.23R4QZPSFPVSM@kernel.org> <d9b845498712e2372967e40e9e7b49ddb1f864c1.camel@ew.tq-group.com> <DBOEPHG2V5WY.Q47MW1V5ZJZE@kernel.org> <2269f445fb233a55e63460351ab983cf3a6a2ed6.camel@ew.tq-group.com> <88972e3aa99d7b9f4dd1967fbb445892829a9b47.camel@ew.tq-group.com> <84588371-ddae-453e-8de9-2527c5e15740@lunn.ch> <47b0406f-7980-422e-b63b-cc0f37d86b18@ti.com> <DBTGZGPLGJBX.32VALG3IRURBQ@kernel.org> <804f394db1151f1fb1f19739d5347b38a3930e8a.camel@ew.tq-group.com> <20250918075651.4676f808@kernel.org>
Message-ID: <734CD0B0-9104-45C8-A8E5-679FC7B7A346@walle.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

[reply all this time=2E=2E]=20

Am 18=2E September 2025 16:56:51 MESZ schrieb Jakub Kicinski <kuba@kernel=
=2Eorg>:
>On Mon, 04 Aug 2025 15:45:08 +0200 Matthias Schiffer wrote:
>> > > Disabling the TX delay may or may not result in an operational syst=
em=2E
>> > > This holds true for all SoCs with various CPSW instances that are
>> > > programmed by the am65-cpsw-nuss=2Ec driver along with the phy-gmii=
-sel=2Ec
>> > > driver=2E =20
>> >=20
>> > In that case u-boot shall be fixed, soon=2E And to workaround older
>> > u-boot versions, linux shall always enable that delay, like Andrew
>> > proposed=2E =20
>>=20
>> I can submit my patch for U-Boot some time this week, probably tomorrow=
=2E Do you
>> also want me to take care of the Linux side for enabling the MAC delay?
>
>What's the conclusion with this regression?
>If we need a fix in Linux it'd be great to have it before v6=2E17 is cut=
=2E

Sorry I'm on mobile, so I can't use my korg account=2E

But on the linux side this is fixed by the following patch:
https://lore=2Ekernel=2Eorg/all/20250819065622=2E1019537-1-mwalle@kernel=
=2Eorg/

You can close this in pw (if that's still in a pending state)=2E

Thanks for taking care and sorry I haven't mentioned the follow-up patch h=
ere=2E=20

-michael

