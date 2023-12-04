Return-Path: <netdev+bounces-53683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B12B8041AB
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 23:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D940B1F210E0
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 22:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948633B798;
	Mon,  4 Dec 2023 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dfOVHmlV"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80754A1
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 14:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bK+byPxsZuHaPYRYQodVTgZI8myAPdyvRrsGFJ0hqUs=;
	t=1701728751; x=1702938351; b=dfOVHmlVeFgdybc2z93NHTAjM/h3IQqzggANhfs7E5ONGVs
	nAwUFxgE33SsK9n/U5jy+XlBKYzQzQ3qLm2TdTT1eq3EI5SkkiCrpdYzugBTyrp8W5rBj2BBLz/H1
	mcFzPfp84KWI42S6TlZI46+ZzCtIK6pg0wng+lzajna2TxrEqIRSnQpOj7l1+SPPQrFDpBMK7Hbqb
	gHkam83Z+tujpFa5UK8vSIGEnJ1Tv+n3wClgByv14WKQMEJLL8m1AB8oOHnRW6RIWDiu5JgiVPEc1
	VeVFEpZMv2wXCWccJmjA5JaI05IcKCypPGYARIzuhhaGH4vC5THnCAR7gX4P2eTA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rAHNr-0000000FIS0-1ZJ1;
	Mon, 04 Dec 2023 23:25:47 +0100
Message-ID: <c4404a84e6490295a8aba37bab7d3152c44ff0ba.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] net: ethtool: do runtime PM outside RTNL
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marc MERLIN <marc@merlins.org>, netdev@vger.kernel.org, Jesse Brandeburg
	 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	intel-wired-lan@lists.osuosl.org, Heiner Kallweit <hkallweit1@gmail.com>
Date: Mon, 04 Dec 2023 23:25:46 +0100
In-Reply-To: <20231204142217.176ed99f@kernel.org>
References: 
	<20231204200710.40c291e60cea.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
	 <20231204200038.GA9330@merlins.org>
	 <a6ac887f7ce8af0235558752d0c781b817f1795a.camel@sipsolutions.net>
	 <20231204203622.GB9330@merlins.org>
	 <24577c9b8b4d398fe34bd756354c33b80cf67720.camel@sipsolutions.net>
	 <20231204205439.GA32680@merlins.org> <20231204212849.GA25864@merlins.org>
	 <69c0fa67c2b0930f72e99c19c72fc706627989af.camel@sipsolutions.net>
	 <20231204142217.176ed99f@kernel.org>
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

On Mon, 2023-12-04 at 14:22 -0800, Jakub Kicinski wrote:
> On Mon, 04 Dec 2023 22:32:25 +0100 Johannes Berg wrote:
> > Well, I was hoping that
> >=20
> >  (a) ethtool folks / Jakub would comment if this makes sense, but I
> >      don't see a good reason to do things the other way around (other
> >      than "code is simpler"); and
>=20
> My opinion on RPM is pretty uneducated. But taking rtnl_lock to resume
> strikes me as shortsighted. RPM functionality should be fairly
> self-contained, and deserving of a separate lock.
> Or at the very least having looked at the igc RPM code in the past,
> I'm a bit cautious about bending the core to fit it, as it is hardly
> a model...

I could agree with that. The reason it seems to do that is that it
invokes some other ifup/down related code in suspend/resume...

On the other hand it also seems a bit odd to do something as unrelated
to networking as runtime PM (which you can also trigger through various
other paths such as sysfs) under RTNL, holding RTNL for longer than
seems necessary, and creating more contention on it?

johannes

