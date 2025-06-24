Return-Path: <netdev+bounces-200855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956F8AE71A8
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC5B5A608C
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F3F25A2CC;
	Tue, 24 Jun 2025 21:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZZHDgbW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD8D25B69A
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 21:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750801151; cv=none; b=tkOzl1QoKgVFsDbiHEUYYmXF5NPfZsEaja63mDnC33Vu5LUIOsDAB4DMnBtD1tfQVI/llss4RpQ+WYsYVLyOONUz/icbz88RhNNTONjWy5ldZl1Hgrvp/CoFGtqAnamMCWreiywYm1qadGVrodVpFJuGTlSmXmadlTGaOnziYHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750801151; c=relaxed/simple;
	bh=iEyEtcrwwcVufUF7/R+qOYwlFnwcPeoKyHgqTX5cRzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kY+Xe/lH8BLJvxLc5jaSNNx8EKydONNvppd/iGFBG3uXBz+ZgqWFvol8xOrsHvTlFgq7p+dbYCFzI//HPPlXovkWPDb4n79QkTbtwUXXLM/gmHmReTIKOKd0HkvUEH7O1by5YYzbDYrh9diFmdBkMAKvCXz0aM0ALQA5WHp70XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZZHDgbW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4536b8c183cso1672575e9.0
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 14:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750801148; x=1751405948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSb9KnXbCwSdSyLMvlS72yR7L6LOlY0SuRxyQmucdyo=;
        b=DZZHDgbWzwvBcch1p54h4XrAT8NYC1c+yrTkiwC3q2REjo5tAf64DEYizBEOoHwH2B
         v3wzBU5ZFWAx6W8reRsOh4hmPfaahy+QYzfKF6qDikkaBTffKQneAu8ok1xTpx/5pOSX
         H34gQwXwTwk4qcwnNsqzm5QtJTdYjT2+567oNPspyHARZRUfLe2BBE4QB5uYaObMD7J0
         Pi2AzjdmKqVJ13FFFCPmiSsU4NK8b5zSEIyml+SXdZC0HjsI4WFlN8SQ9k5zykpMkwd/
         /IvGCQ05fUoLqgU64WHasARPsMCpl1lRUzZlZ4MxXXDDVKf4iwmO7mgLgMdJLGIyz0Hx
         6E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750801148; x=1751405948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSb9KnXbCwSdSyLMvlS72yR7L6LOlY0SuRxyQmucdyo=;
        b=j78KsSKrkFENdpwQRp7g3RBFGN0Zj3nhkDJfkQecKvZk+xWnxv5OtWTQl1je2zxqRb
         FEJyeqGKcyEy0SmSQvnJThjDLR58ejnycazcgxRtxTUe0kjQlxqMOD0qxK7joIhvYP3C
         wyjrvss/GqqnxJSTP5fi/uTuUHWfxRn/UA6D0ktUngAlARRw3zG0otmdgbOw7CNJVHDJ
         C9YnY5H3OdMytgp1WRkpY7UPNbBKECwVZy6SyBeIjzanNAviihmyJHqxegu+3M7AdRoc
         +585EpWETSrNF2tT8mdMz4LIcTv9HVGjagzh2vCzxXeC2kRRzWQSMv9hw40QXguJAh8/
         h77Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6/jXzGdoEXxGSEfks2Tv7b72AO0nwEPJ2O+EKi3bXf5i06tC67KzN+yJ6rS3iDxasAKfnV+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlcNT+KCsLiPk9wVjO1is1xK/eqOID/uOwhTvwrJz5MxUt6gC/
	/EROn1uw2uKnLmWUJfdUGZzoXAnHvRfA+lYlh1fvT77a/aBRTt+re8AG
X-Gm-Gg: ASbGncvStq4hzO8BbG+LhvbzhiQXOlG9FDRJeIKhX7FjCoYS9zhgHzZ2AGAZk17pAec
	RbA59jVRwmu1hEonVj1qCnXK3IGZ3v5wETCqmCAMR8skJ5je7qwMjhAg7+8xucblxuV5vdI1FYa
	IC/5SJtmVNoLydGEzeo0v1iT0/iw79G2TaPwpXujlHHHzMPiUu2pQJNgMwbLz9gK9Da3nMVZqX4
	N0OavYOc9R2AfpMbHwoG+mp5u9pBjRPnvGTo4m3bJ5AbGwTh3M3+4FPhbv00MbUpwup7Tqlc6a6
	bf8LBGbnzViD+gYavQv+ef52PCbQQ6SGg3m+qkqTGZMyYkRL/JbpQRNEAatuAcsb0SyoNyGKvsL
	x
X-Google-Smtp-Source: AGHT+IHUh+1vA8FTuqI1Qidz28hlzE+56N10ujIO7zVjVszCdNsJ7EannSFuFnlYdWKk/lI63TEOyg==
X-Received: by 2002:a05:600c:a319:b0:453:45f1:9c96 with SMTP id 5b1f17b1804b1-4537cd8e312mr36564165e9.14.1750801147969;
        Tue, 24 Jun 2025 14:39:07 -0700 (PDT)
Received: from localhost.localdomain ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538234c9c7sm851415e9.10.2025.06.24.14.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 14:39:07 -0700 (PDT)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH v2 5/6] net: wwan: hwsim: refactor to support more port types
Date: Wed, 25 Jun 2025 00:38:00 +0300
Message-ID: <20250624213801.31702-6-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
References: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
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
2.49.0


