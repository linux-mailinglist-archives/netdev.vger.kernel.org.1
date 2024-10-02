Return-Path: <netdev+bounces-131299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA76B98E087
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756E51F26A15
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3731D131B;
	Wed,  2 Oct 2024 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=inguin@gmx.de header.b="CsFq2+SN"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493BA1D0E1F;
	Wed,  2 Oct 2024 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885903; cv=none; b=sCIab+ZnqfsbhYEPhua2NC/PI6xcj3hVFcU+4JU5w38PzayVy8YuDabifcMCNWVLXdyDH5QQso8fkfTFNzpBzjXElvb3aZ+NaknGYsrmnQv8xqbiX5mGShe/f54P1REs+Qy9WL9YaEnuOBqH8APOABw2wiGrY3tOzJL7nQKz/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885903; c=relaxed/simple;
	bh=9I57oPSi7svJIBtGf3fPTvYUFRRSaBE2k8SgDCMj+VY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D0jnffFaYbcOWyfgwLIctZoss021sqf57MB7OzXhseyt3aaoJHFrbFT+dSPAVWJ4wzEHRMbhEb14AjlaW6LkY6PXhKs5AluqtAZN1DaX2VUMfWgZVa1lSUMPcOoYt6+6IIdOV3LBHaoibDwSAJhl9rgUdQcFbh0Gjs4jnkrNiOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=inguin@gmx.de header.b=CsFq2+SN; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727885892; x=1728490692; i=inguin@gmx.de;
	bh=AoDJvqdHO0Sz527L7ct5upwSZR5UcvLfylsatrSj+lI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CsFq2+SNreYL+GC02v5DoK6pin5mBCwRd1F8DyajIUoCOiDb88NsnTmB47vKiwDE
	 CTVcliLv0RRsvVQHot/TgBJYh4qucQsQWn0FXPpKBQoYDTiaeN5olZOwFDlCK7hJf
	 besuIKoy4kgg4O7JoxsNhsswVHI1zW99JqUJ1eFW4rRSFxAnfJIsL9lBjGDAT6Mi4
	 COCgN2wY4gIHGFS9YCP6jrfd4LQJP0CCJEP6rUA/RcIE0iQclPc05YjApcsP371HI
	 qWd3+ohUDjEyanHbSSparcH6cHS5qaG1O1hWINJVLdrjEUK3WaZY5/x5sUo+8kRIb
	 vTOm93kXC4Mz1h2PbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from zaphod.peppercon.de ([212.80.250.50]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mKP-1rq8XH1INf-015G31; Wed, 02
 Oct 2024 18:18:12 +0200
From: Ingo van Lil <inguin@gmx.de>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Dan Murphy <dmurphy@ti.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ingo van Lil <inguin@gmx.de>
Subject: [PATCH net] net: phy: dp83869: fix memory corruption when enabling fiber
Date: Wed,  2 Oct 2024 18:18:07 +0200
Message-ID: <20241002161807.440378-1-inguin@gmx.de>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RJPQasVZn3eIXYrbYXkD1CVxh2LpRGvXkmnVe8bNFb2qzgnXfnu
 VHBZ0eUkSJktUdcO/A63xkHILQYDrsVTEaDWf3oKQqsZTl15rtFkxB7TMA9Dh716jNnW0eH
 Fq6SALCzOqSVzwME3eAcYlRnD/+F6AL12BmIDv6yIeltYLcLXHb5jJEO1H27C++KkFqyjPK
 hUw8KuPeL3YGeGantEoxg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8FUrrauqUPo=;T00VKEBmPwVSLjkekJJMhGR43Uc
 wIyNMP0TfC3r/IXnoXvMd6h0tbnO6hMluNRx7KAap6lJ/68fvW5nxOgZWMzCflKlvw8TkMPEB
 VQPGLOPn32f2SJ5EqSV2nG6Wkk89eudzaTD8wXvvFe3o9Nt1Y6sAeqNdPo15dlcstH/Omh6+U
 99rNTe6JFRZQnZ1PcCzrF7T46Wtky41HB7Ju0LIy9buLV2HLP/thYzi+y8W2voC7Ao1iiT8TX
 gumXxiSms9uF4e8hywZYZpubrs7TKTBEsM4TCl0wX4O8f/0RjMLoGWeX178IERBJdwc2KfQ0A
 mlIevwH64iD4Z9KLPS5bjw83UfcBfPVlHUOqU2AMz5KvsCaRNMyLr4uuukk7+gFuv5I3JjmTp
 h2igOGYw4knspPmJAGTDr1bxR1e3FedNUNRdUd9InQqHLPU5LEAkmWbaGoUsV0S9p8/tn1l08
 /m1n7oUJSt6r79n/qUg2HVlYcxOxT7uxQ5QlAffE190PdOuoUrbXVgFcSIDyEIMK9MDmTaS0/
 JDhsHntjeGaU1kVeqEv6AM/auDFZjCWDCWWEmBxUrQ4as9bSVPeYDKoDJuEaHdTU3wFTo221N
 YIJk5Jm4cPdWHXHGDVU7JDT+Mn3sj80TgrQreRDQzHTV4RlrahIbaCrp6wZvcEq0EQCqlcvPM
 Z3491CEjAqt2CBKXCJpCghPmzcgga31nmHL3M9gcbx3r34qk0WXJsadYmZnYsB0vUEElGzIpg
 /c/vwBnwzcbaZ5QjX38FXI5tjTzr74zq9TZKXAMUsONdJjNa8eMk2wqFP4blDH8gmLsbV99Bo
 G3zeAuCgkADgndWpD60ohW2g==

When configuring the fiber port, the DP83869 PHY driver incorrectly
calls linkmode_set_bit() with a bit mask (1 << 10) rather than a bit
number (10). This corrupts some other memory location -- in case of
arm64 the priv pointer in the same structure.

Since the advertising flags are updated from supported at the end of the
function the incorrect line isn't needed at all and can be removed.

Fixes: a29de52ba2a1 ("net: dp83869: Add ability to advertise Fiber connect=
ion")
Signed-off-by: Ingo van Lil <inguin@gmx.de>
=2D--
 drivers/net/phy/dp83869.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index d7aaefb5226b..5f056d7db83e 100644
=2D-- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -645,7 +645,6 @@ static int dp83869_configure_fiber(struct phy_device *=
phydev,
 		     phydev->supported);

 	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->supported);
-	linkmode_set_bit(ADVERTISED_FIBRE, phydev->advertising);

 	if (dp83869->mode =3D=3D DP83869_RGMII_1000_BASE) {
 		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
=2D-
2.46.2


