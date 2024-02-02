Return-Path: <netdev+bounces-68628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A644847665
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFAA1F2177C
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFD21509A2;
	Fri,  2 Feb 2024 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MX89aI6u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E6D14C584
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895633; cv=none; b=YPMsFoFckXijnpEerlIJAYdKbcuOy1s6o+IPuokKst0CKq5xq4sf6ug6RdX8vZP2VX3hrZvnvi3F1XzSBBu4HxBaPkisB3nfsqPtgOVID4P6kLyNIAuMcgz+M1dec5s+bEn/sMLULQGp/aeqLo3cCCxFiAcNFV2i6nJ5m0FWNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895633; c=relaxed/simple;
	bh=4zrgDxfQyQr/MMxBX+zy4rapi5D5t+FXILJZ6E/m2l0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bnqt98ACAP0qa86gbpxaaYAH2oKiHoxL905s/45KEtsaA4r9NtaVuMPjLxxDuuX1fZbA7dKdL6cugVpJm5YzVnu8q28z04dXtE1Fcae9x83YEMEv4LXd5rbDQQFo8ATsoqjpvzIUUBQzm/wgfnEpbPHoPzGSKiOhpgka5DDk+ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MX89aI6u; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-78319f64126so280082285a.3
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 09:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706895630; x=1707500430; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ucrSInxhM/tToihWu9krdoEfDlDiN1lPApGKi5+rQ0I=;
        b=MX89aI6uK2NKKj6J+85++YYsENegQ2pObBXfzUpmLIg6JLp+6nnGAiB+5Tvf0iXWTW
         ZuMN2FfFOVm8waP9SOdbcbPnMSj0fXgtx0ZMLe3aNZtMwGflbNGKdFfDxMG8v5zDqNSG
         hCTcB2uMk3PZ2TlTQwGHNDfyyc31SS5GlVM+mp9J15p8n9k2WHYGAEYJgoUuKbExcJwV
         q4Wl801nGLII+nX/IErKrLtYXxSsN0gVg1kkaIFzKl8cajZcF1n44AcWHLjl/wD3/S9z
         iAB6DVHgabq5RhWyKREpfnpxVH0QGv0zAMwSR48LduppWtSbB4SDnYf79ewlMLXX05S0
         ixmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895630; x=1707500430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ucrSInxhM/tToihWu9krdoEfDlDiN1lPApGKi5+rQ0I=;
        b=uuo5JT4vK/ku2tIUci1S+7v8G9RLqKUUNK/pa8JLjWumY2yf61+etPoYEFC0ggclYG
         L8b0yIQQmcjDqj8kYS2OfqXU8QR5P3nL0L0VSTZlGEosF7G1vPqYSKM7s99xvag/A9bK
         /S6mQ5SNYw7kp0C8AiXm2h+KrQM6fHzLKmBr4JXm2JKuocqyC9aMcYiCrE7uvP2fmRWh
         rCg9x6kIQya23x59+rEDfPgaxbgj3g40v5GV5ggp2NKax0ROryNFZHwnRabYb4QQ2u5Y
         w8g3RVpfaKrPOEdmieuZpWZWzka8X/gUXH55Lo13+Hq7LKw32ewfhFbZT5Zthhr6YA1M
         pwAA==
X-Gm-Message-State: AOJu0Yydx389OLkO49y5yRP7JAc6OtPe35p3t4FxiOExjqNbNT11MNLt
	VFKFvUAf+KHB4dC5kDaRteJzgQ0Nj3wdrgkbu3B2m3NcRmKrSeYbop5fY2LYiWHglkmX6QMrrAg
	KD+Idk4jZgA==
X-Google-Smtp-Source: AGHT+IGDoLwt0QflV+hGBF9dRYP0ZEUkGts13SlMFYAmuNAz8yLeknnpDprk3cc4QjWuBrQSnIEdKBkQ9WdA+A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:4011:b0:784:92d:6d5e with SMTP
 id h17-20020a05620a401100b00784092d6d5emr31934qko.15.1706895630119; Fri, 02
 Feb 2024 09:40:30 -0800 (PST)
Date: Fri,  2 Feb 2024 17:40:00 +0000
In-Reply-To: <20240202174001.3328528-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202174001.3328528-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202174001.3328528-16-edumazet@google.com>
Subject: [PATCH v2 net-next 15/16] bridge: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair per netns
and one unregister_netdevice_many() call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bridge/br.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index ac19b797dbece972f236211b9b286c298315df25..2cab878e0a39c99c10952be7d5c732a40c754655 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -356,26 +356,21 @@ void br_opt_toggle(struct net_bridge *br, enum net_bridge_opts opt, bool on)
 		clear_bit(opt, &br->options);
 }
 
-static void __net_exit br_net_exit_batch(struct list_head *net_list)
+static void __net_exit br_net_exit_batch_rtnl(struct list_head *net_list,
+					      struct list_head *dev_to_kill)
 {
 	struct net_device *dev;
 	struct net *net;
-	LIST_HEAD(list);
-
-	rtnl_lock();
 
+	ASSERT_RTNL();
 	list_for_each_entry(net, net_list, exit_list)
 		for_each_netdev(net, dev)
 			if (netif_is_bridge_master(dev))
-				br_dev_delete(dev, &list);
-
-	unregister_netdevice_many(&list);
-
-	rtnl_unlock();
+				br_dev_delete(dev, dev_to_kill);
 }
 
 static struct pernet_operations br_net_ops = {
-	.exit_batch	= br_net_exit_batch,
+	.exit_batch_rtnl = br_net_exit_batch_rtnl,
 };
 
 static const struct stp_proto br_stp_proto = {
-- 
2.43.0.594.gd9cf4e227d-goog


