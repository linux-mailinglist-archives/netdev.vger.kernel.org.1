Return-Path: <netdev+bounces-284704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLQGMXTU+mmzTAMAu9opvQ
	(envelope-from <netdev+bounces-284704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 07:41:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E63E4D64FA
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 07:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DEB6301A70D
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 05:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BB72E9757;
	Wed,  6 May 2026 05:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXX/hnXV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F531A6820
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 05:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778046065; cv=none; b=Q9Hz2vz/5ja7wFlw7a8tcPWFj3VcWVCLSKWY7LKtIlI+1NX02oWnxHiDau2T1POybjSuGXq/wTBuCtZds3BGigrpHH05U5QJN8q0jSHbY9Ylej+A4Ga5q1cS0mUywl9hDIRTQ8JLvHvpnq9gQHALBMPaes/pqa0l90BqKangNtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778046065; c=relaxed/simple;
	bh=HgTqDrjaFmojVMegDqrAcL9i2ahUILl1SyB5IOPWn3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eZe8JwKr21xTZNZODZFIw0NFMwQ0LznoxMod9w1yCG37mjIhxk6yzfc7ZmMFhlMJO2VtXY1hkJmYfcR1Wkd0J0taA3/xK/toYmz7UyNiRys2NswC3/4YtnFvH+c9/TRAvDFrcDI+gRUxPgzI2JhKrqTCvpWJs+9ZIY9rm9NVG9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXX/hnXV; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-1309f4ee973so2610480c88.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 22:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778046063; x=1778650863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8tkEpCpVXVNaZh3Ord5fVcdYhnryscR7qFZjdq29w8Y=;
        b=FXX/hnXVqYqSzOzEuE6UyeeTZSpkTV0sPKMv5p8lyGWzvVN+Qbpmnu6lPkJBUu+lug
         As9Hc1nV/TyaU9kfqAoENaTAopJrXtnhuZ/DhsS5q3y119NfScZhUaS0g+oo+B3wC5ub
         stHBVPv6H7H0qi5WmhMfpLcsbOdDTn+0FFFxJOZfjzVuoEsrqRGOKiz4pygO+jCrGW43
         Fk5VkTsJq59r4Y/8MkEzTsnYyjkk2kacxrqs4MFNgxGHLD1b7zcO6w1DTL5f0SRYwC5L
         xLlGf8IdBR7DuMt+g/WJuPrao1qE0r9+eeS3cZpngnlbq78YUmYthsRh7RvX3/GVcxEe
         l+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778046063; x=1778650863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tkEpCpVXVNaZh3Ord5fVcdYhnryscR7qFZjdq29w8Y=;
        b=r/3cuYa24UGKijGprkMxiGm9yE1YoZXRoEgKRJGzhLLBbJ7zJc2cst+CGLQWqjeQKC
         fAxWtmoRSW2iqHkt0/FSjhotA4ugIFS3mzHBA48RKZAU63zvas1wHHucqoGfNfwrREYe
         uu1L44UEq4gtrLVpAAFBidsqej7hevUs1hY/9+KG+PTYb275kNhfaR3ltIFY3OQcMulW
         S2VaFHynSO06QqRzIq/8lijEl3TwCzLqNQyY9Meq+brPEr+ZXBXKJX2tABdKqX5qC5Wa
         TGJlArFcV2ssdP5TvpVSOrMfApdBBATO3Nwco+tA59v7CxHDfJu2t5eNciSLTjXPSWMA
         /E4A==
X-Gm-Message-State: AOJu0YyY4iN2GFrv/3rIrxDegXWzD1HyvtLF3A0T3YJMZzjVzUN6F/Eg
	Vir6H/6m3+E3bjZs7s9E8qQRxUSaLAubX/v9OR8GXJ2mEPmdBJAY/pdUclft2cZM
X-Gm-Gg: AeBDiesrr9G4HSug7c90JBCiJpuitnTs1OwpCLFVIJM6pxRZs5xOa+bNk9QRMjeorU0
	YAfYbATRNq8FYCntK1d0AZuTZf3Wqb0PjRU0/G3Gla8gMaaX3eOasRYNZ2hSZLU6TOu8x6iqb3m
	S3jmwX0Ox04XoavmSZPzugmTG7tX4sNCiD3G3ZjZvdpmOKnwdem6EJtfXwlOuRd0e/Mb4SCnaho
	iNtq5f3uJ0mmuYdOrwsWpkfyIur4Z95wkI6ho5h5DQdMt0vHX3vS4sxlpE1NRgltR4bdLtbG1WD
	CPGMlL+OjNCJ1ziOiJK44VRZyYBIjkJae0gDh+7LIP7VBwLbOOboO8Dq0jBV9/eHa6U7d0Rvgdj
	3x9bSEZIo1fAsO5DZsb3ymW9rAf/JsX21m8kCiMOQr27TQezKPVDS3tCJocHK5qqpCfEgwILiex
	GIcxkzlwq+441Xs4zSQrWdtUc2s0yvu5yhg3qTUuZWadmSrobAI5IVF8dws5HTwm0J21PholhmN
	xkNdO5k0BKTW3nasOUOa4lXx5HrbYJAf99+fH1Ttxox7mOZ8mT+yIhHSjZV8IEr2mNQDuzJwHuq
	j6ezERP6fadLYZ+ERoU8jrDlHlDb
X-Received: by 2002:a05:7022:fa9:b0:12f:1f67:e744 with SMTP id a92af1059eb24-1318eb518a7mr1026037c88.44.1778046063087;
        Tue, 05 May 2026 22:41:03 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-131f9789e3dsm2134047c88.8.2026.05.05.22.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 22:41:02 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH net-next] net: ethernet: atheros: atl2: remove kernel backward-compatibility code
Date: Tue,  5 May 2026 22:40:27 -0700
Message-ID: <20260506054035.23710-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2E63E4D64FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284704-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The atl2 driver contains code for compatibility with old kernels that
do not support module_param_array. Backward compatibility is
irrelevant because this driver is in-tree. Remove this unreachable
code to simplify the driver's handling of module parameters.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/ethernet/atheros/atlx/atl2.c | 37 ++----------------------
 1 file changed, 3 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl2.c b/drivers/net/ethernet/atheros/atlx/atl2.c
index 280e2f5f4aa5..5560d5cc3169 100644
--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -2756,10 +2756,8 @@ static void atl2_force_ps(struct atl2_hw *hw)
 /* All parameters are treated the same, as an integer array of values.
  * This macro just reduces the need to repeat the same declaration code
  * over and over (plus this helps to avoid typo bugs).
- */
-#define ATL2_PARAM_INIT {[0 ... ATL2_MAX_NIC] = OPTION_UNSET}
-#ifndef module_param_array
-/* Module Parameters are always initialized to -1, so that the driver
+ *
+ * Module parameters are always initialized to -1, so that the driver
  * can tell the difference between no user specified value or the
  * user asking for the default value.
  * The true default values are loaded in when atl2_check_options is called.
@@ -2770,16 +2768,10 @@ static void atl2_force_ps(struct atl2_hw *hw)
  */
 
 #define ATL2_PARAM(X, desc) \
-    static const int X[ATL2_MAX_NIC + 1] = ATL2_PARAM_INIT; \
-    MODULE_PARM(X, "1-" __MODULE_STRING(ATL2_MAX_NIC) "i"); \
-    MODULE_PARM_DESC(X, desc);
-#else
-#define ATL2_PARAM(X, desc) \
-    static int X[ATL2_MAX_NIC+1] = ATL2_PARAM_INIT; \
+    static int X[ATL2_MAX_NIC+1] = {[0 ... ATL2_MAX_NIC] = OPTION_UNSET}; \
     static unsigned int num_##X; \
     module_param_array_named(X, X, int, &num_##X, 0); \
     MODULE_PARM_DESC(X, desc);
-#endif
 
 /*
  * Transmit Memory Size
@@ -2924,9 +2916,6 @@ static void atl2_check_options(struct atl2_adapter *adapter)
 		printk(KERN_NOTICE "Warning: no configuration for board #%i\n",
 			bd);
 		printk(KERN_NOTICE "Using defaults for all values\n");
-#ifndef module_param_array
-		bd = ATL2_MAX_NIC;
-#endif
 	}
 
 	/* Bytes of Transmit Memory */
@@ -2936,16 +2925,12 @@ static void atl2_check_options(struct atl2_adapter *adapter)
 	opt.def = ATL2_DEFAULT_TX_MEMSIZE;
 	opt.arg.r.min = ATL2_MIN_TX_MEMSIZE;
 	opt.arg.r.max = ATL2_MAX_TX_MEMSIZE;
-#ifdef module_param_array
 	if (num_TxMemSize > bd) {
-#endif
 		val = TxMemSize[bd];
 		atl2_validate_option(&val, &opt);
 		adapter->txd_ring_size = ((u32) val) * 1024;
-#ifdef module_param_array
 	} else
 		adapter->txd_ring_size = ((u32)opt.def) * 1024;
-#endif
 	/* txs ring size: */
 	adapter->txs_ring_size = adapter->txd_ring_size / 128;
 	if (adapter->txs_ring_size > 160)
@@ -2958,18 +2943,14 @@ static void atl2_check_options(struct atl2_adapter *adapter)
 	opt.def = ATL2_DEFAULT_RXD_COUNT;
 	opt.arg.r.min = ATL2_MIN_RXD_COUNT;
 	opt.arg.r.max = ATL2_MAX_RXD_COUNT;
-#ifdef module_param_array
 	if (num_RxMemBlock > bd) {
-#endif
 		val = RxMemBlock[bd];
 		atl2_validate_option(&val, &opt);
 		adapter->rxd_ring_size = (u32)val;
 		/* FIXME */
 		/* ((u16)val)&~1; */	/* even number */
-#ifdef module_param_array
 	} else
 		adapter->rxd_ring_size = (u32)opt.def;
-#endif
 	/* init RXD Flow control value */
 	adapter->hw.fc_rxd_hi = (adapter->rxd_ring_size / 8) * 7;
 	adapter->hw.fc_rxd_lo = (ATL2_MIN_RXD_COUNT / 8) >
@@ -2983,16 +2964,12 @@ static void atl2_check_options(struct atl2_adapter *adapter)
 	opt.def = INT_MOD_DEFAULT_CNT;
 	opt.arg.r.min = INT_MOD_MIN_CNT;
 	opt.arg.r.max = INT_MOD_MAX_CNT;
-#ifdef module_param_array
 	if (num_IntModTimer > bd) {
-#endif
 		val = IntModTimer[bd];
 		atl2_validate_option(&val, &opt);
 		adapter->imt = (u16) val;
-#ifdef module_param_array
 	} else
 		adapter->imt = (u16)(opt.def);
-#endif
 	/* Flash Vendor */
 	opt.type = range_option;
 	opt.name = "SPI Flash Vendor";
@@ -3000,16 +2977,12 @@ static void atl2_check_options(struct atl2_adapter *adapter)
 	opt.def = FLASH_VENDOR_DEFAULT;
 	opt.arg.r.min = FLASH_VENDOR_MIN;
 	opt.arg.r.max = FLASH_VENDOR_MAX;
-#ifdef module_param_array
 	if (num_FlashVendor > bd) {
-#endif
 		val = FlashVendor[bd];
 		atl2_validate_option(&val, &opt);
 		adapter->hw.flash_vendor = (u8) val;
-#ifdef module_param_array
 	} else
 		adapter->hw.flash_vendor = (u8)(opt.def);
-#endif
 	/* MediaType */
 	opt.type = range_option;
 	opt.name = "Speed/Duplex Selection";
@@ -3017,14 +2990,10 @@ static void atl2_check_options(struct atl2_adapter *adapter)
 	opt.def = MEDIA_TYPE_AUTO_SENSOR;
 	opt.arg.r.min = MEDIA_TYPE_AUTO_SENSOR;
 	opt.arg.r.max = MEDIA_TYPE_10M_HALF;
-#ifdef module_param_array
 	if (num_MediaType > bd) {
-#endif
 		val = MediaType[bd];
 		atl2_validate_option(&val, &opt);
 		adapter->hw.MediaType = (u16) val;
-#ifdef module_param_array
 	} else
 		adapter->hw.MediaType = (u16)(opt.def);
-#endif
 }
-- 
2.43.0


