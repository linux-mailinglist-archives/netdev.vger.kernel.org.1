Return-Path: <netdev+bounces-158900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B69A13B15
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308333A72EC
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292051DED5F;
	Thu, 16 Jan 2025 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEl39Gyg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017E61DED47
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035228; cv=none; b=PaZ4YU0rlllxe98xeyEp7UmN/ds2KLKKn1fXJ1haDRADbbJfn9zWkeo/WXuc2J/wxB/D+fnIkqy89fCcwDKWOdRS+za/degCeK72y3IGGWw/LarvWlXP6H0hNT7lp5csa/UGu8NqXuPGiXrp10e4J5rNbKkLWLdZZ+sH0B2+Uw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035228; c=relaxed/simple;
	bh=GzpjaNnpeXX9aF6Ub+xwlVop4BR6NwUKODqJzXY2tnc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=AdlpJ22EegHIl8+R4SmS36/sInXy+OoJGMfdwiBjtfIHDPgTls9Hx/AAJwEL3lXrxgEyU8CWon9QMNPqlT/z5AolQ8hx86MT3NIMyQE1qQPak4viSQhZeI/V4KL3aMF3RCXjKpU9qrUICRLu3eHlZhFU7Rq+oyUZzqcp0dFBWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEl39Gyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23293C4CEE1;
	Thu, 16 Jan 2025 13:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737035226;
	bh=GzpjaNnpeXX9aF6Ub+xwlVop4BR6NwUKODqJzXY2tnc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=VEl39GygvggpFvHdNVfU+6XJ8RQqZfSqNYPHvQYoHqbdGqUactn5UAJEdrH18HWsL
	 90mXAriRC2G5NTdWJOTvYCcgm2xcJ4pZOEYGO+YDctF7Tqgi3RbvWUlLPNAs4roF5j
	 GDO4bI8H+hRKIjNU5mf1XGQUvUfqVLyNiiKtFxCdlE+kygZpbPLFvQkaevNP+tQCNo
	 gwu5BuzJlSoPRTHh39eaandsen27lvFJ0Y20SWxx6Mr83VpKiCtYlsqR5fKRRqYWcD
	 uT2BYYHaPLXciS/zsK4/UUPg4n4WBkAHhaZp5xkGKq3GuSr6hCBkMAPzzV6GGeE5go
	 R/OyiBeVNxLog==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8fdd6e04-c7ae-4d2f-b984-98d41d4ef8bc@intel.com>
References: <20250116092159.50890-1-atenart@kernel.org> <8fdd6e04-c7ae-4d2f-b984-98d41d4ef8bc@intel.com>
Subject: Re: [PATCH net v2] net: avoid race between device unregistration and ethnl ops
From: Antoine Tenart <atenart@kernel.org>
Cc: ecree.xilinx@gmail.com, netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Thu, 16 Jan 2025 14:47:03 +0100
Message-ID: <173703522332.6390.7759526922746662664@kwain>

Quoting Przemek Kitszel (2025-01-16 10:44:40)
> On 1/16/25 10:21, Antoine Tenart wrote:
> > The following trace can be seen if a device is being unregistered while
> > its number of channels are being modified.
> >=20
> >    DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
> >    WARNING: CPU: 3 PID: 3754 at kernel/locking/mutex.c:564 __mutex_lock=
+0xc8a/0x1120
> >    CPU: 3 UID: 0 PID: 3754 Comm: ethtool Not tainted 6.13.0-rc6+ #771
> >    RIP: 0010:__mutex_lock+0xc8a/0x1120
> >    Call Trace:
> >     <TASK>
> >     ethtool_check_max_channel+0x1ea/0x880
> >     ethnl_set_channels+0x3c3/0xb10
> >     ethnl_default_set_doit+0x306/0x650
> >     genl_family_rcv_msg_doit+0x1e3/0x2c0
> >     genl_rcv_msg+0x432/0x6f0
> >     netlink_rcv_skb+0x13d/0x3b0
> >     genl_rcv+0x28/0x40
> >     netlink_unicast+0x42e/0x720
> >     netlink_sendmsg+0x765/0xc20
> >     __sys_sendto+0x3ac/0x420
> >     __x64_sys_sendto+0xe0/0x1c0
> >     do_syscall_64+0x95/0x180
> >     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >=20
> > This is because unregister_netdevice_many_notify might run before the
> > rtnl lock section of ethnl operations, eg. set_channels in the above
> > example. In this example the rss lock would be destroyed by the device
> > unregistration path before being used again, but in general running
> > ethnl operations while dismantle has started is not a good idea.
> >=20
> > Fix this by denying any operation on devices being unregistered. A check
> > was already there in ethnl_ops_begin, but not wide enough.
> >=20
> > Note that the same issue cannot be seen on the ioctl version
> > (__dev_ethtool) because the device reference is retrieved from within
> > the rtnl lock section there. Once dismantle started, the net device is
> > unlisted and no reference will be found.
> >=20
> > Fixes: dde91ccfa25f ("ethtool: do not perform operations on net devices=
 being unregistered")
> > Signed-off-by: Antoine Tenart <atenart@kernel.org>
> > ---
>=20
> for future submissions, please add a changelog and a link to previous
> revisions

This one was a bit special as v2 is completely different from v1, not
much to describe. But sure, at least a link could help.

> >   net/ethtool/netlink.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> > index e3f0ef6b851b..4d18dc29b304 100644
> > --- a/net/ethtool/netlink.c
> > +++ b/net/ethtool/netlink.c
> > @@ -90,7 +90,7 @@ int ethnl_ops_begin(struct net_device *dev)
> >               pm_runtime_get_sync(dev->dev.parent);
> >  =20
> >       if (!netif_device_present(dev) ||
> > -         dev->reg_state =3D=3D NETREG_UNREGISTERING) {
> > +         dev->reg_state >=3D NETREG_UNREGISTERING) {
>=20
> looks good, but I would add a comment above enum netdev_reg_state
> definition, to avoid any new state added "at the end"
>=20
> what about NETREG_DUMMY? you want to cover it here too?

I'm not super familiar with NETREG_DUMMY but my understanding is those
devices aren't listed and aren't accessible through ethnl.

Having said that I do agree the checks on reg_state could be
consolidated, eg. reusing and improving dev_isalive(). I actually
planned to have a look at if this would make sense later on.

tl;dr; I don't think there's an issue in practice but we could probably
consolidate the code to make things easier to maintain and to read.

Thanks,
Antoine

