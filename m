Return-Path: <netdev+bounces-272959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEMYLmpqyWnqxwUAu9opvQ
	(envelope-from <netdev+bounces-272959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:07:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC6B35389E
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C098B300FC7F
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2D237D12A;
	Sun, 29 Mar 2026 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqDo+DvR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B35E288B1;
	Sun, 29 Mar 2026 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774807479; cv=none; b=dW+HxP2zLYJCfhTXcUFzhFwu7H3sc3IMAwyv3tNKca8ITrejNnLw9wZ3IsJa/jjgBuRfMgwClAGVwQuTlZVg2KaRYYtB6G3jhg0Xf/PJApsnOop2l4RfwWeVSdOjKsw3JsDyk8CqzYRWa2qaiIeO9Ok0/gLpXkoOPkP67vphPNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774807479; c=relaxed/simple;
	bh=REzvWZ5aOHQ9Y0vSZeYulTmbFFxAa6+bYcMW+sJLcY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCZDPMlndrqyZsyOx0Gx2omzEKfTL1ESlsZqOUEYyl0ua6lNgLEqTUm1GcFDrhoOTSXY6Slfjzc4OKP9xFuZ1wqDKznG3mYUN8QaB79w4KN4uTejvPRbDa1DD4/nQL7kFq2P3iyfS7yZOw3SEJP5Gryd7/vOoKmEnNef3I0UEwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqDo+DvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158D0C116C6;
	Sun, 29 Mar 2026 18:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774807479;
	bh=REzvWZ5aOHQ9Y0vSZeYulTmbFFxAa6+bYcMW+sJLcY4=;
	h=From:To:Cc:Subject:Date:From;
	b=LqDo+DvRfDKwDzps0slvBkwduv3iEK12Yq/FcY86VZDOu7Ybpk55SSAJpj0pwz1MT
	 R+n8tD3VMu1xnm513Ya+w5MF9yHCcXiQ3H72jm0mJhHOx84fg0EE483YqX37vVjLCK
	 rJ9PSLt36DUCW448xvSNDbFUFA3155QRpmHeKLbFzbrlzUf0pufkuU/NhHki35uv3x
	 0PQTXQCwS73jsDPxVe8724ftsBcot5JE7dwAB7wJTIgdDdSz+RvvVI915m7peU76/5
	 nm3YPVE+t5o0L2cQFS/kjRQ2TVXBjI5hOfXBcfNOh79NiH3+OljWu/2m2zn6yWl/5L
	 2hnS3N3S+rIOw==
From: Jakub Kicinski <kuba@kernel.org>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	maze@google.com,
	willemdebruijn.kernel@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Subject: [PATCH bpf-next v2 1/2] net: clear the dst when performing encap / decap
Date: Sun, 29 Mar 2026 11:04:27 -0700
Message-ID: <20260329180428.2657785-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-272959-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:email]
X-Rspamd-Queue-Id: 1AC6B35389E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit ba9db6f907ac ("net: clear the dst when changing skb protocol")
added dst clearing when a BPF program changes the skb protocol
(e.g. IPv4 to IPv6). Since that was a fix we only cleared the dst when
the L3 protocol actually changes to keep it minimal. As suggested during
the discussion (see Link) encap or decap operation which wraps or unwraps
a same-protocol header may also render the existing dst incorrect - even
if that doesn't result in a crash, just the wrong route for the now-outermost
IP dst.

Make dropping dst unconditional for bpf_skb_change_proto() and all
L3 encap / decap ops.

Link: https://lore.kernel.org/CANP3RGfRaYwve_xgxH6Tp2zenzKn2-DjZ9tg023WVzfdJF3p_w@mail.gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - move the pointer recalc
v1: https://lore.kernel.org/20260319234531.3022634-1-kuba@kernel.org

CC: maze@google.com
CC: willemdebruijn.kernel@gmail.com

CC: ast@kernel.org
CC: daniel@iogearbox.net
CC: andrii@kernel.org
CC: martin.lau@linux.dev
CC: eddyz87@gmail.com
CC: song@kernel.org
CC: yonghong.song@linux.dev
CC: john.fastabend@gmail.com
CC: kpsingh@kernel.org
CC: sdf@fomichev.me
CC: haoluo@google.com
CC: jolsa@kernel.org
CC: bpf@vger.kernel.org
---
 net/core/filter.c | 50 +++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 78b548158fb0..8a352257656e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3257,13 +3257,6 @@ static const struct bpf_func_proto bpf_skb_vlan_pop_proto = {
 	.arg1_type      = ARG_PTR_TO_CTX,
 };
 
-static void bpf_skb_change_protocol(struct sk_buff *skb, u16 proto)
-{
-	skb->protocol = htons(proto);
-	if (skb_valid_dst(skb))
-		skb_dst_drop(skb);
-}
-
 static int bpf_skb_generic_push(struct sk_buff *skb, u32 off, u32 len)
 {
 	/* Caller already did skb_cow() with meta_len+len as headroom,
@@ -3362,7 +3355,7 @@ static int bpf_skb_proto_4_to_6(struct sk_buff *skb)
 		shinfo->gso_type |=  SKB_GSO_DODGY;
 	}
 
-	bpf_skb_change_protocol(skb, ETH_P_IPV6);
+	skb->protocol = htons(ETH_P_IPV6);
 	skb_clear_hash(skb);
 
 	return 0;
@@ -3393,7 +3386,7 @@ static int bpf_skb_proto_6_to_4(struct sk_buff *skb)
 		shinfo->gso_type |=  SKB_GSO_DODGY;
 	}
 
-	bpf_skb_change_protocol(skb, ETH_P_IP);
+	skb->protocol = htons(ETH_P_IP);
 	skb_clear_hash(skb);
 
 	return 0;
@@ -3441,7 +3434,13 @@ BPF_CALL_3(bpf_skb_change_proto, struct sk_buff *, skb, __be16, proto,
 	 */
 	ret = bpf_skb_proto_xlat(skb, proto);
 	bpf_compute_data_pointers(skb);
-	return ret;
+	if (ret)
+		return ret;
+
+	if (skb_valid_dst(skb))
+		skb_dst_drop(skb);
+
+	return 0;
 }
 
 static const struct bpf_func_proto bpf_skb_change_proto_proto = {
@@ -3583,12 +3582,13 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 		}
 
 		/* Match skb->protocol to new outer l3 protocol */
-		if (skb->protocol == htons(ETH_P_IP) &&
-		    flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
-			bpf_skb_change_protocol(skb, ETH_P_IPV6);
-		else if (skb->protocol == htons(ETH_P_IPV6) &&
-			 flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
-			bpf_skb_change_protocol(skb, ETH_P_IP);
+		if (flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
+			skb->protocol = htons(ETH_P_IPV6);
+		else if (flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
+			skb->protocol = htons(ETH_P_IP);
+
+		if (skb_valid_dst(skb))
+			skb_dst_drop(skb);
 	}
 
 	if (skb_is_gso(skb)) {
@@ -3616,6 +3616,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 			      u64 flags)
 {
+	bool decap = flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK;
 	int ret;
 
 	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
@@ -3638,13 +3639,16 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 	if (unlikely(ret < 0))
 		return ret;
 
-	/* Match skb->protocol to new outer l3 protocol */
-	if (skb->protocol == htons(ETH_P_IP) &&
-	    flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
-		bpf_skb_change_protocol(skb, ETH_P_IPV6);
-	else if (skb->protocol == htons(ETH_P_IPV6) &&
-		 flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
-		bpf_skb_change_protocol(skb, ETH_P_IP);
+	if (decap) {
+		/* Match skb->protocol to new outer l3 protocol */
+		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
+			skb->protocol = htons(ETH_P_IPV6);
+		else if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
+			skb->protocol = htons(ETH_P_IP);
+
+		if (skb_valid_dst(skb))
+			skb_dst_drop(skb);
+	}
 
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
-- 
2.53.0


