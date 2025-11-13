Return-Path: <netdev+bounces-238337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92513C57652
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70732420C1F
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3446C352F9A;
	Thu, 13 Nov 2025 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="B9t/ZtTK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBCD35292E
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036575; cv=none; b=MEImuQ8pkN5RnpmkTWaotgyWCXODn4IOC5fHkAmmvscfw26B24cGQLeDTRP1zm4slrvMh7f6dVjTIEaxs6DQfjQ23II4SX83VWSVFy7Q6lGVjDNGW9OAGQ2zn5dgmCcCLFLqQxFqX7q2Co9rYUN7qlrH7OKYrc37hey5vymzNAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036575; c=relaxed/simple;
	bh=5tqvMwk42+H+Hk6o00zSTF+C9Uo5MsFrv/AXd1AxK1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=miMSiwWkHNqoUrD9Zn25+SlID4nEeYTQr9iKuf5Tk75IPJdckepyAlo7od9hp2t1QDsY2JIZUnnbBH+nwrppb9So1y9kLARiZxwLsx6bqLVYRusnQsJe2cUXOFqIEWBCjOJ2+aklohXFISXcDwsZWgba3bNLZ08Un0O6lU38Nl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=B9t/ZtTK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477775d3728so7586175e9.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 04:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1763036571; x=1763641371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AYLFqISrGiwoCd/lCer/s501KkmgteGD7tCx9Y4HU6Q=;
        b=B9t/ZtTKBNGYxK8sdf4yju4rBjykbuLx6LsSY+dDmx8653bQbTP12tArC8icla9YBh
         Su7G9zXxDPexMyV3PkC90etg/JAeXtoyWnP5ENV3zrsqxIutsB8wGLsGkED5B90iiJdc
         4iaM6WzmMX43wstqQ1T25CoiRg0vyp9AMd3Ia3KkwkHogTNJpHel6vWe32bGz3+RsWX7
         +7Gi+5WPXIpVHLEp3otatkBluYHoJkh41fGNu8djfpHjhSl1i3K41kEFS9dCaLRrO9DP
         /F62bbtdZatk6xAgZvrtqHiBTF8v8iHYBwcjuWVx/cpU2YVxtzrcEMf2ALRvPP4cY16A
         BvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763036571; x=1763641371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYLFqISrGiwoCd/lCer/s501KkmgteGD7tCx9Y4HU6Q=;
        b=e32lDz9qIRNtFO4x7H1CNdmFs1zyL/LQLu7bxznvqNrfpDcjJNlgPD3Bg3GQCO+gun
         kHt3NiZOtDYoll+R7VnRdy5rGUZc7w7BC8bS8FIPbYOjPM0zMK3j80WV2yhyg+Y13sof
         OlJAsGR6b5VnxudIkeY7uPCxK+r/IvopRXPuHNlsUtFe9LP7oOVDoECaF9aoxNTcoSzd
         AxovNwc1vgqHIebd6VqT3kLRv/l3jHGjBRpeMZ1JqiZb/M1X84TM0AfOfIwR3n9ICquF
         pbvNWxVgrfRoObkPVlVPIAX7VG4TFNMd2+JPwMuiksrY47z1gTg9TUbXgxVsnP6Ou8jh
         qIjA==
X-Gm-Message-State: AOJu0Yxq8DRMyFYzWrKWaWKyVy6YqQtb+O5qY5I3aHwpVP2X9rR8hdgU
	wTGQHAnnEYyH43DkBNQikHxqxlQP08IbHnZc6YqYnwf5uZGGh2HJuHw/fIcvTHuoH51FzP/cgk9
	MASe79aE=
X-Gm-Gg: ASbGncth9oCiQGSX02f16xKFqsYdkNYrT8lRgR8rCwOwkcMD6wAShL6LzVKBOXUk0xo
	Qa7u7/qr5gGIvGFIW59gzkwDrB+7m7x6gK6AjlAUxxLME+sTtOgF6+uvQ5L0Q35FvRzOcGChbCd
	BrMp/d2kxozjUYzVJQNE+pluHWXWS0bE+uiZbmcv2u9jvb32WQ/4okWyMorGQ1ovpOst1SCxC1t
	U1z5dZ4EqWEx6FssKnPEVgC/+fkplGbe7bl3s5rDaCXVLkvOnYnxUSwVgwgfaUt3XvWc+oBBzxn
	ZgVQORl1ZQLDuz6O4J5OxAaKDrPWBoraHd9KiFGe2VEvqMeaDuHi02KWeGHyExspnB9iNEV2NZP
	Oy9dDAt0raiG/u9GrbWzbAwx8xQAzDpPd3zAAwQji3wl2CFRWVrjlVMt/ijD+WgWzLXTSzCp4CH
	Ckfcm7Ug==
X-Google-Smtp-Source: AGHT+IG1Snqo8vv+K/pwW6ezbILm7N5kF5539/ddDpCGwr3N7gMmQhcVkVHdfundDyt/ggzb/nnIkg==
X-Received: by 2002:a05:600c:4fc9:b0:45b:80ff:58f7 with SMTP id 5b1f17b1804b1-477870b5e1fmr56686155e9.36.1763036570462;
        Thu, 13 Nov 2025 04:22:50 -0800 (PST)
Received: from fedora ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e2ad4csm89601205e9.1.2025.11.13.04.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 04:22:50 -0800 (PST)
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC net-next] ovpn: allocate smaller skb when TCP headroom exceeds u16
Date: Thu, 13 Nov 2025 13:21:43 +0100
Message-ID: <20251113122143.357579-1-ralf@mandelbit.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

While testing openvpn over TCP under high traffic conditions,
specifically on the same machine using net namespaces (with veth pairs
interconnecting them), we consistently hit a warning in
skb_reset_network_header. The culprit is an attempt to store an offset
(skb->data - skb->head) larger than U16_MAX in skb->network_header,
which is a u16. This leads to packet drops.

In ovpn_tcp_recv, we're handed an skb from __strp_rcv and need to
linearize it and pull up to the beginning of the openvpn packet. If it's
a data-channel packet, we then pull an additional 24 bytes of openvpn
encapsulation header so that skb->data points to the inner IP packet.
This is necessary for authentication, decryption, and reinjection into
the networking stack of the decapsulated packet, but when the skb is too
large, the network header offset overflows the field.

AFAWCT, these oversized skbs can result from:
- GRO,
- TCP skb coalescing (tcp_try_coalesce, skb_try_coalesce),
- streamparser (__strp_rcv appends more skbs when an openvpn packet
  spans multiple skbs).

Note that this issue is likely affecting espintcp as well, since its
logic similarly involves extracting discrete packets from a coalesced
TCP stream handed off by streamparser, and reinjecting them into the
stack.

We've brainstormed a few possible directions, though we haven't yet
assessed their feasibility:
- introduce a u32 field in struct tcp_sock to limit skb->len during TCP
  coalescing (each socket user can set the limit if needed);
- modify strp to build an skb containing only the relevant frags for the
  current openvpn packet in frag_list.

In this patch, we implement a solution entirely contained within ovpn:
we allocate a new skb and copy the content of the current openvpn packet
into it. This avoids the large headroom issue, but it’s not ideal
because the kernel keeps coalescing skbs while we effectively undo that
work, which isn’t very efficient.

We're sending this RFC to gather ideas and suggestions on how best to
address this issue. Any thoughts or guidance would be appreciated.

Thanks.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/crypto_aead.c |  3 --
 drivers/net/ovpn/proto.h       |  4 ++
 drivers/net/ovpn/tcp.c         | 80 +++++++++++++++++++++++++++-------
 3 files changed, 68 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 2cca759feffa..3b2182984a54 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -23,9 +23,6 @@
 #include "proto.h"
 #include "skb.h"
 
-#define OVPN_AUTH_TAG_SIZE	16
-#define OVPN_AAD_SIZE		(OVPN_OPCODE_SIZE + OVPN_NONCE_WIRE_SIZE)
-
 #define ALG_NAME_AES		"gcm(aes)"
 #define ALG_NAME_CHACHAPOLY	"rfc7539(chacha20,poly1305)"
 
diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
index b7d285b4d9c1..0a9d54386ebb 100644
--- a/drivers/net/ovpn/proto.h
+++ b/drivers/net/ovpn/proto.h
@@ -49,6 +49,10 @@
 
 #define OVPN_PEER_ID_UNDEF		0x00FFFFFF
 
+#define OVPN_AUTH_TAG_SIZE	16
+#define OVPN_AAD_SIZE		(OVPN_OPCODE_SIZE + OVPN_NONCE_WIRE_SIZE)
+#define OVPN_HEADER_SIZE	(OVPN_AUTH_TAG_SIZE + OVPN_AAD_SIZE)
+
 /**
  * ovpn_opcode_from_skb - extract OP code from skb at specified offset
  * @skb: the packet to extract the OP code from
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index b7348da9b040..301fcb1c0495 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -70,39 +70,87 @@ static void ovpn_tcp_to_userspace(struct ovpn_peer *peer, struct sock *sk,
 	peer->tcp.sk_cb.sk_data_ready(sk);
 }
 
-static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
+/* takes ownership of orig_skb */
+static struct sk_buff *ovpn_tcp_skb_packet(const struct ovpn_peer *peer,
+					   struct sk_buff *orig_skb,
+					   const int full_len, const int offset)
 {
-	struct ovpn_peer *peer = container_of(strp, struct ovpn_peer, tcp.strp);
-	struct strp_msg *msg = strp_msg(skb);
-	size_t pkt_len = msg->full_len - 2;
-	size_t off = msg->offset + 2;
-	u8 opcode;
+	struct sk_buff *ovpn_skb = orig_skb;
+	const int pkt_len = full_len - 2;
+	int pkt_offset = offset + 2;
+	int err;
+
+	/* If the final headroom will overflow a u16 we will not be able to
+	 * reset the network header to it so we need to create a new smaller
+	 * skb with the content of this packet.
+	 */
+	if (unlikely(skb_headroom(orig_skb) + pkt_offset + OVPN_HEADER_SIZE >
+		     U16_MAX)) {
+		ovpn_skb = netdev_alloc_skb(peer->ovpn->dev, full_len);
+		if (!ovpn_skb) {
+			ovpn_skb = orig_skb;
+			goto err;
+		}
+
+		skb_copy_header(ovpn_skb, orig_skb);
+		pkt_offset = 2;
+
+		/* copy the entire openvpn packet + 2 bytes length */
+		err = skb_copy_bits(orig_skb, offset,
+				    skb_put(ovpn_skb, full_len), full_len);
+		kfree(orig_skb);
+		if (err) {
+			net_warn_ratelimited("%s: skb_copy_bits failed for peer %u\n",
+					     netdev_name(peer->ovpn->dev),
+					     peer->id);
+			goto err;
+		}
+	}
 
 	/* ensure skb->data points to the beginning of the openvpn packet */
-	if (!pskb_pull(skb, off)) {
+	if (!pskb_pull(ovpn_skb, pkt_offset)) {
 		net_warn_ratelimited("%s: packet too small for peer %u\n",
-				     netdev_name(peer->ovpn->dev), peer->id);
+				     netdev_name(peer->ovpn->dev),
+				     peer->id);
 		goto err;
 	}
 
 	/* strparser does not trim the skb for us, therefore we do it now */
-	if (pskb_trim(skb, pkt_len) != 0) {
+	if (pskb_trim(ovpn_skb, pkt_len) != 0) {
 		net_warn_ratelimited("%s: trimming skb failed for peer %u\n",
-				     netdev_name(peer->ovpn->dev), peer->id);
+				     netdev_name(peer->ovpn->dev),
+				     peer->id);
 		goto err;
 	}
 
+	return ovpn_skb;
+err:
+	kfree(ovpn_skb);
+	return NULL;
+}
+
+static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
+{
+	struct ovpn_peer *peer = container_of(strp, struct ovpn_peer, tcp.strp);
+	struct strp_msg *msg = strp_msg(skb);
+	struct sk_buff *ovpn_skb = NULL;
+	u8 opcode;
+
+	ovpn_skb = ovpn_tcp_skb_packet(peer, skb, msg->full_len, msg->offset);
+	if (!ovpn_skb)
+		goto err;
+
 	/* we need the first 4 bytes of data to be accessible
 	 * to extract the opcode and the key ID later on
 	 */
-	if (!pskb_may_pull(skb, OVPN_OPCODE_SIZE)) {
+	if (!pskb_may_pull(ovpn_skb, OVPN_OPCODE_SIZE)) {
 		net_warn_ratelimited("%s: packet too small to fetch opcode for peer %u\n",
 				     netdev_name(peer->ovpn->dev), peer->id);
 		goto err;
 	}
 
 	/* DATA_V2 packets are handled in kernel, the rest goes to user space */
-	opcode = ovpn_opcode_from_skb(skb, 0);
+	opcode = ovpn_opcode_from_skb(ovpn_skb, 0);
 	if (unlikely(opcode != OVPN_DATA_V2)) {
 		if (opcode == OVPN_DATA_V1) {
 			net_warn_ratelimited("%s: DATA_V1 detected on the TCP stream\n",
@@ -113,8 +161,8 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
 		/* The packet size header must be there when sending the packet
 		 * to userspace, therefore we put it back
 		 */
-		skb_push(skb, 2);
-		ovpn_tcp_to_userspace(peer, strp->sk, skb);
+		skb_push(ovpn_skb, 2);
+		ovpn_tcp_to_userspace(peer, strp->sk, ovpn_skb);
 		return;
 	}
 
@@ -126,7 +174,7 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
 	if (WARN_ON(!ovpn_peer_hold(peer)))
 		goto err_nopeer;
 
-	ovpn_recv(peer, skb);
+	ovpn_recv(peer, ovpn_skb);
 	return;
 err:
 	/* take reference for deferred peer deletion. should never fail */
@@ -135,7 +183,7 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
 	schedule_work(&peer->tcp.defer_del_work);
 	dev_dstats_rx_dropped(peer->ovpn->dev);
 err_nopeer:
-	kfree_skb(skb);
+	kfree_skb(ovpn_skb);
 }
 
 static int ovpn_tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-- 
2.51.1


