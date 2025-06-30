Return-Path: <netdev+bounces-202334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7DDAED648
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 09:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EC2175EBB
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 07:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA1522A7E2;
	Mon, 30 Jun 2025 07:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS/F6o3c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7594013C8E8;
	Mon, 30 Jun 2025 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270246; cv=none; b=JkEy+enKMNYJwjmjFTmcH7pFpqhtOc0xaTR+mziuPC+eBHb+xDH/jX7r+2haEeh/KGuNtOdprH9eI0jzhLV/1Sbg6qJkrwNi4NkKxFS1dmO0E052aL4HyN4rqs0zEXQp4/cecEAYZGrKmX+PCN1Fq2C+lGgu00qfs9TTLpwCpuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270246; c=relaxed/simple;
	bh=zsRaU0MAtAVRlJsiOjU7KbrvhMUsrDil4sHqQqfHNsY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qiV5UpRaCEasaCvvw1Yh2EJfXrDwH3bPgxhBT97f0SdRhlnPcur18jRTG0RrAGIJ+EZkEKjykBXNt/1G+lC+faPb7UUVmtx0dYAdIdk5SubuUNZHDEigoSPLxnkXMJs+pk4JPUH9wJjx12cUpefRiACtdwdBgYpJ5Ycud2aIdmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OS/F6o3c; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553b6a349ccso1978278e87.0;
        Mon, 30 Jun 2025 00:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751270242; x=1751875042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bu9lNrEMZtoTthaZGm1A0/BP/cBzlFzHsIVEQLuaDcg=;
        b=OS/F6o3ceDsV68eFFN7hoJgESKGZr+1Jp4q16TnZ88QZFV/RywXeEzGuBzPT+VZ9uq
         CXJ4yqtiSVmxuAy7/4tyHN7NbXD6v0lJP5G74E/vSP4e9vrh7YQNdkfjFWe5h0DoaXZV
         9YBvilRKzc7UTnOJljos1e0f0zbOuXKfNa7hAOlKVKlJ3HRjZn9zuVsDHJCsM0zcfF12
         JEO+cSyjDrGkhnigOtKLZO9Y/o34qtDXf1f+So3ZD+g9vVZT6dDYUv8KV06FK872jcpq
         UL3/Q7ytk1+Oyrf0z4TYc6hr0xss9CQ1sycHYVX1RAe9oQa3/lJyUzBuQfVvNilm49f2
         zXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751270242; x=1751875042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bu9lNrEMZtoTthaZGm1A0/BP/cBzlFzHsIVEQLuaDcg=;
        b=X25g+WxPsCEzEZ49BLbFYs4DoqUMxXm/epuHl+83Mt5pt9U5cY88FgCdd56dTeY303
         5u75IVy6ZWfowT1mOY46v1y6YUXkazXgnsoYxks+SrdUSGJEZTFNTbJwFMTedwtDkUx6
         d+N8kvhsRQ+hmAinoyiQhdljkn1xgACHb6MTCxnT+cJC+hw3Gw4zu8WkCxDDaf0wMOL7
         xmD1S0PYw84qmAZUsz6fIrb8WxOh4v2lJcu3XuazKWICi88Cx7a+Jd+6n4azSF7k2O0w
         7MCapoUaGX8peKPjr8mvjoW9oSOwvMu1YYI3vfYS2KTpLQGrUJTzhYHerYKEeutkKWcS
         kK3A==
X-Forwarded-Encrypted: i=1; AJvYcCWk2URcTZyTlfe0M8mpcteaCEG3QPnZsohCB3PT2hhWjlGxj5BMTU1xUJmrtCHCQQ54VSr2pwFW@vger.kernel.org, AJvYcCXgjU6M98LHXB/uAD8MbrWpgcDOSnsqOJy21c8EhGo05Xn7A0TV/5KQ3AIevUHwai49eUwRnrPnR79CubQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvSkoOoCveV6qtVdGYbC8F+EKotwPRb/kr37bnkHrIrUNlJiSX
	/B0vd9bsXVT9tBBTGOzEgcu00PrcVXFg/d2Y36uf7frDn49Vk0PHqMih
X-Gm-Gg: ASbGnct5c4hfH5hgxkWIrwpuqQHscInwE2Dg4ucKqgQjcskAHBy+VRo5NBuSoZPbiW6
	oKyDm2qkt64HVRYw3F/6+uns+ryybfQdcffyAXvItlRLN1+nQDbnGNN4vG4mvPwRohxGdXNSYh5
	k7x/c9ZJhBoWRT5jbEm93WPisRo4GDL2B+6bIYRu10G0UoDE6k24xvFdpQlMJqJ3GH+e9s/EIVG
	zZWBWPQkKhFwyMFwSY+ecGy9O7gq1RBf8u7JzqoYWI90mLmVtiRjTll4bqaUUXoBqyjPpoHbuht
	GtnXuOH3HfztaQ8cX0sHmmUSMedNA7NXuBJdhWHmXVPQKSzSuW6XCq7pkeZOesKHdLWMw3A=
X-Google-Smtp-Source: AGHT+IGl4reyggHA8el4hdyTW4gHEDw95iIYbJ8AasinVPNFSzf/QHyKePt4YHgRepUGNPMfasHeaQ==
X-Received: by 2002:a05:6512:401d:b0:553:297b:3d4e with SMTP id 2adb3069b0e04-5550b8db1dbmr4310343e87.52.1751270242171;
        Mon, 30 Jun 2025 00:57:22 -0700 (PDT)
Received: from pc.sberdevices.ru ([95.165.5.237])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b24046csm1338239e87.20.2025.06.30.00.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 00:57:21 -0700 (PDT)
From: Pavel Shpakovskiy <shpakovskiip@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@salutedevices.com,
	Pavel Shpakovskiy <shpakovskiip@gmail.com>
Subject: [PATCH v1] Bluetooth: L2CAP: Introduce minimum limit of rx_credits value
Date: Mon, 30 Jun 2025 10:56:56 +0300
Message-Id: <20250630075656.8970-1-shpakovskiip@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 96cd8eaa131f 
("Bluetooth: L2CAP: Derive rx credits from MTU and MPS") 
removed the static rx_credits setup to improve BLE packet
communication for high MTU values. However, due to vendor-specific 
issues in the Bluetooth module firmware, using low MTU values 
(especially less than 256 bytes) results in dynamically calculated
rx_credits being too low, causing slow speeds and occasional BLE 
connection failures.

This change aims to improve BLE connection stability and speed 
for low MTU values. It is possible to tune minimum value 
of rx credits with debugfs handle.

Signed-off-by: Pavel Shpakovskiy <shpakovskiip@gmail.com>
---
 include/net/bluetooth/l2cap.h |  2 ++
 net/bluetooth/l2cap_core.c    | 17 +++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 4bb0eaedda180..8648d9324a654 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -437,6 +437,8 @@ struct l2cap_conn_param_update_rsp {
 #define L2CAP_CONN_PARAM_ACCEPTED	0x0000
 #define L2CAP_CONN_PARAM_REJECTED	0x0001
 
+#define L2CAP_LE_MIN_CREDITS		10
+
 struct l2cap_le_conn_req {
 	__le16     psm;
 	__le16     scid;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c88f69dde995e..392d7ba0f0737 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -50,6 +50,8 @@ static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN | L2CAP_FEAT_UCD;
 static LIST_HEAD(chan_list);
 static DEFINE_RWLOCK(chan_list_lock);
 
+static u16 le_min_credits = L2CAP_LE_MIN_CREDITS;
+
 static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 				       u8 code, u8 ident, u16 dlen, void *data);
 static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
@@ -547,8 +549,17 @@ static __u16 l2cap_le_rx_credits(struct l2cap_chan *chan)
 	/* If we don't know the available space in the receiver buffer, give
 	 * enough credits for a full packet.
 	 */
-	if (chan->rx_avail == -1)
-		return (chan->imtu / chan->mps) + 1;
+	if (chan->rx_avail == -1) {
+		u16 rx_credits = (chan->imtu / chan->mps) + 1;
+
+		if (rx_credits < le_min_credits) {
+			rx_credits = le_min_credits;
+			BT_DBG("chan %p: set rx_credits to minimum value: %u",
+			       chan, chan->rx_credits);
+		}
+
+		return rx_credits;
+	}
 
 	/* If we know how much space is available in the receive buffer, give
 	 * out as many credits as would fill the buffer.
@@ -7661,6 +7672,8 @@ int __init l2cap_init(void)
 	l2cap_debugfs = debugfs_create_file("l2cap", 0444, bt_debugfs,
 					    NULL, &l2cap_debugfs_fops);
 
+	debugfs_create_u16("l2cap_le_min_credits", 0644, bt_debugfs,
+			   &le_min_credits);
 	return 0;
 }
 
-- 
2.34.1


