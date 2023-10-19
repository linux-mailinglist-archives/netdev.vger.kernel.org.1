Return-Path: <netdev+bounces-42641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0597CFAF4
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3BF2B20B4C
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE71227453;
	Thu, 19 Oct 2023 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MV7QCSQ1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD11DDA6
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 13:27:47 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D09C112;
	Thu, 19 Oct 2023 06:27:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 274A460007;
	Thu, 19 Oct 2023 13:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1697722065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tb30KokhMfhJFg4x7SAE9KT+pO7hqq9T0nfilt18P3g=;
	b=MV7QCSQ1J88BtyakxCd7vSwceC0N69+8kKIiYqzwgw7dzB5U11hLTrmGq/4UbsqVWR+yWA
	i+0rHiSEuSyznUvi+jJNhdk455Bg6rc9Qu0r5+c5fZkKv8dgQMxAJqb5uMJAAXeAkjN9t9
	NDQb6gxEmI61qG4SeuZBEffFToiQVuAvNFMrF1fF/LFfacEpkAeDAJWk1e6MHRd1xG2wHH
	6lchYuSz65Dh5x4xMQbCbxwW79/cHVyNcPLm+iylS+Ez8pw763cCHoT2+ZOVA0y4phOkkA
	IVm3Zp6ozPuXj6Rm2aX0Ne5mFr8glYJCzA5zqvx18Ze5lD8LXWL6GFvbdTARVQ==
Date: Thu, 19 Oct 2023 15:27:43 +0200
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vladimir
 Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] ethtool: fix clearing of WoL flags
Message-ID: <20231019152743.09b28ef4@kmaincent-XPS-13-7390>
In-Reply-To: <20231019105048.l64jp2nd46fxjewt@lion.mk-sys.cz>
References: <20231019070904.521718-1-o.rempel@pengutronix.de>
	<20231019090510.bbcmh7stzqqgchdd@lion.mk-sys.cz>
	<20231019095140.l6fffnszraeb6iiw@lion.mk-sys.cz>
	<20231019122114.5b4a13a9@kmaincent-XPS-13-7390>
	<20231019105048.l64jp2nd46fxjewt@lion.mk-sys.cz>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 19 Oct 2023 12:50:48 +0200
Michal Kubecek <mkubecek@suse.cz> wrote:

> On Thu, Oct 19, 2023 at 12:21:14PM +0200, K=C3=B6ry Maincent wrote:
> > On Thu, 19 Oct 2023 11:51:40 +0200 > Michal Kubecek <mkubecek@suse.cz>
> > wrote: =20
> > >=20
> > > The issue was indeed introduced by commit 108a36d07c01 ("ethtool: Fix
> > > mod state of verbose no_mask bitset"). The problem is that a "no mask"
> > > verbose bitset only contains bit attributes for bits to be set. This
> > > worked correctly before this commit because we were always updating
> > > a zero bitmap (since commit 6699170376ab ("ethtool: fix application of
> > > verbose no_mask bitset"), that is) so that the rest was left zero
> > > naturally. But now the 1->0 change (old_val is true, bit not present =
in
> > > netlink nest) no longer works. =20
> >=20
> > Doh I had not seen this issue! Thanks you for reporting it.
> > I will send the revert then and will update the fix for next merge-wind=
ow. =20
>=20
> Something like the diff below (against current mainline) might do the
> trick but it's just an idea, not even build tested.

Seems a good idea without adding too much complexity to the code.
Will try that and send it in next merge window.

K=C3=B6ry

