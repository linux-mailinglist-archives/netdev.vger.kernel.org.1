Return-Path: <netdev+bounces-233474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B704C13FC3
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 11:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725051884CA7
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 10:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0AA3002AA;
	Tue, 28 Oct 2025 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWSimMO8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FBE2D8782
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645723; cv=none; b=EtWSQYtfSeOmDBDV5bu6wG9a5muloNR36J4K6lr4S0gZRbXM1iGELbaKs68MZOWzwQKNhagtGUPnim2p9KOHQsRTL/QjyObDKwdZKjl7fSwVq8Lj9oMLeRhZ42F+UUEZtNBKnoAg/N9BBSZMHITJW46rxldB3dYj3LJtxSZyWF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645723; c=relaxed/simple;
	bh=g1sXxrWurwGP3WSnAqzAbey+65Dx1mpNNLuBE9CW9t0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p3RmKystZl4sxKRmFADeKBMKxxhr1aWIfpwW3C9qgmdy3HDayG2W9wRBtYUOon8nnHlfoDBccqeRV6UM8bevd96nc7SQqcVxwp5CXiExTppv6hzz6Arn3ISm/GKOoxaq5vwgh9ovGxQotgBG0M0zS+AbNnFsXxHX7WrzeRBNhgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWSimMO8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2947d345949so49675675ad.3
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761645720; x=1762250520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WjJlNaiC67jVbiD/DhPsOt3Z9Q6OZNGG2oz/0pSqa/4=;
        b=RWSimMO881vlTjU23lI4N147wQ2uSIbNFD7ALNdQNpr/lDRCrtpxA20Uf0sXN3mYU2
         DHjOc87kf3a9n0OyXPx4ZQIkyJ4Q4HovMk8KMvDPhJqzDj8Kdf9lUY68O9OoxlVdZ0qD
         X+GH31bVMeECzKFxOaqrtyDTHjnfcxKAOR/ZWZ4ACLAwkwpeoLqQTJnI41xkQ+LM/N5M
         1pbQW6aTWSKJcx6a+Bly0c9T4/C+AUGVgB4hh8QA2hy/2EDqRMkznNsNnGCg+/TsxuWI
         vI5HPBcAnXV2dClyegk+CEfsJsTOcz6uttWZIsIQJTLqZjYLRCXhPjwWgQEa6aq24fwY
         RDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761645720; x=1762250520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WjJlNaiC67jVbiD/DhPsOt3Z9Q6OZNGG2oz/0pSqa/4=;
        b=telIT/OujA4RmHGA4nb6eon7xruV12d5BRVqpn1XJ0D0xwQchd6+2Z5k5BT3j1yP3U
         IxHDzubJFHa0lGyLawjNYHJVuGOBkoc2gr/nOCoSi9ZFxUkGFLZ8XFNs/2B6LJs1rJA7
         xt7Swdwn0x9bRmw1iV5mpyEvFgI2SnmXNjhYpZq63DfKzgXiaMIUzhzkqZvJno4tBkkU
         YBCo4g3eiWYnau3gfg1xW6kp04sjmq8PJ/qEB+UToKldGKaQt9YE+d5M6LC1bt2U33tG
         ELe8/yR0uJfrrPXxQMxpX5yv3wPIoRfdnmZWIp/V0cMqLu8JU5kBODBC0zZu76c7Q75w
         uFbA==
X-Forwarded-Encrypted: i=1; AJvYcCXQw4d4NEm2i3f9HcmPBY/Y3ZwG3/Eg4qONZPok/CP63xU8IXb38y0UvdwCPWbKgJOQYUG829k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAkTLRHtR9mTmCvrhPUxKTBdtKGWcBU/LcwAG/+6WlZbixz3AM
	ivXYs6H5w6o3Pj3wqIKT6prgmH+9zdPNDxwpp5Fmt4d6CLfwx6WEzwRt
X-Gm-Gg: ASbGncvZ/fXxnuwmAu8VTQNT4uiOOd6+AhhzessQoFXl+wLFa0ylhUFGzcHJPIAqlgv
	rOgR05yi53VXOOXsSSs2i6WG7tDmN+yyQTcNYsHW3ZnIml5lVSWr8X0npSOeZ2lE48HOIrPPDjE
	Rmd/26QoaY92mWERAv9JViPXdecDJ4GOcc7by5ak2Cx9BodHzuZkby5E43V/zOaJd0QOiz+9cK8
	MBTemMktV71/LpCZkP5wWMQpmSLhdOpGzffaV2PzmNYel/S7jiY0sBEau4dw6q6Cm2+C1JUUAF6
	phrRZ3iIuePs9rpkiXRAWmQWYWd+JJkIXYtl+AqECuKYlYcjxLR6n4CHnSxItGx1JZnoiqg3NsK
	73TZGx9KrRW4SF4haXWmCQudyqYUCY4zcBrZcdAb+rVs98j1/9ZAnd5y/wlnbNG73eScdGlREd0
	PRoOsYFNHPM8CWy3YTrnACnxxrAkqk1X1H
X-Google-Smtp-Source: AGHT+IFBwhXgtlQjbPIQs9mfzQ/NJHBYSta+M6EJBA9khdS+EpFTEJIi51fCI9JC1hFLkRL4H7vzlw==
X-Received: by 2002:a17:902:ea08:b0:246:7a43:3f66 with SMTP id d9443c01a7336-294cb37a907mr35672335ad.7.1761645720035;
        Tue, 28 Oct 2025 03:02:00 -0700 (PDT)
Received: from localhost.localdomain ([115.245.20.186])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40b1esm113298805ad.73.2025.10.28.03.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 03:01:59 -0700 (PDT)
From: Dharanitharan R <dharanitharan725@gmail.com>
To: sammy@sammy.net
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dharanitharan R <dharanitharan725@gmail.com>
Subject: [PATCH] net: i825xx: replace printk() with pr_*() macros for cleaner logging
Date: Tue, 28 Oct 2025 10:01:27 +0000
Message-ID: <20251028100127.14839-1-dharanitharan725@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch replaces printk() calls in sun3_82586.c with appropriate pr_*()
macros (pr_err, pr_info, etc.) according to Linux kernel logging conventions.

Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>
---
 drivers/net/ethernet/i825xx/sun3_82586.c | 140 +++++++++++++----------
 1 file changed, 79 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ethernet/i825xx/sun3_82586.c b/drivers/net/ethernet/i825xx/sun3_82586.c
index 58a3d28d938c..e42d78e729fd 100644
--- a/drivers/net/ethernet/i825xx/sun3_82586.c
+++ b/drivers/net/ethernet/i825xx/sun3_82586.c
@@ -48,6 +48,7 @@ static int fifo=0x8;	/* don't change */
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
+#include <linux/printk.h> 
 
 #include "sun3_82586.h"
 
@@ -103,16 +104,18 @@ sizeof(nop_cmd) = 8;
     if(!p->scb->cmd_cuc) break; \
     DELAY_18(); \
     if(i == 16383) { \
-      printk("%s: scb_cmd timed out: %04x,%04x .. disabling i82586!!\n",dev->name,p->scb->cmd_cuc,p->scb->cus); \
-       if(!p->reseted) { p->reseted = 1; sun3_reset586(); } } } }
+        netdev_err(dev, "scb_cmd timed out: %04x,%04x .. disabling i82586!!\n",
+           p->scb->cmd_cuc, p->scb->cus);
+		if(!p->reseted) { p->reseted = 1; sun3_reset586(); } } } }
 
 #define WAIT_4_SCB_CMD_RUC() { int i; \
   for(i=0;i<16384;i++) { \
     if(!p->scb->cmd_ruc) break; \
     DELAY_18(); \
     if(i == 16383) { \
-      printk("%s: scb_cmd (ruc) timed out: %04x,%04x .. disabling i82586!!\n",dev->name,p->scb->cmd_ruc,p->scb->rus); \
-       if(!p->reseted) { p->reseted = 1; sun3_reset586(); } } } }
+      netdev_err(dev, "scb_cmd (ruc) timed out: %04x,%04x .. disabling i82586!!\n",
+           p->scb->cmd_ruc, p->scb->rus);
+		if(!p->reseted) { p->reseted = 1; sun3_reset586(); } } } }
 
 #define WAIT_4_STAT_COMPL(addr) { int i; \
    for(i=0;i<32767;i++) { \
@@ -271,7 +274,7 @@ static void alloc586(struct net_device *dev)
 	DELAY(1);
 
 	if(p->iscp->busy)
-		printk("%s: Init-Problems (alloc).\n",dev->name);
+		netdev_err(dev, "Init-Problems (alloc).\n");
 
 	p->reseted = 0;
 
@@ -348,8 +351,7 @@ static int __init sun3_82586_probe1(struct net_device *dev,int ioaddr)
 	/* copy in the ethernet address from the prom */
 	eth_hw_addr_set(dev, idprom->id_ethaddr);
 
-	printk("%s: SUN3 Intel 82586 found at %lx, ",dev->name,dev->base_addr);
-
+	netdev_info(dev, "SUN3 Intel 82586 found at %lx\n", dev->base_addr);
 	/*
 	 * check (or search) IO-Memory, 32K
 	 */
@@ -359,12 +361,14 @@ static int __init sun3_82586_probe1(struct net_device *dev,int ioaddr)
 	dev->mem_end = dev->mem_start + size;
 
 	if(size != 0x2000 && size != 0x4000 && size != 0x8000) {
-		printk("\n%s: Illegal memory size %d. Allowed is 0x2000 or 0x4000 or 0x8000 bytes.\n",dev->name,size);
+		netdev_err(dev, "Illegal memory size %d. Allowed is 0x2000 or 0x4000 or 0x8000 bytes.\n",
+           size);
 		retval = -ENODEV;
 		goto out;
 	}
 	if(!check586(dev,(char *) dev->mem_start,size)) {
-		printk("?memcheck, Can't find memory at 0x%lx with size %d!\n",dev->mem_start,size);
+		netdev_err(dev, "memcheck: Can't find memory at 0x%lx with size %d!\n",
+           dev->mem_start, size);
 		retval = -ENODEV;
 		goto out;
 	}
@@ -385,7 +389,8 @@ static int __init sun3_82586_probe1(struct net_device *dev,int ioaddr)
 		((struct priv *)netdev_priv(dev))->num_recv_buffs =
 							NUM_RECV_BUFFS_32;
 
-	printk("Memaddr: 0x%lx, Memsize: %d, IRQ %d\n",dev->mem_start,size, dev->irq);
+	netdev_info(dev, "Memaddr: 0x%lx, Memsize: %d, IRQ %d\n",
+            dev->mem_start, size, dev->irq);
 
 	dev->netdev_ops		= &sun3_82586_netdev_ops;
 	dev->watchdog_timeo	= HZ/20;
@@ -429,7 +434,7 @@ static int init586(struct net_device *dev)
 	if(dev->flags & IFF_ALLMULTI) {
 		int len = ((char *) p->iscp - (char *) ptr - 8) / 6;
 		if(num_addrs > len)	{
-			printk("%s: switching to promisc. mode\n",dev->name);
+			netdev_info(dev, "switching to promisc. mode\n");
 			cfg_cmd->promisc = 1;
 		}
 	}
@@ -447,7 +452,7 @@ static int init586(struct net_device *dev)
 
 	if((swab16(cfg_cmd->cmd_status) & (STAT_OK|STAT_COMPL)) != (STAT_COMPL|STAT_OK))
 	{
-		printk("%s: configure command failed: %x\n",dev->name,swab16(cfg_cmd->cmd_status));
+		netdev_err(dev, "configure command failed: %x\n", swab16(cfg_cmd->cmd_status));
 		return 1;
 	}
 
@@ -471,7 +476,8 @@ static int init586(struct net_device *dev)
 	WAIT_4_STAT_COMPL(ias_cmd);
 
 	if((swab16(ias_cmd->cmd_status) & (STAT_OK|STAT_COMPL)) != (STAT_OK|STAT_COMPL)) {
-		printk("%s (82586): individual address setup command failed: %04x\n",dev->name,swab16(ias_cmd->cmd_status));
+		netdev_err(dev, "(82586): individual address setup command failed: %04x\n",
+           swab16(ias_cmd->cmd_status));
 		return 1;
 	}
 
@@ -494,7 +500,7 @@ static int init586(struct net_device *dev)
 
 	if(!(swab16(tdr_cmd->cmd_status) & STAT_COMPL))
 	{
-		printk("%s: Problems while running the TDR.\n",dev->name);
+	    netdev_warn(dev, "Problems while running the TDR.\n");	
 	}
 	else
 	{
@@ -507,16 +513,16 @@ static int init586(struct net_device *dev)
 		if(result & TDR_LNK_OK)
 			;
 		else if(result & TDR_XCVR_PRB)
-			printk("%s: TDR: Transceiver problem. Check the cable(s)!\n",dev->name);
+			netdev_warn(dev, "TDR: Transceiver problem. Check the cable(s)!\n");
 		else if(result & TDR_ET_OPN)
-			printk("%s: TDR: No correct termination %d clocks away.\n",dev->name,result & TDR_TIMEMASK);
+			netdev_warn(dev, "TDR: No correct termination %d clocks away.\n", result & TDR_TIMEMASK);
 		else if(result & TDR_ET_SRT)
 		{
 			if (result & TDR_TIMEMASK) /* time == 0 -> strange :-) */
-				printk("%s: TDR: Detected a short circuit %d clocks away.\n",dev->name,result & TDR_TIMEMASK);
+				netdev_warn(dev, "TDR: Detected a short circuit %d clocks away.\n", result & TDR_TIMEMASK);
 		}
 		else
-			printk("%s: TDR: Unknown status %04x\n",dev->name,result);
+			netdev_warn(dev, "TDR: Unknown status %04x\n", result);
 	}
 
 	/*
@@ -542,7 +548,7 @@ static int init586(struct net_device *dev)
 		WAIT_4_STAT_COMPL(mc_cmd);
 
 		if( (swab16(mc_cmd->cmd_status) & (STAT_COMPL|STAT_OK)) != (STAT_COMPL|STAT_OK) )
-			printk("%s: Can't apply multicast-address-list.\n",dev->name);
+	       netdev_err(dev, "Can't apply multicast-address-list.\n");
 	}
 
 	/*
@@ -583,7 +589,7 @@ static int init586(struct net_device *dev)
 		ptr = (char *) ptr + sizeof(struct tbd_struct);
 		if(ptr > (void *)dev->mem_end)
 		{
-			printk("%s: not enough shared-mem for your configuration!\n",dev->name);
+			netdev_err(dev, "not enough shared-mem for your configuration!\n");
 			return 1;
 		}
 		memset((char *)(p->xmit_cmds[i]) ,0, sizeof(struct transmit_cmd_struct));
@@ -693,7 +699,7 @@ static irqreturn_t sun3_82586_interrupt(int irq,void *dev_id)
 	p = netdev_priv(dev);
 
 	if(debuglevel > 1)
-		printk("I");
+		netdev_dbg(dev, "I");
 
 	WAIT_4_SCB_CMD(); /* wait for last command	*/
 
@@ -707,7 +713,7 @@ static irqreturn_t sun3_82586_interrupt(int irq,void *dev_id)
 
 		if(stat & STAT_RNR) /* RU went 'not ready' */
 		{
-			printk("(R)");
+			netdev_dbg(dev, "(R)");
 			if(p->scb->rus & RU_SUSPEND) /* special case: RU_SUSPEND */
 			{
 				WAIT_4_SCB_CMD();
@@ -717,7 +723,8 @@ static irqreturn_t sun3_82586_interrupt(int irq,void *dev_id)
 			}
 			else
 			{
-				printk("%s: Receiver-Unit went 'NOT READY': %04x/%02x.\n",dev->name,(int) stat,(int) p->scb->rus);
+				netdev_warn(dev, "Receiver-Unit went 'NOT READY': %04x/%02x.\n",
+            (int) stat, (int) p->scb->rus);
 				sun3_82586_rnr_int(dev);
 			}
 		}
@@ -729,24 +736,25 @@ static irqreturn_t sun3_82586_interrupt(int irq,void *dev_id)
 		if(stat & STAT_CNA)	/* CU went 'not ready' */
 		{
 			if(netif_running(dev))
-				printk("%s: oops! CU has left active state. stat: %04x/%02x.\n",dev->name,(int) stat,(int) p->scb->cus);
+		     netdev_warn(dev, "oops! CU has left active state. stat: %04x/%02x.\n",
+            (int) stat, (int) p->scb->cus);
 		}
 #endif
 
 		if(debuglevel > 1)
-			printk("%d",cnt++);
+			netdev_dbg(dev, "%d", cnt++);
 
 		WAIT_4_SCB_CMD(); /* wait for ack. (sun3_82586_xmt_int can be faster than ack!!) */
 		if(p->scb->cmd_cuc)	 /* timed out? */
 		{
-			printk("%s: Acknowledge timed out.\n",dev->name);
+			netdev_warn(dev, "Acknowledge timed out.\n");
 			sun3_disint();
 			break;
 		}
 	}
 
 	if(debuglevel > 1)
-		printk("i");
+		netdev_dbg(dev, "i");
 	return IRQ_HANDLED;
 }
 
@@ -763,7 +771,7 @@ static void sun3_82586_rcv_int(struct net_device *dev)
 	struct priv *p = netdev_priv(dev);
 
 	if(debuglevel > 0)
-		printk("R");
+		netdev_dbg(dev, "R");
 
 	for(;(status = p->rfd_top->stat_high) & RFD_COMPL;)
 	{
@@ -798,7 +806,7 @@ static void sun3_82586_rcv_int(struct net_device *dev)
 						totlen += rstat & RBD_MASK;
 						if(!rstat)
 						{
-							printk("%s: Whoops .. no end mark in RBD list\n",dev->name);
+							netdev_err(dev, "Whoops .. no end mark in RBD list\n");
 							break;
 						}
 						rbd->status = 0;
@@ -806,13 +814,13 @@ static void sun3_82586_rcv_int(struct net_device *dev)
 					}
 					totlen += rstat & RBD_MASK;
 					rbd->status = 0;
-					printk("%s: received oversized frame! length: %d\n",dev->name,totlen);
+					netdev_warn(dev, "received oversized frame! length: %d\n", totlen);
 					dev->stats.rx_dropped++;
 			 }
 		}
 		else /* frame !(ok), only with 'save-bad-frames' */
 		{
-			printk("%s: oops! rfd-error-status: %04x\n",dev->name,status);
+			netdev_err(dev, "oops! rfd-error-status: %04x\n", status);
 			dev->stats.rx_errors++;
 		}
 		p->rfd_top->stat_high = 0;
@@ -824,7 +832,7 @@ static void sun3_82586_rcv_int(struct net_device *dev)
 		p->scb->rfa_offset = make16(p->rfd_top);
 
 		if(debuglevel > 0)
-			printk("%d",cnt++);
+			netdev_dbg(dev, "%d", cnt++);
 	}
 
 	if(automatic_resume)
@@ -844,7 +852,7 @@ static void sun3_82586_rcv_int(struct net_device *dev)
 				break;
 			DELAY_16();
 			if(i == 1023)
-				printk("%s: RU hasn't fetched next RFD (not busy/complete)\n",dev->name);
+		       netdev_warn(dev, "RU hasn't fetched next RFD (not busy/complete)\n");
 		}
 	}
 #endif
@@ -855,21 +863,25 @@ static void sun3_82586_rcv_int(struct net_device *dev)
 		int i;
 		volatile struct rfd_struct *rfds=p->rfd_top;
 		volatile struct rbd_struct *rbds;
-		printk("%s: received a FC intr. without having a frame: %04x %d\n",dev->name,status,old_at_least);
+		netdev_warn(dev, "received a FC intr. without having a frame: %04x %d\n",
+            status, old_at_least);
+
 		for(i=0;i< (p->num_recv_buffs+4);i++)
 		{
 			rbds = (struct rbd_struct *) make32(rfds->rbd_offset);
-			printk("%04x:%04x ",rfds->status,rbds->status);
+			netdev_dbg(dev, "%04x:%04x ", rfds->status, rbds->status);
 			rfds = (struct rfd_struct *) make32(rfds->next);
 		}
-		printk("\nerrs: %04x %04x stat: %04x\n",(int)p->scb->rsc_errs,(int)p->scb->ovrn_errs,(int)p->scb->status);
-		printk("\nerrs: %04x %04x rus: %02x, cus: %02x\n",(int)p->scb->rsc_errs,(int)p->scb->ovrn_errs,(int)p->scb->rus,(int)p->scb->cus);
+		netdev_dbg(dev, "\nerrs: %04x %04x stat: %04x\n",
+            (int)p->scb->rsc_errs, (int)p->scb->ovrn_errs, (int)p->scb->status);
+		netdev_dbg(dev, "\nerrs: %04x %04x rus: %02x, cus: %02x\n",
+            (int)p->scb->rsc_errs, (int)p->scb->ovrn_errs, (int)p->scb->rus, (int)p->scb->cus);
 	}
 	old_at_least = at_least_one;
 #endif
 
 	if(debuglevel > 0)
-		printk("r");
+		netdev_dbg(dev, "r");
 }
 
 /**********************************************************
@@ -890,8 +902,7 @@ static void sun3_82586_rnr_int(struct net_device *dev)
 	alloc_rfa(dev,(char *)p->rfd_first);
 /* maybe add a check here, before restarting the RU */
 	startrecv586(dev); /* restart RU */
-
-	printk("%s: Receive-Unit restarted. Status: %04x\n",dev->name,p->scb->rus);
+    netdev_info(dev, "Receive-Unit restarted. Status: %04x\n", p->scb->rus);
 
 }
 
@@ -905,11 +916,12 @@ static void sun3_82586_xmt_int(struct net_device *dev)
 	struct priv *p = netdev_priv(dev);
 
 	if(debuglevel > 0)
-		printk("X");
+		netdev_dbg(dev, "X");
+
 
 	status = swab16(p->xmit_cmds[p->xmit_last]->cmd_status);
 	if(!(status & STAT_COMPL))
-		printk("%s: strange .. xmit-int without a 'COMPLETE'\n",dev->name);
+		netdev_err(dev, "strange .. xmit-int without a 'COMPLETE'\n");
 
 	if(status & STAT_OK)
 	{
@@ -920,21 +932,21 @@ static void sun3_82586_xmt_int(struct net_device *dev)
 	{
 		dev->stats.tx_errors++;
 		if(status & TCMD_LATECOLL) {
-			printk("%s: late collision detected.\n",dev->name);
+			netdev_warn(dev, "late collision detected.\n");
 			dev->stats.collisions++;
 		}
 		else if(status & TCMD_NOCARRIER) {
 			dev->stats.tx_carrier_errors++;
-			printk("%s: no carrier detected.\n",dev->name);
+			netdev_err(dev, "no carrier detected.\n");
 		}
 		else if(status & TCMD_LOSTCTS)
-			printk("%s: loss of CTS detected.\n",dev->name);
+			netdev_warn(dev, "loss of CTS detected.\n");
 		else if(status & TCMD_UNDERRUN) {
 			dev->stats.tx_fifo_errors++;
-			printk("%s: DMA underrun detected.\n",dev->name);
+			netdev_err(dev, "DMA underrun detected.\n");
 		}
 		else if(status & TCMD_MAXCOLL) {
-			printk("%s: Max. collisions exceeded.\n",dev->name);
+			netdev_warn(dev, "Max. collisions exceeded.\n");
 			dev->stats.collisions += 16;
 		}
 	}
@@ -970,8 +982,12 @@ static void sun3_82586_timeout(struct net_device *dev, unsigned int txqueue)
 	{
 		netif_wake_queue(dev);
 #ifdef DEBUG
-		printk("%s: strange ... timeout with CU active?!?\n",dev->name);
-		printk("%s: X0: %04x N0: %04x N1: %04x %d\n",dev->name,(int)swab16(p->xmit_cmds[0]->cmd_status),(int)swab16(p->nop_cmds[0]->cmd_status),(int)swab16(p->nop_cmds[1]->cmd_status),(int)p->nop_point);
+		netdev_warn(dev, "strange ... timeout with CU active?!?\n");
+		netdev_dbg(dev, "%s: X0: %04x N0: %04x N1: %04x %d\n", dev->name,
+			(int)swab16(p->xmit_cmds[0]->cmd_status),
+			(int)swab16(p->nop_cmds[0]->cmd_status),
+			(int)swab16(p->nop_cmds[1]->cmd_status),
+			(int)p->nop_point);
 #endif
 		p->scb->cmd_cuc = CUC_ABORT;
 		sun3_attn586();
@@ -986,9 +1002,9 @@ static void sun3_82586_timeout(struct net_device *dev, unsigned int txqueue)
 #endif
 	{
 #ifdef DEBUG
-		printk("%s: xmitter timed out, try to restart! stat: %02x\n",dev->name,p->scb->cus);
-		printk("%s: command-stats: %04x\n", dev->name, swab16(p->xmit_cmds[0]->cmd_status));
-		printk("%s: check, whether you set the right interrupt number!\n",dev->name);
+		netdev_warn(dev, "xmitter timed out, try to restart! stat: %02x\n", p->scb->cus);
+        netdev_dbg(dev, "%s: command-stats: %04x\n", dev->name, swab16(p->xmit_cmds[0]->cmd_status));
+		netdev_dbg(dev, "%s: check, whether you set the right interrupt number!\n",dev->name);
 #endif
 		sun3_82586_close(dev);
 		sun3_82586_open(dev);
@@ -1011,7 +1027,8 @@ sun3_82586_send_packet(struct sk_buff *skb, struct net_device *dev)
 
 	if(skb->len > XMIT_BUFF_SIZE)
 	{
-		printk("%s: Sorry, max. framelength is %d bytes. The length of your frame is %d bytes.\n",dev->name,XMIT_BUFF_SIZE,skb->len);
+		netdev_warn(dev, "Sorry, max. framelength is %d bytes. The length of your frame is %d bytes.\n",
+            XMIT_BUFF_SIZE, skb->len);
 		dev_kfree_skb(skb);
 		return NETDEV_TX_OK;
 	}
@@ -1040,8 +1057,8 @@ sun3_82586_send_packet(struct sk_buff *skb, struct net_device *dev)
 #ifdef DEBUG
 		if(p->scb->cus & CU_ACTIVE)
 		{
-			printk("%s: Hmmm .. CU is still running and we wanna send a new packet.\n",dev->name);
-			printk("%s: stat: %04x %04x\n",dev->name,p->scb->cus,swab16(p->xmit_cmds[0]->cmd_status));
+			netdev_warn(dev, "Hmmm .. CU is still running and we wanna send a new packet.\n");
+			netdev_dbg(dev, "%s: stat: %04x %04x\n", dev->name, p->scb->cus, swab16(p->xmit_cmds[0]->cmd_status));
 		}
 #endif
 
@@ -1067,7 +1084,8 @@ sun3_82586_send_packet(struct sk_buff *skb, struct net_device *dev)
 			if(p->xmit_cmds[0]->cmd_status)
 				break;
 			if(i==15)
-				printk("%s: Can't start transmit-command.\n",dev->name);
+				netdev_err(dev, "Can't start transmit-command.\n");
+
 		}
 #	else
 		next_nop = (p->nop_point + 1) & 0x1;
@@ -1175,13 +1193,13 @@ void sun3_82586_dump(struct net_device *dev,void *ptr)
 	WAIT_4_STAT_COMPL(dump_cmd);
 
 	if( (dump_cmd->cmd_status & (STAT_COMPL|STAT_OK)) != (STAT_COMPL|STAT_OK) )
-				printk("%s: Can't get dump information.\n",dev->name);
+				netdev_err(dev, "Can't get dump information.\n");
 
 	for(i=0;i<170;i++) {
-		printk("%02x ",(int) ((unsigned char *) (dump_cmd + 1))[i]);
+		netdev_dbg(dev, "%02x ", (int) ((unsigned char *) (dump_cmd + 1))[i]);
 		if(i % 24 == 23)
-			printk("\n");
+			netdev_dbg(dev, "\n");
 	}
-	printk("\n");
+	netdev_dbg(dev, "\n");
 }
-#endif
+#endif
\ No newline at end of file
-- 
2.43.0


