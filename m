Return-Path: <netdev+bounces-158444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3689A11E4E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64BF47A2768
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C87248190;
	Wed, 15 Jan 2025 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fP0cJayf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C81248175
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934105; cv=none; b=RIcrBHj7AWkliaEOMLCVF6Mqvqh2j/0hlPaxO2npF7v8JBPunZ7cjjCTSkiiEd4t4+ePhx5NAwPi31VIS+hNcWF0OQRfp55+Ji5dLYqaV2uWHHwqDBk69UT19xvCx7anxx5nI1Vq0Em/b+w2D533lb0nyaHxFQ7uipThRIQuwXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934105; c=relaxed/simple;
	bh=l3txeSlMTgVPcOkEEADyL+vNbALUEuMnXD4No/xauOQ=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=uDc7AEIMgU14kg0+xmYLyGIdPePdPIao+gFly44izxai76tTMmQ/AsZNdtGo3LuiONgRQrEhn8pc/qcr5zEXjenvo0/2CarYBynXnERDCAHNBaQtH/EcbblbYe5NeZMei6ZEcEwgbeSTRkx3UexwN5vC/c/hh3bvwrKaqn9rFmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fP0cJayf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F0CC4CEE1;
	Wed, 15 Jan 2025 09:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736934105;
	bh=l3txeSlMTgVPcOkEEADyL+vNbALUEuMnXD4No/xauOQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=fP0cJayfgJwGnhpE6tiSdX3U4CAxerAjeysC+8f2McnXzYdOlTZTZMei8QnbTVSYM
	 FUlm7njmLwokObJNkP75LBuKGPYaSFNp7RbTYV1aieFAiqOOZ9UWQyO+XoJM+oQgTA
	 ulKw8LZTczE+2PCqrW7TjDLQBjsKuQvgW3ABfRqNN8Jm9edBhUUSCg6+YCxvvrHWzh
	 FM8dd4driL93km51hqhOPbqJpuEtBvGCclYaj3VFdVqIpxWJXBoiQeXpTiqUie0YlG
	 zitfu1RReOZmP2IXKcnVROdYc5iWEYyNHorL88NuH2dbOUCCAj4K7mNqAnlENM14u3
	 tcSGcPlOrLe1A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f87576e0-93d2-42fe-a6da-09430386bc16@gmail.com>
References: <20250113161842.134350-1-atenart@kernel.org> <20250114112401.545a70f7@kernel.org> <f87576e0-93d2-42fe-a6da-09430386bc16@gmail.com>
Subject: Re: [PATCH net] net: avoid race between device unregistration and set_channels
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org
To: Edward Cree <ecree.xilinx@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Date: Wed, 15 Jan 2025 10:41:41 +0100
Message-ID: <173693410183.5893.12485926901643155644@kwain>

Quoting Edward Cree (2025-01-15 03:51:12)
> On 14/01/2025 19:24, Jakub Kicinski wrote:
> > On Mon, 13 Jan 2025 17:18:40 +0100 Antoine Tenart wrote:
> >> This is because unregister_netdevice_many_notify might run before
> >> set_channels (both are under rtnl).=20
> >=20
> > But that is very bad, not at all sane. The set call should not proceed
> > once dismantle begins.
> >=20
> > How about this?
> >=20
> > diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c index 849c98=
e637c6..913c8e329a06 100644
> > --- a/net/ethtool/netlink.c
> > +++ b/net/ethtool/netlink.c
> > @@ -90,7 +90,7 @@ int ethnl_ops_begin(struct net_device *dev)
> >                 pm_runtime_get_sync(dev->dev.parent);
> > =20
> >         if (!netif_device_present(dev) ||
> > -           dev->reg_state =3D=3D NETREG_UNREGISTERING) {
> > +           dev->reg_state > NETREG_REGISTERED) {
> >                 ret =3D -ENODEV;
> >                 goto err;
> >         }
> >=20
>=20
> Would __dev_ethtool() need a similar check?

It doesn't because it calls __dev_get_by_name() and returns -ENODEV in
case dismantle started.

