Return-Path: <netdev+bounces-303536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DxCQJpXNRGqR1AoAu9opvQ
	(envelope-from <netdev+bounces-303536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:19:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9386EB063
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:19:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QfeAAHJ7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303536-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303536-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C1A6303FB9F
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 08:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7193DB322;
	Wed,  1 Jul 2026 08:16:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5016F3D301A
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 08:16:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893779; cv=none; b=UXTKqrvgYNXblI+0b39KjRjhF952in31GPfysDcb44C7o4Elpq1TAA7K4YCq9kzz4Lm7eNTsjznlKpPj4bN2lHpcQBvoM1o3CYieE9FWZyJzMPSbbstvbhECVelnYFl57721wKpqfEHaNU9Jpz4LvnEueOmWWk+x4ovnnLTFnpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893779; c=relaxed/simple;
	bh=fyGt+jc0oNFM66yYaLF0Z5hcoJwFRhon7H7nHQ471Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3gBirTx4mUMxx+U1tWLlA9XmP1GJQwUwQacsKiNM/RZSREr6QxzWz8ilkT3ylSSADNksRyXSY0aT8mnr/S11TfdUAMA9aXfBYTAn5C6/FYfSydCjYp2EmRXq3dSZJ64HQa6LqvcHttTTz1YOxcJcIXN61LQd4p5VetoipZ95OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfeAAHJ7; arc=none smtp.client-ip=209.85.216.50
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-37e1607f7faso226812a91.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 01:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782893776; x=1783498576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wY5L1SkTbcuC0ovvgAOdSZ2ZO/9WR1lWjpj1amt2bl0=;
        b=QfeAAHJ7NMbK2bl/m94Dg/7fkks782SjWku1iD7sd9bmpLCC5cXczylP8F1fJr2zDJ
         U4UzfI97TPEEZNSuwwkcH/HngFuCIze1ckm3N4rXfY4z7VDT1BM4eFRl49RoynVQAiH0
         WdyIthnokvwOqGcGYUYXsnZ7jVP82b2Akz0+MgXty68h1kez79u6APZIsrltgBqgBIL0
         JKPWC2Ds26jm3BTgXjJf4YXi2LV5F1K4jziJxP6LDzfpOELyBnG+xAwFvKrazCXRr2Hr
         fcNA28rsyf8mGUiF+o5phlemakuDIz+uOIrbkwCRu+PsmfISlC2z6RiRkkqKoibz2yKD
         BiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782893776; x=1783498576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wY5L1SkTbcuC0ovvgAOdSZ2ZO/9WR1lWjpj1amt2bl0=;
        b=TRg8fWE4eHNKOWjEalJ6YlS5XXTBCnU4bD3ngcPyOQ/kOJMecMTgqdAfh754PW8rtJ
         nooSfF4gzqYkSLnvmD91mW1YSa9fCffAqozaGZjo0hgt8atgb4UsLzI0pN8Pm6KgHtYU
         7hWExsGK5GOZLjSyidf11mwVV3koXX82mlCv43vAEVTaIDGiCbNrbN8IphqkZFs/ymEq
         hVtihBLvZOinuJaPeewsLBniATh6TP6UIhXOwHx/jO44k+y5HCEsh38aXxQDbkpXPrnM
         epAhfiZPzC+8DEscRBgcmKhr4MlQXd/91CILCAHJeksV2DUQkZy/uArDYojWp7wDVkRK
         qMbw==
X-Gm-Message-State: AOJu0Yykgc+xeUDDIGOsUQP1tQV48COJcvs5rVD3FAdAFZBMHfOgQqKO
	HfhKWdSs8/jDtnI7sxCYWKc0uFN9OTdNyiC7geS/iB4OQKt4BJW0gtEcHXKdSrpn
X-Gm-Gg: AfdE7cnltqCWb0y7q5uqo0YGuHaSz/iQ8TDJwLbCFz/SoMUWWc7SBdGY6kWGGxzwHNp
	JyHGdV7/3y5wx4iTMqCYcYyTrT7OxYiNpsHPdMIBZ1YLPVv7Bbc8aRu2c8kijXTlQzcHwqESku+
	CP2+HSfakLPkMnBN+zaeVI4yJRe14AqhB/cNIeIY2azxfdwf9e5fiyO5XyiPUat/I9eDjtqkjSc
	LPQZYHKc6yHQ0EMy2suSm0niM9kKpLoHfErvoHbTpdcC03rdNgvVDpL66UegdrJegjsGnlruFJJ
	qAlXnAkiGliw2yKakGzTOGpjaddrEPknmYURYm1kfvqmDEl/FRQbDuuZ5q8qNbiuxwu6P7n47DY
	nt9tEws5/7OWUjAMWdzUmgbwZUdn7K1KbfY6TekF5GoxBxo8zK3piFn4MiK11x6cTIOCfckQRPe
	QaZYQRVJa9e3FH7H8Sc/F+61OVanw=
X-Received: by 2002:a17:90b:4fd2:b0:37e:a09:2640 with SMTP id 98e67ed59e1d1-380aa0fd3e9mr706679a91.7.1782893776546;
        Wed, 01 Jul 2026 01:16:16 -0700 (PDT)
Received: from amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3809641c894sm1364627a91.11.2026.07.01.01.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 01:16:15 -0700 (PDT)
From: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
X-Google-Original-From: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Paritosh Potukuchi <paritosh.potukuchi@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Subject: [PATCH v2 1/2] net: neighbour: add neigh_parms_lookup_dev() helper
Date: Wed,  1 Jul 2026 08:15:59 +0000
Message-ID: <20260701081602.3185086-2-paritosh.potukuchi@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701081602.3185086-1-paritosh.potukuchi@amd.com>
References: <20260701081602.3185086-1-paritosh.potukuchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-303536-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:paritosh.potukuchi@amd.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:idosch@nvidia.com,m:petrm@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[paritoshpotukuchi@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[paritoshpotukuchi@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:mid,amd.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C9386EB063

Provide a helper to lookup neigh_parms associated
with a given (neigh_table, net_device) pair.

The existing lookup_neigh_parms() helper is internal to the
neighbour subsystem and cannot be used by other subsystems.
Some stacked/virtual devices like bond require access to the
underlying device's neigh_parms.

neigh_parms_lookup_dev() is designed to be a wrapper around
lookup_neigh_parms(). The function provides controlled access
to per device neigh_parms.

The caller is expected to hold rcu_read_lock().

This does not break any existing functionality.

Signed-off-by: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
---
 include/net/neighbour.h | 2 ++
 net/core/neighbour.c    | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 8860cc2175fc..1b3b06eda886 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -438,6 +438,8 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
 			  proc_handler *proc_handler);
 void neigh_sysctl_unregister(struct neigh_parms *p);
 
+struct neigh_parms *neigh_parms_lookup_dev(struct neigh_table *tbl, struct net_device *dev);
+
 static inline void __neigh_parms_put(struct neigh_parms *parms)
 {
 	refcount_dec(&parms->refcnt);
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 1349c0eedb64..6d32c2668af3 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1757,6 +1757,14 @@ static inline struct neigh_parms *lookup_neigh_parms(struct neigh_table *tbl,
 	return NULL;
 }
 
+/* Caller must hold rcu_read_lock()*/
+
+struct neigh_parms *neigh_parms_lookup_dev(struct neigh_table *tbl, struct net_device *dev)
+{
+	return lookup_neigh_parms(tbl, dev_net(dev), dev->ifindex);
+}
+EXPORT_SYMBOL(neigh_parms_lookup_dev);
+
 struct neigh_parms *neigh_parms_alloc(struct net_device *dev,
 				      struct neigh_table *tbl)
 {
-- 
2.43.0


