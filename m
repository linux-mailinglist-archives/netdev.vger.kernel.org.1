Return-Path: <netdev+bounces-56630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 376AC80FA22
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6FD28230C
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BFF660E7;
	Tue, 12 Dec 2023 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZgtQM8mS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5BCB3
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 14:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702419526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=niWso/AgTSlNDKs+hLJfqSanWTgF91oEfLP5s9hKVlo=;
	b=ZgtQM8mSySScnanpslZXhtJJ3hfJKVfFEAz7Chqirh4BAWsx0TneYgUVA6I8f7HgX8BIPs
	/f9P0Iz/viliQb9vDlp/XvYcUTCcaWQ0B25kB20iF+vvZdQ3XKMA88TmsDCAGpGxFnTaXx
	IZx0uEkuVfayf66KCfucdJaGWqzclVs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-8e3o65mZPNK6NBJqVXLkbg-1; Tue, 12 Dec 2023 17:18:44 -0500
X-MC-Unique: 8e3o65mZPNK6NBJqVXLkbg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-67ee1ca3b05so21871056d6.2
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 14:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419524; x=1703024324;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niWso/AgTSlNDKs+hLJfqSanWTgF91oEfLP5s9hKVlo=;
        b=sQ0BhF4CeR5bp7IvEJdkDQL4N4ZSfIbB+fv/eIYxEsV4Ipy6NTytDzkEmTbftFZX5D
         KtivjWuDg8euOJ9tDanavXzSKEh5SBVBYq/narCdfsZzTUS4rpVXcGC2VgQyVCWfZHLk
         T7shsL4TBVCwNKveeDF6Fe+j9C49qhEuWgXuLsXAC9pxAiuYedMWhpz6gA1AYiUt1HRA
         dFSda7rkr1mCXj4fkkdqJofSS4FIz3kyP0M1lXsv0z23WJ2cQDqqDABhGn1SWUe04TMR
         BvGLv2i/ideQn/kXkzqBhy6LE8bFoaE65dQi9KghPKW17McglC2K36LR5vp9aF5zbVel
         Jjjw==
X-Gm-Message-State: AOJu0YxDUGM7i//ESHIAHwLri75FDCZsHUgz9oTULNjlZA/pWuGVgz7y
	zJvJoUuAWp1Ofu0s/JCITiFa+GdtVAAc0AEvOxmCy3utJAYWIk2n8og+GbrDQr2rSANQM/G9yhB
	cypVfhwLsZ0KZpKlc
X-Received: by 2002:a0c:c210:0:b0:67e:f58a:d6b0 with SMTP id l16-20020a0cc210000000b0067ef58ad6b0mr226800qvh.27.1702419524250;
        Tue, 12 Dec 2023 14:18:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXwgdCMDLzfi+fVcHm7+1qcErjuVF1ZgVVAksnjigHixsYAtg0Q68ahZCHFpj/G+kad1CZTA==
X-Received: by 2002:a0c:c210:0:b0:67e:f58a:d6b0 with SMTP id l16-20020a0cc210000000b0067ef58ad6b0mr226790qvh.27.1702419524008;
        Tue, 12 Dec 2023 14:18:44 -0800 (PST)
Received: from [192.168.1.163] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id uw2-20020a05620a4d8200b0077f103c8ad6sm4050578qkn.82.2023.12.12.14.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:18:43 -0800 (PST)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Tue, 12 Dec 2023 16:18:33 -0600
Subject: [PATCH net v2] net: stmmac: Handle disabled MDIO busses from
 devicetree
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-b4-stmmac-handle-mdio-enodev-v2-1-600171acf79f@redhat.com>
X-B4-Tracking: v=1; b=H4sIADjceGUC/42NQQrDIBBFrxJm3SnRBCtd9R4lC+tMGqFqUZGW4
 N0rOUGX7z94f4fMyXGG67BD4uqyi6GDPA1gNxOejI46gxzlJKQQ+JgxF++Nxa7pxejJReQQiSt
 qKZQmVtoqAz3xTry6z5G/Q+ACSx83l0tM3+OyikP9V68CBV4mK0c7z6smdUtMmylnGz0srbUfm
 X3voM4AAAA=
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Serge Semin <fancer.lancer@gmail.com>, 
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.12.3

Many hardware configurations have the MDIO bus disabled, and are instead
using some other MDIO bus to talk to the MAC's phy.

of_mdiobus_register() returns -ENODEV in this case. Let's handle it
gracefully instead of failing to probe the MAC.

Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers.")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
Changes in v2:
- Improve error handling code (Serge)
- Fix malformed Fixes tag (Simon)
- Link to v1: https://lore.kernel.org/r/20231211-b4-stmmac-handle-mdio-enodev-v1-1-73c20c44f8d6@redhat.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index fa9e7e7040b9..0542cfd1817e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -591,7 +591,11 @@ int stmmac_mdio_register(struct net_device *ndev)
 	new_bus->parent = priv->device;
 
 	err = of_mdiobus_register(new_bus, mdio_node);
-	if (err != 0) {
+	if (err == -ENODEV) {
+		err = 0;
+		dev_info(dev, "MDIO bus is disabled\n");
+		goto bus_register_fail;
+	} else if (err) {
 		dev_err_probe(dev, err, "Cannot register the MDIO bus\n");
 		goto bus_register_fail;
 	}

---
base-commit: bbd220ce4e29ed55ab079007cff0b550895258eb
change-id: 20231211-b4-stmmac-handle-mdio-enodev-82168de68c6a

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>


