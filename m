Return-Path: <netdev+bounces-242586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62066C925A0
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 15:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E6304E02F3
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 14:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658FB2773E4;
	Fri, 28 Nov 2025 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a49sPGOP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2101F790F
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764341125; cv=none; b=mpS+XNQJq7klGWOOFFO/ex05tuSsx+ckMhYS266hOXI58nRE7s6v2UOBRNT88qXERkGXlKV2Mdy7+MiaMHNgEicuVPouiWGHkBdD+Fof5WYW2+PVLOHmll32+flViQOqO8BWjL7gVNLjTHYM9E34Ge7R1+tr0c4JbcMDiRWQqPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764341125; c=relaxed/simple;
	bh=MhteIaNOVGWti2GWmmr9bIqFwRfvy66Jqa3Lj8eMo2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHqhD22XqqjJPje9XRf9BxqquZ55b8qOYcABcNg0t+hJCmJouGlsEAIJJAwd7CL5G6SO8sRSaQoIB/lSmcDP7L4VHHAd6nTqT4NV27+21XTVkohABb5o2Zv/SqbBCQQ7w8ysN5NTPd8C/xcl+sp3J2wISBW2C+lUJv4wm9VWvcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a49sPGOP; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37a2dced861so25484821fa.1
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 06:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764341121; x=1764945921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=63Lw8xPkh8mWD9PQiyYtDY22cJb20UN8c0nRdcKkFJQ=;
        b=a49sPGOPBnI78RB3DaRrnAb3PjFPodJihGPAgBYWhIxC9AvA4IkRjr3CbeTX8LD/Q3
         okkWWbMbANm7CUgNJt8jhcU1PLbRvDsjpan+jeC7Ytq2v9t1qfnRbYYksTG0Tu2elW3X
         tZZI7tSJ/TyxVZyjx6slEOhwcq2rcKhtAiYYlmG5H3/LFdNvJh5Yvv14TASPIUO3m3iE
         J97yZJsSZrsygA7LQ1I6r1eiJG1MSxNUgtqsgxBf21ZSTLvuPPq4d0RTLRxg0i3nfDYN
         QJcqtvQeBDOBlup7YZm/GbXEwBxmZHXmP05509d8tD7ccQnZcK4HFhMeeSLpzuVMqNn4
         O7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764341121; x=1764945921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63Lw8xPkh8mWD9PQiyYtDY22cJb20UN8c0nRdcKkFJQ=;
        b=Tc2Rvu0GMkHR28KHudc1VfVgTpETyzZe36g6X1wA2TyaNxzj+5pkY2knMCYf6AHY5x
         gnI4Y2JzycMWV3RaWRAinQjOyHsPMJKjo2SsPsFgfsnur0ZbzQf2oIWa1RVkP9TXpAml
         RsI94/FKS0KgrrYrDBrszBoTbFG2fyXylK4dtlgt5e/9Si08bsbQ7/mifhWsxki85AuE
         Xay/qJJnYbq0+CLnNip1x73HGTprkMjX5oZ55WGAJ83i3jNfAp3zd0YctYKRspJegOF4
         I+ByZeRGpnysNTO+jlsBmca1uoK3u0XcVQYFkF020iBRoDKxauVs4SO7JH+UIKtBBUNh
         T9jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUegZ33Zy9oOwF9tqtGuWyiRX6kn9HLMcr3puQg5Hmo2zGjSpObCH4TLI10w7EnipnvDndnsbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzssQrzemioUDigE0F3Px5tuVSKgPpJUcuWXuWb4og7oQ9SbSTV
	Q4FdPHmYwpXrcH7JOHpB/3l00CACEsPC0Ps8heq+e7ewziCAiGUsQu0Z
X-Gm-Gg: ASbGnctQS5AK2OCj/u9tFIpxuVWn1+87+8HgoGV7HHqLLjxxHp/ejZRHZy/+nRvwyKw
	Gi7FKId8pdMa3TSqlMK+FXxXFTDTFv5TnQgIjxOCk9t9jGuL98GhInQrXz06txmGe/LZDiRgDak
	MCgf+O0I8HJMDICvOtOOEieVvoEiyOnicbuJhaIe91k+GUaUOSfiayPSUKmd63I6OxJ+fpAB5z/
	2+X3sfHiFzuF2fFhpgAz8vaLxEIcUgOBXKporWJ01O8Oa6ayQsjhZDxUv8V2Lm9YamGjP4Uv8wV
	tC91vHFLqGVu4KIDx0vcOpr1vXm69ygT4mnGqmkA4Gguada5wRBnZERGwacnpalpcuk2aCHqb2H
	uaZD90hWsSRfHwIpRqjkStASfhs9xG38DsgZ3XZiKM5DNNoMAHrMmMB//EDSUuQ09jrXsMDNK+8
	hI+5e408ZjeGnSYRT/mEgBemVHWVBwHwyQxe2cS6HFZPxtY7+Y0KIQ8GbU
X-Google-Smtp-Source: AGHT+IE+6YnO3WMBJQwBaL87YU7rVz025nLgnEEbmMl7tMziBKhu9TX4BlqqHC8Og3QejjZXXmgeSQ==
X-Received: by 2002:a2e:ab0b:0:b0:37b:9674:f480 with SMTP id 38308e7fff4ca-37cc834e8ecmr81190341fa.11.1764341121242;
        Fri, 28 Nov 2025 06:45:21 -0800 (PST)
Received: from cherrypc.astracloud.ru (109-252-18-135.nat.spd-mgts.ru. [109.252.18.135])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37d240e95a3sm10648461fa.34.2025.11.28.06.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 06:45:20 -0800 (PST)
From: Nazar Kalashnikov <sivartiwe@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nazar Kalashnikov <sivartiwe@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alex Lu <alex_lu@realsil.com.cn>,
	Max Chou <max.chou@realtek.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.10/5.15] Bluetooth: Add more enc key size check
Date: Fri, 28 Nov 2025 17:45:34 +0300
Message-ID: <20251128144535.55357-1-sivartiwe@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Lu <alex_lu@realsil.com.cn>

[ Upstream commit 04a342cc49a8522e99c9b3346371c329d841dcd2 ]

When we are slave role and receives l2cap conn req when encryption has
started, we should check the enc key size to avoid KNOB attack or BLUFFS
attack.
From SIG recommendation, implementations are advised to reject
service-level connections on an encrypted baseband link with key
strengths below 7 octets.
A simple and clear way to achieve this is to place the enc key size
check in hci_cc_read_enc_key_size()

The btmon log below shows the case that lacks enc key size check.

> HCI Event: Connect Request (0x04) plen 10
        Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Class: 0x480104
          Major class: Computer (desktop, notebook, PDA, organizers)
          Minor class: Desktop workstation
          Capturing (Scanner, Microphone)
          Telephony (Cordless telephony, Modem, Headset)
        Link type: ACL (0x01)
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
        Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Role: Peripheral (0x01)
> HCI Event: Command Status (0x0f) plen 4
      Accept Connection Request (0x01|0x0009) ncmd 2
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11
        Status: Success (0x00)
        Handle: 1
        Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
...

> HCI Event: Encryption Change (0x08) plen 4
        Status: Success (0x00)
        Handle: 1 Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Encryption: Enabled with E0 (0x01)
< HCI Command: Read Encryption Key Size (0x05|0x0008) plen 2
        Handle: 1 Address: BB:22:33:44:55:99 (OUI BB-22-33)
> HCI Event: Command Complete (0x0e) plen 7
      Read Encryption Key Size (0x05|0x0008) ncmd 2
        Status: Success (0x00)
        Handle: 1 Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Key size: 6
// We should check the enc key size
...

> ACL Data RX: Handle 1 flags 0x02 dlen 12
      L2CAP: Connection Request (0x02) ident 3 len 4
        PSM: 25 (0x0019)
        Source CID: 64
< ACL Data TX: Handle 1 flags 0x00 dlen 16
      L2CAP: Connection Response (0x03) ident 3 len 8
        Destination CID: 64
        Source CID: 64
        Result: Connection pending (0x0001)
        Status: Authorization pending (0x0002)
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 1 Address: BB:22:33:44:55:99 (OUI BB-22-33)
        Count: 1
        #35: len 16 (25 Kb/s)
        Latency: 5 msec (2-7 msec ~4 msec)
< ACL Data TX: Handle 1 flags 0x00 dlen 16
      L2CAP: Connection Response (0x03) ident 3 len 8
        Destination CID: 64
        Source CID: 64
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)

Cc: stable@vger.kernel.org
Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Max Chou <max.chou@realtek.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ Nazar Kalashnikov: change status to 
rp_status due to function parameter conflict ]
Signed-off-by: Nazar Kalashnikov <sivartiwe@gmail.com>
---
Backport fix for CVE-2023-24023
 net/bluetooth/hci_event.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c6dbb4aebfbc..6310f4f9890e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3043,6 +3043,7 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
 	const struct hci_rp_read_enc_key_size *rp;
 	struct hci_conn *conn;
 	u16 handle;
+	u8 rp_status;
 
 	BT_DBG("%s status 0x%02x", hdev->name, status);
 
@@ -3052,6 +3053,7 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
 	}
 
 	rp = (void *)skb->data;
+	rp_status = rp->status;
 	handle = le16_to_cpu(rp->handle);
 
 	hci_dev_lock(hdev);
@@ -3064,15 +3066,30 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
 	 * secure approach is to then assume the key size is 0 to force a
 	 * disconnection.
 	 */
-	if (rp->status) {
+	if (rp_status) {
 		bt_dev_err(hdev, "failed to read key size for handle %u",
 			   handle);
 		conn->enc_key_size = 0;
 	} else {
 		conn->enc_key_size = rp->key_size;
+		rp_status = 0;
+
+		if (conn->enc_key_size < hdev->min_enc_key_size) {
+			/* As slave role, the conn->state has been set to
+			 * BT_CONNECTED and l2cap conn req might not be received
+			 * yet, at this moment the l2cap layer almost does
+			 * nothing with the non-zero status.
+			 * So we also clear encrypt related bits, and then the
+			 * handler of l2cap conn req will get the right secure
+			 * state at a later time.
+			 */
+			rp_status = HCI_ERROR_AUTH_FAILURE;
+			clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
+			clear_bit(HCI_CONN_AES_CCM, &conn->flags);
+		}
 	}
 
-	hci_encrypt_cfm(conn, 0);
+	hci_encrypt_cfm(conn, rp_status);
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.43.0


