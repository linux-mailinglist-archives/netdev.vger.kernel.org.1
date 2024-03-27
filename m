Return-Path: <netdev+bounces-82651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1C888EF04
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 20:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD1D729F886
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 19:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C154A131E54;
	Wed, 27 Mar 2024 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQ8HGiPr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE7214F9F6
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566730; cv=none; b=lNAzfyH2Yyz6CauXClpG2M2pegO3KC2Hi3vZFhfpEjxNATyeGAQcK2fuEbiERVWDJeu4J44Li6TsEhQLt27RB0jHS3Ig2GWgXKjX3Rj6CYNlvpgjhYFQEZzqq1x/6e3kD8ePk674J1cLI4s8EpNxWOEdJMJ6a+1TP8GWQL9xadc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566730; c=relaxed/simple;
	bh=P8CcbCtPEKX5DVMu8IcqRKCmdxwtfwyxG5EVy0LARuo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qq6BQ/gaP5x2guiV2t+PJz/VyxvfKiIwgwLFjvuujDSewStYivSBln7sjbcFVt0XIF/birPDREmUPvX02F9GkbYGqc0Xmxeqey5ibU6AgYilf/2JuPBvvCIO1Mm56yXfq2PmrCmlG6pEMfTTMty0vATZgyNYL6Epb4Ecqi0N7MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uQ8HGiPr; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a61b31993so3218167b3.1
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 12:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711566728; x=1712171528; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5j8FX0L+UPteWKf09uX1NCGacX18nAOhhO/u6xqP5EU=;
        b=uQ8HGiPrytSng9ZRRJXv8SiYeAfkf0uy+pYqKlfeQ40hWtgYb7kqZuS/DUBvVoIyT8
         s4t1BbwNUQqBGGMu0GlhV/9vZ/T+b8q3Z5Nj5MnefU0d5IKZDBVjphNa9hQyvV3XPAnu
         qfi2x5/2SdBy+dixyRGMJbvbHeYLjHV9Y7QaBOEAk8kml+HuVYifUlkb0x4YtW418DLK
         XEcoq4rAdnNR8NrZc/HQovtRkAnHLVV5jF6x8rzlfqn/+2Ym6GfvO3/p0Ej1vZl7wy/E
         zM9OhgWA65fhrIm2B7eQ1QSYKbp7HenJwfJxOkV5U27k7PE0xRSSKg+s5qmRB7S7dAZd
         Rlug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711566728; x=1712171528;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5j8FX0L+UPteWKf09uX1NCGacX18nAOhhO/u6xqP5EU=;
        b=nRzNxz2NvE4fJ53bNMlgJiPson/luv6uRchQ8OCP/h2napXWGQVO6Uj7Pr3BTCHmlH
         93obbuVeox6D+6eXXO8EQ7f4RoY9De06hL4ONgZe/MrwU+1bM4GhBV0B0LVVF12g09IB
         2EiLwFaag7qajykQ8hWUgMb/19UU55Y9N53a/orpRVxf0TByiB3kiEyPdtcn6nhU+kqA
         D6L1HzX775Ox3tQ/ofDrQt8OWInLp5mAJivD9N5+BYmwTb0hosE8ryMatR/Zyu23T//s
         S2vgb+rd8OklBbCp4jecOT8nMGNxvioQHImsgt3LTkiZw3UwRwdMNI4jD4/4auZnh7Kl
         gzGQ==
X-Gm-Message-State: AOJu0Yxk0V9OY7cpwZEnNBoJQGCVII1k8HG9e6lRsd4leSTjN54kh3x0
	DdMaLL+6rhmgVlo387qBlZ8tvvb733cSoC74VkNdqBo5nN7GiPUIIT7xYy+DlZ5KEfmdO+ZbhWU
	LDUVE8nNApA==
X-Google-Smtp-Source: AGHT+IGv1o1IlMwkUfNp+YxL3r3ukvdF3cl8XVYkaFMhhSTqjt6Hz7X5lAcDPrNX019HQLUGwNi/zO2TIZxiXQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:df41:0:b0:60a:3d7e:2b98 with SMTP id
 i62-20020a0ddf41000000b0060a3d7e2b98mr135621ywe.4.1711566728156; Wed, 27 Mar
 2024 12:12:08 -0700 (PDT)
Date: Wed, 27 Mar 2024 19:12:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327191206.508114-1-edumazet@google.com>
Subject: [PATCH net-next] tcp/dccp: bypass empty buckets in inet_twsk_purge()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

TCP ehash table is often sparsely populated.

inet_twsk_purge() spends too much time calling cond_resched().

This patch can reduce time spent in inet_twsk_purge() by 20x.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_timewait_sock.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index e8de45d34d56a507a4bdcceaccbd5707692b6c0a..b0cc07d9a568c5dc52bd29729862bcb03e5d595d 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -266,12 +266,17 @@ EXPORT_SYMBOL_GPL(__inet_twsk_schedule);
 /* Remove all non full sockets (TIME_WAIT and NEW_SYN_RECV) for dead netns */
 void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
 {
+	struct inet_ehash_bucket *head = &hashinfo->ehash[0];
+	unsigned int ehash_mask = hashinfo->ehash_mask;
 	struct hlist_nulls_node *node;
 	unsigned int slot;
 	struct sock *sk;
 
-	for (slot = 0; slot <= hashinfo->ehash_mask; slot++) {
-		struct inet_ehash_bucket *head = &hashinfo->ehash[slot];
+	for (slot = 0; slot <= ehash_mask; slot++, head++) {
+
+		if (hlist_nulls_empty(&head->chain))
+			continue;
+
 restart_rcu:
 		cond_resched();
 		rcu_read_lock();
-- 
2.44.0.396.g6e790dbe36-goog


