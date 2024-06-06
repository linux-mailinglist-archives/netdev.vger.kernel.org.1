Return-Path: <netdev+bounces-101311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE868FE1B7
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3591B1F23A8B
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DB413FD99;
	Thu,  6 Jun 2024 08:54:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA07913F443;
	Thu,  6 Jun 2024 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664060; cv=none; b=htZlcgUTwhpxW1XkBaBsFWf2jK5gs/yT7w1W0k6aGNS0pSMKuYQ7kxa9+f31C9rtOa+cjPtoZI7IZtK8c4/28NS0VLMaRhdMKFbI5DSF45DhkyxnTjWLeYc1R0MB3fPVGEAT97RQGzmYkxKPcwIINAcLR9tDLTUfkbgeVf0wo5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664060; c=relaxed/simple;
	bh=Dxzgu1E2bxWwq/MieO5oAXOSUD/JtmEc28wK0XbexZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOq4VTxh/n+/He7upx/UgrKEJBvDxHZ75GfMSjOBB6szIp49MuH12KjfB8K0436SQ8vnXfix9rNBdjPBtWO1HsNCc8vlOom4ppftyZQkCGqH7/twbgerbcRoC3wEiq7ijuYzkYJYYa4FbghW4oytXvhDnyHz+rN4aT+4UruxxUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9901b58ca3=ms@dev.tdt.de>)
	id 1sF8sy-00EJuv-8f; Thu, 06 Jun 2024 10:54:16 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sF8sx-00EJun-O2; Thu, 06 Jun 2024 10:54:15 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 773EA240053;
	Thu,  6 Jun 2024 10:54:15 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 0E9AA240050;
	Thu,  6 Jun 2024 10:54:15 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id B9CD2379F6;
	Thu,  6 Jun 2024 10:54:14 +0200 (CEST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 02/13] net: dsa: lantiq_gswip: Only allow phy-mode = "internal" on the CPU port
Date: Thu,  6 Jun 2024 10:52:23 +0200
Message-ID: <20240606085234.565551-3-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606085234.565551-1-ms@dev.tdt.de>
References: <20240606085234.565551-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1717664056-FD9A0776-C50BB7C2/0/0
X-purgate: clean
X-purgate-type: clean

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Add the CPU port to gswip_xrx200_phylink_get_caps() and
gswip_xrx300_phylink_get_caps(). It connects through a SoC-internal bus,
so the only allowed phy-mode is PHY_INTERFACE_MODE_INTERNAL.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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


