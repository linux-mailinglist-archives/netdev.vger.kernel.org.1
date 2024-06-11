Return-Path: <netdev+bounces-102558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B569903AD6
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217F91F22ECE
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 11:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5416417FAC3;
	Tue, 11 Jun 2024 11:42:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE79517F50A;
	Tue, 11 Jun 2024 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106121; cv=none; b=KXMzsVi4x49vAhDiHZdTNXeNFJSdXyYU37OASlBYV9JedItHnuw4UnsJJLvSpLlC0wtx0f/1pWNrH/Fm4cxQ593aAZR1TGOITbTlxdlB/s8RePr7N5E4DXUT4NXTF4KwmbWo/YN0VkVVNeTYv13E7QHi9OurLKueNJa9kH72LTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106121; c=relaxed/simple;
	bh=hZekxdzg6/DbdtqVNiroTrOJ0Q1iP2Vz3e229k+G84U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fb6BAIuLsqD+4A4JU0L+OVLVOojKhFY3Baxc3P3xyk/jMowu7E2qN1LfMQQ5XeYhToa2RCIRgPaJVe3e508sWWWLORoAslFqiOkGlIYu7G9OBNzBBNfb9ZJE3tFP/uGyACFnxrwiHV4inZAYFO408zsV+b+sJ3Qnc2zwA1Qj8iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9906f4c1d5=ms@dev.tdt.de>)
	id 1sGzsz-002Z1m-PD; Tue, 11 Jun 2024 13:41:57 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGzsz-0003Ow-7s; Tue, 11 Jun 2024 13:41:57 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id F0D7A240053;
	Tue, 11 Jun 2024 13:41:56 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 84486240050;
	Tue, 11 Jun 2024 13:41:56 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 5158829768;
	Tue, 11 Jun 2024 13:41:56 +0200 (CEST)
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
Subject: [PATCH net-next v4 13/13] net: dsa: lantiq_gswip: Improve error message in gswip_port_fdb()
Date: Tue, 11 Jun 2024 13:40:27 +0200
Message-ID: <20240611114027.3136405-14-ms@dev.tdt.de>
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
X-purgate-ID: 151534::1718106117-34A72D11-D8C64E16/0/0
X-purgate-type: clean
X-purgate: clean

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


