Return-Path: <netdev+bounces-186458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B57A9F37F
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 16:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F79168F37
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 14:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C2C269883;
	Mon, 28 Apr 2025 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghabFW4Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C975C2AD04;
	Mon, 28 Apr 2025 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745850835; cv=none; b=RUfhY6BUStYBWdWyHMWzg+342leONfzsfy7gOW6APiqf7id2V2EtW+HUSZtRoI7sdNfMt991vyZbLN6U6UG20QIrCEynqpCTP5zi0R6h00DL4yHMz9ujRM4t4ibDaZbgCmEzba2A1gNkBKM3c1yWjtvBYcjiuHtt1okjCj0C+gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745850835; c=relaxed/simple;
	bh=d20GTipVbRB3l5zgAl3x510pauuP792d74b6b3Gl7js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pAVcw+1zqjeCvAVh2ilpCOCtJas63zQwaZmU+UHNC9sgzRRFPWpyQJuBPthfd4KOTFNqRoKuOW33cLA4onWGKVmw1GB0k/cWUMppmPfaGb6q+oQvuqOKMK7EMnRWhZoNyphvBcmxgibOnlv5RQilVOWYPM0vU/louhqo0z9dAsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghabFW4Q; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39d83782ef6so4090706f8f.0;
        Mon, 28 Apr 2025 07:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745850832; x=1746455632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eLMBJu2+m8wSyhJfUpw0sbyDZyeYRNuTT+ciFfWuFWs=;
        b=ghabFW4QeQaTh0R/Yn/vre4oIFoWN4mooZOPggbvnvHCCh0Hz+81naBLJPX8j5HrId
         G88Qo+Zlm0X8Kr+DT6L+cyBZNHqdL4i/kg2IC3n70jPmq+cJz4pC6Be2aTv4okilQsfv
         mQBctZD1Ny1sAmeYt1t4I80gEOtRM1EwFrlKOiSkGylKK2QTH8gJI9FZqMj4zCn/me8o
         Oq8vE2oCc/WE7krHne68bhdze6uiLC+Ga9OWcAFx2Gbqhi9uB9UT67mIYIV8Otv13Jk7
         2GasXqzkerMXDVJma3KigI4HUGeL2TCtTvBsxD0/MdlBTiyb/+nq0hXznS3Rd5O8iMXl
         mXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745850832; x=1746455632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLMBJu2+m8wSyhJfUpw0sbyDZyeYRNuTT+ciFfWuFWs=;
        b=O21EoqbCN52XKrhduXxFgiB5v9eocleSGwwu+ecFJQqDWoNFowJwl+/kCQQzpeyEMI
         r4+uWBU34K/0IYqf0CJ+UggGCUAiBFBGQDNkRNo9L77kwPz6w2SaRsWTOLRFNFLGnN+b
         9azaJoy5ezEpH0Ks46t2t4rDRJc5/i6noM/Kqhir7PRVbj7+44hnBS3SSuJJPX+iuv23
         KQ9dC8/dyEwb27334XyUQmP4XNHO18oq9lh2G3Z1LyD3g4T6xalHQTSJR6HA9Unke3Oc
         ROHI9dZNVYnB0nxNawHg/BuRYJDfeeTaAnjrPtwJMRbvJM8tG6nsQl/US6/1FawNYYUl
         SGYw==
X-Forwarded-Encrypted: i=1; AJvYcCXZjPeprLL9vBb+6dho4o5sE6c5vh1BDgI4JSPbsEm5UZO89TYSCb1gSq+YcHRpOMM0+4uagZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB0vYD/mgAEr3Cd+MPvK4hacnkjg5cQ19yySD4nkchE9AkBWoR
	Epz0RLECe/ZCF5ZJ2BtX2huBl9FEgAgr9Y8Xn0cgv/ryjlRHAP5p
X-Gm-Gg: ASbGncu1qr4K1ZoLlFqPn173xYmNnto77BbNfFII/XILB92+rAc6/+57/Wb1Z/8WPyH
	sCMBCdxH9H+5BmefGLQnO5aejmTip3xEfFUxjRcQjDjQy8IwIVAThE5xFG1wazR1GFjxLMBDYq5
	4rJdx9MrVVW4dM4faKSoYpk5dXxeRG2arjull3vRdvFnw1sZ1tfvgTiK4+zgGijZmMu4hUOVjdp
	J+2os9qLlvmyEZs3Y3KrS7s50PrCsXyYFGIb7yee2iYc+vOJ1Wem/63zGQiC9KzRvEQZHHvPIoE
	vfppNVb4B7+mHSVkvdd9wQju/htPRPuiAuS7zrLVhPeahKcsMFK1v3XCgEHYe65dk+bDKF61ok7
	YPTY=
X-Google-Smtp-Source: AGHT+IGVnfynXJTNx19/KSZv+fN8acHct+F6K+RgM/5Dfk7bEbpKJ2i4zN8ruNE8PUthruYMTtl7WQ==
X-Received: by 2002:a5d:5885:0:b0:39c:266b:feec with SMTP id ffacd0b85a97d-3a074cf147cmr9963691f8f.7.1745850831806;
        Mon, 28 Apr 2025 07:33:51 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e46a49sm11421823f8f.61.2025.04.28.07.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 07:33:51 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
X-Google-Original-From: Sagi Maimon <sagi.maimon@adtran.com>
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
	Sagi Maimon <sagi.maimon@adtran.com>
Subject: [PATCH v1] ptp: ocp: Fix NULL dereference in Adva board SMA sysfs operations
Date: Mon, 28 Apr 2025 17:33:47 +0300
Message-ID: <20250428143347.23675-1-sagi.maimon@adtran.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Adva boards, SMA sysfs store/get operations can call
__handle_signal_outputs() or __handle_signal_inputs() while the `irig`
and `dcf` pointers are uninitialized, leading to a NULL pointer
dereference in __handle_signal() and causing a kernel crash. Add
Adva-specific callbacks ptp_ocp_sma_adva_set_outputs() and
ptp_ocp_sma_adva_set_inputs() to the ptp_ocp driver, and include NULL
checks for `irig` and `dcf` to prevent crashes.

Fixes: ef61f5528fca ("ptp: ocp: add Adva timecard support")
Signed-off-by: Sagi Maimon <sagi.maimon@adtran.com>
---
 drivers/ptp/ptp_ocp.c | 62 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index faf6e027f89a..3eaa2005b3b2 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2578,12 +2578,70 @@ static const struct ocp_sma_op ocp_fb_sma_op = {
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
+	if (bp->irig_out)
+		ptp_ocp_irig_out(bp, reg & 0x00100010);
+	if (bp->dcf_out)
+		ptp_ocp_dcf_out(bp, reg & 0x00200020);
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
+	if (bp->irig_in)
+		ptp_ocp_irig_in(bp, reg & 0x00100010);
+	if (bp->dcf_in)
+		ptp_ocp_dcf_in(bp, reg & 0x00200020);
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


