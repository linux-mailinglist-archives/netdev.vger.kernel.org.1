Return-Path: <netdev+bounces-71187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F82485290B
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF860284477
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 06:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CE51642F;
	Tue, 13 Feb 2024 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZyT3unIh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1317E18044
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805990; cv=none; b=pzoeFAQzC0xgCZ31APFN0ZYlPv4CfVOiDmcaoBdY90JsNLpE05/yn47HwAQUPPPRqXGKhLoxbRDG9o/6534Y5dhOR7moQ/SBgoDhOefQqvk2UOXsaeA7ldU6V+P6kCmPOJHan35CzyIabIxWXidTLCyc0A9f7sSSenNO7+Pg97I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805990; c=relaxed/simple;
	bh=j/J7vu30687/sJrYK0CySmasG67inA1BKRBO3W9Csos=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SaW7UTYMB5BsWOeaYJO60I9w4J08lXFS7CmZoVFEWxm41+Yxl5iusqa3M14oCiEj3g4hIbO8fhOkIvPb0dbsrvXeMMcOebgeO14dpT3K7I/6hvJgyoBAokI3+HOra/BxTT1b/qR4cWZmSN54UTh/6XJUBSmm4Pzv7L0obbPD4qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZyT3unIh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6077ca422d2so13564477b3.1
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707805988; x=1708410788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DP3KPgV+GrkKvwvc7GU1JdciRRPP5FsUDMccnV8S18k=;
        b=ZyT3unIhedpUQMRn+/hgqu8xuKgWwN9B26pPwQcppAZN21JkW/2W0USW+gKcpXT+CP
         vzPpY4m31B5cesDaO6zIq5hmPKpWYnR2eulvh7wsuQsi6/O+BFFRXIJs52G9ySn1I7LG
         np8pj8dVPISZewDiLh/7Kn/p31T0BsKXj5OmSwl5kFW41rkXTExmNQU4/njzyqU1C2Lc
         vmOLkGGMSV+4qRGrJK+EEWGQctPPHGolJI9/G3qVLC+PtZTKlAvaurZGGEfbeNaOxEzD
         wzzlg2UVboAEizbnWDeU2+yk0cPR6CUhw9ssFfHsDX4QWFirdceeBVQkUHc8AlXGHUZE
         zH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805988; x=1708410788;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DP3KPgV+GrkKvwvc7GU1JdciRRPP5FsUDMccnV8S18k=;
        b=MGNGTFLIMRp+FJDCPrMN0y/TLAEdnDbu2AMdcno1w7yOCp2qEBaaArTzKhbr4o597e
         f8ut5RTukznxnD2pqMAGB9Ox4clv73D556ovW+frL6B4Hxt0gnEs4Q2hQ3UpdwOp2BII
         CopKifS8OEPW+QfsvNdQsCD+FLqY5EsaR6rTOYzCWNYScJOeVt98Q0cJe/yvy9+5/7yK
         jetcrew7oeBlF7QdBb4aUlfNhx9O4GfQyGqfQnMaWqhVmlEjvwIJfflp0fbx9l/e5JHd
         Hrc+TfyqxgacMyA4urFoxnMfSK8Z5T031Hm4UgwByB75y4pG4Jwb9+IY3SFaZtaKMyd4
         b3Pw==
X-Gm-Message-State: AOJu0YwUaHfpvjGoZUW/edjDYTbGFVwWRiPslYBAcFFPHNCxvEP4gw8d
	bdOQ/kM5dcwT2YiljOZu7M/aZL7pRokx7exVoTU/SMkJhRmX2HHphCk623IrsdfvZ8nIO3rz49S
	+4YnBglBTug==
X-Google-Smtp-Source: AGHT+IFG/6GgDdzjrgQOjouEsyV3JyCOPvyLCAW45PzDAiHW17cF0bQFFxOmh9ZKK3hcu/dL3tbNP8aYKv38bQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:100b:b0:dc6:fa35:b42 with SMTP
 id w11-20020a056902100b00b00dc6fa350b42mr2286110ybt.2.1707805988176; Mon, 12
 Feb 2024 22:33:08 -0800 (PST)
Date: Tue, 13 Feb 2024 06:32:44 +0000
In-Reply-To: <20240213063245.3605305-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213063245.3605305-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213063245.3605305-13-edumazet@google.com>
Subject: [PATCH v4 net-next 12/13] net: remove dev_base_lock from
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
index ddf2beae547726590b1f0bbad3d40c0556d815d2..a6b5c5aecb6f12a3cb280408bbdd5d9c0b9a9365 100644
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
@@ -10296,9 +10294,9 @@ int register_netdevice(struct net_device *dev)
 		goto err_ifindex_release;
 
 	ret = netdev_register_kobject(dev);
-	write_lock(&dev_base_lock);
+
 	WRITE_ONCE(dev->reg_state, ret ? NETREG_UNREGISTERED : NETREG_REGISTERED);
-	write_unlock(&dev_base_lock);
+
 	if (ret)
 		goto err_uninit_notify;
 
@@ -10587,9 +10585,7 @@ void netdev_run_todo(void)
 			continue;
 		}
 
-		write_lock(&dev_base_lock);
 		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);
-		write_unlock(&dev_base_lock);
 		linkwatch_sync_dev(dev);
 	}
 
@@ -11096,10 +11092,8 @@ void unregister_netdevice_many_notify(struct list_head *head,
 
 	list_for_each_entry(dev, head, unreg_list) {
 		/* And unlink it from device chain. */
-		write_lock(&dev_base_lock);
-		unlist_netdevice(dev, false);
+		unlist_netdevice(dev);
 		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERING);
-		write_unlock(&dev_base_lock);
 	}
 	flush_all_backlogs();
 
@@ -11281,7 +11275,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	dev_close(dev);
 
 	/* And unlink it from device chain */
-	unlist_netdevice(dev, true);
+	unlist_netdevice(dev);
 
 	synchronize_net();
 
-- 
2.43.0.687.g38aa6559b0-goog


