Return-Path: <netdev+bounces-119947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8BD957A9A
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 02:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB01B22FD5
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BD08825;
	Tue, 20 Aug 2024 00:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSPaWutk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF7E17C67
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 00:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724114940; cv=none; b=hlCbUFjft4RzMDOnJFiO1unEGRfovLzBjYoVz2H448mx/YtBVPV4IqUgoHojuvDmh51fQgEgk+UpVryhc03JlVBlm9qZ8/t9fT0EHChj30fWy8l6GNc+NY2O2om+EKNg/h0rVlSPAaTdHttTrc9DBEc0+qeQc83qjS8a5iY8Bso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724114940; c=relaxed/simple;
	bh=yQt4Cluy6o9c+80+JQfQLD/iktSOdzE/jWhOuRBeKg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7wvDEbnJ0T1Ydx08u6EKmpvqyW6H4oEd+ro3DPkuyR3UIeS32Y1Y1uuJWDDfZKuF2F8AKnnqQsPRbVv0nWTL6Krxv4N2QU9B3mY/veurxggokP0ZJbV/qdVIUUvZ5VwKAzMVQHyLctbgYGpDb4ZXqeWZFleRbz9QLcHrcqTbVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSPaWutk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2021aeee5e4so14212275ad.0
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 17:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724114938; x=1724719738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LVdds2t/ms5NrJUSfJGtrgx0vk+SGHQw8qpuigL9sw=;
        b=KSPaWutkM5EcsSsEU67BBz65IQinVaO3oWf7rI/TeyeSEax0MxnctAwypu5Ix3eoN5
         uMjfdiJ4Q3iQOGFUBOXeqWQ9w1C4OjTOkrHXH9TElsYowSrHknPEe4aCu49CvTqIPiBk
         b4Qy/LO7lMif6Eu8lJ1mHkbmZlbBTBpvWgXBe00CUtJdiU8FUKZ6MmPBx3anTZbADDG4
         L8DPv8ylb4DNafFWEWIxOKyUogghZZXeZ/RS4JJhwBKcpeEKWorscSev48QIz9wGbNAG
         haR+Yb8hLHG0hUgkbsf8j8lNuTB6YxUqf28SJA/tIdwpkwOT2FyBcjVkWomrf5qEH86j
         Y2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724114938; x=1724719738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LVdds2t/ms5NrJUSfJGtrgx0vk+SGHQw8qpuigL9sw=;
        b=fY6pOBY8yYglkrqX/rtqlv5e9igDzRi6d2s8UFaf0Xqm79t1oE+gZXE1QIYdy6kDWj
         Q3wBx/upDCHhg3+v0QwhKcyQcCvlDMlAFiHd7Y324zIYONB9gKve/CCAFzUW/U5UZKO/
         QxoZNUufObFE6bvM6qzS1x0MlsJ+qo9aU3UY4XptR/tOjF2xJiH0/WsEvETCSY2uE0iU
         PbqS8lZiDTkKUSP8QX+KpCQSx425gPtEi9yHiozAAK9g6xiuZVKboOQIqPSBzswhUWys
         y4eDMHDEqt8pQn8Cuo1Ljb+GhAGG3Ro1+mhfuDx0oTiw/YSZFJxY8stCpFY4VMXCSgEi
         fgRQ==
X-Gm-Message-State: AOJu0Yxuxl+HAcDUhht9DvGjNZCeh7xULz/J3utbv5bkYkHSzw2BNG0s
	Li8O+K54XTFwbP8G19cBx0h+6HrKsoCUDnWvJsNNuCfRu4/nIH1GDoPlWesJNeU=
X-Google-Smtp-Source: AGHT+IHMibmon6GC8RhXdbPH+VCSiDqpbxOve0Jfm42SRhkBgjPc5TAzt5XMG/yPzCvRB6KBIBf38w==
X-Received: by 2002:a17:903:2307:b0:1fa:a89:fd1a with SMTP id d9443c01a7336-20203e4c4a3mr123368505ad.10.1724114937392;
        Mon, 19 Aug 2024 17:48:57 -0700 (PDT)
Received: from localhost.localdomain ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0300522sm67861455ad.6.2024.08.19.17.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 17:48:57 -0700 (PDT)
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
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 1/3] bonding: add common function to check ipsec device
Date: Tue, 20 Aug 2024 08:48:38 +0800
Message-ID: <20240820004840.510412-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240820004840.510412-1-liuhangbin@gmail.com>
References: <20240820004840.510412-1-liuhangbin@gmail.com>
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
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 48 ++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f9633a6f8571..560e3416f6f5 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -418,6 +418,39 @@ static int bond_vlan_rx_kill_vid(struct net_device *bond_dev,
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
+		slave_warn(bond_dev, slave->dev,
+			   "not same with IPsec offload real dev %s\n",
+			   xs->xso.real_dev->name);
+
+	return slave->dev;
+}
+
 /**
  * bond_ipsec_add_sa - program device with a security association
  * @xs: pointer to transformer state struct
@@ -595,23 +628,12 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
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


