Return-Path: <netdev+bounces-248302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 618CDD06B1C
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 02:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1D3C304A594
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 01:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64B11F91E3;
	Fri,  9 Jan 2026 01:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeYgFHML"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112EF1F099C
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 01:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767920962; cv=none; b=Lec3+4cH8SI5MWKl2ofKv0bEZc83m1qu7HMCTqfCLgAOZ8zq2ohZlcyPFxh3/MJkETcIDFbEyeXg/qMWbH5upkekw9ic8iQCrbC4kQCI9oZaYrIsS2OdKlg7Rv4PQXE/ekVvaFeBnDS0UCB13XJbNf4/AwMTI5zjlAFXs2v2nUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767920962; c=relaxed/simple;
	bh=iinJshec64GKg/TN9rII8jst+csOkvFipCTScE05pN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rnq4IDQfL+ZT1Uwdb1jGEra8HpRO0fnV/pTFmXcWWBdvw9MkCcyhkkBElwdBBpGEl5/uh5naeIAVHSu+s/WTEVUGYILVome8KVjXk//nG888kG3utbECCEgMSOQupmJl8TSOlZ+ayC+1jlpTo7EoAbcUgaiRYIfTK6SWfgDaMZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeYgFHML; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so3210297f8f.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 17:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767920959; x=1768525759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JY8A3nsH5MtpPAQRzjCOTgxx0rWSatWQPCAX40Np41o=;
        b=CeYgFHMLJi2Bx+mVUM4ZwQNGsKbXNw1xrRldpFnOMwVIUcbd4Sal9SimKUt0ketaYp
         UzyXM1xi1FaSHeT4rc37IKufNDkLh1wD7gd2BwiUrs8cjfC0X19eBbYdDP0swhYe4Bzt
         xeL6N5qKwTf1+rIgVbNL6UyWn9NSwVF2nJdp55gGigOdY8Kn36UAGHfnpCSQ3n2gGhVJ
         KzA9mpG9t+DaPKYT0DLYDc8c7wIdBzqWd6ysMSeAldteqKa3+Tl5r7Y75YbEsQ5fqXvV
         T8zhaNytIf2xv7dYWsoVtCc38QBq0EqhjB90KDzjh9ddxWP5Dsm0bcXUs09FLi/XnBhu
         c68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767920959; x=1768525759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JY8A3nsH5MtpPAQRzjCOTgxx0rWSatWQPCAX40Np41o=;
        b=kaMhzxIi+T2ZawAin8gHU8epLOGsqtHkDRM6+8tSXjAnihvfD3PTKv3ETn6CC41r5u
         ObZaa8Hy9CYd1xvClU8c0QXM8bqm5yjoMR76DBiY8Yw5JjGuN+dKvYBMJcVpZmFd4kXz
         4XsWdUCp37jXlawKLq7YJDFigrIgTG26Sfj70ymEk7VvCUlJQ9R+F78BRARQLrpyA6C1
         3zbQQFKWoRM1CNzqBvCzMj/GZ+QtsghU8SGqAXR0Gx0qlJkNfU7chNsdiLr1LxuBS6ma
         7/nPhDuCpgMBDwzjFRnuMSj9wGCMVw+USHFYbEqB4vhqCnGdjXpOZ01UxeoN3NJvsTA5
         dikQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjW4X+1V8TjVgT8JlKwHsZoxed0CGPDrN0hR2gllDYkXxKLlxukGhjU/BCWKkcOYJbQozrvVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAnWsvQB2olC9UVW4ls09OfGOPNmYNVqQdmHOzRC257SBvVCLX
	+j8c8g+75zrm8xgLa9ymVmESwg1F7/qIPStKsXWMwPb0wQD0ZBp6zsaO
X-Gm-Gg: AY/fxX6XOqsnRXU0sM9wDXJQcweUjqXuD+vJ+5Fu98QHDQkHXILRet9gQCoDxwS9UDr
	4XfpknakBwUFD275gEG4xX+KJLEpPkf6Mtu9PAAgIIpsJYQ1TxrZ+tEr2k8/VXN5ZUHx2BRZ5cO
	Up1YCbGWDD3RhNVYURbgYlYfOtqjPYSl1DdL6Pd8H3/3mIhwxsKzpB2U2JVkC+slHjapdlWDmQK
	dhpO2GuLuUxbcvd4nmUsJJXhWpQL7ptQH8KF0cwnQmZbgjBDEpME7JoQBOUauT5XiloqMxeU5QH
	VvAfHk4oLce/9PYt4IhgzXcw4AZUMZy+wCUi1BpGB7Zc1d5n5Ey/fnTbm0Fa2sPlsLW2rsxYbIA
	V7Cu0KoTIC+0PfUd4lTjzSFxj4PW/dTPgF9pC06fdyX4baXycmOi0IdN7hxJR36FqPMMpB71+95
	/cYzpG8NsV4Q==
X-Google-Smtp-Source: AGHT+IEqHlDkH0UxjoAAfYg301owqmBxoZDQeS9f8Y1jOv2GiJHpvEgq4q59IDjHJ8z1+wpXSVlCRg==
X-Received: by 2002:a05:6000:400a:b0:430:f1e8:ed98 with SMTP id ffacd0b85a97d-432c3790b90mr9112198f8f.17.1767920959373;
        Thu, 08 Jan 2026 17:09:19 -0800 (PST)
Received: from rsa-laptop ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e17aasm19698214f8f.15.2026.01.08.17.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 17:09:18 -0800 (PST)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH v5 6/7] net: wwan: hwsim: refactor to support more port types
Date: Fri,  9 Jan 2026 03:09:08 +0200
Message-ID: <20260109010909.4216-7-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109010909.4216-1-ryazanov.s.a@gmail.com>
References: <20260109010909.4216-1-ryazanov.s.a@gmail.com>
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
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes:
* RFCv2->RFCv5: became 6/7 (was 5/6)
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
2.52.0


