Return-Path: <netdev+bounces-218891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890D8B3EF7E
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4ED84874B1
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BDF27B33F;
	Mon,  1 Sep 2025 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvVC3iKo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F284627A44A;
	Mon,  1 Sep 2025 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758014; cv=none; b=WS8bxe48TVY8kFO2dN4czndWml1XgV86Ht9+usAdiufab0J4dytLuLP6+R/D3kBPWt27pjT2wOmKkgh4ANTmc6ZGWqCeHFkpehwZRcdu2SkyQIOMON7Q4kXligTRf9yRJZhMoc+8w98W/AXZE8dx7gHN1M634gLPvJL/XILuVnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758014; c=relaxed/simple;
	bh=HbJ30dCazZc+WvSIXQMk2/8w4kjWLWDIFAkrSuu0ASw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IThQA/jn4vvhqleuPvPnrMpm7wwvOVpkfasw4j2RU5m2lxI7Zs6N6CeYR7A4X5KQRbTN2zKmWkHK3NVxjSXwBEKXkdgrUbVCgdEiXB/dl/qyxy3j1aTTi8edpNBA3ae8KuMBYgw2O7tvGYfnfREbYCukqs5/3XjBrFANA01KTDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvVC3iKo; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7725de6b57dso1323416b3a.0;
        Mon, 01 Sep 2025 13:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756758012; x=1757362812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeRSf9JRvQDMG1wF1dhz0wFZHyy96BAve4rAFav5LgU=;
        b=WvVC3iKoAUtE/82cJ4uEdrZ+sa10tlA0HOR+xTgEOpmrLFuK3UTmVb8HWrk9v6tq2v
         Zurnxqoi1I1dZ2fH/NMg/txKgkTwtst0uyeevTlrrurNkm5verZV987VTOj1rg2os/n/
         b8gjHJqMSUNyzQDqYVKGtJpNuw/1O48HvbVKkukALo6wIADezO24iQwlWgPWmETzf6dA
         yNu7hQJVddi3cbfcumSrMmYulCuaZYJah7/h5GlfEXFdU3/kFbLNiz+UmeQYEB6mDbR/
         VLLvmwxLuuVAvjAuaYSQ6Ws4pp/cFjY5dcXHIooXl/Omb0axddtz5HsRzOcGGpVvv/fR
         ZijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756758012; x=1757362812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeRSf9JRvQDMG1wF1dhz0wFZHyy96BAve4rAFav5LgU=;
        b=CkVdLChKkmG65R9O6fJgepaI4UjcA93mABa04gUxfcN9huAD4sTwfsqmsP+MftXwfo
         HMopI3WSwdBTs4G/sHGL23++iyRGgI0pTJYsA/KUeLWXegD7w1puJu2wgvyUFqhwGpy6
         b43Kh32u4D20ltaXkeDCa6aT3OH0SwYe687PqvUjSkSZfyyGZW5vKWgmnDozKUUTx7Gb
         ZXOHxh+Yb3OyA8l3kAvmB/hlNc5eACqF5hsM0PbsZUc3ue7EGVqiDSm3kMxYkKMToLVQ
         t5jc/sEAUAiLFnzDxrs+cZewBV+nQ1fNP9JR5kppWgWmicFPFc3Z0i68oK22LqPJyMhe
         wRpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4JAkQ1P/3bTDJUegXu5HVcRxDMV31jzrYZVj/u5zbIAqNNS75n4wEfyMWDng5vA13vwCXGBnM9hBQiaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFUHfbrb39zDowXAoXKI3ZMYiI5h+KyZhsDmNrzYQvaS7SjUhP
	novZa7fUH2r/hO7OIzI6qdFTZGsWyDxAxCzYQd/YXiOal53WosGuirtkDv8BYg==
X-Gm-Gg: ASbGncu8cFZQNH2/139DjVhtopjzHCjkUStDb/j6lYT8dHVTU+RjP9PboReCjJZROgZ
	ITw4DSSVp/fwmKZjTUygim99HRcYPfL0QcTrZhiddVRK4T6DetqEiT9NPFBbCFUMvsJtTI9ZEBx
	SF9meokaz0Vs5nV3RtQeOmscKRzq7odwy5etdLOngxI6r/87AyF0+3T/kKxsx9AhRF4kocrGork
	AWC2Uag+ZpGsIT5fqBYy8Cz0uTBW4JWc+IUYUm0m4HJdA5wTRXtJ22KLLO6epVDYj0E82hKgCdw
	y7CutMXUAzlHC7jBCz04mcxiCgddwZA4Zywv9q1NohJjV8TBm5N5rORMrkxVvdE5NZb7wo1f2Vy
	hP8Hwp+QMR8o4AbXa/VNo5q2uBhha8YJo2kWN7QK0JMuHx4EY0d1bw3R5WGmN
X-Google-Smtp-Source: AGHT+IE3xtASVy2SdxROSTGYMDf6f7CkIF6iF535o+i76CjRImTngY9vMHJCWvxziqWiKHC7hydYcQ==
X-Received: by 2002:a05:6a21:6d86:b0:240:406b:194c with SMTP id adf61e73a8af0-243d6f2fad3mr13073254637.41.1756758012083;
        Mon, 01 Sep 2025 13:20:12 -0700 (PDT)
Received: from archlinux ([2601:644:8200:acc7::9ec])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd007026esm10118256a12.9.2025.09.01.13.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:20:11 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com (maintainer:MICROCHIP LAN966X ETHERNET DRIVER),
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk> (maintainer:SFF/SFP/SFP+ MODULE SUPPORT:Keyword:phylink\.h|struct\s+phylink|\.phylink|>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next 1/2] net: lan966x: use of_get_mac_address
Date: Mon,  1 Sep 2025 13:20:00 -0700
Message-ID: <20250901202001.27024-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901202001.27024-1-rosenp@gmail.com>
References: <20250901202001.27024-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As lan966x is an OF driver, switching to the OF version allows usage of
NVMEM to override the MAC address of the interface.

Handle EPROBE_DEFER in the case that NVMEM loads after lan966x.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 7001584f1b7a..8bf28915c030 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -1083,7 +1083,6 @@ static int lan966x_probe(struct platform_device *pdev)
 {
 	struct fwnode_handle *ports, *portnp;
 	struct lan966x *lan966x;
-	u8 mac_addr[ETH_ALEN];
 	int err;
 
 	lan966x = devm_kzalloc(&pdev->dev, sizeof(*lan966x), GFP_KERNEL);
@@ -1093,9 +1092,11 @@ static int lan966x_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, lan966x);
 	lan966x->dev = &pdev->dev;
 
-	if (!device_get_mac_address(&pdev->dev, mac_addr)) {
-		ether_addr_copy(lan966x->base_mac, mac_addr);
-	} else {
+	err = of_get_mac_address(pdev->dev.of_node, lan966x->base_mac);
+	if (err == -EPROBE_DEFER)
+		return err;
+
+	if (err) {
 		pr_info("MAC addr was not set, use random MAC\n");
 		eth_random_addr(lan966x->base_mac);
 		lan966x->base_mac[5] &= 0xf0;
-- 
2.51.0


