Return-Path: <netdev+bounces-102243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 328D19020F0
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 13:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483531C23340
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C896480C1C;
	Mon, 10 Jun 2024 11:55:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BD27E78E;
	Mon, 10 Jun 2024 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020548; cv=none; b=DkaHQ5P7WebDAv4AQd7D4I70eeJ0aeg7oaUUNvbg3Og/3phREieKKWMWtfNGfJ+KSRtiu1PRL2/TArTm+yh8ilH+vDMUke3DHcFAViYxgtPVAdXm3o9Qlkpw8UhiwDp6qXeWOE31Z4EJqZUtXyjh/dk7L2HFkEEqEI1mV0NA2Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020548; c=relaxed/simple;
	bh=53P6Z5xrcrAHsR1uywk051yi7OsJuOQYoZ2Ng+oB2po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GikKowMjG0Y03sU/pDk1wISvVKMGqiXoYYCnle9V4N4g/BpM5ejJQVM3D4vW34Ya2TyJeSgeyUVArxGF6O4q012mV0jqe3RDYTjHCH8ahH/UqbMF5Jh+/UYYfUlehcVgCsqsIAJrPgtObDNMOnyfIUWh+bHmFQWwlp5x8AJFDSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9905c7c8d6=ms@dev.tdt.de>)
	id 1sGdcn-000x9d-BW; Mon, 10 Jun 2024 13:55:45 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGdcm-00BBXX-QJ; Mon, 10 Jun 2024 13:55:44 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 7C060240053;
	Mon, 10 Jun 2024 13:55:44 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 0FFF4240050;
	Mon, 10 Jun 2024 13:55:44 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id D749626128;
	Mon, 10 Jun 2024 13:55:43 +0200 (CEST)
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
Subject: [PATCH net-next v2 12/12] net: dsa: lantiq_gswip: Improve error message in gswip_port_fdb()
Date: Mon, 10 Jun 2024 13:54:00 +0200
Message-ID: <20240610115400.2759500-13-ms@dev.tdt.de>
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
X-purgate-ID: 151534::1718020545-82CB3642-C77B72EE/0/0
X-purgate: clean
X-purgate-type: clean

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Print that no FID is found for bridge %s instead of the incorrect
message that the port is not part of a bridge.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/dsa/lantiq_gswip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswi=
p.c
index 2aa9381dac41..91813d4a6500 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1371,7 +1371,8 @@ static int gswip_port_fdb(struct dsa_switch *ds, in=
t port,
 	}
=20
 	if (fid =3D=3D -1) {
-		dev_err(priv->dev, "Port not part of a bridge\n");
+		dev_err(priv->dev, "no FID found for bridge %s\n",
+			bridge->name);
 		return -EINVAL;
 	}
=20
--=20
2.39.2


