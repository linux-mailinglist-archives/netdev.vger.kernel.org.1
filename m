Return-Path: <netdev+bounces-277948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMAeGqBo3GnoQQkAu9opvQ
	(envelope-from <netdev+bounces-277948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 05:53:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C45EB3E7093
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 05:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8D6830087B0
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 03:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9C937C10A;
	Mon, 13 Apr 2026 03:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IzFsJXsl"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECB62D592C
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 03:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776052366; cv=none; b=P3EFkYnd2K5JLCfV8bY4Yj7gpIldadyTOyYSoK2Sag+RMx9i80Um2tiowV6IUhwC9To3uRBvzb/JnOK4Hwai43VkZLMzczgql9t/SRW7jahOxwPLsaO/nVVIlxK3d/CXI0436W5sBD7r+nQ9gYJLx1W0WMlBBTUC6RElLaXmqOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776052366; c=relaxed/simple;
	bh=Enk/7+1eOnrzFSs1c4ahC/sRpxvzwXJB4ShJvD5rx4Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=svBuiiCdarIJWk6r9vLdCQlYjkxwxbsHxIdNT/CGG6OjIFRFsiwOxLyoBi/hk4qjdJG2Z29xHL/qTUHppLN6qiKMp9FJjCW3rvPJLIQNHz77uhq9yTYFOmzhzAGnTmzdgPnsvhwZG8VPcqH3NAgXEJVhz36XNmtDpjxm0i7TDhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IzFsJXsl; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776052352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HZfm2zw4idtXW52pQTPw8Du+65quJOdBYon2FQtTgvY=;
	b=IzFsJXslCGdOKopFBLAQGcvH6dKIonZPQACTCPrcW2uT+J4zdaQbO/VSTptmLjf1roXJit
	UgVFfZ4Z5jRRXWDVhLdq0XfdSPNpVscQaTcftHbdzG1JN2SPQ+/TJn7ZFOcmNdBawQP7a9
	yWB5F5aMXqIQ90UaockeaN0S1H3m9hI=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Guillaume Nault <gnault@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] pppoe: optimize hash with word access
Date: Mon, 13 Apr 2026 11:52:10 +0800
Message-ID: <20260413035212.56566-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.dev,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277948-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: C45EB3E7093
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, hash_item() processes the 6-byte Ethernet address and the
2-byte session ID byte-wise to compute a hash.

Optimize this by using 16-bit word operations: XOR three 16-bit words
from the Ethernet address and the 16-bit session ID, then fold the
result. This reduces the total number of loads and XORs. The Ethernet
addresses in a skb and struct pppoe_addr are both 2-byte aligned, so the
u16 pointer cast is safe.

Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/pppoe.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index d546a7af0d54..e2e70628958b 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -136,15 +136,15 @@ static inline int cmp_addr(struct pppoe_addr *a, __be16 sid, char *addr)
 #error 8 must be a multiple of PPPOE_HASH_BITS
 #endif
 
-static int hash_item(__be16 sid, unsigned char *addr)
+static u8 hash_item(__be16 sid, const u8 addr[ETH_ALEN])
 {
-	unsigned char hash = 0;
+	const u16 *addr16 = (const u16 *)addr;
 	unsigned int i;
+	u16 hash16;
+	u8 hash;
 
-	for (i = 0; i < ETH_ALEN; i++)
-		hash ^= addr[i];
-	for (i = 0; i < sizeof(sid_t) * 8; i += 8)
-		hash ^= (__force __u32)sid >> i;
+	hash16 = addr16[0] ^ addr16[1] ^ addr16[2] ^ (__force u16)sid;
+	hash = (hash16 >> 8) ^ hash16;
 	for (i = 8; (i >>= 1) >= PPPOE_HASH_BITS;)
 		hash ^= hash >> i;
 
-- 
2.43.0


