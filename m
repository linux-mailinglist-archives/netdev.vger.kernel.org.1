Return-Path: <netdev+bounces-83361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6508920AF
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5241C27EE8
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7DA1C0DF3;
	Fri, 29 Mar 2024 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ARmsfNVv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89081C0DCF
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726954; cv=none; b=dIZxBaFkYS5hDTIEJD8xvhsZy+Ma7t7afF7+bbtME4WnWLg7x1UgSjhsOK6EP5hKSUKb8PY5LY99hcvkuaX9w7z4mSok6sOLiApoEAH3W53j8gBXtUy1ahc8IW438qCSHykTbMsEZRVCpLpiI8cJM6UR4x9GdUNX1p+xZpxXUP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726954; c=relaxed/simple;
	bh=kA41VnKBM5QkuJWHFLJdysv5A55/K/SIu0cl2mwOaHM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C0w8Cs3rKvUQWCzMTgWxYk05nlpsDv7GLcVwXU1Hd8CJXKfwu2CveGWP8dOCLDfUg7gQPKM2Ourhm/mSpfNyIxv2ORG+ONFtvvXyWUmL2Z9V8fc7XdUX2R70HfdqHayjWlwP6qrwwJOJak/ULbtDh7SQnf0+mQ+AUCW+oesc6b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ARmsfNVv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cbba6fa0bso38253857b3.3
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 08:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711726952; x=1712331752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLMqQ3fdvniunS4oceCdUDaRaaFXRuKKKp9GbMATOUk=;
        b=ARmsfNVvG9fnf08FiKmiMH9CCbNj5PcR+JORvkPkWMoqrOsGv3A6cj6cIOdoF+oxDG
         8KpuYWTOEg8LbG9iEObL+ZzwR2tSGYF5ZFKfKsEAxg30T16CiZOCa5FbMSRoXV10yTaE
         AfzqrLy0unhk6l5k5bkcbvJwAN/Efs1TYA+i7TqpZk1eYFNTSzy2BFHn6YC2JJhWNGEW
         Hy5BEesxZ6pki/bW1xoPHYlKsdMHtmo1erxsSjBW8DXilWk/cM9BoFHO5O9STOQr9jtH
         VBUaQzpO755TJ03j9acSOx/+BlznGUfmKFDBWmtNIZmxCMoLj+kKVULtPSXLSSMWjqS7
         7Juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711726952; x=1712331752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLMqQ3fdvniunS4oceCdUDaRaaFXRuKKKp9GbMATOUk=;
        b=qRDQdrGh04tY1+RJNwNURx43H7Fgb3B4V+Av7tq4Pl366ziOdspaGWmaNIsdbIddX3
         poQhFnvDqfVCUz8WwAo7DCe6WNuYJIlit20H2AQMJtVRkPQxd/xaygWQFudS/hxCmCiB
         +JgDnExC2QvENy0kPn9hc24buIzRohmEXn4to8ithxFJqIsz3URfjP+8/w7c/Qu1mvhd
         YH4ORURSysbNaKd6tc/URIQ4/GW9RQadBi71BxB48kqCNhu06xmRmYbmbJCvsdZvY69/
         UB729WPsBHhPo9dZB4CxOU1L24yZYAmgNa8k1XXUBAM9AKpqKfImyc5UDRercN2D2PQz
         tnpg==
X-Gm-Message-State: AOJu0Yy4CEpIecEXHTzPv3QvyY1Wn0d3V3ZfzXyz9jK6v8DCmz5FULnD
	bhjBTXgHkOvrSf81FRoBvPy2AhU1nZMXydacHfmlc6/SOAXxUwdxsjao8R8hWeKnNur6uKRAsAO
	3LjGdzStGrA==
X-Google-Smtp-Source: AGHT+IHjtDW0RzTV+E7nqcUcfFxFk0xs8rqTJEbto8bdPcnmWICXSOPYST3HBnsOX/qDFx0Z1Pjc5Orwj3oW/g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1002:b0:dc9:5ef8:2b2d with SMTP
 id w2-20020a056902100200b00dc95ef82b2dmr742106ybt.4.1711726951947; Fri, 29
 Mar 2024 08:42:31 -0700 (PDT)
Date: Fri, 29 Mar 2024 15:42:20 +0000
In-Reply-To: <20240329154225.349288-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329154225.349288-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329154225.349288-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/8] net: enqueue_to_backlog() change vs not
 running device
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
index c136e80dea6182faac153f0cc4149bf8698b6676..4ad7836365e68f700b26dba2c50515a8c18329cf 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4801,12 +4801,13 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
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
@@ -4827,10 +4828,10 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
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


