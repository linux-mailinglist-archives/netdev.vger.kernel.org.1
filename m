Return-Path: <netdev+bounces-212373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6961B1FB86
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 20:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C6C3B8F4B
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 18:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6AB1F03D8;
	Sun, 10 Aug 2025 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7ZfHMBm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A5920326;
	Sun, 10 Aug 2025 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754849036; cv=none; b=XzluhA8G454rp5Wpxpx0XXErze/20GqlQfwTISms7O5wGMNgTFXMUPjszUbjUAZWdW0ZCYYdfCFLl/VhsQO08uk9vnLwtt4aO3zgwq7Qk3AHRAMn75M0EIMuN9MHO1vGFuTiPkWqHnepIzv9ibMGDDY5SHByoE74Gn/vuEhU05I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754849036; c=relaxed/simple;
	bh=gaYOoHtzTnOvXU48a18BZKN8A69dA/OT/XQFvRAYK0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJaUEXr9NLFZu2xy7S8zRskVMA+CnLysYW529a4+22u7uBa1ulg+gH+6nH6m1x9gM/M9U2XKTDGIy2pgpgiKijrf5Y/u9dKt18OkSr11GIxX5Nk0KOBOFw7jBKP5fRIAfL3oIHO8YO8j70d1FTC+L7uLFnYWnlG6tmsKMlrZ9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7ZfHMBm; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-320dfa8cfa3so3473089a91.3;
        Sun, 10 Aug 2025 11:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754849034; x=1755453834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8iCC178+oHgUid4yigF5hFbaYT7QTZQRpFLb7VJp988=;
        b=f7ZfHMBmjmeagRKRqTn0XbUEqDELgd/2QLSqlRKatl4YbY0Fokg/ZVi/7+HYEPsXlm
         EzSeuTa1nU5YyaZi4zn6TaiXdGVeJxfNZXrIIlrmHOZjZY20JP/cWRGNk4SWrfVeJGxk
         RP87FfCFpuw/lfSYQMMQyT/xgRH1FsEtArmELPoK4Jd6O58+unH0RVjpHUe/WtVJ4S4B
         7taJiFz8AVkC5Jmm8wTsMTZR8uSeCWUPdqng++6mESbzXV7hUMB3k1hhjXxk15iqef64
         AKxbhsIUBcBQ/pvsYEhEPKrxQ/Raw6ncMSu+DhgMHPEfHIzKODAQRu5d+XLVxMMxMwPW
         0uGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754849034; x=1755453834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8iCC178+oHgUid4yigF5hFbaYT7QTZQRpFLb7VJp988=;
        b=R/nQjvxHCp++K8fuHt/2LpKgG0/8XCZJ1OdK/Dygx8Cg9+ThWTY/9tjUGkqn0DFDEZ
         QhdSFlcFgFTDpZlierNpg/WIchvYbqL3vlXOJgTcUCwulj7Y5uSE0Z+pt5mJYoDcoI3N
         GFFhAP9oLIiNUhWlAfNq+DRJlnvaIYhOoonf41377TbKUn3aNOjyi7JFnT3ZEMKzsXmA
         VqZGjKvNwAN8LOvFYaUisxgb2nfGwyABIiawFFrDSA5ky/VlFENlYV0nt044YyYSrFQr
         vEtZ9tFYS97+chT8H5h0VHlDjSGTqwFJb/M51eU0vsBcZj+MTAO04UCTUpuVqpsQRqaX
         YD8A==
X-Forwarded-Encrypted: i=1; AJvYcCUnyfF5EWmwpgAd/jb/3t4BUxvxMa6UDwip778dkI2ZzfyUq2n7UjKmBF8wK/AFvz0Uj873TeIO5ZkIPg4=@vger.kernel.org, AJvYcCWHTyaFjWUsgfTpAGg8L7ezmJsmN5mbhmxgicZ2wa/aCzlo3RYl5NI4pqwdDapTIXZ//ebRiC8t@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ3mjTE6dT49Sn01cog3zsfHN8kALBuALvlPV7men1t08lCRzs
	HH4IRsM+s2rAcf57qIVPh1HZe5u0nBhm8tH8DRTIA+kn3Rt2oLf3mBHWS1oj33S+
X-Gm-Gg: ASbGnctSgcuegzqj/a4BTpTGo/LvKwMgtfmE/MQWTYJzueZAkef7YS8U/rToY8N58k5
	q1nVbFw9f0XiIKzcnHgbke3T/DwKiM9DGrc+SsEKmQu6YVmmeSENwVeu4g2dQE943ijys4c2PZg
	SY45pIeMzrz6GRwuhRhOdJuaqnPqFuU9A0bDNWFLxeJ5MNd5n51ZaftbEd9Af4/3pZoNiZeVsib
	iIngtVXqpiQeRJcSud4+7KkJc7MuL7AbNhkm2b+9CPEm1GA9dly30TCWnmu28IBzZzO7Sajupn0
	XbmWCE3BEhYpyw6gENK77Dn5cdXvLETyfbhvUkUKCL7JoMjZ8krCeKATg3oyTxmlYdy5JSYNN2l
	C6A40Wq2/jdR5tDfKpD3+5Lj6n52QvvDiQnonaPhy6LR8yPiTxlxPxAg=
X-Google-Smtp-Source: AGHT+IFbmMq9se1Gfprc0dkctpXAIoLrgj2/vUGkJmxiyPVwrDO/BYSwEweScA9h1dNxojoUAJO8kg==
X-Received: by 2002:a17:90b:3c83:b0:31e:f193:1822 with SMTP id 98e67ed59e1d1-32183c48368mr14203717a91.28.1754849034415;
        Sun, 10 Aug 2025 11:03:54 -0700 (PDT)
Received: from chandra-mohan-sundar.. ([2401:4900:1cba:adf9:80de:8778:334d:8ba1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b43c54fbce4sm3256987a12.55.2025.08.10.11.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 11:03:54 -0700 (PDT)
From: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
To: sgoutham@marvell.com,
	lcherian@marvell.com,
	gakula@marvell.com,
	jerinj@marvell.com,
	hkelam@marvell.com,
	sbhatta@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: Chandra Mohan Sundar <chandramohan.explore@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH net] Octeontx2-af: Fix negative array index read warning
Date: Sun, 10 Aug 2025 23:33:27 +0530
Message-ID: <20250810180339.228231-1-chandramohan.explore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cgx_get_cgxid function may return a negative value.
Using this value directly as an array index triggers Coverity warnings.

Validate the returned value and handle the case gracefully.

Signed-off-by: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 8375f18c8e07..b14de93a2481 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -3005,6 +3005,8 @@ static int cgx_print_fwdata(struct seq_file *s, int lmac_id)
 		return -EAGAIN;
 
 	cgx_id = cgx_get_cgxid(cgxd);
+	if (cgx_id < 0)
+		return -EINVAL;
 
 	if (rvu->hw->lmac_per_cgx == CGX_LMACS_USX)
 		fwdata =  &rvu->fwdata->cgx_fw_data_usx[cgx_id][lmac_id];
-- 
2.43.0


