Return-Path: <netdev+bounces-72871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B190985A044
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469F528254F
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0878C2555D;
	Mon, 19 Feb 2024 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="QqksZuhA"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AAD28DA7
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336437; cv=none; b=UCvpaTaOWCIRzR28wTT+U8YgQj7efoZ6A31qqPPT46cIiTwO9jFlL9U/X4e1S4u4z55NblNWss/UFYlRqHcPduMgNaQNljaW5PhZ0xtSm1tFOXufMF9a1gBYIwmyZK/Rf0QmVhSPzBDymsniuUnQ42RBLCJMBSKY0gubvjWIlWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336437; c=relaxed/simple;
	bh=Jq/0cSqfhQWP1VE2kKkJKDYWA+Wh4NVj5n4TANbgzAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YldHrT89kWz5evMxC15jfxZWadyiwwbdjpgYrAJa86RVvfGWqFnJat9BDK8IRkKLFfc2ir4o0hum7j5rM4DdeBgs8PHt0WV5yAAvHumlcIQMaLqBi69LMgPoANCM9J1bG0HLUku2k9n62FshJybaGwhaSR+1WsR4egvuxmFFObE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=QqksZuhA; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 3ED612024D; Mon, 19 Feb 2024 17:53:54 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708336434;
	bh=coYoiN4Mah75wcMV/k6LgaKkMxSeMiBcI/i2WXTDSaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QqksZuhAH0OJCp9Uw2r0VAiAzrhQUyYjDuNe4eSefKJeCMqjbQefUsVk/lnoxeEAa
	 sL90woIj4l6ybk4c+lA8PJ805vl77Fvlr+pSCq+EEfKjbGVYz8hap9Zqmg2bJYCSgy
	 dSgNk0xBluZunMGLsrJtAXWu5NJ/Bv1tvDz6RQ/vWr3nN8z8lwRmoLsC1CF/faD1aM
	 E0Pl23FG6xC+kHYtpLeLzCvo5+v5MfwQLQv5BBc7x24Ze1M1eA6lnYQ75jKtVyh47u
	 qumIqaPQ4tHMSusx7OBsmL5rZ2GisfaN9Y1aMyf3weonsvKHoTmjycHIA44HGl9dSp
	 5VMJUEgL3FI/w==
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
	Johannes Berg <johannes.berg@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH net-next v2 02/11] net: mctp: Add some detail on the key allocation implementation
Date: Mon, 19 Feb 2024 17:51:47 +0800
Message-Id: <6c15e3040269608b59edb1e1c668ac8fac0e2b1f.1708335994.git.jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708335994.git.jk@codeconstruct.com.au>
References: <cover.1708335994.git.jk@codeconstruct.com.au>
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


