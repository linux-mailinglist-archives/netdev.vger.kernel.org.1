Return-Path: <netdev+bounces-158206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B898A1102D
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 19:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11BE3A2519
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 18:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5241FA15A;
	Tue, 14 Jan 2025 18:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTSufW4e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B01B1C1AAA;
	Tue, 14 Jan 2025 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879580; cv=none; b=YWfkfH2TbAdcz+t+hWWXVMXb6Ogl2KpVsFx3/jnfHy5v1QQV/qUtMs3xTXYbsT1zLP56gjRysRt0JJ0m+h4rSdB3amdtBniQNMtscYA03eLLcovQI/SNtrAAQFuQCO65Lx8RC7qrprygF0X/sjKuHPiJk8v8MBALm5DWH3dXmnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879580; c=relaxed/simple;
	bh=+VYfghA8rdZLLpmdod8238HnaaeOZHNazblnDuKrS5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tfw1sgkd/zQudNdAJKBBjh/gRNQHZUrMi2Q0aG3BPwNkAjBqdOqXhz+GSIsNnctFaLo6dYDkMmsN8S06pd51yc7xo+ZJ0QPUtOXLLuzTk3EZ6lTlyXhubIgr2aCw+e83pYH21fWMppxe020fj3ENwDHF4yPDx51RGi5HijJnoEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTSufW4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4505C4CEDD;
	Tue, 14 Jan 2025 18:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736879579;
	bh=+VYfghA8rdZLLpmdod8238HnaaeOZHNazblnDuKrS5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dTSufW4efKR+RIHqvwO/9tgIApbDDjdv44InVf79nTpH+fqsZoocULrcrwKMVnQQ5
	 RdzKW96/aFBeiCxYXTefWPYIICbm+Eu6rG7ovKW+JdGiRI47459qzUvUXDQhCB2gRM
	 701k5jFBY4zSmNTziWErYmRGTY/TYyEiiyWUSgUuEkxH3EbunKYRIF0Wa6wGYshwDr
	 MxqJ7pDFS6HDOAkfgpagILog3wKencYyaQQmL7omgH5ezoWMJDVFSItmpitzazhtaO
	 HG+IClazBl+1mEWiDJrI71zrYT1bk7xYW2/7xCY4wqsD1f1YdMI+fhWUJolUp8mxLi
	 UKEpo9Ifnp0yw==
Date: Tue, 14 Jan 2025 10:32:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Li Li <dualli@chromium.org>
Cc: Carlos Llamas <cmllamas@google.com>, dualli@google.com, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com,
 tkjos@android.com, maco@android.com, joel@joelfernandes.org,
 brauner@kernel.org, surenb@google.com, arnd@arndb.de, masahiroy@kernel.org,
 bagasdotme@gmail.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org, hridya@google.com,
 smoreland@google.com, kernel-team@android.com
Subject: Re: [PATCH v11 2/2] binder: report txn errors via generic netlink
Message-ID: <20250114103257.73e9c0d1@kernel.org>
In-Reply-To: <CANBPYPjQVqmzZ4J=rVQX87a9iuwmaetULwbK_5_3YWk2eGzkaA@mail.gmail.com>
References: <20241218203740.4081865-1-dualli@chromium.org>
	<20241218203740.4081865-3-dualli@chromium.org>
	<Z32cpF4tkP5hUbgv@google.com>
	<Z32fhN6yq673YwmO@google.com>
	<CANBPYPi6O827JiJjEhL_QUztNXHSZA9iVSyzuXPNNgZdOzGk=Q@mail.gmail.com>
	<Z4Aaz4F_oS-rJ4ij@google.com>
	<Z4Aj6KqkQGHXAQLK@google.com>
	<CANBPYPjvFuhi7Pwn_CLArn-iOp=bLjPHKN0sJv+5uoUrDTZHag@mail.gmail.com>
	<20250109121300.2fc13a94@kernel.org>
	<Z4BZjHjfanPi5h9W@google.com>
	<20250109161825.62b31b18@kernel.org>
	<CANBPYPjQVqmzZ4J=rVQX87a9iuwmaetULwbK_5_3YWk2eGzkaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Jan 2025 22:01:00 -0800 Li Li wrote:
> On Thu, Jan 9, 2025 at 4:18=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> > > Sorry, it was me that suggested NETLINK_URELEASE. BTW, I did try those
> > > genl_family callbacks first but I couldn't get them to work right away
> > > so I moved on. I'll have a closer look now to figure out what I did
> > > wrong. Thanks for the suggestion Jakub! =20
> >
> > Hm, that's probably because there is no real multicast group here :(
> > genl_sk_priv_get() and co. may work better in that case.
> > your suggestion of NETLINK_URELEASE may work too, tho, I think it's
> > the most error prone =20
>=20
> sock_priv_destroy works with genl_sk_priv_get().
>=20
> But, I have to manually modify the generated netlink header file to satis=
fy CFI.
>=20
> -void binder_nl_sock_priv_init(struct my_struct *priv);
> -void binder_nl_sock_priv_destroy(struct my_struct *priv);
> +void binder_nl_sock_priv_init(void *priv);
> +void binder_nl_sock_priv_destroy(void *priv);
>=20
> The reason is that these 2 callback functions are defined in
> include/net/genetlink.h as below
> void (*sock_priv_init)(void *priv);
> void (*sock_priv_destroy)(void *priv);
>=20
> Otherwise, kernel panic when CFI is enabled.
>=20
> CFI failure at genl_sk_priv_get+0x60/0x138 (target:
> binder_nl_sock_priv_init+0x0/0x34; expected type: 0x0ef81b7d)
>=20
> Jakub, we probably need this patch. Please let me know if you have a
> better idea. Thanks!
>=20
> diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
> index 8155ff6d2a38..84033938a75f 100755
> --- a/tools/net/ynl/ynl-gen-c.py
> +++ b/tools/net/ynl/ynl-gen-c.py
> @@ -2352,8 +2352,8 @@ def print_kernel_family_struct_hdr(family, cw):
>      cw.p(f"extern struct genl_family {family.c_name}_nl_family;")
>      cw.nl()
>      if 'sock-priv' in family.kernel_family:
> -        cw.p(f'void
> {family.c_name}_nl_sock_priv_init({family.kernel_family["sock-priv"]}
> *priv);')
> -        cw.p(f'void
> {family.c_name}_nl_sock_priv_destroy({family.kernel_family["sock-priv"]}
> *priv);')
> +        cw.p(f'void {family.c_name}_nl_sock_priv_init(void *priv);')
> +        cw.p(f'void {family.c_name}_nl_sock_priv_destroy(void *priv);')
>          cw.nl()
>=20

Maybe we can codegen a little wrapper call. Can you try this with CFI?

---->8------------

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen=
_c.py
index d3a7dfbcf929..9852ba6fd9c3 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -2411,6 +2411,15 @@ _C_KW =3D {
     if not kernel_can_gen_family_struct(family):
         return
=20
+    if 'sock-priv' in family.kernel_family:
+        # Generate "trampolines" to make CFI happy
+        cw.write_func("static void", f"__{family.c_name}_nl_sock_priv_init=
",
+                      [f"{family.c_name}_nl_sock_priv_init(priv);"], ["voi=
d *priv"])
+        cw.nl()
+        cw.write_func("static void", f"__{family.c_name}_nl_sock_priv_dest=
roy",
+                      [f"{family.c_name}_nl_sock_priv_destroy(priv);"], ["=
void *priv"])
+        cw.nl()
+
     cw.block_start(f"struct genl_family {family.ident_name}_nl_family __ro=
_after_init =3D")
     cw.p('.name\t\t=3D ' + family.fam_key + ',')
     cw.p('.version\t=3D ' + family.ver_key + ',')
@@ -2428,9 +2437,8 @@ _C_KW =3D {
         cw.p(f'.n_mcgrps\t=3D ARRAY_SIZE({family.c_name}_nl_mcgrps),')
     if 'sock-priv' in family.kernel_family:
         cw.p(f'.sock_priv_size\t=3D sizeof({family.kernel_family["sock-pri=
v"]}),')
-        # Force cast here, actual helpers take pointer to the real type.
-        cw.p(f'.sock_priv_init\t=3D (void *){family.c_name}_nl_sock_priv_i=
nit,')
-        cw.p(f'.sock_priv_destroy =3D (void *){family.c_name}_nl_sock_priv=
_destroy,')
+        cw.p(f'.sock_priv_init\t=3D __{family.c_name}_nl_sock_priv_init,')
+        cw.p(f'.sock_priv_destroy =3D __{family.c_name}_nl_sock_priv_destr=
oy,')
     cw.block_end(';')
=20
=20
--=20
2.47.1


