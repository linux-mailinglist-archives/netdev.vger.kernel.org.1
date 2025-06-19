Return-Path: <netdev+bounces-199360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF88ADFF4F
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F1F17B5BE
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3039C25C6E7;
	Thu, 19 Jun 2025 08:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="XLYsc5VT"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA48E2472A4
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750320070; cv=none; b=i3sgtFKBaML0IAJTJmx9Lrgx22+S+vocOoU3Wb/Q3a6fvMVJYgEX4XxP9SEUHTFv12r17P8RnqvcVJT9c08pj9CO8AOIxTa59iVwdJFGTUBduC6u5hE2exQAni6Vbscy8162o6o5TwkhNMIbLRuZjO0451TiUvKKoTPOl6bx/9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750320070; c=relaxed/simple;
	bh=a6aw4aa2cUbfhI+C1HpTVHxzU6H213PQb/EEj50UUX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kFa5Hd1SeEGD34i2Wq43NaEJbRkDv66u8QA2V/WeqyPNSYGZvX0GVaPMRpo8WnJ8gN7lK9po5D1jblVv7uenH36Unepcf4QsXevHnHTzO6KHkA+5hEF6RTSRYLILXdixn7gPhDwavuXx14iWBVxhw7Cyue3tJwMU6R1FiOikyic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=XLYsc5VT; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750320060;
	bh=WbaZ851tPvl9z9qCq9g9hQhGeKab8Q7zy72SwZ1dqFQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XLYsc5VTsfxNX/OQX2oMdKsSJx//0aagz4uq7I597R/EiG9whucq0LktjJQKiimvF
	 2W3rYgz/pC7GHZpbIi+gNOmjY5zIxh2GD19z33ov0k0bQ3pB+GMVeZRWuwYMjxjW+R
	 g3LAG76LsuLogNshDhHtNSmdUGKJ0cyMIhxiEcpmJ4U701eERNP/bnL19pQAGhHzd6
	 a/ZjS8citU6ux6gx8KcHmXNY8MgRL/V/OICnpA3xdbAJG9Lw+Mw2+tZ8pmLFSzZOAe
	 7IbC/0hHuhfbfmCuep5BdzQWlsU6JTIw2IteD2CCawGyOv9nPcX0PrqxqU8DVQWRhT
	 I0lsCShw/U40w==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 0CFB668E77; Thu, 19 Jun 2025 16:01:00 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Thu, 19 Jun 2025 16:00:36 +0800
Subject: [PATCH net-next v2 01/13] net: mctp: don't use source cb data when
 forwarding, ensure pkt_type is set
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-dev-forwarding-v2-1-3f81801b06c2@codeconstruct.com.au>
References: <20250619-dev-forwarding-v2-0-3f81801b06c2@codeconstruct.com.au>
In-Reply-To: <20250619-dev-forwarding-v2-0-3f81801b06c2@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

In the output path, only check the skb->cb data when we know it's from
a local socket; input packets will have source address information there
instead.

In order to detect when we're forwarding, set skb->pkt_type on
input/output.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/route.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index d9c8e5a5f9ce9aefbf16730c65a1f54caa5592b9..128ac46dda5eb882994960b8c0eb671007ad8583 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -392,6 +392,9 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 	 */
 	skb_orphan(skb);
 
+	if (skb->pkt_type == PACKET_OUTGOING)
+		skb->pkt_type = PACKET_LOOPBACK;
+
 	/* ensure we have enough data for a header and a type */
 	if (skb->len < sizeof(struct mctp_hdr) + 1)
 		goto out;
@@ -578,7 +581,13 @@ static int mctp_route_output(struct mctp_route *route, struct sk_buff *skb)
 		return -EMSGSIZE;
 	}
 
-	if (cb->ifindex) {
+	/* If we're forwarding, we don't want to use the input path's cb,
+	 * as it holds the *source* hardware addressing information.
+	 *
+	 * We will have a PACKET_HOST skb from the dev, or PACKET_OUTGOING
+	 * from a socket; only use cb in the latter case.
+	 */
+	if (skb->pkt_type == PACKET_OUTGOING && cb->ifindex) {
 		/* direct route; use the hwaddr we stashed in sendmsg */
 		if (cb->halen != skb->dev->addr_len) {
 			/* sanity check, sendmsg should have already caught this */
@@ -587,6 +596,7 @@ static int mctp_route_output(struct mctp_route *route, struct sk_buff *skb)
 		}
 		daddr = cb->haddr;
 	} else {
+		skb->pkt_type = PACKET_OUTGOING;
 		/* If lookup fails let the device handle daddr==NULL */
 		if (mctp_neigh_lookup(route->dev, hdr->dest, daddr_buf) == 0)
 			daddr = daddr_buf;
@@ -1032,6 +1042,7 @@ int mctp_local_output(struct sock *sk, struct mctp_route *rt,
 		tag = req_tag & MCTP_TAG_MASK;
 	}
 
+	skb->pkt_type = PACKET_OUTGOING;
 	skb->protocol = htons(ETH_P_MCTP);
 	skb->priority = 0;
 	skb_reset_transport_header(skb);

-- 
2.39.5


