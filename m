Return-Path: <netdev+bounces-54335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38756806ADE
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650171C208D1
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 09:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B43D1A718;
	Wed,  6 Dec 2023 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="R496WGkg"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CBC9C
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 01:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3fntxHKIyKjnSM6vuBVwyvUk6ZAEqyru8xw5RbWoPl0=;
	t=1701855486; x=1703065086; b=R496WGkgUyg2vTrEv9K2Z+xo52I9II3ZI4hUR4oIkxQXnWY
	0rhQdTIO4b79d1xmroMn0s5ml89BABz3nHfNYWnoYb1G5rEmhSAdsvQJz+iHkBakSEThjiVXEulzl
	MAAfyltLZaT5URwf/Tm42LN0jCAMvZolxCKPR9B8XCnZ6UEKQCm1rTtHK/NsLhP+2z5z0x+ILseFO
	TBXtDydxY0dY+/Y1WcE4EG038yQJeBb8sc09wkyXc/sN1PO3Jg8L82WPSnl6KyX8Ueqs6h+5TbduU
	64sQa08oDL92ZiFQPtf57UeoJnxqiewhZChXP478oeYZCO7Ll75SyX+w9R5B5KCQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rAoLt-0000000HY61-2IUs;
	Wed, 06 Dec 2023 10:37:57 +0100
Message-ID: <c1189a1982630f71dd106c3963e0fa71fa6c8a76.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] net: ethtool: do runtime PM outside RTNL
From: Johannes Berg <johannes@sipsolutions.net>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
Cc: Marc MERLIN <marc@merlins.org>, Jesse Brandeburg
	 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	intel-wired-lan@lists.osuosl.org, Heiner Kallweit <hkallweit1@gmail.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Wed, 06 Dec 2023 10:37:56 +0100
In-Reply-To: <3e7ae1f5-77e3-a561-2d6b-377026b1fd26@intel.com>
References: 
	<20231204200710.40c291e60cea.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
	 <d0fc7d04-e3c9-47c0-487e-666cb2a4e3bc@intel.com>
	 <709eff7500f2da223df9905ce49c026a881cb0e0.camel@sipsolutions.net>
	 <3e7ae1f5-77e3-a561-2d6b-377026b1fd26@intel.com>
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

On Wed, 2023-12-06 at 09:46 +0100, Przemek Kitszel wrote:
>=20
> That sounds right too; one could argue if your fix is orthogonal to that
> or not. I would say that your fix makes core net code more robust
> against drivers from past millennia. :)
> igc folks are notified, no idea how much time it would take to propose
> a fix.

Maybe it should be on whoever added runtime pm to ethtool ;-)

Heiner, the igc driver was already doing this when you added
pm_runtime_get_sync() ops, was there a discussion at the time, or just
missed?

I really don't know any of this ...

> > Well, according to the checks, the patch really should use
> > netdev_get_by_name() and netdev_put()? But I don't know how to do that
> > on short-term stack thing ... maybe it doesn't have to?
>=20
> Nice to have such checks :)
> You need some &netdevice_tracker, perhaps one added into struct net
> or other place that would allow to track it at ethtool level.

Yeah but that's dynamic? Seems weird to add something to allocations for
something released in the same function ...

> "short term stack thing" does not relieve us from good coding practices,
> but perhaps "you just replaced __dev_get_by_name() call by
> dev_get_by_name()" to fix a bug would ;) - with transition to tracked
> alloc as a next series to be promised :)

All I want is to know how ;)
but I guess I can try to find examples.

> anyway, I'm fresh here, and would love to know what others think about

Not me, but me too ;-)

johannes

