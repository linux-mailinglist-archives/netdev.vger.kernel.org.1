Return-Path: <netdev+bounces-137325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499CE9A56D3
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 22:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DFA5B22C8C
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 20:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12F4199FAD;
	Sun, 20 Oct 2024 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STqoUV4P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42017198A0F;
	Sun, 20 Oct 2024 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729457825; cv=none; b=GJ/KpNC7NUUsz7cc23E/VLQa3NRatO5GG4Y7W7Kwjg4YHVj83NHut2BNhLhgkVkaRPMJTioQVlIuiAjlnavOuYyzPS+SWIqYPL3gE66Gy9zscVYtYMdSkkRaGViMrvhgITDvOp7Plrt4ZpBJ9gshH9fD9c215pB+rKi/yHbvFoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729457825; c=relaxed/simple;
	bh=AdqYORKqhScmeHeYNSD/MJ6rhroWSE8tdow1UEXHFNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=os9lHvqqNgPTo+Cv4OB7ukZpv7kAxcigPnHWGYKnCtXsgu5U/9GNbyoRLpc10Uf/H9mS9eBtdeLF623++u3ReTzILOy3ttwpSwY0AU4WUzp+vOLfHlmwjcWUH7w+Fm95mPpNFWZBm8HwmOpOpdFxoq3JnAiKIeQtBySV8T5LQZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STqoUV4P; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99f629a7aaso673301066b.1;
        Sun, 20 Oct 2024 13:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729457821; x=1730062621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oVLv8Vu4ZHXQDXrxYkhAbVdIKoCOwOdtS+wCj0vhdU=;
        b=STqoUV4P7ajex16K1RsDAPmypgtEyGB2wuXTclLj/QOiodzuhUT3yLO+7oMYQlamYp
         ajyyEThN4FFDU/4YbtESOHdlkdCXREOzwrznYBn0B9CT7F/7it1wcL9rDsrIfcMcUlTi
         DfTSz4g8ANcxw18n5nj9Z9n5GMoriO0OJzY3777tdaeeitqRPX8lg2y4mvyZ+p4GC6Wk
         ZFy2BY7AY82oEyh/qyuMryUtqsPSha5RvrzH5c7J1GS0Qyy+1y2UME6FCzXiaFtl6aPo
         1qzG2O4/4USByOeCo58mz1g6Ha+/32DYCOMqAsig8s8uDOAy5kjDPxSZ2soebmEQJla6
         Apaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729457821; x=1730062621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oVLv8Vu4ZHXQDXrxYkhAbVdIKoCOwOdtS+wCj0vhdU=;
        b=T8edcLhAeWcc+D3dBK/FMEOqhlbnJEOsav7N6C2yGwcUXTRBPT+VpQjFwr40iKOFaZ
         b8duCx4a1T2fhVfBW6SVHmP5Zvl0W8RlIj4sSOWHhm6mPJO20re7QNLBX+ijpzCitOxd
         447yPzHkRX8QGvtuny6aioNDR6zjDo+GYScOnVpZj8XFMz9u53NGDKJoDrpxsHZWKN3Q
         1XsjMMpYcDw+AFC4fEmqEGB1ZOTRTHrNTSsfVWToqzsB+B8YChWeVXucRR5hZeZunvvS
         ZXhPBDbvbQ/J6uKcyo+6cMwvnAXOewN8PU1QiytiOYEEQ9izUGG/GaqAj8x+5q65I5/W
         oknw==
X-Forwarded-Encrypted: i=1; AJvYcCVch3ZgD2IBc/Aso5Ir1ytKFdTmbIqSRk7MZzseXc92i4yWzp/VzkCBoQ+SvqpFHCiaqPJjHpwuy0orw7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdXcoUvWaZtKkBfdk7aZyv7xPGdpbM65mRIPAOfIbyTV1O96v+
	bSizcybHCgVuXhLJO8i/318+FNbOhGP9xlktYVG3EgEjgrOB5tzfx1Sqeffa
X-Google-Smtp-Source: AGHT+IGDXsiFmy9S2334vw44am/sCgznLYLI2wFZIGi7GDSoqTDGdYuNC3C7h8pDIBY0fWaTEu468g==
X-Received: by 2002:a17:907:d16:b0:a99:5f65:fd9a with SMTP id a640c23a62f3a-a9a4cc3c202mr1567023166b.21.1729457821064;
        Sun, 20 Oct 2024 13:57:01 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912edc07sm125135966b.69.2024.10.20.13.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 13:57:00 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] net: dsa: vsc73xx: implement packet reception via control interface
Date: Sun, 20 Oct 2024 22:54:51 +0200
Message-Id: <20241020205452.2660042-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241020205452.2660042-1-paweldembicki@gmail.com>
References: <20241020205452.2660042-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some types of packets can be forwarded only to and from the PI/SI
interface. For more information, see Chapter 2.7.1 (CPU Forwarding) in
the datasheet.

This patch implements the routines required for link-local reception.
This kind of traffic can't be transferred through the RGMII interface in
vsc73xx.

The packet receiver poller uses a kthread worker, which checks if a packet
has arrived in the CPU buffer. If the header is valid, the packet is
transferred to the correct DSA conduit interface.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 174 +++++++++++++++++++++++++
 drivers/net/dsa/vitesse-vsc73xx.h      |   4 +
 2 files changed, 178 insertions(+)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 21ab3f214490..596b11c4d672 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -45,6 +45,15 @@
 #define VSC73XX_BLOCK_MII_INTERNAL	0x0 /* Internal MDIO subblock */
 #define VSC73XX_BLOCK_MII_EXTERNAL	0x1 /* External MDIO subblock */
 
+/* CAPTURE Block subblock */
+#define VSC73XX_BLOCK_CAPT_FRAME0	0x0 /* Frame 0 subblock */
+#define VSC73XX_BLOCK_CAPT_FRAME1	0x1 /* Frame 1 subblock */
+#define VSC73XX_BLOCK_CAPT_FRAME2	0x2 /* Frame 2 subblock */
+#define VSC73XX_BLOCK_CAPT_FRAME3	0x3 /* Frame 3 subblock */
+#define VSC73XX_BLOCK_CAPT_Q0		0x4 /* Queue 0 subblock */
+#define VSC73XX_BLOCK_CAPT_Q1		0x6 /* Queue 0 subblock */
+#define VSC73XX_BLOCK_CAPT_RST		0x7 /* Capture reset subblock */
+
 #define CPU_PORT	6 /* CPU port */
 #define VSC73XX_NUM_FDB_ROWS	2048
 #define VSC73XX_NUM_BUCKETS	4
@@ -244,6 +253,13 @@
 #define VSC73XX_MACTINDX_BUCKET_MSK		GENMASK(12, 11)
 #define VSC73XX_MACTINDX_INDEX_MSK		GENMASK(10, 0)
 
+#define VSC73XX_CAPENAB_IPMC			BIT(20)
+#define VSC73XX_CAPENAB_ARPBC			BIT(19)
+#define VSC73XX_CAPENAB_IGMP			BIT(18)
+#define VSC73XX_CAPENAB_ALLBRIDGE		BIT(17)
+#define VSC73XX_CAPENAB_BPDU			BIT(16)
+#define VSC73XX_CAPENAB_GARP			GENMASK(15, 0)
+
 #define VSC73XX_MACACCESS_CPU_COPY		BIT(14)
 #define VSC73XX_MACACCESS_FWD_KILL		BIT(13)
 #define VSC73XX_MACACCESS_IGNORE_VLAN		BIT(12)
@@ -297,6 +313,13 @@
 
 #define VSC73XX_MII_STAT_BUSY	BIT(3)
 
+/* Capture block 4 registers */
+#define VSC73XX_CAPT_FRAME_DATA		0x0
+#define VSC73XX_CAPT_FRAME_DATA_MAX	0xff
+#define VSC73XX_CAPT_CAPREADP		0x0
+#define VSC73XX_CAPT_CAPWRP		0x3
+#define VSC73XX_CAPT_CAPRST		0xff
+
 /* Arbiter block 5 registers */
 #define VSC73XX_ARBEMPTY		0x0c
 #define VSC73XX_ARBDISC			0x0e
@@ -316,6 +339,7 @@
 #define VSC73XX_ICPU_MBOX_SET		0x16
 #define VSC73XX_ICPU_MBOX_CLR		0x17
 #define VSC73XX_CHIPID			0x18
+#define VSC73XX_CAPCTRL			0x31
 #define VSC73XX_GPIO			0x34
 
 #define VSC73XX_GMIIDELAY_GMII0_GTXDELAY_NONE	0
@@ -364,6 +388,24 @@
 				 VSC73XX_ICPU_CTRL_CLK_EN | \
 				 VSC73XX_ICPU_CTRL_SRST)
 
+#define VSC73XX_CAPCTRL_QUEUE1_READY		BIT(31)
+#define VSC73XX_CAPCTRL_QUEUE0_READY		BIT(30)
+#define VSC73XX_CAPCTRL_ARPBC_Q			BIT(18)
+#define VSC73XX_CAPCTRL_IPMC_Q			BIT(17)
+#define VSC73XX_CAPCTRL_IGMP_Q			BIT(16)
+#define VSC73XX_CAPCTRL_ALLBRIDGE_Q		BIT(15)
+#define VSC73XX_CAPCTRL_GARP_Q			BIT(14)
+#define VSC73XX_CAPCTRL_BPDU_Q			BIT(13)
+#define VSC73XX_CAPCTRL_FIFO_MODE		BIT(12)
+#define VSC73XX_CAPCTRL_QUEUE1_ENA		BIT(11)
+#define VSC73XX_CAPCTRL_Q1_IRQ_EN		BIT(6)
+#define VSC73XX_CAPCTRL_Q0_IRQ_EN		BIT(5)
+#define VSC73XX_CAPCTRL_Q1_IRQ_PIN		BIT(4)
+#define VSC73XX_CAPCTRL_Q0_IRQ_PIN		BIT(3)
+#define VSC73XX_CAPCTRL_LEARN_TRUNCATE		BIT(2)
+#define VSC73XX_CAPCTRL_LEARN_Q			BIT(1)
+#define VSC73XX_CAPCTRL_MACB_Q			BIT(0)
+
 #define IS_7385(a) ((a)->chipid == VSC73XX_CHIPID_ID_7385)
 #define IS_7388(a) ((a)->chipid == VSC73XX_CHIPID_ID_7388)
 #define IS_7395(a) ((a)->chipid == VSC73XX_CHIPID_ID_7395)
@@ -373,6 +415,7 @@
 #define VSC73XX_POLL_SLEEP_US		1000
 #define VSC73XX_MDIO_POLL_SLEEP_US	5
 #define VSC73XX_POLL_TIMEOUT_US		10000
+#define VSC73XX_RCV_POLL_INTERVAL	100
 
 #define VSC73XX_IFH_MAGIC		0x52
 #define VSC73XX_IFH_SIZE		8
@@ -834,6 +877,115 @@ static void vsc73xx_deferred_xmit(struct kthread_work *work)
 	kfree(xmit_work);
 }
 
+static void vsc73xx_polled_rcv(struct kthread_work *work)
+{
+	struct vsc73xx *vsc = container_of(work, struct vsc73xx, dwork.work);
+	u16 ptr = VSC73XX_CAPT_FRAME_DATA;
+	struct dsa_switch *ds = vsc->ds;
+	int ret, buf_len, len, part;
+	struct vsc73xx_ifh ifh;
+	struct net_device *dev;
+	struct dsa_port *dp;
+	struct sk_buff *skb;
+	u32 val, *buf;
+	u16 count;
+
+	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_CAPCTRL, &val);
+	if (ret)
+		goto queue;
+
+	if (!(val & VSC73XX_CAPCTRL_QUEUE0_READY))
+		/* No frame to read */
+		goto queue;
+
+	/* Initialise reading */
+	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_CAPTURE, VSC73XX_BLOCK_CAPT_Q0,
+			   VSC73XX_CAPT_CAPREADP, &val);
+	if (ret)
+		goto queue;
+
+	/* Get internal frame header */
+	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_CAPTURE,
+			   VSC73XX_BLOCK_CAPT_FRAME0, ptr++, &ifh.datah);
+	if (ret)
+		goto queue;
+
+	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_CAPTURE,
+			   VSC73XX_BLOCK_CAPT_FRAME0, ptr++, &ifh.datal);
+	if (ret)
+		goto queue;
+
+	if (ifh.magic != VSC73XX_IFH_MAGIC) {
+		/* Something goes wrong with buffer. Reset capture block */
+		vsc73xx_write(vsc, VSC73XX_BLOCK_CAPTURE,
+			      VSC73XX_BLOCK_CAPT_RST, VSC73XX_CAPT_CAPRST, 1);
+		goto queue;
+	}
+
+	if (!dsa_is_user_port(ds, ifh.port))
+		goto release_frame;
+
+	dp = dsa_to_port(ds, ifh.port);
+	dev = dp->user;
+	if (!dev)
+		goto release_frame;
+
+	count = (ifh.frame_length + 7 + VSC73XX_IFH_SIZE - ETH_FCS_LEN) >> 2;
+
+	skb = netdev_alloc_skb(dev, len);
+	if (unlikely(!skb)) {
+		netdev_err(dev, "Unable to allocate sk_buff\n");
+		goto release_frame;
+	}
+
+	buf_len = ifh.frame_length - ETH_FCS_LEN;
+	buf = (u32 *)skb_put(skb, buf_len);
+	len = 0;
+	part = 0;
+
+	while (ptr < count) {
+		ret = vsc73xx_read(vsc, VSC73XX_BLOCK_CAPTURE,
+				   VSC73XX_BLOCK_CAPT_FRAME0 + part, ptr++,
+				   buf + len);
+		if (ret)
+			goto free_skb;
+		len++;
+		if (ptr > VSC73XX_CAPT_FRAME_DATA_MAX &&
+		    count != VSC73XX_CAPT_FRAME_DATA_MAX) {
+			ptr = VSC73XX_CAPT_FRAME_DATA;
+			part++;
+			count -= VSC73XX_CAPT_FRAME_DATA_MAX;
+		}
+	}
+
+	/* Get FCS */
+	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_CAPTURE,
+			   VSC73XX_BLOCK_CAPT_FRAME0, ptr++, &val);
+	if (ret)
+		goto free_skb;
+
+	/* Everything we see on an interface that is in the HW bridge
+	 * has already been forwarded.
+	 */
+	if (dp->bridge)
+		skb->offload_fwd_mark = 1;
+
+	skb->protocol = eth_type_trans(skb, dev);
+
+	netif_rx(skb);
+	goto release_frame;
+
+free_skb:
+	kfree_skb(skb);
+release_frame:
+	/* Release the frame from internal buffer */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_CAPTURE, VSC73XX_BLOCK_CAPT_Q0,
+		      VSC73XX_CAPT_CAPREADP, 0);
+queue:
+	kthread_queue_delayed_work(vsc->rcv_worker, &vsc->dwork,
+				   msecs_to_jiffies(VSC73XX_RCV_POLL_INTERVAL));
+}
+
 static int
 vsc73xx_connect_tag_protocol(struct dsa_switch *ds, enum dsa_tag_protocol proto)
 {
@@ -1111,14 +1263,36 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 	ret = dsa_tag_8021q_register(ds, htons(ETH_P_8021Q));
 	rtnl_unlock();
 
+	/* Reset capture block */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_CAPTURE, VSC73XX_BLOCK_CAPT_RST,
+		      VSC73XX_CAPT_CAPRST, 1);
+
+	/* Capture BPDU frames */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_CAPENAB,
+		      VSC73XX_CAPENAB_BPDU);
+
+	vsc->rcv_worker = kthread_create_worker(0, "vsc73xx_rcv");
+	if (IS_ERR(vsc->rcv_worker))
+		return PTR_ERR(vsc->rcv_worker);
+
+	kthread_init_delayed_work(&vsc->dwork, vsc73xx_polled_rcv);
+
+	kthread_queue_delayed_work(vsc->rcv_worker, &vsc->dwork,
+				   msecs_to_jiffies(VSC73XX_RCV_POLL_INTERVAL));
+
 	return ret;
 }
 
 static void vsc73xx_teardown(struct dsa_switch *ds)
 {
+	struct vsc73xx *vsc = ds->priv;
+
 	rtnl_lock();
 	dsa_tag_8021q_unregister(ds);
 	rtnl_unlock();
+
+	kthread_cancel_delayed_work_sync(&vsc->dwork);
+	kthread_destroy_worker(vsc->rcv_worker);
 }
 
 static void vsc73xx_init_port(struct vsc73xx *vsc, int port)
diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
index bf55a20f07f3..5dd458793741 100644
--- a/drivers/net/dsa/vitesse-vsc73xx.h
+++ b/drivers/net/dsa/vitesse-vsc73xx.h
@@ -47,6 +47,8 @@ struct vsc73xx_portinfo {
  *	every vlan configured in port vlan operation. It doesn't cover tag_8021q
  *	vlans.
  * @fdb_lock: Mutex protects fdb access
+ * @rcv_worker: Kthread worker struct for packet reciver poller
+ * @dwork: Work struct for scheduling work to the packet reciver poller
  */
 struct vsc73xx {
 	struct device			*dev;
@@ -60,6 +62,8 @@ struct vsc73xx {
 	struct vsc73xx_portinfo		portinfo[VSC73XX_MAX_NUM_PORTS];
 	struct list_head		vlans;
 	struct mutex			fdb_lock;
+	struct kthread_worker		*rcv_worker;
+	struct kthread_delayed_work	dwork;
 };
 
 /**
-- 
2.34.1


