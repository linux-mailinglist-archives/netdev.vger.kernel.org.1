Return-Path: <netdev+bounces-54515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B02D807598
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B30E1C20E36
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3DC4174D;
	Wed,  6 Dec 2023 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XIUBe3FK"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B68D3
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 08:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gif9H/KLcqsX3MuaBXoiTinMz7E92DV79n/bHsXC3Yk=;
	t=1701881176; x=1703090776; b=XIUBe3FKrMz5puyxSHyYnk7u5hWWxZ8Qv0r0/4ZgiG1ob3C
	1Fe99a5bSSwbmNqTBLp3r6hDhd0uYr1LvR+NTrIQtO4Gqk1DdA3ARqO9SuuZjO7hY9WFVptecHdXH
	03Kd53zOD5RkI0rNbHWfxLNzEnY+KjRj5ZR+BEAAmRyQpAArSK51DJzEws+34hWFyRfb7xarTsTP9
	TBDEDOGieNbNksyHGNZCVcEcQEeXoIhzbCR0esCCLDty5gZXXaDgMyF+sH+pG7F9OnTOugi/Ucdl4
	wolWnpYc0S0y95iE+dVRVHbkpCYjq1aADsnxPcdusGIqdTBCkZj60G+3NovHhDbw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rAv2G-00000000Abj-34Fk;
	Wed, 06 Dec 2023 17:46:09 +0100
Message-ID: <e6f227ee701e1ee37e8f568b1310d240a2b8935a.camel@sipsolutions.net>
Subject: Re: [PATCH net v3] net: ethtool: do runtime PM outside RTNL
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, Marc
 MERLIN <marc@merlins.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Wed, 06 Dec 2023 17:46:07 +0100
In-Reply-To: <20231206084448.53b48c49@kernel.org>
References: 
	<20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
	 <20231206084448.53b48c49@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2023-12-06 at 08:44 -0800, Jakub Kicinski wrote:
> On Wed,  6 Dec 2023 11:39:32 +0100 Johannes Berg wrote:
> > As reported by Marc MERLIN, at least one driver (igc) wants or
> > needs to acquire the RTNL inside suspend/resume ops, which can
> > be called from here in ethtool if runtime PM is enabled.
> >=20
> > Allow this by doing runtime PM transitions without the RTNL
> > held. For the ioctl to have the same operations order, this
> > required reworking the code to separately check validity and
> > do the operation. For the netlink code, this now has to do
> > the runtime_pm_put a bit later.
>=20
> I was really, really hoping that this would serve as a motivation
> for Intel to sort out the igb/igc implementation. The flow AFAICT
> is ndo_open() starts the NIC, the calls pm_sus, which shuts the NIC
> back down immediately (!?) then it schedules a link check from a work
> queue, which opens it again (!?). It's a source of never ending bugs.
>=20

Well, I work there, but ... WiFi something else entirely. Marc just got
lucky I spotted an issue in the logs ;-)

I'll let you guys take it from here ...

johannes

