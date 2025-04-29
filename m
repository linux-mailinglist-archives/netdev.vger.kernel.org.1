Return-Path: <netdev+bounces-186672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 126E8AA0495
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458123BA0B0
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 07:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BDA275118;
	Tue, 29 Apr 2025 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyuxBiDl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17081B0435;
	Tue, 29 Apr 2025 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745912007; cv=none; b=pyKsj2KSMYW19PqFYj/T0l11P9ZjRxb29PxE6tAq2Gok6d6Dies/Gxh1yoQLsNkvdFbkTfIyO1qX3GGdyywWkEMLAiyE6uWtm29U++n9qPGl8jEaoHoW32Ngs2vtXl4T2j+jgI5L8AxGVSzgYRqLCrqSWxrYNE6N4z+RiC0LkC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745912007; c=relaxed/simple;
	bh=xbBdlbJoUcbNkdE1y555rC3vQtsdOVxOcRqhEJpWYo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vCDDj73v2BvEq+/mpgzdj5O7BSjGrxnzdti4iDRjhxfkrNByXHZcnM3LZPGNw7JP9Tx32wwYgS6L5HTcvn6H/UVbyYnadOzHWLsxkcEJKwnNM3wHdTo2e0DSW5B5Qr9DpcAqbhtcYdFNg2jfIJeA/iB5CAeOX1n9v8Vhzj0iKiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyuxBiDl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso49982815e9.2;
        Tue, 29 Apr 2025 00:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745912004; x=1746516804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZRTG5mCMYe6uwsMFdp7Pmy09fK7am4dTvGc1TmLUd4=;
        b=MyuxBiDlhP/N4OTO7+GqaMe1/5J1pdl5+nurwAnj5FwJllFrt1xVUs5s3h0Z88SAqi
         yV6zmvC7GK6JB1GXYU6CAmH/rvNAtvmUxytbOKEvf4EhOveNNudUfhAzvemv/RIGK/yW
         SSkXj6p7mNaXljJey50t2EkSk8cG6Dvz0iIa7VpWPTAm8LarXoWeMxZ9A+ca9aTP0jmq
         wcYzF9OIulNM9PEkZu7mnnN5UYCoi12QqbeUntaShop4VsH3JzhaDqR6Bf1WH2DfaHLC
         fVU6qjXvwFflWuFr5IuJbBpw/wtnm4uNbI0A/2MImRugYj+V0/Gm4PZLAFKRZ1O16fuf
         KelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745912004; x=1746516804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZRTG5mCMYe6uwsMFdp7Pmy09fK7am4dTvGc1TmLUd4=;
        b=L+LvG6NWpLr2PWksmHsaAzcXI5lFg2ge6FXZDU4xu9MKZQn7Dwd6J8oQGKkDWgq2Zs
         jUlz/Py1kyU617vDeIUg/LNvXdkMGgucFHqqfwQgezgQaVSwR9wtdoAhg3mwyy6alMSq
         84Q7Z0N9rkzJoU3nemLsvPJ0TB7R+rvJbnotTq5kDFL71gvxG5gr26ig2I4JT+y0xRzi
         uy2VxTarylAWN+a/7cZktwMWEPf9oaJ8JhT8wh7QZAF9VWF9flk1fRodEnnh85+0zqfu
         tQjsTgSg1LQlBjN9NAde+HON4wOWwEAlv+GulcN8GohAW+ZpsW9vLTzCMnfmQ01thrMW
         q3dg==
X-Forwarded-Encrypted: i=1; AJvYcCU0erobSseJab2/ff9Gqfh5Cx0oteCfwoXfC2nWgozjxfwRAjZPB2vZ7vAPLsdB2//LwFeguXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1CeMSLz4e+IUKSQ2cMc4nTiiUGBoGQEAY6TGKcZeg85Z1qj1B
	UbrfGFwAfAeHd61MxuiGn4l0XA+GPsu3CRnhjuacmCpnNJTpOzrN
X-Gm-Gg: ASbGncskCsX+lXX8xzRSusLfcwSyuo45T2sTTvZu+g0wanMl8gqXD3u/vrglMmvWm+T
	Ac5/7eg7NZ76gJjm3Sp2sB+TqVqv4JY1abaRP8LwN8+tpnvwt0+ShKxhmPZFRBJzpXKrTJZnkoR
	dJEX3Gci6fnXd+P/2fbrHEqvuHcy1B1QaiylG1uXRH+afiyDgqdl7gTalfkB4MenTBosAtcJ43A
	90IjcS5MsVc1/yDLLKqCZKG7Kx/0wfwqaoTwquCE1mXGxzdPUM2ip03KILWO33vsR1+WDjipNPG
	s51OKScH8cEkL90aX7TNbaF5wOOMt/km1oxvREXCPa4dFMQ3h995NkSelGq4QBnZuSheJzRDCNd
	5EzNVunAFuICc
X-Google-Smtp-Source: AGHT+IEUrnuJA4deyu7945wrTrNUfySudUqxMZJWhUy8Gj0/dFs9gb2ysk2VCOhJsyfHHHJ7384okQ==
X-Received: by 2002:a05:600c:674e:b0:440:8fcd:cf16 with SMTP id 5b1f17b1804b1-440ab7d517cmr96110885e9.19.1745912004073;
        Tue, 29 Apr 2025 00:33:24 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2d868asm178728705e9.26.2025.04.29.00.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 00:33:23 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Sagi Maimon <sagi.maimon@adtran.com>,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH v2] ptp: ocp: Fix NULL dereference in Adva board SMA sysfs operations
Date: Tue, 29 Apr 2025 10:33:20 +0300
Message-ID: <20250429073320.33277-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sagi Maimon <sagi.maimon@adtran.com>

On Adva boards, SMA sysfs store/get operations can call
__handle_signal_outputs() or __handle_signal_inputs() while the `irig`
and `dcf` pointers are uninitialized, leading to a NULL pointer
dereference in __handle_signal() and causing a kernel crash. Adva boards
don't use `irig` or `dcf` functionality, so add Adva-specific callbacks
`ptp_ocp_sma_adva_set_outputs()` and `ptp_ocp_sma_adva_set_inputs()` that
avoid invoking `irig` or `dcf` input/output routines.

Fixes: ef61f5528fca ("ptp: ocp: add Adva timecard support")
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
Addressed comments from Vadim Fedorenko:
 - https://www.spinics.net/lists/kernel/msg5659845.html
Changes since v1:
 - Remove unused `irig` and `dcf` code.
---
---
 drivers/ptp/ptp_ocp.c | 52 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index faf6e027f89a..2ccdca4f6960 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2578,12 +2578,60 @@ static const struct ocp_sma_op ocp_fb_sma_op = {
 	.set_output	= ptp_ocp_sma_fb_set_output,
 };
 
+static int
+ptp_ocp_sma_adva_set_output(struct ptp_ocp *bp, int sma_nr, u32 val)
+{
+	u32 reg, mask, shift;
+	unsigned long flags;
+	u32 __iomem *gpio;
+
+	gpio = sma_nr > 2 ? &bp->sma_map1->gpio2 : &bp->sma_map2->gpio2;
+	shift = sma_nr & 1 ? 0 : 16;
+
+	mask = 0xffff << (16 - shift);
+
+	spin_lock_irqsave(&bp->lock, flags);
+
+	reg = ioread32(gpio);
+	reg = (reg & mask) | (val << shift);
+
+	iowrite32(reg, gpio);
+
+	spin_unlock_irqrestore(&bp->lock, flags);
+
+	return 0;
+}
+
+static int
+ptp_ocp_sma_adva_set_inputs(struct ptp_ocp *bp, int sma_nr, u32 val)
+{
+	u32 reg, mask, shift;
+	unsigned long flags;
+	u32 __iomem *gpio;
+
+	gpio = sma_nr > 2 ? &bp->sma_map2->gpio1 : &bp->sma_map1->gpio1;
+	shift = sma_nr & 1 ? 0 : 16;
+
+	mask = 0xffff << (16 - shift);
+
+	spin_lock_irqsave(&bp->lock, flags);
+
+	reg = ioread32(gpio);
+	reg = (reg & mask) | (val << shift);
+
+	iowrite32(reg, gpio);
+
+	spin_unlock_irqrestore(&bp->lock, flags);
+
+	return 0;
+}
+
 static const struct ocp_sma_op ocp_adva_sma_op = {
 	.tbl		= { ptp_ocp_adva_sma_in, ptp_ocp_adva_sma_out },
 	.init		= ptp_ocp_sma_fb_init,
 	.get		= ptp_ocp_sma_fb_get,
-	.set_inputs	= ptp_ocp_sma_fb_set_inputs,
-	.set_output	= ptp_ocp_sma_fb_set_output,
+	.set_inputs	= ptp_ocp_sma_adva_set_inputs,
+	.set_output	= ptp_ocp_sma_adva_set_output,
 };
 
 static int
-- 
2.47.0


