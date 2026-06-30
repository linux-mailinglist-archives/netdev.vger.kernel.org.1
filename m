Return-Path: <netdev+bounces-303173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A98lC36/Q2q8gQoAu9opvQ
	(envelope-from <netdev+bounces-303173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:07:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8C76E49EE
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:07:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=IewcfIvr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303173-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303173-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C859D30EFA37
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AAB436371;
	Tue, 30 Jun 2026 12:56:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF00436369
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:56:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824163; cv=none; b=nV/w14nnVSV8c7q+FIsRrvdb/hPBtwKGxP113HKWuQGDONaMg6h8Tsp9aNqgv+KpPfelCeoPMh4NFjaw9Zo8gSGX+oB5+83/w+kEmtGw+tYwGIo/bJ3QhwmkQO8T2j651MeJRZJUh9vp/ZaCVUvmvAvWYVH5YyXtYwH39O+0XqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824163; c=relaxed/simple;
	bh=59KSa1Og8pFBLuw2SFpkoZ8zQExO8+M5li+owmnWJ2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAzJQ26/aHWfIY8G1dRmLTVUlSQitYX0rRlvgY72QS/SJQ11rOmgWkc8BU8ObigM/tzjWoXeCGPOunH39BKVMVJcZyiYNFytxxRyKIvMFZ2PP3SyBQh5OHo3ddIzfV18rJ0X8+5R9gArtg+KUmhKm6EWdAQ10ci9tzAo+quIdxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IewcfIvr; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782824161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kfIpV7qt/1OjfnIZ3tjJZYz95w78ikfiJgqE9dVyiaE=;
	b=IewcfIvr65+NJVv+Hrz/dpcUsmu5RhgUVwmf/IIgcnQFpBIZahbPCl+sJY99bg1y/+xJkr
	Ex1FH7PswkhSg3E6XVKX3gy2G2ucPBlSkTYBOZQuuPxe5xnDOyWn6kOtURch9LI4GzMbLV
	/4Mu0pClWIRJh/ctVmg/9RvjhTzAe4M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-FMT7VlvYMRmBj0IAJKCEHw-1; Tue,
 30 Jun 2026 08:55:55 -0400
X-MC-Unique: FMT7VlvYMRmBj0IAJKCEHw-1
X-Mimecast-MFC-AGG-ID: FMT7VlvYMRmBj0IAJKCEHw_1782824154
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A486195605F;
	Tue, 30 Jun 2026 12:55:54 +0000 (UTC)
Received: from p16v.bos2.lab (unknown [10.43.2.199])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 911FA180057F;
	Tue, 30 Jun 2026 12:55:50 +0000 (UTC)
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
Subject: [PATCH net-next v6 3/5] dpll: zl3073x: use per-operation poll timeouts
Date: Tue, 30 Jun 2026 14:55:34 +0200
Message-ID: <20260630125536.720717-4-ivecera@redhat.com>
In-Reply-To: <20260630125536.720717-1-ivecera@redhat.com>
References: <20260630125536.720717-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303173-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,microchip.com,linux.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:arkadiusz.kubalewski@intel.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:kuba@kernel.org,m:jiri@resnulli.us,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D8C76E49EE

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
index 8e6416a4741de..0b2050aa2ed92 100644
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
index addba378b0df4..6b55a05a222ed 100644
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
@@ -127,7 +134,8 @@ struct zl3073x_hwreg_seq_item {
 
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


