Return-Path: <netdev+bounces-127148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650E5974565
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 00:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957651C25376
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 22:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4921ABEC0;
	Tue, 10 Sep 2024 22:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wjdt+G3R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2E51A38EE;
	Tue, 10 Sep 2024 22:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006158; cv=none; b=JCVN9Ko18BjAtyE7IWmIDMQxqeLyLMSoUIDnUmS04rqArQ5d9Y3CED5vtok/crjJIeumknGjp6NxR1yRXLYjGUPa2Lu1bbmOw2LWokoCd9vVGCiSBeDfmIuLVPPKLE5pf1NTmcESA9/ZNBtMy1/8EEM9lp5ruL7GRaQZL45JnD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006158; c=relaxed/simple;
	bh=UC492TViKow3sU0MNcqyylalwJUa6SkDtCaqKQQko50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jnjkskIt3MnaMrIhkMC2j155gaCnDtai14B4vnSRYPEebPplx99qUlrLW1lbAyNIvG5P9n3vqeocoSscb8XQ5APuOaNpjUywk8A9rHBS7pzH2f6Z03uSOMW9W7E9kUhDWtpb6VldUBkboHWX9hK/pBvn6CQRMzwpYHNmCM83T1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wjdt+G3R; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-206aee40676so50457935ad.0;
        Tue, 10 Sep 2024 15:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726006156; x=1726610956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4773Rvu09r0h6PHXGaI6AMnY7/hdXotFStOCXJRY+po=;
        b=Wjdt+G3RPd22S+ps1oCdw8JrxrsnXvIYGwZ7sEfIQyMPyzt+gMBBJrEfI+2QkKF1Qt
         BXL8SOg1RRWbqI0EpdC3+IJorXrMkIjJNMmrIC8dKpxu5LrcBsMCSprWdcs09fMwkGHj
         LFqNxzTGgd5WQuymoM39BeVYU5bxY67x9Uh5QpYMVKmoJu2hQQrJAs2gAXXDB9r3nene
         UULqm96b6Z7Ei+LDV4uzUxf7QAQswk5faqlfXUiQS2cnnk+ra6FoWRmNflUHLoNEqSV/
         BIUDQZMSHG6cg/+vwdSdj2RUl9MhPpm2NNOs/c5HGhBsYt5HMsG1tXA1PHm7Uo5y+fdo
         QawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726006156; x=1726610956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4773Rvu09r0h6PHXGaI6AMnY7/hdXotFStOCXJRY+po=;
        b=X0FzaAipSI2J2UUm/DEhxzruW/Zse4MnPtWi4Qe/tSABjn3miWp4mljksrgFVQsFOM
         q+HQp4sekfl1v+S67KDANAYqwdvygqeV2XatCAIomt+Pwf66UtEpp9GqtJktetj//X6m
         GWROwkwhmt3ZMvHZRS94FLblNEkEjw2E9OmFK3X1IITkmeQwA2K1vdpm8NbTSYLZZsp9
         ByljRMW+/VEm9IlpOrKElpzOqUlfVT0YtCJR3dqqYazoghuhb5/+/hL5n7virQS3a1Jg
         sNOAlG17UbrcyHdCVO3dvCbgRHMaHiuSV/PCkjijmBSUJDHAUiffk6A1kYWSgZgb5pTF
         Q6vg==
X-Forwarded-Encrypted: i=1; AJvYcCUwNskuY85FOwa9O98zNG8xiZOVu97iV5P/qvhfdXN8bL7hs45qj7R6Mm8WRdDGP08jmwfms6C+pqUtbi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLizD3wQsVkLHA4Psx1VoElITIxM41MkB9S0q7fT1zBk0Vk9Jp
	Lyt0cPZ8tvfbjO7mR60MfT+toGo6XjMgc/TEY0/DogTQonWE9HlOjybh9w7P
X-Google-Smtp-Source: AGHT+IGsAMFMKE8Go/IHg15W8t4bWEhonD919grXqat/P6VH98GgrcZV2ysBDWdzrPJpOUTev+amFQ==
X-Received: by 2002:a17:902:c408:b0:205:951b:563f with SMTP id d9443c01a7336-2074c6fe6b6mr24778705ad.49.1726006155844;
        Tue, 10 Sep 2024 15:09:15 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f38218sm52946525ad.292.2024.09.10.15.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 15:09:15 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv2 net-next] net: gianfar: fix NVMEM mac address
Date: Tue, 10 Sep 2024 15:09:13 -0700
Message-ID: <20240910220913.14101-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If nvmem loads after the ethernet driver, mac address assignments will
not take effect. of_get_ethdev_address returns EPROBE_DEFER in such a
case so we need to handle that to avoid eth_hw_addr_random.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
 v2: use goto instead of return
---
 drivers/net/ethernet/freescale/gianfar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 2baef59f741d..ecb1703ea150 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -754,6 +754,8 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 		priv->device_flags |= FSL_GIANFAR_DEV_HAS_BUF_STASHING;
 
 	err = of_get_ethdev_address(np, dev);
+	if (err == -EPROBE_DEFER)
+		goto err_grp_init;
 	if (err) {
 		eth_hw_addr_random(dev);
 		dev_info(&ofdev->dev, "Using random MAC address: %pM\n", dev->dev_addr);
-- 
2.46.0


