Return-Path: <netdev+bounces-230953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9543ABF254A
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 18:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D571A3BB1F5
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 16:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE83B284662;
	Mon, 20 Oct 2025 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2PPaX4x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B17A2773D4
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976678; cv=none; b=r+BAASCTGaZIQiTc5YHp1mV2L7hThO91c7ZboHhWPjLe2wDfQB6jW1cxiyb/swn0TjVkJTeF+/EdCjjpX9LD8ZrYeU4p/r+0MJ4dKY9c35DMK2jXFDzgarGIssK9hBkZ2mcQICUYBDVT4e15yn2aWqwWvuJ8Jx1hQJNtnv62yRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976678; c=relaxed/simple;
	bh=d1n2YVQk9HFlFNlDY0GDUW50N4r2+hwWI4V1QzlkUvI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oYZf0Ft8ahBOaMKs2kAqC8w43nPgkUFWqij8BuQ97LnW2DEfkQZcmf8SAY47pVLAvMq1wd0gp4Crv5L5Q0aIiyUHCe/r4Mny7ElelT8V+62avQnGtt8b5n1M41kgdxyZOwMMwTpY+PUzHBPwpARZ9nhqICwfhTt+WQGSUHyUSnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2PPaX4x; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8741223accfso187881986d6.1
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 09:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760976676; x=1761581476; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pkS7kfgMWCPCBuMfltVM6ykO2d8yAJI8fcJyUvxgUSM=;
        b=I2PPaX4xnwBlO3lriT0Vkof3lNOnPZJmszgF71kqASs3n49NniRYiey4QkjPMvnWfg
         6uUPibNFmr66Dos6f57T08YGHPp1MCodCMleXdW40B+tPcrHsht1hDrWVVkS5ZAmtjA7
         qU41P+mGd+9KneH031V45Z3qo9WKYuLonpVCbg4D4tBOUgQ/Q03M6/x1ZuTA3JhrH8dZ
         /3cVRppOkFnfahtFmYxdrSvZCNTpDV6siGV6OU4jcpWx+AQicfmaXlfzZfvhHLpNLX5R
         8iNghrFnnVaUFGLtEkDGaB7OOxFZAB3ZmEw1UhFe3rBC06IxnpNLXsBFd234+hA7kvQd
         7Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760976676; x=1761581476;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pkS7kfgMWCPCBuMfltVM6ykO2d8yAJI8fcJyUvxgUSM=;
        b=FYiX/5t097DdhkATFbM06jHD6R4+apl6hvJBBdW1o2OInCrFy25RWqgYR2tZ6+mdLa
         mJ0t2yjwnrJhx7GtLGGn8xh+gRG6RTKqvf4teWfzYqaNhTcX6pLfQEUQ8ZnTYEL9zWw5
         8uFecMl4k2yox7VhLTIYAg2xOJOEI3li8bQIZoTJv2AkBGvyFU/OMZGhrvxaW1EAr67v
         n/pe09W946E2Hhr0IkPsKxFKxS1yOr2Avm0OCyAzh5dRvLg3CRSFqf55DpvXL75Kml08
         HdFITbMPHcTxHo5C2s8W1ERKc35YNn4XB1IAUenTkv4iZcEXQw/+eCkkQjJfGZxsBrX/
         6azw==
X-Forwarded-Encrypted: i=1; AJvYcCU8eQzJarGa/sA6I521beGKaUrH+oAZeM0tTN5/X/W9kzOu4JcMBclzdi+I6SY3B/NkSOTYlM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ViFqdS/r4/GYjdBmrd+RJgH0LoliKYbtJ13LbST3c/bgy/uP
	igteKukwzNPaBVJQGAg6WpSXBoXdy+zLpMmKVuMp0mA5L+LaMqSEto8YO8UtlC60L1uFvPO5X1e
	rmtwJRFVLuB+rmQ==
X-Google-Smtp-Source: AGHT+IF4jS9xIWU+rpT+flG8G3AHsburrdBe8/ZOkAhKHZtDYD7htWy5bUVwYTbmJldR7n6MWMhOVEOJuOotig==
X-Received: from qkpc29.prod.google.com ([2002:a05:620a:269d:b0:890:932:bca5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1827:b0:4e8:bbd4:99ee with SMTP id d75a77b69052e-4e8bbd49ff9mr73756851cf.44.1760976675949;
 Mon, 20 Oct 2025 09:11:15 -0700 (PDT)
Date: Mon, 20 Oct 2025 16:11:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251020161114.1891141-1-edumazet@google.com>
Subject: [PATCH net] net: gro_cells: fix lock imbalance in gro_cells_receive()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+f9651b9a8212e1c8906f@syzkaller.appspotmail.com, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

syzbot found that the local_unlock_nested_bh() call was
missing in some cases.

WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz.2.329/7421 is trying to acquire lock:
 ffffe8ffffd48888 ((&cell->bh_lock)){+...}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 ffffe8ffffd48888 ((&cell->bh_lock)){+...}-{3:3}, at: gro_cells_receive+0x404/0x790 net/core/gro_cells.c:30

but task is already holding lock:
 ffffe8ffffd48888 ((&cell->bh_lock)){+...}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 ffffe8ffffd48888 ((&cell->bh_lock)){+...}-{3:3}, at: gro_cells_receive+0x404/0x790 net/core/gro_cells.c:30

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock((&cell->bh_lock));
  lock((&cell->bh_lock));

 *** DEADLOCK ***

Given the introduction of @have_bh_lock variable, it seems the author
intent was to have the local_unlock_nested_bh() after the @unlock label.

Fixes: 25718fdcbdd2 ("net: gro_cells: Use nested-BH locking for gro_cell")
Reported-by: syzbot+f9651b9a8212e1c8906f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/68f65eb9.a70a0220.205af.0034.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/gro_cells.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index b43911562f4d10aa3d05c60f343ff89c5d9ed58d..fd57b845de333ff0e397eeb95aa67926d4e4a730 100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -43,12 +43,11 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
 	if (skb_queue_len(&cell->napi_skbs) == 1)
 		napi_schedule(&cell->napi);
 
-	if (have_bh_lock)
-		local_unlock_nested_bh(&gcells->cells->bh_lock);
-
 	res = NET_RX_SUCCESS;
 
 unlock:
+	if (have_bh_lock)
+		local_unlock_nested_bh(&gcells->cells->bh_lock);
 	rcu_read_unlock();
 	return res;
 }
-- 
2.51.0.858.gf9c4a03a3a-goog


