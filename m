Return-Path: <netdev+bounces-243954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74933CAB7A3
	for <lists+netdev@lfdr.de>; Sun, 07 Dec 2025 17:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAC8D301177B
	for <lists+netdev@lfdr.de>; Sun,  7 Dec 2025 16:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0D32609EE;
	Sun,  7 Dec 2025 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBt/mXdA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928603AC39
	for <netdev@vger.kernel.org>; Sun,  7 Dec 2025 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765124482; cv=none; b=ep7tC2T1HOgJjJRMMXaLP0h7P8XWC9W5fvJ7hV/34zTh8Qb2Cf8kWGMxB30E1yFKFnTHZuPyRAN8/CLQgeCJsWGSlcNUqz/7u01yZf5C4mTzs07DAlZNVQHvn64rqc2ZZHclntlHoDQU3JdmUqW7ai4nGS0U/8GNYFiYqrZ5lU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765124482; c=relaxed/simple;
	bh=aTpBxDYxksTFAVMcERh+SdMsNpsKZvznOD8tEYITfIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MWkoXer00yZGbl/mUiyOTDcmxxpUbI1mRsJ/qTPoFsc9i8ubX7u2y/b1zYQ/Uhv0ktNDnZpX22q3Z4PYzgt0OcvWPm+OhrdHQ2IRvf34m9TNwGSIUYasUduVs+5VEgXnJOFPgOmOacDjRSCKGGeNJ+w6fUUuKGHdUpt5UAo0AyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBt/mXdA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2984dfae043so37116695ad.0
        for <netdev@vger.kernel.org>; Sun, 07 Dec 2025 08:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765124481; x=1765729281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gxmW/WrhpBau6o+1U435pSaNgbYL+OSNAukVvCYs5Do=;
        b=TBt/mXdAC9ZvacXTpNzo1rZJwokg/yI4BR5AY7WCXJtBl7zE4FaZoGRZNo5oUontB1
         TLIk7mEQEHuw0ZMAD58QkCQvZ1YUg7/OkmaQeEJxICyL28DnevUR8zu14ZCj94oZcVEm
         M3chfNc1Cr+CAsLDyrc38+RSJPLk8ko8cWJIwAHDccUv3wCa9rFzI4Tyog56gAks4ULj
         HaRUv8kd+aMutgwnzjAGUMC7NXAjGFlbbRduilEn+1ZWJru8bbyHB2MghbphRdXkrzVB
         1QMRDrEN7DqBWysQYS6LJkaHYKt6Znu+6i3V/GhwRMDE9uuQWE6sMPRn4G5jlSqjwBuy
         ZX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765124481; x=1765729281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxmW/WrhpBau6o+1U435pSaNgbYL+OSNAukVvCYs5Do=;
        b=C+X0cIFT49IplSOL7W08JOY/E72+7N+mFIhsmXf4DzP/CHOPOzT33Iwtl5igecToqm
         WB+3nE/izeCc3OCs8sb4Qf1BNmEzlntmfEWkhsrJcwrv8tx/lzt/YSMaJ+AkbqSW+l7O
         IP0AjdliAmsW8SCnIWDEv71c4vx0efa+MdSLbA0y5lqqujfBBZUh1/AvrGtCROs/uC4j
         H4Zbqk3J7pgkghnZ2Ccg1qaxD6dBacho/p01QYw+caT6BE+cSharPpbPpodZdBFcciex
         LZCfEh9nLp4Zv0Dvfzqilapr5ZaHi742HiQNLDK4FHObLYzQRffBppxmA3o7M2vgY5tz
         WFbw==
X-Gm-Message-State: AOJu0YyQ+cEynec2vNcSvb6uoSP/t+qrWhR80Th5/KR+in+XP3oZgqJb
	IEaewpoF8MB4Qs08NptvCsYJGKBKhCWn30O/by+40W7XUPHykOja3m5cYvor7g==
X-Gm-Gg: ASbGnctb1/wmmvxPz0BvjYRfESto6tY+IMEy++ASxc0oa+nczpyUHu8efZ4gKQlZCjW
	YX3ffHvjlZaAICSKrKx0QpNn+F7qVKZI87QA9YRqWoiZS2JnFHIdqWQXr9x2hGNwNfg2pjEbYKw
	+YRcssyywFt+81BMZFS8yEuFwUgtaJ3HN46cx9zKAH4eNmlZc3bwkEfROJ1nRJfVvMxRtzPoVOt
	ha2tBmzyVSNBtOHGIRC1OJUfjE3vx04KJubs7dT/iRbgLnZQdGrH0r2/G7gVtVjKHgRnQoOOS5s
	IK1hTczP6S3eNwakJfWGd8M+4KmCGMfWBMP39AIszBigS0BRWhlhq6G34TdhEBkhKDYC9zKcEpz
	Sz8bJOFjk/8I0dd4G0VmUhmuBG/mbNrvxSb3TmdYhq/+tRtHpYXoK7CjDO0uE2yfg4vR4hfv5c4
	Cz7RtjtSDOAP/Ajfxl6Df5VI96D43xik6oAVtYU9UYwzIj1pVxzIqygEw=
X-Google-Smtp-Source: AGHT+IE0nd0Zf58zLEcThCAnghMhCjb47sIo2ZQF8p5AMwaI9NacMx6JQn7Hff2gH4FqY+oGqQwilA==
X-Received: by 2002:a17:902:ceca:b0:294:f1fa:9097 with SMTP id d9443c01a7336-29df5ca8c66mr55362805ad.34.1765124480605;
        Sun, 07 Dec 2025 08:21:20 -0800 (PST)
Received: from LAPTOP-0S8NEHD9.localdomain ([113.211.143.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeaaba2dsm102904245ad.69.2025.12.07.08.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 08:21:20 -0800 (PST)
From: Syed Tayyab Farooq <syedtayyabfarooq08@gmail.com>
X-Google-Original-From: Syed Tayyab Farooq <tayyabfarooq1997@outlook.com>
To: netdev@vger.kernel.org
Cc: syzbot+0e665e4b99cb925286a0@syzkaller.appspotmail.com,
	syedtayyabfarooq08@gmail.com,
	Syed Tayyab Farooq <tayyabfarooq1997@outlook.com>
Subject: [PATCH] memset skb to zero to avoid uninit value error from KMSAN
Date: Mon,  8 Dec 2025 00:20:52 +0800
Message-ID: <20251207162109.113159-1-tayyabfarooq1997@outlook.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Syed Tayyab Farooq <tayyabfarooq1997@outlook.com>
---

Hi syzbot,

Please test this patch.

#syz test: https://syzkaller.appspot.com/bug?extid=0e665e4b99cb925286a0

Thanks,
Tayyab


 net/phonet/af_phonet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/phonet/af_phonet.c b/net/phonet/af_phonet.c
index a27efa4faa4e..9279decd680b 100644
--- a/net/phonet/af_phonet.c
+++ b/net/phonet/af_phonet.c
@@ -208,6 +208,8 @@ static int pn_raw_send(const void *data, int len, struct net_device *dev,
 	if (skb == NULL)
 		return -ENOMEM;
 
+	memset(skb, 0, MAX_PHONET_HEADER + len);
+
 	if (phonet_address_lookup(dev_net(dev), pn_addr(dst)) == 0)
 		skb->pkt_type = PACKET_LOOPBACK;
 
-- 
2.43.0


