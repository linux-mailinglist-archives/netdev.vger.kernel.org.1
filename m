Return-Path: <netdev+bounces-69850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5521B84CCB8
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3871F21C9D
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE5C7F7DE;
	Wed,  7 Feb 2024 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OSVraRkq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EB07F7C9
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316016; cv=none; b=KcIcMUvBqZSWrIQXLZWvKQTSqhj+ao+L9EDcvUyg8vaQqC8lyJg5+OAmy9JSA36g2Kq+s559aNixJk1yxes+/8dNASe7GBOW4mDvWxM9nw8delpnRewIgy49DrHtJymBeP/LgJwSF0AR07g8euW7XKKjnSEbBHs6IpTrmQLnlpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316016; c=relaxed/simple;
	bh=PaC/2Exh/2AVO8EbYMdpN5FHYC3083rcwQDOCdDH4YE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EJYCLxFtV40o1qfEBB4N1ZZwFwGwzt5vbAsTDqV192pSAYxyu2i3UGAUYPU7DeKmg5qJM+M8r1IY+RL+8ZaiUxjc9SVO4X+k8OPXguJFpuYrB7Mkcc/zAmgJ3n6O4hhcqvSS9wd1Q9/MI3KvBCNeiZpLsxyxCEEl5ZAQgL5h9Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OSVraRkq; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-603cbb4f06dso13188967b3.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 06:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707316014; x=1707920814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha5gRdfszRSqnfJs9PTltXZuav6SdjvG66pzNlueUvY=;
        b=OSVraRkqc5JFIsdnCsZy4GR99uHzNjEvRacxFpRNe/Tlx0VM0qmwrCjZzg2GrVMetV
         L85YtZICxEFpRARG7kHPtHTd0yoAbmalEPRYH5cCqAX+bTA24h4PuZ/w7Y0NhVkKhrgK
         DNFuL9pWDFBfQp1TUpkyhxq6HblTPhaMSILy0CnS8/GIGJ/b2wriiwZX5Cr2bHdY/Peg
         53DIDcPMhj/1U6IXCUuDSQrV1SQNrulq9GjJWZUEp21UZi2vh+MjLVNKLoG9mtQcyUFL
         dwNFTVi0JN05WwqtHNDhWXn+jAz++emKmdlXBZ28Mu2Fr3+k75IruBdsH5zvYB28tUBI
         mf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316014; x=1707920814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha5gRdfszRSqnfJs9PTltXZuav6SdjvG66pzNlueUvY=;
        b=sVtziaMIHq1OI+Uf2byKMGzeVVori6mDMNSpZSJd58VHrVuEcjJI/rILglEsZNUC6/
         TDzz0s6NzHJSZaQT9oHatHUD2C6q80yyIITF8dTfmmt7Q0VLrNUYhNpgsjhzaymjTuwU
         Dc2odF+/LBKQm3iGuZNVv6sYrJ1zTK0gV/i0R1ppjj48PzLbNK6Cz6EHwUPphyjkVChR
         Pe0z9Om6ApE+XGkO9tpRJuO5NhUNeWaAa2S80a1zZmHYUH3VlunsTh6EueoGQpFHxHoZ
         /vaNu16pABBREjBpa1rpRQgcFB5qT9c38qcDvPIPlBqxV3bVBrnoGh64fYRHuM6cI7Dp
         iW1A==
X-Gm-Message-State: AOJu0Yyohn0Dtt/7NbY29jhjQiVQ1J7L4PK/kidauZ9N6GhrEFDzzgUf
	Uvm8jB04AQ4ikE2F+htjKvlYEiFdsZRd2JCSIAwyxSKmjnpy2rCp8js1fZSffpWWGQEYmZDR2EY
	OP0aGuXWrHg==
X-Google-Smtp-Source: AGHT+IGtWfkSwgMV+j6qHo8g9gdYPYAFit+ou97JQek8g1o9HoLAtEdmyzu+DJe6AXj1HOrwcJSBlcSinJE3Tw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:13ce:b0:dc6:d8d9:7d7b with SMTP
 id y14-20020a05690213ce00b00dc6d8d97d7bmr1216283ybu.5.1707316014014; Wed, 07
 Feb 2024 06:26:54 -0800 (PST)
Date: Wed,  7 Feb 2024 14:26:28 +0000
In-Reply-To: <20240207142629.3456570-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207142629.3456570-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207142629.3456570-13-edumazet@google.com>
Subject: [PATCH net-next 12/13] net: remove dev_base_lock from
 register_netdevice() and friends.
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

RTNL already protects writes to dev->reg_state, we no longer need to hold
dev_base_lock to protect the readers.

unlist_netdevice() second argument can be removed.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 2b96d1ed7f481cbd022368b3f16608cce4c6bc49..9b6b530d94d01bcb6e8f70c6942fb39eccb52904 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -412,7 +412,7 @@ static void list_netdevice(struct net_device *dev)
 /* Device list removal
  * caller must respect a RCU grace period before freeing/reusing dev
  */
-static void unlist_netdevice(struct net_device *dev, bool lock)
+static void unlist_netdevice(struct net_device *dev)
 {
 	struct netdev_name_node *name_node;
 	struct net *net = dev_net(dev);
@@ -425,13 +425,11 @@ static void unlist_netdevice(struct net_device *dev, bool lock)
 		netdev_name_node_del(name_node);
 
 	/* Unlink dev from the device chain */
-	if (lock)
-		write_lock(&dev_base_lock);
+	write_lock(&dev_base_lock);
 	list_del_rcu(&dev->dev_list);
 	netdev_name_node_del(dev->name_node);
 	hlist_del_rcu(&dev->index_hlist);
-	if (lock)
-		write_unlock(&dev_base_lock);
+	write_unlock(&dev_base_lock);
 
 	dev_base_seq_inc(dev_net(dev));
 }
@@ -10267,9 +10265,9 @@ int register_netdevice(struct net_device *dev)
 		goto err_ifindex_release;
 
 	ret = netdev_register_kobject(dev);
-	write_lock(&dev_base_lock);
+
 	WRITE_ONCE(dev->reg_state, ret ? NETREG_UNREGISTERED : NETREG_REGISTERED);
-	write_unlock(&dev_base_lock);
+
 	if (ret)
 		goto err_uninit_notify;
 
@@ -10560,9 +10558,7 @@ void netdev_run_todo(void)
 			continue;
 		}
 
-		write_lock(&dev_base_lock);
 		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);
-		write_unlock(&dev_base_lock);
 		linkwatch_sync_dev(dev);
 	}
 
@@ -11069,10 +11065,8 @@ void unregister_netdevice_many_notify(struct list_head *head,
 
 	list_for_each_entry(dev, head, unreg_list) {
 		/* And unlink it from device chain. */
-		write_lock(&dev_base_lock);
-		unlist_netdevice(dev, false);
+		unlist_netdevice(dev);
 		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERING);
-		write_unlock(&dev_base_lock);
 	}
 	flush_all_backlogs();
 
@@ -11254,7 +11248,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	dev_close(dev);
 
 	/* And unlink it from device chain */
-	unlist_netdevice(dev, true);
+	unlist_netdevice(dev);
 
 	synchronize_net();
 
-- 
2.43.0.594.gd9cf4e227d-goog


