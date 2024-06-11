Return-Path: <netdev+bounces-102607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CC9903E34
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F9C289DE1
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D08180A6D;
	Tue, 11 Jun 2024 13:56:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCA217DE3D;
	Tue, 11 Jun 2024 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114175; cv=none; b=uENZAWnXnwgd7YXwS/U/bOiPaFZAYCB9n35EKVvdp/Q+HfSrx7V/ltpPSmpJmSfyL505RSkrb4cvd7+EbdgALBxxGIYO1QOIr/7HP4djiRlgfwkWh79BnBCwjIeSYsVLb7s6E/9sChcRpGUF1gHH9oaN+KCEul2PUTGCDP8JYLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114175; c=relaxed/simple;
	bh=hZekxdzg6/DbdtqVNiroTrOJ0Q1iP2Vz3e229k+G84U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AP5MFf1e2pSfx9WDWtOo8cQwWwFXLO94WKoT8AormZwd3TnIIVWQbQ0MEnHS4k3/blm6N8CyBZ4j/evTYgYBZ++wKSYvJKaFkOjFQKSC9u3EzThy4aW0gz9FoJ3/IG4IcZ9rkZ2sUe0gLmzp2j5RFnfWy4SlJyKo5m71FgX0Jcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9906f4c1d5=ms@dev.tdt.de>)
	id 1sH1yu-002Yle-LV; Tue, 11 Jun 2024 15:56:12 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sH1yu-00FJ85-4O; Tue, 11 Jun 2024 15:56:12 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id D3EA8240053;
	Tue, 11 Jun 2024 15:56:11 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 68642240050;
	Tue, 11 Jun 2024 15:56:11 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 3775B376FA;
	Tue, 11 Jun 2024 15:56:11 +0200 (CEST)
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
Subject: [PATCH net-next v5 12/12] net: dsa: lantiq_gswip: Improve error message in gswip_port_fdb()
Date: Tue, 11 Jun 2024 15:54:34 +0200
Message-ID: <20240611135434.3180973-13-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240611135434.3180973-1-ms@dev.tdt.de>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1718114172-CF4488CF-D5B94AF4/0/0

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Print that no FID is found for bridge %s instead of the incorrect
message that the port is not part of a bridge.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/net/dsa/lantiq_gswip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswi=
p.c
index ec52c62eadce..fcd4505f4925 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1370,7 +1370,8 @@ static int gswip_port_fdb(struct dsa_switch *ds, in=
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


