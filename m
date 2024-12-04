Return-Path: <netdev+bounces-149130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 418D29E463F
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 22:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023EE284096
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 21:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB81E18C900;
	Wed,  4 Dec 2024 21:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yrBCUM6f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A72918DF81
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 21:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733346164; cv=none; b=rtrtNFb2z4oT4fgq9u+L2NYNvJlfXVoltb4cT+iVvACCWiW69FLP6VTAIs3l4WXG8I6gjsp7wUcpZPVp9IJqp/ho2qV9DNuhotSrWRdj9Rq90iBwrRKF4N+UdCxaa8/Pgaa33nvKczKDkzEzTBJNn90qm8aHGByC+FJ0tRM3/DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733346164; c=relaxed/simple;
	bh=tNCQRmA7uVZfWXZM1ueV0TK3opBAR/9bLL/BlNT0JbI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Uq5xVDOv5cwWiy2vU1o2nts7NVfM6tN/AM3gvZMui9wVVUGjN5tzQ5zsqI3uYha88cI43NQ12ihaQvDgii6jQ90bTvwxcgeQQ49qRgLqQHubd/NgwGBXhhfqrN6BVDZIapl1opKurEIz8j618cbuaprhb7LFJ8vHro/LiFGHbd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yrBCUM6f; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6d894e3fb33so6511236d6.2
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 13:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733346162; x=1733950962; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GNRPDIvz3xNKk/kgnn/P6cIj2qZh/XeTmjHX6t36200=;
        b=yrBCUM6f5Nf8UgFz3+G3Yldodhh3k/XdEE6yZmMF1yLh14cPzqpG3ncy9W+zcJlKun
         etVbBZqDo1pbZD9JJM/negQo/L1upDWE0QoBeZRv5lYeUrByJO2WQ85ng/k0LsIX9Dwe
         aA8crLehuJoSt0mifp1srsefyDQiU5gLtLOxWbNA6ncGDRTTZsFlQ/Ycix1vb67AYjV3
         NC8J9ywS1rtGYQIwbIDgRXGqk0pEj9fYziIujBmZ85lGb1myZEDnesDButOtLCBrC6gH
         KEJ0gBnK9UuirsAggjPVeormiin00tif49e3eSSVU2UPX0zOP9hjRvBL0ikggSDZcY02
         SqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733346162; x=1733950962;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GNRPDIvz3xNKk/kgnn/P6cIj2qZh/XeTmjHX6t36200=;
        b=DmE6+MAjgdm6CSdRTdr67HQOPaUWSyKDsmRfuoz3fO+TIbTrzsK5gG0YRCXLGbZGPe
         ia6SVEdsiqQc1+wrmc1GpZCQwo/2hCzoZil+3Q4S85/XFHw4kfU76FUICzNoI2VcubhQ
         N676xNb7qF160LVibG6bGfE0I/Bqh3Y+ckLdvF/eoJ1g4KkJs89phkYGxTdrIq/pIXN2
         qb1kE+YfW9ZgbrrpG6BQ8R68KL9kWBPsLZar/6j4D0su0SEtR71yJHcSdX5xV11R5+6u
         B0kWyGFDdZsGB4OsjgbhILQP4RWbjAGMVQfKTlQuOlWvhKkTjuqlTcgbdtPynkzgwJCe
         M3Cw==
X-Gm-Message-State: AOJu0YxDj7Z3qYI3jmVRDJZroDQzZnOLNimAODHiDyPeaoyLY2HfytAY
	0hmp42PDb0eXW2by+6tgquQ55oy0qvZs5nvyTUYdI56gvcJovIRmcPSqvh0+tuM3kz9hAa1QldF
	yB7HG7+jO7g==
X-Google-Smtp-Source: AGHT+IHrC3VX/WMNa5f6Ore2z04+9N1Rz39ldJ8xGmvmYlY/Jv0qlWYh+Vs5dtK4SDiYrfL6/wsEP5JiPM6xVQ==
X-Received: from qvbqy5.prod.google.com ([2002:a05:6214:4d05:b0:6d8:adbe:3a8b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5bcd:0:b0:6d8:aba8:8393 with SMTP id 6a1803df08f44-6d8b74039f9mr100891226d6.44.1733346162288;
 Wed, 04 Dec 2024 13:02:42 -0800 (PST)
Date: Wed,  4 Dec 2024 21:02:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204210234.319484-1-edumazet@google.com>
Subject: [PATCH net-next] net: tipc: remove one synchronize_net() from tipc_nametbl_stop()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jon Maloy <jmaloy@redhat.com>, 
	Ying Xue <ying.xue@windriver.com>, tipc-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

tipc_exit_net() is very slow and is abused by syzbot.

tipc_nametbl_stop() is called for each netns being dismantled.

Calling synchronize_net() right before freeing tn->nametbl
is a big hammer.

Replace this with kfree_rcu().

Note that RCU is not properly used here, otherwise
tn->nametbl should be cleared before the synchronize_net()
or kfree_rcu(), or even before the cleanup loop.

We might need to fix this at some point.

Also note tipc uses other synchronize_rcu() calls,
more work is needed to make tipc_exit_net() much faster.

List of remaining calls to synchronize_rcu()

  tipc_detach_loopback() (dev_remove_pack())
  tipc_bcast_stop()
  tipc_sk_rht_destroy()

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Jon Maloy <jmaloy@redhat.com>
Cc: Ying Xue <ying.xue@windriver.com>
Cc: tipc-discussion@lists.sourceforge.net
---
 net/tipc/name_table.c | 4 ++--
 net/tipc/name_table.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c
index d1180370fdf41cb05c86522b4da6aa412a54cce9..e74940eab3a47901d49b552767b16793c4459aa2 100644
--- a/net/tipc/name_table.c
+++ b/net/tipc/name_table.c
@@ -949,8 +949,8 @@ void tipc_nametbl_stop(struct net *net)
 	}
 	spin_unlock_bh(&tn->nametbl_lock);
 
-	synchronize_net();
-	kfree(nt);
+	/* TODO: clear tn->nametbl, implement proper RCU rules ? */
+	kfree_rcu(nt, rcu);
 }
 
 static int __tipc_nl_add_nametable_publ(struct tipc_nl_msg *msg,
diff --git a/net/tipc/name_table.h b/net/tipc/name_table.h
index 3bcd9ef8cee3046f09b07901b87e344f42253d69..7ff6eeebaae643c31f8395cb14d3b6b8d8cd2610 100644
--- a/net/tipc/name_table.h
+++ b/net/tipc/name_table.h
@@ -90,6 +90,7 @@ struct publication {
 
 /**
  * struct name_table - table containing all existing port name publications
+ * @rcu: RCU callback head used for deferred freeing
  * @services: name sequence hash lists
  * @node_scope: all local publications with node scope
  *               - used by name_distr during re-init of name table
@@ -102,6 +103,7 @@ struct publication {
  * @snd_nxt: next sequence number to be used
  */
 struct name_table {
+	struct rcu_head rcu;
 	struct hlist_head services[TIPC_NAMETBL_SIZE];
 	struct list_head node_scope;
 	struct list_head cluster_scope;
-- 
2.47.0.338.g60cca15819-goog


