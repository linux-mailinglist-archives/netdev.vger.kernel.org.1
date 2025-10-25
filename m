Return-Path: <netdev+bounces-232902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23131C09DC4
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 19:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19F754F37CC
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 17:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECCC3043C8;
	Sat, 25 Oct 2025 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i89VBVci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED17E2FF17F
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761411988; cv=none; b=gvbY3OXz74/A8vKEwP5C6KXzP7J545SvSp5VJWJx1jEfWS/aunRfCh8+Ft0FigCfBY2LM30UMsAvBeUXfLs1j+QBVbmAmg5Ysjc2aampaRmwAfPX+T6QNE84v75Miz8jABGrVp7IqyS2qhi84FABoD1Y21VB4PsFVue6kOCE7hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761411988; c=relaxed/simple;
	bh=Y4/7kxOvf+Po4ZQ5WfwfaUNB9yGYyDH1l93lR+I4MvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjvtqf5x5zj4gF/DnVbnQsiMbsIiiTvP480j0KOhqQHrjf1hBMCEx4UehXKyIXOQJK0hTjxXKsuF68vSMKILs3Sfi4y8ZMDiMm0ASMXAWJdxTWvDHO2tKMX1UGfTjOn5jSYh7+X1ccCjLtxX0OWLyEzIjan+N90vxkq97/YCZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i89VBVci; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso2782156a91.3
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 10:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761411986; x=1762016786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqGjoL6ZxqRuvTgBTFhR7XlvSN01n0xXPYNgq1DkmvE=;
        b=i89VBVcimjRuuNk1j4MPBydGMZcCdOvOy3HTclLn26HdJQXGK6xtZM9ffuj6c5wHZl
         irvRlpnDbLhLqzzeUmyGTteIc3MzKA2DDoolqjSn8PrpX/JXbH0RYyNq36GI2grj/3kJ
         dU/Uau+ErHu7ai0QHtWEXXVdeXtxNA01G3qF7ONRVQVHhNMGvIIeHAX8YQdAK0VBjkAF
         Zk34pErFMnyNVP/sElCRxr8UXxlMOaQhtE+halG+I9ulhDSN6/4YtuusqNVbSS5HVNHK
         gIs5Q/ZZtIeEze9HsXoHAEYEi/pjj54vT+1mlCQlegEfCaYR705WNgQkBX8RSBcyo39b
         EaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761411986; x=1762016786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqGjoL6ZxqRuvTgBTFhR7XlvSN01n0xXPYNgq1DkmvE=;
        b=gMCTbT5BB2YI4Rb9wQ60vSWtKsJ24oCye5/46w3Gx90i7vLeJTrY28UeG1W49YiLsa
         saWqi+ZkYKDr2wfmUjSiTHIcJnDbFnInvl0jos0QrxGxO+nB3tg/boj+TYfbvT271EnG
         +iX5xyDuMsnYXj7cX00EG9xtag05yIsmB8nuTDKHrBeuG/PwjR0vjZa8SaaEyQqeSxdD
         bov+UqNcnltxcp0/a6ZPweccO3Vbh5fVw1r9IP1j0mx1yIf2U5S/CWSil4Q6TEA0EqTF
         mq6g3tpefxzbeK4LsM/7ygAdep3pa/JJEOSm1YnNJmarHpRjd/We0ZhH5+8gE4FuC2gc
         niDQ==
X-Gm-Message-State: AOJu0YwysLcp9RKI6a9eNhA5qh4jsNBVHS+bH+mRWOKlSpgk5W22K+u8
	Yur+Rxf82ttEeSnL+Ak7aUG5I9jHqS0+6zyHyRJ+mplUGeA/fB6i9JpAtPqezwKr
X-Gm-Gg: ASbGncvGh1mPVXxp3rjIBZWrnmkmrWvC3vhOrtRL6GXp3ptMU4zMHy8SgI9Kk/vlwww
	utKYT2h+SqyBWpqoprBaarrGF1G1DB1RocoJQdg3emszO4LuetKjKDah1ybufJIe99b942dBbbh
	yniUbmNmk6VnzftEZWvC6N4zddjz8T5AeKZ0qXsGsZ0AnaLfM1UU/6ic1WTU5TBTIEtCB2YvxnA
	KLjD2ndOd4lt6r8qcs/fSAuEjJYwZhidcf0KFnGXRidXsxb2Wa07N0rormUNjvRhivSgSRgNLTX
	bLNn2NPR0OtKhadGt9Hn9FVxJjERWzhOR9tA0Tr5WRzfDshZeZWC+LQvOtIuSfzg6fUbH/HZgVn
	rY5yilIqZCVQ3oRQZQn2I+iFfDVW4wDCpVNonoR+ofHza6On1JuxdhY5TgRRwHxGd6QQZNoAhob
	OQIAn5WqA=
X-Google-Smtp-Source: AGHT+IFSbP2Zm6lh0Mx2XlzjJZL1IGNrCV+TBRlRJ7TE1VBAFowd7AX7jxf1xCpHgj0YzP2E2TmA2A==
X-Received: by 2002:a17:90b:55cf:b0:32e:64ca:e84e with SMTP id 98e67ed59e1d1-33bcf874448mr37650304a91.15.1761411985988;
        Sat, 25 Oct 2025 10:06:25 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e70d1sm2857842a91.11.2025.10.25.10.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 10:06:25 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/4] net: dsa: yt921x: Add HSR offloading support
Date: Sun, 26 Oct 2025 01:05:26 +0800
Message-ID: <20251025170606.1937327-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025170606.1937327-1-mmyangfl@gmail.com>
References: <20251025170606.1937327-1-mmyangfl@gmail.com>
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


