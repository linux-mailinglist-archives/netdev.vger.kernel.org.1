Return-Path: <netdev+bounces-120503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 425F6959A03
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B93281E45
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 11:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4301918E34B;
	Wed, 21 Aug 2024 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHUROTqt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2A815FA92
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724237419; cv=none; b=qYc8/U4GwFGOMACTClVWca2iipyfbUZY9fGHdRid8hh1Px1f40GR5xtzZ+YZrgYuG8xhwjLpI1CBWVoFE12RTMW9GJPLpVB7AkbX+E6QggUD0j69d5K7Sa4/BI69vTKf7dK4t25z/F/bJHmPD8k2MlYLAJNgPMts6rfqrJfRTD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724237419; c=relaxed/simple;
	bh=Zq+0/3Gr2e57AJZa0AMF5OcxcxRIYB7VnkX/NnfF42c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpPefo6wWTp2zIPbr8mwcp7rV4o7IDxVr2g8fynjTWAjuOS/GSmDCDLUn5tqEh6ow9b6FADqmPeItag5Lm3bs/eC+iFoz2ohwevr8NNPZoh8brUwTMwbtqMDPz0BozR9cyDE6datCT3yLvJavPNsGgFrTMI+WhhgljaeBnQgFCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHUROTqt; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7093d565310so4876850a34.2
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 03:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724237416; x=1724842216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gCfqc2cR0PpKpPsbaJjvf5TzqEN3O3X8g14GOIR6FQ=;
        b=BHUROTqt0CSFzvBQkV6V0m1k+F2ZlRJU5+cNlZ7ASg9ED5TyQjWUupTyzQK1MlcHJ+
         EnVN8eBdRePOQjVfoEVcdsJlKVovDWAzSq3yq+v0yrTPUAQjTcXf9dA1mrq9G7OBKdZa
         bDCVd8qiXpvQDWuSdd9yQXMm+N1pELvq+BmbyPnZO+oXLbfyirdW1QpG7ywy+4+Q57ip
         4FWofW8IixXdK4BklIoFxnIM8Q1WLszmrcSokKXIXY6UdYAl1lVfUqn1pZheFRol9tTN
         GWbc6hgB+PjNtKvYzCpLeDOg6V26oerGR+O2ErV3/SaoLcYD/z/M2AG80kC+G6w+zrRJ
         MLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724237416; x=1724842216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gCfqc2cR0PpKpPsbaJjvf5TzqEN3O3X8g14GOIR6FQ=;
        b=NCUT830MikaFCXXN1o6XuBf09xG+X6AGodJg3rhIdz/TQJA7JOozFsaheXWi53URQf
         u357VeJON+xqF2/QlUQ/P0ZD+3Cv322bO4N9YZcJRaN6ddYiDoI2kK9IqY9Ln54qRltP
         /ARXKg3LqlcUxtsPUBoIplMegsia1AHrcYniyHn++Wx2hdwcx0g+HEIsPcayRWknJeaB
         fulJ4PEWGC3CEd7o1ylnzo5mBPo3iFG0k9hZb/uSkCfzZHnMYRiUqN76uGO1vMcdEx2B
         cDwkLCDcw+Iqk1kKuLG1CwtXprjKgPabceVaMu4VmY/Xa0ErJFyEFKso/RDxkYpNQYxB
         tW8g==
X-Gm-Message-State: AOJu0YwVzklDxcsAIOitn5ElYUFQIEDljU4Fmw7WBgB6DcvsR3j8UIQj
	6hQhDvDMLjYNCCdBKzjF5lK8da/gXdXgHBE1/GICkAqIVnHEWG2UTtrMwG5JeJU=
X-Google-Smtp-Source: AGHT+IEHhImaH/xn4Kfl/bEXPeBSR9N8v+DAhgGVwWA+IsdFL4OIoZEiF/AxiKDchr9nV0cEBxJ4EA==
X-Received: by 2002:a05:6870:2116:b0:264:9161:82e9 with SMTP id 586e51a60fabf-2738be910acmr1621666fac.41.1724237416188;
        Wed, 21 Aug 2024 03:50:16 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add6db6sm9652521b3a.20.2024.08.21.03.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 03:50:15 -0700 (PDT)
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
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net-next 1/3] bonding: add common function to check ipsec device
Date: Wed, 21 Aug 2024 18:50:01 +0800
Message-ID: <20240821105003.547460-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240821105003.547460-1-liuhangbin@gmail.com>
References: <20240821105003.547460-1-liuhangbin@gmail.com>
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
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 47 ++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f9633a6f8571..fe10ac66f26e 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -418,6 +418,38 @@ static int bond_vlan_rx_kill_vid(struct net_device *bond_dev,
 /*---------------------------------- XFRM -----------------------------------*/
 
 #ifdef CONFIG_XFRM_OFFLOAD
+/**
+ * bond_ipsec_dev - return the device for ipsec offload, or NULL if not exist
+ *                  caller must hold rcu_read_lock.
+ * @xs: pointer to transformer state struct
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
@@ -595,23 +627,12 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
  **/
 static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 {
-	struct net_device *bond_dev = xs->xso.dev;
 	struct net_device *real_dev;
-	struct slave *curr_active;
-	struct bonding *bond;
 	int err;
 
-	bond = netdev_priv(bond_dev);
 	rcu_read_lock();
-	curr_active = rcu_dereference(bond->curr_active_slave);
-	real_dev = curr_active->dev;
-
-	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP) {
-		err = false;
-		goto out;
-	}
-
-	if (!xs->xso.real_dev) {
+	real_dev = bond_ipsec_dev(xs);
+	if (!real_dev) {
 		err = false;
 		goto out;
 	}
-- 
2.45.0


