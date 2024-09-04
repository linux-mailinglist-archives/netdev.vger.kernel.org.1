Return-Path: <netdev+bounces-124765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB4D96AD63
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 02:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9EB1C20FD5
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 00:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3384963D;
	Wed,  4 Sep 2024 00:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qz8qNlx5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D280391
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 00:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725410113; cv=none; b=ksTCJE4cxCUyedZS2NwMA4AeGGOhpne+8Nk/cleKWUZXnlWQZfST9XPAAR34SJptSDl7C+cYESyvPcnUd9SJcs4WdLIULbMubY+0E4Il6yc93WkAlz0AZHR9Mj1F/dBmGuYW9Hv61TE9F2UExGaVMHKuo/mcQYXrYtLRRORPT84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725410113; c=relaxed/simple;
	bh=nH9cie4EipFRr9xRf7dHReaZsoy6tTleh5bMiQVIWvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/aNyNwPHmbp2snFr38t5TB8F+HVFIaFeGgFTUhJ9MmrUzu7zuV09tI/2PA/0hWQzlg7iRAOqojIasxTU21abK0ToabMthr3JvNBdSk1BVBMuwGQjPGx5ClLQtowPKJEvpUdPIjT+SiAwIb5ZjOzC69jKD2VrEixuNyL/ZYtMAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qz8qNlx5; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-27806115eafso109802fac.3
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 17:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725410110; x=1726014910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRYpxeP62juRhoXXN4rMqIUv1DTtYurPPQTT9nnc0mU=;
        b=Qz8qNlx5WdMXY9zC2Pgs/2Krg4tBjcgHFpVNuFWfLZGkTsWdYN5umNY0mnU7b2An/n
         zdObiXEury1ffWxKjHGPKlBB0S9TujYaLgbhd9w3cb9FlFePv3/UreHIaNEP795GR/yd
         JyBPAen7wP71cxPJwtPGcoOB4+xLFh6Sr1AuH4ckrOIn5SpyyTID1NoLBaiwBZdDHjYw
         DUE8CGBq5cqzHTFniHNwC5TI9jdZ1OsEQNyIvzfjEBKRXFAYraFZcbMMdD449/pwXnwu
         VLk2x5VKRLSp5LZK9+vmpnXEIhQ1TRRnTCc856BF3PKQ52g/ixasocnp5JZ+x8EJtboy
         r1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725410110; x=1726014910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRYpxeP62juRhoXXN4rMqIUv1DTtYurPPQTT9nnc0mU=;
        b=nyUXEHSd6ql7nf6qZaINHagZrgL0WxID+7UWpBzAlNtFqTiuC83MHCENh6Xbeh/uDT
         ueZpMcrszGx6LLEJ4iE/AwfRSf5x2ZhyKW+NmOZvso4GyCfRNtDnjDKx5EV0wLfgfMia
         ezjggBiSX7B5uld22nEwdmfW/Mu8sPOXOk/dPn+IhOSp3K4iqSjpUn9/XHzcMe1MAvKR
         dCszTtmEOOadvQZbboeB1H4zqBLVpM/2huD1plUwtdeC8BGXZz2BhDMJ226teiYpYE+H
         +6/00s4ITpTR4+VtWLDguuV/VYlWa7t92A9tiLqhWj+fHFhfY4+7TljoZPna34omf/E4
         9tXg==
X-Gm-Message-State: AOJu0YyS/EU6PBmR/sRuBm+LKRjrsaCdyUhLA6lL/M3ofqeBrUZsVu8O
	0CZHHzjh9BUWKeNBqOhiF0f3aZWxbQUOM33Wh70B8QlGQ7xekb9Jm7qsFGfFVmXSfQ==
X-Google-Smtp-Source: AGHT+IHrWS0YJuQs8JtjAoruHphpJbMPa4JSx65jYPTxS8ZkdXS9EyF3I63La/GW1y3NsF4NAZcZbw==
X-Received: by 2002:a05:6871:79a6:b0:25e:fb:af8c with SMTP id 586e51a60fabf-277900edeb3mr20312878fac.18.1725410109969;
        Tue, 03 Sep 2024 17:35:09 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778589133sm444218b3a.109.2024.09.03.17.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 17:35:09 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
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
Subject: [PATCHv7 net-next 1/3] bonding: add common function to check ipsec device
Date: Wed,  4 Sep 2024 08:34:55 +0800
Message-ID: <20240904003457.3847086-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240904003457.3847086-1-liuhangbin@gmail.com>
References: <20240904003457.3847086-1-liuhangbin@gmail.com>
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
index f13d413ad26c..46f46fea9152 100644
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
@@ -640,23 +675,12 @@ static void bond_ipsec_free_sa(struct xfrm_state *xs)
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


