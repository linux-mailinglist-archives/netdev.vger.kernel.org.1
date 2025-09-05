Return-Path: <netdev+bounces-220286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5394CB452ED
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 11:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9F01CC1C0A
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 09:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D32288C89;
	Fri,  5 Sep 2025 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFxEeXpU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA3528853A
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063765; cv=none; b=RxsBmO1wKH11qKRp7lygZPnTNQo+EnI/UMaEf7xs2O17Yn20iR3W7jDyefqk4bKObEYdz0Ye24xVhI2v/yF1NS1qBh7l69GDQIDxLkvsjq53/dH8mXMm1j8M13rfWRVnI3v2R4lC1FjvbN0zrizSq/cvROp6V0fez38XxCAxgMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063765; c=relaxed/simple;
	bh=DqTHnQsp/mwcHMBNvJrC4uo6gorfWQw13RfxNR8G8ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiPZriH1zqnN8LyLiM3GaShb+FDHx7Vtx8gWM3r/P91wqlLEIOZgGE4EwBgq4hsYn7dwvuDhG2HQc4uGD9/h7avARGy2N87ISpKkrPz42+Q8qdZiwxk2SxBo5hgJxq3EcQuP4HgrhuvQ1Gm1HwQA75EKQHMTFIGPT2f5o8+UWRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFxEeXpU; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7724df82cabso2284913b3a.2
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 02:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757063763; x=1757668563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xE/f4QURRS1AqvBo2D8CIR2ffwmt5kSq0TuafWtYDk=;
        b=hFxEeXpU3U/tqTUiyLMhtrrjAeKz6wYuD+GH+BhAvH1dViov0BAN0WJB3CJ36sb+un
         sNPJ3Q/yoLtXn4R4faN0xHjL1Gwm/0rje2edR/eZla/HFNp30CPHq6YJBq+RwvJpIRIx
         UtEt0Xgv4RHJApJPsVSqnUFoRuiufDwDg5PWlg35BkGJMG3Y13XPel2SG5vVjllCQCSG
         9ktKZoK2plx/cjYC8VFG5SMh2Q5Xa+BvoG+k9p9X1btcmanNX6MO5oUH9leacVz7t/hW
         hWOhJv/ZP0I33WqFdStxlCxlr/8829r7vKdZSH4D6TOxfKR+cFPwXuI6LcALNkNFPklX
         WOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063763; x=1757668563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xE/f4QURRS1AqvBo2D8CIR2ffwmt5kSq0TuafWtYDk=;
        b=gbucAHAlbuwLQcTHD/+ETsHqQ7E4++GA9HPmr8MZWGJcl0qnLZ7RKUTzx6Tl1EXQi+
         GfqwRx9egBDHqvyjdP21QreQAEtgMlU8cyypzdrqlXCeS9qenjy79AT2AtggEBrfQGqe
         g9c8eWlqtX9Tvc/lKnjHhFIKdAUGi4Z9aaFIR+CEGIrXFG7udXBnvarSwprMtszxODUy
         1sadJXuhbtBj3lrQ/gpzPggfsm31DeWonmYrS4Xlz+GdRge2p2qvPU46MQF+EHpsBtB5
         f5k4q6ZC/L4jAIru2AdwvCZTCErIuutS96IKo4Fwbdrf8HBoDu01aU/NFVE5b7beRyJx
         Ixig==
X-Gm-Message-State: AOJu0YzVbiLgUCfgARYV8DcsEZGwAfwE8DqdM9PUE2dmBJ6njO/g7Sm9
	CM9mtEr9ywnrRwjZmcxr2aPDO/07F4pyr3JdwwtvNVDy87JgFLClTfHYu8/cm23hXog=
X-Gm-Gg: ASbGncuV7FLMiblOFhtFM+cDJFpSxwVQgaZ1sPIQUI/Ehdacddh7WkUP/yOUyc3Y2jh
	zk6eHNhjDx8EPH3F9Zl4z7wbRvZKJl1RrOwv854AIi5mDGd765srcMY312VloRuuUxJ+ICY3QoK
	xnseSy1CTOXPooKXHT2mtmxRtAYAOZG2iaN15069SnwKpSrZZR71kgQpvJJ3NlwWp+dKGha7D4x
	l+7uY49stvYhb+9Jb3dEQOD3xcf9uJBfqNNeKzN2BV2QuaInf2Mgn0HYTEaYOqpAkv3AiQttGwv
	7HZlAgN/v0vXot7ZfnzQmP7fvHgINJ8dkbtrWOUDFsOkJ1T94FW+gGu8fmHG4zD4YrsXQ583G+d
	w8eRFIF0LqsrSL5s2fCQElmVAYeYTatM7Ot644W4uwA==
X-Google-Smtp-Source: AGHT+IHM+k/Pq9tv+R1ivmPmueHYkY5pjF9yNe8WCur5AlRlna9DgaXN9uvrvPrV3OR9tXMUp4JpBg==
X-Received: by 2002:a05:6a00:190e:b0:771:ef50:34d with SMTP id d2e1a72fcca58-7723e36284bmr24445501b3a.16.1757063762766;
        Fri, 05 Sep 2025 02:16:02 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a71c60bsm21078281b3a.103.2025.09.05.02.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:16:02 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
	Fernando Fernandez Mancera <ffmancera@riseup.net>,
	Murali Karicheri <m-karicheri2@ti.com>,
	WingMan Kwok <w-kwok2@ti.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 3/3] hsr: hold rcu and dev lock for hsr_get_port_ndev
Date: Fri,  5 Sep 2025 09:15:33 +0000
Message-ID: <20250905091533.377443-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905091533.377443-1-liuhangbin@gmail.com>
References: <20250905091533.377443-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hsr_get_port_ndev calls hsr_for_each_port, which need to hold rcu lock.
On the other hand, before return the port device, we need to hold the
device reference to avoid UaF in the caller function.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Fixes: 9c10dd8eed74 ("net: hsr: Create and export hsr_get_port_ndev()")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 20 ++++++++++++++------
 net/hsr/hsr_device.c                         |  7 ++++++-
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index dadce6009791..e42d0fdefee1 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -654,7 +654,7 @@ static void icssg_prueth_hsr_fdb_add_del(struct prueth_emac *emac,
 
 static int icssg_prueth_hsr_add_mcast(struct net_device *ndev, const u8 *addr)
 {
-	struct net_device *real_dev;
+	struct net_device *real_dev, *port_dev;
 	struct prueth_emac *emac;
 	u8 vlan_id, i;
 
@@ -663,11 +663,15 @@ static int icssg_prueth_hsr_add_mcast(struct net_device *ndev, const u8 *addr)
 
 	if (is_hsr_master(real_dev)) {
 		for (i = HSR_PT_SLAVE_A; i < HSR_PT_INTERLINK; i++) {
-			emac = netdev_priv(hsr_get_port_ndev(real_dev, i));
-			if (!emac)
+			port_dev = hsr_get_port_ndev(real_dev, i);
+			emac = netdev_priv(port_dev);
+			if (!emac) {
+				dev_put(port_dev);
 				return -EINVAL;
+			}
 			icssg_prueth_hsr_fdb_add_del(emac, addr, vlan_id,
 						     true);
+			dev_put(port_dev);
 		}
 	} else {
 		emac = netdev_priv(real_dev);
@@ -679,7 +683,7 @@ static int icssg_prueth_hsr_add_mcast(struct net_device *ndev, const u8 *addr)
 
 static int icssg_prueth_hsr_del_mcast(struct net_device *ndev, const u8 *addr)
 {
-	struct net_device *real_dev;
+	struct net_device *real_dev, *port_dev;
 	struct prueth_emac *emac;
 	u8 vlan_id, i;
 
@@ -688,11 +692,15 @@ static int icssg_prueth_hsr_del_mcast(struct net_device *ndev, const u8 *addr)
 
 	if (is_hsr_master(real_dev)) {
 		for (i = HSR_PT_SLAVE_A; i < HSR_PT_INTERLINK; i++) {
-			emac = netdev_priv(hsr_get_port_ndev(real_dev, i));
-			if (!emac)
+			port_dev = hsr_get_port_ndev(real_dev, i);
+			emac = netdev_priv(port_dev);
+			if (!emac) {
+				dev_put(port_dev);
 				return -EINVAL;
+			}
 			icssg_prueth_hsr_fdb_add_del(emac, addr, vlan_id,
 						     false);
+			dev_put(port_dev);
 		}
 	} else {
 		emac = netdev_priv(real_dev);
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 702da1f9aaa9..fbbc3ccf9df6 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -675,9 +675,14 @@ struct net_device *hsr_get_port_ndev(struct net_device *ndev,
 	struct hsr_priv *hsr = netdev_priv(ndev);
 	struct hsr_port *port;
 
+	rcu_read_lock();
 	hsr_for_each_port(hsr, port)
-		if (port->type == pt)
+		if (port->type == pt) {
+			dev_hold(port->dev);
+			rcu_read_unlock();
 			return port->dev;
+		}
+	rcu_read_unlock();
 	return NULL;
 }
 EXPORT_SYMBOL(hsr_get_port_ndev);
-- 
2.50.1


