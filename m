Return-Path: <netdev+bounces-226167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E35DCB9D357
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 04:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E1C4C364B
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 02:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267C51E51EE;
	Thu, 25 Sep 2025 02:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYML3YRu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B241DB12C
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 02:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767601; cv=none; b=FhD4jPKccMK2uqviPAvqVbxlQ/ovtTrrSZNdLNSCuOZxZrnZxxB/BZ+yZ2fRIgOUBzd6BaKIMU70VAGtEQUh1Tg+Wq/OiGs0P6jaVM0OD+venlqkSC1CfV6lWgPS6tKjvQl2p7VQJ+yRqGM3mey/87/K+ARmqOP42jGI7t17C50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767601; c=relaxed/simple;
	bh=A0SYA/uGVqV0t12v78y7j6A0Qn1o9/UofWKnTo4rxks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MMeOjlU0KBaUfUPs1KmAVfGRaBP5pZFu8ci78mte7FCXjeSYpR+eY2QP1zJ/uxxlYKkF98KFkny9Aukjd2VIbZU0+sjMPPiGct7HjXXEhupsvPlv0VLI6ezhhxOaOz0k6b+rlU5vC+YvOBewGu5ySR7rv4Wzz8kufFzb8uId1Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYML3YRu; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-780292fcf62so433053b3a.0
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 19:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758767597; x=1759372397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFI9CyYkDTQ36kWZc+gCQLPuFnUp/y5mcXpEnS25+DY=;
        b=YYML3YRusUXWqwYQe9I9m0oZ4xxZy92Gin7ShxHB5ncLMIG57M83nHmpVSQINvJQK/
         uI/uaXZj9r/RwpQrTqO+Ig4t06uSpMxQJv6UnAYWuxoZun1PVBx+EHi3Gli8GdKb/uDZ
         sc1vsSEVwC6dUiWjdSHOXU6ZMzkrqZoCGr8JstYJgiH1ciOt9zzoNqr4soga3+hBbHkK
         PK225ZMZ2+faLdmr0bBtCg7JOGBib4xo3jnC/2XSx7TRfU89OKNGatAKO9otyFzBCqTW
         youVfN/lzakAZjSUw5pqODqe3Tow4YRFjF95NDQh0miNbcL47vjDYetwwxiyTb9LTTg+
         2StQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758767597; x=1759372397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFI9CyYkDTQ36kWZc+gCQLPuFnUp/y5mcXpEnS25+DY=;
        b=LWoBnWvMmM+B2KnNZ5LNBraiSPZXqukWNSs57PuRAV+sJ+mcZgICtyN21YuOnMLd0F
         juNv5nSqwccyMnUE1Ddgn3N5NBYY07b68iLRxQhoB/FtxjHDjMC+tckxN990Tgo2s+JD
         c/WkYzg3cptGZndNl1OTixdSRQSwUvBWJfCuTOqpFsmXxmrf3WeCGo/gycESY6YIzJME
         xr0JiA2mfBVJGhKIMtkHZB+UTzbuvSon+yuhGVnm+qZCok1hE95jcmrKjZI5o8NgxSMU
         QnJJcXO7fu3WXJ16K5efCkKkE4Hnks/TBuANcSAfswN8nR0WCm6EFoGQqWV7YCAmvpw4
         06pw==
X-Gm-Message-State: AOJu0YxyPSlvOBEp7aaKVa7RobOdle8LOcnsVd8KyeLiySMzVBmUsw+3
	wJMA/RM49PNvoSLlbrLflEJyZ96A5504XpbDPXPtjgzpMhAjPPN1CAUjMjsHvV1h
X-Gm-Gg: ASbGncuhBUteaH+pxd7oI4DoGxyZJAmFGLY1julfOm2ZHQQ1rnjAKHAo5i2AbqMJc4T
	CCM6atsF0XwxaUtvrpCkiqaGf9B9TetgYGqXPZEzoylnN0FZnypYStF20dQdGDIKN4oSbE3Pk46
	hPFxmwkQd7qii1zzLAe2fHaxvRpPq/a3q6Fkeg0TzmB7/fah/cEYszcebbSYasoO4umhLk6jEDK
	SNtjk8PtS5PDrC65WE+2zUWn4kGV7eidrm4txMWmU4fuwKbmslDhBQcFFkmh06TgwOLEBw/8Pga
	BjcR5g9Tcko/AreYETFEUl42OxZgOoOzzLVnm2xdWuC/d2y4Hh6Rfk7yenttsLyE2uVn9PFiptu
	RDfFM+PA/UI+7XHDF2VO4TDhOcMwBcEaoSZe6bhdSzw==
X-Google-Smtp-Source: AGHT+IH8e6so5L+GLUmp5IFsgA7Wbe8X1CYUgfB3rRYj9V6GMkDn1aEkWIvP8u5OgMXiN0FPD+ogew==
X-Received: by 2002:a05:6a21:9998:b0:250:1407:50a4 with SMTP id adf61e73a8af0-2e7d1755812mr2265155637.43.1758767597219;
        Wed, 24 Sep 2025 19:33:17 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78105a81540sm125952b3a.14.2025.09.24.19.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:33:16 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 1/2] bonding: fix xfrm offload feature setup on active-backup mode
Date: Thu, 25 Sep 2025 02:33:03 +0000
Message-ID: <20250925023304.472186-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The active-backup bonding mode supports XFRM ESP offload. However, when
a bond is added using command like `ip link add bond0 type bond mode 1
miimon 100`, the `ethtool -k` command shows that the XFRM ESP offload is
disabled. This occurs because, in bond_newlink(), we change bond link
first and register bond device later. So the XFRM feature update in
bond_option_mode_set() is not called as the bond device is not yet
registered, leading to the offload feature not being set successfully.

To resolve this issue, we can modify the code order in bond_newlink() to
ensure that the bond device is registered first before changing the bond
link parameters. This change will allow the XFRM ESP offload feature to be
correctly enabled.

Fixes: 007ab5345545 ("bonding: fix feature flag setting at init time")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v3: rebase to latest net, no code update
v2: rebase to latest net, no code update
---
 drivers/net/bonding/bond_main.c    |  2 +-
 drivers/net/bonding/bond_netlink.c | 16 +++++++++-------
 include/net/bonding.h              |  1 +
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 57be04f6cb11..f4f0feddd9fa 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4411,7 +4411,7 @@ void bond_work_init_all(struct bonding *bond)
 	INIT_DELAYED_WORK(&bond->slave_arr_work, bond_slave_arr_handler);
 }
 
-static void bond_work_cancel_all(struct bonding *bond)
+void bond_work_cancel_all(struct bonding *bond)
 {
 	cancel_delayed_work_sync(&bond->mii_work);
 	cancel_delayed_work_sync(&bond->arp_work);
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 57fff2421f1b..7a9d73ec8e91 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -579,20 +579,22 @@ static int bond_newlink(struct net_device *bond_dev,
 			struct rtnl_newlink_params *params,
 			struct netlink_ext_ack *extack)
 {
+	struct bonding *bond = netdev_priv(bond_dev);
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
 	int err;
 
-	err = bond_changelink(bond_dev, tb, data, extack);
-	if (err < 0)
+	err = register_netdevice(bond_dev);
+	if (err)
 		return err;
 
-	err = register_netdevice(bond_dev);
-	if (!err) {
-		struct bonding *bond = netdev_priv(bond_dev);
+	netif_carrier_off(bond_dev);
+	bond_work_init_all(bond);
 
-		netif_carrier_off(bond_dev);
-		bond_work_init_all(bond);
+	err = bond_changelink(bond_dev, tb, data, extack);
+	if (err) {
+		bond_work_cancel_all(bond);
+		unregister_netdevice(bond_dev);
 	}
 
 	return err;
diff --git a/include/net/bonding.h b/include/net/bonding.h
index e06f0d63b2c1..bd56ad976cfb 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -711,6 +711,7 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
 int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave);
 void bond_slave_arr_work_rearm(struct bonding *bond, unsigned long delay);
 void bond_work_init_all(struct bonding *bond);
+void bond_work_cancel_all(struct bonding *bond);
 
 #ifdef CONFIG_PROC_FS
 void bond_create_proc_entry(struct bonding *bond);
-- 
2.50.1


