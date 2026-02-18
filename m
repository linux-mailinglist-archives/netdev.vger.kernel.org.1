Return-Path: <netdev+bounces-259357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGfBJWQclmntaAIAu9opvQ
	(envelope-from <netdev+bounces-259357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 21:09:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA501595A1
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 21:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E8483012241
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 20:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D22B347FED;
	Wed, 18 Feb 2026 20:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ocf9IRsG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F78311C31
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771445344; cv=none; b=NPGHDI08Mra3vC/GA4Yq5cTLa4WXwiLyMZHonnfPbGcQ3JdLLb2jV2g6cy+n0L4i3nkvMjn9vu+FWInyq12Qn55G38JR/lP1Uc/Md3OEoHYzakmsy05EomDqMyX59YvWqHAzSx+dHoXMQ6AL+Bh8bslbmmj0bwSKz6t04cU8tpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771445344; c=relaxed/simple;
	bh=4u/0zMZud2DfpZt3P7fhgLoxuMsmYU7Ao/tK6EHDaTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J+IhmBLgxtS83GBSpk5KwjX1JmCRWnnwqCzCZmjjluE0xVAJKzVGyk0vlGecAuUOiC7KxFUJgFWIDdMe1BCk/KCA4JMIZ+5HcPWiwRR68eWgcO+q4f52WNGYzE6wSjphZZ8KIioZHkIaPpNaVDjMkNWZnm2XweXyOkfXOBNiI88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ocf9IRsG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483703e4b08so2045975e9.1
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 12:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1771445341; x=1772050141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a2AEZP98CjZlQ+1qd6TgCVoriHSyX4H+oEt4CstN+kE=;
        b=Ocf9IRsGmVUxcrdOrNJbqR1rTgtbKAQFOi7RrLkJ26SKslr4PSV/sSNqwp/MeLIXBv
         8Rb1vJn++0+PMk5QaSHn4lMwRmkgNXi/N5yp5IeCYvCa2JZGEYPEy60Wag6qlFWCKWL2
         //CHfVysZzNAe3a2yH5NlJy37EIRXRwlWsWLuVF+eQglEvxnCuzS1qFLxiBj+TUmbdFE
         5MSBpwlzmTFaT+d3urKe20/2IBVqY5nKEKQnJeZC4k32/w512tNweyyT5Tr7VlVZXpqW
         rXX0wTlDi4hjeu+bqv0sYQLRN7cgezQtx+2BBrUYWb+CD8UTyioeh0E1crhCx/e6GoEW
         QutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771445341; x=1772050141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2AEZP98CjZlQ+1qd6TgCVoriHSyX4H+oEt4CstN+kE=;
        b=ILyQl63NWF0u3tDzyy5hKwT2wAY1SeqOv/yxsPnmSh0FQJ1OsyvnazVbBPcxBLQr+S
         ENT3F3VpabxYam4+zhLZ1PmydDP5wRkAYl1lKstDUyzRuMXXleInpwUx8yoG4TE4tYdc
         F1yY/7dB6uETArASO2vdXQ+Q0D8t/SKjxHAoCrwAYxacm6l3ZmtVmCwOIKwbEppbzMeb
         HFD09YdzUt9SmEsmvklnkMAa0MY7nhikdQx325z3JrZvGyjxOzAa4z7G1HDFnvbFpUfh
         Igp5BUxlStcu3B8hlc5sLD2h4J6pLaElVCG88P4CytkagVyefv+It/SWdTK2yk1Sgbph
         luIA==
X-Gm-Message-State: AOJu0Yy/dHt0mFfqC1QYSb+gLPvzdCx4XR4Vt0EjrFfHUy+c3KnjD5Dj
	b9NZL1qjzPrIJchHRcua+C4PdhncSWPbF8q5NUqmRuFlQy1RbeMUsEjrb6zre3eG96Y6UASZk8w
	j0SeHuddGwlpuwFjRwqS3C5W61ulrUmq6irwWr26HjLf4DT2og5NJxnzoNeAajcXY
X-Gm-Gg: AZuq6aKjB7jvYn+aAY7NfRgzILznfMi8bIZyS9VR2OOq18pr3qG8kYxA3FvdbX4wPbI
	VJEcxhuI5DDrPscUBOddzSvoVG7/Kwz2xDpHkW+GfATFWSrHXa+Iq0ayjnto2F0YP6TbOVcvHuc
	OiS4fw+1foKZ/cW6b9pEzYjzAT6Z1xkNlIOXa1nF689NAdQmWQ3bkqwAPdVXbqdu7HwQInvZpi2
	I6AD0fR8UIaaPh/I0HBRk6Rj2D2tGJs3reXPXQrSS74HGLimRw6S0K6yLalCdxMi0XRSJX/ssDp
	BkV4LCDAwH5jJZYe7B50X4TN3Oi25Ogf1dtNhrUo9yUPqzhMbaWWnDxJKpIRsbfIrA15uFDhZtt
	TOygtaKXpwv+bodWOO9WbtltetZyYw4kUAISRYtB/d8JJGfgX81grmcdhvPMH+GirK/vRJjQsWU
	KwM/YnDBrusx+FFmptr5z/U1mIOa/H9JSE+Ck=
X-Received: by 2002:a7b:c38a:0:b0:47e:e051:79ee with SMTP id 5b1f17b1804b1-48398c5ab5emr39165575e9.3.1771445341043;
        Wed, 18 Feb 2026 12:09:01 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:3dd6:2395:a76d:c54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836ff00332sm382571725e9.2.2026.02.18.12.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 12:09:00 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net] ovpn: tcp - fix packet extraction from stream
Date: Wed, 18 Feb 2026 21:08:26 +0100
Message-ID: <20260218200826.24025-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259357-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[openvpn.net:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvpn.net:mid,openvpn.net:dkim,openvpn.net:email,mandelbit.com:email,queasysnail.net:email]
X-Rspamd-Queue-Id: DAA501595A1
X-Rspamd-Action: no action

From: Ralf Lici <ralf@mandelbit.com>

When processing TCP stream data in ovpn_tcp_recv, we receive large
cloned skbs from __strp_rcv that may contain multiple coalesced packets.
The current implementation has two bugs:

1. Header offset overflow: Using pskb_pull with large offsets on
   coalesced skbs causes skb->data - skb->head to exceed the u16 storage
   of skb->network_header. This causes skb_reset_network_header to fail
   on the inner decapsulated packet, resulting in packet drops.

2. Unaligned protocol headers: Extracting packets from arbitrary
   positions within the coalesced TCP stream provides no alignment
   guarantees for the packet data causing performance penalties on
   architectures without efficient unaligned access. Additionally,
   openvpn's 2-byte length prefix on TCP packets causes the subsequent
   4-byte opcode and packet ID fields to be inherently misaligned.

Fix both issues by allocating a new skb for each openvpn packet and
using skb_copy_bits to extract only the packet content into the new
buffer, skipping the 2-byte length prefix. Also, check the length before
invoking the function that performs the allocation to avoid creating an
invalid skb.

If the packet has to be forwarded to userspace the 2-byte prefix can be
pushed to the head safely, without misalignment.

As a side effect, this approach also avoids the expensive linearization
that pskb_pull triggers on cloned skbs with page fragments. In testing,
this resulted in TCP throughput improvements of up to 74%.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/ovpn/tcp.c | 53 ++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index ec2bbc28c196..5499c1572f3e 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -70,37 +70,56 @@ static void ovpn_tcp_to_userspace(struct ovpn_peer *peer, struct sock *sk,
 	peer->tcp.sk_cb.sk_data_ready(sk);
 }
 
-static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
+static struct sk_buff *ovpn_tcp_skb_packet(const struct ovpn_peer *peer,
+					   struct sk_buff *orig_skb,
+					   const int pkt_len, const int pkt_off)
 {
-	struct ovpn_peer *peer = container_of(strp, struct ovpn_peer, tcp.strp);
-	struct strp_msg *msg = strp_msg(skb);
-	size_t pkt_len = msg->full_len - 2;
-	size_t off = msg->offset + 2;
-	u8 opcode;
+	struct sk_buff *ovpn_skb;
+	int err;
 
-	/* ensure skb->data points to the beginning of the openvpn packet */
-	if (!pskb_pull(skb, off)) {
-		net_warn_ratelimited("%s: packet too small for peer %u\n",
-				     netdev_name(peer->ovpn->dev), peer->id);
+	/* create a new skb with only the content of the current packet */
+	ovpn_skb = netdev_alloc_skb(peer->ovpn->dev, pkt_len);
+	if (unlikely(!ovpn_skb))
 		goto err;
-	}
 
-	/* strparser does not trim the skb for us, therefore we do it now */
-	if (pskb_trim(skb, pkt_len) != 0) {
-		net_warn_ratelimited("%s: trimming skb failed for peer %u\n",
+	skb_copy_header(ovpn_skb, orig_skb);
+	err = skb_copy_bits(orig_skb, pkt_off, skb_put(ovpn_skb, pkt_len),
+			    pkt_len);
+	if (unlikely(err)) {
+		net_warn_ratelimited("%s: skb_copy_bits failed for peer %u\n",
 				     netdev_name(peer->ovpn->dev), peer->id);
+		kfree_skb(ovpn_skb);
 		goto err;
 	}
 
-	/* we need the first 4 bytes of data to be accessible
+	consume_skb(orig_skb);
+	return ovpn_skb;
+err:
+	kfree_skb(orig_skb);
+	return NULL;
+}
+
+static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
+{
+	struct ovpn_peer *peer = container_of(strp, struct ovpn_peer, tcp.strp);
+	struct strp_msg *msg = strp_msg(skb);
+	int pkt_len = msg->full_len - 2;
+	u8 opcode;
+
+	/* we need at least 4 bytes of data in the packet
 	 * to extract the opcode and the key ID later on
 	 */
-	if (!pskb_may_pull(skb, OVPN_OPCODE_SIZE)) {
+	if (unlikely(pkt_len < OVPN_OPCODE_SIZE)) {
 		net_warn_ratelimited("%s: packet too small to fetch opcode for peer %u\n",
 				     netdev_name(peer->ovpn->dev), peer->id);
 		goto err;
 	}
 
+	/* extract the packet into a new skb */
+	skb = ovpn_tcp_skb_packet(peer, skb, pkt_len, msg->offset + 2);
+	if (unlikely(!skb))
+		goto err;
+
 	/* DATA_V2 packets are handled in kernel, the rest goes to user space */
 	opcode = ovpn_opcode_from_skb(skb, 0);
 	if (unlikely(opcode != OVPN_DATA_V2)) {
@@ -113,7 +132,7 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
 		/* The packet size header must be there when sending the packet
 		 * to userspace, therefore we put it back
 		 */
-		skb_push(skb, 2);
+		*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(pkt_len);
 		ovpn_tcp_to_userspace(peer, strp->sk, skb);
 		return;
 	}
-- 
2.52.0


