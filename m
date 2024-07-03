Return-Path: <netdev+bounces-108844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93F9926026
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F93B22B11
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B8617164D;
	Wed,  3 Jul 2024 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="w0BLMBJb"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D7645945;
	Wed,  3 Jul 2024 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720008433; cv=none; b=T0fB9O3P0cO9obazLdKHgxKk9E/Lh0qUCsof719E+fjQtwDVg9ovkRKaWD+A11/FHtTADGK+htmHVOecUUxMLxgDskCZhOcD60GaEFUakup2jNyAemhrGKbV4SufHbcsMlbbpTpMTQ069Brwlno+ebq7Glldlio00sxxQBxaa8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720008433; c=relaxed/simple;
	bh=xAUwGWmp2Hl2S78EcEtu1s0V5BlSHNn5+p43jBpD7F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRraqax1husbk+8rYAXqZo1Tv5q5m/lC37aukhc5BXzsmkODEW1DQDIfZ2HOo++VP1zYkmdyEs8wxXz1e9vZBsUG/zUlRAPmWCCWwfcYAeAW0H+c8yjVe98MrvknH/9QdTXl2R1Whx6xB9/BCOBJ6N2oVP5qMfVEmPzzwj2ckuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=w0BLMBJb; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from localhost (unknown [IPv6:2a02:8012:909b:0:1e90:7398:2278:75e2])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id 0E2147D76D;
	Wed,  3 Jul 2024 13:07:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1720008431; bh=xAUwGWmp2Hl2S78EcEtu1s0V5BlSHNn5+p43jBpD7F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Disposition:In-Reply-To:From;
	z=Date:=20Wed,=203=20Jul=202024=2013:07:10=20+0100|From:=20Tom=20Pa
	 rkin=20<tparkin@katalix.com>|To:=20syzbot=20<syzbot+c041b4ce3a6dfd
	 1e63e2@syzkaller.appspotmail.com>|Cc:=20linux-kernel@vger.kernel.o
	 rg,=20netdev@vger.kernel.org,=0D=0A=09syzkaller-bugs@googlegroups.
	 com|Subject:=20Re:=20[syzbot]=20[net?]=20KASAN:=20slab-use-after-f
	 ree=20Write=20in=0D=0A=20l2tp_session_delete|Message-ID:=20<ZoU+7g
	 bOSzWMOOPC@katalix.com>|References:=20<0000000000008405e0061bb6d4d
	 5@google.com>|MIME-Version:=201.0|Content-Disposition:=20inline|In
	 -Reply-To:=20<0000000000008405e0061bb6d4d5@google.com>;
	b=w0BLMBJbDBFIXB290mdCgyzw4g78apzkAqDnE8dFFQlM/ILK+q354zuNwBLhWwyoq
	 5QrnZ2m5J681Fy755vGc+fF265RLmDSjtNMD0WWuSO/lYOOH16D6dYO0fCe6ka0NF2
	 xdEAmaZ9AOzrk/rZAruKkygyoF79/Qmh8u3iZRcGSa9wABLFd58ZJC9yd8NAIkQuBO
	 1yhPzWRIYz+6xsfBp/Q8jlIPSaXyiV76eBzpwf4VpfoKnC+OduC3Ean5uA/Hq9WIIy
	 B8/1MoYjwo0mQlhkZ65zC9JVm1ulI8SC6EKGZB9OimuAyS20UjS+4ivqq3HuGPDM3O
	 LOmA94O4fE9IA==
Date: Wed, 3 Jul 2024 13:07:10 +0100
From: Tom Parkin <tparkin@katalix.com>
To: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in
 l2tp_session_delete
Message-ID: <ZoU+7gbOSzWMOOPC@katalix.com>
References: <0000000000008405e0061bb6d4d5@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SmA1Ol97I3F9djjj"
Content-Disposition: inline
In-Reply-To: <0000000000008405e0061bb6d4d5@google.com>


--SmA1Ol97I3F9djjj
Content-Type: multipart/mixed; boundary="6dG6xs0iNw9vxUoM"
Content-Disposition: inline


--6dG6xs0iNw9vxUoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On  Tue, Jun 25, 2024 at 06:25:23 -0700, syzbot wrote:
> syzbot found the following issue on:
>=20
> HEAD commit:    185d72112b95 net: xilinx: axienet: Enable multicast by de=
f..
> git tree:       net-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1062bd46980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.g=
it  185d72112b95
=20

--6dG6xs0iNw9vxUoM
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-l2tp-fix-possible-UAF-when-cleaning-up-tunnels.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 15d6d4c290810d5b8f357b9e494c5ad420c8a2fb Mon Sep 17 00:00:00 2001
=46rom: Tom Parkin <tparkin@katalix.com>
Date: Wed, 3 Jul 2024 13:02:51 +0100
Subject: [PATCH] l2tp: fix possible UAF when cleaning up tunnels

syzbot reported a UAF caused by a race when the L2TP work queue closes a
tunnel at the same time as a userspace thread closes a session in that
tunnel.

Tunnel cleanup is handled by a work queue which iterates through the
sessions contained within a tunnel, and closes them in turn.

Meanwhile, a userspace thread may arbitrarily close a session via
either netlink command or by closing the pppox socket in the case of
l2tp_ppp.

The race condition may occur when l2tp_tunnel_closeall walks the list
of sessions in the tunnel and deletes each one.  Currently this is
implemented using list_for_each_safe, but because the list spinlock is
dropped in the loop body it's possible for other threads to manipulate
the list during list_for_each_safe's list walk.  This can lead to the
list iterator being corrupted, leading to list_for_each_safe spinning.
One sequence of events which may lead to this is as follows:

 * A tunnel is created, containing two sessions A and B.
 * A thread closes the tunnel, triggering tunnel cleanup via the work
   queue.
 * l2tp_tunnel_closeall runs in the context of the work queue.  It
   removes session A from the tunnel session list, then drops the list
   lock.  At this point the list_for_each_safe temporary variable is
   pointing to the other session on the list, which is session B, and
   the list can be manipulated by other threads since the list lock has
   been released.
 * Userspace closes session B, which removes the session from its parent
   tunnel via l2tp_session_delete.  Since l2tp_tunnel_closeall has
   released the tunnel list lock, l2tp_session_delete is able to call
   list_del_init on the session B list node.
 * Back on the work queue, l2tp_tunnel_closeall resumes execution and
   will now spin forever on the same list entry until the underlying
   session structure is freed, at which point UAF occurs.

The solution is to iterate over the tunnel's session list using
list_first_entry_not_null to avoid the possibility of the list
iterator pointing at a list item which may be removed during the walk.
---
 net/l2tp/l2tp_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index be4bcbf291a1..fa75a8eb8782 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1290,12 +1290,14 @@ static void l2tp_session_unhash(struct l2tp_session=
 *session)
 static void l2tp_tunnel_closeall(struct l2tp_tunnel *tunnel)
 {
 	struct l2tp_session *session;
-	struct list_head __rcu *pos;
-	struct list_head *tmp;
=20
 	spin_lock_bh(&tunnel->list_lock);
 	tunnel->acpt_newsess =3D false;
-	list_for_each_safe(pos, tmp, &tunnel->session_list) {
+	for (;;) {
+		session =3D list_first_entry_or_null(&tunnel->session_list,
+						   struct l2tp_session, list);
+		if (!session)
+			break;
 		session =3D list_entry(pos, struct l2tp_session, list);
 		list_del_init(&session->list);
 		spin_unlock_bh(&tunnel->list_lock);
--=20
2.34.1


--6dG6xs0iNw9vxUoM--

--SmA1Ol97I3F9djjj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEsUkgyDzMwrj81nq0lIwGZQq6i9AFAmaFPuoACgkQlIwGZQq6
i9CrwQf7BBc5N63d0HQY0kvvRRlqKPEWIMS5AJ2lfoKEkpll/MaNURPv9PjKypdQ
w31Prbzd96i1ZBw7is0BeTfdPch9mULTr7Hj4IfITSxRadUR/DuKnNaWWGeTDbM+
NC7hM6lsCsuVn9zXz2Mm7KFyjUoy1TVUQ1fjP4wfM+5EhCJQfN+RbCmpXXS5pyNV
VtYIflrjxu562d0wE7/MoAu6qCnEtIFmCRNVWtpkNvVjXDaMXMs+j0pKTr0jd8q5
/+oRpJQai/NOza4acd0lsd0Tuw0msQuweDmHOswOlGpaBAdAqryCXr6NQnAef+g+
HfcldotjcV6+ZKgDiBo+uuNcRLxzjw==
=Y74Y
-----END PGP SIGNATURE-----

--SmA1Ol97I3F9djjj--

