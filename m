Return-Path: <netdev+bounces-186643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E372AAA0099
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 05:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA15C3AB139
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 03:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99542638B2;
	Tue, 29 Apr 2025 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQDKGnzV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A46554769;
	Tue, 29 Apr 2025 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745897772; cv=none; b=JWB+YDuLNSS7z69WpWD7vKxXreeZUtuOyllhCz6mz/WdsYW7KD0UZJOfGwa8cuZLZG8lVNKyvd23EMdEKR1gnzdQpjK7Y0LW72YaZBwhPimHB87rgMqWMQXQ49QEk+am+/VL4xMiPEJlgjvnX3/SGwOovEYscqDFGauIjbP3lJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745897772; c=relaxed/simple;
	bh=YqRpaNuy2JgbzQUagG9PVmgqunYn9gBcbJjSu43l+KY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ug7gYz16Tn7O4fG38eDnb44kXIIzdUILxJj1+ur2Z1/12KA/PosYKsapwePgj27vNZavce9qP6xBr+sMBfLhj0C0QqqM4hlM1PuPfmwUq1lhbpK+qtdLDdE08+8GdpdxkzG0m2RslSuG5bUzndvgZzSfBTBqChDwcx2WRb70rmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQDKGnzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECF53C4CEE3;
	Tue, 29 Apr 2025 03:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745897772;
	bh=YqRpaNuy2JgbzQUagG9PVmgqunYn9gBcbJjSu43l+KY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=KQDKGnzVbOfqok+d5wYTKFIMiGDa/uevuE+Amab+EL4eRmo1RTNl5c+0y60dfbQOH
	 /G4cdjYimP3wVwBf5gqO28y1RVR2EtK8DscnMimRA4wLpKKKubaFNFbIKAU+ZqH4/o
	 3YB6AOMclp967j/LqdPrICIgZkB3ujrKKheBX4koPBA7OOO0a+Ttx4sEnpHUwmCZXI
	 G3ilGCHXMHvIxNb1wzn8/ybyTqm7vzimFrrLBJGtmygEgxwOh0vlJkX9+sR7vkruy0
	 8hPwJytou9BFeVMeJeRUYNoLpZ1mLRJ3KEKNpIpdB2jdf3qdtI9Pgbk2OHUQCRc1GT
	 4WhovtAzAgQ3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59A4C369D9;
	Tue, 29 Apr 2025 03:36:11 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Tue, 29 Apr 2025 11:35:51 +0800
Subject: [PATCH] iso: add BT_ISO_TS optional to enable ISO timestamp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com>
X-B4-Tracking: v=1; b=H4sIABZJEGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEyND3czi/PiSYt1kC6NEYwODxFRzCxMloOKCotS0zAqwQdGxtbUARtp
 HWlgAAAA=
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745897770; l=3821;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=7V3ep2vGxaAYLV1WXhSaBss+Dq4jK4u8OsBDNgsTPZg=;
 b=CPGdUZ6fjHNrQEwv0zuBPrpvP20XmSn1aYRNkQnZBqX2gPuk3O+sgQbMt2vn4WodgQrrcaLoA
 fJESvmPeLMZCypa8d2dtx6YwmGUF/Jjwg2mvWDkok1OBAaNtNaC8xCy
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

Application layer programs (like pipewire) need to use
iso timestamp information for audio synchronization.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 include/net/bluetooth/bluetooth.h |  4 ++-
 net/bluetooth/iso.c               | 58 +++++++++++++++++++++++++++++++++------
 2 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index bbefde319f95..a102bd76647c 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -242,6 +242,7 @@ struct bt_codecs {
 #define BT_CODEC_MSBC		0x05
 
 #define BT_ISO_BASE		20
+#define BT_ISO_TS		21
 
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
@@ -390,7 +391,8 @@ struct bt_sock {
 enum {
 	BT_SK_DEFER_SETUP,
 	BT_SK_SUSPEND,
-	BT_SK_PKT_STATUS
+	BT_SK_PKT_STATUS,
+	BT_SK_ISO_TS
 };
 
 struct bt_sock_list {
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 2f348f48e99d..2c1fdea4b8c1 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1718,7 +1718,21 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 		iso_pi(sk)->base_len = optlen;
 
 		break;
+	case BT_ISO_TS:
+		if (optlen != sizeof(opt)) {
+			err = -EINVAL;
+			break;
+		}
 
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
+			break;
+
+		if (opt)
+			set_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags);
+		else
+			clear_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags);
+		break;
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -1789,7 +1803,16 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 			err = -EFAULT;
 
 		break;
+	case BT_ISO_TS:
+		if (len < sizeof(u32)) {
+			err = -EINVAL;
+			break;
+		}
 
+		if (put_user(test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags),
+			    (u32 __user *)optval))
+			err = -EFAULT;
+		break;
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -2271,13 +2294,21 @@ static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 {
 	struct iso_conn *conn = hcon->iso_data;
+	struct sock *sk;
 	__u16 pb, ts, len;
 
 	if (!conn)
 		goto drop;
 
-	pb     = hci_iso_flags_pb(flags);
-	ts     = hci_iso_flags_ts(flags);
+	iso_conn_lock(conn);
+	sk = conn->sk;
+	iso_conn_unlock(conn);
+
+	if (!sk)
+		goto drop;
+
+	pb = hci_iso_flags_pb(flags);
+	ts = hci_iso_flags_ts(flags);
 
 	BT_DBG("conn %p len %d pb 0x%x ts 0x%x", conn, skb->len, pb, ts);
 
@@ -2294,17 +2325,26 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		if (ts) {
 			struct hci_iso_ts_data_hdr *hdr;
 
-			/* TODO: add timestamp to the packet? */
-			hdr = skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_SIZE);
-			if (!hdr) {
-				BT_ERR("Frame is too short (len %d)", skb->len);
-				goto drop;
-			}
+			if (test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags)) {
+				hdr = (struct hci_iso_ts_data_hdr *)skb->data;
+				len = hdr->slen + HCI_ISO_TS_DATA_HDR_SIZE;
+			} else {
+				hdr = skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_SIZE);
+				if (!hdr) {
+					BT_ERR("Frame is too short (len %d)", skb->len);
+					goto drop;
+				}
 
-			len = __le16_to_cpu(hdr->slen);
+				len = __le16_to_cpu(hdr->slen);
+			}
 		} else {
 			struct hci_iso_data_hdr *hdr;
 
+			if (test_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags)) {
+				BT_ERR("Invalid option BT_SK_ISO_TS");
+				clear_bit(BT_SK_ISO_TS, &bt_sk(sk)->flags);
+			}
+
 			hdr = skb_pull_data(skb, HCI_ISO_DATA_HDR_SIZE);
 			if (!hdr) {
 				BT_ERR("Frame is too short (len %d)", skb->len);

---
base-commit: 16b4f97defefd93cfaea017a7c3e8849322f7dde
change-id: 20250421-iso_ts-c82a300ae784

Best regards,
-- 
Yang Li <yang.li@amlogic.com>



