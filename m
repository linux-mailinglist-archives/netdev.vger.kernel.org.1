Return-Path: <netdev+bounces-283457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id c2nrBIU99mkhTQIAu9opvQ
	(envelope-from <netdev+bounces-283457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 20:08:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEA94B3230
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 20:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBE3B300915E
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 18:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88CD2DB7BF;
	Sat,  2 May 2026 18:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gIhWe8bB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FC223BCE3
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777745281; cv=none; b=hBdQ96GqkL3PEjCBwn79japjqFPhhO0QTWDzisd5ufstyRvglehhPMTAj0gaoQPQs6iWj/XbmyhzdgDJbzwmaHwhHZdKXuH0AcBuazsTqc3kaGc0Du4huMij8yp9ZyvaMI/g6R75eKytDxSycEfJOv4rwYAGqWax09dU4mkoi2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777745281; c=relaxed/simple;
	bh=BDg71/ljDFweEuTL0vy+sPaEuIXWcBXLbiTbY0cJyoY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=l148v8XGzGjI2AdlAe9j2e37dwXt+Bq8z/eOyvdeiuQXIlMEq015EuH3Sat2kNOQ5jvqQEZ9Zw6TmSJz7yenRrcktLqJrj3SWZFJQKWX/tjSxeVuw4OG6u7yUc7sgoroPS2VckgRYMFx5/WwoG3TuwhtdGDBvIe47e2trKH3L/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gIhWe8bB; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f74bcfb86so3530917b3a.0
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 11:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777745280; x=1778350080; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aEcvfwyEFLPfEDIb2zMG4nYldEq5yQOfiEnMDl+vTY4=;
        b=gIhWe8bBFZPeBVptrlNqh1e9WvAa4Yw78iM+FVRLdZ4raYwLiVZtH/2/xLpHjCL0sM
         kSKWJrY4i7RBnLLv9gtZBqItoQxKeUU446/ddiv54hnxG4dlE1ggx0QDs9iw3OPVD9oZ
         IZuB97T9kCtBMqEH9mNH9Lxxr4DtQPB1aHlzftxvp5f8V1b3VK+4WtEo3BMOzHsG+W1O
         YyRLkltKYpxUsq5o8iiNexJwX65UjHinkxx4DPHCTXj56NIoCzoJvG3EZqT1DZzm9ZqZ
         Srz4EOgiD6sj+VuQPuc0C44j2g0VdEiXHh8DgjwewkQuc1nT4pW+0WpwHt8wJ6AGx1Tm
         BQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777745280; x=1778350080;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aEcvfwyEFLPfEDIb2zMG4nYldEq5yQOfiEnMDl+vTY4=;
        b=MJM/rWjXOBfSwfnE5zJci6bOlIqQb9Q7IdMiIAnDGdM9ov+nlaVWcL8YiWjrPx4fa9
         yIj1hCUF2kCj1D5Hz14mUbTghAiioEEGY8TdzNgLtfEBqKPkl01bfHGZg8NlHTus/X+9
         ivSwMo40LaHJYnImhMiw0ovA+GtY/+C85KnbE+VNz2jiQ5YLeSk6USoWYxZmNmzWpTAZ
         9CV2+mjVPd09vNnd5gN580sxbGC2alyvL+JDJO8v4dUtSEQ7Y6QW51Ef05nez+MQAlTi
         lk0IQmqHgivZVHWc96Xm3TNlfAeJ8jknB2BcL1BTXpHTS2u1Ju1XzfjppiKGEBYCHEAF
         o/tQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1zMcJWozRfnETxdEHoZpD3saF7gvqp1NXw7gTOBlcho3lVAscfbLyGzImiT95HBRJ60ECU1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YygeT/9FpyfyKzAHH3sccWpvGVvjSWfQKcWaGqp9I+sGJTVq4sH
	GfgmnMU/J3pERmEwE/kMM5b5UuvpS9Rtp8NmCW57GQ1mEr8NDoLQiev+BIgVbJtTZvaDBGsHKVU
	BclS9YA==
X-Received: from pfbhj6.prod.google.com ([2002:a05:6a00:8706:b0:82f:5b50:db30])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a90c:b0:834:df57:9d31
 with SMTP id d2e1a72fcca58-8352d28c18fmr3978357b3a.28.1777745279762; Sat, 02
 May 2026 11:07:59 -0700 (PDT)
Date: Sat,  2 May 2026 18:07:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502180755.359554-1-kuniyu@google.com>
Subject: [PATCH v1 net] ipmr: Add __rcu to netns_ipv4.mrt.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4FEA94B3230
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283457-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

kernel test robot reported this Sparse warning:

  $ make C=1 net/ipv4/ipmr.o
  net/ipv4/ipmr.c:312:24: error: incompatible types in comparison expression (different address spaces):
  net/ipv4/ipmr.c:312:24:    struct mr_table [noderef] __rcu *
  net/ipv4/ipmr.c:312:24:    struct mr_table *

Let's add __rcu annotation to netns_ipv4.mrt.

Fixes: b3b6babf4751 ("ipmr: Free mr_table after RCU grace period.")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605030032.glNApko7-lkp@intel.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/netns/ipv4.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 80ccd4dda8e0..6e27c56514df 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -275,7 +275,7 @@ struct netns_ipv4 {
 
 #ifdef CONFIG_IP_MROUTE
 #ifndef CONFIG_IP_MROUTE_MULTIPLE_TABLES
-	struct mr_table		*mrt;
+	struct mr_table __rcu	*mrt;
 #else
 	struct list_head	mr_tables;
 	struct fib_rules_ops	*mr_rules_ops;
-- 
2.54.0.545.g6539524ca2-goog


