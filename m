Return-Path: <netdev+bounces-305749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AIztGfYmTmrDEAIAu9opvQ
	(envelope-from <netdev+bounces-305749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:31:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CAB72459A
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:31:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="AIaY/XyW";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305749-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305749-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1D5A3063AA7
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 10:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A910399350;
	Wed,  8 Jul 2026 10:23:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C9E3ADB92
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 10:23:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506237; cv=none; b=aoQn9ZPhpkBqkgfMJPRbtUiIV50vsjOeb4eTzmDbjtqwsEY9nvvb/9NNqenyCWSWT+Q8O34P6yuX6/hcGeFyL+n/KANpQ4+n3nT23iKgzn+hIBjvnGFgsAseLs8154J2t1fGkWr52a6aAxlA+G8JFDuUh+dbcFf+4rFDhV2bAXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506237; c=relaxed/simple;
	bh=7wUx43Y9Oa6/DeFLQeJ73QbpK2P5lOEtjBbrhpx7ObY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4AKm33oT7gnSiiwV0f5NEa/bxgWwZcD6TT/SMI9M8dxkT1Y8XEMYx2+8u5AbyV/Fis6yUYlMm0IAvMKyewAkc1uKtu5cldxOCQxOKCOQkIxyWqmGQDe8PGw1AQkmj9xGy+ErtkJsqpitXAI3/EhSr2PwgM/ivVXfQXxkM30fhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIaY/XyW; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493b7612475so3878715e9.3
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 03:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783506233; x=1784111033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2dERfihgZZP+MocUx+v5NwwvdSmaQ1OgSs+UDsOWnc4=;
        b=AIaY/XyWy+s4MTJFOci4b0rLMHjFkA82b2BtnYcVetSfyN4GX7y2ephhA+8fbv+H02
         seHkuk1ZfxiU21kIsex83bnzLGE/K1Pin4nDTLn0z+VyNs+m5MQpxpsGftsqInGF1ht2
         8NOfw1NLjdmw+nUZb4juD+CKR+wRSNRju31N+7sBV2x1N369eZJy1oqfH/p3b1EfBZ0n
         D87xqdZ7VU+KWPmhoMLxC+990yqncuHkcRYtDWcR2NT47ZDeaXj2JV8Wp8Y+u4g9w+Jf
         uyW01s7fh5DE4BIjTEbF0368ZGvyuaFv0PIxfYPBGrUXMBCoQ3wkte9Qf4XM0Xc/sZE8
         KN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783506233; x=1784111033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2dERfihgZZP+MocUx+v5NwwvdSmaQ1OgSs+UDsOWnc4=;
        b=EFGv48fCtDqhh+Sm8tyPP+WIw//mjWw5kqRHLOBvw9ZbAMQlYLt5AtN3uqOnpJ+c5w
         aPLHJ49wjDnAhPpnJHr+6qI8efK5UO5yB9xesjDFuGy7TiRtDQLJbLrMaLe/l5VpJUqr
         Fze7mQmwoo2aYUiFhzk0OnaCT2y0Ns7J06h5iZ5HZvJ3/tFpmaiAFi0pipFJtmos4Gb3
         nPAzAMDcJcBT4Vu8vIQePkvBAflznBMyNhcKiV0XTfculXq7B5PValUGJzvY9UWdftm5
         YKWQpImkxdpFtRz+8Oxal0FKkmISpw/8LDkHQ5SbPibsgZcKYGUelujvTaGyDl4VKzUi
         3uCw==
X-Forwarded-Encrypted: i=1; AHgh+RrqlwJ+IGw4VDTNmdRjCxkiz5d4Y/9QjvT/+7MDihTu/OMN1w1wgnofrYQCPyaIyzCPxJiqOMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2iL7+UjtcMsSvbtEibwpnvmbcqBHcdxYO+AVuklvD4a6Sj6bQ
	UUuDoJscn2v8mzLYfj0UIuYhS4v8MJLd4SKTgpMw5rxcpsCEmIl3kxwH
X-Gm-Gg: AfdE7cnDpHYiR0N75YgeVKH7NpHdGhfTx9AVyWc6GSBYMkgltBG4VKjyhQtZfsA9+D4
	A2XKW/65zX+xhuNryHzQLpMZofK4sN8PBKH2wvODj61VGOcAddMrAQt1WOXtXMA3MSWXxGn2IZj
	dD8dN3bdRL4aEv8CAaCr2+obs2FpaY+dnCNyNq/6akCJsulmU32REHB1BXHYbzdL3YcTWi+35+l
	CVQcqonztitVV4BupRxFA9OeOORJPfo1XvDXHo7Qur8+O/kMe7Bpsf2ZdPL2lJBHjLQ3SwuI+wv
	uccdUdlW+1G9xNFHT0P9dvtR+3csEZGbKu2gakwYdh/mNMqw74NYZfdf6rdmZegrmyl6oQPG4n7
	u1GD0afPRymzhSgMW7ZzG+UUh7mCOjeSBEwvBd6gwkAMK5KLVBgk1Is7uw/GrxJwWisgePRD1kd
	5dJMBeIMiDALUTfvPOmGocL53SaRC9i8F90xBX83lPchGSmjcNB0E8rA7ukBwDHwOQbNu1NapcD
	TY9fsvR
X-Received: by 2002:a05:600c:6291:b0:493:e4cd:def1 with SMTP id 5b1f17b1804b1-493e84edbbdmr7236775e9.11.1783506232601;
        Wed, 08 Jul 2026 03:23:52 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47aa0f2186bsm40660248f8f.36.2026.07.08.03.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:23:51 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next 2/5] net: phy: mediatek: move MTK GE SoC registers define to dedicated header
Date: Wed,  8 Jul 2026 12:23:28 +0200
Message-ID: <20260708102341.53919-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708102341.53919-1-ansuelsmth@gmail.com>
References: <20260708102341.53919-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305749-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ansuelsmth@gmail.com,m:daniel@makrotopia.org,m:dqfext@gmail.com,m:SkyLake.Huang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,makrotopia.org,mediatek.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2CAB72459A

In preparation for support of special Software Calibration for Airoha
PHY, move the MTK GE SoC registers define to a dedicated header.

It's also needed to generalize the cal_cycle function as Airoha needs
only part of its logic (the wait logic) to complete a calibration cycle.

This is to keep cleaner code and permit sharing these define in multiple
source code.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS                           |   1 +
 drivers/net/phy/mediatek/mtk-ge-soc.c | 371 ++------------------------
 drivers/net/phy/mediatek/mtk-ge-soc.h | 351 ++++++++++++++++++++++++
 3 files changed, 373 insertions(+), 350 deletions(-)
 create mode 100644 drivers/net/phy/mediatek/mtk-ge-soc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c3f72058a2f2..16e47aea84c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16512,6 +16512,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/phy/mediatek/mtk-2p5ge.c
 F:	drivers/net/phy/mediatek/mtk-ge-soc.c
+F:	drivers/net/phy/mediatek/mtk-ge-soc.h
 F:	drivers/net/phy/mediatek/mtk-phy-lib.c
 F:	drivers/net/phy/mediatek/mtk-ge.c
 F:	drivers/net/phy/mediatek/mtk.h
diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index 9a54949644d5..46bae11ad740 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -11,322 +11,10 @@
 
 #include "../phylib.h"
 #include "mtk.h"
+#include "mtk-ge-soc.h"
 
 #define MTK_PHY_MAX_LEDS			2
 
-#define MTK_GPHY_ID_MT7981			0x03a29461
-#define MTK_GPHY_ID_MT7988			0x03a29481
-#define MTK_GPHY_ID_AN7581			0x03a294c1
-#define MTK_GPHY_ID_AN7583			0xc0ff0420
-
-#define MTK_EXT_PAGE_ACCESS			0x1f
-#define MTK_PHY_PAGE_STANDARD			0x0000
-#define MTK_PHY_PAGE_EXTENDED_3			0x0003
-
-#define MTK_PHY_LPI_REG_14			0x14
-#define MTK_PHY_LPI_WAKE_TIMER_1000_MASK	GENMASK(8, 0)
-
-#define MTK_PHY_LPI_REG_1c			0x1c
-#define MTK_PHY_SMI_DET_ON_THRESH_MASK		GENMASK(13, 8)
-
-#define MTK_PHY_PAGE_EXTENDED_2A30		0x2a30
-
-/* Registers on Token Ring debug nodes */
-/* ch_addr = 0x0, node_addr = 0x7, data_addr = 0x15 */
-/* NormMseLoThresh */
-#define NORMAL_MSE_LO_THRESH_MASK		GENMASK(15, 8)
-
-/* ch_addr = 0x0, node_addr = 0xf, data_addr = 0x3c */
-/* RemAckCntLimitCtrl */
-#define REMOTE_ACK_COUNT_LIMIT_CTRL_MASK	GENMASK(2, 1)
-
-/* ch_addr = 0x1, node_addr = 0xd, data_addr = 0x20 */
-/* VcoSlicerThreshBitsHigh */
-#define VCO_SLICER_THRESH_HIGH_MASK		GENMASK(23, 0)
-
-/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x0 */
-/* DfeTailEnableVgaThresh1000 */
-#define DFE_TAIL_EANBLE_VGA_TRHESH_1000		GENMASK(5, 1)
-
-/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x1 */
-/* MrvlTrFix100Kp */
-#define MRVL_TR_FIX_100KP_MASK			GENMASK(22, 20)
-/* MrvlTrFix100Kf */
-#define MRVL_TR_FIX_100KF_MASK			GENMASK(19, 17)
-/* MrvlTrFix1000Kp */
-#define MRVL_TR_FIX_1000KP_MASK			GENMASK(16, 14)
-/* MrvlTrFix1000Kf */
-#define MRVL_TR_FIX_1000KF_MASK			GENMASK(13, 11)
-
-/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x12 */
-/* VgaDecRate */
-#define VGA_DECIMATION_RATE_MASK		GENMASK(8, 5)
-
-/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x17 */
-/* SlvDSPreadyTime */
-#define SLAVE_DSP_READY_TIME_MASK		GENMASK(22, 15)
-/* MasDSPreadyTime */
-#define MASTER_DSP_READY_TIME_MASK		GENMASK(14, 7)
-
-/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x18 */
-/* EnabRandUpdTrig */
-#define ENABLE_RANDOM_UPDOWN_COUNTER_TRIGGER	BIT(8)
-
-/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x20 */
-/* ResetSyncOffset */
-#define RESET_SYNC_OFFSET_MASK			GENMASK(11, 8)
-
-/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x0 */
-/* FfeUpdGainForceVal */
-#define FFE_UPDATE_GAIN_FORCE_VAL_MASK		GENMASK(9, 7)
-/* FfeUpdGainForce */
-#define FFE_UPDATE_GAIN_FORCE			BIT(6)
-
-/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x3 */
-/* TrFreeze */
-#define TR_FREEZE_MASK				GENMASK(11, 0)
-
-/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x6 */
-/* SS: Steady-state, KP: Proportional Gain */
-/* SSTrKp100 */
-#define SS_TR_KP100_MASK			GENMASK(21, 19)
-/* SSTrKf100 */
-#define SS_TR_KF100_MASK			GENMASK(18, 16)
-/* SSTrKp1000Mas */
-#define SS_TR_KP1000_MASTER_MASK		GENMASK(15, 13)
-/* SSTrKf1000Mas */
-#define SS_TR_KF1000_MASTER_MASK		GENMASK(12, 10)
-/* SSTrKp1000Slv */
-#define SS_TR_KP1000_SLAVE_MASK			GENMASK(9, 7)
-/* SSTrKf1000Slv */
-#define SS_TR_KF1000_SLAVE_MASK			GENMASK(6, 4)
-
-/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x8 */
-/* clear this bit if wanna select from AFE */
-/* Regsigdet_sel_1000 */
-#define EEE1000_SELECT_SIGNAL_DETECTION_FROM_DFE	BIT(4)
-
-/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0xd */
-/* RegEEE_st2TrKf1000 */
-#define EEE1000_STAGE2_TR_KF_MASK		GENMASK(13, 11)
-
-/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0xf */
-/* RegEEE_slv_waketr_timer_tar */
-#define SLAVE_WAKETR_TIMER_MASK			GENMASK(20, 11)
-/* RegEEE_slv_remtx_timer_tar */
-#define SLAVE_REMTX_TIMER_MASK			GENMASK(10, 1)
-
-/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x10 */
-/* RegEEE_slv_wake_int_timer_tar */
-#define SLAVE_WAKEINT_TIMER_MASK		GENMASK(10, 1)
-
-/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x14 */
-/* RegEEE_trfreeze_timer2 */
-#define TR_FREEZE_TIMER2_MASK			GENMASK(9, 0)
-
-/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x1c */
-/* RegEEE100Stg1_tar */
-#define EEE100_LPSYNC_STAGE1_UPDATE_TIMER_MASK	GENMASK(8, 0)
-
-/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x25 */
-/* REGEEE_wake_slv_tr_wait_dfesigdet_en */
-#define WAKE_SLAVE_TR_WAIT_DFE_DETECTION_EN	BIT(11)
-
-#define ANALOG_INTERNAL_OPERATION_MAX_US	20
-#define TXRESERVE_MIN				0
-#define TXRESERVE_MAX				7
-
-#define MTK_PHY_ANARG_RG			0x10
-#define   MTK_PHY_TCLKOFFSET_MASK		GENMASK(12, 8)
-
-/* Registers on MDIO_MMD_VEND1 */
-#define MTK_PHY_TXVLD_DA_RG			0x12
-#define   MTK_PHY_DA_TX_I2MPB_A_GBE_MASK	GENMASK(15, 10)
-#define   MTK_PHY_DA_TX_I2MPB_A_TBT_MASK	GENMASK(5, 0)
-
-#define MTK_PHY_TX_I2MPB_TEST_MODE_A2		0x16
-#define   MTK_PHY_DA_TX_I2MPB_A_HBT_MASK	GENMASK(15, 10)
-#define   MTK_PHY_DA_TX_I2MPB_A_TST_MASK	GENMASK(5, 0)
-
-#define MTK_PHY_TX_I2MPB_TEST_MODE_B1		0x17
-#define   MTK_PHY_DA_TX_I2MPB_B_GBE_MASK	GENMASK(13, 8)
-#define   MTK_PHY_DA_TX_I2MPB_B_TBT_MASK	GENMASK(5, 0)
-
-#define MTK_PHY_TX_I2MPB_TEST_MODE_B2		0x18
-#define   MTK_PHY_DA_TX_I2MPB_B_HBT_MASK	GENMASK(13, 8)
-#define   MTK_PHY_DA_TX_I2MPB_B_TST_MASK	GENMASK(5, 0)
-
-#define MTK_PHY_TX_I2MPB_TEST_MODE_C1		0x19
-#define   MTK_PHY_DA_TX_I2MPB_C_GBE_MASK	GENMASK(13, 8)
-#define   MTK_PHY_DA_TX_I2MPB_C_TBT_MASK	GENMASK(5, 0)
-
-#define MTK_PHY_TX_I2MPB_TEST_MODE_C2		0x20
-#define   MTK_PHY_DA_TX_I2MPB_C_HBT_MASK	GENMASK(13, 8)
-#define   MTK_PHY_DA_TX_I2MPB_C_TST_MASK	GENMASK(5, 0)
-
-#define MTK_PHY_TX_I2MPB_TEST_MODE_D1		0x21
-#define   MTK_PHY_DA_TX_I2MPB_D_GBE_MASK	GENMASK(13, 8)
-#define   MTK_PHY_DA_TX_I2MPB_D_TBT_MASK	GENMASK(5, 0)
-
-#define MTK_PHY_TX_I2MPB_TEST_MODE_D2		0x22
-#define   MTK_PHY_DA_TX_I2MPB_D_HBT_MASK	GENMASK(13, 8)
-#define   MTK_PHY_DA_TX_I2MPB_D_TST_MASK	GENMASK(5, 0)
-
-#define MTK_PHY_RXADC_CTRL_RG7			0xc6
-#define   MTK_PHY_DA_AD_BUF_BIAS_LP_MASK	GENMASK(9, 8)
-
-#define MTK_PHY_RXADC_CTRL_RG9			0xc8
-#define   MTK_PHY_DA_RX_PSBN_TBT_MASK		GENMASK(14, 12)
-#define   MTK_PHY_DA_RX_PSBN_HBT_MASK		GENMASK(10, 8)
-#define   MTK_PHY_DA_RX_PSBN_GBE_MASK		GENMASK(6, 4)
-#define   MTK_PHY_DA_RX_PSBN_LP_MASK		GENMASK(2, 0)
-
-#define MTK_PHY_LDO_OUTPUT_V			0xd7
-
-#define MTK_PHY_RG_ANA_CAL_RG0			0xdb
-#define   MTK_PHY_RG_CAL_CKINV			BIT(12)
-#define   MTK_PHY_RG_ANA_CALEN			BIT(8)
-#define   MTK_PHY_RG_ZCALEN_A			BIT(0)
-
-#define MTK_PHY_RG_ANA_CAL_RG1			0xdc
-#define   MTK_PHY_RG_ZCALEN_B			BIT(12)
-#define   MTK_PHY_RG_ZCALEN_C			BIT(8)
-#define   MTK_PHY_RG_ZCALEN_D			BIT(4)
-#define   MTK_PHY_RG_TXVOS_CALEN		BIT(0)
-
-#define MTK_PHY_RG_ANA_CAL_RG5			0xe0
-#define   MTK_PHY_RG_REXT_TRIM_MASK		GENMASK(13, 8)
-
-#define MTK_PHY_RG_TX_FILTER			0xfe
-
-#define MTK_PHY_RG_LPI_PCS_DSP_CTRL_REG120	0x120
-#define   MTK_PHY_LPI_SIG_EN_LO_THRESH1000_MASK	GENMASK(12, 8)
-#define   MTK_PHY_LPI_SIG_EN_HI_THRESH1000_MASK	GENMASK(4, 0)
-
-#define MTK_PHY_RG_LPI_PCS_DSP_CTRL_REG122	0x122
-#define   MTK_PHY_LPI_NORM_MSE_HI_THRESH1000_MASK	GENMASK(7, 0)
-
-#define MTK_PHY_RG_TESTMUX_ADC_CTRL		0x144
-#define   MTK_PHY_RG_TXEN_DIG_MASK		GENMASK(5, 5)
-
-#define MTK_PHY_RG_CR_TX_AMP_OFFSET_A_B		0x172
-#define   MTK_PHY_CR_TX_AMP_OFFSET_A_MASK	GENMASK(13, 8)
-#define   MTK_PHY_CR_TX_AMP_OFFSET_B_MASK	GENMASK(6, 0)
-
-#define MTK_PHY_RG_CR_TX_AMP_OFFSET_C_D		0x173
-#define   MTK_PHY_CR_TX_AMP_OFFSET_C_MASK	GENMASK(13, 8)
-#define   MTK_PHY_CR_TX_AMP_OFFSET_D_MASK	GENMASK(6, 0)
-
-#define MTK_PHY_RG_AD_CAL_COMP			0x17a
-#define   MTK_PHY_AD_CAL_COMP_OUT_MASK		GENMASK(8, 8)
-
-#define MTK_PHY_RG_AD_CAL_CLK			0x17b
-#define   MTK_PHY_DA_CAL_CLK			BIT(0)
-
-#define MTK_PHY_RG_AD_CALIN			0x17c
-#define   MTK_PHY_DA_CALIN_FLAG			BIT(0)
-
-#define MTK_PHY_RG_DASN_DAC_IN0_A		0x17d
-#define   MTK_PHY_DASN_DAC_IN0_A_MASK		GENMASK(9, 0)
-
-#define MTK_PHY_RG_DASN_DAC_IN0_B		0x17e
-#define   MTK_PHY_DASN_DAC_IN0_B_MASK		GENMASK(9, 0)
-
-#define MTK_PHY_RG_DASN_DAC_IN0_C		0x17f
-#define   MTK_PHY_DASN_DAC_IN0_C_MASK		GENMASK(9, 0)
-
-#define MTK_PHY_RG_DASN_DAC_IN0_D		0x180
-#define   MTK_PHY_DASN_DAC_IN0_D_MASK		GENMASK(9, 0)
-
-#define MTK_PHY_RG_DASN_DAC_IN1_A		0x181
-#define   MTK_PHY_DASN_DAC_IN1_A_MASK		GENMASK(9, 0)
-
-#define MTK_PHY_RG_DASN_DAC_IN1_B		0x182
-#define   MTK_PHY_DASN_DAC_IN1_B_MASK		GENMASK(9, 0)
-
-#define MTK_PHY_RG_DASN_DAC_IN1_C		0x183
-#define   MTK_PHY_DASN_DAC_IN1_C_MASK		GENMASK(9, 0)
-
-#define MTK_PHY_RG_DASN_DAC_IN1_D		0x184
-#define   MTK_PHY_DASN_DAC_IN1_D_MASK		GENMASK(9, 0)
-
-#define MTK_PHY_RG_DEV1E_REG19b			0x19b
-#define   MTK_PHY_BYPASS_DSP_LPI_READY		BIT(8)
-
-#define MTK_PHY_RG_LP_IIR2_K1_L			0x22a
-#define MTK_PHY_RG_LP_IIR2_K1_U			0x22b
-#define MTK_PHY_RG_LP_IIR2_K2_L			0x22c
-#define MTK_PHY_RG_LP_IIR2_K2_U			0x22d
-#define MTK_PHY_RG_LP_IIR2_K3_L			0x22e
-#define MTK_PHY_RG_LP_IIR2_K3_U			0x22f
-#define MTK_PHY_RG_LP_IIR2_K4_L			0x230
-#define MTK_PHY_RG_LP_IIR2_K4_U			0x231
-#define MTK_PHY_RG_LP_IIR2_K5_L			0x232
-#define MTK_PHY_RG_LP_IIR2_K5_U			0x233
-
-#define MTK_PHY_RG_DEV1E_REG234			0x234
-#define   MTK_PHY_TR_OPEN_LOOP_EN_MASK		GENMASK(0, 0)
-#define   MTK_PHY_LPF_X_AVERAGE_MASK		GENMASK(7, 4)
-#define   MTK_PHY_TR_LP_IIR_EEE_EN		BIT(12)
-
-#define MTK_PHY_RG_LPF_CNT_VAL			0x235
-
-#define MTK_PHY_RG_DEV1E_REG238			0x238
-#define   MTK_PHY_LPI_SLV_SEND_TX_TIMER_MASK	GENMASK(8, 0)
-#define   MTK_PHY_LPI_SLV_SEND_TX_EN		BIT(12)
-
-#define MTK_PHY_RG_DEV1E_REG239			0x239
-#define   MTK_PHY_LPI_SEND_LOC_TIMER_MASK	GENMASK(8, 0)
-#define   MTK_PHY_LPI_TXPCS_LOC_RCV		BIT(12)
-
-#define MTK_PHY_RG_DEV1E_REG27C			0x27c
-#define   MTK_PHY_VGASTATE_FFE_THR_ST1_MASK	GENMASK(12, 8)
-#define MTK_PHY_RG_DEV1E_REG27D			0x27d
-#define   MTK_PHY_VGASTATE_FFE_THR_ST2_MASK	GENMASK(4, 0)
-
-#define MTK_PHY_RG_DEV1E_REG2C7			0x2c7
-#define   MTK_PHY_MAX_GAIN_MASK			GENMASK(4, 0)
-#define   MTK_PHY_MIN_GAIN_MASK			GENMASK(12, 8)
-
-#define MTK_PHY_RG_DEV1E_REG2D1			0x2d1
-#define   MTK_PHY_VCO_SLICER_THRESH_BITS_HIGH_EEE_MASK	GENMASK(7, 0)
-#define   MTK_PHY_LPI_SKIP_SD_SLV_TR		BIT(8)
-#define   MTK_PHY_LPI_TR_READY			BIT(9)
-#define   MTK_PHY_LPI_VCO_EEE_STG0_EN		BIT(10)
-
-#define MTK_PHY_RG_DEV1E_REG323			0x323
-#define   MTK_PHY_EEE_WAKE_MAS_INT_DC		BIT(0)
-#define   MTK_PHY_EEE_WAKE_SLV_INT_DC		BIT(4)
-
-#define MTK_PHY_RG_DEV1E_REG324			0x324
-#define   MTK_PHY_SMI_DETCNT_MAX_MASK		GENMASK(5, 0)
-#define   MTK_PHY_SMI_DET_MAX_EN		BIT(8)
-
-#define MTK_PHY_RG_DEV1E_REG326			0x326
-#define   MTK_PHY_LPI_MODE_SD_ON		BIT(0)
-#define   MTK_PHY_RESET_RANDUPD_CNT		BIT(1)
-#define   MTK_PHY_TREC_UPDATE_ENAB_CLR		BIT(2)
-#define   MTK_PHY_LPI_QUIT_WAIT_DFE_SIG_DET_OFF	BIT(4)
-#define   MTK_PHY_TR_READY_SKIP_AFE_WAKEUP	BIT(5)
-
-#define MTK_PHY_LDO_PUMP_EN_PAIRAB		0x502
-#define MTK_PHY_LDO_PUMP_EN_PAIRCD		0x503
-
-#define MTK_PHY_DA_TX_R50_PAIR_A		0x53d
-#define MTK_PHY_DA_TX_R50_PAIR_B		0x53e
-#define MTK_PHY_DA_TX_R50_PAIR_C		0x53f
-#define MTK_PHY_DA_TX_R50_PAIR_D		0x540
-
-/* Registers on MDIO_MMD_VEND2 */
-#define MTK_PHY_LED1_DEFAULT_POLARITIES		BIT(1)
-
-#define MTK_PHY_RG_BG_RASEL			0x115
-#define   MTK_PHY_RG_BG_RASEL_MASK		GENMASK(2, 0)
-
-/* 'boottrap' register reflecting the configuration of the 4 PHY LEDs */
-#define RG_GPIO_MISC_TPBANK0			0x6f0
-#define   RG_GPIO_MISC_TPBANK0_BOOTMODE		GENMASK(11, 8)
-
 /* These macro privides efuse parsing for internal phy. */
 #define EFS_DA_TX_I2MPB_A(x)			(((x) >> 0) & GENMASK(5, 0))
 #define EFS_DA_TX_I2MPB_B(x)			(((x) >> 6) & GENMASK(5, 0))
@@ -346,51 +34,16 @@
 #define EFS_RG_BG_RASEL(x)			(((x) >> 4) & GENMASK(2, 0))
 #define EFS_RG_REXT_TRIM(x)			(((x) >> 7) & GENMASK(5, 0))
 
-enum {
-	NO_PAIR,
-	PAIR_A,
-	PAIR_B,
-	PAIR_C,
-	PAIR_D,
-};
-
-enum calibration_mode {
-	EFUSE_K,
-	SW_K
-};
-
-enum CAL_ITEM {
-	REXT,
-	TX_OFFSET,
-	TX_AMP,
-	TX_R50,
-	TX_VCM
-};
-
-enum CAL_MODE {
-	EFUSE_M,
-	SW_M
-};
-
 struct mtk_socphy_shared {
 	u32			boottrap;
 	struct mtk_socphy_priv	priv[4];
 };
 
-/* One calibration cycle consists of:
- * 1.Set DA_CALIN_FLAG high to start calibration. Keep it high
- *   until AD_CAL_COMP is ready to output calibration result.
- * 2.Wait until DA_CAL_CLK is available.
- * 3.Fetch AD_CAL_COMP_OUT.
- */
-static int cal_cycle(struct phy_device *phydev, int devad,
-		     u32 regnum, u16 mask, u16 cal_val)
+int mtk_cal_cycle_wait(struct phy_device *phydev)
 {
 	int reg_val;
 	int ret;
 
-	phy_modify_mmd(phydev, devad, regnum,
-		       mask, cal_val);
 	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_AD_CALIN,
 			 MTK_PHY_DA_CALIN_FLAG);
 
@@ -409,7 +62,25 @@ static int cal_cycle(struct phy_device *phydev, int devad,
 	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_AD_CAL_COMP);
 	if (ret < 0)
 		return ret;
-	ret = FIELD_GET(MTK_PHY_AD_CAL_COMP_OUT_MASK, ret);
+
+	return FIELD_GET(MTK_PHY_AD_CAL_COMP_OUT_MASK, ret);
+}
+
+/* One calibration cycle consists of:
+ * 1.Set DA_CALIN_FLAG high to start calibration. Keep it high
+ *   until AD_CAL_COMP is ready to output calibration result.
+ * 2.Wait until DA_CAL_CLK is available.
+ * 3.Fetch AD_CAL_COMP_OUT.
+ */
+static int cal_cycle(struct phy_device *phydev, int devad,
+		     u32 regnum, u16 mask, u16 cal_val)
+{
+	int ret;
+
+	phy_modify_mmd(phydev, devad, regnum,
+		       mask, cal_val);
+
+	ret = mtk_cal_cycle_wait(phydev);
 	phydev_dbg(phydev, "cal_val: 0x%x, ret: %d\n", cal_val, ret);
 
 	return ret;
diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.h b/drivers/net/phy/mediatek/mtk-ge-soc.h
new file mode 100644
index 000000000000..9aaa7e3caa41
--- /dev/null
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.h
@@ -0,0 +1,351 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _MTK_GE_SOC_H_
+#define _MTK_GE_SOC_H_
+
+#include <linux/bitfield.h>
+
+#define MTK_GPHY_ID_MT7981			0x03a29461
+#define MTK_GPHY_ID_MT7988			0x03a29481
+#define MTK_GPHY_ID_AN7581			0x03a294c1
+#define MTK_GPHY_ID_AN7583			0xc0ff0420
+
+#define MTK_EXT_PAGE_ACCESS			0x1f
+#define MTK_PHY_PAGE_STANDARD			0x0000
+#define MTK_PHY_PAGE_EXTENDED_3			0x0003
+
+#define MTK_PHY_LPI_REG_14			0x14
+#define MTK_PHY_LPI_WAKE_TIMER_1000_MASK	GENMASK(8, 0)
+
+#define MTK_PHY_LPI_REG_1c			0x1c
+#define MTK_PHY_SMI_DET_ON_THRESH_MASK		GENMASK(13, 8)
+
+#define MTK_PHY_PAGE_EXTENDED_2A30		0x2a30
+
+/* Registers on Token Ring debug nodes */
+/* ch_addr = 0x0, node_addr = 0x7, data_addr = 0x15 */
+/* NormMseLoThresh */
+#define NORMAL_MSE_LO_THRESH_MASK		GENMASK(15, 8)
+
+/* ch_addr = 0x0, node_addr = 0xf, data_addr = 0x3c */
+/* RemAckCntLimitCtrl */
+#define REMOTE_ACK_COUNT_LIMIT_CTRL_MASK	GENMASK(2, 1)
+
+/* ch_addr = 0x1, node_addr = 0xd, data_addr = 0x20 */
+/* VcoSlicerThreshBitsHigh */
+#define VCO_SLICER_THRESH_HIGH_MASK		GENMASK(23, 0)
+
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x0 */
+/* DfeTailEnableVgaThresh1000 */
+#define DFE_TAIL_EANBLE_VGA_TRHESH_1000		GENMASK(5, 1)
+
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x1 */
+/* MrvlTrFix100Kp */
+#define MRVL_TR_FIX_100KP_MASK			GENMASK(22, 20)
+/* MrvlTrFix100Kf */
+#define MRVL_TR_FIX_100KF_MASK			GENMASK(19, 17)
+/* MrvlTrFix1000Kp */
+#define MRVL_TR_FIX_1000KP_MASK			GENMASK(16, 14)
+/* MrvlTrFix1000Kf */
+#define MRVL_TR_FIX_1000KF_MASK			GENMASK(13, 11)
+
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x12 */
+/* VgaDecRate */
+#define VGA_DECIMATION_RATE_MASK		GENMASK(8, 5)
+
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x17 */
+/* SlvDSPreadyTime */
+#define SLAVE_DSP_READY_TIME_MASK		GENMASK(22, 15)
+/* MasDSPreadyTime */
+#define MASTER_DSP_READY_TIME_MASK		GENMASK(14, 7)
+
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x18 */
+/* EnabRandUpdTrig */
+#define ENABLE_RANDOM_UPDOWN_COUNTER_TRIGGER	BIT(8)
+
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x20 */
+/* ResetSyncOffset */
+#define RESET_SYNC_OFFSET_MASK			GENMASK(11, 8)
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x0 */
+/* FfeUpdGainForceVal */
+#define FFE_UPDATE_GAIN_FORCE_VAL_MASK		GENMASK(9, 7)
+/* FfeUpdGainForce */
+#define FFE_UPDATE_GAIN_FORCE			BIT(6)
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x3 */
+/* TrFreeze */
+#define TR_FREEZE_MASK				GENMASK(11, 0)
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x6 */
+/* SS: Steady-state, KP: Proportional Gain */
+/* SSTrKp100 */
+#define SS_TR_KP100_MASK			GENMASK(21, 19)
+/* SSTrKf100 */
+#define SS_TR_KF100_MASK			GENMASK(18, 16)
+/* SSTrKp1000Mas */
+#define SS_TR_KP1000_MASTER_MASK		GENMASK(15, 13)
+/* SSTrKf1000Mas */
+#define SS_TR_KF1000_MASTER_MASK		GENMASK(12, 10)
+/* SSTrKp1000Slv */
+#define SS_TR_KP1000_SLAVE_MASK			GENMASK(9, 7)
+/* SSTrKf1000Slv */
+#define SS_TR_KF1000_SLAVE_MASK			GENMASK(6, 4)
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x8 */
+/* clear this bit if wanna select from AFE */
+/* Regsigdet_sel_1000 */
+#define EEE1000_SELECT_SIGNAL_DETECTION_FROM_DFE	BIT(4)
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0xd */
+/* RegEEE_st2TrKf1000 */
+#define EEE1000_STAGE2_TR_KF_MASK		GENMASK(13, 11)
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0xf */
+/* RegEEE_slv_waketr_timer_tar */
+#define SLAVE_WAKETR_TIMER_MASK			GENMASK(20, 11)
+/* RegEEE_slv_remtx_timer_tar */
+#define SLAVE_REMTX_TIMER_MASK			GENMASK(10, 1)
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x10 */
+/* RegEEE_slv_wake_int_timer_tar */
+#define SLAVE_WAKEINT_TIMER_MASK		GENMASK(10, 1)
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x14 */
+/* RegEEE_trfreeze_timer2 */
+#define TR_FREEZE_TIMER2_MASK			GENMASK(9, 0)
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x1c */
+/* RegEEE100Stg1_tar */
+#define EEE100_LPSYNC_STAGE1_UPDATE_TIMER_MASK	GENMASK(8, 0)
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x25 */
+/* REGEEE_wake_slv_tr_wait_dfesigdet_en */
+#define WAKE_SLAVE_TR_WAIT_DFE_DETECTION_EN	BIT(11)
+
+#define ANALOG_INTERNAL_OPERATION_MAX_US	20
+#define TXRESERVE_MIN				0
+#define TXRESERVE_MAX				7
+
+#define MTK_PHY_ANARG_RG			0x10
+#define   MTK_PHY_TCLKOFFSET_MASK		GENMASK(12, 8)
+
+/* Registers on MDIO_MMD_VEND1 */
+#define MTK_PHY_TXVLD_DA_RG			0x12
+#define   MTK_PHY_DA_TX_I2MPB_A_GBE_MASK	GENMASK(15, 10)
+#define   MTK_PHY_DA_TX_I2MPB_A_TBT_MASK	GENMASK(5, 0)
+
+#define MTK_PHY_TX_I2MPB_TEST_MODE_A2		0x16
+#define   MTK_PHY_DA_TX_I2MPB_A_HBT_MASK	GENMASK(15, 10)
+#define   MTK_PHY_DA_TX_I2MPB_A_TST_MASK	GENMASK(5, 0)
+
+#define MTK_PHY_TX_I2MPB_TEST_MODE_B1		0x17
+#define   MTK_PHY_DA_TX_I2MPB_B_GBE_MASK	GENMASK(13, 8)
+#define   MTK_PHY_DA_TX_I2MPB_B_TBT_MASK	GENMASK(5, 0)
+
+#define MTK_PHY_TX_I2MPB_TEST_MODE_B2		0x18
+#define   MTK_PHY_DA_TX_I2MPB_B_HBT_MASK	GENMASK(13, 8)
+#define   MTK_PHY_DA_TX_I2MPB_B_TST_MASK	GENMASK(5, 0)
+
+#define MTK_PHY_TX_I2MPB_TEST_MODE_C1		0x19
+#define   MTK_PHY_DA_TX_I2MPB_C_GBE_MASK	GENMASK(13, 8)
+#define   MTK_PHY_DA_TX_I2MPB_C_TBT_MASK	GENMASK(5, 0)
+
+#define MTK_PHY_TX_I2MPB_TEST_MODE_C2		0x20
+#define   MTK_PHY_DA_TX_I2MPB_C_HBT_MASK	GENMASK(13, 8)
+#define   MTK_PHY_DA_TX_I2MPB_C_TST_MASK	GENMASK(5, 0)
+
+#define MTK_PHY_TX_I2MPB_TEST_MODE_D1		0x21
+#define   MTK_PHY_DA_TX_I2MPB_D_GBE_MASK	GENMASK(13, 8)
+#define   MTK_PHY_DA_TX_I2MPB_D_TBT_MASK	GENMASK(5, 0)
+
+#define MTK_PHY_TX_I2MPB_TEST_MODE_D2		0x22
+#define   MTK_PHY_DA_TX_I2MPB_D_HBT_MASK	GENMASK(13, 8)
+#define   MTK_PHY_DA_TX_I2MPB_D_TST_MASK	GENMASK(5, 0)
+
+#define MTK_PHY_RXADC_CTRL_RG7			0xc6
+#define   MTK_PHY_DA_AD_BUF_BIAS_LP_MASK	GENMASK(9, 8)
+
+#define MTK_PHY_RXADC_CTRL_RG9			0xc8
+#define   MTK_PHY_DA_RX_PSBN_TBT_MASK		GENMASK(14, 12)
+#define   MTK_PHY_DA_RX_PSBN_HBT_MASK		GENMASK(10, 8)
+#define   MTK_PHY_DA_RX_PSBN_GBE_MASK		GENMASK(6, 4)
+#define   MTK_PHY_DA_RX_PSBN_LP_MASK		GENMASK(2, 0)
+
+#define MTK_PHY_LDO_OUTPUT_V			0xd7
+
+#define MTK_PHY_RG_ANA_CAL_RG0			0xdb
+#define   MTK_PHY_RG_CAL_CKINV			BIT(12)
+#define   MTK_PHY_RG_ANA_CALEN			BIT(8)
+#define   MTK_PHY_RG_ZCALEN_A			BIT(0)
+
+#define MTK_PHY_RG_ANA_CAL_RG1			0xdc
+#define   MTK_PHY_RG_ZCALEN_B			BIT(12)
+#define   MTK_PHY_RG_ZCALEN_C			BIT(8)
+#define   MTK_PHY_RG_ZCALEN_D			BIT(4)
+#define   MTK_PHY_RG_TXVOS_CALEN		BIT(0)
+
+#define MTK_PHY_RG_ANA_CAL_RG5			0xe0
+#define   MTK_PHY_RG_REXT_TRIM_MASK		GENMASK(13, 8)
+
+#define MTK_PHY_RG_TX_FILTER			0xfe
+
+#define MTK_PHY_RG_LPI_PCS_DSP_CTRL_REG120	0x120
+#define   MTK_PHY_LPI_SIG_EN_LO_THRESH1000_MASK	GENMASK(12, 8)
+#define   MTK_PHY_LPI_SIG_EN_HI_THRESH1000_MASK	GENMASK(4, 0)
+
+#define MTK_PHY_RG_LPI_PCS_DSP_CTRL_REG122	0x122
+#define   MTK_PHY_LPI_NORM_MSE_HI_THRESH1000_MASK	GENMASK(7, 0)
+
+#define MTK_PHY_RG_TESTMUX_ADC_CTRL		0x144
+#define   MTK_PHY_RG_TXEN_DIG_MASK		GENMASK(5, 5)
+
+#define MTK_PHY_RG_CR_TX_AMP_OFFSET_A_B		0x172
+#define   MTK_PHY_CR_TX_AMP_OFFSET_A_MASK	GENMASK(13, 8)
+#define   MTK_PHY_CR_TX_AMP_OFFSET_B_MASK	GENMASK(6, 0)
+
+#define MTK_PHY_RG_CR_TX_AMP_OFFSET_C_D		0x173
+#define   MTK_PHY_CR_TX_AMP_OFFSET_C_MASK	GENMASK(13, 8)
+#define   MTK_PHY_CR_TX_AMP_OFFSET_D_MASK	GENMASK(6, 0)
+
+#define MTK_PHY_RG_AD_CAL_COMP			0x17a
+#define   MTK_PHY_AD_CAL_COMP_OUT_MASK		GENMASK(8, 8)
+
+#define MTK_PHY_RG_AD_CAL_CLK			0x17b
+#define   MTK_PHY_DA_CAL_CLK			BIT(0)
+
+#define MTK_PHY_RG_AD_CALIN			0x17c
+#define   MTK_PHY_DA_CALIN_FLAG			BIT(0)
+
+#define MTK_PHY_RG_DASN_DAC_IN0_A		0x17d
+#define   MTK_PHY_DASN_DAC_IN0_A_MASK		GENMASK(9, 0)
+
+#define MTK_PHY_RG_DASN_DAC_IN0_B		0x17e
+#define   MTK_PHY_DASN_DAC_IN0_B_MASK		GENMASK(9, 0)
+
+#define MTK_PHY_RG_DASN_DAC_IN0_C		0x17f
+#define   MTK_PHY_DASN_DAC_IN0_C_MASK		GENMASK(9, 0)
+
+#define MTK_PHY_RG_DASN_DAC_IN0_D		0x180
+#define   MTK_PHY_DASN_DAC_IN0_D_MASK		GENMASK(9, 0)
+
+#define MTK_PHY_RG_DASN_DAC_IN1_A		0x181
+#define   MTK_PHY_DASN_DAC_IN1_A_MASK		GENMASK(9, 0)
+
+#define MTK_PHY_RG_DASN_DAC_IN1_B		0x182
+#define   MTK_PHY_DASN_DAC_IN1_B_MASK		GENMASK(9, 0)
+
+#define MTK_PHY_RG_DASN_DAC_IN1_C		0x183
+#define   MTK_PHY_DASN_DAC_IN1_C_MASK		GENMASK(9, 0)
+
+#define MTK_PHY_RG_DASN_DAC_IN1_D		0x184
+#define   MTK_PHY_DASN_DAC_IN1_D_MASK		GENMASK(9, 0)
+
+#define MTK_PHY_RG_DEV1E_REG19b			0x19b
+#define   MTK_PHY_BYPASS_DSP_LPI_READY		BIT(8)
+
+#define MTK_PHY_RG_LP_IIR2_K1_L			0x22a
+#define MTK_PHY_RG_LP_IIR2_K1_U			0x22b
+#define MTK_PHY_RG_LP_IIR2_K2_L			0x22c
+#define MTK_PHY_RG_LP_IIR2_K2_U			0x22d
+#define MTK_PHY_RG_LP_IIR2_K3_L			0x22e
+#define MTK_PHY_RG_LP_IIR2_K3_U			0x22f
+#define MTK_PHY_RG_LP_IIR2_K4_L			0x230
+#define MTK_PHY_RG_LP_IIR2_K4_U			0x231
+#define MTK_PHY_RG_LP_IIR2_K5_L			0x232
+#define MTK_PHY_RG_LP_IIR2_K5_U			0x233
+
+#define MTK_PHY_RG_DEV1E_REG234			0x234
+#define   MTK_PHY_TR_OPEN_LOOP_EN_MASK		GENMASK(0, 0)
+#define   MTK_PHY_LPF_X_AVERAGE_MASK		GENMASK(7, 4)
+#define   MTK_PHY_TR_LP_IIR_EEE_EN		BIT(12)
+
+#define MTK_PHY_RG_LPF_CNT_VAL			0x235
+
+#define MTK_PHY_RG_DEV1E_REG238			0x238
+#define   MTK_PHY_LPI_SLV_SEND_TX_TIMER_MASK	GENMASK(8, 0)
+#define   MTK_PHY_LPI_SLV_SEND_TX_EN		BIT(12)
+
+#define MTK_PHY_RG_DEV1E_REG239			0x239
+#define   MTK_PHY_LPI_SEND_LOC_TIMER_MASK	GENMASK(8, 0)
+#define   MTK_PHY_LPI_TXPCS_LOC_RCV		BIT(12)
+
+#define MTK_PHY_RG_DEV1E_REG27C			0x27c
+#define   MTK_PHY_VGASTATE_FFE_THR_ST1_MASK	GENMASK(12, 8)
+#define MTK_PHY_RG_DEV1E_REG27D			0x27d
+#define   MTK_PHY_VGASTATE_FFE_THR_ST2_MASK	GENMASK(4, 0)
+
+#define MTK_PHY_RG_DEV1E_REG2C7			0x2c7
+#define   MTK_PHY_MAX_GAIN_MASK			GENMASK(4, 0)
+#define   MTK_PHY_MIN_GAIN_MASK			GENMASK(12, 8)
+
+#define MTK_PHY_RG_DEV1E_REG2D1			0x2d1
+#define   MTK_PHY_VCO_SLICER_THRESH_BITS_HIGH_EEE_MASK	GENMASK(7, 0)
+#define   MTK_PHY_LPI_SKIP_SD_SLV_TR		BIT(8)
+#define   MTK_PHY_LPI_TR_READY			BIT(9)
+#define   MTK_PHY_LPI_VCO_EEE_STG0_EN		BIT(10)
+
+#define MTK_PHY_RG_DEV1E_REG323			0x323
+#define   MTK_PHY_EEE_WAKE_MAS_INT_DC		BIT(0)
+#define   MTK_PHY_EEE_WAKE_SLV_INT_DC		BIT(4)
+
+#define MTK_PHY_RG_DEV1E_REG324			0x324
+#define   MTK_PHY_SMI_DETCNT_MAX_MASK		GENMASK(5, 0)
+#define   MTK_PHY_SMI_DET_MAX_EN		BIT(8)
+
+#define MTK_PHY_RG_DEV1E_REG326			0x326
+#define   MTK_PHY_LPI_MODE_SD_ON		BIT(0)
+#define   MTK_PHY_RESET_RANDUPD_CNT		BIT(1)
+#define   MTK_PHY_TREC_UPDATE_ENAB_CLR		BIT(2)
+#define   MTK_PHY_LPI_QUIT_WAIT_DFE_SIG_DET_OFF	BIT(4)
+#define   MTK_PHY_TR_READY_SKIP_AFE_WAKEUP	BIT(5)
+
+#define MTK_PHY_LDO_PUMP_EN_PAIRAB		0x502
+#define MTK_PHY_LDO_PUMP_EN_PAIRCD		0x503
+
+#define MTK_PHY_DA_TX_R50_PAIR_A		0x53d
+#define MTK_PHY_DA_TX_R50_PAIR_B		0x53e
+#define MTK_PHY_DA_TX_R50_PAIR_C		0x53f
+#define MTK_PHY_DA_TX_R50_PAIR_D		0x540
+
+/* Registers on MDIO_MMD_VEND2 */
+#define MTK_PHY_LED1_DEFAULT_POLARITIES		BIT(1)
+
+#define MTK_PHY_RG_BG_RASEL			0x115
+#define   MTK_PHY_RG_BG_RASEL_MASK		GENMASK(2, 0)
+
+/* 'boottrap' register reflecting the configuration of the 4 PHY LEDs */
+#define RG_GPIO_MISC_TPBANK0			0x6f0
+#define   RG_GPIO_MISC_TPBANK0_BOOTMODE		GENMASK(11, 8)
+
+enum CAL_ITEM {
+	REXT,
+	TX_OFFSET,
+	TX_AMP,
+	TX_R50,
+	TX_VCM,
+	RX_OFFSET,
+};
+
+enum {
+	NO_PAIR,
+	PAIR_A,
+	PAIR_B,
+	PAIR_C,
+	PAIR_D,
+};
+
+enum calibration_mode {
+	EFUSE_K,
+	SW_K
+};
+
+enum CAL_MODE {
+	EFUSE_M,
+	SW_M
+};
+
+/* MTK GE SoC common functions */
+int mtk_cal_cycle_wait(struct phy_device *phydev);
+
+#endif /* _MTK_GE_SOC_H_ */
-- 
2.53.0


