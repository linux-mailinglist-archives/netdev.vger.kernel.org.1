Return-Path: <netdev+bounces-186853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240BDAA1C08
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE85D4C1CED
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8DE27A912;
	Tue, 29 Apr 2025 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggkFFXMD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856A9278E7B;
	Tue, 29 Apr 2025 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957866; cv=none; b=pu5GJPKgFUpLQtuiGcdAxfv2mCUgtcj7tylvNB1OtFy2rzYXGvhuywXgvc18Mi2GA0s+iSFFajAHWVV4gSIm2XOx5LfUk7zcI48+2c8Yipa4YW2z7DIXhhFZvm28WCRmzQbFMwBBR9QU6Jjr7JTR0szXcGeiY/ElGz8jtsZ+HGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957866; c=relaxed/simple;
	bh=iKIi5IbtIQ6n2Yqby2/QwXaGpzinjrmagh0Zcb5dYlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVQ3qHWxMRN85jEtuAlhBezR9NrNP32Fh4xQeqcObUuiKFgZMjc3NVLFSOD9N35jkOlsGFcMeGwM6Xb4xO4YbM7BjwcJUWEWNRUvZ7yInYKgUfXnh9zh0XuY90DLFZlMCqK3hG1TmpFevn/gx59ELU77RnZT7XgY6jPkOkGcguA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggkFFXMD; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5eb92df4fcbso12536909a12.0;
        Tue, 29 Apr 2025 13:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745957863; x=1746562663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5BNxoTrzKFeKZ63Ngyf0mjUdLNCnvkNWHzVfnwG0qI=;
        b=ggkFFXMDc2mhWBJ0kxVMKXD8zDKy9TIuayxpgbRsbjqxCcV+zoiUhUeCsFEaXbp70n
         NnOKwYdBBkylhxJp4R/pa/X15btz6wmdhZmw0Jd3LvCY0/L0KqiSOAmC62ujOs0OWLdb
         VjZ1qjNncQw6Eij89NE/ERWTas87R2t5Hn0bw1PFob+AxGrzXoGiPU8tgSm8uavXm3no
         KDlqpL0D9x7kJ6+Xn1rjZNK9PH6iff4qQ4+81zMDcSIFYGe7mktIHoCE+WZGCACqde8Y
         HF7qQwByGw9S3sCM4BTuXxOVCkJtMPOF0OTfTxDIZx12KwfCIZmFyXvp4nZ1XkjkP7um
         dz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745957863; x=1746562663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5BNxoTrzKFeKZ63Ngyf0mjUdLNCnvkNWHzVfnwG0qI=;
        b=WgDVu1ySxBCw4XR8iAoykxQps/zhbxZ2/IqF7KGo81mglo1fM2O8xLKzYCRkGMhk3m
         E3hjfXxTD56BLEkZEgvJqCeIQ66t12xdVCkdC+7KNXa4Z86Ti+oFojUBbjHRFQqFFuWY
         Vw7dxXoyR4tYhBzokC7zywV5jLQ3td5GaxNTY/M0kKhnRUHsyPfl4wi+K8l+BYUGGL5P
         e/IrXyYF8Jw5fsHOwOwVbK1dcBRzMu1KjRwbtqm/u7G8Cry3xptpPxop+LtX+Mc2Wsy5
         7YNqoYJ1sWc/5lm6engtECPQaqj8cYXpNjunWsM+kmR7yIeZB9BkyGpWkH7YZKd7OzKe
         HPpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0Hk+aZ8+XWcqoTNw5vf5DS0fkyMfbHJOjBuQAY2RQC9M2hiwU1xy2/Yk2nwSBJFWsAwm0LW4P6leK/vs=@vger.kernel.org, AJvYcCXWJI9zA+R4gOVqC26gG3I0RsTaFgj/xjYES7GlKduUTLIrDN1KGbiBOeUDURHjPXhu1NadZeBE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5kEdKj6NDm2ycVPgB0Ao4FChCy0Q9uAgpEdu/jY07FoS+/KBL
	n8raaTu7r04T3aIL0CqUbeZIGBZo4SpT8AqYIur+cpWjx86dD2E8
X-Gm-Gg: ASbGncs7YDkLGseKyexYdu3YH3ujG1kqS2TBTs6+Dt6gFaaK0+N4P3VSJruIdOTFPGh
	VTzxQMRhnVM3j44lCybNzEl+vLoQszVCuMmIqCQQuJSOIrt+K1fWkTxw+e8PS0DGRlQmjfHejep
	uh07VHoBH7rycfL3BkxAezMD4t5CNyslaRWR54OrgvmflBqGr7CeSKy87qSULOngv2NnqXY5g+o
	T4ShIsqBlyL9XE8kRt6eqN2suieW3uZqESITVSDTEwnT+k34tBzM9nff7fC1p3MJVx4Iz544L80
	xLBEuk6/M+Et1mRo4d5qiX5+3v7yy3VWj4PoFNNx2hGQ4yL7rbrEhWdEdJoCiQQRyKYVsqUYiNv
	Rm3I7o1y6BPPmYEDhZck=
X-Google-Smtp-Source: AGHT+IEg99rGpo8rsFAZS+LhmSX7lC7sLyGZu1gg/97KqcYbBE3PfMub95Xnuu1OY1tkrehDn27s8A==
X-Received: by 2002:a17:906:c142:b0:ac8:1798:a796 with SMTP id a640c23a62f3a-acedc773ef7mr65205666b.54.1745957862650;
        Tue, 29 Apr 2025 13:17:42 -0700 (PDT)
Received: from localhost (dslb-002-205-023-067.002.205.pools.vodafone-ip.de. [2.205.23.67])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f70354633asm7773423a12.55.2025.04.29.13.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 13:17:42 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Kurt Kanzenbach <kurt@linutronix.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 11/11] net: dsa: b53: do not set learning and unicast/multicast on up
Date: Tue, 29 Apr 2025 22:17:10 +0200
Message-ID: <20250429201710.330937-12-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429201710.330937-1-jonas.gorski@gmail.com>
References: <20250429201710.330937-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a port gets set up, b53 disables learning and enables the port for
flooding. This can undo any bridge configuration on the port.

E.g. the following flow would disable learning on a port:

$ ip link add br0 type bridge
$ ip link set sw1p1 master br0 <- enables learning for sw1p1
$ ip link set br0 up
$ ip link set sw1p1 up <- disables learning again

Fix this by populating dsa_switch_ops::port_setup(), and set up initial
config there.

Fixes: f9b3827ee66c ("net: dsa: b53: Support setting learning on port")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 21 +++++++++++++--------
 drivers/net/dsa/b53/b53_priv.h   |  1 +
 drivers/net/dsa/bcm_sf2.c        |  1 +
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index a2c0b44fc6be..9eb39cfa5fb2 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -578,6 +578,18 @@ static void b53_eee_enable_set(struct dsa_switch *ds, int port, bool enable)
 	b53_write16(dev, B53_EEE_PAGE, B53_EEE_EN_CTRL, reg);
 }
 
+int b53_setup_port(struct dsa_switch *ds, int port)
+{
+	struct b53_device *dev = ds->priv;
+
+	b53_port_set_ucast_flood(dev, port, true);
+	b53_port_set_mcast_flood(dev, port, true);
+	b53_port_set_learning(dev, port, false);
+
+	return 0;
+}
+EXPORT_SYMBOL(b53_setup_port);
+
 int b53_enable_port(struct dsa_switch *ds, int port, struct phy_device *phy)
 {
 	struct b53_device *dev = ds->priv;
@@ -590,10 +602,6 @@ int b53_enable_port(struct dsa_switch *ds, int port, struct phy_device *phy)
 
 	cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
 
-	b53_port_set_ucast_flood(dev, port, true);
-	b53_port_set_mcast_flood(dev, port, true);
-	b53_port_set_learning(dev, port, false);
-
 	if (dev->ops->irq_enable)
 		ret = dev->ops->irq_enable(dev, port);
 	if (ret)
@@ -724,10 +732,6 @@ static void b53_enable_cpu_port(struct b53_device *dev, int port)
 	b53_write8(dev, B53_CTRL_PAGE, B53_PORT_CTRL(port), port_ctrl);
 
 	b53_brcm_hdr_setup(dev->ds, port);
-
-	b53_port_set_ucast_flood(dev, port, true);
-	b53_port_set_mcast_flood(dev, port, true);
-	b53_port_set_learning(dev, port, false);
 }
 
 static void b53_enable_mib(struct b53_device *dev)
@@ -2387,6 +2391,7 @@ static const struct dsa_switch_ops b53_switch_ops = {
 	.phy_read		= b53_phy_read16,
 	.phy_write		= b53_phy_write16,
 	.phylink_get_caps	= b53_phylink_get_caps,
+	.port_setup		= b53_setup_port,
 	.port_enable		= b53_enable_port,
 	.port_disable		= b53_disable_port,
 	.support_eee		= b53_support_eee,
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 4636e27fd1ee..2cf3e6a81e37 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -384,6 +384,7 @@ enum dsa_tag_protocol b53_get_tag_protocol(struct dsa_switch *ds, int port,
 					   enum dsa_tag_protocol mprot);
 void b53_mirror_del(struct dsa_switch *ds, int port,
 		    struct dsa_mall_mirror_tc_entry *mirror);
+int b53_setup_port(struct dsa_switch *ds, int port);
 int b53_enable_port(struct dsa_switch *ds, int port, struct phy_device *phy);
 void b53_disable_port(struct dsa_switch *ds, int port);
 void b53_brcm_hdr_setup(struct dsa_switch *ds, int port);
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index fa2bf3fa9019..454a8c7fd7ee 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -1230,6 +1230,7 @@ static const struct dsa_switch_ops bcm_sf2_ops = {
 	.resume			= bcm_sf2_sw_resume,
 	.get_wol		= bcm_sf2_sw_get_wol,
 	.set_wol		= bcm_sf2_sw_set_wol,
+	.port_setup		= b53_setup_port,
 	.port_enable		= bcm_sf2_port_setup,
 	.port_disable		= bcm_sf2_port_disable,
 	.support_eee		= b53_support_eee,
-- 
2.43.0


