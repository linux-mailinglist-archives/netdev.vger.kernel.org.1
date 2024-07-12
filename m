Return-Path: <netdev+bounces-110997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8342992F374
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 03:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC8DDB2112F
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 01:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A8A524C;
	Fri, 12 Jul 2024 01:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="UFepnNHQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3530B139D
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720747838; cv=none; b=RKjGXL5kdiJyhPlGDCJ10Lc7+ckHDaihdNNVvFTdWLmoyxfw5dcmTYv68Dwke0VN5KO14Yuxt31SOOey/EGJ5qvASPv8ulaNDdulaF8O1vrX3HH36DiG2sNzsT0BsVAkKzXkxBuOTsVy2ephMkPyeWpLUgsMF5baKVcg+CGu6Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720747838; c=relaxed/simple;
	bh=NlCD2N/GTA25z+Lv3QJ4ioPnzGqSDCz42FqtGeEExpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YV2J6H9p/gFMraiAkLK6F6aE2QlsfTTyp/C5ZBrV103JXSKudwDqriU3xzQrpHJgpImqhi3tUUFv5tykgDzb+BZt2jQZVHdv9NcTvVLULbzzJLLXhXHiVix2ntnzS5L1oP2NsHQzGoU2hjGnl20YuWBbnXgGS4F9FNsCtU6YcR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=UFepnNHQ; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4E9813FE22
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 01:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720747833;
	bh=KlZHJQ1gZb5CHVxW02hQaRdYCM2wgPQ+hnanLrc4+9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=UFepnNHQfPcmZ4JWHsvAMkvkvWkM1pcjtRP/xDtHksN1Tjjosq+QS23y4cNaRFGUn
	 mtMbhVcFpWvpKH5VViP5GJ9NomzHgoh7tRI4N23GZMUWGNNBOb1chf8PEIOucZQ2Lu
	 bKE/j6rPVQ2E7uwNtyym1aw+I7PDRTL7ARbmEf5ynmRhiWToN74PVuG+WWhFXkN5kf
	 KtbfV90eDAVRf/Lk/10SDnd3IphveI6elPx5SLbY323kjI4azw/1DJnTHZBb8C/80c
	 0J4FYzdaHfFlsQ14/bM179SzWB3HWvE94PcJL80tjMzmfRZ/16pCViV7lRQ2Mpic+F
	 vAot5HdKEIWWg==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-70af57e0df0so1238793b3a.0
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 18:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720747831; x=1721352631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlZHJQ1gZb5CHVxW02hQaRdYCM2wgPQ+hnanLrc4+9g=;
        b=vWGYOfKsDn8yizGPsSlAhiMeo3K3Q2bYj1uHBA0yPtm1NqsugqoD33XBTWtrnlL4Ri
         YejifuhNCo1Whrw4dbMrYDq9AL+VxM+DgwE1WMfiXDfceql0JUMc5PT88woKzzCK2AhD
         qfm9WWaLHLt4MJDXSdIkLUoitokvDHoLExVA48hd2N8MNRr1Q+i4NHY4Z2kB+DKnOl5e
         s2mgLBavVWSbbzO2JCEXN1TthYf5RvX5IUZz8rTcNBNGdnAcixVkfK0oYo1jSfz8t8Xp
         SHxvmDdWNNJAuUxw1/+Ce+vxQ/ou5gOGXOySE5D16mM3Bp73Eaxf4egDfHPhGHFixsSu
         us8w==
X-Forwarded-Encrypted: i=1; AJvYcCUd8YLnXvnLLFX39N+yZ6fOxeiAQM0q4FKKShiqvaY/GY8upgdumsw4ny27eQQHPlTznkzKS+MN/zkE0IKuXANk3zXj+5hh
X-Gm-Message-State: AOJu0Yz0qQrXfIW0TAOlgqRfqXiHCLYcuYTOko+EWektmbihqNKbdfKV
	ddKxS9S8v23qqf4E/kzXj8iBVd4BAQrAdjRZbXVP2Z2xVTHAt1v8tvybm3yUnpL9eImyUqZWKyq
	PZZgHzFW3l3Zk0raETLNseQ8Cxpud8egjWQqFPjNXFKq4PVF7XkPA+zG8Rptm0L6dJ6Uyfg==
X-Received: by 2002:a05:6a00:1142:b0:706:5cd9:655d with SMTP id d2e1a72fcca58-70b435f0138mr12853713b3a.22.1720747831459;
        Thu, 11 Jul 2024 18:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/ixhoVzGPJtCBK2hGPZAloXzsTCLG5S6o+60wt8uR9BFh6w0LpLnsU1SfNGIGVF6cQHuZGg==
X-Received: by 2002:a05:6a00:1142:b0:706:5cd9:655d with SMTP id d2e1a72fcca58-70b435f0138mr12853691b3a.22.1720747830989;
        Thu, 11 Jul 2024 18:30:30 -0700 (PDT)
Received: from chengendu.. (2001-b011-381c-1f42-c48a-cb4d-0ee1-65a8.dynamic-ip6.hinet.net. [2001:b011:381c:1f42:c48a:cb4d:ee1:65a8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4398e086sm6317024b3a.164.2024.07.11.18.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 18:30:30 -0700 (PDT)
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
Subject: [PATCH v9] af_packet: Handle outgoing VLAN packets without hardware offloading
Date: Fri, 12 Jul 2024 09:29:56 +0800
Message-ID: <20240712012956.10408-1-chengen.du@canonical.com>
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
 net/packet/af_packet.c | 86 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index ea3ebc160e25..84e8884a77e3 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -538,6 +538,61 @@ static void *packet_current_frame(struct packet_sock *po,
 	return packet_lookup_frame(po, rb, rb->head, status);
 }
 
+static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *dev)
+{
+	struct vlan_hdr vhdr, *vh;
+	u8 *skb_orig_data = skb->data;
+	int skb_orig_len = skb->len;
+	unsigned int header_len;
+
+	if (!dev)
+		return 0;
+
+	/* In the SOCK_DGRAM scenario, skb data starts at the network
+	 * protocol, which is after the VLAN headers. The outer VLAN
+	 * header is at the hard_header_len offset in non-variable
+	 * length link layer headers. If it's a VLAN device, the
+	 * min_header_len should be used to exclude the VLAN header
+	 * size.
+	 */
+	if (dev->min_header_len == dev->hard_header_len)
+		header_len = dev->hard_header_len;
+	else if (is_vlan_dev(dev))
+		header_len = dev->min_header_len;
+	else
+		return 0;
+
+	skb_push(skb, skb->data - skb_mac_header(skb));
+	vh = skb_header_pointer(skb, header_len, sizeof(vhdr), &vhdr);
+	if (skb_orig_data != skb->data) {
+		skb->data = skb_orig_data;
+		skb->len = skb_orig_len;
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
+		u8 *skb_orig_data = skb->data;
+		int skb_orig_len = skb->len;
+
+		skb_push(skb, skb->data - skb_mac_header(skb));
+		proto = __vlan_get_protocol(skb, proto, NULL);
+		if (skb_orig_data != skb->data) {
+			skb->data = skb_orig_data;
+			skb->len = skb_orig_len;
+		}
+	}
+
+	return proto;
+}
+
 static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
 {
 	del_timer_sync(&pkc->retire_blk_timer);
@@ -1007,10 +1062,16 @@ static void prb_clear_rxhash(struct tpacket_kbdq_core *pkc,
 static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
 			struct tpacket3_hdr *ppd)
 {
+	struct packet_sock *po = container_of(pkc, struct packet_sock, rx_ring.prb_bdqc);
+
 	if (skb_vlan_tag_present(pkc->skb)) {
 		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
 		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
 		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+	} else if (unlikely(po->sk.sk_type == SOCK_DGRAM && eth_type_vlan(pkc->skb->protocol))) {
+		ppd->hv1.tp_vlan_tci = vlan_get_tci(pkc->skb, pkc->skb->dev);
+		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
+		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 	} else {
 		ppd->hv1.tp_vlan_tci = 0;
 		ppd->hv1.tp_vlan_tpid = 0;
@@ -2428,6 +2489,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
 			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
 			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (unlikely(sk->sk_type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
+			h.h2->tp_vlan_tci = vlan_get_tci(skb, skb->dev);
+			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
+			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 		} else {
 			h.h2->tp_vlan_tci = 0;
 			h.h2->tp_vlan_tpid = 0;
@@ -2457,7 +2522,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
 	sll->sll_family = AF_PACKET;
 	sll->sll_hatype = dev->type;
-	sll->sll_protocol = skb->protocol;
+	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
+		vlan_get_protocol_dgram(skb) : skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
 	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
@@ -3482,7 +3548,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		/* Original length was stored in sockaddr_ll fields */
 		origlen = PACKET_SKB_CB(skb)->sa.origlen;
 		sll->sll_family = AF_PACKET;
-		sll->sll_protocol = skb->protocol;
+		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
+			vlan_get_protocol_dgram(skb) : skb->protocol;
 	}
 
 	sock_recv_cmsgs(msg, sk, skb);
@@ -3539,6 +3606,21 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
 			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
 			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (unlikely(sock->type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
+			struct sockaddr_ll *sll = &PACKET_SKB_CB(skb)->sa.ll;
+			struct net_device *dev;
+
+			rcu_read_lock();
+			dev = dev_get_by_index_rcu(sock_net(sk), sll->sll_ifindex);
+			if (dev) {
+				aux.tp_vlan_tci = vlan_get_tci(skb, dev);
+				aux.tp_vlan_tpid = ntohs(skb->protocol);
+				aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+			} else {
+				aux.tp_vlan_tci = 0;
+				aux.tp_vlan_tpid = 0;
+			}
+			rcu_read_unlock();
 		} else {
 			aux.tp_vlan_tci = 0;
 			aux.tp_vlan_tpid = 0;
-- 
2.43.0


