Return-Path: <netdev+bounces-160251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84473A19018
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 11:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC4C07A5439
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 10:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78862211494;
	Wed, 22 Jan 2025 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmmAnUtO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B2C211464;
	Wed, 22 Jan 2025 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737542636; cv=none; b=TD6nN6Z2R7OCEx4fwDc8KKRiw8TpYL+p2UELewSOw1fqEvxqqun8ZPrXNlv55y20a/hZrao57elFYw2xRtDDy85qu067GffYUcqPuhoagDBg39c6NVfnlSiatgIAefkmJrpmlkRDSNDOc/vUQ/B5LrxXZpYU2EUqwCGH/ntBSXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737542636; c=relaxed/simple;
	bh=7IGm911vUOkWZgIy+Be/s5qjNLSpBCaq3uAzUvgev5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RxqvPYTJ0oL2WuhuSbrlBfpXBV/U6EYbj87BLC0bS+C1lQjDcTYEnd9dWAmWhFoWyKIwfa7++XSi9F7tHithtwUrvTv2jVjp6HCZsayFHs6NpVzV1eDD3VSE/uDEw47tHeSvn9KFuOnoylzZxXUurFIGgWCGfYU/F6BG/qh5QzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmmAnUtO; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f4409fc8fdso1094830a91.1;
        Wed, 22 Jan 2025 02:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737542633; x=1738147433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fkPC1i2sSxMmUrTx0VCnD5+d9HTeCHfJmCCgbIfq+Rc=;
        b=JmmAnUtOLKFqRWN+acJhbIq6GJlT4Me0MEozer7xWvsJ0Ehy583uUFGGeDbjgxokyd
         doVPH5O6sUM/E5ZgLKzRj4ymnJ9WXaey68t3w9uTdbra1S5WDouQAquwkP9JpBHLgoDf
         8Wx+wQaQ5qluTzC+SOpcdVZ04iVlhcqRzz7n6eOL6gw2WW6CGT6zBSARitw8U5rsaN+H
         1uz+FZfDY5xIY/L5HhR28XZ939GZrU3/joGEPpc5HCeVyIL+5+o3yv04Szpv8FMMd2MC
         oUAq/bCmyzam62ZmhdLjwVUxh3E0rKYx/M7+d0xzy0P5puIHZexhUEm9JSIfmy5axhzU
         YHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737542633; x=1738147433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkPC1i2sSxMmUrTx0VCnD5+d9HTeCHfJmCCgbIfq+Rc=;
        b=v4AGyS5kyMhqranI52jipJ8r0ElWdO5CRq2UsJt+bXlCy8IwmWnc7/rHFAvITiAIAS
         tfx1mWOgQjPunoRFbnM1Qnjqzdw0Tse2Ynk4uf/m3Ld7wCL+YjZtmEnBOwsTQ7vcJRNd
         6J3mlJX03bfUud7xAAGdUY1VxWp1D4jB1cEDTIVrule1PeqRmqGtlZAr8KTASfkBnpOS
         O02ZSPXwchlG94oqdHTBlYdcgzym0E3rACh6c0Hn204pXTm9owMoIB87R2fQXz1Jl1Rg
         UE285iFOiiEs+ZrFZ6x7kGpYhAbe4SRelHDAVkpigcCHV9rSyUmo3doQSuqPCRZwNB6N
         xQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCUCiB6m2mD9COoKI6+oNVCuKhNdPgy5eh8nXex/8uWbC/Ilp/E15dc42zUUtkssW7aE2MvJRPJU@vger.kernel.org, AJvYcCXgbHK+s5KdEhLPUwywWlr9LobNieKKkzTsRENaSV+VD24OEQ3KVKKQ16CmALaIX3U94AHzXiSl/0H7a7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/TxibRT9O+ms1/RqNeL1aFIL9J2xYZXWOuBRzya/tsuODyS+
	EWcUUK3PuXZMOaBIEBWCn1L+8ZRltX43YdXvU3a+aGS+J4FRrw/0
X-Gm-Gg: ASbGncveOoSSQKj0aXcCv3hnaIHsIdzKxoAZs9oU428etc9g2rmOz6AX22WTLwqit8J
	aBfIA/sx35z7hGZ0b6NWgdkupHZHvLIogWt4ovVbfAL/G6801U+xPwDuwE6xeHNxUoToexM0zEg
	ivptmPquR59N+DgY8guUFI3BR8hxUHAWu1Cw7nu2HT8sWElI1tLIZKcii8Fj0XjX9yxWIGN+N/H
	x+nB1Tc2UCPNI6IMj8K7aFtO7qzzYISBn/FDx8zzAan8fXWefo0DuM+1sod/Axg60XvfsBhYA==
X-Google-Smtp-Source: AGHT+IEfVKkJ4GS364V1u71OAFpPt8DZDMt957lkAWfFJGA9SgKVgggY0puJYiM0NEkyy1x3KCPNNA==
X-Received: by 2002:a17:90b:50c3:b0:2ee:5c9b:35c0 with SMTP id 98e67ed59e1d1-2f782c455f8mr28375950a91.9.1737542633388;
        Wed, 22 Jan 2025 02:43:53 -0800 (PST)
Received: from HOME-PC ([223.185.135.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6a78d0bsm1396369a91.15.2025.01.22.02.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 02:43:53 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: wei.fang@nxp.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: [PATCH net] net: fec: remove unnecessary DMA mapping of TSO header
Date: Wed, 22 Jan 2025 16:13:07 +0530
Message-Id: <20250122104307.138659-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TSO header buffer is pre-allocated DMA memory, so there's no need to
map it again with dma_map_single() in fec_enet_txq_put_hdr_tso(). Remove
this redundant mapping operation.

Fixes: 79f339125ea3 ("net: fec: Add software TSO support")
Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 68725506a095..039de4c5044e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -805,15 +805,6 @@ fec_enet_txq_put_hdr_tso(struct fec_enet_priv_tx_q *txq,
 
 		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
 			swap_buffer(bufaddr, hdr_len);
-
-		dmabuf = dma_map_single(&fep->pdev->dev, bufaddr,
-					hdr_len, DMA_TO_DEVICE);
-		if (dma_mapping_error(&fep->pdev->dev, dmabuf)) {
-			dev_kfree_skb_any(skb);
-			if (net_ratelimit())
-				netdev_err(ndev, "Tx DMA memory map failed\n");
-			return NETDEV_TX_OK;
-		}
 	}
 
 	bdp->cbd_bufaddr = cpu_to_fec32(dmabuf);
-- 
2.34.1


