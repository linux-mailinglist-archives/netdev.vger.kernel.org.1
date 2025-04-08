Return-Path: <netdev+bounces-180517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BE6A81965
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7382719E4C3D
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 23:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1818F256C9C;
	Tue,  8 Apr 2025 23:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmHlQ1KE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2B12566F9
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 23:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744155092; cv=none; b=Kk+TdC4vfw7zE6QHxidW0d9mkGEeB2SHcmpGnVJjbBS3x+VJ0sgNIP4DZsr9fAlp/T0SpfAkkU6NP8pALC205zzrhb8D3vTvLaZem1k70Xr2mI7YMnAEeubDyLJrpxcQVQergfvx+/vXrZNP7Pbye2r/EKHsFJU5ogkwhrwH0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744155092; c=relaxed/simple;
	bh=5iAXVWPhdoBqMoUiomZtNJM57U2CHvhCDU6HgkdBmp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5q5zROrWmr1HZwhiShxHKT8zX4CwqXp37xxUlTdKkDg6YJjJjDZu8Ku7FqyL6eOqRijcdRfrxkwd0rYehi+qRvZ8jqbCzmgtPS0FYWbBTokkXCzR2nYCQ9qupqLjPgk6e93sDVBgFYw2iRJzVLxnW6GeQ1F6k0u5WsHTaS8kBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmHlQ1KE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c266c2dd5so5311530f8f.3
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 16:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744155088; x=1744759888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8HM9S55GlQ+9LmT9CwhcfqVPTmAkRhT3Oi7RjYzwMY=;
        b=WmHlQ1KE3499b5iupjzPyetOzjtd/7PBBSgIcdg815oailvZQI/nOUPvH8uapxz9Eh
         J7tE5ev77qna/5YFvqeAVI0FT1Y8QrJcr5M/1ovKAXXvjM0sdsZgIZeMj8aDJQsNvrTz
         yTXOddZs8vlgUv5RlIkcbe04+95vRFqhUr09kGCqc9ouCtUuDTCAQccpMnYvpXCh2pDz
         32hnwK9dTJPhSdnNqjbMGcy2HEIQdm5cUK6wKgQFkyAGjQJi69M7px/mnRESPSSdrAJv
         /7B2UWYdivkwm7s0Xohb5srZM0C66fJIOA1YyhUdYfq/RXbSfAT9799PlYKISJQsOfG7
         zhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744155088; x=1744759888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8HM9S55GlQ+9LmT9CwhcfqVPTmAkRhT3Oi7RjYzwMY=;
        b=Mfs2RYNRLv5SsAjd3rnZweHxtsWXJ4/FOc2NdFtgSM3PdUgxoAhanpPEH8PmQD2177
         1rlzhw16wKN5V+fjf6guZIdRU5hb14HKvumohb+xkIteBstJtY1kRMv/x+a/LPW6tbmJ
         qTRgsp3Q8wVAJBME+ZXquzl3zf7s6btzChcwcVEzGcoGA52BANS7wtnGra4J0GtMiIKx
         9XYjksdsmIpNqRGN8offq87xmgk9tPitEuUHXgHVQeT0p5xYgE5YUbYO520gMZ88kykO
         JQFO6bA0KrSepAUKrEA8mx5eDMc1LkGu6ruDA18WA2qJzQSOKFeOoO13taZUYItGvMQy
         DVtw==
X-Forwarded-Encrypted: i=1; AJvYcCW6a1LI0dw3nTmo+nfWQrx9MAcTPzdiDP/DyU+1O+Vhox4yz0+/kKM2cA06a7e0w9VPjwHuNTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZX7DsNTmxlZjzNgHRUFKX4BfxMzwNcl3rcjxKimKmnZhNJFT1
	QDC45dEl8ZoEG7DIFkBZ6Gt9oXhbqeUE71n5pXCAhmqGtFtZVlo/
X-Gm-Gg: ASbGncsSSSrcGj79hIy4LHn4jNJwNAXxk7loWcUGSyu3TIMSmww5bMt7j6rHlEloL37
	wUyjUZbF+FXRS3eY1c6bOC3K2hAd/a5+zxLlnRnzP1zncjCIdhQNCNtkrLKc06iBq4wG6rXcc8L
	KO2sn+b6YNRQTrzZX4JqsyL07KYzbz0dBqWXEZR/vIDY/x12Th+4/efBabW+ZSZDsEDDMaOqyGl
	NpIOCT/I8TV3yVA9ru0TKgsUXbecgR5OGDASw6bGNaaimRF+aOcIv8HwaeWsm6eERPGd4V/CPj7
	5NGXoIwfPxtcE5Kp1s8zBDuN9AONaBWAz51DOJcG3NqzABh7PQi/41oKv7Q=
X-Google-Smtp-Source: AGHT+IF47GVySUqjP8DNtzWjpU/6SaCFS8yQqnujcFvxkfC+f7uymbo+lxVel2cBJYOTkNGcVVSUUw==
X-Received: by 2002:a05:6000:4284:b0:399:7f43:b3a4 with SMTP id ffacd0b85a97d-39d87ab407cmr815724f8f.24.1744155088222;
        Tue, 08 Apr 2025 16:31:28 -0700 (PDT)
Received: from localhost.localdomain ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d75ac6d66sm9934565f8f.14.2025.04.08.16.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 16:31:27 -0700 (PDT)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH 5/6] net: wwan: hwsim: refactor to support more port types
Date: Wed,  9 Apr 2025 02:31:17 +0300
Message-ID: <20250408233118.21452-6-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250408233118.21452-1-ryazanov.s.a@gmail.com>
References: <20250408233118.21452-1-ryazanov.s.a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just introduced WWAN NMEA port type needs a testing option. The WWAN HW
simulator was developed with the AT port type in mind and cannot be
easily extended. Refactor it now to make it capable to support more port
types.

No big functional changes, mostly renaming with a little code
rearrangement.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 drivers/net/wwan/wwan_hwsim.c | 73 ++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wwan/wwan_hwsim.c b/drivers/net/wwan/wwan_hwsim.c
index b02befd1b6fb..20277ba88433 100644
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
2.45.3


