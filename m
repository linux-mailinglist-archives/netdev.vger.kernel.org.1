Return-Path: <netdev+bounces-247638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB83CFCAC3
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 09:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3EA630194FD
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 08:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA8B279DC3;
	Wed,  7 Jan 2026 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvmoXEp7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9017083C;
	Wed,  7 Jan 2026 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767775694; cv=none; b=hQjDrgHrrO2T2qDQ+l7yO7yQ6wJ3RNoNxxHUsUWVAM1q6sMHWtA1eboXkBa1kvkL0MuRXPWan8Yo4WfQYl2uoCB++/8XWuV8UIv0+vPmLtPa/6Jn/fytNg9mkAu9o0sC/ZBHqAtqFX86jJmXmQG7z2lAKyysu2BMgopXRmMUVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767775694; c=relaxed/simple;
	bh=pGxNbgaMb+VJxYIO05kdvF6BUm0EeGaXKDqBwmMff8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bgB6hTUcjfnCiPfbozelZXVlZC+UGVPcU0Y5ZJyhBs+eQKmiEaBOthbl0AsBUYJ/60l0oIMea9aOzDDMd1iG7f7HILSPQbJ46nVkdbPFS/YkJy7iGmWR8LwKGp95j0TBzhPyWFsGkKsSiLrQS4AtajXutZ+NAE/L0+bSe/TlprI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvmoXEp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DE4DC4CEF7;
	Wed,  7 Jan 2026 08:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767775694;
	bh=pGxNbgaMb+VJxYIO05kdvF6BUm0EeGaXKDqBwmMff8w=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=WvmoXEp773IvzFofUNXvRaDoT1UWsjOYHUDKVtBLUm5HUcp5sKjWUAKEKQXqSDh0e
	 0nfSNTB++9PC3lt6LAqjkqn+5tdD3Vp6PZAeNNqWVoY2dFQQkEuyvqtg349p1tR2BN
	 fESn0hHudMgaLOhpr/YOB1sTdc5/AXg4XQuonm3W9bPrxGOuAjna04qgwXiXNhtSgK
	 fuIx9B7M+y5AGPmMS0rAQTN/XlAn3/OLXiNZ+SY/c2jPcSt5MkP5Ldh5/quuhpl0SG
	 Iyuc0UP/Yy6quHdxzn45Mf8P7mN9btwlWTYX8LF3rjBbZbnZ7nmvcf2s1Zi8uir3uB
	 osR8ycdxO/8Ug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F7ECF6C04;
	Wed,  7 Jan 2026 08:48:14 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Wed, 07 Jan 2026 16:48:08 +0800
Subject: [PATCH] Bluetooth: mgmt: report extended advertising SID to
 userspace
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-mgmt_ext_adv_sid-v1-1-1cb570c7adf7@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAMcdXmkC/x3MTQqAIBBA4avErBO0P6mrRIjkZLPQQiME8e5Jy
 2/xXoaIgTDC0mQI+FKky1eItoH91N4iI1MNHe8mLrhkzrpHYXqUNq+KZJhEPfIeh0nOAmp2Bzw
 o/ct1K+UDF5DVL2IAAAA=
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767775689; l=3615;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=jBmr5FIDDl995BF+9DomJoZAhCWPM4Uef0JY/2Np600=;
 b=V/ux01+VdAla+V1PNlq5O7Wq86VMgMjszSE8gr9GydbRRVIc6rljMD+tOkvcIXXf/g38GIi5f
 9DmB2ewp1MJAewxWuRow2dUwyZr4+D7Zx/RbH+5dw5a6wFydOuxlZrq
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

Add a new mgmt event to report the SID of extended advertising
to userspace. This allows userspace to obtain the SID before
initiating PA sync, without waiting for the next extended
advertising report to update the SID.

By providing the SID earlier, the PA sync flow can be simplified
and the overall latency reduced.

Link: https://github.com/bluez/bluez/issues/1758

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 include/net/bluetooth/hci_core.h |  2 ++
 include/net/bluetooth/mgmt.h     |  7 +++++++
 net/bluetooth/hci_event.c        |  3 +++
 net/bluetooth/mgmt.c             | 13 +++++++++++++
 4 files changed, 25 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a7bffb908c1e..81ef3e94e3af 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2469,6 +2469,8 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
 		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len,
 		       u64 instant);
+void mgmt_ext_adv_sid_changed(struct hci_dev *hdev, bdaddr_t *bdaddr,
+				     u8 addr_type, u8 sid);
 void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, s8 rssi, u8 *name, u8 name_len);
 void mgmt_discovering(struct hci_dev *hdev, u8 discovering);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 8234915854b6..7ee38ebaccd8 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -1195,3 +1195,10 @@ struct mgmt_ev_mesh_device_found {
 struct mgmt_ev_mesh_pkt_cmplt {
 	__u8	handle;
 } __packed;
+
+#define MGMT_EV_EXT_ADV_SID_CHANGED		0x0033
+struct mgmt_ev_ext_adv_sid_changed {
+	struct mgmt_addr_info addr;
+	__u8	sid;
+} __packed;
+
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 467710a42d45..f4463e71b424 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6519,6 +6519,9 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, void *data,
 					   info->rssi, info->data, info->length,
 					   !(evt_type & LE_EXT_ADV_LEGACY_PDU),
 					   false, instant);
+			mgmt_ext_adv_sid_changed(hdev, &info->bdaddr,
+						      info->bdaddr_type,
+						      info->sid);
 		}
 	}
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5be9b8c91949..4e0f8c43e387 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -208,6 +208,7 @@ static const u16 mgmt_untrusted_events[] = {
 	MGMT_EV_EXT_INDEX_REMOVED,
 	MGMT_EV_EXT_INFO_CHANGED,
 	MGMT_EV_EXP_FEATURE_CHANGED,
+	MGMT_EV_EXT_ADV_SID_CHANGED,
 };
 
 #define CACHE_TIMEOUT	secs_to_jiffies(2)
@@ -10516,6 +10517,18 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	mgmt_adv_monitor_device_found(hdev, bdaddr, report_device, skb, NULL);
 }
 
+void mgmt_ext_adv_sid_changed(struct hci_dev *hdev, bdaddr_t *bdaddr,
+				     u8 addr_type, u8 sid)
+{
+	struct mgmt_ev_ext_adv_sid_changed ev;
+
+	bacpy(&ev.addr.bdaddr, bdaddr);
+	ev.addr.type = link_to_bdaddr(LE_LINK, addr_type);
+	ev.sid = sid;
+
+	mgmt_event(MGMT_EV_EXT_ADV_SID_CHANGED, hdev, &ev, sizeof(ev), NULL);
+}
+
 void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, s8 rssi, u8 *name, u8 name_len)
 {

---
base-commit: 030d2c0e9c1d68e67f91c08704482ad9881583eb
change-id: 20260107-mgmt_ext_adv_sid-7ea503e46791

Best regards,
-- 
Yang Li <yang.li@amlogic.com>



