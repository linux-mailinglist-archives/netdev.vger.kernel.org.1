Return-Path: <netdev+bounces-70262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4394884E2E4
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71A91F268DB
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D4B7CF3A;
	Thu,  8 Feb 2024 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cCeRC+tq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018927B3EE
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401554; cv=none; b=q6x66YMfuMzhP7SG3iYHWNPzk97o8mEuvvMEy4Ne/SVm1H2gceX6bKIUtJYP1e3uWtWWFfpKIp35HYZD89wCjnJDQDDirVAONm6C477vPzR0NpwULmQ+E/hrnHPw6cjoHEMKqw0NzMD3LWpSuCqJLLBmuG/4qszrx20vLlZSzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401554; c=relaxed/simple;
	bh=3dEIclIlCNF9rXMf2VHFOyDmo/STRXctrLLM2Vo41w8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iOXkm71Haao0QQinfe02pmEXPCwoFG4WouYJ3eod1Azeytqq3Hq9pHyLBPzhqqRD6OYOsoISzHb7AzWrgDtX4kJpfr4B7uTlZt2VpmxoV16fgpaYHeTUBPDMrKZ2StTe37sSLA89ftGxFpaHW5Kg7j04OLiwar4k4Wna3yCeErI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cCeRC+tq; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so2344894276.2
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 06:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707401552; x=1708006352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/yPY3D6IQ091H0KBhKyBNuekLGyEgvb4dhGsTtzVHpk=;
        b=cCeRC+tqfdZD5bthrGofxnUy279hk91ElRDznkkAkMAYOfUaoVHBKe+9NOxXtxWy0x
         okQRnJcZkjta5tpJViNG/lEVagzY9TL9CCiI7NoaonWJu2Ad92L/ggLPRBspUdjAkCor
         UL5xQxSUXu7yrxt1xp1Y6OFCngIlqgavViCvyOP/x//+pHAKO0XY1TI/gLTUZR+QLOHi
         AXd/8FWhNZFYg4pWx2u3ezUOR56MR/9jNsZqW23NCR22S6Ocw8J/0L1na3/TAZyqaZ2G
         hL9w2+Yp21kmYQ3ehVP7hdYH+c66sNhHDm6z1Ag4+dZhyZWPV+Q9MRlLhjpQsjM6d0xm
         kcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707401552; x=1708006352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yPY3D6IQ091H0KBhKyBNuekLGyEgvb4dhGsTtzVHpk=;
        b=s8MYOj3pQAiIqOlwEtf7iA0FkvLYxpbbs9Lk3/4fJBfd2Ee9cabbHi0BoNybyH7sjc
         aN9fpEop5bsl9cQQ+gQgLrxsMM2x8+58YBcYwwDHcKpzSr2QYr+BQbAer2cQO8rdxkJA
         IzWqGzpVccoS5crtRiGNDHiYYveX1asLl/dQyjUmBkYXCMPoubW/u2orLDP9Bk5Zw5Pz
         fMas//BkU0aIXo/UWKBygIoRWk372BKhvSyZg6hxtOxkCZ4agG0GLYGPB8StH6q6CjSv
         Fx2Eq46KN0Q4UAgJkEmNmW5XqL+bji21b8bXbpFmexYvzKm+h34XaRgMcAR/wMyQm9Iz
         tIpQ==
X-Gm-Message-State: AOJu0YzjjAQo66Ej3vTZ2bKBWrsijGYOZ9sxejSFTWwqIjZR+aqObdrQ
	ze5Fkal2W1Kl8jWdd2IxcVONqcnL1dXPMPRHEILWEbMBGxFHhIN+NNfYi8z/WferFpdY0mLnZsQ
	M4MC3sTDqIA==
X-Google-Smtp-Source: AGHT+IGflCDb+aY1lt8EX+RX+gF+stGjlSDgTCQkMN2I1wuJX/b+otqFwU24Yvbk/KqEZG7NhuPiMGsugw33Wg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2102:b0:dc6:eb86:c422 with SMTP
 id dk2-20020a056902210200b00dc6eb86c422mr323187ybb.5.1707401551991; Thu, 08
 Feb 2024 06:12:31 -0800 (PST)
Date: Thu,  8 Feb 2024 14:11:53 +0000
In-Reply-To: <20240208141154.1131622-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208141154.1131622-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208141154.1131622-13-edumazet@google.com>
Subject: [PATCH v2 net-next 12/13] net: remove dev_base_lock from
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
index a69c931fca7bc5904db29a217779981fb6858e54..4adf1b93eefe8052dfd907727fe6f1996b3477fd 100644
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
 
@@ -10558,9 +10556,7 @@ void netdev_run_todo(void)
 			continue;
 		}
 
-		write_lock(&dev_base_lock);
 		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);
-		write_unlock(&dev_base_lock);
 		linkwatch_sync_dev(dev);
 	}
 
@@ -11067,10 +11063,8 @@ void unregister_netdevice_many_notify(struct list_head *head,
 
 	list_for_each_entry(dev, head, unreg_list) {
 		/* And unlink it from device chain. */
-		write_lock(&dev_base_lock);
-		unlist_netdevice(dev, false);
+		unlist_netdevice(dev);
 		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERING);
-		write_unlock(&dev_base_lock);
 	}
 	flush_all_backlogs();
 
@@ -11252,7 +11246,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	dev_close(dev);
 
 	/* And unlink it from device chain */
-	unlist_netdevice(dev, true);
+	unlist_netdevice(dev);
 
 	synchronize_net();
 
-- 
2.43.0.594.gd9cf4e227d-goog


