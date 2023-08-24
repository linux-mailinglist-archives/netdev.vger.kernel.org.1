Return-Path: <netdev+bounces-30434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F7E78748E
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 17:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F3028159C
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4978113AD9;
	Thu, 24 Aug 2023 15:48:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39782134DE
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 15:48:54 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44E3199F;
	Thu, 24 Aug 2023 08:48:52 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 2054A8609B;
	Thu, 24 Aug 2023 17:48:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692892131;
	bh=H7FM7ibaZ+AGk5z5tKpm5KmKsPsHbA7ASKu0Pd5KuWE=;
	h=From:To:Cc:Subject:Date:From;
	b=XQ5ZqWUaW6StxQF2LrjwD437t1fpL1Q+gl3CzHps57TvOvLXbRJdPTfJ+6PBU3K4M
	 JK2ufVxymKLDflSu6BrwFVwm7JotTIb/gP1vz3gSataV/XJwDFIS+49allJTpFYTnr
	 x71ZUgZtQDdMaucvsModMn99Yo9Dcfe3L6c+Vt9aOGs7R6II6/VrGGwanQIosGwj50
	 56r6zUzBoPCyletjIq2WJXxyGyPqEkkKXmnTWuEqWjuuBHu/b4SXlAOzPzJhASnTyL
	 90raq2VxV2KNytTurs3Y1pCEhTXTCxZp1GK7vU4tdCdUQcFR9kYYFWtyqWo4cRJ1sk
	 9lsxFSQQLp3TA==
From: Lukasz Majewski <lukma@denx.de>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com
Cc: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 1/2] net: dsa: microchip: KSZ9477: Provide functions to access MMD registers
Date: Thu, 24 Aug 2023 17:48:26 +0200
Message-Id: <20230824154827.166274-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Those function are necessary to access MMD (indirect) port registers of
the KSZ9477 device.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/net/dsa/microchip/ksz9477.c | 31 +++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 83b7f2d5c1ea..cb6aa7c668a8 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -43,6 +43,37 @@ static void ksz9477_port_cfg32(struct ksz_device *dev, int port, int offset,
 			   bits, set ? bits : 0);
 }
 
+static void ksz9477_port_mmd_setup(struct ksz_device *dev, uint port, u16 devid,
+				   u16 reg, u16 len)
+{
+	u16 ctrl = PORT_MMD_OP_DATA_NO_INCR;
+
+	if (len > 1)
+		ctrl = PORT_MMD_OP_DATA_INCR_RW;
+
+	ksz_pwrite16(dev, port, REG_PORT_PHY_MMD_SETUP,
+		     MMD_SETUP(PORT_MMD_OP_INDEX, devid));
+	ksz_pwrite16(dev, port, REG_PORT_PHY_MMD_INDEX_DATA, reg);
+	ksz_pwrite16(dev, port, REG_PORT_PHY_MMD_SETUP,
+		     MMD_SETUP(ctrl, devid));
+}
+
+static void ksz9477_port_mmd_read(struct ksz_device *dev, uint port, u16 devid,
+				  u16 reg, u16 *buf, u16 len)
+{
+	ksz9477_port_mmd_setup(dev, port, devid, reg, len);
+	for (; len; buf++, len--)
+		ksz_pread16(dev, port, REG_PORT_PHY_MMD_INDEX_DATA, buf);
+}
+
+static void ksz9477_port_mmd_write(struct ksz_device *dev, uint port, u16 devid,
+				   u16 reg, u16 *buf, u16 len)
+{
+	ksz9477_port_mmd_setup(dev, port, devid, reg, len);
+	for (; len; buf++, len--)
+		ksz_pwrite16(dev, port, REG_PORT_PHY_MMD_INDEX_DATA, *buf);
+}
+
 int ksz9477_change_mtu(struct ksz_device *dev, int port, int mtu)
 {
 	u16 frame_size;
-- 
2.20.1


