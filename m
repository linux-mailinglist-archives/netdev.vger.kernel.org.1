Return-Path: <netdev+bounces-151968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE539F20A0
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 20:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68129166943
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 19:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9C81A8F79;
	Sat, 14 Dec 2024 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="qu8Bfyvo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8151119A;
	Sat, 14 Dec 2024 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734205395; cv=none; b=WmtEFWNKGQ+8h6C9PPEO/6HrYJISFoEhJeuEiKNsYT4ogbjLR+vcKFLJ/sRgqWWrcLkFYB3/8fQP3KBdkSiflixXPsivK9uw3aLe4oKbJf1fVqx+/8OuI39mIpqBkCdXy9Y6yFVWz1Fy1S/tIq7NlANncOOaUBt8vfkzSSYsg0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734205395; c=relaxed/simple;
	bh=tXqciZ4bi16lw4tGIOlIHwU2qwiOiHAdCX1Cma++6LQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rADVA5whkHqlWCd+6vTauS+ycEuLP+GhGv9gmdjZc1ii4axVq938u5Q9gAUe3PBUwegOeDa+a63HsFiBzmCxgMN+pfybhm1Qq7eFVdji6Rw+Nkjzs23q/XIOGL1333UJWAZwJEIkhDVv2+9+3lklxOOO2MuXP31H36lM1A8gnXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=qu8Bfyvo; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1734205391; x=1734464591;
	bh=djRhhUH3mgerGdQ1ZA/d9QHoyZN0+WSjWLmBCwL3nhs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=qu8BfyvoDw0wDK/ggOhvkWyvkNqVmOTzGnu4M0LU/oyljt7vHz7PHMWdPAsUbpyuu
	 czyYh2Tk62SyQek/JTYmD9CQzqKdmZuuAkgUPx4QwTR2hHedZr5yVMBe24tTKV252f
	 8s/fbrcKKYK4Ru0XgcNEThKawYFSxojESBFi7ia7Y1NMvIJ5FMHOT2v9JSxjdvUIeq
	 G4F5ir+PIRLqOXcjxPdCxvm4WGSh28WSOLZQ1PB/mWSYiwRWpZnF7GGuP/DYg4h7z9
	 T28y8iwJiedWKJn0w328e3uPx8Qr9WMIFGI5L4u0+c7K7tYN1l3OK5IPR03qllC3Wa
	 JgSD4yC4NIB9g==
Date: Sat, 14 Dec 2024 19:43:06 +0000
To: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, Rahul Rameshbabu <sergeantsagara@protonmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH net-next v2] rust: net::phy scope ThisModule usage in the module_phy_driver macro
Message-ID: <20241214194242.19505-1-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: 343454d894d86e60e952ec0404fc15c470e70326
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Similar to the use of $crate::Module, ThisModule should be referred to as
$crate::ThisModule in the macro evaluation. The reason the macro previously
did not cause any errors is because all the users of the macro would use
kernel::prelude::*, bringing ThisModule into scope.

Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---

Notes:
    Notes:
        v1->v2:
            Dropped the Fixes: tag and target net-next.
   =20
        How I came up with this change:
   =20
            I was working on my own rust bindings and rust driver when I co=
mpared my
            macro_rule to the one used for module_phy_driver. I noticed, if=
 I made a
            driver that does not use kernel::prelude::*, that the ThisModul=
e type
            identifier used in the macro would cause an error without being=
 scoped in
            the macro_rule. I believe the correct implementation for the ma=
cro is one
            where the types used are correctly expanded with needed scopes.

 rust/kernel/net/phy.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index b89c681d97c0..00c3100f5ebd 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -837,7 +837,7 @@ const fn as_int(&self) -> u32 {
 ///         [::kernel::net::phy::create_phy_driver::<PhySample>()];
 ///
 ///     impl ::kernel::Module for Module {
-///         fn init(module: &'static ThisModule) -> Result<Self> {
+///         fn init(module: &'static ::kernel::ThisModule) -> Result<Self>=
 {
 ///             let drivers =3D unsafe { &mut DRIVERS };
 ///             let mut reg =3D ::kernel::net::phy::Registration::register=
(
 ///                 module,
@@ -903,7 +903,7 @@ struct Module {
                 [$($crate::net::phy::create_phy_driver::<$driver>()),+];
=20
             impl $crate::Module for Module {
-                fn init(module: &'static ThisModule) -> Result<Self> {
+                fn init(module: &'static $crate::ThisModule) -> Result<Sel=
f> {
                     // SAFETY: The anonymous constant guarantees that nobo=
dy else can access
                     // the `DRIVERS` static. The array is used only in the=
 C side.
                     let drivers =3D unsafe { &mut DRIVERS };

base-commit: 9bc5c9515b4817e994579b21c32c033cbb3b0e6c
--=20
2.44.1



