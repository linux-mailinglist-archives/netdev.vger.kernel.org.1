Return-Path: <netdev+bounces-69904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EE684CF47
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EDC31F21476
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD23A81ABA;
	Wed,  7 Feb 2024 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mf1zCb1l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C98A81ACA
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324802; cv=none; b=ZltI9D694W3+tfzweU6axlb+OyqfBAItoV2pyrnv0/Wc5udnJTWKpQMWrK2pZxqG+jkkOXpRVqZaKabcyB2TwvBLy3KB/a11zZpE+PzPQTb3J1Ca1QLlNELiQ0Q98LjWoY9yHrYTNOGhH5pqaFkziE9uLkoIPqJCTKZo+lv9FnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324802; c=relaxed/simple;
	bh=nniEyp51numRXzwgSo9jtvblmB2pDQQQWqNLfs9PuNg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZTRqsHraaqhieLVrVSkasIJSwqM2C5/n0GRoxrhG84l91Tvv3Yvhvr2eTfAAx+X7Ue+nkb5pUximxrXysEqD9ngWex8j70eurEKS8qOEoasn9f8Td5lGFecwPS5tNtLE4L8w/4G926v2Usp5qMy33tsig5lgCWJC4uxQtHJMEas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mf1zCb1l; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60482420605so12856587b3.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 08:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707324800; x=1707929600; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OQwsGHnAOsxjxCglzesNlQeIVYyP+vXuetGLb+2OAMM=;
        b=mf1zCb1lFOi/u5OAO7BMTiw8gwDoQaurN7mjUrn0pZpvqTu7GfKdY9dLCFpctER0aB
         qSAM5ES9h+eDrRKtpz0uxJ3mTpHz2lYeGdmrFsMlCXttuflWyYigstNqE4nl5BOz8s9S
         ABaAlGnOw7GRF+wpe5x0UZlvzpHUTpqzCfs387cC6tXlWQ1Ti6GKtcIKq+O/gV1Gie96
         Y6FDFScZSdnarpJQz7NJET1BmwVce3mS45H0xKAmL45RXeR0n72cgtvz+4i9ovh/d1cO
         4VZcaDzSEfR/LWlr0edKGnLJGfz6qetNp+ohV0+oTUFlBnkO78eowFR5JYDdzUz5HTxV
         Ee+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324800; x=1707929600;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OQwsGHnAOsxjxCglzesNlQeIVYyP+vXuetGLb+2OAMM=;
        b=RBDOPQmORU2meVxnyU/RrRIXK3gTRRqyx/QEQcFL34P+Y4/THvL7YM5wKV652DOKt4
         qE5ZfaskJHxVk/FP6VGfqg2QuCyI+MDOxbEaWEtljzpwcFSaCKZvU/hY76cIjMn9AJ81
         63LqlVG/QYFUnvldB/yqu8fs8M3j5DM3P6AOF9y1ifA6dbMXVXo3yF2D/pbfEsSu0N4c
         JYH1BfZD+J98lghd80GU4aYWYZAF87GYXb6haXV8y4mG1ym1FLZtNSzu7ZWPchzLEvq0
         vSZrQVeH5YEfDfsYo+A+7+fOnFLas+mVfogBf8tidqHAUcgLo6YrA1uk2yp0kK4AOimO
         q1Eg==
X-Gm-Message-State: AOJu0Yz35yTCnmsQjJO/gqFVJp/x0qcW/AQ/aUUxK7PR0qyfLJkc/QKm
	6lVyUs9WbWBd+imZU0htqA2ucth+iwGOnJbVVkAR7ZYHiobv3MWNZEq8DLy6dBANANwYXZHGXy8
	/Q5k8EvL50Q==
X-Google-Smtp-Source: AGHT+IHyaM9YW3DldausWFTen1mvuJSkRt1C3NGOVr7ibU9w5eQMvhJ0koPm4R+c225ZtC1EO4Kl1KW1LJUUJg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1b89:b0:dc6:d9eb:6422 with SMTP
 id ei9-20020a0569021b8900b00dc6d9eb6422mr223167ybb.10.1707324800183; Wed, 07
 Feb 2024 08:53:20 -0800 (PST)
Date: Wed,  7 Feb 2024 16:53:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207165318.3814525-1-edumazet@google.com>
Subject: [PATCH net-next] net-procfs: use xarray iterator to implement /proc/net/dev
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In commit 759ab1edb56c ("net: store netdevs in an xarray")
Jakub added net->dev_by_index to map ifindex to netdevices.

We can get rid of the old hash table (net->dev_index_head),
one patch at a time, if performance is acceptable.

This patch removes unpleasant code to something more readable.

As a bonus, /proc/net/dev gets netdevices sorted by their ifindex.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/net-procfs.c | 48 +++++++------------------------------------
 1 file changed, 7 insertions(+), 41 deletions(-)

diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
index 09f7ed1a04e8ab881e461971e919728641927252..2e4e96d30ee1a7a51e49587378aab47aed1290da 100644
--- a/net/core/net-procfs.c
+++ b/net/core/net-procfs.c
@@ -6,49 +6,18 @@
 
 #include "dev.h"
 
-#define BUCKET_SPACE (32 - NETDEV_HASHBITS - 1)
-
-#define get_bucket(x) ((x) >> BUCKET_SPACE)
-#define get_offset(x) ((x) & ((1 << BUCKET_SPACE) - 1))
-#define set_bucket_offset(b, o) ((b) << BUCKET_SPACE | (o))
-
-static inline struct net_device *dev_from_same_bucket(struct seq_file *seq, loff_t *pos)
+static void *dev_seq_from_index(struct seq_file *seq, loff_t *pos)
 {
-	struct net *net = seq_file_net(seq);
+	unsigned long ifindex = *pos;
 	struct net_device *dev;
-	struct hlist_head *h;
-	unsigned int count = 0, offset = get_offset(*pos);
 
-	h = &net->dev_index_head[get_bucket(*pos)];
-	hlist_for_each_entry_rcu(dev, h, index_hlist) {
-		if (++count == offset)
-			return dev;
+	for_each_netdev_dump(seq_file_net(seq), dev, ifindex) {
+		*pos = dev->ifindex;
+		return dev;
 	}
-
-	return NULL;
-}
-
-static inline struct net_device *dev_from_bucket(struct seq_file *seq, loff_t *pos)
-{
-	struct net_device *dev;
-	unsigned int bucket;
-
-	do {
-		dev = dev_from_same_bucket(seq, pos);
-		if (dev)
-			return dev;
-
-		bucket = get_bucket(*pos) + 1;
-		*pos = set_bucket_offset(bucket, 1);
-	} while (bucket < NETDEV_HASHENTRIES);
-
 	return NULL;
 }
 
-/*
- *	This is invoked by the /proc filesystem handler to display a device
- *	in detail.
- */
 static void *dev_seq_start(struct seq_file *seq, loff_t *pos)
 	__acquires(RCU)
 {
@@ -56,16 +25,13 @@ static void *dev_seq_start(struct seq_file *seq, loff_t *pos)
 	if (!*pos)
 		return SEQ_START_TOKEN;
 
-	if (get_bucket(*pos) >= NETDEV_HASHENTRIES)
-		return NULL;
-
-	return dev_from_bucket(seq, pos);
+	return dev_seq_from_index(seq, pos);
 }
 
 static void *dev_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	++*pos;
-	return dev_from_bucket(seq, pos);
+	return dev_seq_from_index(seq, pos);
 }
 
 static void dev_seq_stop(struct seq_file *seq, void *v)
-- 
2.43.0.594.gd9cf4e227d-goog


