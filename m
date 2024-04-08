Return-Path: <netdev+bounces-85890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC10B89CC2C
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 21:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2705F1F246B0
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 19:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1052145B17;
	Mon,  8 Apr 2024 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RzlRs4Ca"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6AC14535A
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712603086; cv=none; b=jL8kP2pBdiOEeQK4SvkAd/tt16b+iJ97WSEgDeGaDQW1H/+iQlwlFsjN4T3f3XgEKXiN4Jq/yLGlv7jw+6vCk8NCFInD5G/GAv5SBAu+rwCOuTxEblVZg8c7OSNjP27+Ewu7/cqH3Eloe4plr/jN2uxz/1eZKtsYU9k4/jNjUJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712603086; c=relaxed/simple;
	bh=qbOui7asl3gajjDWUWGn/0raYrWjYh8fvjtr7oXZ3v4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B4lVjGSO/TYPwCN0CV610hCLoHYZVKMHu8hLAohMLX1i7p/vb5AgV/m1Jc9I0TywC0eIAZht8KGpiWZnuT4Udjs8k8nE0sVf9UxreYDs2mgtkQvNCA48HCss0sCV3eRmch2NcqpHtGxYRwqvkIEiNlEAU+mF2WwTq253HW6fICE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RzlRs4Ca; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6150e36ca0dso70259077b3.1
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 12:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712603084; x=1713207884; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9YFwpua1V9N06H0cwOIhR311m3BvdWhu1fWCYs6M3do=;
        b=RzlRs4CaA/OAHHCCKwP0IxB2nRgqj/KHqkESkiYaMM7uDXV9m4SfpFOc9iMDPxcXRo
         mx2a8XqGnjDxi/dM/JqvWml0nzlTLelRjAuxZoR5E9IvckQkqBT8ruJf63LH0gxKRYc4
         un/PPEEj60+h3+IoX1Uqm31Ym9BAQ+8iGbvkuxu4tXhmLMEJE0QSUcz8gMDkV2T+7Fgw
         W+ctJ6GYalKmwA80umnQ91T3i1afAATQ1M2QMRmLgWa3DMjU4EBCweAcEDaD8rgy21JA
         0AkkwX2Rxq/ZWk1mVNYvLXsTzQgKlrIoecsLuevj+szzxR/FmbYixi+jZAedlUzJbWMT
         0OPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712603084; x=1713207884;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YFwpua1V9N06H0cwOIhR311m3BvdWhu1fWCYs6M3do=;
        b=IJFaaXu3IcjVd2Acjx0s2VNskRmgOqwLhYphvNXGIqzc/Kf5yWMm+pDgQVyFlHkF5r
         5aUS93maTOLfGflE6KjDXYw92L5PeVI6XM6v2iMIsSCkoQ8ETYNi6v3Mmd6ng8SNdDHU
         ES+EnnqtSpAGQA0dAYbuyzwUQTPyTsr2muE348Lq0fVf/mG1IP2rRL0SSyUuFEaSBiUP
         UF3KIRR9XcdYFVPQ0oZzm0u3tcn0R+3wkZ3xhsPKursHUW1a+vhQSzh73R/A++ccEmgi
         +FemAvZDYflCtcS5dC84iJ4ixdPtEigB1eOQVrNNnLrGgh46u4LoYgypoDQe82WZJGF7
         B3cw==
X-Forwarded-Encrypted: i=1; AJvYcCUs4Q7Jst8h48CNBEgp680MiZke6NXdRrF5aBnVpW/LTTTifkF3TqOTJCkPw8Zc6Pa/V204IGEdBbVjApwSSG1bWBNm/dT4
X-Gm-Message-State: AOJu0Yx/o7vB3eYiGCevQ+4ynQLdRImRmUnp5jVIWho6RAhdUMWnTkfP
	9Eg5HJoskluWKw2q4PvMRkgNetxfsU7TaYUj/KQbDpRlWyu2Rq8VUgwIOC8ehKhW0v5sRMEC+Wu
	cdy9AhWjOpQ==
X-Google-Smtp-Source: AGHT+IFOajzXu4ciC9lRgMO2q3G1iQc3DZBnLs5jw5/F0RryqTfOBy8e0mNMbm/LLnHOWlx821hE7xLCRACCGQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1083:b0:dc6:b982:cfa2 with SMTP
 id v3-20020a056902108300b00dc6b982cfa2mr758626ybu.8.1712603084180; Mon, 08
 Apr 2024 12:04:44 -0700 (PDT)
Date: Mon,  8 Apr 2024 19:04:37 +0000
In-Reply-To: <20240408190437.2214473-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240408190437.2214473-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408190437.2214473-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] bonding: no longer use RTNL in bonding_show_queue_id()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Annotate lockless reads of slave->queue_id.

Annotate writes of slave->queue_id.

Switch bonding_show_queue_id() to rcu_read_lock()
and bond_for_each_slave_rcu().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/bonding/bond_main.c        |  2 +-
 drivers/net/bonding/bond_netlink.c     |  3 ++-
 drivers/net/bonding/bond_options.c     |  2 +-
 drivers/net/bonding/bond_procfs.c      |  2 +-
 drivers/net/bonding/bond_sysfs.c       | 10 +++++-----
 drivers/net/bonding/bond_sysfs_slave.c |  2 +-
 6 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 08e9bdbf450afdc103931249259c58a08665dc02..b3a7d60c3a5ca60be1d9eed184ec1dad593a182b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5245,7 +5245,7 @@ static inline int bond_slave_override(struct bonding *bond,
 
 	/* Find out if any slaves have the same mapping as this skb. */
 	bond_for_each_slave_rcu(bond, slave, iter) {
-		if (slave->queue_id == skb_get_queue_mapping(skb)) {
+		if (READ_ONCE(slave->queue_id) == skb_get_queue_mapping(skb)) {
 			if (bond_slave_is_up(slave) &&
 			    slave->link == BOND_LINK_UP) {
 				bond_dev_queue_xmit(bond, skb, slave->dev);
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 29b4c3d1b9b6ff873fe067e80bedf7cb681d18f1..2a6a424806aa603ad8a00ca797e9e22d38bd0435 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -51,7 +51,8 @@ static int bond_fill_slave_info(struct sk_buff *skb,
 		    slave_dev->addr_len, slave->perm_hwaddr))
 		goto nla_put_failure;
 
-	if (nla_put_u16(skb, IFLA_BOND_SLAVE_QUEUE_ID, slave->queue_id))
+	if (nla_put_u16(skb, IFLA_BOND_SLAVE_QUEUE_ID,
+			READ_ONCE(slave->queue_id)))
 		goto nla_put_failure;
 
 	if (nla_put_s32(skb, IFLA_BOND_SLAVE_PRIO, slave->prio))
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 4cdbc7e084f4b4cb3b150656aa765531806d8ad9..0cacd7027e352dbf3204d82b7ce1672469a186de 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1589,7 +1589,7 @@ static int bond_option_queue_id_set(struct bonding *bond,
 		goto err_no_cmd;
 
 	/* Actually set the qids for the slave */
-	update_slave->queue_id = qid;
+	WRITE_ONCE(update_slave->queue_id, qid);
 
 out:
 	return ret;
diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
index 43be458422b3f9448d96383b0fb140837562f446..7edf72ec816abd8b66917bdecd2c93d237629ffa 100644
--- a/drivers/net/bonding/bond_procfs.c
+++ b/drivers/net/bonding/bond_procfs.c
@@ -209,7 +209,7 @@ static void bond_info_show_slave(struct seq_file *seq,
 
 	seq_printf(seq, "Permanent HW addr: %*phC\n",
 		   slave->dev->addr_len, slave->perm_hwaddr);
-	seq_printf(seq, "Slave queue ID: %d\n", slave->queue_id);
+	seq_printf(seq, "Slave queue ID: %d\n", READ_ONCE(slave->queue_id));
 
 	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
 		const struct port *port = &SLAVE_AD_INFO(slave)->port;
diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
index 75ee7ca369034ef6fa58fc9399b566dd7044fedc..1e13bb17051567e2b5d9451ceef47f2cf1a588ec 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -625,10 +625,9 @@ static ssize_t bonding_show_queue_id(struct device *d,
 	struct slave *slave;
 	int res = 0;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	rcu_read_lock();
 
-	bond_for_each_slave(bond, slave, iter) {
+	bond_for_each_slave_rcu(bond, slave, iter) {
 		if (res > (PAGE_SIZE - IFNAMSIZ - 6)) {
 			/* not enough space for another interface_name:queue_id pair */
 			if ((PAGE_SIZE - res) > 10)
@@ -637,12 +636,13 @@ static ssize_t bonding_show_queue_id(struct device *d,
 			break;
 		}
 		res += sysfs_emit_at(buf, res, "%s:%d ",
-				     slave->dev->name, slave->queue_id);
+				     slave->dev->name,
+				     READ_ONCE(slave->queue_id));
 	}
 	if (res)
 		buf[res-1] = '\n'; /* eat the leftover space */
 
-	rtnl_unlock();
+	rcu_read_unlock();
 
 	return res;
 }
diff --git a/drivers/net/bonding/bond_sysfs_slave.c b/drivers/net/bonding/bond_sysfs_slave.c
index 313866f2c0e49ac96299ffea307b1613955713ec..36d0e8440b5b94464b3226ce1a04f32361de5aa6 100644
--- a/drivers/net/bonding/bond_sysfs_slave.c
+++ b/drivers/net/bonding/bond_sysfs_slave.c
@@ -53,7 +53,7 @@ static SLAVE_ATTR_RO(perm_hwaddr);
 
 static ssize_t queue_id_show(struct slave *slave, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", slave->queue_id);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(slave->queue_id));
 }
 static SLAVE_ATTR_RO(queue_id);
 
-- 
2.44.0.478.gd926399ef9-goog


