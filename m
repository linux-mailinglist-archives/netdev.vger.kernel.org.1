Return-Path: <netdev+bounces-42536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570E77CF3AC
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 11:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D01E2B20D49
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 09:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9247168CD;
	Thu, 19 Oct 2023 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A831168A3
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 09:12:41 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC1212D
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 02:12:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qtP4v-0001No-Cs; Thu, 19 Oct 2023 11:12:29 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1qtP4u-002kgS-6v; Thu, 19 Oct 2023 11:12:28 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qtP4u-00FFUF-4A; Thu, 19 Oct 2023 11:12:28 +0200
Date: Thu, 19 Oct 2023 11:12:28 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] ethtool: fix clearing of WoL flags
Message-ID: <20231019091228.GA3632494@pengutronix.de>
References: <20231019070904.521718-1-o.rempel@pengutronix.de>
 <20231019090510.bbcmh7stzqqgchdd@lion.mk-sys.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231019090510.bbcmh7stzqqgchdd@lion.mk-sys.cz>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Oct 19, 2023 at 11:05:10AM +0200, Michal Kubecek wrote:
> On Thu, Oct 19, 2023 at 09:09:04AM +0200, Oleksij Rempel wrote:
> > With current kernel it is possible to set flags, but not possible to re=
move
> > existing WoL flags. For example:
> > ~$ ethtool lan2
> > ...
> >         Supports Wake-on: pg
> >         Wake-on: d
> > ...
> > ~$ ethtool -s lan2 wol gp
> > ~$ ethtool lan2
> > ...
> >         Wake-on: pg
> > ...
> > ~$ ethtool -s lan2 wol d
> > ~$ ethtool lan2
> > ...
> >         Wake-on: pg
> > ...
> >=20
> > This patch makes it work as expected
> >=20
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  net/ethtool/wol.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/net/ethtool/wol.c b/net/ethtool/wol.c
> > index 0ed56c9ac1bc..fcefc1bbfa2e 100644
> > --- a/net/ethtool/wol.c
> > +++ b/net/ethtool/wol.c
> > @@ -108,15 +108,16 @@ ethnl_set_wol(struct ethnl_req_info *req_info, st=
ruct genl_info *info)
> >  	struct net_device *dev =3D req_info->dev;
> >  	struct nlattr **tb =3D info->attrs;
> >  	bool mod =3D false;
> > +	u32 wolopts =3D 0;
> >  	int ret;
> > =20
> >  	dev->ethtool_ops->get_wol(dev, &wol);
> > -	ret =3D ethnl_update_bitset32(&wol.wolopts, WOL_MODE_COUNT,
> > +	ret =3D ethnl_update_bitset32(&wolopts, WOL_MODE_COUNT,
> >  				    tb[ETHTOOL_A_WOL_MODES], wol_mode_names,
> >  				    info->extack, &mod);
> >  	if (ret < 0)
> >  		return ret;
> > -	if (wol.wolopts & ~wol.supported) {
> > +	if (wolopts & ~wol.supported) {
> >  		NL_SET_ERR_MSG_ATTR(info->extack, tb[ETHTOOL_A_WOL_MODES],
> >  				    "cannot enable unsupported WoL mode");
> >  		return -EINVAL;
> > @@ -132,8 +133,9 @@ ethnl_set_wol(struct ethnl_req_info *req_info, stru=
ct genl_info *info)
> >  				    tb[ETHTOOL_A_WOL_SOPASS], &mod);
> >  	}
> > =20
> > -	if (!mod)
> > +	if (!mod && wolopts =3D=3D wol.wolopts)
> >  		return 0;
> > +	wol.wolopts =3D wolopts;
> >  	ret =3D dev->ethtool_ops->set_wol(dev, &wol);
> >  	if (ret)
> >  		return ret;
> > --=20
> > 2.39.2
>=20
> This doesn't look right, AFAICS with this patch, the resulting WoL flags
> would not depend on current values at all, i.e. it would certainly break
> non-absolute commands like
>=20
>   ethtool -s eth0 wol +g
>   ethtool -s eth0 wol -u+g
>   ethtool -s etho wol 32/34

Wow, I have learned something new :)

> How recent was the kernel where you encountered the issue?

It is latest net-next.

> I suspect the
> issue might be related to recent 108a36d07c01 ("ethtool: Fix mod state
> of verbose no_mask bitset"), I'll look into it closer.

Thx!

Regards,
Oleksij
--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

