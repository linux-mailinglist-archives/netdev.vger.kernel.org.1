Return-Path: <netdev+bounces-115286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3190F945BC6
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 12:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD38F282937
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6C21DAC4C;
	Fri,  2 Aug 2024 10:05:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD1A1C69D;
	Fri,  2 Aug 2024 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722593138; cv=none; b=pfcMqkzrcavMvPk9nAtJlcOf3KvJ/wCYtjGVqey+VkkAa7WYOydnDH6Fjulg7YhbQqYEW4QhMMUI1H/OUMvK3YoSf8fDHIjdCSZB8d3Z0W/pDYeZBCPpDIUFPz95sqzeqKVn1h2Y4WoD2UkgeMFFmuDr7o98NPR6GFygdRq3UmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722593138; c=relaxed/simple;
	bh=mVqPr5BeRaCt8ln7YVbvkUqRz3dKQwG7bFALGCRL7aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JXSMURhvbprTgaStTzeqRyzo59ZQmdSDD2KQNiaaJsRZnouxt2bLRn6MqjtBPc/jkjUC+GxI/ZkrybMvubP3CU6Zczdf3oqqW8AHxSxmm9x053/rFny+dgxN7y6DiGQmFUR9e2gZt/A1MppqqjOCL4ex72kOM+px5JV/yoS4+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from abreu.molgen.mpg.de (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 266F761E5FE01;
	Fri,  2 Aug 2024 12:04:57 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Roy Lee <roy_lee@accton.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tg3: Add param `short_preamble` to enable MDIO traffic to external PHYs
Date: Fri,  2 Aug 2024 12:04:42 +0200
Message-ID: <20240802100448.10745-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Roy Lee <roy_lee@accton.com>

Add parameter to enable *short preamble* for MAC, so MDIO access to some
external PHY, like BCM54616, can be validated.

Applies to the five platforms below, that have the ethernet controller
BCM5720:

as7116_54x, as7326_56x, as7716_32x-r0, as7716_32xb, and as7816_64x

Verified by mii-tool. (31 is the address of external phy).

    root@sonic:/home/admin# mii-tool -v eth0 -p 31
    using the specified MII index 31.
    eth0: negotiated, link ok
    product info: vendor 00:d8:97, model 17 rev 2
    basic mode: autonegotiation enabled
    basic status: autonegotiation complete, link ok
    capabilities: 1000baseT-HD 1000baseT-FD 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
    advertising: flow-control
    link partner: 1000baseT-FD 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD

Note, this upstreams a patch to the SONiC Linux kernel added in 2018
[1][2][3].

[1]: https://github.com/sonic-net/sonic-linux-kernel/pull/71/
[2]: https://github.com/sonic-net/sonic-linux-kernel/commit/ad754bdcc094f6499b3fd6af067c828b0546f96c
[3]: https://github.com/sonic-net/sonic-buildimage/pull/2318

Signed-off-by: Roy Lee <roy_lee@accton.com>
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/net/ethernet/broadcom/tg3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 0ec5f01551f9..9b4ab201fd9a 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -233,6 +233,10 @@ static int tg3_debug = -1;	/* -1 == use TG3_DEF_MSG_ENABLE as value */
 module_param(tg3_debug, int, 0);
 MODULE_PARM_DESC(tg3_debug, "Tigon3 bitmapped debugging message enable value");
 
+static int short_preamble = 0;
+module_param(short_preamble, int, 0);
+MODULE_PARM_DESC(short_preamble, "Enable short preamble.");
+
 #define TG3_DRV_DATA_FLAG_10_100_ONLY	0x0001
 #define TG3_DRV_DATA_FLAG_5705_10_100	0x0002
 
@@ -1493,6 +1497,11 @@ static void tg3_mdio_config_5785(struct tg3 *tp)
 static void tg3_mdio_start(struct tg3 *tp)
 {
 	tp->mi_mode &= ~MAC_MI_MODE_AUTO_POLL;
+
+	if(short_preamble) {
+	    tp->mi_mode |= MAC_MI_MODE_SHORT_PREAMBLE;
+	}
+
 	tw32_f(MAC_MI_MODE, tp->mi_mode);
 	udelay(80);
 
-- 
2.45.2


