Return-Path: <netdev+bounces-72295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4155885778B
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B83B282974
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 08:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9A71C6B6;
	Fri, 16 Feb 2024 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ca198odF"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E271C6A1
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071582; cv=none; b=oGhyZhFw0UxXlnA+EQGGVMHwhfyeuxJWSwzjI7bcq+/PAXsJqq1oT1jIBokxMB6DGBN5fNt2NZv8pFIybBROLL834eji/VSPoLLtovhib0zv4FBobf6wPb04GIz2cL/eDTjrxE13FTA+1CDPUsUfGqdhKk8i+qFj1A0EDX++rlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071582; c=relaxed/simple;
	bh=Jq/0cSqfhQWP1VE2kKkJKDYWA+Wh4NVj5n4TANbgzAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i+bKzn+TFQHecRvXd/d/6TTUg+JvcweW6X7vs/58p0zMTOFdZt70a9HZX9FoIp1zZ0toro5QholAwLk7M09/DBTc3+m1LtofVzCHF7romzjjDCpaNK+evhjJ8mJam7Onb5WzphzgcMXxaIF3G1RJK629HJKDrhJXR60UR8dnPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ca198odF; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 7CF1020228; Fri, 16 Feb 2024 16:19:32 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708071572;
	bh=coYoiN4Mah75wcMV/k6LgaKkMxSeMiBcI/i2WXTDSaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ca198odFZd1cfzYXyZ9dOIPre5uYEYFc80U4wByxRb6rTe733zqgh4K3DFJJklIIL
	 ZHMl54Bxznb9JPMG+Mn9HaIiN9mADHsYutWJYr2NFDGUbN3qvKMLCBiJPhH2DiazlV
	 o8aEQHAMRTydbvYP9eKBRchNJtMNNKDkGWMGjJ3znez84odfZ2/yTho5HCB45CeqFV
	 VyMKvj+AEwAmCcsWF58Okbvq3ucZawpCBMxLCl5LSut56yTPCszVhO3fKXzSlCPj6U
	 LHs62IsOJDBflIx6bsnSC7af6+jQhWSs/94B+yMT6hhO8KW3IOEQq4J7jxYhzWXK0i
	 cNZVwXN++81HQ==
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: netdev@vger.kernel.org
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net-next 02/11] net: mctp: Add some detail on the key allocation implementation
Date: Fri, 16 Feb 2024 16:19:12 +0800
Message-Id: <6c15e3040269608b59edb1e1c668ac8fac0e2b1f.1708071380.git.jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708071380.git.jk@codeconstruct.com.au>
References: <cover.1708071380.git.jk@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We could do with a little more comment on where MCTP_ADDR_ANY will match
in the key allocations.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/route.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 37c5c3dd16f6..95f59508543b 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -73,6 +73,40 @@ static struct mctp_sock *mctp_lookup_bind(struct net *net, struct sk_buff *skb)
 	return NULL;
 }
 
+/* A note on the key allocations.
+ *
+ * struct net->mctp.keys contains our set of currently-allocated keys for
+ * MCTP tag management. The lookup tuple for these is the peer EID,
+ * local EID and MCTP tag.
+ *
+ * In some cases, the peer EID may be MCTP_EID_ANY: for example, when a
+ * broadcast message is sent, we may receive responses from any peer EID.
+ * Because the broadcast dest address is equivalent to ANY, we create
+ * a key with (local = local-eid, peer = ANY). This allows a match on the
+ * incoming broadcast responses from any peer.
+ *
+ * We perform lookups when packets are received, and when tags are allocated
+ * in two scenarios:
+ *
+ *  - when a packet is sent, with a locally-owned tag: we need to find an
+ *    unused tag value for the (local, peer) EID pair.
+ *
+ *  - when a tag is manually allocated: we need to find an unused tag value
+ *    for the peer EID, but don't have a specific local EID at that stage.
+ *
+ * in the latter case, on successful allocation, we end up with a tag with
+ * (local = ANY, peer = peer-eid).
+ *
+ * So, the key set allows both a local EID of ANY, as well as a peer EID of
+ * ANY in the lookup tuple. Both may be ANY if we prealloc for a broadcast.
+ * The matching (in mctp_key_match()) during lookup allows the match value to
+ * be ANY in either the dest or source addresses.
+ *
+ * When allocating (+ inserting) a tag, we need to check for conflicts amongst
+ * the existing tag set. This requires macthing either exactly on the local
+ * and peer addresses, or either being ANY.
+ */
+
 static bool mctp_key_match(struct mctp_sk_key *key, mctp_eid_t local,
 			   mctp_eid_t peer, u8 tag)
 {
@@ -368,6 +402,9 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 			 * key lookup to find the socket, but don't use this
 			 * key for reassembly - we'll create a more specific
 			 * one for future packets if required (ie, !EOM).
+			 *
+			 * this lookup requires key->peer to be MCTP_ADDR_ANY,
+			 * it doesn't match just any key->peer.
 			 */
 			any_key = mctp_lookup_key(net, skb, MCTP_ADDR_ANY, &f);
 			if (any_key) {
-- 
2.39.2


