Return-Path: <netdev+bounces-305908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /StfGXuDTmoPOQIAu9opvQ
	(envelope-from <netdev+bounces-305908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:06:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6469672901B
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:06:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Ndb4rYme;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305908-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305908-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C4183001A44
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 17:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC043B813A;
	Wed,  8 Jul 2026 17:05:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9948A2B5
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 17:05:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530352; cv=none; b=QFBhyTTzWa3oTDTCVUNw/k+lGflLuR13UZEA/CMuDsaYGZi1IfU43xkgJLvSwFNLquNAmwmMCDO1WDqm3gmAHBv+FzIYpbVWDZoIZdz3NFImgugezabtuN+5mM9YhVZoTj6reAwm/MAtxMtUTPtg6mmwG30R+pq4FX8vAgH0ieE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530352; c=relaxed/simple;
	bh=SyupLNH6Fj6WkXaCXF6E4J+h24SEkaa2P4kAFHBOyz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKfukvlSq/HcivB55hjY34Q7yUYCxGjAabZRFLP4bd9RpEDy+w6Isoirttp73vH6MQyHoefdZM/P/lRQNk9Y7JiPoJieCelptlb6Qz2FPhKFNmU0gIyTj4yvcQk8cIAxyahsLX+GKvoYHOrXJ7SsjWrhfOzEF99BEuZ+mFC3x2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ndb4rYme; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783530345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gh598srVaddWqg0LNziej6Y7lMJsA2rAyMbU45cU1Lc=;
	b=Ndb4rYmeEdhlJ95Nrso5GAboOvBrGZd3dyUaSAOfO+MxXkbBwdko1NbHDvHMrmzjQ3RFiw
	AFNNMhMD79A+I2+ZmC7yu/OlK/QybetquIIUdC7rr2Xlvy5D12PsV+DCISRRJbfnlaR8RA
	klPeyaS0/mivFpHFmtvw3qHWUKhGXW4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-ZS6a0zaANqyN6c8Lz_B6CA-1; Wed,
 08 Jul 2026 13:05:42 -0400
X-MC-Unique: ZS6a0zaANqyN6c8Lz_B6CA-1
X-Mimecast-MFC-AGG-ID: ZS6a0zaANqyN6c8Lz_B6CA_1783530340
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC8CF1955F11;
	Wed,  8 Jul 2026 17:05:39 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.50.138])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A6808195606C;
	Wed,  8 Jul 2026 17:05:34 +0000 (UTC)
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
Subject: [PATCH net-next 1/4] dpll: zl3073x: add channel ToD and phase step operations
Date: Wed,  8 Jul 2026 19:05:24 +0200
Message-ID: <20260708170527.916035-2-ivecera@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[microchip.com,intel.com,davemloft.net,kernel.org,resnulli.us,redhat.com,gmail.com,linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305908-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6469672901B

Add low-level DPLL channel operations for ToD read/write/adjust,
delta frequency offset write and output phase step. ToD operations
use a wait-before-write pattern to avoid blocking after each
operation. tod_adjust additionally waits for completion since callers
may follow with phase step operations.

The tod_ready_wait helper selects the poll timeout based on the
current ToD command - write operations use a longer timeout (1000 ms)
than reads (30 ms).

The ToD read captures system timestamps (ptp_system_timestamp) around
the HW command and completion poll to support cross-timestamping.

Add output step-time mask invariant to zl3073x_chan and
zl3073x_chan_is_out_stepped() helper to check if an output
participates in step-time operations.

Tested-by: Chris du Quesnay <Chris.duQuesnay@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/chan.c | 267 ++++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/chan.h |  31 +++++
 drivers/dpll/zl3073x/core.c |   4 +
 drivers/dpll/zl3073x/core.h |   5 +
 drivers/dpll/zl3073x/regs.h |  44 ++++++
 5 files changed, 351 insertions(+)

diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
index 4ec2cf53dad46..8360444559d09 100644
--- a/drivers/dpll/zl3073x/chan.c
+++ b/drivers/dpll/zl3073x/chan.c
@@ -3,6 +3,7 @@
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
+#include <linux/ptp_clock_kernel.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
@@ -202,6 +203,11 @@ int zl3073x_chan_state_fetch(struct zl3073x_dev *zldev, u8 index)
 		zl3073x_chan_refsel_state_get(chan),
 		zl3073x_chan_refsel_ref_get(chan));
 
+	rc = zl3073x_read_u16(zldev, ZL_REG_OUTPUT_STEP_TIME_MASK,
+			      &chan->out_step_time_mask);
+	if (rc)
+		return rc;
+
 	guard(mutex)(&zldev->multiop_lock);
 
 	/* Read DPLL configuration from mailbox */
@@ -234,6 +240,267 @@ const struct zl3073x_chan *zl3073x_chan_state_get(struct zl3073x_dev *zldev,
 	return &zldev->chan[index];
 }
 
+/**
+ * zl3073x_chan_tod_ready_wait - wait for ToD semaphore to clear
+ * @zldev: pointer to zl3073x device
+ * @ch: DPLL channel index
+ *
+ * Polls the ToD control register until the semaphore bit is cleared,
+ * indicating the device has completed the previous ToD operation.
+ *
+ * Return: 0 on success, -EBUSY if semaphore not cleared, <0 on error
+ */
+static int zl3073x_chan_tod_ready_wait(struct zl3073x_dev *zldev, u8 ch)
+{
+	unsigned int timeout;
+	u8 tod_ctrl;
+	int rc;
+
+	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_TOD_CTRL(ch), &tod_ctrl);
+	if (rc)
+		return rc;
+
+	switch (FIELD_GET(ZL_DPLL_TOD_CTRL_CMD, tod_ctrl)) {
+	case ZL_DPLL_TOD_CTRL_CMD_WR_NEXT_1HZ:
+		timeout = ZL_POLL_TOD_WR_TIMEOUT_US;
+		break;
+	default:
+		timeout = ZL_POLL_TOD_RD_TIMEOUT_US;
+		break;
+	}
+
+	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_DPLL_TOD_CTRL(ch),
+				  ZL_DPLL_TOD_CTRL_SEM, timeout);
+
+	return rc == -ETIMEDOUT ? -EBUSY : rc;
+}
+
+/**
+ * zl3073x_chan_tod_ctrl - issue ToD command
+ * @zldev: pointer to zl3073x device
+ * @ch: DPLL channel index
+ * @cmd: ToD command to execute
+ *
+ * Writes the semaphore and command to dpll_tod_ctrl. The caller must
+ * ensure the device is ready (semaphore clear) before calling and
+ * must wait for completion if needed.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int zl3073x_chan_tod_ctrl(struct zl3073x_dev *zldev, u8 ch, u8 cmd)
+{
+	return zl3073x_write_u8(zldev, ZL_REG_DPLL_TOD_CTRL(ch),
+				ZL_DPLL_TOD_CTRL_SEM | cmd);
+}
+
+/**
+ * zl3073x_chan_tod_read - read ToD registers after issuing a command
+ * @zldev: pointer to zl3073x device
+ * @ch: DPLL channel index
+ * @next_hz: if true, read predicted ToD at next 1 Hz; otherwise read current
+ * @ts: timespec to store the result
+ * @sts: optional system timestamp pair for cross-timestamping
+ *
+ * Context: Caller must serialize all zl3073x_chan_tod_* calls externally.
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_chan_tod_read(struct zl3073x_dev *zldev, u8 ch,
+			  bool next_hz, struct timespec64 *ts,
+			  struct ptp_system_timestamp *sts)
+{
+	u32 nsec;
+	u64 sec;
+	u8 cmd;
+	int rc;
+
+	if (next_hz)
+		cmd = ZL_DPLL_TOD_CTRL_CMD_RD_NEXT_1HZ;
+	else
+		cmd = ZL_DPLL_TOD_CTRL_CMD_RD_CURRENT;
+
+	/* Wait for any previous ToD operation to complete */
+	rc = zl3073x_chan_tod_ready_wait(zldev, ch);
+	if (rc)
+		return rc;
+
+	ptp_read_system_prets(sts);
+	rc = zl3073x_chan_tod_ctrl(zldev, ch, cmd);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_chan_tod_ready_wait(zldev, ch);
+	if (rc)
+		return rc;
+	ptp_read_system_postts(sts);
+
+	rc = zl3073x_read_u48(zldev, ZL_REG_DPLL_TOD_SEC(ch), &sec);
+	if (rc)
+		return rc;
+
+	/* HW nanoseconds are always in [0, NSEC_PER_SEC) range */
+	rc = zl3073x_read_u32(zldev, ZL_REG_DPLL_TOD_NS(ch), &nsec);
+	if (rc)
+		return rc;
+
+	ts->tv_sec = sec;
+	ts->tv_nsec = nsec;
+
+	return 0;
+}
+
+/**
+ * zl3073x_chan_tod_write - write ToD registers and trigger 1 Hz update
+ * @zldev: pointer to zl3073x device
+ * @ch: DPLL channel index
+ * @ts: time to set
+ *
+ * Context: Caller must serialize all zl3073x_chan_tod_* calls externally.
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_chan_tod_write(struct zl3073x_dev *zldev, u8 ch,
+			   struct timespec64 ts)
+{
+	int rc;
+
+	/* Wait for any previous ToD operation to complete */
+	rc = zl3073x_chan_tod_ready_wait(zldev, ch);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_write_u48(zldev, ZL_REG_DPLL_TOD_SEC(ch), ts.tv_sec);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_write_u32(zldev, ZL_REG_DPLL_TOD_NS(ch), ts.tv_nsec);
+	if (rc)
+		return rc;
+
+	return zl3073x_chan_tod_ctrl(zldev, ch,
+				    ZL_DPLL_TOD_CTRL_CMD_WR_NEXT_1HZ);
+}
+
+/**
+ * zl3073x_chan_tod_adjust - atomic ToD read-modify-write with rollover guard
+ * @zldev: pointer to zl3073x device
+ * @ch: DPLL channel index
+ * @delta: time adjustment to apply
+ *
+ * Reads the next-Hz ToD and current ToD, then checks whether enough time
+ * remains before the next 1 Hz rollover to safely complete the write.
+ * If less than 20 ms remains, waits for the rollover and increments the
+ * next-Hz seconds by one. Applies @delta and writes the result back.
+ *
+ * Context: Caller must serialize all zl3073x_chan_tod_* calls externally.
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_chan_tod_adjust(struct zl3073x_dev *zldev, u8 ch,
+			    struct timespec64 delta)
+{
+	static const long threshold_ns = 20 * NSEC_PER_MSEC;
+	struct timespec64 ts_next, ts_cur, diff;
+	int rc;
+
+	/* Read predicted ToD at next 1 Hz tick */
+	rc = zl3073x_chan_tod_read(zldev, ch, true, &ts_next, NULL);
+	if (rc)
+		return rc;
+
+	/* Read current ToD to determine remaining margin */
+	rc = zl3073x_chan_tod_read(zldev, ch, false, &ts_cur, NULL);
+	if (rc)
+		return rc;
+
+	/* If too close to (or past) the next rollover, wait it out */
+	diff = timespec64_sub(ts_next, ts_cur);
+	if (diff.tv_sec < 0 || (!diff.tv_sec && diff.tv_nsec < threshold_ns)) {
+		if (!diff.tv_sec && diff.tv_nsec)
+			fsleep((unsigned long)diff.tv_nsec / NSEC_PER_USEC + 1);
+		ts_next.tv_sec++;
+	}
+
+	/* Apply delta to the next-Hz ToD */
+	ts_next = timespec64_add(ts_next, delta);
+	if (!timespec64_valid(&ts_next))
+		return -EINVAL;
+
+	/* Write adjusted ToD back and wait for completion */
+	rc = zl3073x_chan_tod_write(zldev, ch, ts_next);
+	if (rc)
+		return rc;
+
+	return zl3073x_chan_tod_ready_wait(zldev, ch);
+}
+
+/**
+ * zl3073x_chan_df_offset_set - write delta frequency offset to hardware
+ * @zldev: pointer to zl3073x device
+ * @ch: DPLL channel index
+ * @offset: frequency offset in 2^-48 steps
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_chan_df_offset_set(struct zl3073x_dev *zldev, u8 ch, s64 offset)
+{
+	int rc;
+
+	rc = zl3073x_write_u48(zldev, ZL_REG_DPLL_DF_OFFSET(ch), offset);
+	if (!rc)
+		zldev->chan[ch].df_offset = offset;
+
+	return rc;
+}
+
+/**
+ * zl3073x_chan_phase_step - execute one output phase step operation
+ * @zldev: pointer to zl3073x device
+ * @ch: DPLL channel index
+ * @out_mask: bitmask of outputs to step
+ * @step_cycles: phase step in synthesizer clock cycles
+ * @tod_step: also step the ToD counter
+ *
+ * All masked outputs must use synthesizers of the same frequency since
+ * the step value is in synthesizer clock cycles.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_chan_phase_step(struct zl3073x_dev *zldev, u8 ch,
+			    u16 out_mask, s32 step_cycles,
+			    bool tod_step)
+{
+	u8 ctrl;
+	int rc;
+
+	guard(mutex)(&zldev->phase_step_lock);
+
+	/* Wait for any previous phase step operation to complete */
+	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_OUTPUT_PHASE_STEP_CTRL,
+				  ZL_OUTPUT_PHASE_STEP_CTRL_OP,
+				  ZL_POLL_PHASE_STEP_TIMEOUT_US);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_PHASE_STEP_DATA,
+			       step_cycles);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_write_u16(zldev, ZL_REG_OUTPUT_PHASE_STEP_MASK, out_mask);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_write_u8(zldev, ZL_REG_OUTPUT_PHASE_STEP_NUMBER, 1);
+	if (rc)
+		return rc;
+
+	ctrl = FIELD_PREP(ZL_OUTPUT_PHASE_STEP_CTRL_DPLL, ch) |
+	       FIELD_PREP(ZL_OUTPUT_PHASE_STEP_CTRL_OP,
+			  ZL_OUTPUT_PHASE_STEP_CTRL_OP_WRITE);
+	if (tod_step)
+		ctrl |= ZL_OUTPUT_PHASE_STEP_CTRL_TOD_STEP;
+
+	return zl3073x_write_u8(zldev, ZL_REG_OUTPUT_PHASE_STEP_CTRL, ctrl);
+}
+
 /**
  * zl3073x_chan_state_set - commit DPLL channel state changes to hardware
  * @zldev: pointer to zl3073x_dev structure
diff --git a/drivers/dpll/zl3073x/chan.h b/drivers/dpll/zl3073x/chan.h
index dc9c6d95bdee7..56a3db012cf50 100644
--- a/drivers/dpll/zl3073x/chan.h
+++ b/drivers/dpll/zl3073x/chan.h
@@ -5,10 +5,12 @@
 
 #include <linux/bitfield.h>
 #include <linux/stddef.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 
 #include "regs.h"
 
+struct ptp_system_timestamp;
 struct zl3073x_dev;
 
 /**
@@ -16,6 +18,7 @@ struct zl3073x_dev;
  * @ctrl: DPLL control register value
  * @mode_refsel: mode and reference selection register value
  * @ref_prio: reference priority registers (4 bits per ref, P/N packed)
+ * @out_step_time_mask: output step-time mask
  * @mon_status: monitor status register value
  * @refsel_status: reference selection status register value
  * @df_offset: frequency offset vs tracked reference in 2^-48 steps
@@ -26,6 +29,9 @@ struct zl3073x_chan {
 		u8	mode_refsel;
 		u8	ref_prio[ZL3073X_NUM_REFS / 2];
 	);
+	struct_group(inv, /* Invariants */
+		u16	out_step_time_mask;
+	);
 	struct_group(stat,
 		u8	mon_status;
 		u8	refsel_status;
@@ -42,6 +48,18 @@ int zl3073x_chan_state_set(struct zl3073x_dev *zldev, u8 index,
 int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index);
 int zl3073x_chan_nco_mode_set(struct zl3073x_dev *zldev, u8 index);
 
+int zl3073x_chan_tod_read(struct zl3073x_dev *zldev, u8 ch,
+			  bool next_hz, struct timespec64 *ts,
+			  struct ptp_system_timestamp *sts);
+int zl3073x_chan_tod_write(struct zl3073x_dev *zldev, u8 ch,
+			   struct timespec64 ts);
+int zl3073x_chan_tod_adjust(struct zl3073x_dev *zldev, u8 ch,
+			    struct timespec64 delta);
+int zl3073x_chan_phase_step(struct zl3073x_dev *zldev, u8 ch,
+			    u16 out_mask, s32 step_cycles, bool tod_step);
+
+int zl3073x_chan_df_offset_set(struct zl3073x_dev *zldev, u8 ch, s64 offset);
+
 /**
  * zl3073x_chan_df_offset_get - get cached df_offset vs tracked reference
  * @chan: pointer to channel state
@@ -233,4 +251,17 @@ static inline u8 zl3073x_chan_refsel_ref_get(const struct zl3073x_chan *chan)
 	return FIELD_GET(ZL_DPLL_REFSEL_STATUS_REFSEL, chan->refsel_status);
 }
 
+/**
+ * zl3073x_chan_is_out_stepped - check if output is in step-time mask
+ * @chan: pointer to channel state
+ * @out: output index
+ *
+ * Return: true if output is affected by step-time operations
+ */
+static inline bool
+zl3073x_chan_is_out_stepped(const struct zl3073x_chan *chan, u8 out)
+{
+	return !!(chan->out_step_time_mask & BIT(out));
+}
+
 #endif /* _ZL3073X_CHAN_H */
diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 7f5afaaae6342..958b722d7a38d 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -1033,6 +1033,10 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev)
 	 * and/or polls are required to be done atomically.
 	 */
 	rc = devm_mutex_init(zldev->dev, &zldev->multiop_lock);
+	if (rc)
+		return dev_err_probe(zldev->dev, rc,
+				     "Failed to initialize mutex\n");
+	rc = devm_mutex_init(zldev->dev, &zldev->phase_step_lock);
 	if (rc)
 		return dev_err_probe(zldev->dev, rc,
 				     "Failed to initialize mutex\n");
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 78dc208f3eea2..bd60104ee567a 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -26,6 +26,9 @@ struct zl3073x_dpll;
 #define ZL_POLL_HWREG_TIMEOUT_US	(50 * USEC_PER_MSEC)
 #define ZL_POLL_MB_TIMEOUT_US		(30 * USEC_PER_MSEC)
 #define ZL_POLL_PHASE_ERR_TIMEOUT_US	(50 * USEC_PER_MSEC)
+#define ZL_POLL_PHASE_STEP_TIMEOUT_US	(3000 * USEC_PER_MSEC)
+#define ZL_POLL_TOD_RD_TIMEOUT_US	(30 * USEC_PER_MSEC)
+#define ZL_POLL_TOD_WR_TIMEOUT_US	(1000 * USEC_PER_MSEC)
 
 enum zl3073x_flags {
 	ZL3073X_FLAG_REF_PHASE_COMP_32_BIT,
@@ -55,6 +58,7 @@ struct zl3073x_chip_info {
  * @regmap: regmap to access device registers
  * @info: detected chip info
  * @multiop_lock: to serialize multiple register operations
+ * @phase_step_lock: to serialize output phase step operations
  * @ref: array of input references' invariants
  * @out: array of outs' invariants
  * @synth: array of synths' invariants
@@ -71,6 +75,7 @@ struct zl3073x_dev {
 	struct regmap			*regmap;
 	const struct zl3073x_chip_info	*info;
 	struct mutex			multiop_lock;
+	struct mutex			phase_step_lock;
 
 	/* Invariants */
 	struct zl3073x_ref	ref[ZL3073X_NUM_REFS];
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index b70ead7d4495b..9b8e06fddaa6c 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -179,6 +179,14 @@
 #define ZL_DPLL_DF_READ_CMD			GENMASK(2, 0)
 #define ZL_DPLL_DF_READ_CMD_ACC_I		4
 
+#define ZL_REG_DPLL_TOD_CTRL(_idx)					\
+	ZL_REG_IDX(_idx, 5, 0x38, 1, 8, 1)
+#define ZL_DPLL_TOD_CTRL_SEM			BIT(4)
+#define ZL_DPLL_TOD_CTRL_CMD			GENMASK(3, 0)
+#define ZL_DPLL_TOD_CTRL_CMD_WR_NEXT_1HZ	1
+#define ZL_DPLL_TOD_CTRL_CMD_RD_CURRENT	8
+#define ZL_DPLL_TOD_CTRL_CMD_RD_NEXT_1HZ	9
+
 #define ZL_REG_DPLL_MEAS_CTRL			ZL_REG(5, 0x50, 1)
 #define ZL_DPLL_MEAS_CTRL_EN			BIT(0)
 #define ZL_DPLL_MEAS_CTRL_AVG_FACTOR		GENMASK(7, 4)
@@ -193,6 +201,9 @@
 
 /*******************************
  * Register Pages 6-7, DPLL Data
+ *
+ * Per-channel registers with stride 0x20. Channels 0-3 reside on page 6,
+ * channel 4 on page 7.
  *******************************/
 
 #define ZL_REG_DPLL_DF_OFFSET_03(_idx)					\
@@ -202,6 +213,18 @@
 	((_idx) < 4 ? ZL_REG_DPLL_DF_OFFSET_03(_idx) : ZL_REG_DPLL_DF_OFFSET_4)
 #define ZL_DPLL_DF_OFFSET_UNKNOWN	S64_MIN
 
+#define ZL_REG_DPLL_TOD_SEC_03(_idx)					\
+	ZL_REG_IDX(_idx, 6, 0x12, 6, 4, 0x20)
+#define ZL_REG_DPLL_TOD_SEC_4			ZL_REG(7, 0x12, 6)
+#define ZL_REG_DPLL_TOD_SEC(_idx)					\
+	((_idx) < 4 ? ZL_REG_DPLL_TOD_SEC_03(_idx) : ZL_REG_DPLL_TOD_SEC_4)
+
+#define ZL_REG_DPLL_TOD_NS_03(_idx)					\
+	ZL_REG_IDX(_idx, 6, 0x18, 4, 4, 0x20)
+#define ZL_REG_DPLL_TOD_NS_4			ZL_REG(7, 0x18, 4)
+#define ZL_REG_DPLL_TOD_NS(_idx)					\
+	((_idx) < 4 ? ZL_REG_DPLL_TOD_NS_03(_idx) : ZL_REG_DPLL_TOD_NS_4)
+
 /***********************************
  * Register Page 9, Synth and Output
  ***********************************/
@@ -221,6 +244,8 @@
 #define ZL_OUTPUT_CTRL_EN			BIT(0)
 #define ZL_OUTPUT_CTRL_SYNTH_SEL		GENMASK(6, 4)
 
+#define ZL_REG_OUTPUT_STEP_TIME_MASK		ZL_REG(9, 0x36, 2)
+
 /*******************************
  * Register Page 10, Ref Mailbox
  *******************************/
@@ -316,6 +341,25 @@
 #define ZL_REG_OUTPUT_ESYNC_WIDTH		ZL_REG(14, 0x18, 4)
 #define ZL_REG_OUTPUT_PHASE_COMP		ZL_REG(14, 0x20, 4)
 
+/***********************************
+ * Register Page 9, Output Phase Step
+ ***********************************/
+
+#define ZL_REG_OUTPUT_PHASE_STEP_CTRL		ZL_REG(9, 0x38, 1)
+#define ZL_OUTPUT_PHASE_STEP_CTRL_DPLL		GENMASK(6, 4)
+#define ZL_OUTPUT_PHASE_STEP_CTRL_TOD_STEP	BIT(3)
+#define ZL_OUTPUT_PHASE_STEP_CTRL_OP		GENMASK(1, 0)
+#define ZL_OUTPUT_PHASE_STEP_CTRL_OP_NONE	0
+#define ZL_OUTPUT_PHASE_STEP_CTRL_OP_RESET	1
+#define ZL_OUTPUT_PHASE_STEP_CTRL_OP_READ	2
+#define ZL_OUTPUT_PHASE_STEP_CTRL_OP_WRITE	3
+
+#define ZL_REG_OUTPUT_PHASE_STEP_NUMBER		ZL_REG(9, 0x39, 1)
+
+#define ZL_REG_OUTPUT_PHASE_STEP_MASK		ZL_REG(9, 0x3a, 2)
+
+#define ZL_REG_OUTPUT_PHASE_STEP_DATA		ZL_REG(9, 0x3c, 4)
+
 /*
  * Register Page 255 - HW registers access
  */
-- 
2.53.0


