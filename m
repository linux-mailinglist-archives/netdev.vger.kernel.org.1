Return-Path: <netdev+bounces-298167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5j/6H7DNKmrTxAMAu9opvQ
	(envelope-from <netdev+bounces-298167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:01:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF70672E0F
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:01:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rckr3W8F;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298167-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298167-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE986300517D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DB223D7DC;
	Thu, 11 Jun 2026 15:00:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D44DFBE1
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 15:00:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190055; cv=none; b=SGVMFhAxheOFvyXyNvXfFO4FNBn/P3QiO4T2EFVxoG6L6WDfvhqi6HpBvtpja4GYD0yxh47VCbrr8/78AYzjD9O/NM0Eyyk+KaXP5EBONITfpwhgocIDobShuD41aObNsJ28D5/HhyhAd1oj8qjXldsipS61acWsgS/hFePTfe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190055; c=relaxed/simple;
	bh=iblYNVR1r4JW4gEgMF3ug3ZFjyXSN/XURtsYhtIZN9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T97rT7RPPXOfaKbYlkLdfeUT9WzV9R6xpkK7pZLA81Bh9WTa/rR2SCDW7wPe4GvG54ag8BMgBlTTvpxGp43Wfw0wU/2ezV8yRARybNjNK5QnPRsd9uaMBfX1PJx35f2sZyl9FJMtdbcuF6dNmsnvEntdgFT5qec5gfqxfRANOU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rckr3W8F; arc=none smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8422f395a4aso8116b3a.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781190054; x=1781794854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tMCB5aEJqZUM5g7PfGe/93cSlvh7IQWgPKJGGXWKhlM=;
        b=rckr3W8F+ZW2B+bIZwqyDLL27sH0VVzF9dXG85QsiH2mW2Q+U9hvBW2FYjUMXb/uIq
         yChtCUsPsPHJqWj2khggHIvFFmc+ye9BzjYnQndzAZjEnmaTaFT2pdMRfhCZ/YrO4Rdx
         tDYExwb8B7iKAJbfcd3Wfjaphijw8QaXL/Q6DeE/kkggioX3owyYLLsqIAB+PbDzRnVa
         i5GYe7YY2F+anDAOBhebluQL/triAT594drjMScZzVCx3jZjyrYwbmoZ3kLrufVVnCzj
         4y2xSAbuQODqcUckCUfx8YSZxom8qxNTKQBlZOJJNHvQb2n8/PWHDr8MQ88FeWR3O3gD
         AXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781190054; x=1781794854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMCB5aEJqZUM5g7PfGe/93cSlvh7IQWgPKJGGXWKhlM=;
        b=XCpOV9iHObPUhRuazTatRDwYZdwrHMG0AOPiRhDPFrPgqSfIL6KPGnx0eod6EZKpie
         6Mi6HfWqlHs69k8e98qqcF194aa/VM+kA6Vi0Ira7WibEqJEmARdxCEYkPHXtEc/wumc
         l2/xSCfoXDchwT5xHzRg1avW3wvoHLCFKxCgbFtzTN14UwFxbjvqbOuG9sGNHOHjZdNb
         biSfnVQVebmk9WqUXAnTEz3HRi5U+BwnWqi9V6ql4oXfhtOWrGXnMWsSaDTLHWVpS5Ss
         qxcGvHlBwDH9OPLR1sny39Uih7gG5SLrv2MwGLNjuezbV6H7oBo+yxe4fnvOxV/ESVF0
         bC4g==
X-Forwarded-Encrypted: i=1; AFNElJ/7TBy1ReqiwblGUELlkMMIKGcgNISh/B43+2JYjiEdjNoHnptCy8fJ7Cmj1AJ2yBOjpX2NsLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Q7VQuWNziG+cWUJ/yjZQv0v0H6guqV/OYXDp8XVWUZf6buEY
	EAmcZeBhIzrCmG1J8mRvC/7w59WZhETrt7DUgl3ihN/cnhOpBlVcspa+M1HNarJc
X-Gm-Gg: Acq92OEA+9z1HoPxrItPn6aldQVim+rlFaeCIxBbLutbetjzkftPSXHhPjUseMy/5b2
	H0eIN7hPoc3P7SyISY0Uq6deHCHuO/OtOO4Bu7xzDFODxHJgYXzIcCYU06nvJ0klioXogjHdg7L
	LxCv9ubLfGSvq/4wf8WxylwMrKMBiwnlhJ6bvFCkfl7ZB3j5gOMHYxFmZffSu1MZ4+gApQBj00x
	UAT8F6JU1Fv8QHu+/cv37t3IpbA6PI/YS+OELJxfQeTdJkOb50G71jxx2cKuaKo2tAZao2laIDF
	7NMJjzeUNVhsA0MCrLBDQ48PGmg73Zyfvk+wSS3QKZ4/Xvb0lkgGusLWd4dsusb5YU2Ho9m/NC6
	DQRqjsJ9GNM2QFxfXjl9Zzy73i273XgofGg/sffy3F+XYPQqPYym8ncXDjz+boP360RAQMKgI0T
	kPeHEGBPNAsqgPknar1jBRAajm84+XhjciyJIoa6N/7IX1gT+X0VJT1gdpgS3ytjN20snH3fRgM
	x4=
X-Received: by 2002:a05:6a00:3988:b0:842:63f5:d097 with SMTP id d2e1a72fcca58-84335ca5571mr3001210b3a.3.1781190053512;
        Thu, 11 Jun 2026 08:00:53 -0700 (PDT)
Received: from DESKTOP-VNSSJ2S.lan (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bb6ca7sm2481378b3a.14.2026.06.11.08.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 08:00:52 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
To: lorenzo@kernel.org
Cc: nbd@nbd.name,
	netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Zhi-Jun You <hujy652@gmail.com>
Subject: [PATCH] net: ethernet: mtk_wed: fix loading WO firmware for MT7986
Date: Thu, 11 Jun 2026 23:00:51 +0800
Message-ID: <20260611150051.586-1-hujy652@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-298167-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[nbd.name,vger.kernel.org,lists.infradead.org,gmail.com];
	FORGED_SENDER(0.00)[hujy652@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:nbd@nbd.name,m:netdev@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:hujy652@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hujy652@gmail.com,netdev@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDF70672E0F

MT7986 requires a different mask for second WO firmware.
Without this, WO would timeout after loading FW.

The correct mask was removed when adding WED for MT7988.
Add it back and add a WED version check to fix it.

This can be reproduced with a MT7986 + MT7916 board.

Fixes: e2f64db13aa1 ("net: ethernet: mtk_wed: introduce WED support for MT7988")
Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_wed_mcu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
index fa6b21603416..0d38183c6ba7 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
@@ -367,8 +367,12 @@ mtk_wed_mcu_load_firmware(struct mtk_wed_wo *wo)
 	/* wo firmware reset */
 	wo_w32(MTK_WO_MCU_CFG_LS_WF_MCCR_CLR_ADDR, 0xc00);
 
-	val = wo_r32(MTK_WO_MCU_CFG_LS_WF_MCU_CFG_WM_WA_ADDR) |
-	      MTK_WO_MCU_CFG_LS_WF_WM_WA_WM_CPU_RSTB_MASK;
+	val = wo_r32(MTK_WO_MCU_CFG_LS_WF_MCU_CFG_WM_WA_ADDR);
+
+	if (!mtk_wed_is_v3_or_greater(wo->hw) && wo->hw->index)
+		val |= MTK_WO_MCU_CFG_LS_WF_WM_WA_WA_CPU_RSTB_MASK;
+	else
+		val |= MTK_WO_MCU_CFG_LS_WF_WM_WA_WM_CPU_RSTB_MASK;
 	wo_w32(MTK_WO_MCU_CFG_LS_WF_MCU_CFG_WM_WA_ADDR, val);
 out:
 	release_firmware(fw);
-- 
2.47.3


