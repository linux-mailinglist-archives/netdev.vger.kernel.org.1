Return-Path: <netdev+bounces-85888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C4A89CC2A
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 21:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0331C22120
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 19:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CFF145326;
	Mon,  8 Apr 2024 19:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ugaytZo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED241420D8
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 19:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712603083; cv=none; b=Xd0KUQGOYcnlqvEn3aOAl2FrEDvBBR7JCeA6Kx2FCQNM2H3MpdnU8XHh/ddMlHi2dtX/rpXarXEsB3mAYlK0I2HVV4sprujlvkmyTjFrQo/qwbSfBIVYOCmu5jVp0yiRMkLUSNCCjAKRRYVVhFLVV4b7WRzKfYO8eQpEnl1aefY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712603083; c=relaxed/simple;
	bh=bUJeVELf/0h7eqzXkRcJF5AAYU2ToZalQ8Ai+iW8LJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qi5gbV4QcJIeAuz/jbZq+xPZ/N0BAvNPDe7/L72GibtfCPd1r+5VM6eq2idkn1mI1E0OGbTwGe3vJBN7iXeA+CHydntfmIZXeQ0FBjuLHYSfDGVvwTaGC+yTq9FD1JOurU7qZB82bAco/EURWjEsBF2Jg/tabwjJLdVJbDujfGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ugaytZo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61510f72bb3so81721077b3.0
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 12:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712603081; x=1713207881; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SCOobaFxiB8VywykUvfRGdsWgiL4TXNUBVDqreGXQy0=;
        b=4ugaytZo3Nhfar8d8IdqjJEho4oMgii5fuwVlS9b6Q3yH64EilRS19NRdFfAOS+n2b
         28y5thFP2O/+tnl7C7GuAUDHSEZtr+m+xbJAxql81hy6GxPTLJfOXkWqL2JcVRPeyeRN
         l4ju6zvj8imxunAlFGBcpmo//xAnRE/z5FGx1l2cOASAB4OaGGtHE+XwbFaO7CKWsjK6
         Tr3OUh7917Sx9ANyRM4K50UfptQh79+Gi0QOPTnCgAn21f2rs2t4h0HYgQooqoDVcbIP
         jrvGftEZp7JxEsIYEWyAiXmFMIGUV5mTgQg9GY6YcIVt4oOxIkqKf4uFnbqDsztuNJkY
         YI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712603081; x=1713207881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SCOobaFxiB8VywykUvfRGdsWgiL4TXNUBVDqreGXQy0=;
        b=lL1fcpTn6MtIVyR5XfHBW0qBrY90G8oQfofpwS5L1X3VXzUrySlRjmPeqaWBWcW6kr
         yWPOYfmnfB6bLlImKDXGD6M4auDOUlxvajKsWzIDit429aMxgjJNtrtkgFGjBvCZ/zsE
         b28MYjrwRnjidx9+ZjEfGn1QlpZ3sqOzdnl/RjWhzLt8vnyHVjHUWKFqNPjjL/tSrL9n
         Pn5Z7SgYsRyJAvDrr+c2jNGu/zv1QftseT6G6gVMYdRo9S2uOlVLIPbejm28w6O7DpdY
         2kZ6+PPShoMFQh/rFJSYwGz0bfK+rmIrQyyo1c+iMpU+rsYpMoGJlMvKHPtfmukd3LB0
         IpNA==
X-Forwarded-Encrypted: i=1; AJvYcCUjYQ1Pmb4MhQwBzQmCDa6Q4BGSkiKy8kxJwABZOIMShy0hsX3VUSoHGLHkG92St4X83eUNhGTVsc7qhQ6nGIDXrWQqcLZR
X-Gm-Message-State: AOJu0YyIs0dQ8mGEGBeHzv7neGBJ7qEjF2LuQ59GNl6BE5MTReSjJ7hG
	uGugM0jY0OKoL2rNVb5xV5gSREmej/OHOeRe6jlJ8JCDmtkeuowXAGzKcVyCIyq3s4MtoFcJBTH
	c7xLSphHPgw==
X-Google-Smtp-Source: AGHT+IE7sqnv0RPb9psfPSVRWnf26rpSGKrAF00DmsN+zsJDLfOoZnIxCtr0Iptx99yQQHcHYLkQoLdShfppQQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:7156:0:b0:617:f232:85c with SMTP id
 m83-20020a817156000000b00617f232085cmr1682420ywc.6.1712603081055; Mon, 08 Apr
 2024 12:04:41 -0700 (PDT)
Date: Mon,  8 Apr 2024 19:04:35 +0000
In-Reply-To: <20240408190437.2214473-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240408190437.2214473-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408190437.2214473-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] bonding: no longer use RTNL in bonding_show_bonds()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

netdev structures are already RCU protected.

Change bond_init() and bond_uninit() to use RCU
enabled list_add_tail_rcu() and list_del_rcu().

Then bonding_show_bonds() can use rcu_read_lock()
while iterating through bn->dev_list.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/bonding/bond_main.c  | 4 ++--
 drivers/net/bonding/bond_sysfs.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index c9f0415f780ab0a9ecb26424795695eff951421a..08e9bdbf450afdc103931249259c58a08665dc02 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5933,7 +5933,7 @@ static void bond_uninit(struct net_device *bond_dev)
 
 	bond_set_slave_arr(bond, NULL, NULL);
 
-	list_del(&bond->bond_list);
+	list_del_rcu(&bond->bond_list);
 
 	bond_debug_unregister(bond);
 }
@@ -6347,7 +6347,7 @@ static int bond_init(struct net_device *bond_dev)
 	spin_lock_init(&bond->stats_lock);
 	netdev_lockdep_set_classes(bond_dev);
 
-	list_add_tail(&bond->bond_list, &bn->dev_list);
+	list_add_tail_rcu(&bond->bond_list, &bn->dev_list);
 
 	bond_prepare_sysfs_group(bond);
 
diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
index 2805135a7205ba444ccaf412df33f621f55a729a..9132033f85fb0e33093e97c55f885a997c95cb4a 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -37,12 +37,12 @@ static ssize_t bonding_show_bonds(const struct class *cls,
 {
 	const struct bond_net *bn =
 		container_of_const(attr, struct bond_net, class_attr_bonding_masters);
-	int res = 0;
 	struct bonding *bond;
+	int res = 0;
 
-	rtnl_lock();
+	rcu_read_lock();
 
-	list_for_each_entry(bond, &bn->dev_list, bond_list) {
+	list_for_each_entry_rcu(bond, &bn->dev_list, bond_list) {
 		if (res > (PAGE_SIZE - IFNAMSIZ)) {
 			/* not enough space for another interface name */
 			if ((PAGE_SIZE - res) > 10)
@@ -55,7 +55,7 @@ static ssize_t bonding_show_bonds(const struct class *cls,
 	if (res)
 		buf[res-1] = '\n'; /* eat the leftover space */
 
-	rtnl_unlock();
+	rcu_read_unlock();
 	return res;
 }
 
-- 
2.44.0.478.gd926399ef9-goog


