Return-Path: <netdev+bounces-165694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5C2A33172
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 22:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D515E166455
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 21:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62436202C2E;
	Wed, 12 Feb 2025 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OA9v2ghg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88FE201025;
	Wed, 12 Feb 2025 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739395580; cv=none; b=EMfuSjMydauj3aCP/w0498c6EyDshmmnEtGU8hdISIx7vZImXKJ4DYhaoR36BM6yYrL1EtI81+dvmvNwY2Tvjxr8+vUR1mCHswWDg+E9rxtoGk6P6Ow1iMA6UNfrIsiHIjXsRL+l8nuzYnMF27vosEMyA5qwE0SSMAtbmERhjig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739395580; c=relaxed/simple;
	bh=LRZCQaspsOsbl6Xvcpdl0Em6oU9ssTagtKynW59UThY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NyL0N5RJEAPT6gV+71lV0pTGTGpCNyBoLXW6RvfujiI7WOPBGrIgftiCYCMdEhKki4GmDJjkFV+7o5UMyIhiteWjKTbDupFjdR7CmwDmpBFmGGx0VSq7b10e0i9fB9yExt+vdz6p/0FCw6qv29tKSp/h60ZVqPGKIig9ixTbx7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OA9v2ghg; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c07b2110cbso548685a.3;
        Wed, 12 Feb 2025 13:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739395577; x=1740000377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKVnOyx1/VLC5hIczSELZnSDd/twEbt35BMvF5Yzcpg=;
        b=OA9v2ghgkivk4KD19CIOHrK6UCyprVoAOg1qLTbmkcaT3DOejArt4zP0vgi2/c+u+M
         37vzDt7V5IYHfvVgjbH+CCpISZTxR9oSbMVv6Yvo7dcMloOPmRNDFJeWKeJM+373M3L/
         LA+pEVeW/TVxWVxvhuJtZ30OlXMLf68xCAP+AUZ5ymbIj+MXZBoW9r2lQrhTt1ru+OV3
         jQ9EDg2w6SwvMwmiEQVUrdwpDGNb5kdFtuMLr2qGWnzJzHlS1u04ezafK+TEFMAEmefo
         XakGchvEfpC8f3F4EaANLIFyEp2VwL1/cFsC20zs4Cp8ALbb9AXgzqHqu6agKT+3w/ET
         9Sqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739395577; x=1740000377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKVnOyx1/VLC5hIczSELZnSDd/twEbt35BMvF5Yzcpg=;
        b=d0+IW1BBkwSWWHRGA6lHmLRpRbic0ptrYBrQaFuKyDgOfVjO/5DeLJxZgKhUFKQ03p
         RtHvpoYqQKM3hKwmMYqm0WDP7E6sPUDSoouKHn2iQTNHdYfkmTzJkKRy/hCYtOcNCGhu
         ijcBpsfnVpuijWnd89l0/rTibllm0/PpJIqIjeW3yxdQauv508hA9YjucDeSfzbHaZsT
         5QRdFM6ouS07ZjvU99qOrF1f2B2jYopYl5QZFMMFEpiSbEpJYbPighak3KgAo9zFvn29
         aDefcJ9Ay72YSz+6Mwyk6yzGbrNqt8XdDZxeTQU9QXjGbB/3PRfwy7gL42niZrxK8xFg
         2okQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq1gpJWuhNNvWe+V97WtJ/81/rt2K+2rLhXIIqMI6FBzd/PC46Hy42nu5eCLzKQkU6bxumdsWnexseZ6M=@vger.kernel.org, AJvYcCXgSE5dar+uyA5l3oUs8SB7R8WvcIjnUclejVo3CmhcbdBAyXFFv1QpcCnB+2ei04Bas620F559@vger.kernel.org
X-Gm-Message-State: AOJu0YzEYW7m2bl+AFPg9Izisb8f6NtWccHXOsyWlHbPWL3J3psm7v7v
	MEgM0esmpKNrvnG8pift+a/crrTgRQL3o8LpF2I7CxBRmRKsURc=
X-Gm-Gg: ASbGncvN7OqrEAdLKS9pHTVcAqeoEQXmrejoeo5hEbkNvsDUZnjRl3mBPdbCz6D3AsF
	+VvIFx7xdtonE73AnF67v/LDXzOrcO8JY2QWnr5RAKr0QNZ4BMfrWIjfDPW8j+qCBtVky3YV8SK
	05DAVojTduMZEZgT214nL/awnr5YvHUshty2Zxl6NEKwWNmHQ2CKtnyFEqF8QS7N0c5TDkUzVPs
	scgaZKxKKc7YMOQi/D6pwfsJIv/DXXiHMNcKD9Jy/OgxD5KqO3aE8GcexWPVCITRsTAbJoi6rL3
	NgOjT2PBkqzb
X-Google-Smtp-Source: AGHT+IGd1Y0JnSACVaZOKyKB72nc3A5B1D1EcMp52cuNwxHCQGYLp7nvFvXTV7+ixgZOYHfw/YEdvw==
X-Received: by 2002:a05:620a:1926:b0:7be:3d02:b5e2 with SMTP id af79cd13be357-7c06fe307c4mr265815385a.6.1739395577321;
        Wed, 12 Feb 2025 13:26:17 -0800 (PST)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0728eb208sm148719985a.99.2025.02.12.13.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 13:26:16 -0800 (PST)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	richardcochran@gmail.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] soc: aspeed: Add NULL pointer check in aspeed_lpc_enable_snoop()
Date: Wed, 12 Feb 2025 15:25:56 -0600
Message-Id: <20250212212556.2667-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lpc_snoop->chan[channel].miscdev.name could be NULL, thus,
a pointer check is added to prevent potential NULL pointer dereference.
This is similar to the fix in commit 3027e7b15b02
("ice: Fix some null pointer dereference issues in ice_ptp.c").

This issue is found by our static analysis tool.

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 9ab5ba9cf1d6..376b3a910797 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -200,6 +200,8 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	lpc_snoop->chan[channel].miscdev.minor = MISC_DYNAMIC_MINOR;
 	lpc_snoop->chan[channel].miscdev.name =
 		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
+	if (!lpc_snoop->chan[channel].miscdev.name)
+		return -ENOMEM;
 	lpc_snoop->chan[channel].miscdev.fops = &snoop_fops;
 	lpc_snoop->chan[channel].miscdev.parent = dev;
 	rc = misc_register(&lpc_snoop->chan[channel].miscdev);
-- 
2.34.1


