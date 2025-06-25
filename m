Return-Path: <netdev+bounces-200956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654B5AE78B5
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1677E3B8FD5
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 07:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB48C20B81B;
	Wed, 25 Jun 2025 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="csWmUzFX"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D8621421E
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750836908; cv=none; b=dLRELTDAJ08z5DegQnKcYbcZmRolxWXyDp+mUhj/RPFLvNdYbUr8KCghUY2XxfjqJyy2YWFPq8PH0iQ4DRcLZfB0kUJK9jVo00L9pmA5ogdqp0go0kxfNnKpqnmMms7ea9MfJtuE05Nlxwkd4UnelcI/TEvrNNKgnewX73VA08I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750836908; c=relaxed/simple;
	bh=a6aw4aa2cUbfhI+C1HpTVHxzU6H213PQb/EEj50UUX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ljiSPSWbSESAvrxKQMPLaqmcZT0iEYSrXWu0KsRGFPTi9Wfpgk/smEpfS6zejV4bHUPbuif2s/DbInqnzxfgC5222GdfgihlaLA63wcGhDwYKNPTsME+IOffUqHf3+GlGdCmK8WZ4WBxiBS9TVB9a/lYv/iyfhD+u59MW0DzIic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=csWmUzFX; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750836904;
	bh=WbaZ851tPvl9z9qCq9g9hQhGeKab8Q7zy72SwZ1dqFQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=csWmUzFXRJSLeywLOIl3qAWBsW66gKjIrOBeZbrmVbQYx3KpO/yS9wsnRjjh+rGif
	 17UjRypDmhvAejGJWOH8GQHqPecfif2QouJZ9PwEiVsl5ScLu2KPGpr1xOnRtZUUYi
	 1JGQ/X5uQ4bTSVl4JyCqwWYnSciePD2AY0J5KqpCOJSiV3HCr1FDftZ718/NJzIY9d
	 PiWhB6RhfI+PefvBZvw+1DX4FL3/fG+xKnsFSQtgrpj+yu8fiZ/97pHjPPwmfyHuw7
	 CQYORrnV6HA/kwz7PSV/siGUu9RB6Q1u3rnJ6/mjmrHZmcOBIJNtGrmt3c8BBJwBvq
	 rC4c5RtMt3ufA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id C36CB69A31; Wed, 25 Jun 2025 15:35:04 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 25 Jun 2025 15:34:39 +0800
Subject: [PATCH net-next v3 01/14] net: mctp: don't use source cb data when
 forwarding, ensure pkt_type is set
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-dev-forwarding-v3-1-2061bd3013b3@codeconstruct.com.au>
References: <20250625-dev-forwarding-v3-0-2061bd3013b3@codeconstruct.com.au>
In-Reply-To: <20250625-dev-forwarding-v3-0-2061bd3013b3@codeconstruct.com.au>
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


