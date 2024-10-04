Return-Path: <netdev+bounces-132068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A86B9904C5
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8E15B20A7D
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851832101A7;
	Fri,  4 Oct 2024 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eT5svHqm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE3D212F0B
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049647; cv=none; b=lv7EKacFp/mrAobq9yQs9CPZSK6zST8J57L8kN4wiAghlStc7xxQEboiOLnGqYL0Gjs+EQ/hmlsD9H6EVI3savrX9og3pabvyuqVr11N8uvceS6o98kwVTxl2XRQQf/nB0qJqjPpNi9eeP29E6JjnFC0yFs+rR2M5G4jPnxxbCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049647; c=relaxed/simple;
	bh=a72KhzjwyFh3nz7XfPh4moZi8YtJdVMW5XG/AFMUBFo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RAKb/A8lxIykxFrVJdk9IxgztHj7xYNMPuJ2CbEyOCD3mBIsmEx/CewEkbaGypNlhueFrO7FTtOn4+MpKOBAzm+OVKX9lBsu0YuFTek6smgYj2k3yHSBmuFhDvXubpAeJhDnpp25hDaiPvpX8a7sma4jZ+TLzBnqMtYTZr48gA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eT5svHqm; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e262e764f46so3492232276.1
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 06:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728049645; x=1728654445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yvrrepST4GJRUm66NiZVOohqpKiv6IlBESIes/aP9+s=;
        b=eT5svHqmE+OZzPi23uSqn9y8G1jwfjtEv2/XPp/TMoi/EZ5yl9d6DKpquofg3xeASQ
         lyIwlgcwR5bkQYZ3bSdWpGL0+DWeZa0qcd6E2I6VvGm/HW/D1mk27iy57zIqkuB+6Yrf
         WTlcavVbpjyYj8H0lbV5cY0iaGdeq+b6sjUEDwyhfMO5Ns9EHtQxq1gua02uICy0xRfZ
         k+TjkGUdYDle9sLEob7g0bU9inqbGfUjgGpqbDqRn7AWWkFLwUHJJ0JimVy8DJv8ZsZI
         uDRUpBn8snCFGPsvkmSK6SiBVr7/d9piY65EcbHM0dCtCAO+4M0s1u+NdmvYLU5+TAMY
         auRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728049645; x=1728654445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvrrepST4GJRUm66NiZVOohqpKiv6IlBESIes/aP9+s=;
        b=Wu38gJOwfMNm0Af2LKpSmJUmrzdkUkEM5qXOMVTBQ/MsQd4nL7iN/snbQ+x2Ai0wEb
         oJZOJxSMaInsFujIVAbVyTc2P6gcknjy+pO+vVP5dMI98UcNUbVkXSwLpfoXAa8JxpAu
         b6Dh8n0fnIY1463g9Jk/gAti8ki/RE7up98QA1HxapWdXiqA3oYbXO2lD01WvJ9Vv7J7
         vN0jdg/I764kUnIgR9D1tB+HIyZeF0q0iUQhU8hG06im3QSPZEownS6fLpYZeaSHo+qS
         2jtgGEmy98T+AuZxUEmVCeCQ/uQbY9A02NXMGKK2Q+Yxec6IHYpC8YpvW7reGd5OmaoX
         up8w==
X-Forwarded-Encrypted: i=1; AJvYcCVEMRo/C7kBkbeZwdS8Bj8yrXbjmLDcIweDM57r3wM43e9p5S94p2qTvKpMVN12k9Hr5H0gDM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNI0iM3qLpEM9nE1xNzkcXKB8qm+nEdL7VbGurnjqi5ogWw0vz
	MJrmEFsS/q+58P+h4p4KbFUqDxMR7WF6pFAoQyUzesuO9zKTEuF4Ms59//eCIso3LLERA1m+XTV
	B/5xRZAboeA==
X-Google-Smtp-Source: AGHT+IGzRV898qBhhKaW9DBm2fq/XmwGCW4N8pTQ4fudT+j/im7WilGv2r4Aa1adN861v65p/QkTaHMCIxU8vw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:b191:0:b0:e26:177c:86ed with SMTP id
 3f1490d57ef6-e28936bb059mr1733276.1.1728049644870; Fri, 04 Oct 2024 06:47:24
 -0700 (PDT)
Date: Fri,  4 Oct 2024 13:47:18 +0000
In-Reply-To: <20241004134720.579244-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004134720.579244-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241004134720.579244-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] ipv4: use rcu in ip_fib_check_default()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Alexandre Ferrieux <alexandre.ferrieux@orange.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

fib_info_devhash[] is not resized in fib_info_hash_move().

fib_nh structs are already freed after an rcu grace period.

This will allow to remove fib_info_lock in the following patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/fib_semantics.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 1219d1b325910322dd978f3962a4cafa8e8db10b..e0ffb4ffd95d0f9ebc796c3129bc2f494fb478dd 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -275,7 +275,7 @@ void fib_release_info(struct fib_info *fi)
 			change_nexthops(fi) {
 				if (!nexthop_nh->fib_nh_dev)
 					continue;
-				hlist_del(&nexthop_nh->nh_hash);
+				hlist_del_rcu(&nexthop_nh->nh_hash);
 			} endfor_nexthops(fi)
 		}
 		/* Paired with READ_ONCE() from fib_table_lookup() */
@@ -431,28 +431,23 @@ static struct fib_info *fib_find_info(struct fib_info *nfi)
 }
 
 /* Check, that the gateway is already configured.
- * Used only by redirect accept routine.
+ * Used only by redirect accept routine, under rcu_read_lock();
  */
 int ip_fib_check_default(__be32 gw, struct net_device *dev)
 {
 	struct hlist_head *head;
 	struct fib_nh *nh;
 
-	spin_lock(&fib_info_lock);
-
 	head = fib_info_devhash_bucket(dev);
 
-	hlist_for_each_entry(nh, head, nh_hash) {
+	hlist_for_each_entry_rcu(nh, head, nh_hash) {
 		if (nh->fib_nh_dev == dev &&
 		    nh->fib_nh_gw4 == gw &&
 		    !(nh->fib_nh_flags & RTNH_F_DEAD)) {
-			spin_unlock(&fib_info_lock);
 			return 0;
 		}
 	}
 
-	spin_unlock(&fib_info_lock);
-
 	return -1;
 }
 
@@ -1606,7 +1601,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 			if (!nexthop_nh->fib_nh_dev)
 				continue;
 			head = fib_info_devhash_bucket(nexthop_nh->fib_nh_dev);
-			hlist_add_head(&nexthop_nh->nh_hash, head);
+			hlist_add_head_rcu(&nexthop_nh->nh_hash, head);
 		} endfor_nexthops(fi)
 	}
 	spin_unlock_bh(&fib_info_lock);
-- 
2.47.0.rc0.187.ge670bccf7e-goog


