Return-Path: <netdev+bounces-219011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D8BB3F606
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 08:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3207C20610A
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 06:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999522E5429;
	Tue,  2 Sep 2025 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLAXxkOB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCD82AF1B
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756796169; cv=none; b=dMV9fBksf+lX0VM/y6nKvfSkCZ+TJSJaMPdPgBvSprzq5q8XCX9lLk4pXBOv2ZPu8eTEy3mwXJA5/NOoHVxulqLF4oRFsqf2CSjCGOwAXCHLXc/bLZLbPFi3XPsRjFzxG2oDxruHib23K2oAojAdhz3pyeVSl+Y62ptCyIImf3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756796169; c=relaxed/simple;
	bh=Fdzb+IyLIi/nFKLRErc+Gc4Dltwq7b/0NPoChgAFqq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L/VPWrSVPR5CXYePPjy267LHO79CfFaLp4KbnOp+prNl1j5P5hF5g1pEvfZ67a0ax9/mmso7Ac2LZtOs8nwqHc+k1DPMreLNuhHvATl7ECSJCHthdUGze/3QH8hodpPQUQ1onjJWj42sOrz1dzpGwk8pq8LbvqCzRwuhOLY5MqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLAXxkOB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-772679eb358so830529b3a.1
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 23:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756796167; x=1757400967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E58OWx4v1iHaLUWJF1TIEDfgEr4A5zIWuoF7X6q3eWI=;
        b=fLAXxkOBwutR5SN+iG38HQxPtkshuw6X/rnxCdjdyyjHiiWV1R+PJX0a4RhBQIGKq8
         /qkL79DjLItp/wVjazDlmllOI1I3E18sUx7XPRyoG4OOO+etpKTz5so3yya1SQgH7pv1
         VY3NzHowA4oMooESww7a9xAb6aI9jl/0s7MCAKIyAbQEFl97+ELlQVhF22XMBaNB8c7M
         0GnT1ozXeSYVvvTj6qRBC/tqLloIHm7GY1w2gdU4uY8n6gghG24K0s2ke2rR9Rz59ESu
         0wTvTvlOLJHsLsRI+FVhNoG3bSTkrNc5NeJI5xYKHJy9VJBJIHaMHHc1JJz8fndHRb7Z
         R4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756796167; x=1757400967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E58OWx4v1iHaLUWJF1TIEDfgEr4A5zIWuoF7X6q3eWI=;
        b=ijvoCN2bCuNAI8yD+fTXyP2Lb4LE94IuxwNdjBoD3Q6JvDgMifJkYIEqcuLKjNl6m3
         uoU12JvWpamXXERaRyXND36PA8QAzXuPDUM5oP0b7Pw+2OccJeY33whTnNXp5eGGWANX
         FRFDkYgMdOGsp9jNGdlJKy+tJ/zLl5RyWCSus6oNCuy0I0sJ54HQ3d3yL2G1jS0PR01R
         dr80GnxDZOjR9aXcITC8UahRpsTL+yRFauRtVa7QWq/SHxmSYm9nQXtIQHPbgR2qHPEG
         oIondrbVwK1omyML5Qg0/mcnyG9R9qN7PodzYsx0zp6boaNd/Rp13p0AiTjmYOKOU6qd
         4WFg==
X-Gm-Message-State: AOJu0Yxz5HdNWigYYGmIV/Vsexq6Nis8w8Jc4VKXAQ4zczHWlMK2GglG
	HgDrL2ShyWzpFfs/ppa+K/p4WXvHpJRufMd3eGWZe26NsdV9Kn1rP8aHpEu5NdSZqEg=
X-Gm-Gg: ASbGncuhNT2WzF2bb8G3jWjNQVJYk8hHinPdjlDwNZxEaDXWWFBWCv40RpTRMgikyn8
	evqRAAgJKEizFgRx4H4Fp69oeUxax4RRRJSUy0m6sbuh9B3OT0IFKVTWKjEIMql7/cFc8ecSey/
	K9HFj9PNf1Gb0RKuzQyWYhlV75hqJD2UbQ/9XBLa6w0lMXgzIe2SBlYsOp+9+oAR/evu9SVjIFB
	+iS/fkOxkU2NFsP+MtLilWDGGSys7i85RvKobKm81Hy4Bx/YingkD/0nEW4NNeFO4VtVlfcFEe8
	mCXItE6CoVDAsAPkvmCNrxTVR2merl6GhR2CV98LzZhQyjzcv2ej35QekpvPjNDGgbBeewt3yF7
	cxJdLuS5evTOtEZqoLfdj33XmqhDbKmMT77leKbhrFQ==
X-Google-Smtp-Source: AGHT+IFmWXFo2co4fEn8s8iD6/IORbb74MwWVApv1Pq4DbWoV7CxqWlux3YUtZ16ymRKleVXuiACsA==
X-Received: by 2002:a05:6a00:4b11:b0:76b:c09a:ae9 with SMTP id d2e1a72fcca58-7723e24d4bamr11034346b3a.10.1756796167209;
        Mon, 01 Sep 2025 23:56:07 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bf378sm12572957b3a.60.2025.09.01.23.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 23:56:06 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Acs <acsjakub@amazon.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Fernando Fernandez Mancera <ffmancera@riseup.net>,
	Taehee Yoo <ap420073@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next] hsr: use netdev_master_upper_dev_link() when linking lower ports
Date: Tue,  2 Sep 2025 06:55:58 +0000
Message-ID: <20250902065558.360927-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Unlike VLAN devices, HSR changes the lower device’s rx_handler, which
prevents the lower device from being attached to another master.
Switch to using netdev_master_upper_dev_link() when setting up the lower
device.

This could improves user experience, since ip link will now display the
HSR device as the master for its ports.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---

v2: no code change, update description, target to net-next (Jakub Kicinski)

---
 net/hsr/hsr_slave.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 102eccf5ead7..8177ac6c2d26 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -143,6 +143,7 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
 			     struct netlink_ext_ack *extack)
 
 {
+	struct netdev_lag_upper_info lag_upper_info;
 	struct net_device *hsr_dev;
 	struct hsr_port *master;
 	int res;
@@ -159,7 +160,9 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	hsr_dev = master->dev;
 
-	res = netdev_upper_dev_link(dev, hsr_dev, extack);
+	lag_upper_info.tx_type = NETDEV_LAG_TX_TYPE_BROADCAST;
+	lag_upper_info.hash_type = NETDEV_LAG_HASH_UNKNOWN;
+	res = netdev_master_upper_dev_link(dev, hsr_dev, NULL, &lag_upper_info, extack);
 	if (res)
 		goto fail_upper_dev_link;
 
-- 
2.50.1


