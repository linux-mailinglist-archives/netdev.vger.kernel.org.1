Return-Path: <netdev+bounces-69511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A3E84B82B
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0FA1F22A62
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385CE133286;
	Tue,  6 Feb 2024 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qavyAEZ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A3D132C3D
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230608; cv=none; b=CksrVTYFKZ7cHvMlXevwVvBhO2sqSAyjSyuDAv8KhYZ+Nicns2ShXAhYmwP8Cd8aJha3y7cLglXxuQUSOV5NLVwQeReYJtucVB6C4CyQIJh91Nr4lkZiAAko7lWh69oisUkTtIPzQtwpO5OGiyuugJOk4ehTU5CV8tPLe2s8OFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230608; c=relaxed/simple;
	bh=3inax9oQr+uY3Pakj/T8bqd1YyGzeya+JqIQMhjNHGs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gf/toaZcO0c43jbrKPRzr+zmFNjOHxD6QKmsNa1TJpwL4DhDfBdxQOhgQ6sVA/g8z4fCn3vgD2wbNLfYxTYmV0FG4nfkc5tESyCjr3/TAYUT2QBC3V9PsY3YNdBFdEDoYIGFHt/FN27ljpyDPwLmLtLNYMDZyA3R88oAc+/5Uj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qavyAEZ+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6040ffa60ddso114200447b3.2
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707230605; x=1707835405; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pg//Oaguf3NBkI6AznnoOrXcgWPfLj7QsWct95JQ/AA=;
        b=qavyAEZ+jsaUjewpeWqOudc/+D151ACtXCmWnfUHrXuIlEd0Mf++dvUSKSchk9G9P4
         l5n0dGSgOVXCdRfK4q/fOU1puZqAFd99an3YRtMzuRu9OiJwsw0LDgDkXBRD9A/YlSD3
         1wHolC+L03tEs4b+1DlH6nnsMlft0ArgEgZJRT2TE2fWiLLCduRELAuwlBBDKduUrvLc
         cJ+3xH5O4kxM6xnL4F5VC/mN2yNNSSKZAThD2f78QiwkG4dB2HABAvlSOpudl4BTpaLa
         hhspUm+6OqW5IZrt5iu+YLhrGQ7qIs1o69VoTj8QnVdTy4u8kRnYZ0VdaWAQ/hY+Ik7z
         3bOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230605; x=1707835405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pg//Oaguf3NBkI6AznnoOrXcgWPfLj7QsWct95JQ/AA=;
        b=wbWqsKX3cwATxDFGB3q+XgseaaGJQcSq/c4Ycr7g2Z2WeVHvVV18BNV6ywM+3Qgscg
         CJKejk7W/Nqu6zi4uAYWdtdNyl03FnoNJcpWQOQEFmOR+uYspgT2dFANogtceM8bsBsf
         34ew4vJepxi67l4WGiC8HG/A4VSpV+fkjc2LCGIaYMEIRSOEmmsilbZ25yuYjltMTqtb
         J4kwgmhOEDcjLlLVPjn1M0i37d4RpZhkEFWJIvx2n3odCQ4+p02F2Q9/tAqRXIvWbSwl
         mvDRzQtC4xiKCYGxzGZ28qyM2tbdyy5kpsE3IJ48hvuykg04t4ykptGsPuqmhmbxz95v
         SyxA==
X-Gm-Message-State: AOJu0YweNPMd98Q4D7SPGtcvQd1RVwcZVkWVtOWlblt9ScfFl40Cva/v
	4sjuF9/L5MjDJpIHVJrbEFAwDF3KY7x1V48nNo5U9US+jnwwLkxB2OywGDvIr9dN5jSO6uvNcfn
	L2SE9NbFohQ==
X-Google-Smtp-Source: AGHT+IFoKtQbzT5S7talrSxlifCJFDZlHHinD4pBf/Y/Bbln5v9qi4TrPAKvuv+Kq5RD9hOrXb+rQ5zK8yQHKQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:110:b0:604:2252:7827 with SMTP
 id bd16-20020a05690c011000b0060422527827mr385664ywb.10.1707230605573; Tue, 06
 Feb 2024 06:43:25 -0800 (PST)
Date: Tue,  6 Feb 2024 14:43:01 +0000
In-Reply-To: <20240206144313.2050392-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206144313.2050392-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206144313.2050392-6-edumazet@google.com>
Subject: [PATCH v4 net-next 04/15] bonding: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jay Vosburgh <j.vosburgh@gmail.com>, 
	Andy Gospodarek <andy@greyhouse.net>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair,
and one unregister_netdevice_many() call.

v2: Added bond_net_pre_exit() method to make sure bond_destroy_sysfs()
    is called before we unregister the devices in bond_net_exit_batch_rtnl
 (Antoine Tenart : https://lore.kernel.org/netdev/170688415193.5216.10499830272732622816@kwain/)

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Antoine Tenart <atenart@kernel.org>
Acked-by: Jay Vosburgh <j.vosburgh@gmail.com>
Cc: Andy Gospodarek <andy@greyhouse.net>
---
 drivers/net/bonding/bond_main.c | 37 +++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index ae9d32c0faf40ca32884f3c7e69b320e1e02c8d0..cb67ece47328cc50c6158cc0408d1820ef8c6dd4 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -6416,28 +6416,41 @@ static int __net_init bond_net_init(struct net *net)
 	return 0;
 }
 
-static void __net_exit bond_net_exit_batch(struct list_head *net_list)
+/* According to commit 69b0216ac255 ("bonding: fix bonding_masters
+ * race condition in bond unloading") we need to remove sysfs files
+ * before we remove our devices (done later in bond_net_exit_batch_rtnl())
+ */
+static void __net_exit bond_net_pre_exit(struct net *net)
+{
+	struct bond_net *bn = net_generic(net, bond_net_id);
+
+	bond_destroy_sysfs(bn);
+}
+
+static void __net_exit bond_net_exit_batch_rtnl(struct list_head *net_list,
+						struct list_head *dev_kill_list)
 {
 	struct bond_net *bn;
 	struct net *net;
-	LIST_HEAD(list);
-
-	list_for_each_entry(net, net_list, exit_list) {
-		bn = net_generic(net, bond_net_id);
-		bond_destroy_sysfs(bn);
-	}
 
 	/* Kill off any bonds created after unregistering bond rtnl ops */
-	rtnl_lock();
 	list_for_each_entry(net, net_list, exit_list) {
 		struct bonding *bond, *tmp_bond;
 
 		bn = net_generic(net, bond_net_id);
 		list_for_each_entry_safe(bond, tmp_bond, &bn->dev_list, bond_list)
-			unregister_netdevice_queue(bond->dev, &list);
+			unregister_netdevice_queue(bond->dev, dev_kill_list);
 	}
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+}
+
+/* According to commit 23fa5c2caae0 ("bonding: destroy proc directory
+ * only after all bonds are gone") bond_destroy_proc_dir() is called
+ * after bond_net_exit_batch_rtnl() has completed.
+ */
+static void __net_exit bond_net_exit_batch(struct list_head *net_list)
+{
+	struct bond_net *bn;
+	struct net *net;
 
 	list_for_each_entry(net, net_list, exit_list) {
 		bn = net_generic(net, bond_net_id);
@@ -6447,6 +6460,8 @@ static void __net_exit bond_net_exit_batch(struct list_head *net_list)
 
 static struct pernet_operations bond_net_ops = {
 	.init = bond_net_init,
+	.pre_exit = bond_net_pre_exit,
+	.exit_batch_rtnl = bond_net_exit_batch_rtnl,
 	.exit_batch = bond_net_exit_batch,
 	.id   = &bond_net_id,
 	.size = sizeof(struct bond_net),
-- 
2.43.0.594.gd9cf4e227d-goog


