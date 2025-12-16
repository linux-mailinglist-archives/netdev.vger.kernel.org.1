Return-Path: <netdev+bounces-244961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CDACC4149
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 16:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F5553030DA4
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 15:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA07328604;
	Tue, 16 Dec 2025 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="hPhGTx9F"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADAD325701;
	Tue, 16 Dec 2025 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765900206; cv=none; b=gc3zGJMQ48zZMaO+el38j1aNm1TN3Ze632uwGZ01v2jYwL+dBH8yNy26uHLH4qozuAq7VPhhXJdOjd+G466v5wGWwznGr5ztlANSVLT8szO5oHTM2w0zbybffYgarnZn7Dt8t3O7RrjQNcGxEGMplTt/4qTYIvCIcHyYbq2lWac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765900206; c=relaxed/simple;
	bh=1IpInUbDNJx8nZem6F0+q1Ev+HyMJkkagkl5ZTSg3EM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jmJbj4j+QTwd/6NAhW6BKEVfKDsuKNpr0ZeCJXJyz6n1m8f5aD7FjOZhgayrA6MoFtuhWnbEeELEqe3c/j1MJex+lZwkKVFc1nWzdzpfKVYyJ3NMX4fWs6nRRiMMRCDQZmFZhS3w/7h/WzgYQmxIHLkH37ZClJlOw1L6APKFb8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=hPhGTx9F; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9B9113D8537E;
	Tue, 16 Dec 2025 10:50:02 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id q2q0nCE-1inL; Tue, 16 Dec 2025 10:50:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 41FB53D85148;
	Tue, 16 Dec 2025 10:50:01 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 41FB53D85148
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1765900201; bh=1fDN+55XoAP+Yu3gl4HXDedXtkgRxsC8J7LSRYb/rLA=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=hPhGTx9Fb6hb5s0iC5L43SEVv0m9TYmMpTwfCA90jESGT9t3lVg/zQVzXOND/waJt
	 O647w7mIHgUXWd+BlzqaIRqaQGZ3QwrPJjuGiF+2shh8g3BI9j39T8hPuMJqtnuUbe
	 N+aGvDztZLyUpjkwi3umsVY3iQl5uTmTD7cUa3bWbtPVNe2HRhh46KDia6NFxFf7h3
	 QLWYW4rNMfwFO8q75FczXp3RtjyzAJprXmkIRAby7obreKeiQz1oCcb60K+bx/oi7O
	 DoPl/0oN3ZZKAmckcvCegQ4GOwYcp8/gd+lx5dB2iKNhNdFItdOnW2fZMDQ4QjJ+9f
	 m1clbUNQk/AtA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id XjzIYE5vKPso; Tue, 16 Dec 2025 10:50:01 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E93243D8482F;
	Tue, 16 Dec 2025 10:50:00 -0500 (EST)
Date: Tue, 16 Dec 2025 10:50:00 -0500 (EST)
From: Osose Itua <osose.itua@savoirfairelinux.com>
To: netdev <netdev@vger.kernel.org>
Cc: devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, 
	=?utf-8?Q?J=C3=A9rome?= Oufella <jerome.oufella@savoirfairelinux.com>
Message-ID: <933810763.1512847.1765900200898.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <1695319092.1512780.1765900119201.JavaMail.zimbra@savoirfairelinux.com>
References: <1695319092.1512780.1765900119201.JavaMail.zimbra@savoirfairelinux.com>
Subject: Re: [PATCH 2/2] dt-bindings: net: adi,adin: document LP termination
  property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 10.1.6_GA_0225 (ZimbraWebClient - GC141 (Linux)/10.1.6_GA_0225)
Thread-Topic: dt-bindings: net: adi,adin: document LP termination property
Thread-Index: hGdGaIZ/TEW52TQsSs5ZKvo3NMSZH0RrUopj

From 4b4409504fd41c81c7150ae1d88bc0ca755e6ace Mon Sep 17 00:00:00 2001
From: Osose Itua <osose.itua@savoirfairelinux.com>
Date: Mon, 15 Dec 2025 17:59:38 -0500
Subject: [PATCH 2/2] dt-bindings: net: adi,adin: document LP termination
 property

Add "adi,low-cmode-impedance" boolean property which, when present,
configures the PHY for the lowest common-mode impedance on the receive
pair for 100BASE-TX operation.

Signed-off-by: Osose Itua <osose.itua@savoirfairelinux.com>
---
 Documentation/devicetree/bindings/net/adi,adin.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/adi,adin.yaml b/Document=
ation/devicetree/bindings/net/adi,adin.yaml
index c425a9f1886d..d3c8c5cc4bb1 100644
--- a/Documentation/devicetree/bindings/net/adi,adin.yaml
+++ b/Documentation/devicetree/bindings/net/adi,adin.yaml
@@ -52,6 +52,12 @@ properties:
     description: Enable 25MHz reference clock output on CLK25_REF pin.
     type: boolean
=20
+  adi,low-cmode-impedance:
+    description: |
+      Ability to configure for the lowest common-mode impedance on the
+      receive pair for 100BASE-TX.
+    type: boolean
+
 unevaluatedProperties: false
=20
 examples:


----- Message original -----
De: "Osose Itua" <osose.itua@savoirfairelinux.com>
=C3=80: "netdev" <netdev@vger.kernel.org>
Cc: "devicetree" <devicetree@vger.kernel.org>, "linux-kernel" <linux-kernel=
@vger.kernel.org>, "Michael Hennerich" <michael.hennerich@analog.com>, "J=
=C3=A9rome Oufella" <jerome.oufella@savoirfairelinux.com>
Envoy=C3=A9: Mardi 16 D=C3=A9cembre 2025 10:48:39
Objet: [PATCH 1/2] net: phy: adin: enable configuration of the LP  Terminat=
ion Register

From 9c68d9082a9c0550891f24c5902c1f0de15de949 Mon Sep 17 00:00:00 2001
From: Osose Itua <osose.itua@savoirfairelinux.com>
Date: Fri, 14 Nov 2025 17:00:14 -0500
Subject: [PATCH 1/2] net: phy: adin: enable configuration of the LP
 Termination Register

The ADIN1200/ADIN1300 provide a control bit that selects between normal
receive termination and the lowest common mode impedance for 100BASE-TX
operation. This behavior is controlled through the Low Power Termination
register (B_100_ZPTM_EN_DIMRX).

Bit 0 of this register enables normal termination when set (this is the
default), and selects the lowest common mode impedance when cleared.

Signed-off-by: Osose Itua <osose.itua@savoirfairelinux.com>
---
 drivers/net/phy/adin.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/phy/adin.c b/drivers/net/phy/adin.c
index 7fa713ca8d45..2969480a7be3 100644
--- a/drivers/net/phy/adin.c
+++ b/drivers/net/phy/adin.c
@@ -89,6 +89,9 @@
 #define ADIN1300_CLOCK_STOP_REG=09=09=090x9400
 #define ADIN1300_LPI_WAKE_ERR_CNT_REG=09=090xa000
=20
+#define ADIN1300_B_100_ZPTM_DIMRX=09=090xB685
+#define ADIN1300_B_100_ZPTM_EN_DIMRX=09=09BIT(0)
+
 #define ADIN1300_CDIAG_RUN=09=09=090xba1b
 #define   ADIN1300_CDIAG_RUN_EN=09=09=09BIT(0)
=20
@@ -522,6 +525,31 @@ static int adin_config_clk_out(struct phy_device *phyd=
ev)
 =09=09=09      ADIN1300_GE_CLK_CFG_MASK, sel);
 }
=20
+static int adin_config_zptm100(struct phy_device *phydev)
+{
+=09struct device *dev =3D &phydev->mdio.dev;
+=09u8 reg;
+=09int rc;
+
+=09if (!(device_property_read_bool(dev, "adi,low-cmode-impedance")))
+=09=09return 0;
+
+=09/* set to 0 to configure for lowest common-mode impedance */
+=09rc =3D phy_write_mmd(phydev, MDIO_MMD_VEND1, ADIN1300_B_100_ZPTM_DIMRX,=
 0x0);
+=09if (rc < 0)
+=09=09return rc;
+
+=09reg =3D phy_read_mmd(phydev, MDIO_MMD_VEND1, ADIN1300_B_100_ZPTM_DIMRX)=
;
+=09if (reg < 0)
+=09=09return reg;
+
+=09if (reg !=3D 0x0)
+=09=09phydev_err(phydev,
+=09=09=09   "Lowest common-mode impedance configuration failed\n");
+
+=09return 0;
+}
+
 static int adin_config_init(struct phy_device *phydev)
 {
 =09int rc;
@@ -548,6 +576,10 @@ static int adin_config_init(struct phy_device *phydev)
 =09if (rc < 0)
 =09=09return rc;
=20
+=09rc =3D adin_config_zptm100(phydev);
+=09if (rc < 0)
+=09=09return rc;
+
 =09phydev_dbg(phydev, "PHY is using mode '%s'\n",
 =09=09   phy_modes(phydev->interface));

