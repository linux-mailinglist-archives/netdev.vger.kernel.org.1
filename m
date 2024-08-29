Return-Path: <netdev+bounces-123188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746E196402C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 11:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B22A1B22468
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5C518E05E;
	Thu, 29 Aug 2024 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bupjNBxJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FE018E047
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923910; cv=none; b=skDtq/EFmHlkyDXM4rQ7DKpxeQqjX1HfLVS8XtAbkrJxQuxIgWsTjYl3cNjiG0absrRHDj1xs6msfzN3AanmWW8Pj3Uhzmls9Xv8nu5LhhKKdotVLozgDdOsMBy2Y/9AZrskq3EmIbv5DYuRdP0yTNQmnlrYDwFLXTgL2wHB8SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923910; c=relaxed/simple;
	bh=D+s13BDEUnJeZYrxYWqDLcqwE/73VE4oMFbNYQhetCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKo0Irtz9yhJehcEhsXhd6byncV/M27nwXjOKudbP7rp3yGMZ4m5lTkZsxPWP3XAqmYqzvCrDJ3OWD3rzLlFdxVms8RsLEBR9CV2FkbmaJJRKxBdrGu9p5xqJHgJy83XG7zxLFK0sykBz0PIIP3ye3SMGo/LTUIwtioC00eN2mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bupjNBxJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7141b04e7b5so261951b3a.2
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 02:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724923908; x=1725528708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPRhluOYd/mm0oVegksOEHKc4Aw+9DxFrTl3DWLVjzw=;
        b=bupjNBxJU0kiNofYZhncRnESEOCiPsg+FTC7V2ifL8HdKfMqY1DBK/L0Fm4DuAipb4
         VfYzdANGyuMvfqWCEKzHqzTaaxmRTlftAVA/f181Uyt6jrlTkDdXOguFy1pr0sG7saQB
         igQ+QYDp3kYaLsrJK1oLuIL3j2mBrVBXPu5CKacvUFjQpDUiEN+tqrmPHWyfaR74BdQW
         o0UaTpQvE7sc2OY/vqfb1U6gHRJQWSO3q8cjb87Dgt0CfNyqblB46M72a8P9Zd4xq0ka
         LRf+MjUFZff7u6W3bZmm2graqIloKKQmWv9JGmbcOw91OqRBfU45iiFf9PrMSEkcLxLC
         RjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724923908; x=1725528708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPRhluOYd/mm0oVegksOEHKc4Aw+9DxFrTl3DWLVjzw=;
        b=b+J2MarQOPUbUS3ChrNXkrCZ1S1rOTw/+DcmocE+r5bvJxRZpt3dejWFkyMIGlMDzg
         ZXv0A4LDGhd79NjuplnXClp6VjwJZBfxgLlwm1mC6p/AhsvRLl8+Nkf9I8JIDNrTLEtG
         8YaoPR5lakrJ/uM/5nk9FN1Qx5jOtPxhLp3W41aF0L9g8MyO7RkDlsBK2V5qtpw5RUoc
         i8ZVyUhkKoc3pHoaxYxHnq2N/+OYXjDbHi1JLLUATLCn/pxlt9FFLj1yAN7CHwEYoPZ7
         m0KiogPmmIgLBtTv7IZQSItO/HtPoDGMTGEkiHcQWhTn+F6SS9xAs/bSbRNNA+gR8zUM
         ljWA==
X-Gm-Message-State: AOJu0YyFhZUFWLuzyu4AIvbIhpm/0kLPnDxHp26nZxs8gZ5eVSGCcePu
	eq3TLrvmH1+Sr7PYbCVUDpZbPBnSzYm5QHS3HnSnHDDE24ixF14c2BgVjI28mrscuQ==
X-Google-Smtp-Source: AGHT+IHLn8rDWGFw7Cpy+cfjDQt8kLEP3YoKA1qQ3EFKLvFqYR1XOdzJwkMRDwh+7ZFWVICB/TDUPA==
X-Received: by 2002:a05:6a20:c78d:b0:1cc:b22d:979f with SMTP id adf61e73a8af0-1cce0ff23f1mr2172558637.4.1724923908140;
        Thu, 29 Aug 2024 02:31:48 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e575c417sm743276b3a.197.2024.08.29.02.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:31:47 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>
Subject: [PATCHv6 net-next 1/3] bonding: add common function to check ipsec device
Date: Thu, 29 Aug 2024 17:31:31 +0800
Message-ID: <20240829093133.2596049-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240829093133.2596049-1-liuhangbin@gmail.com>
References: <20240829093133.2596049-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a common function to check the status of IPSec devices.
This function will be useful for future implementations, such as IPSec ESN
and state offload callbacks.

Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Acked-by: Jay Vosburgh <jv@jvosburgh.net>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 50 ++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index a3b6e6c696b4..4eb4d13fcec9 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -418,6 +418,41 @@ static int bond_vlan_rx_kill_vid(struct net_device *bond_dev,
 /*---------------------------------- XFRM -----------------------------------*/
 
 #ifdef CONFIG_XFRM_OFFLOAD
+/**
+ * bond_ipsec_dev - Get active device for IPsec offload
+ * @xs: pointer to transformer state struct
+ *
+ * Context: caller must hold rcu_read_lock.
+ *
+ * Return: the device for ipsec offload, or NULL if not exist.
+ **/
+static struct net_device *bond_ipsec_dev(struct xfrm_state *xs)
+{
+	struct net_device *bond_dev = xs->xso.dev;
+	struct bonding *bond;
+	struct slave *slave;
+
+	if (!bond_dev)
+		return NULL;
+
+	bond = netdev_priv(bond_dev);
+	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
+		return NULL;
+
+	slave = rcu_dereference(bond->curr_active_slave);
+	if (!slave)
+		return NULL;
+
+	if (!xs->xso.real_dev)
+		return NULL;
+
+	if (xs->xso.real_dev != slave->dev)
+		pr_warn_ratelimited("%s: (slave %s): not same with IPsec offload real dev %s\n",
+				    bond_dev->name, slave->dev->name, xs->xso.real_dev->name);
+
+	return slave->dev;
+}
+
 /**
  * bond_ipsec_add_sa - program device with a security association
  * @xs: pointer to transformer state struct
@@ -594,23 +629,12 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
  **/
 static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 {
-	struct net_device *bond_dev = xs->xso.dev;
 	struct net_device *real_dev;
-	struct slave *curr_active;
-	struct bonding *bond;
 	bool ok = false;
 
-	bond = netdev_priv(bond_dev);
 	rcu_read_lock();
-	curr_active = rcu_dereference(bond->curr_active_slave);
-	if (!curr_active)
-		goto out;
-	real_dev = curr_active->dev;
-
-	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
-		goto out;
-
-	if (!xs->xso.real_dev)
+	real_dev = bond_ipsec_dev(xs);
+	if (!real_dev)
 		goto out;
 
 	if (!real_dev->xfrmdev_ops ||
-- 
2.45.0


