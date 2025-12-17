Return-Path: <netdev+bounces-245083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1586CC6B78
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 10:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2481930E4E06
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC2D342C94;
	Wed, 17 Dec 2025 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htG3QTef"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFDB33B6F3
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765961473; cv=none; b=I5CtwF3VpnYs0I7xAYj7inGEk99il1PX5Ja1RyIoAtxYv0Teub3abN35S7Q6LNz/HF+jFuGvODTeT9vT6Wh/qpOeYIG55shr6nwD3FvRl2ZI56UPbyFHDdNEoQ531efFW9QMeR0WQt4ERCb7XX7c4dLFNGTX+h+BWZ5n4K3mVZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765961473; c=relaxed/simple;
	bh=dpOQWuBh0QYcp41epU4bOBn1YkCEX2RBE5dAA6qahPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ETg1yS2eC5uad+KKPXcu3QfTy4nUt5NKxt1wqqw3od7J8zIxvbiL2FmU/CJ7nLK0bAgMBuwvwsmofxSsb34A5B+h9VrTkXR7taR/vR6rIE2Xwx7DHrRu+5xiH7Z7M30AUBuBARKX7fDvky+MHUvjJAJem/Aay/tlhMY4qW/czss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htG3QTef; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b75e366866so2342055b3a.2
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 00:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765961471; x=1766566271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=InBMy9THL/+AKttWz10fgYUD/zq8kVUZDf3eTuw65J8=;
        b=htG3QTef0iXqh5jPkxxW1NF4xyts36wIELh65mN2+VxJG8nTMO2+fA7pGnNQyndHYB
         /Lt1vfDzr2FwKL+oDPGts88BRjJJav3kKOFkE+z3y52S7SG51rB3BsrSt46jyiNpCiQi
         A4kL8dLjQ+qKzirSBp8/g//ARqiCh8nyX79uAVFlb6YozlB8g6jsXFICIsZ27Ny6AZm2
         H49+o1rxK+IOj9Yw4ycs77fzpkRvJ11bj0c408IY0yWbfPQWdqDtAZyGtm0ntnjV0uRw
         ylM8dkOjOa7Hu8TfVfyHLUgusypglH5N4it/ULbZq+gtydgBFvhNMsDAP7/70M5VHfDv
         rp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765961471; x=1766566271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InBMy9THL/+AKttWz10fgYUD/zq8kVUZDf3eTuw65J8=;
        b=Z2G5HOFgbHct/mrfJx/hg3kTbvaNo5uVV9oYpED4iY9MxnAs5seOdJx1gA2MrqKPH8
         wMbdrU3sKGaDTWhGJ488u/LOveKUtkVP5hiE0IH+WEcWOqwoBUoLojeJzYxPlPDodD4f
         odfWg9oYOTOeCor/yl9b56UV/l6tgPeQs9byQF2E0zR7aziBDTckYzvEIs390SgKdlP2
         xcUoWmA9rE/t1ji77QJ1meMdBfcKoD+ixzyw+726LCtYIYfQYVsA6WLmHQ4EJjQmjANo
         1nFCVI4dWIEfICOyYJLqUwv7vQJ9po1rYPUBroV5JAHBe9xE4x5a55VY5vioQUSvC8mo
         qvAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSuoA/CTXSTe1MqtQbUbxIE+82nqCXoxxvW2gA1PZGTkPIvHr+knM65ppJrk4Qy7sHLYXcAis=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD+ZKHni3ozidraDUm/sw8n4O2lnqgn7+u+yDLRhRaKxlJ5hRG
	O4cj52pCjCs1ds5b+xZtM/h860ybvlbVCMsCdWCrF/gYkXOLeIZRPWqK
X-Gm-Gg: AY/fxX72pT8DhJnQi1B+Amx2hRmxgyB/QT4DcbNOL/hBEoaY7h83bWwf9gkMttatN1B
	f5/GkWC3ZBm4K9OfpFWaGCeskYcKRTklgQjJWtwxmhBa8YZuXhpLhAldAdI2OQTVx9tW5Smijv/
	RVov+U6qbotONoYQi2SGY6l94RSDYrFq7XA8Hx+/x6Fr8F5WDN7j1nL8xZZ5sTbh+KQFc2b2Lx5
	bobZ613YV5XnSQ60ImC0zIOs6HTRxKFxNH/4JgW97yrbuOx/1e7dNT5gG9ChlIkSAgtA1BAs141
	BQgOrrWI4OoZbeTn2tUlDS2F23hHXqguwqL/qPK06S23gz1ortbLG1Rp1sPVaES5x10U/owuRtC
	vq/M8reDQTOZqGQcfPxnDExRN15mHLzVMHrARekYYQf7vAiH6fu/kTbAlyigTbly6Ak473J6ZmP
	oM/aRs6KwMJ23RBp+6/S68z7DBUe/2tp2ECGOjj8iK/+KWW2H5KMlxp3s7DPkni8BgqRg=
X-Google-Smtp-Source: AGHT+IEZIbsXjRYAzwthqUL9izCT0P/bBYc6ctvrcCaiRWG4w6M0LZKqWuthurxHYK2J2E0kB/Ip2Q==
X-Received: by 2002:a05:6a21:6d96:b0:35f:5896:85a4 with SMTP id adf61e73a8af0-369ad5e9564mr16560809637.5.1765961471020;
        Wed, 17 Dec 2025 00:51:11 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:d95a:1e5e:256b:2761])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2b8e0fb4sm17531670a12.25.2025.12.17.00.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 00:51:10 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	khalasa@piap.pl
Cc: o.rempel@pengutronix.de,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+3d43c9066a5b54902232@syzkaller.appspotmail.com
Subject: [PATCH] net: usb: asix: validate PHY address before use
Date: Wed, 17 Dec 2025 14:20:57 +0530
Message-ID: <20251217085057.270704-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASIX driver reads the PHY address from the USB device via
asix_read_phy_addr(). A malicious or faulty device can return an
invalid address (>= PHY_MAX_ADDR), which causes a warning in
mdiobus_get_phy():

  addr 207 out of range
  WARNING: drivers/net/phy/mdio_bus.c:76

Validate the PHY address before returning it from asix_read_phy_addr().

Reported-by: syzbot+3d43c9066a5b54902232@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3d43c9066a5b54902232
Tested-by: syzbot+3d43c9066a5b54902232@syzkaller.appspotmail.com
Fixes: 7e88b11a862a ("net: usb: asix: refactor asix_read_phy_addr() and handle errors on return")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/net/usb/asix_common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
index 7fd763917ae2..6ab3486072cb 100644
--- a/drivers/net/usb/asix_common.c
+++ b/drivers/net/usb/asix_common.c
@@ -335,6 +335,11 @@ int asix_read_phy_addr(struct usbnet *dev, bool internal)
 	offset = (internal ? 1 : 0);
 	ret = buf[offset];
 
+	if (ret >= PHY_MAX_ADDR) {
+		netdev_err(dev->net, "invalid PHY address: %d\n", ret);
+		return -ENODEV;
+	}
+
 	netdev_dbg(dev->net, "%s PHY address 0x%x\n",
 		   internal ? "internal" : "external", ret);
 
-- 
2.43.0


