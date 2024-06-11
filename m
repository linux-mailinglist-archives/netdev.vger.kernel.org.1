Return-Path: <netdev+bounces-102542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F895903AA1
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF061C23A83
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 11:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D82017C7A2;
	Tue, 11 Jun 2024 11:41:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F5C17C230;
	Tue, 11 Jun 2024 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106069; cv=none; b=OIRoaLfJsNPkY8L64wwJwggkv7h0b+2AibaqSYot+tVTSyUOv8WjcmKCBCkCjLW/W9GyaatvF2qoCz0DTtdUh5OFfrPMOUQZIN1Vlu4iDKwHr0p9yJYfSYp2l8SG+BidpUFja2lhMelYcdeUba8PFnAxodVmNmYMWV4mueKnGrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106069; c=relaxed/simple;
	bh=hP0sLRRO7z5gXu62mMF36bj4dc67b+JdN8oz64AlZLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cc4q55CmOO5cHIY2UxoIiRlfVYAiV90SCjeiM/J0mb26ej/q5PSotV+nGaWSwjmfDAYcBljo0L3OiM5PXPmOgt+4Ghz07CqFEOiRBa5qn0aWv9OL49flyGwcNzCsUC6elOiH7dXwnkK+cl6rKB5ZgEZh/Os6fSiTK6lOIBc7h6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9906f4c1d5=ms@dev.tdt.de>)
	id 1sGzs9-002HXR-3o; Tue, 11 Jun 2024 13:41:05 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGzs8-0026aD-IO; Tue, 11 Jun 2024 13:41:04 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 49309240054;
	Tue, 11 Jun 2024 13:41:04 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id CD59F240053;
	Tue, 11 Jun 2024 13:41:03 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 7711529768;
	Tue, 11 Jun 2024 13:41:03 +0200 (CEST)
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
Subject: [PATCH net-next v4 03/13] net: dsa: lantiq_gswip: Only allow phy-mode = "internal" on the CPU port
Date: Tue, 11 Jun 2024 13:40:17 +0200
Message-ID: <20240611114027.3136405-4-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240611114027.3136405-1-ms@dev.tdt.de>
References: <20240611114027.3136405-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1718106065-AA6BDD95-F9F2136E/0/0
X-purgate-type: clean
X-purgate: clean

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Add the CPU port to gswip_xrx200_phylink_get_caps() and
gswip_xrx300_phylink_get_caps(). It connects through a SoC-internal bus,
so the only allowed phy-mode is PHY_INTERFACE_MODE_INTERNAL.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
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


