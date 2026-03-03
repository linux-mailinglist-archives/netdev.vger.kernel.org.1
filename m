Return-Path: <netdev+bounces-263394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHvIJgE9p2kNgAAAu9opvQ
	(envelope-from <netdev+bounces-263394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:56:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C1C1F67A6
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF7B830D36D3
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 19:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D7A386450;
	Tue,  3 Mar 2026 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4Ox95DJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F59389113
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567761; cv=none; b=duair1bkqIw8jazNLsUSLElXMkIJV8Beu8Vx5zcd0unW6V/DFchH5jZzhkz1WmVGAwm/WgdWMeUv4sKnhD9QOOfXHIjqR4ol6cu14qPImWy4Dc7om+cP7ClH2b0adI+I4epn4QoL++jSSX8QWDDHzjtFBsFsmVQni9N4/Pp+o9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567761; c=relaxed/simple;
	bh=lAeoYgBQM1LTZWAFlAqqO4VQEX8bViSlLynqua3uy0E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pug0MdMxgj/ja23zFX0b3nAe0WNrOMiMQ+Z9l76DZsry+qanC5dqo/MIS+V7WN5CmVB2QjNKpeQXxSE559QLSyiE/oU0PTbLNq9byjkkKgsFO2jtthRPYIZ26QF6n6d5Sfj2IQ4u7rkIo1sbLJneYi3NW/gARvHA4hkjn1URBg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C4Ox95DJ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae57228f64so22438355ad.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 11:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772567757; x=1773172557; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P8wBZYOjVx1PhHvmvhSvpE8PvzwVvcrdiZixhCtvqCs=;
        b=C4Ox95DJEU4xS4hut7ebGN7EhQuj5gI5uyqv8ZG3MykMA0+D6qSI00Y2sUqQ4/MFzp
         1es9iKGyLyN+8+ZsqqNpWeEl2lPaEw5+dfYzNb5xKxv/cOgohvnNk1jgUUaejXjGSzvS
         R7CdhQm171QVnmftcC0Spv/JIuDdRuw6KeZkwCXHbzLivJwc5HwxGvx0B7gtWrF3YWuH
         tJ+9+3qZkCV47mD1EMoHkABcQMvsPEFxHpRbCkA5AChg7yHNOCAMPkncQfNn7nYlAD5i
         o5O13KWsSW0kOmkPs19p+Ge9a5PWpXeCtCulzwWOVgtagzuRNxQRUBlNh7sR0oP1SwMO
         AllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772567757; x=1773172557;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8wBZYOjVx1PhHvmvhSvpE8PvzwVvcrdiZixhCtvqCs=;
        b=EVjKGOp1t/NUpgFQqne5Mc0bUPjnLV0o7jBnJjZUrZ8+uuqUg+6N8MENxoOXyl21Lj
         SvpdaEvMANr9A07sXASmZPZBORAlzS10fuBvTlgAd/l1vq3rjNJF51lUgOR+MqZ5DAc3
         hYF5grt7LOVvvBZbBZMCuM7Hz6M0yAURLWqu5R3HEchVWA9twqrEcTmDvTyfoS9nq7nw
         GrJfCzMsAF23DpxGbX2++nQu8cRCqpLsXAGayCXMVosVSfpwKpnKxsa8JczSYvolHYxl
         pYA6cHdBv3Xm2VyAEV1egC1L0JIbNk8xtrM9bo7IeBSIkCz998boBvhXy8NTwRVO7+hv
         ZaBg==
X-Gm-Message-State: AOJu0YysSCK3ABa9zhlmUqmYtAdDTzh4fZHck4sO4DLU8kwVqeaktMVA
	OtWzk4HiwhOPAVABgy7yGn28/RDijxf6Xq4vIdg0+gqiQqq2TM/+hUk6g9AAmtrPHSs116q53xZ
	+v5SEBQCmK4JiO3iuVtrxlebbysZhTYynY1EodKDEi7h/56iEUCciql6k1lLtgXxYxH3cSbrVol
	ori3hKW8W3Yg5RQbZLcbDgIAvzpS2ma1wc40y3fReYMjQe2LE=
X-Received: from plrd24.prod.google.com ([2002:a17:902:aa98:b0:2ae:4655:2b3b])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2ac7:b0:2ae:3afc:eb38 with SMTP id d9443c01a7336-2ae3afcefb0mr135265005ad.41.1772567757193;
 Tue, 03 Mar 2026 11:55:57 -0800 (PST)
Date: Tue,  3 Mar 2026 11:55:47 -0800
In-Reply-To: <20260303195549.2679070-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260303195549.2679070-1-joshwash@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303195549.2679070-3-joshwash@google.com>
Subject: [PATCH net-next 2/4] gve: fix SW coalescing when hw-GRO is used
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Jordan Rhee <jordanrhee@google.com>, Ankit Garg <nktgrg@google.com>, 
	John Fraker <jfraker@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	Matt Olson <maolson@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Tim Hostetler <thostet@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 22C1C1F67A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263394-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Ankit Garg <nktgrg@google.com>

Leaving gso_segs unpopulated on hardware GRO packet prevents further
coalescing by software stack because the kernel's GRO logic marks the
SKB for flush because the expected length of all segments doesn't match
actual payload length.

Setting gso_segs correctly results in significantly more segments being
coalesced as measured by the result of dev_gro_receive().

gso_segs are derived from payload length. When header-split is enabled,
payload is in the non-linear portion of skb. And when header-split is
disabled, we have to parse the headers to determine payload length.

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 63a96106..5ba893e5 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -945,11 +945,16 @@ static int gve_rx_complete_rsc(struct sk_buff *skb,
 			       struct gve_ptype ptype)
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
+	int rsc_segments, rsc_seg_len, hdr_len;
 
-	/* Only TCP is supported right now. */
+	/* HW-GRO only coalesces TCP. */
 	if (ptype.l4_type != GVE_L4_TYPE_TCP)
 		return -EINVAL;
 
+	rsc_seg_len = le16_to_cpu(desc->rsc_seg_len);
+	if (!rsc_seg_len)
+		return 0;
+
 	switch (ptype.l3_type) {
 	case GVE_L3_TYPE_IPV4:
 		shinfo->gso_type = SKB_GSO_TCPV4;
@@ -961,7 +966,21 @@ static int gve_rx_complete_rsc(struct sk_buff *skb,
 		return -EINVAL;
 	}
 
-	shinfo->gso_size = le16_to_cpu(desc->rsc_seg_len);
+	if (skb_headlen(skb)) {
+		/* With header-split, payload is in the non-linear part */
+		rsc_segments = DIV_ROUND_UP(skb->data_len, rsc_seg_len);
+	} else {
+		/* HW-GRO packets are guaranteed to have complete TCP/IP
+		 * headers in frag[0] when header-split is not enabled.
+		 */
+		hdr_len = eth_get_headlen(skb->dev,
+					  skb_frag_address(&shinfo->frags[0]),
+					  skb_frag_size(&shinfo->frags[0]));
+		rsc_segments = DIV_ROUND_UP(skb->len - hdr_len, rsc_seg_len);
+	}
+	shinfo->gso_size = rsc_seg_len;
+	shinfo->gso_segs = rsc_segments;
+
 	return 0;
 }
 
-- 
2.53.0.473.g4a7958ca14-goog


