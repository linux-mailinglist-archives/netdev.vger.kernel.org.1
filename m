Return-Path: <netdev+bounces-282265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHo9HOKw8WmwjgEAu9opvQ
	(envelope-from <netdev+bounces-282265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:18:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1631F490575
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76D0F3076179
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 07:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD783A3E80;
	Wed, 29 Apr 2026 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4xIbUUh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D67539C65E
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 07:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446862; cv=none; b=uiEHVFJkyx0CqUVDpVpTIqtCkNn5fULsPODAMTwm8lqlWaaBR9B/cUh9dph+bA8AccQtR9B1pjrIZhgRsmfg2jrBUlCGbbkIpAI+XMpoDvyFPT86EWA7nktE0zZBFhsCRE4IXLAXvEa/ZU3WIE5rakF/lc8er/VjhjVMbB+pbME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446862; c=relaxed/simple;
	bh=BzL2dzaDkxeqGllHqj3NV6tg03FX4+dG8gU9GpWFTqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGlbdCWH6X/rt0AeEImsgQ2Ws82ovsazieo1OT+XZFL6y1sregAAZApNoVCVuaCAJsLknyEa9ZMolFYtPnaZIAnFf8oaWR8FbPPPQCLquujZRpxqKVoxo/b23lneQXzzw6nl2P/AnDKi6L7ro3o/p/RnHr9PFKX3rLUkAoLNlOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4xIbUUh; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38dfb789d7fso94443401fa.2
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 00:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777446859; x=1778051659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEfFwVoPkTu57X++6jUaIy2CgDN8Kgokv8XI4v/O6v8=;
        b=f4xIbUUhbaKClwpI7QDtMYfSpbLGolNibAaasNUoHuJv5HrL30gbSVR9bPRlOG2dCA
         GsI5s8mI7nXxnWZZVXr4YS9eET+3o8OkwVhNkScVdax0FBVCaJ1FM+Ko2CCCB0Nhg1cE
         3SO7/sxkJKC8RxT7AEiUpvh2xdW90j59ZsgGRYt5hyRADqkBRzRmPvXGCzRh5ZTlzBA8
         JVW3N5z8GxsoeF/7+FzxzojgbdncshthlmW967ZoXYkClth9Z6G/A3Gy/Ru5j4MSr1g2
         HsSRk3vxysbNAkAyM7FOBqXjzrq7plCyfUw5TEJuuy0TsoFlKrxr0x+lEtgEP0CPKvIl
         Ignw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777446859; x=1778051659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YEfFwVoPkTu57X++6jUaIy2CgDN8Kgokv8XI4v/O6v8=;
        b=nYDQTukiVTkmflC4SsELWrG6RWkW5gHz42ONZDQsF1oYmIPctQ6h1FYoF3TZruYodt
         2j8RWTH/uxvoTFTavcLw8ujU3t38YPFcj7bgwCxKTDEI7dS/g9dtLuHo45d/dUjJybMj
         jT4+Olok/WeHsLqt6DFPJWGM/dhvHIWNtHYE+j2zOwuXq5ZO6VIvWiVgdIc2QWa89jGe
         s5cBfumA2UeHaypho+I2jM8AKLPpJYNmFp7Ilqn8hTyZz7Dm3S7bBl0at4Q6MTZyC3Rz
         9bzTdZ4BgE0TT4zHkP6NgoY2CoVjkY1NtA28ve3HRJODSBM9i6/mSuhNFtPXWdkScIuo
         8Rwg==
X-Forwarded-Encrypted: i=1; AFNElJ/LiAoP3WqUbDpuPkQ2DrfeHVuVAHtQdmPIISdEKca89uqNINuNq9XKi5pLv9O58N6cNeYMECQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpwVfKewLoh13lyk344jpBT0e3G7adooXFPMY4L5d8whN5Fz7B
	FHq/99wrnfQdB+xzQEKJbJVoTczmxhxfOBZKdRoxUw2DFDzzDuU99A2g
X-Gm-Gg: AeBDiettk4WgrHXt3w0A3TfxexkZPiPniAugSxOiRVx2ZnSnSx+7z+sHBc/paXTk5zJ
	9IPzUuaGa/tCfwA6r487d2HISwtwtkx/uYeR3F/y14kKcV8mFCC9qDghrw7/SBeqvIbX2jIJW4a
	UR8YBI7sNSrjH4N1rTeXTWJuGc48+e4KyVHEr27jRocGBC71f/FvtYtxxTh+q8NsTFr4cUjgYzt
	Cq5387Y+klLZPoX+CGc6RuaIh1mV3R9KSwiVwC+Hf40iMsnw+n5KbaEj7hekokWbY3Lj3du1pE4
	bA9AQwqEaXdSQ4pM28u+0ux975gctNQHpuaUUvO5ywM6jGkJW9YWvbV46J/3zt2g6l2uvUGnwHq
	aFkqaCAOlOskupUVau7KpJ/yuVnXRyGgxDKUkrF/RZc89WZS7GLFsomMh8p0SiGG7bVGgfVJFQJ
	9euG6nsqlB1hPo9XodW26VJSQwv4nAIBY=
X-Received: by 2002:a2e:a994:0:b0:38c:c253:2999 with SMTP id 38308e7fff4ca-3924100a4d7mr21713741fa.31.1777446858332;
        Wed, 29 Apr 2026 00:14:18 -0700 (PDT)
Received: from thinkpad ([188.225.109.225])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3924fa7c93bsm2861151fa.23.2026.04.29.00.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 00:14:18 -0700 (PDT)
From: Matthew Bystrin <dev.mbstr@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Min Li <min.li.xe@renesas.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 1/2] mfd: rsmu: fix page register setup
Date: Wed, 29 Apr 2026 10:20:46 +0300
Message-ID: <20260429072047.1111427-2-dev.mbstr@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429072047.1111427-1-dev.mbstr@gmail.com>
References: <20260429072047.1111427-1-dev.mbstr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1631F490575
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,renesas.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282265-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devmbstr@gmail.com,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Fix writes to page register in 8A3400x family (Clock Matrix).

All calls to rsmu_write_page_register() (both in i2c and spi) have
resulted in early return, becase all addresses in
include/linux/mfd/idt8a340_reg.h are less than RSMU_CM_SCSR_BASE.

There were 2 separate patch series which have to be merged in one time:
mfd and ptp. The latter have been merged, the former[1] have not.

Link: https://lore.kernel.org/netdev/LV3P220MB1202F8E2FCCFBA2519B4966EA0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM/
Fixes: 67d6c76fc815 ("mfd: rsmu: Support 32-bit address space")
Signed-off-by: Matthew Bystrin <dev.mbstr@gmail.com>
---
 drivers/mfd/rsmu_i2c.c | 6 +-----
 drivers/mfd/rsmu_spi.c | 5 +----
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/rsmu_i2c.c b/drivers/mfd/rsmu_i2c.c
index cba64f107a2f..9e5fc8259eec 100644
--- a/drivers/mfd/rsmu_i2c.c
+++ b/drivers/mfd/rsmu_i2c.c
@@ -134,14 +134,10 @@ static int rsmu_i2c_write_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u8 by
 static int rsmu_write_page_register(struct rsmu_ddata *rsmu, u32 reg,
 				    rsmu_rw_device rsmu_write_device)
 {
-	u32 page = reg & RSMU_CM_PAGE_MASK;
+	u32 page = (reg | RSMU_CM_SCSR_BASE) & RSMU_CM_PAGE_MASK;
 	u8 buf[4];
 	int err;
 
-	/* Do not modify offset register for none-scsr registers */
-	if (reg < RSMU_CM_SCSR_BASE)
-		return 0;
-
 	/* Simply return if we are on the same page */
 	if (rsmu->page == page)
 		return 0;
diff --git a/drivers/mfd/rsmu_spi.c b/drivers/mfd/rsmu_spi.c
index 39d9be1e141f..c931d8cea0a1 100644
--- a/drivers/mfd/rsmu_spi.c
+++ b/drivers/mfd/rsmu_spi.c
@@ -101,11 +101,8 @@ static int rsmu_write_page_register(struct rsmu_ddata *rsmu, u32 reg)
 
 	switch (rsmu->type) {
 	case RSMU_CM:
-		/* Do not modify page register for none-scsr registers */
-		if (reg < RSMU_CM_SCSR_BASE)
-			return 0;
 		page_reg = RSMU_CM_PAGE_ADDR;
-		page = reg & RSMU_PAGE_MASK;
+		page = (reg | RSMU_CM_SCSR_BASE) & RSMU_PAGE_MASK;
 		buf[0] = (u8)(page & 0xFF);
 		buf[1] = (u8)((page >> 8) & 0xFF);
 		buf[2] = (u8)((page >> 16) & 0xFF);
-- 
2.53.0


