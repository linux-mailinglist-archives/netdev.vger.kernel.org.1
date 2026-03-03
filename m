Return-Path: <netdev+bounces-263395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH7YGxM9p2kNgAAAu9opvQ
	(envelope-from <netdev+bounces-263395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:57:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 121321F67BD
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F63B30EAFD6
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 19:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F053AE6F6;
	Tue,  3 Mar 2026 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SBAl/Bz7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517AB3890E4
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567763; cv=none; b=frhpiDyQVRrdwYmZPmOeXKr9wDFouKIyqvcMjONw/wM9bWJdii56jlv9omliAMqiXPRCWwtcG3EjMi+u/GiROolXFC+e9R4SorOEiqlqoxci4W1LU8DMI80li7ozOj10wh/mJfHgVQT/RDzeHhIplI9+yJwUTbAuMkpu7mWVXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567763; c=relaxed/simple;
	bh=Fz+xOWFU7AOGBur392VvmH8RfVHXuXIbgMX+VtQzmUo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I+HFmr7cu9ODAwnx/GwPh8TWn66ULQKGTSqjrKop3+xp87Rum1yCP/tvf9hKT9wXywVR950q9anJFYSFtPpo1P/iH0xUXew9YKPlAW6D1p26OVLi1bPDhHoGozfg+1apYbjEMp30YxVXfOpHix8bgIe+8jOop1POK57Okjr55GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SBAl/Bz7; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c70ea91bfe1so3863367a12.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 11:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772567759; x=1773172559; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dq/OV3i9BQc2Nxo8MqQVMxCoaBT7eVK8KXpu8kyi000=;
        b=SBAl/Bz7g8wUyIfoOWqBebb9/XtKX/DOKzT4m1N42I8caEKbRF4LXcTYEXO/nykKJb
         LOBi3UT2nBpp9aJl3PcbderSvVThUbl6Hru39LudvvZdfdx/mg0gs0Nf1q+xUuvkIUhk
         k1oGYK2N/hpTaoAtqgm1BtVMGEfkIq1W6vEwlxd+WvB68ZDRbRuDIy+Hy0ey1uuFYmPc
         JvX9VNTXxgRES+my+BVrUZeCM0yFVrak+MMQjmiQj6yh2f3GHYQqQp79EIkj/NZIpQ03
         Rfr5TOoZkLDTwwOWxK5WYaddrUzlnzdLPB1QFClEGujmNCE7aQGaCVNKAL0BudEYI23a
         zMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772567759; x=1773172559;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dq/OV3i9BQc2Nxo8MqQVMxCoaBT7eVK8KXpu8kyi000=;
        b=XYk+WaWvKQxdvG2CyFTDvmTjtjGH4Jt6IFNceDBVnNkcTFcZQtrHpC3U02FFtaTn68
         Y1OoR1A5KtCMUsQwLGbL72YxGMrUZX/n0wEY2ZHXnFmbqHvGmweSmeW5N6oD+eulAcEI
         kOZMlElHQuUFaPKROnhoXhCKBbLThg5fY2Yx57Vbb3h6uNwdl3GxATRIOR8i7g4+VAHl
         /VodoEKGwHz8wQRnKoUSaAT/CjWiZBuE0WI1l9q7WOuyOv4MRinSTkX70NYI9xMkd8Ua
         bR8HuVHYh2W1zRBQjwATcjXVU+5eBaqJyzhYmJv2rrWIDRYxiJFwtl2iwSiO8cIDCXn1
         w7nQ==
X-Gm-Message-State: AOJu0YxX4vAMfC0303omWRR1DB9O3BNx0lXxw/wLN2DlFPJwUtWur/py
	ngk5JkxOatJo+syV+wAhgihTYNkIae/eHBTUD/1JGNl9LNCB17Us0lamMwM8e6xtr6XUVeHr+jL
	FRHa9JnBsIGMPGcrqct8yhV3Z/4AkxSbpIsDz4guUPdrMIGU8iCMNCXaZSm3mnMUR9DFfLUoRT9
	+7BhnUiEpPt3aTrBSPZfbYMJoH8+GobnaHbXlVrtQbEkatPic=
X-Received: from pfjt7.prod.google.com ([2002:a05:6a00:21c7:b0:824:a3b4:6d0])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d95:b0:822:1dbc:e75d with SMTP id d2e1a72fcca58-8274d933c52mr13543880b3a.1.1772567758991;
 Tue, 03 Mar 2026 11:55:58 -0800 (PST)
Date: Tue,  3 Mar 2026 11:55:48 -0800
In-Reply-To: <20260303195549.2679070-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260303195549.2679070-1-joshwash@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303195549.2679070-4-joshwash@google.com>
Subject: [PATCH net-next 3/4] gve: pull network headers into skb linear part
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
X-Rspamd-Queue-Id: 121321F67BD
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
	TAGGED_FROM(0.00)[bounces-263395-lists,netdev=lfdr.de];
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

Currently, in DQO mode with hw-gro enabled, entire received packet is
placed into skb fragments when header-split is disabled. This leaves
the skb linear part empty, forcing the networking stack to do multiple
small memory copies to access eth, IP and TCP headers.

This patch adds a single memcpy to put all headers into linear portion
before packet reaches the SW GRO stack; thus eliminating multiple
smaller memcpy calls.

Additionally, the criteria for calling napi_gro_frags() was updated.
Since skb->head is now populated, we instead check if the SKB is the
cached NAPI scratchpad to ensure we continue using the zero-allocation
path.

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 5ba893e5..ac44f50d 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -946,6 +946,8 @@ static int gve_rx_complete_rsc(struct sk_buff *skb,
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
 	int rsc_segments, rsc_seg_len, hdr_len;
+	skb_frag_t *frag;
+	void *va;
 
 	/* HW-GRO only coalesces TCP. */
 	if (ptype.l4_type != GVE_L4_TYPE_TCP)
@@ -973,10 +975,20 @@ static int gve_rx_complete_rsc(struct sk_buff *skb,
 		/* HW-GRO packets are guaranteed to have complete TCP/IP
 		 * headers in frag[0] when header-split is not enabled.
 		 */
-		hdr_len = eth_get_headlen(skb->dev,
-					  skb_frag_address(&shinfo->frags[0]),
-					  skb_frag_size(&shinfo->frags[0]));
+		frag = &skb_shinfo(skb)->frags[0];
+		va = skb_frag_address(frag);
+		hdr_len =
+			eth_get_headlen(skb->dev, va, skb_frag_size(frag));
 		rsc_segments = DIV_ROUND_UP(skb->len - hdr_len, rsc_seg_len);
+		skb_copy_to_linear_data(skb, va, hdr_len);
+		skb_frag_size_sub(frag, hdr_len);
+		/* Verify we didn't empty the fragment completely as that could
+		 * otherwise lead to page leaks.
+		 */
+		DEBUG_NET_WARN_ON_ONCE(!skb_frag_size(frag));
+		skb_frag_off_add(frag, hdr_len);
+		skb->data_len -= hdr_len;
+		skb->tail += hdr_len;
 	}
 	shinfo->gso_size = rsc_seg_len;
 	shinfo->gso_segs = rsc_segments;
@@ -1013,7 +1025,7 @@ static int gve_rx_complete_skb(struct gve_rx_ring *rx, struct napi_struct *napi,
 			return err;
 	}
 
-	if (skb_headlen(rx->ctx.skb_head) == 0)
+	if (rx->ctx.skb_head == napi->skb)
 		napi_gro_frags(napi);
 	else
 		napi_gro_receive(napi, rx->ctx.skb_head);
-- 
2.53.0.473.g4a7958ca14-goog


