Return-Path: <netdev+bounces-130747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A328A98B64D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9031F227A6
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AAF1BDAA3;
	Tue,  1 Oct 2024 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=inguin@gmx.de header.b="q6B0qALA"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99E1BBBCA;
	Tue,  1 Oct 2024 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769501; cv=none; b=owPAhhR7IXSL9Pu09oaQDGt+faSxnaztB7l/8OgCxwOJ26/uoWcUIR2vDoRKPYlIzOc2UybUdzNqUYRDX+K0bRj1780DbRnhg5jLcUpYSCtBkXv3fF0EkEY4s2dKBK1G7lggM7HYD+PP9u+bOdxoIcXjxy6fHN6QwJkhQofGUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769501; c=relaxed/simple;
	bh=pMfk8+HOUrV4upL5IAGrbT4UHJ69CkGVlbCs68wRMs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WvNMUnPmceGOhEzQ56h58efS5R87h0C8v/ewmJF0jNtSJ2xI/9H68pUnLxbrg30vcnD1+0eAlqxHKtFwQft5rr8ulNtcCExUCr3qXcn5NBb2fq8Obi8DKq40T26Z5hbYT7aJpQSKEJM4pNVQWq5+Ys+ZZ1su6g45Z8+/JuL7+CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=inguin@gmx.de header.b=q6B0qALA; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727769493; x=1728374293; i=inguin@gmx.de;
	bh=/5mt1WVT3U9Tvoh5M1UJm7KdQL8Gr6u06WdAplJnPkg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=q6B0qALAw1nZGYGPdILsoenv3Z7YR0486p9vU+EM4Bmj5R4NkhT1hTosMHG5MMRs
	 WiwneED35w4Q6woqikXz02IduzkrbS4UqKh8LbI8DSlCLtKCLHP3cYgYZqOR0EYXE
	 /Cwc7yn8Ap+778ksanN97Q6xkUM1ms19rA6mmbVsam8Xjgftd5Ne4eh5jEU0vz2gS
	 QkZxumIVUdqWm0XpVkGMoSDcrpRGNoxa7dVuj9JyKscPnpToqSvW2bK2KC7wkeL5O
	 HeHvfCbjy+Np5j1HFOYRtsahmFH3Nk3YGEsGEXqvftjPFcha+Xs/ejmP/RU00hOFU
	 wfjk1N7tz30KDfeAlA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from zaphod.peppercon.de ([212.80.250.50]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6bjy-1rpo0B2Ztm-012GUD; Tue, 01
 Oct 2024 09:58:13 +0200
From: Ingo van Lil <inguin@gmx.de>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Dan Murphy <dmurphy@ti.com>,
	Ingo van Lil <inguin@gmx.de>
Subject: [PATCH] net: phy: dp83869: fix memory corruption when enabling fiber
Date: Tue,  1 Oct 2024 09:57:33 +0200
Message-ID: <20241001075733.10986-1-inguin@gmx.de>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hIXkf3Br/eZWUxRH8HgfA7JdSuAyOjwxQhyisSoJy+v4/NNVYHI
 1FUy18obP9AFDEzS5GNMrFNNU48SwyvesNC2tjMl8EnnLgQBRJLlHfythv6a8IBx0SMXlTH
 CcVp9KclStzSCO4PljKymc7YJ4reDgjEfPRNCraSOa7hCDsTIAu72Jfr+Z++yJZeFWAys/I
 LwPpDvxe15wDkt96qeWsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MIpViB/Q/Gs=;bJGMd7H/GnYPuVYZM5jbqS7b7Nw
 eGfrn5BuYDD1NsMxC7Kd6Xk8SpZE8op0N+8fMECKt9RVMbAI2FSLDXGTYSwlcUaGoWxuOr0D/
 ao2mXn+Urx6IosGyfQ4pP1Z7bmWyUxJR8NUvA0ZkzgVQXm1XaVeRy19gonPW67A2TkeMSoCew
 0kDtq/M0MxUq6z+eKteBtNAvs0SfBX/U3qLysIGxsWzI0560hLGpZA2+mbqPbRAqLMJZU14Xa
 kGtmxVyDvHR2DxRnQcQTpluBUP45BP1emysy7CM2uCReUmy3v1aDazvLElDWv+3kV+tU1Ch0J
 rc7IXzU+x2TfCwA1wQLhxKvHYaBcF8xUZMUoOR4OcC5a3TqON/PlngfhHs9zwhCSb/WL5ildt
 77MUAjx0kPU/JSyZ5kY5yg1bJcL5/6untNmUh4eysw1WtpuemjDIw21FwFfAcoAmxtrUATCpJ
 0MyAOczw4Jj1U1lTDopJM5ka3WDenTwmBoEyHdT7va7sfJmWRLjXCTlm2TB5TsRtt0vi3PgBR
 dKHOGjmAOifCa+A9f3W+2awDnGJr1NScMXjDZ+6OKzZL04w/f2w1g4lHiW/OFkxZ6JwoKWi0H
 iMOaMVL69/Tw58xF0pYqb3CKZAPvVwYO2CRt4Cugbe4SR+zpQ2tQ35w4XxjSGXlQn2h8Gsqna
 y5pRNvNabB+dW3754LQYEKDpiHneREDp6pzG2ji+Wp0ZXtt70TtDN7kw+vXlGcU6ous4VFDo1
 lmq5QaYqV/J5SdJ93JPijBsqei30osvLXDofww8tA/JJT3WdYHpQ+7FEhDibeEPttTtTj1rDn
 QhuuDcCOiBUtkhNXDLdCzaRQ==

When configuring the fiber port, the DP83869 PHY driver incorrectly
calls linkmode_set_bit() with a bit mask (1 << 10) rather than a bit
number (10). This corrupts some other memory location -- in case of
arm64 the priv pointer in the same structure.

Signed-off-by: Ingo van Lil <inguin@gmx.de>
=2D--
 drivers/net/phy/dp83869.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index d7aaefb5226b..9c5ac5d6a9fd 100644
=2D-- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -645,7 +645,7 @@ static int dp83869_configure_fiber(struct phy_device *=
phydev,
 		     phydev->supported);

 	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->supported);
-	linkmode_set_bit(ADVERTISED_FIBRE, phydev->advertising);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->advertising);

 	if (dp83869->mode =3D=3D DP83869_RGMII_1000_BASE) {
 		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
=2D-
2.46.1


