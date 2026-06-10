Return-Path: <netdev+bounces-297664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IkoAN2lcKWq1VgMAu9opvQ
	(envelope-from <netdev+bounces-297664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:45:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E74166965B
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:45:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dqpSNu7n;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297664-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297664-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C93763280AD1
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4EC405C4E;
	Wed, 10 Jun 2026 12:40:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30CA408010
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:40:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095227; cv=none; b=MqsjORxgfVpr4Pgf33n6xjRvJ5FSZv6ArhLvkJvUYONGx9k/lNp1LUJ0SmAe6ftcSUA4pS19G/5x1T6v0DI6KJxmEGjJAG/+ekrNi4Jm6itBEMixUaA0I/OwBWj3WF790IjS0KNz4J2gDytrssd3p2kVTR85o5grb5QCPE3BJI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095227; c=relaxed/simple;
	bh=3lbic6BKuHrKV44Tl4lVOFTZZtQZ8lsERUz5T+f5Z9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYOfAS43elk80taHmHsPy8ILCfgzRwow0QEXrA674LcFVq7yP4QeOe/aZN3txpIMwUWKsqGTMXKYGgQaoM7257w0AVr72gsTJc+c2TyuONItvlX8TzgtVXVEPtBNzPCg8Kl2/4Qi9r3/qu0DniIerXcrfqikwNPXoC/t0qAzwHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqpSNu7n; arc=none smtp.client-ip=209.85.222.175
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-915d17e2721so404042285a.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 05:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095212; x=1781700012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=An/axLWUDL0c+TuA+eV8ebm4dYxt+pu/ziUp/2+XnXY=;
        b=dqpSNu7n4/TyrRWfvprAJ895TN/gWG0jWkRW0D8PZdMwGT7g+Sfw9NpT7uC0DleQ85
         kmWZHiEjE/KaRinhK0gFfkloWZq7tgFBhtJtN/O+nXAXFgDioRHMBJOHXTWlLuJGaiGx
         69lDWgxu8B9xGOWN8GAzmu9SlVaV6LQmjLWTUS4/8ffedSQvsyegKpMgsI1DfiO0Nkxy
         YhxXspZkdGGlD4jOOj1NFyb6WkaYDDAznvY+ZRLQlWrBbtluZlpRFZ51D+O5jRGJ+g0T
         3m5WnbPL8IsOL4IhAHipbPfj1gczNg2PaULvYS2vvIuj75G/SrQltrvxCZPh24TyrV+7
         CCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095212; x=1781700012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=An/axLWUDL0c+TuA+eV8ebm4dYxt+pu/ziUp/2+XnXY=;
        b=sUe981PhAX7gkSOImZVyUwElBtKM2iBYYkDPEfxC5UnVkvVsfzZxeGrBFNYVeeBCM1
         1YJdkmHtG4xIKMflpS1cXiUwNjtQt+4n8JWupJMgZpGmXZwzlExnzr2GM3J9zGgvXWaU
         CgiGqS3Wb3giwqvNBri6tC8i1JlNQ6XfhJkk03qUUe9tyyb+MikoNaL7bhYHSwCtsVhm
         PZ24kZqT/GVyKyWVQRtHbwzGQfTmg+YDLZXUEubNfri8ZAJxfOTzWS0NwyJB5czrK7Re
         iTjiO3qbeIy9/6SGZnOSiX8IQT9t34Ok4XXI72CnFIa50Vne1yxN5tQ9aLeG75cOXfY0
         PdGQ==
X-Forwarded-Encrypted: i=1; AFNElJ8K+Vdf9cssHt+v7kMdefOGQt7nIdJfZyuxys2jl4MdR2h3tylFgwPm65922ppJk/0m79VOXds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxee6c9Q1d8J4SRHFlD3VblFtFVGox8qe69W4t40nGDVJeL9hS
	Wn44gr2QBmKoNZHwbudiMNmajyMYWyNfrjviP1yFSwHbzmTUD8ASvowa
X-Gm-Gg: Acq92OHju7Zy3du25Rfojg2pOTR5Xc7lRtRTxAWPZKaTyHAJjYF7jJ+nw+uRCWh1qWr
	OIao0y0MVMfGS0fQlAFMzWjd3rPG6Lz/w0M3wUY72073ooDsL6cHeRmqaDGQHvuibi66pgS3Xno
	+Aoxm8vIqga7scyeHLDcF9scxdZf+6ibgyNXf45K6Qeq4jTzipY0TOJTF8Vf1z+pv7IHGnKt2QK
	HFvnuLsf6BBwu55MfhURtRPdlp/RH2CzZWo0xyyqsyGEo9IRd0eoffR4bIbpveahNM7SdtBnr43
	S0bQ02cSdl1QeSMHQ1QXilpEopj25FInRQgspyacL9pcIJAFr6B25uCS0aLMVQ6RWQDGV8/II1x
	wqPgXSs8ZfWRSq2Ls9E6Tv+V0jYN3hL1/X4BbqWFOIes+vXB25Xaky4VGVhGuWCYqZvtnmnoG96
	mXRocFopzVWdVhjb6Ud8J5x4m0E794tDsfuPFAV9HFGNUVi9cd0fQZgR+ALxrgETfhL0aLCLf/E
	1sqrRuj/T9Z86TSINl+rez+/R/caCk=
X-Received: by 2002:a05:620a:4141:b0:915:6cf9:5630 with SMTP id af79cd13be357-915a9d89fdamr4109579385a.34.1781095211893;
        Wed, 10 Jun 2026 05:40:11 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a237330sm2499096885a.16.2026.06.10.05.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 05:40:11 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 3/3] tipc: reject inverted service ranges from peer bindings
Date: Wed, 10 Jun 2026 08:40:03 -0400
Message-ID: <20260610124003.3831170-4-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610124003.3831170-1-michael.bommarito@gmail.com>
References: <20260610124003.3831170-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297664-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:tung.quang.nguyen@est.tech,m:horms@kernel.org,m:ying.xue@windriver.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E74166965B

tipc_update_nametbl() inserts a binding advertised by a peer node using
the lower and upper service-range bounds taken directly from the wire,
without checking that lower <= upper. The local bind path validates the
ordering (tipc_uaddr_valid()), but the name-distribution path does not.

A binding with lower > upper is inserted at the far end of the
service-range rbtree (keyed on lower) where no lookup or withdrawal can
ever match it (service_range_foreach_match() requires sr->lower <= end).
The publication, its service_range node and the augmented rbtree entry
are then leaked for the lifetime of the namespace, and there is no
per-peer cap equivalent to TIPC_MAX_PUBL on locally created bindings.

Reject inverted ranges in the network path as well. A peer node can
otherwise leak unbounded binding-table memory by sending PUBLICATION
items with lower > upper.

Fixes: 37922ea4a310 ("tipc: permit overlapping service ranges in name table")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/tipc/name_distr.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index 190b49c5cbc3e..ba4f4906e13b7 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -280,12 +280,21 @@ static bool tipc_update_nametbl(struct net *net, struct distr_item *i,
 				u32 node, u32 dtype)
 {
 	struct publication *p = NULL;
+	u32 lower = ntohl(i->lower);
+	u32 upper = ntohl(i->upper);
 	struct tipc_socket_addr sk;
-	struct tipc_uaddr ua;
 	u32 key = ntohl(i->key);
+	struct tipc_uaddr ua;
+
+	/* A peer-advertised binding with lower > upper can never be matched
+	 * or withdrawn and would leak the publication; the local bind path
+	 * rejects such ranges, so reject ranges learned from the network too.
+	 */
+	if (lower > upper)
+		return false;
 
 	tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_CLUSTER_SCOPE,
-		   ntohl(i->type), ntohl(i->lower), ntohl(i->upper));
+		   ntohl(i->type), lower, upper);
 	sk.ref = ntohl(i->port);
 	sk.node = node;
 
-- 
2.53.0


