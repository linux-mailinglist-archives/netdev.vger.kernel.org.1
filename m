Return-Path: <netdev+bounces-201803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A00A6AEB1AD
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4331BC66EC
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F05827EC78;
	Fri, 27 Jun 2025 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="nHQCLlJP"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB795136327
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751014369; cv=none; b=Mfzr3t9oMD14qBxwtxjStW3QIs28WI5ZEdI6UPjW6Buau6j1z6/etNNleFJBtvDG+ralOOoIgmj5E9bO3cIapRL9KBzFQXzRaOgheQYrtlxqGK1IWtVdzzYcIisNiy93aVv9TWZBNeu7C5l//DPNyJvrgRWXah7mwdwPn18QFY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751014369; c=relaxed/simple;
	bh=a6aw4aa2cUbfhI+C1HpTVHxzU6H213PQb/EEj50UUX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fTg6Z7ZNkmzmiBm6LvmMLx2W8aGcvIqjwdnaZQ+zOiU0qyO4CJuHTAmsI47Bvhyl+EJXu6fnNVN/U+svY70bAcG6s32teV5GfYCYrQT1i2lrFPSZDVXJhwOZzazKD8KP4Yrfgv3dhuuRbaYiCk1PcSYx9LOv/zAGFJlQP4kJj88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=nHQCLlJP; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751014365;
	bh=WbaZ851tPvl9z9qCq9g9hQhGeKab8Q7zy72SwZ1dqFQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nHQCLlJP9AR76X192/7WlMqLmGZB0ja35Zqjz+uliQbSDouTe1fGxMcEcQQn1EFrr
	 4IFIyfoiVVrFLJRVKeth9LEmgT4qQhI9Ud14QEddiyr4FJyJZODbgXUYa0ua7vZJTn
	 x1mLw2oWLUughsjfJAFCimQrvnz4Wxtra6+ClkRy8vb8GMIjoFqtGG1Jb9zZZs9Asq
	 hGsgWJIiwZj3nGMCXuk8hEqoL/oGWmDHpHNbhbtN+Qa7manRfEv4vCf5P4WQcyntmD
	 tJ72YdJ3ABuN8sCgQ0qx0aGJVTdAqCw88vYlhcMhSRBWEKTizbjGqY5fOY6FMW7n6L
	 K2gXreCBGDcJQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id CAFF669E13; Fri, 27 Jun 2025 16:52:45 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 27 Jun 2025 16:52:17 +0800
Subject: [PATCH net-next v4 01/14] net: mctp: don't use source cb data when
 forwarding, ensure pkt_type is set
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-dev-forwarding-v4-1-72bb3cabc97c@codeconstruct.com.au>
References: <20250627-dev-forwarding-v4-0-72bb3cabc97c@codeconstruct.com.au>
In-Reply-To: <20250627-dev-forwarding-v4-0-72bb3cabc97c@codeconstruct.com.au>
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


