Return-Path: <netdev+bounces-102241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 126209020E8
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 13:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9CB91F22A9F
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA077E767;
	Mon, 10 Jun 2024 11:55:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C8E7E774;
	Mon, 10 Jun 2024 11:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020533; cv=none; b=YEOhZX9aBwJZc5QEsPOTClQ3n5pjF80QOS/7HTeTpIyMyjAl8LUGKV0r/hPADin6UwL/sMCF+CqzGylqcZuQZVq/kvQxpP7hyJxdQOzm+SsqPIYsKVbBOKPDCwZ/6KGGOb9D+dnLdbcGztL1YFUOQzndL2/o5eLkBtRzkeOnyBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020533; c=relaxed/simple;
	bh=+njtnHy+rO2JAsOYdhi9Sa4qYK7/FIM05eOZ+MuPxks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cl/OJGAiWlHRsGliREp1imESLD9VKm94MWyEqMvHjwJuxa3eCTmNVIIOI67ohsDU7G4j40yRPCoj9Uwn6UI7PVUe5sESZ4UvWdmH+153KOpxmDPLjQWpgRzYMAb7OpPGAjz2KGiMDHv3B11kA5cWacEU3JwedPWrRArpcKeoCWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9905c7c8d6=ms@dev.tdt.de>)
	id 1sGdcX-00AEBc-3q; Mon, 10 Jun 2024 13:55:29 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGdcW-00BhFV-Hy; Mon, 10 Jun 2024 13:55:28 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 3DE41240053;
	Mon, 10 Jun 2024 13:55:28 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id C7A50240050;
	Mon, 10 Jun 2024 13:55:27 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 7969E26128;
	Mon, 10 Jun 2024 13:55:27 +0200 (CEST)
From: Martin Schiller <ms@dev.tdt.de>
To: martin.blumenstingl@googlemail.com,
	hauke@hauke-m.de,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ms@dev.tdt.de
Subject: [PATCH net-next v2 10/12] net: dsa: lantiq_gswip: Remove dead code from gswip_add_single_port_br()
Date: Mon, 10 Jun 2024 13:53:58 +0200
Message-ID: <20240610115400.2759500-11-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610115400.2759500-1-ms@dev.tdt.de>
References: <20240610115400.2759500-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1718020529-2BCA062D-5B02B15F/0/0
X-purgate: clean
X-purgate-type: clean

The port validation in gswip_add_single_port_br() is superfluous and
can be omitted.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 drivers/net/dsa/lantiq_gswip.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswi=
p.c
index cd88b00cfdc1..ea079d1a31e4 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -658,11 +658,6 @@ static int gswip_add_single_port_br(struct gswip_pri=
v *priv, int port, bool add)
 	unsigned int max_ports =3D priv->hw_info->max_ports;
 	int err;
=20
-	if (port >=3D max_ports) {
-		dev_err(priv->dev, "single port for %i supported\n", port);
-		return -EIO;
-	}
-
 	vlan_active.index =3D port + 1;
 	vlan_active.table =3D GSWIP_TABLE_ACTIVE_VLAN;
 	vlan_active.key[0] =3D 0; /* vid */
--=20
2.39.2


