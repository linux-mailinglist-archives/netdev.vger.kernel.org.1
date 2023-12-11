Return-Path: <netdev+bounces-56096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902DC80DD22
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C150C1C214F8
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 21:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D3654BFF;
	Mon, 11 Dec 2023 21:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhSO/qrz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F387CB8
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 13:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702330306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3m2lRSq/x6O1AvE2D5Tmo4LBWE3DJjeKHdxsqLlOX9k=;
	b=VhSO/qrzb9qwflrUwK5C4jAAcISs4g5JgJP0dMs5jtaDNO8i+eJTIZq+y4IWRpX8nLfsQM
	8RSwXoEDNmpr6ghakOLGLMTj5bbtbNqvHOJXcoR6BQo+kIBpExrVQdnGsBsg94B0pMDaIM
	1IpXsSeRGSYNMC6AOMl3Xl9BvSGXWv8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-CW85fzqkMS2YhpT2qWkCnA-1; Mon, 11 Dec 2023 16:31:40 -0500
X-MC-Unique: CW85fzqkMS2YhpT2qWkCnA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67bd67fe537so70468946d6.2
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 13:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702330299; x=1702935099;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3m2lRSq/x6O1AvE2D5Tmo4LBWE3DJjeKHdxsqLlOX9k=;
        b=meuhgz+w1lV5JF2Yj6sJcsdgNJ8+1M8mA40MSrGlM59q33EH0SJ5lTQnMab/MNIz7Q
         IEOZqTo0gNEWd7d0iYa2WO25VSjmal8ZHwEPh+Tv8q+Usn4mdbX12DS/dtcEdyuGVRaR
         CmuSNl002TyQAjcHw8Qs7FB2bFZDVc9tTG/GuTvPY+UiJGj0IEN89MfenZDEhw/4TLN5
         SoYkpeJ0tLuFsXRnZ8Tf77ip0ckUE9jACK/bs2vHpecVyG8GVjBbVP71GufYpW4owOjs
         bcl2Dnt/XZBb4os2FDHwaS/TZDiNU6GIMbFuHfjG/baSGUDOF3QuarZRRIm83SygQqPi
         9m9w==
X-Gm-Message-State: AOJu0YxbDA+odnKjxvf7gPbHn91IEVQCAhKBQgthQxzGb47tH1K0ERKf
	mBjwZ3AuyNLfe4rrp2wLxf2G1A2MvU+oNx4KwjWsUc3mkxadZcCUuOjjXvMb4Kc4xofg9r+Yp/l
	0bh0hI3Gzo3PDQTo9
X-Received: by 2002:a0c:fb42:0:b0:67a:98bc:4b45 with SMTP id b2-20020a0cfb42000000b0067a98bc4b45mr6325900qvq.25.1702330299796;
        Mon, 11 Dec 2023 13:31:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfOr5Qchzr/j+FGRg3RKaC+dHzH5m7JUsZDA1GvPXcQq/y9SyQGFh3KmV3W0rrIbwNAaai2g==
X-Received: by 2002:a0c:fb42:0:b0:67a:98bc:4b45 with SMTP id b2-20020a0cfb42000000b0067a98bc4b45mr6325895qvq.25.1702330299614;
        Mon, 11 Dec 2023 13:31:39 -0800 (PST)
Received: from [192.168.1.164] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id t18-20020a05621405d200b00677a12f11bcsm3579945qvz.24.2023.12.11.13.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 13:31:39 -0800 (PST)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Mon, 11 Dec 2023 15:31:17 -0600
Subject: [PATCH net] net: stmmac: Handle disabled MDIO busses from
 devicetree
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231211-b4-stmmac-handle-mdio-enodev-v1-1-73c20c44f8d6@redhat.com>
X-B4-Tracking: v=1; b=H4sIAKR/d2UC/x3MQQrCMBBG4auUWTvgxBKCVxEXMfOrAyaRpJRC6
 d0NLj8evJ06mqHTddqpYbVutQzIaaL0juUFNh0md3YXcSL8mLkvOcfEI+sHnNUqo1TFysGJDwo
 fko80Ft+Gp23//Y0KFrofxw8QHoykcwAAAA==
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Serge Semin <fancer.lancer@gmail.com>, 
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.12.3

Many hardware configurations have the MDIO bus disabled, and are instead
using some other MDIO bus to talk to the MAC's phy.

of_mdiobus_register() returns -ENODEV in this case. Let's handle it
gracefully instead of failing to probe the MAC.

Fixes: 47dd7a540b8a (net: add support for STMicroelectronics Ethernet controllers.")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index fa9e7e7040b9..a39be15d41a8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -591,7 +591,13 @@ int stmmac_mdio_register(struct net_device *ndev)
 	new_bus->parent = priv->device;
 
 	err = of_mdiobus_register(new_bus, mdio_node);
-	if (err != 0) {
+	if (err) {
+		if (err == -ENODEV) {
+			/* The bus is disabled in the devicetree, that's ok */
+			mdiobus_free(new_bus);
+			return 0;
+		}
+
 		dev_err_probe(dev, err, "Cannot register the MDIO bus\n");
 		goto bus_register_fail;
 	}

---
base-commit: bbd220ce4e29ed55ab079007cff0b550895258eb
change-id: 20231211-b4-stmmac-handle-mdio-enodev-82168de68c6a

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>


