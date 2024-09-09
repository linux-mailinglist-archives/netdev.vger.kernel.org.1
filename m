Return-Path: <netdev+bounces-126538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DED8971B7E
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E7B0B22292
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3701B9B55;
	Mon,  9 Sep 2024 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/Tppn1v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785A61B1403;
	Mon,  9 Sep 2024 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889577; cv=none; b=bRMwj6mlQs/OXhwYaEOADO1h8XPM3asZBQMImJCia2kf7PGwQ9WbXl1Kpl/W8kiwwL17dtOVuQ3ebEnVcKR9/Ms0wwgAxRKFUj7ar90NQdR8xsx1oM+N7PtO6ZTcUha7vCMw6W7NvBu/r+XQZFerNdmccTGMLiaZ7lft228kr+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889577; c=relaxed/simple;
	bh=iplRYtL2g0wea0iqy6D251Yydb/Pl3OdQS9g51XRlFg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WsgBx2CjfILZJCJRDDrf4GU/+Wpi5fRn4eIzjPtV5bI2RY03bIlY5pPiyBaMb8i1B/ymk9/q/NKFhjknlJfHFzpEtr1QzkAatCJrCiughAoUz65Afr4bdKjVWF5SqFGZLlssz5/K6PRZwefkjIvbGwmv/KsIWhuBPvPg0aFRsYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/Tppn1v; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374bd059b12so2654780f8f.1;
        Mon, 09 Sep 2024 06:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725889575; x=1726494375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jsb1hW5HiIcqNhuIYoIU21k0XvWHTUUsVMgaYZ6WuUQ=;
        b=Q/Tppn1v4Zf031qbiID8NTsyLP9iSatVbXgjbj9riPyNrRFRUitv8gAiYs7PYqoFZF
         9VvddGu+mBSaMNQOM0DlxqvVPCx7KdCCwLpjU3bY4MQ3luLAPznWPtUx7CxYAQHNHJMV
         JBVmHzR5llkUtaKyzIkxnXLenDnAo4CyRJLEBUuGtnnNTZ9+e9QTI45u7em3GyypT+17
         ABUqKnAzJ0PhwpMNzKUDMJvCVi2KYIZunVCDhfPfnQH+c3IXJNbLQM9jLgkAzOp0/W6F
         iNA/xxTtYhv8/oDxhVuobMaBShDuzqmdoPJHZfSprOpkKY07EN43ZyXs7/nook1+6val
         NeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889575; x=1726494375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsb1hW5HiIcqNhuIYoIU21k0XvWHTUUsVMgaYZ6WuUQ=;
        b=j8FwiLWj4ND5Vk2ggYGj3nlQQBHMYIdufBywJS55S7RfZrABntF5E8NASbeTao0Rgt
         1OoZAd7i/Yl8Ui+LcPeSfa0k1IAsfnnOZiKn/lOWbUTFvh7HugUvYxDL19yX8scN5CYo
         pfpeQ5aANIEBJVrmiJEapxAyQ91Cml6ccyHHXfkB0PF6k3dHeSNGDUBDGf2swhpdcmLE
         NhNX01O+Zvj1hRRwHmjJKdKbanjbMujaOf0RrdlFH3+OAxPWxQJFjFPtTCNF07CI48EZ
         tIW38PKcQ6lmJ/NbRi7CcqnDyWc6wciioxOai3FHLDdvDxl+Sg0RHSiWUmx5dRVk12Wz
         YZ4A==
X-Forwarded-Encrypted: i=1; AJvYcCVCa6O8deJSj5BEJFmobqgcw5y+5Xfl4hLz0RA74Ct4qy0Z0EkImjZ6BMDkpCdfoEibc3OBOFrEVEhgkwY=@vger.kernel.org, AJvYcCWeUWL9QWO87QZOyQJ6Rrts3qADTYlNLLihL2aGGlJeY0+nTpOmhmfUZa/WKCu7BLsAHiiqqLgK@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/Jf5nzNdy9TmAFv1TyodIDIpOrKRb2mA05Qf5/SBADTRy5ik
	ck6xRsWZ9ekFXTcDk7Zbb2G3m8DTuHnjn03uGz667rBFyeKtSepK
X-Google-Smtp-Source: AGHT+IFQL7agCuie4HPQrXUIGOQjmrOE9UbJfjjzFxKEnCpDAmCZFKVP1sYMkgzhBgJ4uOWfFjOQoQ==
X-Received: by 2002:a05:6000:1f0b:b0:374:c793:7bad with SMTP id ffacd0b85a97d-378949f7bfbmr4708962f8f.16.1725889574563;
        Mon, 09 Sep 2024 06:46:14 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb73ab096sm39270425e9.22.2024.09.09.06.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:46:13 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Justin Lai <justinlai0215@realtek.com>,
	Larry Chiu <larry.chiu@realtek.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] rtase: Fix spelling mistake: "tx_underun" -> "tx_underrun"
Date: Mon,  9 Sep 2024 14:46:12 +0100
Message-Id: <20240909134612.63912-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in the struct field tx_underun, rename
it to tx_underrun.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 7882f2c0e1a4..869183e1565e 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -98,7 +98,7 @@ struct rtase_counters {
 	__le64 rx_broadcast;
 	__le32 rx_multicast;
 	__le16 tx_aborted;
-	__le16 tx_underun;
+	__le16 tx_underrun;
 } __packed;
 
 static void rtase_w8(const struct rtase_private *tp, u16 reg, u8 val8)
@@ -1619,8 +1619,8 @@ static void rtase_dump_state(const struct net_device *dev)
 		   le32_to_cpu(counters->rx_multicast));
 	netdev_err(dev, "tx_aborted %d\n",
 		   le16_to_cpu(counters->tx_aborted));
-	netdev_err(dev, "tx_underun %d\n",
-		   le16_to_cpu(counters->tx_underun));
+	netdev_err(dev, "tx_underrun %d\n",
+		   le16_to_cpu(counters->tx_underrun));
 }
 
 static void rtase_tx_timeout(struct net_device *dev, unsigned int txqueue)
-- 
2.39.2


