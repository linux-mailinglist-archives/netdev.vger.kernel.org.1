Return-Path: <netdev+bounces-232343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E88BC0443A
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 05:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5125E3B9528
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 03:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A6927B4EE;
	Fri, 24 Oct 2025 03:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW3WuWI0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AE72749D7
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 03:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761276794; cv=none; b=WO5/1tzr4uKGLolIwQ4ArphUhjDIBD8IkSRiPhLr/cbIZ+3sLl1TSNBioRm8cyHf1nuZMIjnb+a90gHCkkdhz47rJ895pQRtEJ2c225BEzpz9rCR3fNp+gmpYhS/0WnfaqXV39d4wwXwtiZAhCxXkEO1RHw2dNHGaQsnSy+l/Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761276794; c=relaxed/simple;
	bh=Y4/7kxOvf+Po4ZQ5WfwfaUNB9yGYyDH1l93lR+I4MvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUoIXsSWKYv6GF8b7oiqzJbJiTtH8ThRNSgJI8FcMDY4b3tikD3MYpfAGhe+xXJ/zbTXCfvqfJR/QtwCH0VlE6bj1ir3OzktOL3oD0ABqUCxPtS0sonSmAQh8JjiMlrlBxnY9PB3+8IJ1ZryR8yEUhPAFC2vJvH7Ge2EAUZ+DwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aW3WuWI0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29470bc80ceso16717535ad.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 20:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761276792; x=1761881592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqGjoL6ZxqRuvTgBTFhR7XlvSN01n0xXPYNgq1DkmvE=;
        b=aW3WuWI0NUPfR9YlELKW2iINtEi9XYNs0i4Y9fLgvCypp+m2sjps9MdXGxMROBWn2m
         nzXAf8BUg8Y0aW+WIKHiCt3gdHFSi9znKpOQAGyYGmuh1jeOWX0vHCKGHeZQSS5fMG7c
         oNjoZ1oSIUALqe/SZvu846/2MG0CUywpqMTjFBDHsk12BKZceZMTjzzzfEZJFCLJLVxE
         QGvOoC3fju57Gb25FbqcHwOmHPbhUE6kaSOTEoR7qzNT4L6EDqRUs1Mm8x+HT3Hmo4ZD
         RBbnm6OhwaD3wYYlXwNmLoSFTQH766zujxsdLTBOY3DEf2yj1YZdMZ/8LebMQdgEyFee
         oDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761276792; x=1761881592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqGjoL6ZxqRuvTgBTFhR7XlvSN01n0xXPYNgq1DkmvE=;
        b=sU3fruADVyzeilxbMqtdka/OzQ7BveyDCpNoVLCSCtX9qPjJBkgbbUzNQr+xakrQAU
         IjKzyum2xVaCvS7hh72YWx+WJkn8F4H+/wnMte/9BGay5Te7Faa5+sygbD4/DfomyFd/
         6+FFhVq55MzWMHOHylVwcgTFX/ur+WY36i8Py/kt6Zf4qBR/eoeFUPBxpQ21xPiTLlKf
         sXvUkzSRxhkOXJso8UrlEIgq9Oki5dZuvjpDZz1nvuKyyAy6Qd1gV8e9FjbD8JkL6SRp
         3wvqCqOz8XsLtVwWIhsFa/O1TbTxm5iJc9oIv4fjvqZO8fhyoGEnHLnDt3N9yDUmy13T
         90qQ==
X-Gm-Message-State: AOJu0Yzrk5U7tauU2EaNk6ykFHFysiO1fOYbqtQiXW0NMFM0hmfc00zP
	tyevVT2S++jH3XI+1b8bayS73TQz9jm7JiWs3z5yCACgeO7toy3URsPMxUYden7PUGY=
X-Gm-Gg: ASbGncsVtGXKyJnIuH2n+sPz7dxrbTnULV9tpeF7ItIpsWQUVqywpubHyp2mBkrNcse
	BMEMjBqJXTed7amSPHgrre6TeNla4FTp1R3pzHnHjmBEYPNGzBTJZ9Y1imp1sapZH236NeFromP
	NhLCqEG41D7ahYFa+g9/AByYnh/Sb2vgcnQjIoiQQGJzybZGfjkmPV8Piu24nUafAsq640TywFM
	waIaYGTFcWHqZYmmXrifR+iZz4RdSBZnVelDjVB2RGHZAyV3KWBDwyU7EcycQdjBE4NxQkD17MI
	HfYqP9++MlZlCxPZa8wXvq/sxU+rqhJBjdCtw4NaFxEq7zQW7AVu6reGEdJ/xqpFnUtaH1zmMqA
	rXR/lzGPrr2MS8zXZj/1p7P7PajsiBfc5exhMkf/Ov11S2lTC5uhT9aCoymmOGGUSx1gxZhDZSa
	4pPYVHG1Q/slux22intg==
X-Google-Smtp-Source: AGHT+IEvpsqt6uv0HWRQnHevKvtcDn8gVEGvS5rTwnsQrRLfJgzSufjkPD3j+2HYjJHz0o3hCrw3MQ==
X-Received: by 2002:a17:902:e805:b0:26a:6d5a:944e with SMTP id d9443c01a7336-29489e3e784mr11842035ad.24.1761276791160;
        Thu, 23 Oct 2025 20:33:11 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda7949sm40394265ad.3.2025.10.23.20.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 20:33:10 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] net: dsa: yt921x: Add HSR offloading support
Date: Fri, 24 Oct 2025 11:32:28 +0800
Message-ID: <20251024033237.1336249-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024033237.1336249-1-mmyangfl@gmail.com>
References: <20251024033237.1336249-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add offloading for packet duplication supported by the YT921x switches.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 24 ++++++++++++++++++++++++
 net/dsa/tag_yt921x.c     |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 485fec3ac74f..885a63f2b978 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -1038,6 +1038,27 @@ static int yt921x_dsa_port_max_mtu(struct dsa_switch *ds, int port)
 	return YT921X_FRAME_SIZE_MAX - ETH_HLEN - ETH_FCS_LEN - YT921X_TAG_LEN;
 }
 
+static int
+yt921x_dsa_port_hsr_leave(struct dsa_switch *ds, int port,
+			  struct net_device *hsr)
+{
+	return 0;
+}
+
+static int
+yt921x_dsa_port_hsr_join(struct dsa_switch *ds, int port,
+			 struct net_device *hsr, struct netlink_ext_ack *extack)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct net_device *user = dp->user;
+
+	/* Nothing special here; we natively support tx packet duplication */
+
+	user->features |= NETIF_F_HW_HSR_DUP;
+
+	return 0;
+}
+
 static int
 yt921x_mirror_del(struct yt921x_priv *priv, int port, bool ingress)
 {
@@ -2879,6 +2900,9 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	/* mtu */
 	.port_change_mtu	= yt921x_dsa_port_change_mtu,
 	.port_max_mtu		= yt921x_dsa_port_max_mtu,
+	/* hsr */
+	.port_hsr_leave		= yt921x_dsa_port_hsr_leave,
+	.port_hsr_join		= yt921x_dsa_port_hsr_join,
 	/* mirror */
 	.port_mirror_del	= yt921x_dsa_port_mirror_del,
 	.port_mirror_add	= yt921x_dsa_port_mirror_add,
diff --git a/net/dsa/tag_yt921x.c b/net/dsa/tag_yt921x.c
index 995da44f0a2a..0ad83924fda1 100644
--- a/net/dsa/tag_yt921x.c
+++ b/net/dsa/tag_yt921x.c
@@ -46,6 +46,7 @@ yt921x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct dsa_port *dp = dsa_user_to_port(netdev);
 	unsigned int port = dp->index;
+	struct dsa_port *partner;
 	__be16 *tag;
 	u16 tx;
 
@@ -59,6 +60,9 @@ yt921x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
 	tag[1] = 0;
 	tag[2] = 0;
 	tx = YT921X_TAG_PORT_EN | YT921X_TAG_TX_PORTn(port);
+	if (dp->hsr_dev)
+		dsa_hsr_foreach_port(partner, dp->ds, dp->hsr_dev)
+			tx |= YT921X_TAG_TX_PORTn(partner->index);
 	tag[3] = htons(tx);
 
 	return skb;
-- 
2.51.0


