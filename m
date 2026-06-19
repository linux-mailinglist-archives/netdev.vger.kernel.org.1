Return-Path: <netdev+bounces-300626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h2qQGYHpNGrEjwYAu9opvQ
	(envelope-from <netdev+bounces-300626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:02:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F016A4336
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:02:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=pAt5jmmu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300626-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300626-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DEFD3011C4C
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 07:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3967935C1B0;
	Fri, 19 Jun 2026 07:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B6233ADA8
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 07:00:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781852460; cv=none; b=c+lhpFrp1YSGWabgQOEHlKPhme1badeHxysoTwuSY+My2rO980CDH01GnrpKNo9ZK8AOTsK+yr9JGhV4wGsCAtGdFpAaT5obyD+XVOfkqfkygaEiBqzbtiTufQS/Y9nGFussJbRVcp/RixA6zoKysonr+kNdrvQ/yR+I01RdOIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781852460; c=relaxed/simple;
	bh=pW77rAJgegkBP/hnVfi2NYylT9SiKlq3uZ53FUz6NhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRVgUti7GIAp2YIOxjsO88hsopW8PPL/86UPhQryhCpzQEJl1f15Gkmi+AU7oB8QsP3dkG50oZLhuf4WVXE3qeXpAljgV3pBEFmfmcqBkZS891xij9UdKVhtu2ifTxpGGHTd7Li3JLM23ymb2BNkjvoyWLmnylGoE1IYGAnab+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=pAt5jmmu; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1781852455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4vd3XpcRqG07DRs5Sf90jAxQ0vzJC0YNpd4xsAKMEl4=;
	b=pAt5jmmutaVQHH8SPqrS+uSvumGinZA7gjUTi19bSDn5Jtd2I1hgavcPSQOlHngQM9CWax
	EujQ9WecmRffta1Y1ih4P1GquFu6UkXIq7KBEzBc98TfLKvEts2QwFDBY/DmEV1kA1A+tR
	H4P5UJf5LEhORZSDMGHAuStgc7481QwIlm3G65nvTKZ+sOsSgzzn9k9HJ4cVEK1nObx36q
	P3P8tHFBKjvnpwxRrEjaydFERf4XiuO14atX5uOPWMGIsZAoLbiAoqczi4GXNg4z/vKr9o
	J/KnjzXAwEreMOkKexDIptgV1AJECc3tCdZDDZsQsIGwZisLD39MlbvHdemX1A==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 13/15] batman-adv: dat: prevent false sharing between VLANs
Date: Fri, 19 Jun 2026 09:00:43 +0200
Message-ID: <20260619070045.438101-14-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619070045.438101-1-sw@simonwunderlich.de>
References: <20260619070045.438101-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300626-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:stable@kernel.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[simonwunderlich.de:dkim,simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,narfation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6F016A4336

From: Sven Eckelmann <sven@narfation.org>

The local hash of DAT entries is supposed to be VLAN (VID) aware. But
the adding to the hash and the search in the hash were not checking the VID
information of the hash entries. The entries would therefore only be
correctly separated when batadv_hash_dat() didn't select the same buckets
for different VIDs.

Cc: stable@kernel.org
Fixes: be1db4f6615b ("batman-adv: make the Distributed ARP Table vlan aware")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index aaea155b94038..ae39ceaa2e29a 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -215,10 +215,13 @@ static void batadv_dat_purge(struct work_struct *work)
  */
 static bool batadv_compare_dat(const struct hlist_node *node, const void *data2)
 {
-	const void *data1 = container_of(node, struct batadv_dat_entry,
-					 hash_entry);
+	const struct batadv_dat_entry *entry1;
+	const struct batadv_dat_entry *entry2;
 
-	return memcmp(data1, data2, sizeof(__be32)) == 0;
+	entry1 = container_of(node, struct batadv_dat_entry, hash_entry);
+	entry2 = data2;
+
+	return entry1->ip == entry2->ip && entry1->vid == entry2->vid;
 }
 
 /**
@@ -345,6 +348,9 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 		if (dat_entry->ip != ip)
 			continue;
 
+		if (dat_entry->vid != vid)
+			continue;
+
 		if (!kref_get_unless_zero(&dat_entry->refcount))
 			continue;
 
-- 
2.47.3


