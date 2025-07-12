Return-Path: <netdev+bounces-206372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4CAB02CE6
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 22:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05FF4E1D28
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 20:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9452122C355;
	Sat, 12 Jul 2025 20:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Jjz6A5S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E822D7AA
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752352535; cv=none; b=Dx5Vov7OH+OUKIpXzf5jGefXvCkbqTCXI7nPCL/7zHbCks/74/eaglTZhZBh/IuYe60NCi1OCk52U5L7sXctlT7rIYGWydreyFa8azl2PjBXtZrJbIiiWo55Z3ttiEGQgNmKDVSFZ49Oo0+VVXGazrhmrJ+OGHUD2SAR9jFAaU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752352535; c=relaxed/simple;
	bh=UyZ0rpb79sz2Zc/pp3C4WcTIDjKkIslRsbk1fl9n8lY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XTHfUMWjnSSsyMvZ/YMtggmwtDRr/aPT49y3Tqqvry41K9p2IOVA58AGaD0ae1wDVoIVI5endkg1tgpu8XF8WvyU3BKWWVXYCRCSHDgGDTpe1MGRmJGNGmKrI3dfx1y4WSgY3oArX3DQuCrqEqzkKKJhhJ4vt+5uM/AB9u32USE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Jjz6A5S; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-747ddba7c90so2674501b3a.0
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 13:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752352533; x=1752957333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CLNUYRj+s/13Bynnqks1AIvyaN+/9aczM3T5t5NQz/M=;
        b=2Jjz6A5SHVAmXfqCERqjFkhhfErMTYr2SuulFKsowQoX2cS6iCNorJT3OI3wY07a2S
         ZR3lOFZQkNMET/mD4FfSAV/OGEvg9zpiRwkcdUeGUZXB1rXMgnLeHGl9ywCD6RX1bxa+
         18qMBxHqRJyKM80RmKMTa8vhOK1ElDQ0ILQSM1QBSoMyt0iKplAQ9UkgdT9FsaSWcAam
         L/QbsGJ6uQvrBxTuV6U7kh//MW24viGbSNMwjb6IVfFwFSDoQCLFZfVctd8pVeajnaAm
         i/QZlifqKV2cbg/FOdY3CReW9FHs/TniDoVDfiT+XEowMGqlaEicSIPY4YW0gnXs5LZU
         WOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752352533; x=1752957333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLNUYRj+s/13Bynnqks1AIvyaN+/9aczM3T5t5NQz/M=;
        b=LjWGNoeW+XXtaMnhEt2ncG1B9aIAfZYCcvVqQxYae1K+k3rf/h9csH65mQk6QDvCDG
         RIeaNFOCeSuDDVcl9piZogcIBJDEAFmLXkqulSiVYEPAngAC78I8mkqtcrfWyWJc4MrJ
         qC8tu087fXFoP2RnnDygcchT025Cq9VRWNhLRo6hz5l0Gi47tnMOh/nPZUuPU2LH/ywo
         UYZXSMwUq9yOBnOEIqRcJLBfNXQmkDUkADp+ZwMy0xCHI10Mvbw+9h2KLhsd680KUw3s
         YNaqm0E1VOVfwQM0NybzEWtnFcrVMNx5xPqaCo3JyFOMTAyCbJgHzVHBZ9jphKQXLuM0
         sWPw==
X-Forwarded-Encrypted: i=1; AJvYcCWkpzz1PL+jKYuTCmuGZMfNwLYFNgwQVuNXrpQYCttqHaqQ5W/gIUrepUvduolUWhoaqzyTsfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4gE4MG8/qadTcENP5gmE10y1m6emfHdr5WKfEMbyxR0vwCguB
	2J0vcclJYcUgw7/4CL0/zgi9Z73zB+yQ3qF+/wrSW7KLW1HhMyjoj/a805jJmxf5tZEDTU0aOrq
	4c+NYiA==
X-Google-Smtp-Source: AGHT+IGtObKwai7MJmFermPgGAYE/6FILkpgaA+aNMocdE1d18rNfCHcKAhWreK7fSWBXRoV9NwJZvZ++lg=
X-Received: from pfbbj10.prod.google.com ([2002:a05:6a00:318a:b0:748:da37:7e37])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:846:b0:748:e5a0:aa77
 with SMTP id d2e1a72fcca58-74ee2961e15mr10792958b3a.13.1752352533363; Sat, 12
 Jul 2025 13:35:33 -0700 (PDT)
Date: Sat, 12 Jul 2025 20:34:19 +0000
In-Reply-To: <20250712203515.4099110-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250712203515.4099110-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712203515.4099110-11-kuniyu@google.com>
Subject: [PATCH v2 net-next 10/15] neighbour: Drop read_lock_bh(&tbl->lock) in pneigh_dump_table().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now pneigh_entry is guaranteed to be alive during the
RCU critical section even without holding tbl->lock.

Let's drop read_lock_bh(&tbl->lock) and use rcu_dereference()
to iterate tbl->phash_buckets[] in pneigh_dump_table()

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 38442cffa480b..0109bc712378d 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2806,14 +2806,12 @@ static int pneigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 	if (filter->dev_idx || filter->master_idx)
 		flags |= NLM_F_DUMP_FILTERED;
 
-	read_lock_bh(&tbl->lock);
-
 	for (h = s_h; h <= PNEIGH_HASHMASK; h++) {
 		if (h > s_h)
 			s_idx = 0;
-		for (n = rcu_dereference_protected(tbl->phash_buckets[h], 1), idx = 0;
+		for (n = rcu_dereference(tbl->phash_buckets[h]), idx = 0;
 		     n;
-		     n = rcu_dereference_protected(n->next, 1)) {
+		     n = rcu_dereference(n->next)) {
 			if (idx < s_idx || pneigh_net(n) != net)
 				goto next;
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
@@ -2822,16 +2820,13 @@ static int pneigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 			err = pneigh_fill_info(skb, n, NETLINK_CB(cb->skb).portid,
 					       cb->nlh->nlmsg_seq,
 					       RTM_NEWNEIGH, flags, tbl);
-			if (err < 0) {
-				read_unlock_bh(&tbl->lock);
+			if (err < 0)
 				goto out;
-			}
 		next:
 			idx++;
 		}
 	}
 
-	read_unlock_bh(&tbl->lock);
 out:
 	cb->args[3] = h;
 	cb->args[4] = idx;
-- 
2.50.0.727.gbf7dc18ff4-goog


