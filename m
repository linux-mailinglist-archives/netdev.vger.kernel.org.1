Return-Path: <netdev+bounces-83014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2418906C4
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 18:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90515B23817
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 17:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523AC3BB38;
	Thu, 28 Mar 2024 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvbTVzn5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973035A78E
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645398; cv=none; b=cCGdZsbAvajmSOL1T++vWkp30kzykgolV/uw0RKCHkbZxFzyJmmUXldn0hcr7EEUWQqJ4GcgPh2niZt74ue6X9XRO2H6RhZ//6HBgYsVffDt4eU2FxrQ+QMZNAVbSzqiM9ybm265aNwrvKrJ1sl3oSij7iPCYFq20GKDnfeOVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645398; c=relaxed/simple;
	bh=F4gefdTj70muIJN2Zn7X1B8TXmBV5hqnEjBHGBIqff8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n0Oed3D1A8lc6/AN1ZEtoB6IXSGJA0URnDG7+XjFnJY9OVVwG0RhhI9jfJnaChASFD51CKlLEyVjjKevZaCps6AFAPwbpkEesYjxzFaUkWRebbVHJvZSRleditXcsAo9t6sfnRX5Unbg0GQ2X0aPQBnhblGQuSEV3JzOlfCETC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bvbTVzn5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd169dd4183so1379617276.3
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 10:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711645395; x=1712250195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FtfH02Ug/jt3Vtvx2bBwAZ1F+VYum2JtqqevVN5MyMc=;
        b=bvbTVzn5lpS1821HnOAn8qLAoFXvXlx0n0Qu8qASV7ZL1Bvw5HBjK71tioP15LJZce
         0S+XjG+7xUOZgGmRxU3cKcFC46mQ3nKsX86ZfOi6j0eRk1pnZUBUFofAoizF7up8gIPT
         wIIjCgsVLWd0VYw89VxBZVAvYX71i1O1KDP3iM0Vdj5xiAvRXv2ObLimhNOPnXBD6pTC
         oFoJcSuKPVY4XUk86DN+U5URs4bw7daokt9oc6N6wUhF6R08syVP8g7h/napKFlFPcOa
         AUlKadmhNVdvba60tXeldB07MdI+349TJjkaxxS9pv4q6rotkhBxl/p6W/1oqf/2Dhuc
         EO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711645395; x=1712250195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FtfH02Ug/jt3Vtvx2bBwAZ1F+VYum2JtqqevVN5MyMc=;
        b=ulkyzdidUBug2wxr1AcVsmurfTc+alzYjayUWBvqw/kUf6MotOSWLHU5zClidRmkS9
         C7R79oDFVkFC0iksftBwLRJ9mcDupRYs80ft5kBObFHe/h4nyajxRC3kbacttue0rDXs
         83DUUHObkA23B3aUztNtZJt8QHt5LKBu9TLpnlcRyFipF2sfBnoNJ92vJ1zL5Tjy4llN
         Z9zftTtOpm7zw7PkvTGdIUqH5k/wYHMFzz/jlBSM+/cCWGUj6kFepdVPSKRFI8j8RAzO
         QWWwAeOf1XjNregjU9kZJIJoBibe7VlPtwZrANMx5THq1V0I+iEeqmMbZtGlxvDz5nHJ
         LCyg==
X-Gm-Message-State: AOJu0Yy9qImlIvnZGuJAdeVMzk6O9h+DvJ573ZggSxKrYkqeZj6QrocX
	oH+Grjn4qHp60MjccEsXqG1NFNhRPMIwlHf9qFC+DohQHHCUukCX6nHbAr0SAp5344ZFb1CVYhT
	woE/nFCo9+Q==
X-Google-Smtp-Source: AGHT+IH+8zFiZOYmBZcmX4Q9j60Xdg9XImP4FW/41zvE6T/HOTeWE3/uBt0aUrcda2YyGzUocDfaX0OEueuBlQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1502:b0:dda:c565:1025 with SMTP
 id q2-20020a056902150200b00ddac5651025mr252047ybu.2.1711645395779; Thu, 28
 Mar 2024 10:03:15 -0700 (PDT)
Date: Thu, 28 Mar 2024 17:03:04 +0000
In-Reply-To: <20240328170309.2172584-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328170309.2172584-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240328170309.2172584-4-edumazet@google.com>
Subject: [PATCH net-next 3/8] net: enqueue_to_backlog() change vs not running device
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

If the device attached to the packet given to enqueue_to_backlog()
is not running, we drop the packet.

But we accidentally increase sd->dropped, giving false signals
to admins: sd->dropped should be reserved to cpu backlog pressure,
not to temporary glitches at device dismantles.

While we are at it, perform the netif_running() test before
we get the rps lock, and use REASON_DEV_READY
drop reason instead of NOT_SPECIFIED.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5d36a634f468ffdeaca598c3dd033fe06d240bd0..af7a34b0a7d6683c6ffb21dd3388ed678473d95e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4791,12 +4791,13 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 	unsigned long flags;
 	unsigned int qlen;
 
-	reason = SKB_DROP_REASON_NOT_SPECIFIED;
+	reason = SKB_DROP_REASON_DEV_READY;
+	if (!netif_running(skb->dev))
+		goto bad_dev;
+
 	sd = &per_cpu(softnet_data, cpu);
 
 	backlog_lock_irq_save(sd, &flags);
-	if (!netif_running(skb->dev))
-		goto drop;
 	qlen = skb_queue_len(&sd->input_pkt_queue);
 	if (qlen <= READ_ONCE(net_hotdata.max_backlog) &&
 	    !skb_flow_limit(skb, qlen)) {
@@ -4817,10 +4818,10 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 	}
 	reason = SKB_DROP_REASON_CPU_BACKLOG;
 
-drop:
 	sd->dropped++;
 	backlog_unlock_irq_restore(sd, &flags);
 
+bad_dev:
 	dev_core_stats_rx_dropped_inc(skb->dev);
 	kfree_skb_reason(skb, reason);
 	return NET_RX_DROP;
-- 
2.44.0.478.gd926399ef9-goog


