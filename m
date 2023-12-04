Return-Path: <netdev+bounces-53436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DED802F9C
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 11:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111F2280E7C
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B1E1EB5C;
	Mon,  4 Dec 2023 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="JgVEDQjg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A590FB6
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 02:08:26 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bc22c836bso5666189e87.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 02:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701684505; x=1702289305; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eupC3o2v88nkyvmlhi7dfTAJJixZuJxhtsJieZvcVs4=;
        b=JgVEDQjgse/LYYtQOd6Y6R1uqZQt+ZD34hIr5+zNdNdDlZ4Iyf5ju6JUZzk+MrqVh7
         E2GWmQs8U9+mqjvzjKO4Xm+HR1I+rq9fXNkt4GotvBRLXKN8yBOnXiTI4Qzaf/lVjnGr
         mRbmwI5E36G+ENH4sWaskKbeSYE3Ybjn9En/aBnKLX8WHZbPyGwaPkkn9EdJvscH1SfR
         B+zxYE0h4ClTxzfGCdrvpvPD0zRYi7Ty2IL2lRaICoPoKoGeBiuV0k+pqDEyQs8U0wsk
         Af8Kb4viuHMaeGzY+XFj67HMrTfwkBKCsnkGAiCF4IxSgekwHwh7JK4W+fsOZpCV8fES
         p3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684505; x=1702289305;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eupC3o2v88nkyvmlhi7dfTAJJixZuJxhtsJieZvcVs4=;
        b=jQz2EDyxD5ybQeszrhvgcG7cJQ4qb2xhR0GR/wopgru3D4tBghFvcKmG6WBPx/nA5Q
         U11Fpf80IXRU7yye3kUsxTzAh+OI3WpHvYcxOkySmKVOH6JkpgUsrOi/l6zJkgZsKEuI
         UGOoFXcjbW5Yh7uUxJliDWNjmksxYg45uZZdlh37bPQlFJrEGLWYblABJwDdVI82tEps
         gZO+Z8Vjny5ItUD9PtYZTJrm+XY0mbBaLtDa/Kgzt2DDysb2zQnFH/OIDv2m/HN2Pv97
         mqsC/ulvInsI635CkL0DIIWsKW5Cf5Lzijm8H0dWSfi474dEBWWM8F974tpOImsoZMLo
         Iegg==
X-Gm-Message-State: AOJu0Yzrs4taVBYBIA8DWxSr2O5fUY4p3u9IwBfSSrWYbugQpwLTQ5DS
	dmZAu6M8D18pkr89mwG0N2HaPgep+HfUaRaEdgk=
X-Google-Smtp-Source: AGHT+IE/N2VQf5IgRHPQlqZw8f/J2Jpsiwa/nIx+x0CTNzxyWV0S1gZ5ZscCubKe9pBllkeLWypXqg==
X-Received: by 2002:a05:6512:3b0e:b0:50b:f351:6fb7 with SMTP id f14-20020a0565123b0e00b0050bf3516fb7mr1126850lfv.0.1701684505045;
        Mon, 04 Dec 2023 02:08:25 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id u29-20020a19791d000000b0050beead375bsm553643lfc.57.2023.12.04.02.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 02:08:24 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 net-next 2/3] net: mvmdio: Avoid excessive sleeps in polled mode
Date: Mon,  4 Dec 2023 11:08:10 +0100
Message-Id: <20231204100811.2708884-3-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204100811.2708884-1-tobias@waldekranz.com>
References: <20231204100811.2708884-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Before this change, when operating in polled mode, i.e. no IRQ is
available, every individual C45 access would be hit with a 150us sleep
after the bus access.

For example, on a board with a CN9130 SoC connected to an MV88X3310
PHY, a single C45 read would take around 165us:

    root@infix:~$ mdio f212a600.mdio-mii mmd 4:1 bench 0xc003
    Performed 1000 reads in 165ms

By replacing the long sleep with a tighter poll loop, we observe a 10x
increase in bus throughput:

    root@infix:~$ mdio f212a600.mdio-mii mmd 4:1 bench 0xc003
    Performed 1000 reads in 15ms

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/ethernet/marvell/mvmdio.c | 53 ++++++++-------------------
 1 file changed, 16 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 89f26402f8fb..5f66f779e56f 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -58,11 +59,6 @@
  * - Armada 370       (Globalscale Mirabox):   41us to 43us (Polled)
  */
 #define MVMDIO_SMI_TIMEOUT		1000 /* 1000us = 1ms */
-#define MVMDIO_SMI_POLL_INTERVAL_MIN	45
-#define MVMDIO_SMI_POLL_INTERVAL_MAX	55
-
-#define MVMDIO_XSMI_POLL_INTERVAL_MIN	150
-#define MVMDIO_XSMI_POLL_INTERVAL_MAX	160
 
 struct orion_mdio_dev {
 	void __iomem *regs;
@@ -84,8 +80,6 @@ enum orion_mdio_bus_type {
 
 struct orion_mdio_ops {
 	int (*is_done)(struct orion_mdio_dev *);
-	unsigned int poll_interval_min;
-	unsigned int poll_interval_max;
 };
 
 /* Wait for the SMI unit to be ready for another operation
@@ -94,34 +88,23 @@ static int orion_mdio_wait_ready(const struct orion_mdio_ops *ops,
 				 struct mii_bus *bus)
 {
 	struct orion_mdio_dev *dev = bus->priv;
-	unsigned long timeout = usecs_to_jiffies(MVMDIO_SMI_TIMEOUT);
-	unsigned long end = jiffies + timeout;
-	int timedout = 0;
+	unsigned long timeout;
+	int done;
 
-	while (1) {
-	        if (ops->is_done(dev))
+	if (dev->err_interrupt <= 0) {
+		if (!read_poll_timeout_atomic(ops->is_done, done, done, 2,
+					      MVMDIO_SMI_TIMEOUT, false, dev))
+			return 0;
+	} else {
+		/* wait_event_timeout does not guarantee a delay of at
+		 * least one whole jiffie, so timeout must be no less
+		 * than two.
+		 */
+		timeout = max(usecs_to_jiffies(MVMDIO_SMI_TIMEOUT), 2);
+
+		if (wait_event_timeout(dev->smi_busy_wait,
+				       ops->is_done(dev), timeout))
 			return 0;
-	        else if (timedout)
-			break;
-
-	        if (dev->err_interrupt <= 0) {
-			usleep_range(ops->poll_interval_min,
-				     ops->poll_interval_max);
-
-			if (time_is_before_jiffies(end))
-				++timedout;
-	        } else {
-			/* wait_event_timeout does not guarantee a delay of at
-			 * least one whole jiffie, so timeout must be no less
-			 * than two.
-			 */
-			if (timeout < 2)
-				timeout = 2;
-			wait_event_timeout(dev->smi_busy_wait,
-				           ops->is_done(dev), timeout);
-
-			++timedout;
-	        }
 	}
 
 	dev_err(bus->parent, "Timeout: SMI busy for too long\n");
@@ -135,8 +118,6 @@ static int orion_mdio_smi_is_done(struct orion_mdio_dev *dev)
 
 static const struct orion_mdio_ops orion_mdio_smi_ops = {
 	.is_done = orion_mdio_smi_is_done,
-	.poll_interval_min = MVMDIO_SMI_POLL_INTERVAL_MIN,
-	.poll_interval_max = MVMDIO_SMI_POLL_INTERVAL_MAX,
 };
 
 static int orion_mdio_smi_read(struct mii_bus *bus, int mii_id,
@@ -194,8 +175,6 @@ static int orion_mdio_xsmi_is_done(struct orion_mdio_dev *dev)
 
 static const struct orion_mdio_ops orion_mdio_xsmi_ops = {
 	.is_done = orion_mdio_xsmi_is_done,
-	.poll_interval_min = MVMDIO_XSMI_POLL_INTERVAL_MIN,
-	.poll_interval_max = MVMDIO_XSMI_POLL_INTERVAL_MAX,
 };
 
 static int orion_mdio_xsmi_read_c45(struct mii_bus *bus, int mii_id,
-- 
2.34.1


