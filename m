Return-Path: <netdev+bounces-292805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LUCIueNGGptlAgAu9opvQ
	(envelope-from <netdev+bounces-292805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:48:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDBD5F6B89
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCD71304A844
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C4632B11A;
	Thu, 28 May 2026 18:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="bCFMACKE"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B893432695F
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779994037; cv=none; b=iXKH/lovxJ63iqC4xzpwoCvZ4vnTRvK45fbChUK27gELAv+1inRo29b/m1GU9IoFMh25X6qgKTlNMeg+rhg5qervgV8qpEnaOLMJygGmjVGjQQoKhwO6Nmtzmkov55R3encrdRreV0q5mwQpzWh2Y9LjXxs61nLjUkfctzpkO5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779994037; c=relaxed/simple;
	bh=vDtJRU1wFleTIPmzpkCTF5jlT8++4Xw1YgA6GlrHVgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfOsH1rZTEZ3dKxcokznL8PQyd9GqgkR7PT6Yh8BTcONfa1J4+ZUV69/h9NMcDujfV9bMg1eUAEN/h5+pkUucKyCxMGaE9AhV8lva6Dk9ED2aw7evIWO42nInQF4u6Z3PbgwGXT61DsQR90MY8YpAkwmOIri5KPEU6kgdzT6tEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=bCFMACKE; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1779994020; x=1780598820; i=wahrenst@gmx.net;
	bh=5YtUiIUA5sZA7Vylh0FkqdcVQC7Ma2RA2MF0rKwJekg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bCFMACKE12XfQgk7oRZE6tINPsRVUFyY0oW++KQgCq2pI3sSZ/QQflReDoXFSrma
	 gHd0QNVC2nkhwzNhDse+RC2sv1z//ISSv1zGsUWiXDIjWJEDYyeTY+6inJOZmk+uv
	 PoXHT2pLTuHuIkvecc5cBcY8VyOlPFqDEiXDrtCrIS4wVSdnSxa4fIGDsKPipd+DL
	 Kk0svhVWYXX4xFye/6MSYrvCGlWQqTIJHSa7/ldqwC94tvlU/CKLUaqnm3QZhGVTS
	 ettyotsucr0orbdGvty5sLiyr9Owr9SAcqIV5DjOE/Ai9QkmDGgMdAwc797udBcpC
	 KT60T0+kj7s81SEXNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VHM-1xMC9W0kLi-00sOUC; Thu, 28
 May 2026 20:47:00 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 2/2] net: phy: dp83822: Add optional external PHY clock
Date: Thu, 28 May 2026 20:46:42 +0200
Message-ID: <20260528184642.33424-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528184642.33424-1-wahrenst@gmx.net>
References: <20260528184642.33424-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wwb9UpJwQgoK0Lp6pvpyArTBSQ5jQ/vGcLt/fBTLvgCmPBnozC5
 F7pPuRgwjmZHGmT5LOwCzx4TG7KukGNjrUVB7Ti5DzOXn6/xvfKlfTJVPPfaXLEMi5EBEpG
 7vgp38pWR03I5wcsWkgXsibcJV39zQjobcxyrJ48gElXC0xoDqM2f0iDxHBYlwHObLwfWvi
 j6rJOUV2wNI7P8THGLp+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1TW9e1LQ99o=;tV0/npU9rkNHRAttoCcYFluYDRA
 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
 AuUVIbiJs3/IUffktP/3UXZPTXRKo6l+5Gz26Q5
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292805-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.net];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wahrenst@gmx.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.net:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DFDBD5F6B89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In some cases, the PHY can use an external ref clock source instead of a
crystal.

Add an optional clock in the PHY node to make sure that the clock source
is enabled, if specified, before probing.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/phy/dp83822.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index d8c5b5cd1bc0..6fc86be9d593 100644
=2D-- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2017 Texas Instruments Inc.
  */
=20
+#include <linux/clk.h>
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
 #include <linux/kernel.h>
@@ -986,11 +987,18 @@ static int dp8382x_probe(struct phy_device *phydev)
 {
 	struct device *dev =3D &phydev->mdio.dev;
 	struct dp83822_private *dp83822;
+	struct clk *clk;
=20
 	dp83822 =3D devm_kzalloc(dev, sizeof(*dp83822), GFP_KERNEL);
 	if (!dp83822)
 		return -ENOMEM;
=20
+	clk =3D devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(clk)) {
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "Failed to request ref clock\n");
+	}
+
 	dp83822->tx_amplitude_100base_tx_index =3D -1;
 	dp83822->mac_termination_index =3D -1;
 	phydev->priv =3D dp83822;
=2D-=20
2.43.0


