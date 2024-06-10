Return-Path: <netdev+bounces-102233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A62C29020C9
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 13:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535331F22A34
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BBD80630;
	Mon, 10 Jun 2024 11:54:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669898060B;
	Mon, 10 Jun 2024 11:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020490; cv=none; b=QtfM/fpENLJ/MEN6zuFJcYgqWcxvlIadc25RHok2xMgLMAPPH0iRqPSNRRDDSJMX4KrEIV2RClXkr+8QdIt2TwSk0gxtG0xCs+n/Uufdgs06U6b4Kz3tjUJCKlXKKwiNh9/Q+8fDuisI1pBjbDRJibJoRuphliXdQjTYJYwrntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020490; c=relaxed/simple;
	bh=1E/QCPVAo3zQph0r+GGS/Za4870aqIcUJG8oVPfg6Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3lmxqipKa4CXP4UHaNZrLZOjKQRDUXJjehYHE6O+wM+zcAk+rJG5u4EfNVvKRFPKj2rngWRfZ7IzmGDqjCUPpNRfdqkqmSysElxf6OAMKbMVP2M0G9TlLT7LzsyttibL88HKJdBoyA/Uf9a/AyKn1LOWLL4pR9Xj++bEr6GEd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9905c7c8d6=ms@dev.tdt.de>)
	id 1sGdbr-00ADpu-9V; Mon, 10 Jun 2024 13:54:47 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGdbq-005YZw-Nk; Mon, 10 Jun 2024 13:54:46 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 725FD240053;
	Mon, 10 Jun 2024 13:54:46 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 05391240050;
	Mon, 10 Jun 2024 13:54:46 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id B13B826128;
	Mon, 10 Jun 2024 13:54:45 +0200 (CEST)
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
Subject: [PATCH net-next v2 02/12] net: dsa: lantiq_gswip: Only allow phy-mode = "internal" on the CPU port
Date: Mon, 10 Jun 2024 13:53:50 +0200
Message-ID: <20240610115400.2759500-3-ms@dev.tdt.de>
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
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1718020487-1B4A162D-C3367F85/0/0

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


