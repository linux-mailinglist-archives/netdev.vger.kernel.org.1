Return-Path: <netdev+bounces-204453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6947FAFA9B4
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 04:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30BB18984F9
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 02:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8CA1A8F6D;
	Mon,  7 Jul 2025 02:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZnkAC9+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C7A17D7;
	Mon,  7 Jul 2025 02:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751855901; cv=none; b=t6/c5Rvdst+3tn9VI2FUONrkfJC6uPwuV8JfifMgXGMLt4ahZm+PULxD28S88CV1DB8YxJT6F8i7Nyfvajm1RSd9mPUQKJckk5Ig4Hj6ZdtK3EyX+2T3VkwA/mFMz54wbIk4fRbHtmIBi0Ex8a6c2lk3EzEFsas0V4tsDpVgAxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751855901; c=relaxed/simple;
	bh=jsMSlWRbC2p2Ki/3pcpBduSnR9cjT/0cdZHutS4pqLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OjxEB3u7w8asyxU55qHeZHE6suAs5YUrYdhiNe5h2joKmF5o1PXQsqU9hDwpZzEdR4aP68nsqSLbRXwoBosw4rjIfzLDIudfopKembPXTwP6bPrRcxHG5zNdokntChSKz5FET38XqFQId6J+3DTd6v7yrdP9vfv1JPOPPXyYxAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZnkAC9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C73FCC4CEED;
	Mon,  7 Jul 2025 02:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751855900;
	bh=jsMSlWRbC2p2Ki/3pcpBduSnR9cjT/0cdZHutS4pqLc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=PZnkAC9+SBjAsCtt3qV6KEi9x/hY9NehFoEIyat4+oRtL/hXlHPQEVToNO/Yp5loj
	 BhgIA2+8YFyL/R+G1xyrnfIdydDFxHzH7if1mHBAhrXnv1IWkATHQMkIq0oQ6j4yXg
	 sf9PrtbEcWDyQf5rFOhL4vcthqvsriguUpgSLAMrFUl9BRnYyVqGSPDM7OKdaUyz3r
	 t5Mto8v3nX5XLsc1a/KMteUtqs0nV05QnWPO29GSMWOgM6MhkseFXJHatBMyQKmOz3
	 XdgmiJELHd2gvgO7dTDl7J41Z9Jwp8Qfx2rFe3+9sj7CR0gxMoHZCXXYOfscdMWBLa
	 aH9885SA0tkCA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33A8C83F09;
	Mon,  7 Jul 2025 02:38:20 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Mon, 07 Jul 2025 10:38:17 +0800
Subject: [PATCH v4] Bluetooth: ISO: Support SCM_TIMESTAMPING for ISO TS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250707-iso_ts-v4-1-0f0bb162a182@amlogic.com>
X-B4-Tracking: v=1; b=H4sIABgza2gC/2XM0Q6CIBTG8VdxXEeDgyJ01Xu01hBR2VIaOFZzv
 nvoptW6/M7O7z+hYLw1AZ2yCXkTbbBuSCM/ZEh3amgNtnXaCAgUJAeKbXC3MWAtQDFClClFjtL
 zw5vGPtfQ5Zp2Z8Po/GvtRrpct4TcEpFiik0heMNIbbiuzqq/u9bqo3Y9WiIRPrAksENIsARWU
 ym1IFz8Q/YN8x2yBIGBqDQnIDn9hfM8vwEQFcK3EAEAAA==
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751855898; l=2017;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=qgUJFn3trnlHdIpSsRIi/lqpwsE0ic/VXvHX/T3pPD0=;
 b=zGf02G9TNaUyf7AUHDel5TePBmF/SbbYQWX7X849oQ6I/tGvyPElaI8e+fsoFmd2x0K33eRP3
 5JFDaZh67h3DLRD18THLJO/jQJci9dO7xnfy87onJmYzw8UB8FM3KCW
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

User-space applications (e.g. PipeWire) depend on
ISO-formatted timestamps for precise audio sync.

The ISO ts is based on the controller’s clock domain,
so hardware timestamping (hwtimestamp) must be used.

Ref: Documentation/networking/timestamping.rst,
section 3.1 Hardware Timestamping.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
Changes in v4:
- Optimizing the code
- Link to v3: https://lore.kernel.org/r/20250704-iso_ts-v3-1-2328bc602961@amlogic.com

Changes in v3:
- Change to use hwtimestamp
- Link to v2: https://lore.kernel.org/r/20250702-iso_ts-v2-1-723d199c8068@amlogic.com

Changes in v2:
- Support SOCK_RCVTSTAMPNS via CMSG for ISO sockets
- Link to v1: https://lore.kernel.org/r/20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com
---
 net/bluetooth/iso.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index fc22782cbeeb..677144bb6b94 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2278,6 +2278,7 @@ static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 {
 	struct iso_conn *conn = hcon->iso_data;
+	struct skb_shared_hwtstamps *hwts;
 	__u16 pb, ts, len;
 
 	if (!conn)
@@ -2301,13 +2302,16 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		if (ts) {
 			struct hci_iso_ts_data_hdr *hdr;
 
-			/* TODO: add timestamp to the packet? */
 			hdr = skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_SIZE);
 			if (!hdr) {
 				BT_ERR("Frame is too short (len %d)", skb->len);
 				goto drop;
 			}
 
+			/*  Record the timestamp to skb*/
+			hwts = skb_hwtstamps(skb);
+			hwts->hwtstamp = us_to_ktime(le32_to_cpu(hdr->ts));
+
 			len = __le16_to_cpu(hdr->slen);
 		} else {
 			struct hci_iso_data_hdr *hdr;

---
base-commit: b8db3a9d4daeb7ff6a56c605ad6eca24e4da78ed
change-id: 20250421-iso_ts-c82a300ae784

Best regards,
-- 
Yang Li <yang.li@amlogic.com>



