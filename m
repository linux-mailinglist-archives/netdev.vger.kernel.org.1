Return-Path: <netdev+bounces-108853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EB792608F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3981C23096
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1249176AA4;
	Wed,  3 Jul 2024 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="GnZFnWrg"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9A0171E60;
	Wed,  3 Jul 2024 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010368; cv=none; b=BOY2CigUgKZaIVhS6TaJoofiBirXj3l8UC5l4ZvRbnW94ikO2OurHrHfLy3h52pyac+GkEc1y4J6hseINISKZoIc3/xQyC0L2OwQ9e8RTi3MzJk84erB2xaUl5U7UNxVe2T7HxTodEFkolI9ybsBp2w0IVLFjg/1HPaMrQectVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010368; c=relaxed/simple;
	bh=4KS0NOSTe916DVS2ghPWA1bcCCr8Xm00pZgHtyhX8Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCOo2xYLbwJgP/j7Zn7GvcnZPn/Kx/FqnyJRortqE01nD5dnJv6srrq0AO/8gEdQI5dOD3mDwiKv5rnFk9WzbRA8ppVVsbvxmZ6hXLctlIhSqXF54WkTlntIkIz2kxo+Jg5OVSIrcY+umXXCKFNEGMyk6M2fU44SWJqZbHvj3to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=GnZFnWrg; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from localhost (unknown [IPv6:2a02:8012:909b:0:1e90:7398:2278:75e2])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id 11FDB7D76D;
	Wed,  3 Jul 2024 13:39:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1720010366; bh=4KS0NOSTe916DVS2ghPWA1bcCCr8Xm00pZgHtyhX8Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Disposition:In-Reply-To:From;
	z=Date:=20Wed,=203=20Jul=202024=2013:39:25=20+0100|From:=20Tom=20Pa
	 rkin=20<tparkin@katalix.com>|To:=20Hillf=20Danton=20<hdanton@sina.
	 com>|Cc:=20syzbot=20<syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspot
	 mail.com>,=0D=0A=09linux-kernel@vger.kernel.org,=20netdev@vger.ker
	 nel.org,=0D=0A=09James=20Chapman=20<jchapman@katalix.com>,=0D=0A=0
	 9syzkaller-bugs@googlegroups.com|Subject:=20Re:=20[syzbot]=20[net?
	 ]=20KASAN:=20slab-use-after-free=20Write=20in=0D=0A=20l2tp_session
	 _delete|Message-ID:=20<ZoVGfR6Gx7PLbnn1@katalix.com>|References:=2
	 0<ZoU1Aa/JJ+60FZla@katalix.com>=0D=0A=20<20240703115113.2928-1-hda
	 nton@sina.com>|MIME-Version:=201.0|Content-Disposition:=20inline|I
	 n-Reply-To:=20<20240703115113.2928-1-hdanton@sina.com>;
	b=GnZFnWrgLUYiTr5NbJYMtRCj0TOpeqxDrAybnef27jT4/ntNTFLn3lnCdCKA8pSHN
	 ToSADbbWTU7JvvcPiW54YKlE9mORbjbR0E7urB0jxhjr2Et1UPI6+1YErEeG6SEo5O
	 bqwzsKFoLOXDaXGDU85xoa/Iju+zix6wx4jFA5QIi2dNxEyAD4z4bzmyBE6RVfdguK
	 k4K22t7PEUtY3w30DAINd6ZA0vjLtoY26cSAY+HbO7sQxRToX3T4dOnpkP2ZWjDtim
	 QeCj4o3sMHt+HmznJ0UyNOsrPVpYxJQj6Ikpu60HvjimxFVIS5px2HkRNkqT3//OWq
	 mmLLJ2gtUfALQ==
Date: Wed, 3 Jul 2024 13:39:25 +0100
From: Tom Parkin <tparkin@katalix.com>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	James Chapman <jchapman@katalix.com>,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in
 l2tp_session_delete
Message-ID: <ZoVGfR6Gx7PLbnn1@katalix.com>
References: <ZoU1Aa/JJ+60FZla@katalix.com>
 <20240703115113.2928-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OWXArNVFVWFs/V+O"
Content-Disposition: inline
In-Reply-To: <20240703115113.2928-1-hdanton@sina.com>


--OWXArNVFVWFs/V+O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hillf,

On  Wed, Jul 03, 2024 at 19:51:13 +0800, Hillf Danton wrote:
> On Wed, 3 Jul 2024 12:24:49 +0100 Tom Parkin <tparkin@katalix.com>
> >=20
> > [-- Attachment #1.1: Type: text/plain, Size: 379 bytes --]
> >=20
> > On  Tue, Jun 25, 2024 at 06:25:23 -0700, syzbot wrote:
> > > syzbot found the following issue on:
> > >=20
> > > HEAD commit:    185d72112b95 net: xilinx: axienet: Enable multicast b=
y def..
> > > git tree:       net-next
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1062bd469=
80000
> >=20
> > #syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-ne=
xt.git  185d72112b95
> >=20
> > [-- Attachment #1.2: 0001-l2tp-fix-possible-UAF-when-cleaning-up-tunnel=
s.patch --]
> > [-- Type: text/x-diff, Size: 3275 bytes --]
> >=20
> > From 31321b7742266c4e58355076c19d8d490fa005d2 Mon Sep 17 00:00:00 2001
> > From: James Chapman <jchapman@katalix.com>
> > Date: Tue, 2 Jul 2024 12:49:07 +0100
> > Subject: [PATCH] l2tp: fix possible UAF when cleaning up tunnels
> >=20
> > syzbot reported a UAF caused by a race when the L2TP work queue closes a
> > tunnel at the same time as a userspace thread closes a session in that
> > tunnel.
> >=20
> > Tunnel cleanup is handled by a work queue which iterates through the
> > sessions contained within a tunnel, and closes them in turn.
> >=20
> > Meanwhile, a userspace thread may arbitrarily close a session via
> > either netlink command or by closing the pppox socket in the case of
> > l2tp_ppp.
> >=20
> > The race condition may occur when l2tp_tunnel_closeall walks the list
> > of sessions in the tunnel and deletes each one.  Currently this is
> > implemented using list_for_each_safe, but because the list spinlock is
> > dropped in the loop body it's possible for other threads to manipulate
> > the list during list_for_each_safe's list walk.  This can lead to the
> > list iterator being corrupted, leading to list_for_each_safe spinning.
> > One sequence of events which may lead to this is as follows:
> >=20
> >  * A tunnel is created, containing two sessions A and B.
> >  * A thread closes the tunnel, triggering tunnel cleanup via the work
> >    queue.
> >  * l2tp_tunnel_closeall runs in the context of the work queue.  It
> >    removes session A from the tunnel session list, then drops the list
> >    lock.  At this point the list_for_each_safe temporary variable is
> >    pointing to the other session on the list, which is session B, and
> >    the list can be manipulated by other threads since the list lock has
> >    been released.
> >  * Userspace closes session B, which removes the session from its parent
> >    tunnel via l2tp_session_delete.  Since l2tp_tunnel_closeall has
> >    released the tunnel list lock, l2tp_session_delete is able to call
> >    list_del_init on the session B list node.
> >  * Back on the work queue, l2tp_tunnel_closeall resumes execution and
> >    will now spin forever on the same list entry until the underlying
> >    session structure is freed, at which point UAF occurs.
> >=20
> > The solution is to iterate over the tunnel's session list using
> > list_first_entry_not_null to avoid the possibility of the list
> > iterator pointing at a list item which may be removed during the walk.
> >=20
> > ---
> >  net/l2tp/l2tp_core.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> > index 64f446f0930b..afa180b7b428 100644
> > --- a/net/l2tp/l2tp_core.c
> > +++ b/net/l2tp/l2tp_core.c
> > @@ -1290,13 +1290,14 @@ static void l2tp_session_unhash(struct l2tp_ses=
sion *session)
> >  static void l2tp_tunnel_closeall(struct l2tp_tunnel *tunnel)
> >  {
> >  	struct l2tp_session *session;
> > -	struct list_head *pos;
> > -	struct list_head *tmp;
> > =20
> >  	spin_lock_bh(&tunnel->list_lock);
> >  	tunnel->acpt_newsess =3D false;
> > -	list_for_each_safe(pos, tmp, &tunnel->session_list) {
> > -		session =3D list_entry(pos, struct l2tp_session, list);
> > +	for (;;) {
> > +		session =3D list_first_entry_or_null(&tunnel->session_list,
> > +						   struct l2tp_session, list);
> > +		if (!session)
> > +			break;
>=20
> WTF difference could this patch make wrt closing the race above?
>

Sorry if the commit message isn't clear :-(

The specific UAF that syzbot hits is due to the list node that the
list_for_each_safe temporary variable points to being modified while
the list_for_each_safe walk is in process.

This is possible due to l2tp_tunnel_closeall dropping the spin lock
that protects the list mid way through the list_for_each_safe loop.
This opens the door for another thread to call list_del_init on the
node that list_for_each_safe is planning to process next, causing
l2tp_tunnel_closeall to repeatedly iterate on that node forever.

In the context of l2tp_ppp, this eventually leads to UAF because the
session structure itself is freed when the pppol2tp socket is
destroyed and the pppol2tp sk_destruct handler unrefs the session
structure to zero.

So to avoid the UAF, the list can safely be processed using a loop
which accesses the first entry in the tunnel session list under
spin lock protection, removing that entry, then dropping the lock
to call l2tp_session_delete.

FWIW, I note that syzbot has bisected this UAF to d18d3f0a24fc ("l2tp:
replace hlist with simple list for per-tunnel session list") which
changes l2tp_tunnel_closeall from a similar pattern of repeatedly
grabbing the list head under spin lock projection, to the current code
in net-next.

> >  		list_del_init(&session->list);
> >  		spin_unlock_bh(&tunnel->list_lock);
> >  		l2tp_session_delete(session);

--OWXArNVFVWFs/V+O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEsUkgyDzMwrj81nq0lIwGZQq6i9AFAmaFRnkACgkQlIwGZQq6
i9D4MQgAlIrC9CzRSg+P0UVnqtS/PLhm/PeRB4C6jo0u0H9ikWTDgNC0oM1Rxc18
jxt1yHHMUxdwKIdZGsY2i07WaA9ZAgpGfZk3w07GFDpa1Mub449igzOBPK9XwaYa
J6gjgMMQmiQ3b3ag0VZkhreMuN3uPUERi2r2gxWfsqQq7Z8AZmsUkbWirM+VxnLE
1jwVrQmqxFvJB0S9nIq81srJcpr/LlE6KtzB7g1RXGBJtY/veJ58yRH66i9I51KA
Y5AHKm0vVgTlFVzb1XKio97dH0pPBFwleJkYGEFNDn+MN06br7b/XHzUidBJGVZ+
oNOJrb+SfoRbisG2s5ElFcDdi7WckQ==
=XdNU
-----END PGP SIGNATURE-----

--OWXArNVFVWFs/V+O--

