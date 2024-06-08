Return-Path: <netdev+bounces-101983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8FA900F48
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 04:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3891F21A89
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 02:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8D8D27A;
	Sat,  8 Jun 2024 02:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="k2gM+dqy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DAD8C1A
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 02:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717815259; cv=none; b=F7R71Ie8/bIOSeCzh2oNYImFxVrqsN+gYDr4RDuWAgFd03bmDnU0BDho493+ww2gJtU/kxdRw+dcEyJ71CEnvXJWOw/P3Lpu/Gxx9PAnSodkpOXhOWM0HRcYIPzoKGv+w3npEgCWfutqEpSiKteUCOEeDuUUKMsJfGc09fPBZl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717815259; c=relaxed/simple;
	bh=XCq98BdW69m3pSWZHjycAMDpvLfIsaMbXaCFIS2C+3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oPNk7q5q1gZMbV7NY+uOms21eISDrlPLM6Xo/pRFbhF17s8plfQTtvC9uL/8F+SPeVddrhWknXeOKdzcMVoL39U/gSxp0mU+at5iG/fM0fD7OeEXjn/surn4BUl3U70OJVKpxX0Yl46PR3/0opXeHQ1N+S9R0Hhg4ealxPzU3jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=k2gM+dqy; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 19B123F68D
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 02:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717815249;
	bh=eG9eAD1eUsRWubPosFB8FQEEdV1lJ1Ey5T3UFqQEt+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=k2gM+dqyDfQfUvY5hGp4CJb+UJwPttj9cxehKvFan2rGOjV0Lm+08G0dSXKHPW7h2
	 jOD3qVx+hrFZ3a7qkUPUxYlDCYvVC9wKhrd5sOCFlF/AjX1MygKu+8a3h7FGd5Zd8l
	 mRu0JMti38Nvunom9OyvQiGRS4n+DQckS+PnIKJJTg/EsNm5n8oIitAktCe3wqn2Ct
	 MJWRPmei1wyMq7oGNjOzgNKEmb1mVUPUfU9AMyAwnmObFx19Poem+NwWE9orLrnjaA
	 R0KrBGGzaOsPw9vmp2DxLycIlAIUZWRiwltOBIKrrbbgx58EgW7WRK/87ZwN8gWun7
	 s/AgxiM9aHrlA==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1f6174cfcf8so31588385ad.3
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 19:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717815247; x=1718420047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eG9eAD1eUsRWubPosFB8FQEEdV1lJ1Ey5T3UFqQEt+8=;
        b=r7HlryPzfczw+cUMgcRqp7Y2b9L3Yw+f5SUI45cCHvXhMpLddXam63vZ2JHqzM/sWK
         1dirMQ+SS+Nh4Pczd+DVAo66kGrpNzvBBn13LOspGL7gjlyfFFOKrvHNaXtScIN8g/rI
         RazuFIIWsUp1sMCGbb05/dGZAxjPPFfP/VlFtWidZy6tA5UpjbicrPoWwsQy3YemgYcV
         kjnhznHvde3g2KHgG8xiSxCBC3xg8LO7V3HVNtn85iAzChfvPnZX6gzbx83zOrtkhXUh
         to8WkgqsILAfp4+KC/iWSBtBLTsE/1OqEMgnpX2KBK5pMJjJ5hlBhAOh4JOMQ10XWCjB
         CwNA==
X-Forwarded-Encrypted: i=1; AJvYcCUspboIvpq+TARwVmf47+l/msBVWXPh2soSHIFdRCs/A4NzH8RWDCBr41h0mGgsansrwJEcmauLBLJWipj+E0oLqPbwEgqU
X-Gm-Message-State: AOJu0Yz1LjMsD7T+7dNyqaBBnelN/nZXQqah6FyZUmvsPmBaOh+Xm9xj
	fhzlJH7n4KEGf1MyezSRzvNfA+wyLxqSSTbdGJC5TaDdjrfCMptXfPD1paslfYQ3gVimerwJ1xF
	vVF6pTWZ944YGw+Z66L4DegluV1rsCAeMkkw/4fNAuLWQ9IExx74Zfj92B25ZwChh/sdkTw==
X-Received: by 2002:a17:902:a3cf:b0:1f6:dfbc:7f1c with SMTP id d9443c01a7336-1f6dfbc819amr23641475ad.35.1717815246777;
        Fri, 07 Jun 2024 19:54:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8vB8lIDvNuDmz13l9a3GnvHasLxIcGIP48bamhmPvhcSNiJhTktjZFfgapif4JbMagIYpkw==
X-Received: by 2002:a17:902:a3cf:b0:1f6:dfbc:7f1c with SMTP id d9443c01a7336-1f6dfbc819amr23641255ad.35.1717815245929;
        Fri, 07 Jun 2024 19:54:05 -0700 (PDT)
Received: from chengendu.. (2001-b011-381c-b87f-87a2-26e8-842b-6eef.dynamic-ip6.hinet.net. [2001:b011:381c:b87f:87a2:26e8:842b:6eef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e07edsm41614665ad.214.2024.06.07.19.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 19:54:05 -0700 (PDT)
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
Subject: [PATCH v6] af_packet: Handle outgoing VLAN packets without hardware offloading
Date: Sat,  8 Jun 2024 10:53:47 +0800
Message-ID: <20240608025347.90680-1-chengen.du@canonical.com>
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
 net/packet/af_packet.c | 57 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index ea3ebc160e25..8cffbe1f912d 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -538,6 +538,43 @@ static void *packet_current_frame(struct packet_sock *po,
 	return packet_lookup_frame(po, rb, rb->head, status);
 }
 
+static u16 vlan_get_tci(struct sk_buff *skb)
+{
+	struct vlan_hdr vhdr, *vh;
+	u8 *skb_orig_data = skb->data;
+	int skb_orig_len = skb->len;
+
+	skb_push(skb, skb->data - skb_mac_header(skb));
+	vh = skb_header_pointer(skb, ETH_HLEN, sizeof(vhdr), &vhdr);
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
@@ -1007,10 +1044,16 @@ static void prb_clear_rxhash(struct tpacket_kbdq_core *pkc,
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
+		ppd->hv1.tp_vlan_tci = vlan_get_tci(pkc->skb);
+		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
+		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 	} else {
 		ppd->hv1.tp_vlan_tci = 0;
 		ppd->hv1.tp_vlan_tpid = 0;
@@ -2428,6 +2471,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
 			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
 			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (unlikely(sk->sk_type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
+			h.h2->tp_vlan_tci = vlan_get_tci(skb);
+			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
+			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 		} else {
 			h.h2->tp_vlan_tci = 0;
 			h.h2->tp_vlan_tpid = 0;
@@ -2457,7 +2504,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
 	sll->sll_family = AF_PACKET;
 	sll->sll_hatype = dev->type;
-	sll->sll_protocol = skb->protocol;
+	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
+		vlan_get_protocol_dgram(skb) : skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
 	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
@@ -3482,7 +3530,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		/* Original length was stored in sockaddr_ll fields */
 		origlen = PACKET_SKB_CB(skb)->sa.origlen;
 		sll->sll_family = AF_PACKET;
-		sll->sll_protocol = skb->protocol;
+		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
+			vlan_get_protocol_dgram(skb) : skb->protocol;
 	}
 
 	sock_recv_cmsgs(msg, sk, skb);
@@ -3539,6 +3588,10 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
 			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
 			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (unlikely(sock->type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
+			aux.tp_vlan_tci = vlan_get_tci(skb);
+			aux.tp_vlan_tpid = ntohs(skb->protocol);
+			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 		} else {
 			aux.tp_vlan_tci = 0;
 			aux.tp_vlan_tpid = 0;
-- 
2.43.0


