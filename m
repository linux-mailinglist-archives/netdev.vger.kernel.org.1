Return-Path: <netdev+bounces-108833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CCC925DF2
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8471F22E14
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D4C16F857;
	Wed,  3 Jul 2024 11:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="YqxfldAJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470A116C688;
	Wed,  3 Jul 2024 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005894; cv=none; b=b3FbM5xGV+dykoc1l4vSgEM2Wg3yRMxAxvIjHqMvt9RWRX8SuRbRJLFdyRmcDYB3Ft3aUn+K7fnWFrwiIdqEzh4D1OgOzdPB0SHscasH/EgXXchEUettJMAHNDU6mx6MPriTSTDaEOMwnoNUN4drgtcW61nhDSkvdtC9Rl8oO38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005894; c=relaxed/simple;
	bh=BE/sLoMBYTXAIc//RdgxDfWFFsqXiL6IEX26nDYHdFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jU816xAWdBTbHZv+6jRNd/66TzF1W1mypc2/t+bPDCOo5lKXExe62MIgY9e60FcmobKgtxUN+Eo5gkZFyu5WveZbogpQWH+M04zDNBDlq4CCxPqu6I9miZiv97hEL3mVCJ2JZw24ShkjvAjE3u8mtsdxLi6kcLiESv4h9jrXqdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=YqxfldAJ; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from localhost (unknown [IPv6:2a02:8012:909b:0:1e90:7398:2278:75e2])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id 20C2D7D76D;
	Wed,  3 Jul 2024 12:24:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1720005891; bh=BE/sLoMBYTXAIc//RdgxDfWFFsqXiL6IEX26nDYHdFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Disposition:In-Reply-To:From;
	z=Date:=20Wed,=203=20Jul=202024=2012:24:49=20+0100|From:=20Tom=20Pa
	 rkin=20<tparkin@katalix.com>|To:=20syzbot=20<syzbot+c041b4ce3a6dfd
	 1e63e2@syzkaller.appspotmail.com>|Cc:=20linux-kernel@vger.kernel.o
	 rg,=20netdev@vger.kernel.org,=0D=0A=09syzkaller-bugs@googlegroups.
	 com|Subject:=20Re:=20[syzbot]=20[net?]=20KASAN:=20slab-use-after-f
	 ree=20Write=20in=0D=0A=20l2tp_session_delete|Message-ID:=20<ZoU1Aa
	 /JJ+60FZla@katalix.com>|References:=20<0000000000008405e0061bb6d4d
	 5@google.com>|MIME-Version:=201.0|Content-Disposition:=20inline|In
	 -Reply-To:=20<0000000000008405e0061bb6d4d5@google.com>;
	b=YqxfldAJgFm7lw78xlwfeHP5DSazv9tjA1NEMUD3upFLwq2mhqQl7zlwcPOvcsb93
	 JmXweicTtOrJxi7JMtRN+moAA2WDbghH7sBNoks4+8kMegAFs3km8hJ9BgN1Ff4WH+
	 wbLbl4WpG7UV2ZAadf/5jox1BGO7wmt4Cqp/4byqz1ZmYu9MP0nX8EoNVYsrre2xS1
	 swLnxw3qz6zGRP+Tctgtkf+kD67igcRUM6+AL6g4VVZ0ZNyX6GhiByQOwRfdaGFUFR
	 nBXEMMxjgm4zytZP3hrmm2DXbpSAU8/anqSFa9Hemz6FKiA9TPRxD6ZjZ8kMrbyEvs
	 lVCy+kvDgK/9w==
Date: Wed, 3 Jul 2024 12:24:49 +0100
From: Tom Parkin <tparkin@katalix.com>
To: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in
 l2tp_session_delete
Message-ID: <ZoU1Aa/JJ+60FZla@katalix.com>
References: <0000000000008405e0061bb6d4d5@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="04wT6jxD1uvAzd26"
Content-Disposition: inline
In-Reply-To: <0000000000008405e0061bb6d4d5@google.com>


--04wT6jxD1uvAzd26
Content-Type: multipart/mixed; boundary="alq3nTuPx/UEmRgh"
Content-Disposition: inline


--alq3nTuPx/UEmRgh
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

--alq3nTuPx/UEmRgh
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-l2tp-fix-possible-UAF-when-cleaning-up-tunnels.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 31321b7742266c4e58355076c19d8d490fa005d2 Mon Sep 17 00:00:00 2001
=46rom: James Chapman <jchapman@katalix.com>
Date: Tue, 2 Jul 2024 12:49:07 +0100
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
 net/l2tp/l2tp_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 64f446f0930b..afa180b7b428 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1290,13 +1290,14 @@ static void l2tp_session_unhash(struct l2tp_session=
 *session)
 static void l2tp_tunnel_closeall(struct l2tp_tunnel *tunnel)
 {
 	struct l2tp_session *session;
-	struct list_head *pos;
-	struct list_head *tmp;
=20
 	spin_lock_bh(&tunnel->list_lock);
 	tunnel->acpt_newsess =3D false;
-	list_for_each_safe(pos, tmp, &tunnel->session_list) {
-		session =3D list_entry(pos, struct l2tp_session, list);
+	for (;;) {
+		session =3D list_first_entry_or_null(&tunnel->session_list,
+						   struct l2tp_session, list);
+		if (!session)
+			break;
 		list_del_init(&session->list);
 		spin_unlock_bh(&tunnel->list_lock);
 		l2tp_session_delete(session);
--=20
2.34.1


--alq3nTuPx/UEmRgh--

--04wT6jxD1uvAzd26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEsUkgyDzMwrj81nq0lIwGZQq6i9AFAmaFNPkACgkQlIwGZQq6
i9CJ1wf+IKvWllXWlabMHP/Fw1+D0e6LEqvI1CHE5kREGC8ag+eQ8pEs1fgs0dFs
melLESrjallkY5MEnlxg2JTR3t5ZfeLiP0Ur7o0s2cYfOu+r7DCPdlDex05WT/BB
qFk+wVEOLTt9jOgKQ+5MfLiou273TWTFwN1wUm9VZSyI1jgQSqVN62laRVzxe+sR
Fp+6PpWigsPjHGhnJiS4Kva9UvBDC+EeM0sg6Yvbq9GCVJS7kB2xdiK4FFcIvUx3
djTIT37mObkPnhUxJJYERAkpA0rH1FtbB4o4XRs1hsh0WkuXmgCKGJCJlXBxYT5D
VP5vHZBgCs/GSnii5rkhbqI7MOUPrg==
=7fnD
-----END PGP SIGNATURE-----

--04wT6jxD1uvAzd26--

