Return-Path: <netdev+bounces-245264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1ECCC9F2C
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 02:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 551E8302858E
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 01:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14A42459ED;
	Thu, 18 Dec 2025 01:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap7m0XjS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ECE2264AA
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 01:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766020328; cv=none; b=LAPkAYUkKEdhef0G3OesVpEbilg5aqkv1C80Mijrih1aP3DlzGnjtWDNCd8ZMQtydYZToDwWQEkj5PrbNK2E3m/drHFAd9+tiRVrzKiwzRak5max4yDfmNLZyD0L8q05dfPbH3p0if1dybFfWKm/XXwvHwbltD7nT7yDgz0B6Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766020328; c=relaxed/simple;
	bh=s9PK0bqGZdNUz/UoLjF3yDZIxEKPvTCoS9DzPQLFNrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pDJxgH4GoE332vuj1je02YCC+tt1j4RrLQN7l1ZG7vTpmAmoXLt7MD/wxZBoThGJS5YtiC5a/afvTmSmPuwbEgdBiUzCV/8RZMzAgBAHDOzuUWOcHUjDeskuokk0K81m/ss3aRfp0yj9WZSJl2LSuYNmIoXlbmf7et6SqC6lxtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ap7m0XjS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7f0db5700b2so127984b3a.0
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 17:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766020327; x=1766625127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cqayJvvvEzIpD6BlpMcbxJqU7Fdf+Cn2lVBKmN/a5pI=;
        b=ap7m0XjSpBKCyqavIKHmP5tMLvKYvc1rVaauYy9the7EBt1AtZ7Oiui9hzzMdMGAxC
         mLQB0KvcjmCF8OC+QxI8ST3t937PqzQ+1KrO+zhlGt+OQX7DA2pqzHtZW07vjW+DGTzs
         +A6BNXR5M3B2r1XoLxTwqM5XyOLdkoZSQWoGrF0zQaEB3CDRQXcROeet8/hVWldOX9zr
         ono4BH8XRkGawgEAIrLsKHzcydDcUoNmRuLoFQTVC5niSGAmvmd9Kb4T9QFTG/vqX+2x
         kRNms1RsFf7ZAgP12zYvjFHavQMha4tybpkRr47YbqxumepWqNPXSkZcJNJ4puG8QTsi
         oWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766020327; x=1766625127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqayJvvvEzIpD6BlpMcbxJqU7Fdf+Cn2lVBKmN/a5pI=;
        b=OeJB9nTNavN/jX2/iQlmVY1vwzKMt9WB8cXyhVajBP2WLuYi1pC9zPZ3nt6NJf6VJc
         zE6Mp7wB1Y4dzpTVcp12peGZDfIlQnyzvotZ4rhGMrIDwis37Lv8LW2kKFVbZ1pFDoyb
         K/tSX22YTfc8zimOm0mK/SPk57ca6Ya+VWqSYXNxh130QW1BLpTdVnqfEcm9F6ZRpf5M
         vOTvdwaOStFbxdjoc/pfK8z0ClsJBSPJhej2hpksmxhlLOy2yChHqmkFxz6ZQOrnG5q8
         htFdSrgmpdkVC9DffNa42FoLYgE/HdRXBCZL55STKT9tXow2LyvnRtZhPNEA12AAdLt0
         8L6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSVFWlfDtyVXXzmRAImxdp2kCG3Vn0WyQi542T9tcmmQkwLKLanKOOfCh/gjXgI2vxk4ftJis=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE3tzLu/6xJTg+1S96ZZs2z233Z2gVBqHUc96W3kqTw+wxbwE4
	8B511jeq/JmPuSAJuKykzw8F9Xy8cNWJY9csr35+LrxbyxAKNm7gcBIS
X-Gm-Gg: AY/fxX6qN1bVjoxpZhZV2lrND4Gk+ULz55LKvNtiN/EkgOkDkf7kEmDQpuX6ZHnJN4I
	8jQxzqNV4xbefzQr3ahvNMp3rQqDD98xyQRJgWtYOEaKpaGTnJfnP3foKVBAZZ1SFRiqa87DDEF
	jNSyRRYS4b6bO0KIe30CPpFW6Et8JHa8Mta0ZolClul7eeoWtZ/7lzJKKFSS2TXnj9X6xFtl7Vb
	EI8MRqcsFGcdLIHkvchF8+Z49p1UCuk3uBlI0Z8Nnkt/ute2OIUvYUAOcnHQB69lalG9ADxxBmg
	5+DhOAuvJ8u7KiSFp9qIZQnkadjQDQWHsU9PwVI83LhLcayoRSDoL3Y2A/2Y92Ol8OATnWa9eu1
	va41yKEWo9qOyfF7FSXPGEg8V6KCVwdM7kQQ+1FJ07iEQJ8fav2d5h/CDFRXWftx1fAMmYSXMra
	ijWdsb27twrvxRqnYdb+En6/HtO1dv1DjPW+LkQ34CqN48Q0LOFuAVmqZGzcXlpLG+LNw=
X-Google-Smtp-Source: AGHT+IFJqoTwqgKVjRcNNsxMRErlVDSEk/2rabThjD/yG3RsjGp4Bfvmj1fiJuJB/w7vsAffrQ/hLw==
X-Received: by 2002:a05:6a00:1d9d:b0:7e8:4398:b368 with SMTP id d2e1a72fcca58-7f669a974c0mr18352826b3a.59.1766020326541;
        Wed, 17 Dec 2025 17:12:06 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:a45b:c390:af5a:2503])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe70c4b853sm106470b3a.45.2025.12.17.17.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:12:05 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	khalasa@piap.pl,
	andriy.shevchenko@linux.intel.com
Cc: o.rempel@pengutronix.de,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+3d43c9066a5b54902232@syzkaller.appspotmail.com
Subject: [PATCH v2] net: usb: asix: validate PHY address before use
Date: Thu, 18 Dec 2025 06:41:56 +0530
Message-ID: <20251218011156.276824-1-kartikey406@gmail.com>
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

Validate the PHY address in asix_read_phy_addr() and remove the
now-redundant check in ax88172a.c.

Reported-by: syzbot+3d43c9066a5b54902232@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3d43c9066a5b54902232
Tested-by: syzbot+3d43c9066a5b54902232@syzkaller.appspotmail.com
Fixes: 7e88b11a862a ("net: usb: asix: refactor asix_read_phy_addr() and handle errors on return")
Link: https://lore.kernel.org/all/20251217085057.270704-1-kartikey406@gmail.com/T/ [v1]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v2:
  - Remove redundant validation check in ax88172a.c (Andrew Lunn)
---
 drivers/net/usb/asix_common.c | 5 +++++
 drivers/net/usb/ax88172a.c    | 6 +-----
 2 files changed, 6 insertions(+), 5 deletions(-)

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
 
diff --git a/drivers/net/usb/ax88172a.c b/drivers/net/usb/ax88172a.c
index f613e4bc68c8..758a423a459b 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -210,11 +210,7 @@ static int ax88172a_bind(struct usbnet *dev, struct usb_interface *intf)
 	ret = asix_read_phy_addr(dev, priv->use_embdphy);
 	if (ret < 0)
 		goto free;
-	if (ret >= PHY_MAX_ADDR) {
-		netdev_err(dev->net, "Invalid PHY address %#x\n", ret);
-		ret = -ENODEV;
-		goto free;
-	}
+
 	priv->phy_addr = ret;
 
 	ax88172a_reset_phy(dev, priv->use_embdphy);
-- 
2.43.0


