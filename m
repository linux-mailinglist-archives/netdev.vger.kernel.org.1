Return-Path: <netdev+bounces-203308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C68AF13F8
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C431678EA
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611902652A2;
	Wed,  2 Jul 2025 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEOZQmII"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322211D516A;
	Wed,  2 Jul 2025 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456152; cv=none; b=GSPJeqYQNmhWup7nD1ECp9CFqiX2QoNe1Vu5g7onrI4eTWXB+TsHENxeWN8aeBbI19hL2subtl6ds94+AkPwB4duaeQAs3CcskUTiPIj/59F49z7//dKIw7Nr1NlsIHHMsDJWDsjd/vfhMRE4DM7QFg5lwgwMLE473c1EmVsKc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456152; c=relaxed/simple;
	bh=75tX/3HUrOf8+9xyDRzjBq3cba5xi1dbfPz2qmejVzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cHWccnyiVz+KIaTSUZV0SYI+qlkhnvik1OcP3QrJ0Mr2T3DS8WEmSWo6V4i2PA+VurlrSlggoFeyuq48XX1iveCUnFtHy9+KKrfVoFoliPdl/PfblWJ0XSHXw3GBnP5Rpnh6+kdjz531OXp0VRhK1UUeVQFJIcWkFgLTx21MsLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEOZQmII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FD69C4CEF2;
	Wed,  2 Jul 2025 11:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751456151;
	bh=75tX/3HUrOf8+9xyDRzjBq3cba5xi1dbfPz2qmejVzQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=VEOZQmIIaiaKvRQd40Um4F8toPmxvD0ygHZOzMNUcGANXbNTX4Nx9IaPpgJtfMClD
	 YDUwmoc+sPhKhgPpDtPk+g//uySdT8I5o83FbnsJvg8Eavmm6O6C+S8NDrtrUEU/0c
	 BTKWFA71Dwodr8Xj0UKgnowse7P2j3A3uWL2UKu7tc8jzOOvNNYTVpRO1QKbLp2k2I
	 TfAYBUo5UqMa4NBYrNhgJ4F+ArrTTIRJv6jcbTFweIQdl+RWEAngSZl2aVxJNV+uwn
	 MzwiBfAq/SIhE4xYih5aswvAn4YL7bCdt6OFz6slHHirZ1Apd1VE6SnmU0dGRWaX5t
	 Z20RDr7KUQ3XA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D04FC83013;
	Wed,  2 Jul 2025 11:35:51 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Wed, 02 Jul 2025 19:35:48 +0800
Subject: [PATCH v2] Bluetooth: ISO: Support SOCK_RCVTSTAMP via CMSG for ISO
 sockets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-iso_ts-v2-1-723d199c8068@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAJMZZWgC/zXMywrCMBCF4VcpszaSpBdjV76HFInptB2wjWRKU
 Ere3Vjo8j8cvg0YAyFDW2wQMBKTX3LoUwFussuIgvrcoKWuZaWVIPaPlYUz2pZSWryYCvL5HXC
 gzw7du9wT8erDd3ej+q8HcT2IqIQSWJtmKGWPjXve7PzyI7mz8zN0KaUfJqRCPZ4AAAA=
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751456149; l=982;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=KHMGQKsMq1ealL3OXyoBth/L4LOJjuWSriffKLAfOLM=;
 b=/XSCa4bHVCWY+eq/QxDxP2198DpIAxIIYl+i0/OLzyiR//vXWJO4ymOsMxYq+VWerTZC7XiS5
 fr079bqjNMVCLDw9rVIMzKlGfuxrsKYSwq4LMm4pJjo7jybc0sEvAE+
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

User-space applications (e.g., PipeWire) depend on
ISO-formatted timestamps for precise audio sync.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
Changes in v2:
- Support SOCK_RCVTSTAMPNS via CMSG for ISO sockets
- Link to v1: https://lore.kernel.org/r/20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com
---
 net/bluetooth/iso.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index fc22782cbeeb..6927c593a1d6 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2308,6 +2308,9 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 				goto drop;
 			}
 
+			/* Record the timestamp to skb*/
+			skb->skb_mstamp_ns = le32_to_cpu(hdr->ts);
+
 			len = __le16_to_cpu(hdr->slen);
 		} else {
 			struct hci_iso_data_hdr *hdr;

---
base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
change-id: 20250421-iso_ts-c82a300ae784

Best regards,
-- 
Yang Li <yang.li@amlogic.com>



