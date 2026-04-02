Return-Path: <netdev+bounces-274698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FhACZDZzmmGqgYAu9opvQ
	(envelope-from <netdev+bounces-274698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:03:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 802A138E383
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2172E30610F6
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 21:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A741C388E5D;
	Thu,  2 Apr 2026 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arKOk3P8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8489338645C;
	Thu,  2 Apr 2026 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775163613; cv=none; b=RymPfHZ7KZ+wiVeoIU/+OA0nxff1ZOBbg5HvBpZaNoOlnaw6jiDpP2jFO5MgtLFK1mTOmpvoqtJDXp+g2ytB4VSY4HXljckPW2xDbQ8dyTJF4XYvVuIOsSJ91FH7ihBSiXpE7PFaKkpmsroN34DYC+g2e8QGfzO5DfNVFnBLFVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775163613; c=relaxed/simple;
	bh=oV/VscydqBcFKc3QxQ/giSQe+ZDvaY6N81wtjHH+xjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Up7PuTlMHsHuunyk11NW7Xq4ago58FuLaZnco6YdmA2c+T6ViVKabg3wfAlk/AXto4rRRc69JS2eqU88wYJONFIPL1P2F6U5RCuSkqzvKkPg7NNOxzFFUevxmo6sPS/VIBMJyYDDx471iCa1QeANfkCZzlqxO9HUcmdtr3fKd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arKOk3P8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70A3C2BCB0;
	Thu,  2 Apr 2026 21:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775163613;
	bh=oV/VscydqBcFKc3QxQ/giSQe+ZDvaY6N81wtjHH+xjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=arKOk3P8zHAkH79mXHzm3f4yKxQPpaonil6K6UIXugb3ch+tv5KnexrqbABqpfMuk
	 SM8WOafJBhN1TS9uvKBQDlkrasxEU96cSoB7YC58QY2W6UE0yIWU6ypHSdNSV63st5
	 A6sB7o6RR8FCZ3i6UFBXjJOaTOz+hYEBAAZ93L6lRWaOmtsvkJbVYzTE7oN5ImCVHR
	 v7JVni8hFidWHXofl8I57uJxXsd5+8BiFmtLYnadoY3xgFJfMEaiPKIvNtCJJB3VEv
	 zS+9i7bKAAXcC2K4VOOkgwRuW1eGlYwucUUYohcC9doaVna9frwZE+U+KWddWLkqAI
	 ftsrqEEnu7R6w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	anubhavsinggh@google.com,
	richardbgobert@gmail.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 5/8] selftests: drv-net: gro: remove TOTAL_HDR_LEN
Date: Thu,  2 Apr 2026 13:59:57 -0700
Message-ID: <20260402210000.1512696-6-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402210000.1512696-1-kuba@kernel.org>
References: <20260402210000.1512696-1-kuba@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-274698-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 802A138E383
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Willem points out TOTAL_HDR_LEN is identical to MAX_HDR_LEN.
This seems to have been the case ever since the test was added.
Replace the uses of TOTAL_HDR_LEN with MAX_HDR_LEN, MAX seems
more common for what this value is.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/gro.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/lib/gro.c b/tools/testing/selftests/net/lib/gro.c
index 57080ecc3df8..3616ecc42a01 100644
--- a/tools/testing/selftests/net/lib/gro.c
+++ b/tools/testing/selftests/net/lib/gro.c
@@ -94,7 +94,6 @@
 #define START_SEQ 100
 #define START_ACK 100
 #define ETH_P_NONE 0
-#define TOTAL_HDR_LEN (ETH_HLEN + sizeof(struct ipv6hdr) + sizeof(struct tcphdr))
 #define MSS (4096 - sizeof(struct tcphdr) - sizeof(struct ipv6hdr))
 #define MAX_PAYLOAD (IP_MAXPACKET - sizeof(struct tcphdr) - sizeof(struct ipv6hdr))
 #define NUM_LARGE_PKT (MAX_PAYLOAD / MSS)
@@ -526,9 +525,9 @@ static void send_data_pkts(int fd, struct sockaddr_ll *daddr,
  */
 static void send_large(int fd, struct sockaddr_ll *daddr, int remainder)
 {
-	static char pkts[NUM_LARGE_PKT][TOTAL_HDR_LEN + MSS];
-	static char last[TOTAL_HDR_LEN + MSS];
-	static char new_seg[TOTAL_HDR_LEN + MSS];
+	static char pkts[NUM_LARGE_PKT][MAX_HDR_LEN + MSS];
+	static char last[MAX_HDR_LEN + MSS];
+	static char new_seg[MAX_HDR_LEN + MSS];
 	int i;
 
 	for (i = 0; i < NUM_LARGE_PKT; i++)
-- 
2.53.0


