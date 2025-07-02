Return-Path: <netdev+bounces-203189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EBCAF0B79
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF241897099
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 06:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E44219A86;
	Wed,  2 Jul 2025 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="UZuXyYAM"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F11021323C
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 06:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751437218; cv=none; b=LjTamkdooVPOB3fVtDW0afvMVxCkV4IkV/YFnbKizDRnjugoknG9Yn3GB9plemzdjWyXakSllPOqBS9Mks6SUCXabZchTnj52a+gct/aMLrAKMnlYj5KRROUtdkvnefjmBWVgL8mg5dcrKtmDzzG4K7Kdg5ha/oPYr5zDjQ+LY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751437218; c=relaxed/simple;
	bh=a6aw4aa2cUbfhI+C1HpTVHxzU6H213PQb/EEj50UUX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KDWAQ6IYgG5blPLh3FfNs0pf5YFeQimBDhbelJb68z1eMDLeJDELeHRD0FIYrnd8yn2M0zJCRYZFDvZmJxrVcNO1BbmI5u1zUBvdXrhbljeu/kaFYfvpXDNURlWg2DevxGhumMdTtjcqbfEFW6X6mnbKh6vVSmLL0qyQf8p0Je0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=UZuXyYAM; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751437215;
	bh=WbaZ851tPvl9z9qCq9g9hQhGeKab8Q7zy72SwZ1dqFQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UZuXyYAMut5dWJyxZaCWFG8+pxZF48XLIjXkizXOE8iwDw9j9ZPR7SmlUU0qX2MZ2
	 1IFIxCYeVY0eH4aVmyNrkm07WeXU51bUs9Qcku9yynhfpOv8LnS+Fbu9mLxTZpnzPx
	 LK76qTrnVD5uc5giLr7lfdvJOz40+cHHyV+F3mp8pffiOs0ByGgcP49EMMWwkrplaT
	 iNABvhfOu0k1H0vIcXRIxDfyY6xhgUYYVf6+lgImcEA7ZTvC1YSfA/EEoWkeejz0pa
	 ueATH0Dn3ACQtHJZXJ0JEw03EMR7e68Jp+TpNSp5+2yAxCPGVXpH2ClXOlohY0fBqr
	 ZztKtEe4++LFQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 4A75F6A707; Wed,  2 Jul 2025 14:20:15 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 02 Jul 2025 14:20:01 +0800
Subject: [PATCH net-next v5 01/14] net: mctp: don't use source cb data when
 forwarding, ensure pkt_type is set
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-dev-forwarding-v5-1-1468191da8a4@codeconstruct.com.au>
References: <20250702-dev-forwarding-v5-0-1468191da8a4@codeconstruct.com.au>
In-Reply-To: <20250702-dev-forwarding-v5-0-1468191da8a4@codeconstruct.com.au>
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


