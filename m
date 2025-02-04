Return-Path: <netdev+bounces-162594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9390A274D0
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A68F87A453D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142F8213E93;
	Tue,  4 Feb 2025 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Axj8j42f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631032139B6
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680510; cv=none; b=fV2PljOjCwyyZvid8Kx+clQydE2tFVRTP2ObxS0ApvfEzXETp79A0OPP15GDoU0sUKPkw7OZ/bJpwww/6weKxVb/hlTTQusqcq1swBDp5l6WT9v7ENd1858j6TK0jLGYpM+YwuUqaITPhrXp21IvOaLa4BdkYY/sIXSsyiY1r5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680510; c=relaxed/simple;
	bh=ElpwuvjwZuyJfH9rcvKItdiXC98NPbp1PaosnGP9CeA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KCkqI8kH3ghtwc5Xc6QUZESx7sMyI0K/AkmO5NMntqIPVjld9RztLhChS758i1AKd+iM4wvuiDASPZJh3b8UTOC2Th+q3BqbI8QihiGZboO7YL0d6i636yJJ09CD0cEugv9bKR3Mc9yrMwh1+pLb+lynG+8k7UVobo+G1PbwDgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Axj8j42f; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6e4215a7c5aso18215126d6.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 06:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738680507; x=1739285307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZJ1qdiXb0TcZUWOs5jGcGtuQYCNU8AHiosg1p3qP2cg=;
        b=Axj8j42fITijBeDfaSAu8dQNxrAXV4/ItVNPcqGZkAmbOnUzUC0ivDH1LvGv4ILrgR
         XWax/6YDqPOxFTIrcummMcLfh5I1UkfE4Vbe/b4S6CHcVnFx592wO69d+qtG8on8khSK
         i5bK7ywhPG4cFSS5fSbjx988NNkf6EaT2xDQfG77RIp/tuZzkCwgGBhOfE0uc/5TPga0
         b0lFjSYHXW6xSAIocmRcIavcFlQuMG+pAF9ydW+FbI+LyAA8yR2VmaLXRjQymOL3pZl4
         ZyuefzBryRIJLBnGpWoCVVVonzzhWv9OyYck7mJDwUDkGB/DMi2vrcjN0x0efJ4P8co5
         Vy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738680507; x=1739285307;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ1qdiXb0TcZUWOs5jGcGtuQYCNU8AHiosg1p3qP2cg=;
        b=hgtGV6/w8ChrUMYrMUI+GZ95++GUrqG04HOzRys3rOFdZMXSfyr4OZdLN7mf0bIeVC
         pMTcZwnuiRtSMsADlIBYkabpqJT5x7Awz/W7cyyXD5vefajXbVX9QsiQL7R7JEMNF8qa
         LgS4G5Pud0OU3ERLOtpB4Zy/I3d2JN+atSblW7a7Ijx66xkce/mje5BFC/sO8Ggk3wDx
         Xj666JOKaRzwoAUf8MauNXktz2GyDHKCJUo8nuCZmUuCw+H3pP2XZ00s6jueVQy4/bb9
         6PTE/R0jydka4Afeq6f1bjHXcKpB2P/vSU3BpX376YieLPMSQAOxFwVlquBj7zKnf8ys
         Cy4w==
X-Gm-Message-State: AOJu0Yy1FlXywEpXEfYfRk3dTPVC0B0eEwMJgq1Iuggg1tJlzB9q5ytt
	N4UJ3UvSalJhU+uPeIjmagDaBQ/rBL8B4p39r9OCU/Jj6SMAGvGcaHCh0kG4Une2vzuvw0p9+kV
	HpmFDbfURWQ==
X-Google-Smtp-Source: AGHT+IGxVJqFvT7ipy2H7nB0AZTnc/u/mtKOKxsImue4Sn7tIzDRK2lX9iA3HinEDFpIhbaXKAyvyn6tD0PGxg==
X-Received: from qvbmf17.prod.google.com ([2002:a05:6214:5d91:b0:6dd:d513:6126])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:1d22:b0:6d8:a70d:5e43 with SMTP id 6a1803df08f44-6e243c9bc6cmr396615476d6.35.1738680507283;
 Tue, 04 Feb 2025 06:48:27 -0800 (PST)
Date: Tue,  4 Feb 2025 14:48:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204144825.316785-1-edumazet@google.com>
Subject: [PATCH net-next] net: flush_backlog() small changes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add READ_ONCE() around reads of skb->dev->reg_state, because
this field can be changed from other threads/cpus.

Instead of calling dev_kfree_skb_irq() and kfree_skb()
while interrupts are masked and locks held,
use a temporary list and use __skb_queue_purge_reason()

Use SKB_DROP_REASON_DEV_READY drop reason to better
describe why these skbs are dropped.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c0021cbd28fc11e4c4eb6184d98a2505fa674871..cd31e78a7d8a2229e3dc17d08bb638f862148823 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6119,16 +6119,18 @@ EXPORT_SYMBOL(netif_receive_skb_list);
 static void flush_backlog(struct work_struct *work)
 {
 	struct sk_buff *skb, *tmp;
+	struct sk_buff_head list;
 	struct softnet_data *sd;
 
+	__skb_queue_head_init(&list);
 	local_bh_disable();
 	sd = this_cpu_ptr(&softnet_data);
 
 	backlog_lock_irq_disable(sd);
 	skb_queue_walk_safe(&sd->input_pkt_queue, skb, tmp) {
-		if (skb->dev->reg_state == NETREG_UNREGISTERING) {
+		if (READ_ONCE(skb->dev->reg_state) == NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->input_pkt_queue);
-			dev_kfree_skb_irq(skb);
+			__skb_queue_tail(&list, skb);
 			rps_input_queue_head_incr(sd);
 		}
 	}
@@ -6136,14 +6138,16 @@ static void flush_backlog(struct work_struct *work)
 
 	local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
 	skb_queue_walk_safe(&sd->process_queue, skb, tmp) {
-		if (skb->dev->reg_state == NETREG_UNREGISTERING) {
+		if (READ_ONCE(skb->dev->reg_state) == NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->process_queue);
-			kfree_skb(skb);
+			__skb_queue_tail(&list, skb);
 			rps_input_queue_head_incr(sd);
 		}
 	}
 	local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
 	local_bh_enable();
+
+	__skb_queue_purge_reason(&list, SKB_DROP_REASON_DEV_READY);
 }
 
 static bool flush_required(int cpu)
-- 
2.48.1.362.g079036d154-goog


