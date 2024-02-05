Return-Path: <netdev+bounces-69122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A200E849B02
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59531C2216D
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A9E2D054;
	Mon,  5 Feb 2024 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4vqYVtPK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27B72CCDF
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137288; cv=none; b=cpaDSWdervTo5OPP2Uzm7wj2E5vD74yZ9o5IipzAxMhz9wGA+MrC9Yme3eOjZhqU1JUNjejxEO2+jBi9/H+YYKWoxwR10R/wjSRgJQ5abm+5n0wLuF7SfeaS0AIY9ru1160D1TTkDmC9IuE1Fs4y4CTmc4fb1MrIGoIyJUgX1CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137288; c=relaxed/simple;
	bh=4dKksu2wPSOz+KuIfaNY66xb7JDGSdvhNqfmAeN2KZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VdKqj0xhxpBp0CBwlL6NlrDkCpsFON/bbvW5bsnfacS+PvccsLIhY+30U0/Byt7edfTHtXohm2/PQOYenuq7LYahPyiLTvVtA9rTwJVRdsWQVTqhorcqWyZuhuJk3CH1RWXODwtdltW9OGXhSIHvoBEe585u91n+k9MSSyC3ZzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4vqYVtPK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ee22efe5eeso67503457b3.3
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 04:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707137285; x=1707742085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0yJd5KU09GLllTvfyorLCQ5BW6lssMZj8h0K+orrVbg=;
        b=4vqYVtPK5ehl4rB4YC7hLUdts2Ap71dg3MFaYaKVNpm1j8poGSE1n5GQ5GESfRWGlP
         oSWPZqdkpDX2zzRy46mswCUvFjERn8oEEGvmC/yQgxUBk5iNYmJzm4KEEhtn8RjoL4KV
         EaRzdqglT910x8WnA6c5tvh5i9oAHcLbEF8OFGM22jCJWlQ0C+Gua25ouTqv6f+zD3ws
         pWQTCUongfeQFDKVcCB43aAApCRczGycrjwNzdSAlTer1TSwN5kLo++YxSsMinFnpHeU
         7ggSS2Ok+OfGX/YIFn5BGL2gDqny6CtUmNF4LVWabJQ+xftuLZwPEwUVBi8hKOS63BkJ
         FBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137285; x=1707742085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0yJd5KU09GLllTvfyorLCQ5BW6lssMZj8h0K+orrVbg=;
        b=Gar2EFFoPFGEwU76d7fa1kkLL7mqddklzLYqfx/M4wxzZbvtkt3fOkiwWW2w/HvPv+
         0AL5M3NZCpqGR21FUs+rP7AuUSN9W5e2rnyMjy9wYcMpm7cGnxsiwkrF+DY9Z9w3pFSL
         YWAnr+4b+QobJa9T6pC4ojSxV94Ld6VelQtsJumZb+qKJwwUWAsMJrjZEIu2+zxjeZsT
         l5mqF6Sc4VMWFJpxDuBUff86ihXffde+IEfHsZBeuGbSaYY6q3T7cX2W/QOmjSiRkrW8
         aAVoH0FKtNdpd0+LbtObjHpTORwt2Atnaa0yvt06Y1j+LUVXrBcXO1vayactjeVPeMQy
         lUHw==
X-Gm-Message-State: AOJu0YzmYROz0woFfBe6dKGcXgKS/46K2f8ke5+H25SWiLcihtnR8bxZ
	os5Ex5UHOXNzZkTirctJ3XqXui5gRVSx6zpaky/ewbD/LSI2WV7LAXx4FSaPxzO0Qlj6MkBZpZ+
	iKn9WPhJDGw==
X-Google-Smtp-Source: AGHT+IFAfqosCrctlL1z7fKIfsHGNFcWyu0tt/yVhI0zVyntsr/c/AA757yAQtz6YR81yoB5j0RNe1For0grNQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2612:b0:dbe:30cd:8fcb with SMTP
 id dw18-20020a056902261200b00dbe30cd8fcbmr435613ybb.0.1707137285719; Mon, 05
 Feb 2024 04:48:05 -0800 (PST)
Date: Mon,  5 Feb 2024 12:47:41 +0000
In-Reply-To: <20240205124752.811108-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205124752.811108-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205124752.811108-5-edumazet@google.com>
Subject: [PATCH v3 net-next 04/15] bonding: use exit_batch_rtnl() method
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
index 4e0600c7b050f21c82a8862e224bb055e95d5039..a5e3d000ebd85c09beba379a2e6a7f69a0fd4c88 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -6415,28 +6415,41 @@ static int __net_init bond_net_init(struct net *net)
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
@@ -6446,6 +6459,8 @@ static void __net_exit bond_net_exit_batch(struct list_head *net_list)
 
 static struct pernet_operations bond_net_ops = {
 	.init = bond_net_init,
+	.pre_exit = bond_net_pre_exit,
+	.exit_batch_rtnl = bond_net_exit_batch_rtnl,
 	.exit_batch = bond_net_exit_batch,
 	.id   = &bond_net_id,
 	.size = sizeof(struct bond_net),
-- 
2.43.0.594.gd9cf4e227d-goog


