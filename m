Return-Path: <netdev+bounces-53014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 587F68011C9
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1396A281253
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119A44E61F;
	Fri,  1 Dec 2023 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="VH+jQzel"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD33CD54
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 09:36:11 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9b8aa4fc7so32627471fa.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 09:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701452170; x=1702056970; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x57p+X/w2tEsd6GdWAN+PVlTIs+rxhmRjLrPaMCJ7rk=;
        b=VH+jQzelM3qGPNA+5OPUzpU0hbhv1ykhn6i6GzS79vgC2Mv4+avagxrDzzs6aMT6u5
         aSMaEE015IXq4XJcLr0WCTXq5MOme/ccD2Ym4wWAl/qUAuolZ1KJV9G7VZ2PkTEicS0F
         RXCoWszeBIkdRiUCLnt4TE1B+otEdPN7nZXPUNNw1fzUpLgCFNUogQMek4I9BtEHTvSl
         1VfppIO+fWPu9b4mp1fDZ+qaRe7ltPF/lA8bjaSo4zyMgrJjpFUdhnuubrh2g2LPNHWh
         GEVN927p4Hngh0X/4A5tiqg5qcfwYz88INBFUGwdXxQrc8R5Wd0cUK8W+Q06CPOJ2+FQ
         bNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701452170; x=1702056970;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x57p+X/w2tEsd6GdWAN+PVlTIs+rxhmRjLrPaMCJ7rk=;
        b=OABfGtvqf9U+Jsd3kLyz0PW5XeVg6umpk+6QA7wtoVvKQMHssRijMP9LEghd5p4eJM
         eMIFv81LkRxEkfFSD70SZjrz+S8CQ4fvCD9+XrNdysgI0ifm14RwFEqdNRWmiJVYJb8Z
         ytWKgI4Tu6lsYVuJT5GF9PstPqgNTCBWAzNXMsA3HyQycETpJ51dD8pfNpdo/Wg/iRWB
         17jWADjYBuycHPiAxTSpPb4jlj0Y4mclYHjH62yUVUhFrFiIWWH4C57m7b9rbisSFMYs
         qYg9D0M99PabVfXAhUXpaY8lIXxZlDeuOVEVC1go7M56iB8vEW0/absyWd07Srxd8E9E
         zMVQ==
X-Gm-Message-State: AOJu0Yx268SpJgAz09CBqM07SDacuBo04D5BR5BilXH4J9OuwPvOiQBe
	zxKN+42ZymTaQ0VxLyUnTVHN5A==
X-Google-Smtp-Source: AGHT+IEKyCG3+Kp1SnQHbaz/AXf+7pmVpJFrvQpacq30S+mGG66HXCcGNasKl1UsRsvOU3SvoMgooQ==
X-Received: by 2002:a2e:b0d6:0:b0:2c9:c24e:19fe with SMTP id g22-20020a2eb0d6000000b002c9c24e19femr987118ljl.26.1701452169836;
        Fri, 01 Dec 2023 09:36:09 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-176-10-137-178.NA.cust.bahnhof.se. [176.10.137.178])
        by smtp.gmail.com with ESMTPSA id y9-20020a2eb009000000b002c120b99f8csm470327ljk.134.2023.12.01.09.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:36:09 -0800 (PST)
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
Subject: [PATCH net-next 2/3] net: mvmdio: Avoid excessive sleeps in polled mode
Date: Fri,  1 Dec 2023 18:35:44 +0100
Message-Id: <20231201173545.1215940-3-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201173545.1215940-1-tobias@waldekranz.com>
References: <20231201173545.1215940-1-tobias@waldekranz.com>
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
 drivers/net/ethernet/marvell/mvmdio.c | 41 +++++++++++----------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 89f26402f8fb..1de2175269bf 100644
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
@@ -94,23 +88,24 @@ static int orion_mdio_wait_ready(const struct orion_mdio_ops *ops,
 				 struct mii_bus *bus)
 {
 	struct orion_mdio_dev *dev = bus->priv;
-	unsigned long timeout = usecs_to_jiffies(MVMDIO_SMI_TIMEOUT);
-	unsigned long end = jiffies + timeout;
-	int timedout = 0;
+	unsigned long end, timeout;
+	int done, timedout;
 
-	while (1) {
-	        if (ops->is_done(dev))
+	if (dev->err_interrupt <= 0) {
+		if (!read_poll_timeout_atomic(ops->is_done, done, done, 2,
+					      MVMDIO_SMI_TIMEOUT, false, dev))
 			return 0;
-	        else if (timedout)
-			break;
-
-	        if (dev->err_interrupt <= 0) {
-			usleep_range(ops->poll_interval_min,
-				     ops->poll_interval_max);
+	} else {
+		timeout = usecs_to_jiffies(MVMDIO_SMI_TIMEOUT);
+		end = jiffies + timeout;
+		timedout = 0;
+
+		while (1) {
+			if (ops->is_done(dev))
+				return 0;
+			else if (timedout)
+				break;
 
-			if (time_is_before_jiffies(end))
-				++timedout;
-	        } else {
 			/* wait_event_timeout does not guarantee a delay of at
 			 * least one whole jiffie, so timeout must be no less
 			 * than two.
@@ -135,8 +130,6 @@ static int orion_mdio_smi_is_done(struct orion_mdio_dev *dev)
 
 static const struct orion_mdio_ops orion_mdio_smi_ops = {
 	.is_done = orion_mdio_smi_is_done,
-	.poll_interval_min = MVMDIO_SMI_POLL_INTERVAL_MIN,
-	.poll_interval_max = MVMDIO_SMI_POLL_INTERVAL_MAX,
 };
 
 static int orion_mdio_smi_read(struct mii_bus *bus, int mii_id,
@@ -194,8 +187,6 @@ static int orion_mdio_xsmi_is_done(struct orion_mdio_dev *dev)
 
 static const struct orion_mdio_ops orion_mdio_xsmi_ops = {
 	.is_done = orion_mdio_xsmi_is_done,
-	.poll_interval_min = MVMDIO_XSMI_POLL_INTERVAL_MIN,
-	.poll_interval_max = MVMDIO_XSMI_POLL_INTERVAL_MAX,
 };
 
 static int orion_mdio_xsmi_read_c45(struct mii_bus *bus, int mii_id,
-- 
2.34.1


