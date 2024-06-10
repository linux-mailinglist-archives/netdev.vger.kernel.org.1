Return-Path: <netdev+bounces-102282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D21090236E
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D491C208CE
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BC613C3CA;
	Mon, 10 Jun 2024 14:02:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04511139566;
	Mon, 10 Jun 2024 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028165; cv=none; b=H+H/M0T8RJ9qvV+NRquoM+tgPTHZcZiGVdewrbv+F5tzMTvPW6SjgPL0av7knPPCb+LrWJ1b4Rj6oHvDbIUaCzZr0gKpwvVH4g2/3Xau46y1T/I2FOrioNIkRL6aOha9alI1S69DI6lnhA9M0FtXtLmSr/Lub6phLYCFQ0al4WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028165; c=relaxed/simple;
	bh=1E/QCPVAo3zQph0r+GGS/Za4870aqIcUJG8oVPfg6Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHmADMjvjAEM72CbYs7PHPxvVJ/XykHPfWxsbepPegm6WTci6Btdj6os4BAVJgrZ2KMqjp9Q0rinGlWiy4ktB5/gvOLj7h/aEiPnRaIpoNtbKp3dAuu4lDQFbgtA8+Po4Vau/cwF2bl9UsxGJFVmespSxZdkVTa7N69NWy8l4G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9905c7c8d6=ms@dev.tdt.de>)
	id 1sGfbe-00Bf9r-7b; Mon, 10 Jun 2024 16:02:42 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGfbd-00CRxv-N2; Mon, 10 Jun 2024 16:02:41 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 6BAE1240053;
	Mon, 10 Jun 2024 16:02:41 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 01B1B240050;
	Mon, 10 Jun 2024 16:02:41 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id BE45636F2E;
	Mon, 10 Jun 2024 16:02:40 +0200 (CEST)
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
Subject: [PATCH net-next v3 02/12] net: dsa: lantiq_gswip: Only allow phy-mode = "internal" on the CPU port
Date: Mon, 10 Jun 2024 16:02:09 +0200
Message-ID: <20240610140219.2795167-3-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610140219.2795167-1-ms@dev.tdt.de>
References: <20240610140219.2795167-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate-ID: 151534::1718028162-CD44C8CF-4B1BDC09/0/0
X-purgate: clean

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Add the CPU port to gswip_xrx200_phylink_get_caps() and
gswip_xrx300_phylink_get_caps(). It connects through a SoC-internal bus,
so the only allowed phy-mode is PHY_INTERFACE_MODE_INTERNAL.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/net/dsa/lantiq_gswip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswi=
p.c
index a557049e34f5..b9c7076ce32f 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1516,6 +1516,7 @@ static void gswip_xrx200_phylink_get_caps(struct ds=
a_switch *ds, int port,
 	case 2:
 	case 3:
 	case 4:
+	case 6:
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  config->supported_interfaces);
 		break;
@@ -1547,6 +1548,7 @@ static void gswip_xrx300_phylink_get_caps(struct ds=
a_switch *ds, int port,
 	case 2:
 	case 3:
 	case 4:
+	case 6:
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  config->supported_interfaces);
 		break;
--=20
2.39.2


