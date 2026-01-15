Return-Path: <netdev+bounces-250145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 619ABD244D0
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1CEC30ABEE9
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49810393DFE;
	Thu, 15 Jan 2026 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hBEWCU4J"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700AB3939C3;
	Thu, 15 Jan 2026 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477655; cv=none; b=KFoX6aAjk1DW8iCxRooXib4U03FTBPj//EkaO9ovPmoEltFqU34glaLxM398kR89qezI4NS4tcIZAagOu3rh+97Pg+uuwk3nRypsyB4HbX8qZ1NtPJcJrqzBjpsCW1oxDLv1A3zF5Cl1NcT3PrQYHaSuISkV3DsseSk6ml8+ZOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477655; c=relaxed/simple;
	bh=ch3WUowE0r41pxeM/FiSHDm2a/bn91+yh/Iqf4f8cno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VM2rErcgDzM80yycMEZVc1aCXxR6HleDAUJxvWVgJqDYarnDoXhSSkH5KP+GWIhfYgb2SxYe9KVBLa2ciRs7YVGGRxppHaCcX+TXy4+bQ7MFl9GKoz7v983xzGJGLKWn1L2GStBHScc76Vl2MuGv/u7GIf/Nakzr6GLxk1JzHMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hBEWCU4J; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=xj
	XLh9OxB7OyImjOAQduujoqYcXrgtQdnE2zosJw5bA=; b=hBEWCU4JCy/S4vL5LG
	TRJ6yOAUxUAmbIjCVL3LxlfpyOKwbwj9HIygaVbe9QJR7TxeDEkTRwQ8i8esWbmO
	MYhKIAXeTvS12YxvJxntrDEGgCCQzzbxlDD4z/lABmTDHTHmX7/wKRSjkyscyOf2
	MbeXXeGiE9aNl1vKYL5Gx0oIs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBHLGiX02hpr2PzGQ--.4331S8;
	Thu, 15 Jan 2026 19:46:48 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mani@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slark_xiao@163.com
Subject: [net-next v7 6/8] net: wwan: hwsim: refactor to support more port types
Date: Thu, 15 Jan 2026 19:46:23 +0800
Message-Id: <20260115114625.46991-7-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260115114625.46991-1-slark_xiao@163.com>
References: <20260115114625.46991-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHLGiX02hpr2PzGQ--.4331S8
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr4UKr1UAry5CFWfAFykAFb_yoWxJrykpa
	yqgr9xKrWUt3Z3Wry7tFsrAa4Fkrn5WryvqrWrW34FqFn7t345ZFWvk3s0kr4DAFy7CFy3
	Cr98t343Jw47Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pETmhrUUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCwAiT92lo06jnRgAA33

From: Sergey Ryazanov <ryazanov.s.a@gmail.com>

Just introduced WWAN NMEA port type needs a testing option. The WWAN HW
simulator was developed with the AT port type in mind and cannot be
easily extended. Refactor it now to make it capable to support more port
types.

No big functional changes, mostly renaming with a little code
rearrangement.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/net/wwan/wwan_hwsim.c | 73 ++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wwan/wwan_hwsim.c b/drivers/net/wwan/wwan_hwsim.c
index 733688cd4607..11d15dc39041 100644
--- a/drivers/net/wwan/wwan_hwsim.c
+++ b/drivers/net/wwan/wwan_hwsim.c
@@ -56,12 +56,16 @@ struct wwan_hwsim_port {
 	struct wwan_port *wwan;
 	struct work_struct del_work;
 	struct dentry *debugfs_topdir;
-	enum {			/* AT command parser state */
-		AT_PARSER_WAIT_A,
-		AT_PARSER_WAIT_T,
-		AT_PARSER_WAIT_TERM,
-		AT_PARSER_SKIP_LINE,
-	} pstate;
+	union {
+		struct {
+			enum {	/* AT command parser state */
+				AT_PARSER_WAIT_A,
+				AT_PARSER_WAIT_T,
+				AT_PARSER_WAIT_TERM,
+				AT_PARSER_SKIP_LINE,
+			} pstate;
+		} at_emul;
+	};
 };
 
 static const struct file_operations wwan_hwsim_debugfs_portdestroy_fops;
@@ -101,16 +105,16 @@ static const struct wwan_ops wwan_hwsim_wwan_rtnl_ops = {
 	.setup = wwan_hwsim_netdev_setup,
 };
 
-static int wwan_hwsim_port_start(struct wwan_port *wport)
+static int wwan_hwsim_at_emul_start(struct wwan_port *wport)
 {
 	struct wwan_hwsim_port *port = wwan_port_get_drvdata(wport);
 
-	port->pstate = AT_PARSER_WAIT_A;
+	port->at_emul.pstate = AT_PARSER_WAIT_A;
 
 	return 0;
 }
 
-static void wwan_hwsim_port_stop(struct wwan_port *wport)
+static void wwan_hwsim_at_emul_stop(struct wwan_port *wport)
 {
 }
 
@@ -120,7 +124,7 @@ static void wwan_hwsim_port_stop(struct wwan_port *wport)
  *
  * Be aware that this processor is not fully V.250 compliant.
  */
-static int wwan_hwsim_port_tx(struct wwan_port *wport, struct sk_buff *in)
+static int wwan_hwsim_at_emul_tx(struct wwan_port *wport, struct sk_buff *in)
 {
 	struct wwan_hwsim_port *port = wwan_port_get_drvdata(wport);
 	struct sk_buff *out;
@@ -142,17 +146,17 @@ static int wwan_hwsim_port_tx(struct wwan_port *wport, struct sk_buff *in)
 	for (i = 0, s = 0; i < in->len; ++i) {
 		char c = in->data[i];
 
-		if (port->pstate == AT_PARSER_WAIT_A) {
+		if (port->at_emul.pstate == AT_PARSER_WAIT_A) {
 			if (c == 'A' || c == 'a')
-				port->pstate = AT_PARSER_WAIT_T;
+				port->at_emul.pstate = AT_PARSER_WAIT_T;
 			else if (c != '\n')	/* Ignore formating char */
-				port->pstate = AT_PARSER_SKIP_LINE;
-		} else if (port->pstate == AT_PARSER_WAIT_T) {
+				port->at_emul.pstate = AT_PARSER_SKIP_LINE;
+		} else if (port->at_emul.pstate == AT_PARSER_WAIT_T) {
 			if (c == 'T' || c == 't')
-				port->pstate = AT_PARSER_WAIT_TERM;
+				port->at_emul.pstate = AT_PARSER_WAIT_TERM;
 			else
-				port->pstate = AT_PARSER_SKIP_LINE;
-		} else if (port->pstate == AT_PARSER_WAIT_TERM) {
+				port->at_emul.pstate = AT_PARSER_SKIP_LINE;
+		} else if (port->at_emul.pstate == AT_PARSER_WAIT_TERM) {
 			if (c != '\r')
 				continue;
 			/* Consume the trailing formatting char as well */
@@ -162,11 +166,11 @@ static int wwan_hwsim_port_tx(struct wwan_port *wport, struct sk_buff *in)
 			skb_put_data(out, &in->data[s], n);/* Echo */
 			skb_put_data(out, "\r\nOK\r\n", 6);
 			s = i + 1;
-			port->pstate = AT_PARSER_WAIT_A;
-		} else if (port->pstate == AT_PARSER_SKIP_LINE) {
+			port->at_emul.pstate = AT_PARSER_WAIT_A;
+		} else if (port->at_emul.pstate == AT_PARSER_SKIP_LINE) {
 			if (c != '\r')
 				continue;
-			port->pstate = AT_PARSER_WAIT_A;
+			port->at_emul.pstate = AT_PARSER_WAIT_A;
 		}
 	}
 
@@ -183,18 +187,25 @@ static int wwan_hwsim_port_tx(struct wwan_port *wport, struct sk_buff *in)
 	return 0;
 }
 
-static const struct wwan_port_ops wwan_hwsim_port_ops = {
-	.start = wwan_hwsim_port_start,
-	.stop = wwan_hwsim_port_stop,
-	.tx = wwan_hwsim_port_tx,
+static const struct wwan_port_ops wwan_hwsim_at_emul_port_ops = {
+	.start = wwan_hwsim_at_emul_start,
+	.stop = wwan_hwsim_at_emul_stop,
+	.tx = wwan_hwsim_at_emul_tx,
 };
 
-static struct wwan_hwsim_port *wwan_hwsim_port_new(struct wwan_hwsim_dev *dev)
+static struct wwan_hwsim_port *wwan_hwsim_port_new(struct wwan_hwsim_dev *dev,
+						   enum wwan_port_type type)
 {
+	const struct wwan_port_ops *ops;
 	struct wwan_hwsim_port *port;
 	char name[0x10];
 	int err;
 
+	if (type == WWAN_PORT_AT)
+		ops = &wwan_hwsim_at_emul_port_ops;
+	else
+		return ERR_PTR(-EINVAL);
+
 	port = kzalloc(sizeof(*port), GFP_KERNEL);
 	if (!port)
 		return ERR_PTR(-ENOMEM);
@@ -205,9 +216,7 @@ static struct wwan_hwsim_port *wwan_hwsim_port_new(struct wwan_hwsim_dev *dev)
 	port->id = dev->port_idx++;
 	spin_unlock(&dev->ports_lock);
 
-	port->wwan = wwan_create_port(&dev->dev, WWAN_PORT_AT,
-				      &wwan_hwsim_port_ops,
-				      NULL, port);
+	port->wwan = wwan_create_port(&dev->dev, type, ops, NULL, port);
 	if (IS_ERR(port->wwan)) {
 		err = PTR_ERR(port->wwan);
 		goto err_free_port;
@@ -392,7 +401,7 @@ static ssize_t wwan_hwsim_debugfs_portcreate_write(struct file *file,
 	struct wwan_hwsim_dev *dev = file->private_data;
 	struct wwan_hwsim_port *port;
 
-	port = wwan_hwsim_port_new(dev);
+	port = wwan_hwsim_port_new(dev, WWAN_PORT_AT);
 	if (IS_ERR(port))
 		return PTR_ERR(port);
 
@@ -459,6 +468,8 @@ static int __init wwan_hwsim_init_devs(void)
 	int i, j;
 
 	for (i = 0; i < wwan_hwsim_devsnum; ++i) {
+		struct wwan_hwsim_port *port;
+
 		dev = wwan_hwsim_dev_new();
 		if (IS_ERR(dev))
 			return PTR_ERR(dev);
@@ -471,9 +482,7 @@ static int __init wwan_hwsim_init_devs(void)
 		 * the simulator readiness time.
 		 */
 		for (j = 0; j < 2; ++j) {
-			struct wwan_hwsim_port *port;
-
-			port = wwan_hwsim_port_new(dev);
+			port = wwan_hwsim_port_new(dev, WWAN_PORT_AT);
 			if (IS_ERR(port))
 				return PTR_ERR(port);
 
-- 
2.25.1


