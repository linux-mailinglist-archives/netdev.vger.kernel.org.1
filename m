Return-Path: <netdev+bounces-305910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NSn6CqCFTmr1OQIAu9opvQ
	(envelope-from <netdev+bounces-305910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:15:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7383672913B
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:15:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=VjcnVxeO;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305910-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305910-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17DA53110A6E
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 17:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EF84BCAD9;
	Wed,  8 Jul 2026 17:06:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA18D48097B
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 17:05:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530360; cv=none; b=HEI7+K6FS7nGlhCuBBHV6BkRFSaX3QEghjsKfrDHpkKhlggCWJfqtCirkZ/WdEEtyAEnQgFmVMf4p2UO3gC+WbLlZc2gDOnc2JWytJuaO11ICKWWfgSs42Uk2mFGobZCmW49mfxFFpgykQXTW9bJD9FeTVQnVzIS4o7G0AXCM1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530360; c=relaxed/simple;
	bh=QRri8qmiI44tk3WjfvQBY9DgQ0bHixHlI8+Zwf6cGKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRi98C7GayjieTYl69b/CSF+ws7VxRuXPcoQc8Pa6eGape982GkB5mUQwa1MzXuoy8BO/vqAgag058meArWRtx6kuK8/lPMTkEXsw6R9bh5g3xCwkfcScr6wxyhLwndgUHf8asJ+yv5Xl8BvAIykGkkxLlYbD4yrCHt2yiywIcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VjcnVxeO; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783530356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfRYypFnDEYfILpNC9u5faeXVGDA23vcpN0O6CxLjhQ=;
	b=VjcnVxeOBhRPhG8+yDye5vOQZvKWkzKc30zA/kBbIhrcljvclz4YEcz9z6DfjgjZZ5XWLe
	c+PYa3mrqkAcik2GXwvE19rZ47TgSLrxienEBxOZkcDCcSAQKe9wLfCIAIwmE2/CGTCwvf
	KHHrLPRRs757iZx5OalnZbuhnWIUzGU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-Go1lAePXPgKoUCCJkw5Bog-1; Wed,
 08 Jul 2026 13:05:52 -0400
X-MC-Unique: Go1lAePXPgKoUCCJkw5Bog-1
X-Mimecast-MFC-AGG-ID: Go1lAePXPgKoUCCJkw5Bog_1783530350
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0E9218052D0;
	Wed,  8 Jul 2026 17:05:50 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.50.138])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08529195606C;
	Wed,  8 Jul 2026 17:05:45 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Chris du Quesnay <Chris.duQuesnay@microchip.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pasi Vaananen <pvaanane@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/4] dpll: zl3073x: add channel TIE write operation
Date: Wed,  8 Jul 2026 19:05:26 +0200
Message-ID: <20260708170527.916035-4-ivecera@redhat.com>
In-Reply-To: <20260708170527.916035-1-ivecera@redhat.com>
References: <20260708170527.916035-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[microchip.com,intel.com,davemloft.net,kernel.org,resnulli.us,redhat.com,gmail.com,linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305910-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:Chris.duQuesnay@microchip.com,m:arkadiusz.kubalewski@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:jiri@resnulli.us,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:richardcochran@gmail.com,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,microchip.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7383672913B

Add TIE phase adjustment operation zl3073x_chan_tie_write() that
converts nanoseconds to TIE units (0.01 ps) and writes TIE data
to the specified DPLL channel. A tie_lock mutex serializes TIE
operations.

Add convenience helper zl3073x_chan_mode_supports_tie() to chan.h.

Tested-by: Chris du Quesnay <Chris.duQuesnay@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/chan.c | 40 +++++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/chan.h | 17 ++++++++++++++++
 drivers/dpll/zl3073x/core.c |  4 ++++
 drivers/dpll/zl3073x/core.h |  3 +++
 drivers/dpll/zl3073x/regs.h | 12 +++++++++++
 5 files changed, 76 insertions(+)

diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
index 8360444559d09..53032e782fd4a 100644
--- a/drivers/dpll/zl3073x/chan.c
+++ b/drivers/dpll/zl3073x/chan.c
@@ -450,6 +450,46 @@ int zl3073x_chan_df_offset_set(struct zl3073x_dev *zldev, u8 ch, s64 offset)
 	return rc;
 }
 
+/**
+ * zl3073x_chan_tie_write - adjust DPLL phase using TIE write
+ * @zldev: pointer to zl3073x device
+ * @ch: DPLL channel index
+ * @delta_ns: phase adjustment in nanoseconds (must be within +-1s)
+ *
+ * Converts nanoseconds to TIE units (0.01 ps) and writes TIE data
+ * to the specified channel.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_chan_tie_write(struct zl3073x_dev *zldev, u8 ch, s64 delta_ns)
+{
+	s64 tie_data;
+	int rc;
+
+	guard(mutex)(&zldev->tie_lock);
+
+	/* Wait for any previous TIE operation to complete */
+	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_DPLL_TIE_CTRL,
+				  ZL_DPLL_TIE_CTRL_OP,
+				  ZL_POLL_TIE_WR_TIMEOUT_US);
+	if (rc)
+		return rc;
+
+	/* Convert ns to TIE units (0.01 ps = 10^-14 s) */
+	tie_data = delta_ns * 100000LL;
+
+	rc = zl3073x_write_u48(zldev, ZL_REG_DPLL_TIE_DATA(ch), tie_data);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_TIE_CTRL_MASK, BIT(ch));
+	if (rc)
+		return rc;
+
+	return zl3073x_write_u8(zldev, ZL_REG_DPLL_TIE_CTRL,
+				ZL_DPLL_TIE_CTRL_OP_WR);
+}
+
 /**
  * zl3073x_chan_phase_step - execute one output phase step operation
  * @zldev: pointer to zl3073x device
diff --git a/drivers/dpll/zl3073x/chan.h b/drivers/dpll/zl3073x/chan.h
index 56a3db012cf50..9dc5a3f1991f1 100644
--- a/drivers/dpll/zl3073x/chan.h
+++ b/drivers/dpll/zl3073x/chan.h
@@ -60,6 +60,8 @@ int zl3073x_chan_phase_step(struct zl3073x_dev *zldev, u8 ch,
 
 int zl3073x_chan_df_offset_set(struct zl3073x_dev *zldev, u8 ch, s64 offset);
 
+int zl3073x_chan_tie_write(struct zl3073x_dev *zldev, u8 ch, s64 delta_ns);
+
 /**
  * zl3073x_chan_df_offset_get - get cached df_offset vs tracked reference
  * @chan: pointer to channel state
@@ -218,6 +220,21 @@ static inline bool zl3073x_chan_mode_is_reflock(const struct zl3073x_chan *chan)
 	return zl3073x_chan_mode_get(chan) == ZL_DPLL_MODE_REFSEL_MODE_REFLOCK;
 }
 
+/**
+ * zl3073x_chan_mode_supports_tie - check if channel mode supports TIE write
+ * @chan: pointer to channel state
+ *
+ * TIE write is supported in AUTO and REFLOCK modes regardless of lock state.
+ *
+ * Return: true if TIE write is supported, false otherwise
+ */
+static inline bool
+zl3073x_chan_mode_supports_tie(const struct zl3073x_chan *chan)
+{
+	return zl3073x_chan_mode_is_auto(chan) ||
+		zl3073x_chan_mode_is_reflock(chan);
+}
+
 /**
  * zl3073x_chan_is_ho_ready - check if holdover is ready
  * @chan: pointer to channel state
diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 958b722d7a38d..b2f9fc97fd1b6 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -1037,6 +1037,10 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev)
 		return dev_err_probe(zldev->dev, rc,
 				     "Failed to initialize mutex\n");
 	rc = devm_mutex_init(zldev->dev, &zldev->phase_step_lock);
+	if (rc)
+		return dev_err_probe(zldev->dev, rc,
+				     "Failed to initialize mutex\n");
+	rc = devm_mutex_init(zldev->dev, &zldev->tie_lock);
 	if (rc)
 		return dev_err_probe(zldev->dev, rc,
 				     "Failed to initialize mutex\n");
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index bd60104ee567a..2dc836d0c8f6b 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -27,6 +27,7 @@ struct zl3073x_dpll;
 #define ZL_POLL_MB_TIMEOUT_US		(30 * USEC_PER_MSEC)
 #define ZL_POLL_PHASE_ERR_TIMEOUT_US	(50 * USEC_PER_MSEC)
 #define ZL_POLL_PHASE_STEP_TIMEOUT_US	(3000 * USEC_PER_MSEC)
+#define ZL_POLL_TIE_WR_TIMEOUT_US	(1000 * USEC_PER_MSEC)
 #define ZL_POLL_TOD_RD_TIMEOUT_US	(30 * USEC_PER_MSEC)
 #define ZL_POLL_TOD_WR_TIMEOUT_US	(1000 * USEC_PER_MSEC)
 
@@ -58,6 +59,7 @@ struct zl3073x_chip_info {
  * @regmap: regmap to access device registers
  * @info: detected chip info
  * @multiop_lock: to serialize multiple register operations
+ * @tie_lock: to serialize TIE write operations
  * @phase_step_lock: to serialize output phase step operations
  * @ref: array of input references' invariants
  * @out: array of outs' invariants
@@ -75,6 +77,7 @@ struct zl3073x_dev {
 	struct regmap			*regmap;
 	const struct zl3073x_chip_info	*info;
 	struct mutex			multiop_lock;
+	struct mutex			tie_lock;
 	struct mutex			phase_step_lock;
 
 	/* Invariants */
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index 9b8e06fddaa6c..447757e99845d 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -179,6 +179,12 @@
 #define ZL_DPLL_DF_READ_CMD			GENMASK(2, 0)
 #define ZL_DPLL_DF_READ_CMD_ACC_I		4
 
+#define ZL_REG_DPLL_TIE_CTRL			ZL_REG(5, 0x30, 1)
+#define ZL_DPLL_TIE_CTRL_OP			GENMASK(2, 0)
+#define ZL_DPLL_TIE_CTRL_OP_WR			4
+
+#define ZL_REG_DPLL_TIE_CTRL_MASK		ZL_REG(5, 0x31, 1)
+
 #define ZL_REG_DPLL_TOD_CTRL(_idx)					\
 	ZL_REG_IDX(_idx, 5, 0x38, 1, 8, 1)
 #define ZL_DPLL_TOD_CTRL_SEM			BIT(4)
@@ -213,6 +219,12 @@
 	((_idx) < 4 ? ZL_REG_DPLL_DF_OFFSET_03(_idx) : ZL_REG_DPLL_DF_OFFSET_4)
 #define ZL_DPLL_DF_OFFSET_UNKNOWN	S64_MIN
 
+#define ZL_REG_DPLL_TIE_DATA_03(_idx)					\
+	ZL_REG_IDX(_idx, 6, 0x0C, 6, 4, 0x20)
+#define ZL_REG_DPLL_TIE_DATA_4			ZL_REG(7, 0x0C, 6)
+#define ZL_REG_DPLL_TIE_DATA(_idx)					\
+	((_idx) < 4 ? ZL_REG_DPLL_TIE_DATA_03(_idx) : ZL_REG_DPLL_TIE_DATA_4)
+
 #define ZL_REG_DPLL_TOD_SEC_03(_idx)					\
 	ZL_REG_IDX(_idx, 6, 0x12, 6, 4, 0x20)
 #define ZL_REG_DPLL_TOD_SEC_4			ZL_REG(7, 0x12, 6)
-- 
2.53.0


