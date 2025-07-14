Return-Path: <netdev+bounces-206684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DA2B040E7
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92BC3AA5A7
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 14:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8694255E26;
	Mon, 14 Jul 2025 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="pjBZLqtT"
X-Original-To: netdev@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714625332E;
	Mon, 14 Jul 2025 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501800; cv=pass; b=YmBMgX6rceICNtJZvEPHYJ9AmV0lkwuksk9J6Z2wphIUCYIGnJ3HsxDrbCOQyN8SkmXN7PkA0XwwR9RfDtKB23IeJhuE8969eYxZ9H2WdAJ6qdDBEt92BxckuOyF2GAMw1DZKXYpXk4uAuvZGP873u4gDdUP6R0w1Y0M4W6eIdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501800; c=relaxed/simple;
	bh=XhqpgxRLTI2G38XPOETojzoF8wUzYzAAaiZd6w5Vu1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TyAfoHgoy8dQJ7mmEBiWF1SLot+hAZfKVfOVnNcgTy2ybjSObhWAZqaBp2M8HDdBTbVbAWum6oTWUv7H5dh0I4YDo9lN6setj1yLCGcmCii13YzMQ7+RcemZnM5UewXX243ryftdUEtgCfCrsoGo6YjEeCYlRd2GXdLq8DEeGPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=pjBZLqtT; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4bgkYP5Tr3zySF;
	Mon, 14 Jul 2025 17:03:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1752501788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EEa6HnWbQ2p07TGZOlrDqqHKYisSPERO0/iEcWBFJbY=;
	b=pjBZLqtTrcM5mZIJkFFLctCpit5e52nIb8+KZOSZrog793QZqaAyYHd3H41UHtEzWvIYHD
	6HXlMxR31SNOWihKlw0Vbog4ehaOmB0Y4+ogAKKGUIYMCBIMH8ysruPe7FBqjfNWlcTA6z
	XC22IKKCoXfKphmoMKOOCOJ/lcvZziI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1752501788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EEa6HnWbQ2p07TGZOlrDqqHKYisSPERO0/iEcWBFJbY=;
	b=ZAGYNmJAtFyi5io33edYnUgQvTJxEFnoa6KE6nl2nFIgNZig8tt0xgvNpNT0xRho32uYnQ
	wGNeBbQLCKMwE7fG6ZhUv67u1SQnu6ClQEbi3tUmXe1QOuEzLSkFdtPfbkcbjKwl1Q2tpn
	zUZuXxwzgqLxGOedKiLEd9ikZAnr5xY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1752501788; a=rsa-sha256; cv=none;
	b=qzCuAZohwkHhNKumzizoBxZGfTdj24RIHyPXCcm8eYbpsofUsNi1qD4junUrVyKB3LGxQR
	Azu7If+L0vCEyRd6N0UMLyXFQlGSU/gzNQhU8SejFptnht/GAKRHtk+kJ4KdbKD8KxtBtf
	g6ze6yPQc4BHQA86m9y8BH4rLck9J9A=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: add socket option to report packet seqnum via CMSG
Date: Mon, 14 Jul 2025 17:02:57 +0300
Message-ID: <474a5321753aba17ec2819ba59adfd157ecfb343.1752501596.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User applications need a way to track which ISO interval a given SDU
belongs to, to properly detect packet loss. All controllers do not set
timestamps, and it's not guaranteed user application receives all packet
reports (small socket buffer, or controller doesn't send all reports
like Intel AX210 is doing).

Add socket option BT_PKT_SEQNUM that enables reporting of received
packet ISO sequence number in BT_SCM_PKT_SEQNUM CMSG.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    Intel AX210 is not sending all reports:
    
    $ btmon -r dump.btsnoop -I -C90|grep -A1 'ISO Data RX: Handle 2304'
    ...
    > ISO Data RX: Handle 2304 flags 0x02 dlen 64                      #1713 [hci0] 22.567744
            dd 01 3c 00 6d 08 e9 14 1e 3b 85 7b 35 c2 25 0b  ..<.m....;.{5.%.
    --
    > ISO Data RX: Handle 2304 flags 0x02 dlen 64                      #1718 [hci0] 22.573745
            de 01 3c 00 41 65 22 4f 99 9b 0b b6 ff cb 06 00  ..<.Ae"O........
    --
    > ISO Data RX: Handle 2304 flags 0x02 dlen 64                      #1727 [hci0] 22.587933
            e0 01 3c 00 8b 6e 33 44 65 51 ee d7 e0 ee 49 d8  ..<..n3DeQ....I.
    --
    > ISO Data RX: Handle 2304 flags 0x02 dlen 64                      #1732 [hci0] 22.596742
            e1 01 3c 00 a7 48 54 a7 c1 9f dc 37 66 fe 04 ab  ..<..HT....7f...
    ...
    
    Here, report for packet with sequence number 0x01df is missing.
    
    This may be spec violation by the controller, see Core v6.1 pp. 3702
    
        All SDUs shall be sent to the upper layer including the indication
        of validity of data. A report shall be sent to the upper layer if
        the SDU is completely missing.
    
    Regardless, it will be easier for user applications to see the HW
    sequence numbers directly, so they don't have to count packets and it's
    in any case more reliable if packets get dropped due to socket buffer
    size.

 include/net/bluetooth/bluetooth.h |  9 ++++++++-
 net/bluetooth/af_bluetooth.c      |  7 +++++++
 net/bluetooth/iso.c               | 21 ++++++++++++++++++---
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 114299bd8b98..0e31779a3341 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -244,6 +244,10 @@ struct bt_codecs {
 
 #define BT_ISO_BASE		20
 
+#define BT_PKT_SEQNUM		21
+
+#define BT_SCM_PKT_SEQNUM	0x05
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
@@ -391,7 +395,8 @@ struct bt_sock {
 enum {
 	BT_SK_DEFER_SETUP,
 	BT_SK_SUSPEND,
-	BT_SK_PKT_STATUS
+	BT_SK_PKT_STATUS,
+	BT_SK_PKT_SEQNUM,
 };
 
 struct bt_sock_list {
@@ -475,6 +480,7 @@ struct bt_skb_cb {
 	u8 pkt_type;
 	u8 force_active;
 	u16 expect;
+	u16 pkt_seqnum;
 	u8 incoming:1;
 	u8 pkt_status:2;
 	union {
@@ -488,6 +494,7 @@ struct bt_skb_cb {
 
 #define hci_skb_pkt_type(skb) bt_cb((skb))->pkt_type
 #define hci_skb_pkt_status(skb) bt_cb((skb))->pkt_status
+#define hci_skb_pkt_seqnum(skb) bt_cb((skb))->pkt_seqnum
 #define hci_skb_expect(skb) bt_cb((skb))->expect
 #define hci_skb_opcode(skb) bt_cb((skb))->hci.opcode
 #define hci_skb_event(skb) bt_cb((skb))->hci.req_event
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 6ad2f72f53f4..44b7acb20a67 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -364,6 +364,13 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 			put_cmsg(msg, SOL_BLUETOOTH, BT_SCM_PKT_STATUS,
 				 sizeof(pkt_status), &pkt_status);
 		}
+
+		if (test_bit(BT_SK_PKT_SEQNUM, &bt_sk(sk)->flags)) {
+			u16 pkt_seqnum = hci_skb_pkt_seqnum(skb);
+
+			put_cmsg(msg, SOL_BLUETOOTH, BT_SCM_PKT_SEQNUM,
+				 sizeof(pkt_seqnum), &pkt_seqnum);
+		}
 	}
 
 	skb_free_datagram(sk, skb);
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index fc22782cbeeb..469450bb6b6c 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1687,6 +1687,17 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			clear_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags);
 		break;
 
+	case BT_PKT_SEQNUM:
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
+			break;
+
+		if (opt)
+			set_bit(BT_SK_PKT_SEQNUM, &bt_sk(sk)->flags);
+		else
+			clear_bit(BT_SK_PKT_SEQNUM, &bt_sk(sk)->flags);
+		break;
+
 	case BT_ISO_QOS:
 		if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND &&
 		    sk->sk_state != BT_CONNECT2 &&
@@ -2278,7 +2289,7 @@ static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 {
 	struct iso_conn *conn = hcon->iso_data;
-	__u16 pb, ts, len;
+	__u16 pb, ts, len, sn;
 
 	if (!conn)
 		goto drop;
@@ -2308,6 +2319,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 				goto drop;
 			}
 
+			sn = hdr->sn;
 			len = __le16_to_cpu(hdr->slen);
 		} else {
 			struct hci_iso_data_hdr *hdr;
@@ -2318,18 +2330,20 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 				goto drop;
 			}
 
+			sn = hdr->sn;
 			len = __le16_to_cpu(hdr->slen);
 		}
 
 		flags  = hci_iso_data_flags(len);
 		len    = hci_iso_data_len(len);
 
-		BT_DBG("Start: total len %d, frag len %d flags 0x%4.4x", len,
-		       skb->len, flags);
+		BT_DBG("Start: total len %d, frag len %d flags 0x%4.4x sn %d",
+		       len, skb->len, flags, sn);
 
 		if (len == skb->len) {
 			/* Complete frame received */
 			hci_skb_pkt_status(skb) = flags & 0x03;
+			hci_skb_pkt_seqnum(skb) = sn;
 			iso_recv_frame(conn, skb);
 			return;
 		}
@@ -2352,6 +2366,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 			goto drop;
 
 		hci_skb_pkt_status(conn->rx_skb) = flags & 0x03;
+		hci_skb_pkt_seqnum(conn->rx_skb) = sn;
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
 					  skb->len);
 		conn->rx_len = len - skb->len;
-- 
2.50.1


