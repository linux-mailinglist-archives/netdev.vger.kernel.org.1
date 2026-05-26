Return-Path: <netdev+bounces-291776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INIkIILEFWqxawcAu9opvQ
	(envelope-from <netdev+bounces-291776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:04:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ECF5D9447
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC9FB307679F
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BEF3955F5;
	Tue, 26 May 2026 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+wqfpLJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1523911C7;
	Tue, 26 May 2026 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811053; cv=none; b=ONusjjvlYwesGVBKZSlbKSJnyTK3s7fvyPxS7kgHeTdHYptSEwotNAvQadEcsOsDEjB/VD9WffcBGqAS27WPVWGGagMdUJJkmxP32xs2OiFe29UXsTItcr+3AI5+Tn+5zSDUPEL68J8Ufk+WU/h1UwXUY4IfY+BQZdqfPvBRrjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811053; c=relaxed/simple;
	bh=LpOshOD8CEJMPGynMo1OGhyuRPoGqSI3AU/juk3lci8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7J0DQtK7BvAYViJgeKOYj9Ggz1b9LiH+RGqlgoAG2PJRefE4jEt06VEYIZrG8cZgaU5c7Ev6HSBFvz2COWg0xlAkuaSh1HjxNiuogWxHhl8fTdVKoobrK7RuiAVG4p2uXc6P6g0x90CQIsupXZubwX8vPFogTiYOleA2ReTQ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+wqfpLJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0D81F00A3C;
	Tue, 26 May 2026 15:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811052;
	bh=mxKZ0V7pV9r4fW3zIDl0k6FOYnnqt4CWUpW8VmNe5Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L+wqfpLJh3+LMPA/21qCoDRHyrd0GCjlKgcYxYT8XryteMyL0aXxaqr5HZMh7vIhJ
	 RNwxvvPTWMD0pD3mARi7DmqJmEB5ElW88giyQrKWecgcv77cZXEwagWEgl4wEq/K+L
	 h2rCnEDma1tdtSkEgLG96dJWLrSFYCTda74w877eVbEc47SejFJC3gqF45DqwksgR/
	 auVdWI45uvcERZZlsldD/9bRXEInKQLzQJGwere2agzGHPUWG/+x0UrZndSs6Vhdg9
	 D9L+sMSLiD3+RODflocInTecyzuSO0xjIDoJhKHArR/paajVx1bjBZh6Xq0RhMv4QJ
	 m5yqA5FYi2Jfw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	corbet@lwn.net,
	tariqt@nvidia.com,
	dtatulea@nvidia.com,
	linux-doc@vger.kernel.org,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/4] docs: clarify page pool NAPI consumer requirement
Date: Tue, 26 May 2026 08:57:20 -0700
Message-ID: <20260526155722.2790742-3-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526155722.2790742-1-kuba@kernel.org>
References: <20260526155722.2790742-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-291776-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pp_params.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 41ECF5D9447
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The comment about requirements when to set the NAPI pointer
may not be super clear. Add more words.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/page_pool.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/page_pool.rst b/Documentation/networking/page_pool.rst
index 6e43e1953218..5409c68be3fc 100644
--- a/Documentation/networking/page_pool.rst
+++ b/Documentation/networking/page_pool.rst
@@ -48,13 +48,18 @@ genetlink family (see Documentation/netlink/specs/netdev.yaml).
 
 API interface
 =============
-The number of pools created **must** match the number of hardware queues
+The number of pools created **must** match the number of NAPI contexts / queues
 unless hardware restrictions make that impossible. This would otherwise beat the
 purpose of page pool, which is allocate pages fast from cache without locking.
 This lockless guarantee naturally comes from running under a NAPI softirq.
 The protection doesn't strictly have to be NAPI, any guarantee that allocating
 a page will cause no race conditions is enough.
 
+If ``params.napi`` is set, the NAPI instance must be the sole consumer
+context for pages allocated from the pool. In other words, when running in
+that NAPI context, the page pool may safely access consumer-side resources
+**without any additional locking**.
+
 .. kernel-doc:: net/core/page_pool.c
    :identifiers: page_pool_create
 
@@ -139,7 +144,7 @@ Registration
     pp_params.pool_size = DESC_NUM;
     pp_params.nid = NUMA_NO_NODE;
     pp_params.dev = priv->dev;
-    pp_params.napi = napi; /* only if locking is tied to NAPI */
+    pp_params.napi = napi; /* only if this NAPI is the sole consumer, see above */
     pp_params.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
     page_pool = page_pool_create(&pp_params);
 
-- 
2.54.0


