Return-Path: <netdev+bounces-292367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIIICz4aF2ov4gcAu9opvQ
	(envelope-from <netdev+bounces-292367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:22:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE6C5E7B26
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A346130343BC
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9606A42E011;
	Wed, 27 May 2026 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOJ3gjp3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183A837C110
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898395; cv=none; b=q05cP0RPf7xWf/TdR7jAso8bo1hLZZ/pJ0HbRn7XC7YO70eXp+pNJIA3dMC5UszNVpdnXCom/MgQ6dsxOZZakPMNOTdEk7LaW+jKQ1wBaCFqvLVXZPWKwhAvTcOaCSkZeuugf8tCuy+fyKw0Yvs5/XpUIyAZKPLkoRV6LW5xrMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898395; c=relaxed/simple;
	bh=wzZ9TtyjvtSeeVyMtoxrdgiISZT8yVKwIOCSGlKQTbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTQ+d+j9l2oO8EwcH2sSDSGRKoLdoRGKUHlwVXu34Mko5uD6rFmTlf3rB6baJSY1DUkCtmfIalvEN7xBn3SJBE7mCOK2jOybNVpmopK0UbHiVteZ2GQrYXO31j9blTRX+DUZ3GhiQ8hZ159dWWotIqoKeybEQUVwrlUsrL0djBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BOJ3gjp3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779898390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k98EUWVLz08EYv1KHteuVs1EnfUpuSib3NUwjojow24=;
	b=BOJ3gjp3Nkl0lZa3ELyjfIKLYS4vbNV2konuQy56DCEqAqRRXHohYZmR79FYl4iauN5H11
	BivPiZq5PpwRvGHBtPSOtGB9wCBltAY3pLWvaDEysxafG4QIeMPO+4pD17l0XPsJfZSOWK
	LmiiQo+X6G3I+TpD1+HAdAab0MKe9X0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-sE8uuosRNcOfIaMmJKoZpg-1; Wed,
 27 May 2026 12:13:02 -0400
X-MC-Unique: sE8uuosRNcOfIaMmJKoZpg-1
X-Mimecast-MFC-AGG-ID: sE8uuosRNcOfIaMmJKoZpg_1779898377
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 095591956059;
	Wed, 27 May 2026 16:12:57 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.34.40])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86C271686;
	Wed, 27 May 2026 16:12:52 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pasi Vaananen <pvaanane@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 2/4] dpll: zl3073x: use per-operation poll timeouts
Date: Wed, 27 May 2026 18:12:39 +0200
Message-ID: <20260527161241.86655-3-ivecera@redhat.com>
In-Reply-To: <20260527161241.86655-1-ivecera@redhat.com>
References: <20260527161241.86655-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,microchip.com,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292367-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2FE6C5E7B26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the single 2s timeout in zl3073x_poll_zero_u8() with a
per-caller timeout parameter. Different HW operations have different
expected completion times so using per-operation timeouts improves
error detection. The timeout values are based on proprietary source
code provided by Microchip and own measurement.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/chan.c |  6 ++++--
 drivers/dpll/zl3073x/core.c | 29 +++++++++++++++++------------
 drivers/dpll/zl3073x/core.h | 10 +++++++++-
 3 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
index 2fe3c3da84bb5..677a920c16254 100644
--- a/drivers/dpll/zl3073x/chan.c
+++ b/drivers/dpll/zl3073x/chan.c
@@ -33,7 +33,8 @@ int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index)
 
 	/* Read df_offset vs tracked reference */
 	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_DPLL_DF_READ(index),
-				  ZL_DPLL_DF_READ_SEM);
+				  ZL_DPLL_DF_READ_SEM,
+				  ZL_POLL_DF_READ_TIMEOUT_US);
 	if (rc)
 		return rc;
 
@@ -43,7 +44,8 @@ int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index)
 		return rc;
 
 	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_DPLL_DF_READ(index),
-				  ZL_DPLL_DF_READ_SEM);
+				  ZL_DPLL_DF_READ_SEM,
+				  ZL_POLL_DF_READ_TIMEOUT_US);
 	if (rc)
 		return rc;
 
diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index b3345060490db..02f42fd72aa57 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -311,17 +311,17 @@ int zl3073x_write_u48(struct zl3073x_dev *zldev, unsigned int reg, u64 val)
  * @zldev: zl3073x device pointer
  * @reg: register to poll (has to be 8bit register)
  * @mask: bit mask for polling
+ * @timeout_us: timeout in microseconds
  *
  * Waits for bits specified by @mask in register @reg value to be cleared
  * by the device.
  *
  * Returns: 0 on success, <0 on error
  */
-int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 mask)
+int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg,
+			 u8 mask, unsigned int timeout_us)
 {
-	/* Register polling sleep & timeout */
-#define ZL_POLL_SLEEP_US   10
-#define ZL_POLL_TIMEOUT_US 2000000
+#define ZL_POLL_SLEEP_US 10
 	unsigned int val;
 
 	/* Check the register is 8bit */
@@ -335,7 +335,7 @@ int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 mask)
 	reg = ZL_REG_ADDR(reg) + ZL_RANGE_OFFSET;
 
 	return regmap_read_poll_timeout(zldev->regmap, reg, val, !(val & mask),
-					ZL_POLL_SLEEP_US, ZL_POLL_TIMEOUT_US);
+					ZL_POLL_SLEEP_US, timeout_us);
 }
 
 int zl3073x_mb_op(struct zl3073x_dev *zldev, unsigned int op_reg, u8 op_val,
@@ -354,7 +354,8 @@ int zl3073x_mb_op(struct zl3073x_dev *zldev, unsigned int op_reg, u8 op_val,
 		return rc;
 
 	/* Wait for the operation to actually finish */
-	return zl3073x_poll_zero_u8(zldev, op_reg, op_val);
+	return zl3073x_poll_zero_u8(zldev, op_reg, op_val,
+				    ZL_POLL_MB_TIMEOUT_US);
 }
 
 /**
@@ -377,8 +378,8 @@ zl3073x_do_hwreg_op(struct zl3073x_dev *zldev, u8 op)
 		return rc;
 
 	/* Poll for completion - pending bit cleared */
-	return zl3073x_poll_zero_u8(zldev, ZL_REG_HWREG_OP,
-				    ZL_HWREG_OP_PENDING);
+	return zl3073x_poll_zero_u8(zldev, ZL_REG_HWREG_OP, ZL_HWREG_OP_PENDING,
+				    ZL_POLL_HWREG_TIMEOUT_US);
 }
 
 /**
@@ -609,7 +610,8 @@ int zl3073x_ref_phase_offsets_update(struct zl3073x_dev *zldev, int channel)
 	 * to be zero to ensure that the measured data are coherent.
 	 */
 	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_REF_PHASE_ERR_READ_RQST,
-				  ZL_REF_PHASE_ERR_READ_RQST_RD);
+				  ZL_REF_PHASE_ERR_READ_RQST_RD,
+				  ZL_POLL_PHASE_ERR_TIMEOUT_US);
 	if (rc)
 		return rc;
 
@@ -628,7 +630,8 @@ int zl3073x_ref_phase_offsets_update(struct zl3073x_dev *zldev, int channel)
 
 	/* Wait for finish */
 	return zl3073x_poll_zero_u8(zldev, ZL_REG_REF_PHASE_ERR_READ_RQST,
-				    ZL_REF_PHASE_ERR_READ_RQST_RD);
+				    ZL_REF_PHASE_ERR_READ_RQST_RD,
+				    ZL_POLL_PHASE_ERR_TIMEOUT_US);
 }
 
 /**
@@ -648,7 +651,8 @@ zl3073x_ref_freq_meas_latch(struct zl3073x_dev *zldev, u8 type)
 
 	/* Wait for previous measurement to finish */
 	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_REF_FREQ_MEAS_CTRL,
-				  ZL_REF_FREQ_MEAS_CTRL);
+				  ZL_REF_FREQ_MEAS_CTRL,
+				  ZL_POLL_FREQ_MEAS_TIMEOUT_US);
 	if (rc)
 		return rc;
 
@@ -669,7 +673,8 @@ zl3073x_ref_freq_meas_latch(struct zl3073x_dev *zldev, u8 type)
 
 	/* Wait for finish */
 	return zl3073x_poll_zero_u8(zldev, ZL_REG_REF_FREQ_MEAS_CTRL,
-				    ZL_REF_FREQ_MEAS_CTRL);
+				    ZL_REF_FREQ_MEAS_CTRL,
+				    ZL_POLL_FREQ_MEAS_TIMEOUT_US);
 }
 
 /**
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 99440620407da..d470845ee12ae 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -7,6 +7,7 @@
 #include <linux/kthread.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 
 #include "chan.h"
@@ -19,6 +20,12 @@ struct device;
 struct regmap;
 struct zl3073x_dpll;
 
+/* Per-operation poll timeouts */
+#define ZL_POLL_DF_READ_TIMEOUT_US	(25 * USEC_PER_MSEC)
+#define ZL_POLL_FREQ_MEAS_TIMEOUT_US	(50 * USEC_PER_MSEC)
+#define ZL_POLL_HWREG_TIMEOUT_US	(50 * USEC_PER_MSEC)
+#define ZL_POLL_MB_TIMEOUT_US		(30 * USEC_PER_MSEC)
+#define ZL_POLL_PHASE_ERR_TIMEOUT_US	(50 * USEC_PER_MSEC)
 
 enum zl3073x_flags {
 	ZL3073X_FLAG_REF_PHASE_COMP_32_BIT,
@@ -125,7 +132,8 @@ struct zl3073x_hwreg_seq_item {
 
 int zl3073x_mb_op(struct zl3073x_dev *zldev, unsigned int op_reg, u8 op_val,
 		  unsigned int mask_reg, u16 mask_val);
-int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 mask);
+int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg,
+			 u8 mask, unsigned int timeout_us);
 int zl3073x_read_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 *val);
 int zl3073x_read_u16(struct zl3073x_dev *zldev, unsigned int reg, u16 *val);
 int zl3073x_read_u32(struct zl3073x_dev *zldev, unsigned int reg, u32 *val);
-- 
2.53.0


