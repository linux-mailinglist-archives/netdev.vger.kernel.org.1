Return-Path: <netdev+bounces-155164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F633A01533
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 15:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10AD93A4024
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 14:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122E9176AA9;
	Sat,  4 Jan 2025 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ow5pFg6C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26258189B8F
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736000449; cv=none; b=HRSL+kHyygmP7Ll/Lv7nlLxUpnun5YVAfPcxU2xpzt2PoFSdFyZasqXe39M4CwcOGhdCf2PFYZf7+xVC+g2M+Vn+2a6iA6G0nBzGraXCyB6XfCufee/RodeGO+fSCdjPVQ4+FvN6JFPWCLe4vZ0srMZnFNQC3YVTViONVDyfFJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736000449; c=relaxed/simple;
	bh=eVgs3PCXqky4uyt6ABNBEGXpRJe82iXhyMLaqyrkw1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f7WJ2A6lYGRuQx7/23Avdflallp2/WIa6aXaMd5vORl29zk1qr+CrQhn6gac6A3V5WAF9BAyCWOrNCIJQ3emIQYFR4TzY9VnYYWbwYLCN712uN4a1Ue0RzTAAkLpwjS5zCU7gmAe4MhOjPy0KNxPxPTIpmmXgNvpch33qeDapdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ow5pFg6C; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d44550adb7so3119191a12.2
        for <netdev@vger.kernel.org>; Sat, 04 Jan 2025 06:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736000446; x=1736605246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L97nnv6RYOpgwrTXImS1pc69DfgbqhSWnbNEYnc9INU=;
        b=ow5pFg6CaTA/hcWtoTSj06wsoRgiqzd/ae1ivXfqdPXj+DD9rLkOROvkawHF1aXVjK
         zVu8kuBM/cjvjbt+ywMhC/FrXusL9f046/kRdU2yB76nGhS4pkgMSfwobaGkXGbER/h5
         RBnCaHAd2zieUp/QF8JSZCyfTXZNgBF7n/ML4o9Czl7f8Z2tV3AIFJ5eJLVU0lSUirze
         rmA0h4BcN+okUdND10jcH3Z1HOib6LPqCvoiM/ajzgdgXmSx055PzWTq7OTsVS7knCUx
         y7DPxuMWSLfgoAiuRoxaWB/jNh2Tn8ARemLK/5IplPLSkini8AVu3uidZOFMlWlerbVO
         ouTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736000446; x=1736605246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L97nnv6RYOpgwrTXImS1pc69DfgbqhSWnbNEYnc9INU=;
        b=KCYxcjiD69fwdiVPzxU8/WD1hrbautS1XCvE4laRhxMMe/QtBYXdhzE2ZQmPOzjB0I
         PkO9ewc2bjSetbloLvpZ9jtFTBGiUq97L7t+FFUXfnvQGd5rIdWo+LR3TTLPV2wX+rfM
         ysiKNrrYqE+hwVJasRhEmksfi3AW/wAgUJ4qOcBXhIt+pTAIi4ST3tY5meHjbhL8oXOd
         BeoSmb/wIFDT2cs9nS7LFBKQRago36qj0Scoq0X9r+wVtfslao4GyK9gvmE7duaUtZJ6
         wFMZYgpxeKdsK2qd6xTlUUZoQKkKit4oskXSZfzorqE08R0YVbQMaoWyBu5mFilW3Td1
         BBsA==
X-Forwarded-Encrypted: i=1; AJvYcCWbKV3hZTJ5jLFSOF8TIY+XJwSPFKwNPnedCcX17wGWrEm7JTWnFdMDeqVpVx0CYcuLwkhCJN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOBFIW556G/hIFZKbT8gpKxmGZa2KQ8PGbaZ4XZx4UUdsflw3W
	Vi5355BzNcNlUSpEVq3Hbt7E59TmbpoGqO0FNX+8zvp1PFJN4hPZJi0/wMGXjJ6XIMreYGnSxzE
	U
X-Gm-Gg: ASbGnct4HfxSZAOmnO62E+aqZhkRUQeDKSb5i7l3EotKvsURPNL1/8mkjueLiNub8PU
	NQ/b2iUlWpU//pjVBBjCDbWQNtVb+Cdqf5vq5ur6sa1QhbBMa0x5ADCrkZTxToprrTcZ3vxjkUv
	Xkl1IGFpAtVCkkxWgKhf+Arjzl1g9Xsv5TVPS25bib3Hpwc6hgESLmlwqrfVkz3VxUVakm0p/ix
	fU5mnKjR9aDk2pOUzyWLLHYuNmhOaA9GZbrbn46E3bOXJyhHoKR0v4jP8m1pyR1n+q5IsM=
X-Google-Smtp-Source: AGHT+IHwGbZVkG211x6UmHpmKAUnIk/VlBs5m3FZ70AqueQY/czbZ9SdfSt4tHy7ZtiCXAg6lm0+Cg==
X-Received: by 2002:a17:907:d15:b0:a9a:2a56:b54 with SMTP id a640c23a62f3a-aac2b0a5754mr1871809466b.5.1736000446253;
        Sat, 04 Jan 2025 06:20:46 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82f828sm2013944266b.19.2025.01.04.06.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 06:20:45 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] nfc: st21nfca: Drop unneeded null check in st21nfca_tx_work()
Date: Sat,  4 Jan 2025 15:20:43 +0100
Message-ID: <20250104142043.116045-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable 'info' is obtained via container_of() of struct work_struct, so
it cannot be NULL.  Simplify the code and solve Smatch warning:

  drivers/nfc/st21nfca/dep.c:119 st21nfca_tx_work() warn: can 'info' even be NULL?

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/nfc/st21nfca/dep.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/nfc/st21nfca/dep.c b/drivers/nfc/st21nfca/dep.c
index 1ec651e31064..3425b68f0ddc 100644
--- a/drivers/nfc/st21nfca/dep.c
+++ b/drivers/nfc/st21nfca/dep.c
@@ -116,18 +116,16 @@ static void st21nfca_tx_work(struct work_struct *work)
 	struct nfc_dev *dev;
 	struct sk_buff *skb;
 
-	if (info) {
-		dev = info->hdev->ndev;
-		skb = info->dep_info.tx_pending;
+	dev = info->hdev->ndev;
+	skb = info->dep_info.tx_pending;
 
-		device_lock(&dev->dev);
+	device_lock(&dev->dev);
 
-		nfc_hci_send_cmd_async(info->hdev, ST21NFCA_RF_READER_F_GATE,
-				ST21NFCA_WR_XCHG_DATA, skb->data, skb->len,
-				info->async_cb, info);
-		device_unlock(&dev->dev);
-		kfree_skb(skb);
-	}
+	nfc_hci_send_cmd_async(info->hdev, ST21NFCA_RF_READER_F_GATE,
+			ST21NFCA_WR_XCHG_DATA, skb->data, skb->len,
+			info->async_cb, info);
+	device_unlock(&dev->dev);
+	kfree_skb(skb);
 }
 
 static void st21nfca_im_send_pdu(struct st21nfca_hci_info *info,
-- 
2.43.0


