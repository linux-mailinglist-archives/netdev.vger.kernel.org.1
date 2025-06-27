Return-Path: <netdev+bounces-202027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFCDAEC09F
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683033A7357
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 20:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6952ECEA9;
	Fri, 27 Jun 2025 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iG6z2O4M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179F2EBDC8
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 20:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054763; cv=none; b=YMHYOt6fLcGHt4R9NlaXCfO6WRFzdLHyky2KOANyZ++neboSAaT7ycpPC5Sr4h442ayiYIDKUhve94rhHBvLvwochO7Bb8GXvFX7OBTIDux8tvXstCjSx0hACOvRdZKlHeDHYo8Ul+000svKr+sOPPVP+2wpfFNCtMqhOlPbsko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054763; c=relaxed/simple;
	bh=8sl/BamXyPErSZId9rs/N7b0J00e4aPBzwUHI1FuxJo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jL0jMXQX8eWY0YtZ3kRb9ZEPSGkB7aWoZ4EcqIaaePszxbbQLUNbl8bnMl7fRrATiewtBwF2rAjLa5V4exDmlUdv+ctTWH9W5cXEDvI+htf07y9kjls7SlGknbb0T/3GDZDlWEMHTbRkbeXggBvCb34pX7tYGz3icbVv56sVySE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iG6z2O4M; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4a42c569a9aso61710371cf.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 13:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751054761; x=1751659561; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2+5fuODTy+0oQZ42M74GhZtNyewLy/xl1yWAqypMN4=;
        b=iG6z2O4M/Is+nX67m9Pv63lhbePkVkvbFnTOa/GpBpfH78s8UCeYyNFBIichxPU3JB
         hQwMjyXDRRptU75QIoSD4i2XffLJpbdr4lJDlfkdJUwrRCEkyAi8EAqY7PwY5SglUcSM
         DOiRmOQIKxCWd8wE5RfqFFqQ66BCPfq3+8f6n+K+rNL3EviUDdS11G7JQcpfXcCxVMbv
         SR0XVecdp/8XpoEk5g7MicbNyLxyOUf/EqZGvgl13WD/bv2rzu2bu1ZjpgE4rWoMjuxO
         Uf4yUhvAuDh1EdXU0LRrot9ztCJHUVBtm2BSIJu2Fjk6NAcq4WZ3jYWwi45yWVHoTNLM
         PUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751054761; x=1751659561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2+5fuODTy+0oQZ42M74GhZtNyewLy/xl1yWAqypMN4=;
        b=VnsPcel++iiNyYAHiTQI9kA0/wekMXJzbpAEdjClEzDqduzsStwaS3DisJJmkGUokE
         DDPyQJFQfv/8wBtjVbRzJVjyUB6hOhlhcXdCpdhkrktqmvUDPhqI5TVCNkBeikeUGTpo
         M083uliNOs5pono4toLqJDEbAxNSsoEpV7yYNCHIP952ffvPsCPImfHaqeJJhdsKrjcR
         75vyb0EiY1aS2vL47cYS3yxWgXFA8rtBqRzgP4slD2tUNzzFyIZeHGHovqQ72bK7fNCW
         J4SWBCxWCOuNTLIfqecJ1FobmLdQ7G29bqQR9TSBzeuKAehN6jMv1GFvzFDbtarXlXEd
         zeXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+Sfi/qn80aegS8TTu4nQTjXPHJDy4k23FHaZZDnXNTXpJ+pQDs/0CjZpTbYAx/NxeTuUj6HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrBqmwRr+25PA1O8I6Vw9DFTXjlNBrdXFgxcXIznZCSFmnHVyK
	qJA0u86xiH9MLpv4exsc5Q9gLVX6qhYOHEJklzjIryJ6lpJ616rA/oSgj1GabsyWBbczGZpGI6t
	yUS7yTIVwb7Ea7w==
X-Google-Smtp-Source: AGHT+IFuYkUyOUfs3zRkDdERsODGTqb0wzRuh34CLA3axFUASmeB5TDSarGdZoShkUqNlkAbAulDrZsCF0Zwqw==
X-Received: from qtcw28.prod.google.com ([2002:a05:622a:191c:b0:49c:e782:eaad])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2446:b0:4a6:f0bb:4d83 with SMTP id d75a77b69052e-4a7f2de1d1emr167185721cf.8.1751054760979;
 Fri, 27 Jun 2025 13:06:00 -0700 (PDT)
Date: Fri, 27 Jun 2025 20:05:49 +0000
In-Reply-To: <20250627200551.348096-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627200551.348096-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627200551.348096-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] net: move net_cookie into net_aligned_data
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Using per-cpu data for net->net_cookie generation is overkill,
because even busy hosts do not create hundreds of netns per second.

Make sure to put net_cookie in a private cache line to avoid
potential false sharing.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/aligned_data.h | 1 +
 net/core/net_namespace.c   | 8 ++------
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/net/aligned_data.h b/include/net/aligned_data.h
index cf3329d7c2272ec4424e89352626800cbc282663..6538c66efdf90ed51836cf244237ee17019a325d 100644
--- a/include/net/aligned_data.h
+++ b/include/net/aligned_data.h
@@ -9,6 +9,7 @@
  * attribute to ensure no accidental false sharing can happen.
  */
 struct net_aligned_data {
+	atomic64_t	net_cookie ____cacheline_aligned_in_smp;
 };
 
 extern struct net_aligned_data net_aligned_data;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index d0f607507ee8d0b6d31f11a49421b5f0a985bd3b..e68d208b200dd4be76fc08af73054b3d1dea834c 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -19,9 +19,9 @@
 #include <linux/net_namespace.h>
 #include <linux/sched/task.h>
 #include <linux/uidgid.h>
-#include <linux/cookie.h>
 #include <linux/proc_fs.h>
 
+#include <net/aligned_data.h>
 #include <net/sock.h>
 #include <net/netlink.h>
 #include <net/net_namespace.h>
@@ -64,8 +64,6 @@ DECLARE_RWSEM(pernet_ops_rwsem);
 
 static unsigned int max_gen_ptrs = INITIAL_NET_GEN_PTRS;
 
-DEFINE_COOKIE(net_cookie);
-
 static struct net_generic *net_alloc_generic(void)
 {
 	unsigned int gen_ptrs = READ_ONCE(max_gen_ptrs);
@@ -434,9 +432,7 @@ static __net_init int setup_net(struct net *net)
 	LIST_HEAD(net_exit_list);
 	int error = 0;
 
-	preempt_disable();
-	net->net_cookie = gen_cookie_next(&net_cookie);
-	preempt_enable();
+	net->net_cookie = atomic64_inc_return(&net_aligned_data.net_cookie);
 
 	list_for_each_entry(ops, &pernet_list, list) {
 		error = ops_init(ops, net);
-- 
2.50.0.727.gbf7dc18ff4-goog


