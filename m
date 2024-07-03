Return-Path: <netdev+bounces-108786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B05092572E
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC11E1C210DF
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 09:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ED413DDCF;
	Wed,  3 Jul 2024 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="FxImH4Cc"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C3913541F;
	Wed,  3 Jul 2024 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000019; cv=none; b=Z5gmd2fxtNF6d+k3lLsYtrmkX9bhC8ZXAgsAfLWZDx1bSaab2Ob1yG26fvFbViOsGGDgSfFBIYQv/VlMA5C/ymvlzA1BAzUIzZ835xzUunv/Nx0+rNT1WvlPZo5zuMYeYw3FegViMjzO6pTAgW0QkNkzs2yOWS5ITxa0lmuASRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000019; c=relaxed/simple;
	bh=bouHdOsxPVaf7RPMK1kJM80X30VaeGQat5pdp7fw4K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crYSQ0supDonFMu8G7crOW/x/eKJkbzufh7Iq3NAgjjKT7wbfA9L0wIn8e2qityNQnToiyl2rIUJDltimbUmZFXkiOlWBlKByql2Xu01eGENEAYLSqe1+gib/KQbqIhCe5z5aUL+g+LEwXPPcI78aTqgiAkhDn/oRJR00wq+7Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=FxImH4Cc; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from localhost (unknown [IPv6:2a02:8012:909b:0:1e90:7398:2278:75e2])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id B81097D76D;
	Wed,  3 Jul 2024 10:46:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1720000010; bh=bouHdOsxPVaf7RPMK1kJM80X30VaeGQat5pdp7fw4K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Disposition:In-Reply-To:From;
	z=Date:=20Wed,=203=20Jul=202024=2010:46:50=20+0100|From:=20Tom=20Pa
	 rkin=20<tparkin@katalix.com>|To:=20syzbot=20<syzbot+c041b4ce3a6dfd
	 1e63e2@syzkaller.appspotmail.com>|Cc:=20linux-kernel@vger.kernel.o
	 rg,=20netdev@vger.kernel.org,=0D=0A=09syzkaller-bugs@googlegroups.
	 com|Subject:=20Re:=20[syzbot]=20[net?]=20KASAN:=20slab-use-after-f
	 ree=20Write=20in=0D=0A=20l2tp_session_delete|Message-ID:=20<ZoUeCo
	 DMkRA/9DSi@katalix.com>|References:=20<0000000000008405e0061bb6d4d
	 5@google.com>|MIME-Version:=201.0|Content-Disposition:=20inline|In
	 -Reply-To:=20<0000000000008405e0061bb6d4d5@google.com>;
	b=FxImH4Cc+MmKNP/W1dIfK745SW7hYM6WudOVJcab9XMPeNyGvnm/z4pmVzbwzA9gm
	 iirs2VMH7FkBMP4HKvof46cisiOu1XogdfgzHUIYEdYXSftxp9VVs04DsLWAAPcxc3
	 TT4Am5Bff4xGj/9Tta+pXYZNA69Mj8KJRzW6/pYFoG4hR4wKvUVgbpeoseBF1+0u8Y
	 qajBRLu2yCjNKhtuio+gs1/qiTRXgaafUtiCM05hn/nNPgsonlZhPM9tkojoM2pTcQ
	 jkUgARp+f0QmmiD15gIokLIMZc96n6gsNhNWE/bPcKBTWV+FqyOWp5z1AnzxBjEMpx
	 u7R0Cex694xgA==
Date: Wed, 3 Jul 2024 10:46:50 +0100
From: Tom Parkin <tparkin@katalix.com>
To: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in
 l2tp_session_delete
Message-ID: <ZoUeCoDMkRA/9DSi@katalix.com>
References: <0000000000008405e0061bb6d4d5@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8snERkfl58I8EGWb"
Content-Disposition: inline
In-Reply-To: <0000000000008405e0061bb6d4d5@google.com>


--8snERkfl58I8EGWb
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

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1290,13 +1290,14 @@ static void l2tp_session_unhash(struct l2tp_session=
 *session)
 static void l2tp_tunnel_closeall(struct l2tp_tunnel *tunnel)
 {
    struct l2tp_session *session;
-   struct list_head *pos;
-   struct list_head *tmp;

    spin_lock_bh(&tunnel->list_lock);
    tunnel->acpt_newsess =3D false;
-   list_for_each_safe(pos, tmp, &tunnel->session_list) {
-       session =3D list_entry(pos, struct l2tp_session, list);
+   for (;;) {
+       session =3D list_first_entry_or_null(&tunnel->session_list,
+                          struct l2tp_session, list);
+       if (!session)
+           break;
        list_del_init(&session->list);
        spin_unlock_bh(&tunnel->list_lock);
        l2tp_session_delete(session);

--8snERkfl58I8EGWb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEsUkgyDzMwrj81nq0lIwGZQq6i9AFAmaFHgQACgkQlIwGZQq6
i9CeRAf/W3LdHltDdn3pvAj9TMVybZHHF9EwniUz3G3NRWazvpq5T4svhx/H7uf/
OJ+m5auCgiDOHuz7DtMP4LKd3VPnRZ2RYFtYztDNKZDSIsWQNBVVkfkV97+FmARu
mBgW684e8gRLVybRG+sQEgJaXHieG+hz7mO7YGfQBK0sncrMcKVn40SLGhB3LA9F
0W/Jnm3QhFRGqtmka23k3od7kASz+87LxGrZhclemnu+knTpyTA/Uf7YsD176TH+
fdtrjUBPJy4BX3qcThTks2NgQdS6WQ2dtTRk792lNNOUtfo0m/Tx4B0dALbVP3Wr
1VoijlJ88UWjNjb1Hr36qpzddS48rQ==
=j0cV
-----END PGP SIGNATURE-----

--8snERkfl58I8EGWb--

