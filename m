Return-Path: <netdev+bounces-54070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794A8805EC7
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 20:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32067281F8C
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 19:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF466ABA1;
	Tue,  5 Dec 2023 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KUgpWwdF"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7063DA5
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 11:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=soPdmCRcIztlx9Qn+p7ZQyp8LgTp6+uQ1GZoBpjgHvA=;
	t=1701805706; x=1703015306; b=KUgpWwdFUnt6SjEzDa8dyL0WP93N3vLpC94ecb5rnwYAByO
	lQASwdg9pGF6xxdEpmPlJ9h44YxxPhrKibhfJQvTPkMm1xC4+QTN4n5bLd409bOMrHVz6yn5vwC19
	cvLuKF3WVVJPcfAmirTBHnvwGbdTHAP6uZzkn8QKy9xtmDuP1ZZUwOL14/nlXZKOJ19OXn1zOUIXy
	r177kzy0j0MNbq5f9jq5qPiT8F3aY06LS4vytbWF4HrtufwqARw9UX/5QgdIxUmJ1e4zG+RCQOzRs
	w+Y8uU9cWwJEKmfiuS0hkzLVAo0bmgNTXYKOf1f5o5L4h9elsg3yLLyJxBRX2+zQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rAbP2-0000000GWku-2LDb;
	Tue, 05 Dec 2023 20:48:20 +0100
Message-ID: <709eff7500f2da223df9905ce49c026a881cb0e0.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] net: ethtool: do runtime PM outside RTNL
From: Johannes Berg <johannes@sipsolutions.net>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
Cc: Marc MERLIN <marc@merlins.org>, Jesse Brandeburg
	 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	intel-wired-lan@lists.osuosl.org, Heiner Kallweit <hkallweit1@gmail.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Tue, 05 Dec 2023 20:48:19 +0100
In-Reply-To: <d0fc7d04-e3c9-47c0-487e-666cb2a4e3bc@intel.com>
References: 
	<20231204200710.40c291e60cea.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
	 <d0fc7d04-e3c9-47c0-487e-666cb2a4e3bc@intel.com>
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

On Tue, 2023-12-05 at 06:19 +0100, Przemek Kitszel wrote:
> On 12/4/23 20:07, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > As reported by Marc MERLIN in [1], at least one driver (igc)
>=20
> perhaps Reported-by tag? (I know this is RFC as of now)

I guess.

> > wants/needs to acquire the RTNL inside suspend/resume ops,
> > which can be called from here in ethtool if runtime PM is
> > enabled.
> >=20
> > [1] https://lore.kernel.org/r/20231202221402.GA11155@merlins.org
> >=20
> > Allow this by doing runtime PM transitions without the RTNL
> > held. For the ioctl to have the same operations order, this
> > required reworking the code to separately check validity and
> > do the operation. For the netlink code, this now has to do
> > the runtime_pm_put a bit later.
> >=20
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > ---
> >   net/ethtool/ioctl.c   | 71 ++++++++++++++++++++++++++----------------=
-
> >   net/ethtool/netlink.c | 32 ++++++++-----------
> >   2 files changed, 56 insertions(+), 47 deletions(-)
> >=20
> Thank you for the patch,
>=20
> I like the idea of split into validate + do for dev_ethtool(),
> what minimizes unneeded PM touching. Moving pm_runtime_get_sync() out of=
=20
> RTNL is also a great improvement per se. Also from the pure coding=20
> perspective I see no obvious flaws in the patch. I think that igc code
> was just accidental to the issue, in a way that it was not deliberate to
> hold RTNL for extended periods.

Well Jakub was arguing igc shouldn't be taking rtnl in suspend/resume,
maybe, but dunno.

> With your patch fixing the bug, there is
> no point with waiting IMO, so
>=20
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Well, according to the checks, the patch really should use
netdev_get_by_name() and netdev_put()? But I don't know how to do that
on short-term stack thing ... maybe it doesn't have to?

johannes

