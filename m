Return-Path: <netdev+bounces-100433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653DE8FAA3E
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 07:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1164D282A45
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 05:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3311313DDA3;
	Tue,  4 Jun 2024 05:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="MBKCrui6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEA0132135
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 05:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717480275; cv=none; b=dAQBZPrYvMZIh/PsH726AeoW2yYb351iu/nzAZO40mUan3ZPmLpC/ibyDH/sQ8GIcNViCZ/2n8h5KkL3fdfV5W+Ftroe4qsCsZxyKfVa0fdwi5rDvL+oC4z4MYpp7j45EaOppe9KGHnCyaMYTG2rQo7HNu2y0LnPbUEGNAvZJWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717480275; c=relaxed/simple;
	bh=uss0X1VN88HbrrQxklnUMnnojK0g+Phe6pPxPPeCyyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nn7MX9u9m7ydv8+GN9sLtytzQ/2iSEiCXPSe6Awoz+oP+4r+TgDRJoqraZSKA6kYw6qEnB7lFBTOJL3h+CEazCRd8jRb/cgMJeesudQUdKi9uj8gUCY5suMNxgyl4RMfocGYBLcIiwYR1ZNCvDkfBik2DJQM8y2S7AZsl1ejgRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=MBKCrui6; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 71EC03F2A4
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 05:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717480264;
	bh=bakozUuCaN+IM6untUm+580ISMXPQFrIaEMbe9vcbuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=MBKCrui6MJPxUOCK0h+zzPBX4aaJu01iFda22nFx9inG6/fYYf2AYTCR7rhzlNbkw
	 01zqMUGQ0e8MpEM0QX1yWEaS0edjNTLKMAGlKodmTDlc6jQ02gRCXFMQYmeazGuNwJ
	 YGqc3bwPv5maFM8vSrrSWBuDoahDNlJ1LiOkMSd7LOSMc6nRary0sLQ4PoDc/X7ejT
	 qGCy5VvhQQHbdW7qSGZ+/i43iMWxtnU5wG+DXYPwvcUFJuqFDp/tJwAE66w1+WUTdg
	 7xUnUJYRtme2Q2ou41/6iSqtNThTtpkadWa8HJeOyD3UfhJKv1qTEZ34+OmSXOYGwF
	 GPdHNY5lMS+3g==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-44026115fa1so430191cf.3
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 22:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717480260; x=1718085060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bakozUuCaN+IM6untUm+580ISMXPQFrIaEMbe9vcbuo=;
        b=NNwkEXSVZTMMuVtaPuXUXB3jL4E7bPWY3YTu3xUM6bYdpP2Ikz51nUu9xdL5xic6yS
         K11zkG67Q23UH/g1vuJKXAPn5VwTQVtoNNOJOuEspu+6t+S5FhZy/jviFDkcOBIiA/vN
         H0fyiZdW0SBYD4niUSRpeDIIWQ41bqUGQe/VARfOlX5Lv0PszJ+Q7CCyYM7N8lvgemWx
         7Jwqcnz8CS5yVvhKvaB3UcGAIN8rNUVKEW9iU2G36WaQotnOMkPe1Fso2f3CdrhPq3HY
         5Y3E0XhHlFV1cFDdOMG8Z4tXkuDmV50kAUyXKl65rwEPoCdySnborJEwLQyD8DrmWyBW
         1cQw==
X-Forwarded-Encrypted: i=1; AJvYcCV+LaReoiFN0WXHYzVjkl2ZQC9kkXxx33Ec5ScNIeEmr6auWUFcJNNMSjh4yBUUSJvZRuBEHJg4FslKA094NZaXVlnnFIkO
X-Gm-Message-State: AOJu0Yz/Ri6C17ipjz0g7B38a4aaW1hGaMBplPjzYl3BMBc70cdnGPzt
	qPXsanhil6izF1/m03TeMCKN/KSaCWfjfjjg4cCo/uHPt4EPybrFqHOdM+RKS2i8CMxKIxJt6q5
	73H1JxlCIzFKgLksdk8rxWVzTVv1JFWrziFSI1B9j9rypvK+GkeDqwi57L05qUHupghLr4BKCWY
	Jhpxm/
X-Received: by 2002:ac8:7d42:0:b0:43e:3b8e:670f with SMTP id d75a77b69052e-43ff549f297mr105319941cf.43.1717480260123;
        Mon, 03 Jun 2024 22:51:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNNMHj3DNemo6r8ze9mxeAlNiDseNl5q4JzhvkZ5jaG0w4QaVp8XWGaG9AL3DFRkMjFlevuQ==
X-Received: by 2002:ac8:7d42:0:b0:43e:3b8e:670f with SMTP id d75a77b69052e-43ff549f297mr105319801cf.43.1717480259672;
        Mon, 03 Jun 2024 22:50:59 -0700 (PDT)
Received: from localhost.localdomain ([2001:67c:1560:8007::aac:c40b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff23a1aacsm46472871cf.12.2024.06.03.22.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 22:50:59 -0700 (PDT)
From: Chengen Du <chengen.du@canonical.com>
To: willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kaber@trash.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengen Du <chengen.du@canonical.com>,
	stable@vger.kernel.org
Subject: [PATCH v5] af_packet: Handle outgoing VLAN packets without hardware offloading
Date: Tue,  4 Jun 2024 13:48:23 +0800
Message-ID: <20240604054823.20649-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue initially stems from libpcap. The ethertype will be overwritten
as the VLAN TPID if the network interface lacks hardware VLAN offloading.
In the outbound packet path, if hardware VLAN offloading is unavailable,
the VLAN tag is inserted into the payload but then cleared from the sk_buff
struct. Consequently, this can lead to a false negative when checking for
the presence of a VLAN tag, causing the packet sniffing outcome to lack
VLAN tag information (i.e., TCI-TPID). As a result, the packet capturing
tool may be unable to parse packets as expected.

The TCI-TPID is missing because the prb_fill_vlan_info() function does not
modify the tp_vlan_tci/tp_vlan_tpid values, as the information is in the
payload and not in the sk_buff struct. The skb_vlan_tag_present() function
only checks vlan_all in the sk_buff struct. In cooked mode, the L2 header
is stripped, preventing the packet capturing tool from determining the
correct TCI-TPID value. Additionally, the protocol in SLL is incorrect,
which means the packet capturing tool cannot parse the L3 header correctly.

Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
Link: https://lore.kernel.org/netdev/20240520070348.26725-1-chengen.du@canonical.com/T/#u
Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Chengen Du <chengen.du@canonical.com>
---
 net/packet/af_packet.c | 64 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index ea3ebc160e25..53d51ac87ac6 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -538,6 +538,52 @@ static void *packet_current_frame(struct packet_sock *po,
 	return packet_lookup_frame(po, rb, rb->head, status);
 }
 
+static u16 vlan_get_tci(struct sk_buff *skb)
+{
+	unsigned int vlan_depth = skb->mac_len;
+	struct vlan_hdr vhdr, *vh;
+	u8 *skb_head = skb->data;
+	int skb_len = skb->len;
+
+	if (vlan_depth) {
+		if (WARN_ON(vlan_depth < VLAN_HLEN))
+			return 0;
+		vlan_depth -= VLAN_HLEN;
+	} else {
+		vlan_depth = ETH_HLEN;
+	}
+
+	skb_push(skb, skb->data - skb_mac_header(skb));
+	vh = skb_header_pointer(skb, vlan_depth, sizeof(vhdr), &vhdr);
+	if (skb_head != skb->data) {
+		skb->data = skb_head;
+		skb->len = skb_len;
+	}
+	if (unlikely(!vh))
+		return 0;
+
+	return ntohs(vh->h_vlan_TCI);
+}
+
+static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
+{
+	__be16 proto = skb->protocol;
+
+	if (unlikely(eth_type_vlan(proto))) {
+		u8 *skb_head = skb->data;
+		int skb_len = skb->len;
+
+		skb_push(skb, skb->data - skb_mac_header(skb));
+		proto = __vlan_get_protocol(skb, proto, NULL);
+		if (skb_head != skb->data) {
+			skb->data = skb_head;
+			skb->len = skb_len;
+		}
+	}
+
+	return proto;
+}
+
 static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
 {
 	del_timer_sync(&pkc->retire_blk_timer);
@@ -1011,6 +1057,10 @@ static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
 		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
 		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
 		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+	} else if (unlikely(eth_type_vlan(pkc->skb->protocol))) {
+		ppd->hv1.tp_vlan_tci = vlan_get_tci(pkc->skb);
+		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
+		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 	} else {
 		ppd->hv1.tp_vlan_tci = 0;
 		ppd->hv1.tp_vlan_tpid = 0;
@@ -2428,6 +2478,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
 			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
 			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (unlikely(eth_type_vlan(skb->protocol))) {
+			h.h2->tp_vlan_tci = vlan_get_tci(skb);
+			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
+			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 		} else {
 			h.h2->tp_vlan_tci = 0;
 			h.h2->tp_vlan_tpid = 0;
@@ -2457,7 +2511,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
 	sll->sll_family = AF_PACKET;
 	sll->sll_hatype = dev->type;
-	sll->sll_protocol = skb->protocol;
+	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
+		vlan_get_protocol_dgram(skb) : skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
 	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
@@ -3482,7 +3537,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		/* Original length was stored in sockaddr_ll fields */
 		origlen = PACKET_SKB_CB(skb)->sa.origlen;
 		sll->sll_family = AF_PACKET;
-		sll->sll_protocol = skb->protocol;
+		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
+			vlan_get_protocol_dgram(skb) : skb->protocol;
 	}
 
 	sock_recv_cmsgs(msg, sk, skb);
@@ -3539,6 +3595,10 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
 			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
 			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (unlikely(eth_type_vlan(skb->protocol))) {
+			aux.tp_vlan_tci = vlan_get_tci(skb);
+			aux.tp_vlan_tpid = ntohs(skb->protocol);
+			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 		} else {
 			aux.tp_vlan_tci = 0;
 			aux.tp_vlan_tpid = 0;
-- 
2.43.0


