Return-Path: <netdev+bounces-109227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724AC927796
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2FCA1C230FE
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A3F1AEFD7;
	Thu,  4 Jul 2024 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="26Aj+Ih3"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCCE1AEFD9;
	Thu,  4 Jul 2024 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101608; cv=none; b=Su9r6407ls9xYWD/WRwJeOK2QroUzWZ23zc3D18cRssvuoaTZQg8ZTB31i7UDSwvoCDpwRW7s5fjA5KV0zIG2zM56pIPxgSqmCjuf+eELdojqB3Pk+LERg4CoEwCwKZLS2m+91P3Gq9Z6jW1Jth7T+bmjafiLMAEzaI44zG7fkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101608; c=relaxed/simple;
	bh=NL4y4Vxm3N+KiIzZR5ru/bHBDfPngIH5NU6qtzx4NEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYu1ieU3w3e52U7tjrMFBjeA3NZzCf41FJqG3L/6NDrwqYhHwZ72GxpvGRRJQDR5RajjSupm+ZDayr90qOhnvizXzp4bx9tER//e8BHE3qdA4SoVii5TcRiIQLbADUVXRx8ILklUxkB1aXeytUwAaeGEGNhxIqCpkgyrWqEf5j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=26Aj+Ih3; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from localhost (unknown [IPv6:2a02:8012:909b:0:a8e6:1543:faf0:bfe2])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id 2D7EA7D582;
	Thu,  4 Jul 2024 15:00:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1720101600; bh=NL4y4Vxm3N+KiIzZR5ru/bHBDfPngIH5NU6qtzx4NEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Disposition:In-Reply-To:From;
	z=Date:=20Thu,=204=20Jul=202024=2014:59:59=20+0100|From:=20Tom=20Pa
	 rkin=20<tparkin@katalix.com>|To:=20Hillf=20Danton=20<hdanton@sina.
	 com>|Cc:=20syzbot=20<syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspot
	 mail.com>,=0D=0A=09linux-kernel@vger.kernel.org,=20netdev@vger.ker
	 nel.org,=0D=0A=09James=20Chapman=20<jchapman@katalix.com>,=0D=0A=0
	 9syzkaller-bugs@googlegroups.com|Subject:=20Re:=20[syzbot]=20[net?
	 ]=20KASAN:=20slab-use-after-free=20Write=20in=0D=0A=20l2tp_session
	 _delete|Message-ID:=20<Zoaq358lbnpyHPUq@katalix.com>|References:=2
	 0<ZoVGfR6Gx7PLbnn1@katalix.com>=0D=0A=20<20240704112303.3092-1-hda
	 nton@sina.com>|MIME-Version:=201.0|Content-Disposition:=20inline|I
	 n-Reply-To:=20<20240704112303.3092-1-hdanton@sina.com>;
	b=26Aj+Ih33jEIr1loN/x04M8950DbCo7Lfou9XtxjcOYTq0zpbs/I2foZZxQsH6Yy0
	 krq4dTuQO//PSwqIi+haaxBO/dTHTK4phezHo5zEBY1cvheBSlhgfJlt1qvBxm3r0Q
	 j4sGzpMbiwYachPXZEn81Nlz2DAsGg7C/CuemeOu2OHoGPruaIWpwkAY/czGNy10+u
	 KHkLmCBKewRcNO2wtPjVRSnqeZu9XbrQ9qHjeGXKjkOoKhHiu9RwY2mS8HKNMFlpZb
	 Y2/A36E1aPqLk6QTM44YSjmGtSjZNGZKeYxyasLfKwkwAQdIb/4yL2gBDL8sba9vZf
	 lpZgp7DKZIc2w==
Date: Thu, 4 Jul 2024 14:59:59 +0100
From: Tom Parkin <tparkin@katalix.com>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	James Chapman <jchapman@katalix.com>,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in
 l2tp_session_delete
Message-ID: <Zoaq358lbnpyHPUq@katalix.com>
References: <ZoVGfR6Gx7PLbnn1@katalix.com>
 <20240704112303.3092-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RnLWkKV2K9RyjKPH"
Content-Disposition: inline
In-Reply-To: <20240704112303.3092-1-hdanton@sina.com>


--RnLWkKV2K9RyjKPH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On  Thu, Jul 04, 2024 at 19:23:03 +0800, Hillf Danton wrote:
> On Wed, 3 Jul 2024 13:39:25 +0100 Tom Parkin <tparkin@katalix.com>
> >=20
> > The specific UAF that syzbot hits is due to the list node that the
> > list_for_each_safe temporary variable points to being modified while
> > the list_for_each_safe walk is in process.
> >=20
> > This is possible due to l2tp_tunnel_closeall dropping the spin lock
> > that protects the list mid way through the list_for_each_safe loop.
> > This opens the door for another thread to call list_del_init on the
> > node that list_for_each_safe is planning to process next, causing
> > l2tp_tunnel_closeall to repeatedly iterate on that node forever.
> >=20
> Yeah the next node could race with other thread because of the door.

Exactly, yes.

> > In the context of l2tp_ppp, this eventually leads to UAF because the
> > session structure itself is freed when the pppol2tp socket is
> > destroyed and the pppol2tp sk_destruct handler unrefs the session
> > structure to zero.
> >=20
> > So to avoid the UAF, the list can safely be processed using a loop
> > which accesses the first entry in the tunnel session list under
> > spin lock protection, removing that entry, then dropping the lock
> > to call l2tp_session_delete.
>=20
> Race exists after your patch.
>=20
> 	cpu1				cpu2
> 	---				---
> 					pppol2tp_release()
>=20
> 	spin_lock_bh(&tunnel->list_lock);
> 	while (!list_empty(&tunnel->session_list)) {
> 		session =3D list_first_entry(&tunnel->session_list,
> 					struct l2tp_session, list);
>  		list_del_init(&session->list);
>  		spin_unlock_bh(&tunnel->list_lock);
>=20
>  					l2tp_session_delete(session);
>=20
>  		l2tp_session_delete(session);
>  		spin_lock_bh(&tunnel->list_lock);
>  	}
>  	spin_unlock_bh(&tunnel->list_lock);

I take your point.  Calling l2tp_session_delete() on the same session
twice isn't a problem per-se, but if cpu2 manages to destruct the
socket and unref the session to zero before cpu1 progresses then we
have the same sort of problem.

To be honest, cleanup generally could use some TLC (the dancing around
the list lock in _closeall is not ideal), but a minimal patch to
address the UAF makes sense in the short term IMO -- so to that end
holding a session reference around l2tp_session_delete in _closeall is
probably the least invasive thing to do.

--RnLWkKV2K9RyjKPH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEsUkgyDzMwrj81nq0lIwGZQq6i9AFAmaGqtsACgkQlIwGZQq6
i9BNXQf/bpKvkmGlwUefekQYEVJouMll0xdfE14o9PWiT8zEwZd/A9BxTsXxVUru
81C6K0F6otF+WgZw2HfFQcueMO6IULt4PK7VeXhy8D8uCtod6fbCr2DvRmMatGlY
5POVyervFyGElR+sgieUIIoBgclXaG5g2mHKn/O7cgDjGRrgXP3gzQucgywYzAVP
MkvZVV4d+OpUWlIW+D/a96r1U4POJIrRrm9GkPf+OnIxvgagpv5q+QJdItPwU9CL
9pCNUzqDi4Yw+jo4tmmj050/KeRxQRL4RpQWugLhJVeN8imx94Q6PUfX+UcHHsbA
CaHO+fmbyhv2zhm3TNX4bYXI7oun/Q==
=nc6Q
-----END PGP SIGNATURE-----

--RnLWkKV2K9RyjKPH--

