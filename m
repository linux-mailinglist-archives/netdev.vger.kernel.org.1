Return-Path: <netdev+bounces-206785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DA7B045A5
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080FB16A081
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9BA25BF1E;
	Mon, 14 Jul 2025 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="OcnvVX2T"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE57F1F4CB3;
	Mon, 14 Jul 2025 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511271; cv=pass; b=JwJ0zSRrQKeEcDp/P1kHxrD3TEOgSZQoTVSM0hmemC92PAzCzZ3geYqNjmsyrzTLaPg9Bu8fw0GJPZGi5Y3xlWHPJt7qVaqyhahuZ7T0YurNBrBrlYZAKfuCtwZ3iLY/bq8BIcxxPFUcMHuCRUd2ZzMmFQNFo0fuZ4IHTtsAyEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511271; c=relaxed/simple;
	bh=hv6IWH3cq1kbC4Yk/9rrFWekSNr8ifAYeq4KH8pi9TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iKVpiNHP/D8IAg90+YqWAJYyB9gaJn7Qirsmd2EfYOsR3le1I0tc6+hFVBa7/HiW2C5kT4r3c0oWVdXw8HiDvSIIV/VA9ApdiVAFUdNc2f7olLqe6A5rB9Lw8PSPAWanJEHEvNSXCbRDoCAUomDNDd8AWXP2fJRrFsmxbc+Xjcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=OcnvVX2T; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bgp3c1FVWz49Psn;
	Mon, 14 Jul 2025 19:40:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1752511262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vn9aL+KxI0Zs9wTT5HhYOvvfjbX8cff8m4lR7olPBKY=;
	b=OcnvVX2TQrA/X55uuQlmS3ktKHlFSHnbyGhP3e6A41Sx7f0KsQh3zmgbCUJCv0RE+zOQT/
	9+zREOvcgpvpuOpds8nb4mpHT4w8ju6oBFPZxBs4D1uyjNePy6Bw4K9F8tXvR9N9CSqABf
	rwqDrZxcsBbvB30daABVcpkhxzfbFWv4Xej90Bk4aiuGRrcl7zYzoyftrLtO6YVheYYql/
	r+E8TsUjyrmmsizNY/jmjgDqqyD/n6gWnpWvskxY/6aB3AhXSYr39A9PuLiHVoJS+Bx0Yc
	yMdNRaoRtTeqczVBmEwVd7QSDyeN+Rg9oBUr+sRoZ5aiM5uHfh+Lrr622KkmeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1752511262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vn9aL+KxI0Zs9wTT5HhYOvvfjbX8cff8m4lR7olPBKY=;
	b=St4f1TpvOUPimyJ+NL8VplVR1+CzaiuUf5PN1AoXMJqaEPfAr2jWEPCziQfrezgkqTDaNB
	BkA/TNTYSDu2cfGNZ1VyP0SlyPBh+ABbgBSUbbO+SnCOoZmgGjFNMGLXuWf/61RaVB93Yk
	jQmb5LlTdcKNI/Lq1qPNPVqn+r1ec9GuP2ObMxOAeKOEN6jWkUSeZNUm97HCkYF1QRhBZW
	lTUi6Xz67hgooW/ov8KvkgcLRtDAr16SVPsQxLnKQyyX9DdfqriDUAUrNQ418kbXk8u/wM
	WgjXFh/4nA7Bor30+xf+h7ysW7QVLO8qVCiR2hG8CDDP2lYqe11HJFCfd42IZg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1752511262; a=rsa-sha256;
	cv=none;
	b=SAGOHVsZ2XNS+kadX287OeZz1/+v54JeoApx77S8SzE/2zrMg6bSxLhAcj9egU8wa/zSzS
	+up/MFddA6C9ln2M4qXSYhnZ79dZiBm7zvvxUeYnTG5e04VTJCHS3NgqZjLgpmVQQit9W1
	vtbpMh87aaoXJGfBqyS8q9n0SPYRKB/ticXnG98jjnAkhCGa7eKT5Fr8ASuAGwvR/T/31j
	d+nyhDbPqZguWtYAEaFSQI6HjTc96by0N7f5OkivsC3VBa/vDU9AaL0EAw9KAWaDcePozR
	FU6+h4/ISKj4N+d0qZkQMJxL7RTxYwLVuD6NhtC72CfKRAVQkFNUIbKvCVywEw==
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
Subject: [PATCH v2] Bluetooth: ISO: add socket option to report packet seqnum via CMSG
Date: Mon, 14 Jul 2025 19:40:37 +0300
Message-ID: <712e0e6752a8619bdde98d55af0a9e672aa290c2.1752511130.git.pav@iki.fi>
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

Use BT_PKT_SEQNUM == 22 for the socket option, as 21 was used earlier
for a removed experimental feature that never got into mainline.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - fix missing __le16_to_cpu for hdr->sn
    - change BT_PKT_SEQNUM value to 22, to avoid clashing with removed
      experimental feature (only in bluetooth-next, it was never merged in
      mainline)
    - still call seqnum "sn", as the name is used in "hdr->sn"
    
    Tests: https://lore.kernel.org/linux-bluetooth/c9a75585e3640d8a1efca0bf96158eec1ca25fdc.1752501450.git.pav@iki.fi/

 include/net/bluetooth/bluetooth.h | 11 ++++++++++-
 net/bluetooth/af_bluetooth.c      |  7 +++++++
 net/bluetooth/iso.c               | 21 ++++++++++++++++++---
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 114299bd8b98..ada5b56a4413 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -244,6 +244,12 @@ struct bt_codecs {
 
 #define BT_ISO_BASE		20
 
+/* Socket option value 21 reserved */
+
+#define BT_PKT_SEQNUM		22
+
+#define BT_SCM_PKT_SEQNUM	0x05
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
@@ -391,7 +397,8 @@ struct bt_sock {
 enum {
 	BT_SK_DEFER_SETUP,
 	BT_SK_SUSPEND,
-	BT_SK_PKT_STATUS
+	BT_SK_PKT_STATUS,
+	BT_SK_PKT_SEQNUM,
 };
 
 struct bt_sock_list {
@@ -475,6 +482,7 @@ struct bt_skb_cb {
 	u8 pkt_type;
 	u8 force_active;
 	u16 expect;
+	u16 pkt_seqnum;
 	u8 incoming:1;
 	u8 pkt_status:2;
 	union {
@@ -488,6 +496,7 @@ struct bt_skb_cb {
 
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
index fc22782cbeeb..d402a22c8f91 100644
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
 
+			sn = __le16_to_cpu(hdr->sn);
 			len = __le16_to_cpu(hdr->slen);
 		} else {
 			struct hci_iso_data_hdr *hdr;
@@ -2318,18 +2330,20 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 				goto drop;
 			}
 
+			sn = __le16_to_cpu(hdr->sn);
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


