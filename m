Return-Path: <netdev+bounces-307122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i9EFNEzAVGrmqgMAu9opvQ
	(envelope-from <netdev+bounces-307122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:39:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E48749E46
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:39:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="D5/bt63H";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307122-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307122-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38B9C301C103
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42C337CD52;
	Mon, 13 Jul 2026 10:39:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8446D1DE8AE
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 10:39:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939146; cv=none; b=KcAWPAitoLWszlPGXn8vxdhYd4WzysiyZv2BCdWuz9nC7IvDy+/lYDoSLNxlLSb1dC9aCncRgHXZyaVKwoxCsGDv2ZqFrXVFuk0GvybBOhpsjMHmd7dfdBePypaSgohqx3YsDfkMwgzlkh4q4vCLLed4/XnDE4pjgOYzY6F4XPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939146; c=relaxed/simple;
	bh=5lJjoRVoCSfH/V0XKlgwS/RAllrxepGL5mwGioceFzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGEG5CbrbkAwgBRizr3GaMnzw7kjZmOe1L/kzoEMUuOVokqUGuuHD/k5rfsWq5sSb+g/cmqINs2kF25SViQxkxg1qAGfLN8gE39k3txt4EEWed+xaXXyOkIAK5nPTCeQc6x+RASnYy9n1i0PhQkLovSqMLXFvlg2KVeW470gsTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D5/bt63H; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783939143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=osH3fxjvVJH7EalUWwuKy490ZPOyUfXX20A+InHKIX0=;
	b=D5/bt63Hg3VmCCbbvzhA0eTT3ppgkFzZlkvEboxZsCqbuaRz9qNFoye67/ACRlclu5a+rb
	Rm6ag/2J2pNIT+GUYyyMUxGyvAvxzNRGPmHQUj8fjYZUGbObcG0klOA9OOAFZnsz8g5+LC
	uzmBa5KfcBZvCOOj9z7yJRFQ2FToBR8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-zTPF6UW7NvOGiFjyqoP1Lg-1; Mon,
 13 Jul 2026 06:37:52 -0400
X-MC-Unique: zTPF6UW7NvOGiFjyqoP1Lg-1
X-Mimecast-MFC-AGG-ID: zTPF6UW7NvOGiFjyqoP1Lg_1783939070
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E42C1955D8F;
	Mon, 13 Jul 2026 10:37:50 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.34.53])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 699A21956056;
	Mon, 13 Jul 2026 10:37:45 +0000 (UTC)
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
Subject: [PATCH net-next v2 1/2] dpll: zl3073x: add channel ToD, phase step and TIE operations
Date: Mon, 13 Jul 2026 12:37:38 +0200
Message-ID: <20260713103739.1553284-2-ivecera@redhat.com>
In-Reply-To: <20260713103739.1553284-1-ivecera@redhat.com>
References: <20260713103739.1553284-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[microchip.com,intel.com,davemloft.net,kernel.org,resnulli.us,redhat.com,gmail.com,linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307122-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39E48749E46

Add low-level DPLL channel operations for ToD read/write/adjust,
output phase step, delta frequency offset write and TIE (Time
Interval Error) write. These serve as building blocks for the PTP
clock callbacks added in the next patch.

ToD operations use a wait-before-write pattern to avoid blocking
after each operation. tod_adjust additionally waits for completion
since callers may follow with phase step operations.

The tod_ready_wait helper selects the poll timeout based on the
current ToD command - write operations use a longer timeout (1000 ms)
than reads (30 ms).

The ToD read captures system timestamps (ptp_system_timestamp) around
the HW command and completion poll to support cross-timestamping.

The TIE write operation provides sub-picosecond resolution phase
adjustment for modes where the DPLL is tracking a reference
(AUTO and REFLOCK).

Add output step-time mask invariant to zl3073x_chan and
zl3073x_chan_is_out_stepped() helper to check if an output
participates in step-time operations.

Tested-by: Chris du Quesnay <Chris.duQuesnay@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/chan.c | 307 ++++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/chan.h |  48 ++++++
 drivers/dpll/zl3073x/core.c |   8 +
 drivers/dpll/zl3073x/core.h |   8 +
 drivers/dpll/zl3073x/regs.h |  56 +++++++
 5 files changed, 427 insertions(+)

diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
index 4ec2cf53dad46..53032e782fd4a 100644
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
@@ -234,6 +240,307 @@ const struct zl3073x_chan *zl3073x_chan_state_get(struct zl3073x_dev *zldev,
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
index dc9c6d95bdee7..9dc5a3f1991f1 100644
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
@@ -42,6 +48,20 @@ int zl3073x_chan_state_set(struct zl3073x_dev *zldev, u8 index,
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
+int zl3073x_chan_tie_write(struct zl3073x_dev *zldev, u8 ch, s64 delta_ns);
+
 /**
  * zl3073x_chan_df_offset_get - get cached df_offset vs tracked reference
  * @chan: pointer to channel state
@@ -200,6 +220,21 @@ static inline bool zl3073x_chan_mode_is_reflock(const struct zl3073x_chan *chan)
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
@@ -233,4 +268,17 @@ static inline u8 zl3073x_chan_refsel_ref_get(const struct zl3073x_chan *chan)
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
index 7f5afaaae6342..b2f9fc97fd1b6 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -1033,6 +1033,14 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev)
 	 * and/or polls are required to be done atomically.
 	 */
 	rc = devm_mutex_init(zldev->dev, &zldev->multiop_lock);
+	if (rc)
+		return dev_err_probe(zldev->dev, rc,
+				     "Failed to initialize mutex\n");
+	rc = devm_mutex_init(zldev->dev, &zldev->phase_step_lock);
+	if (rc)
+		return dev_err_probe(zldev->dev, rc,
+				     "Failed to initialize mutex\n");
+	rc = devm_mutex_init(zldev->dev, &zldev->tie_lock);
 	if (rc)
 		return dev_err_probe(zldev->dev, rc,
 				     "Failed to initialize mutex\n");
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 78dc208f3eea2..2dc836d0c8f6b 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -26,6 +26,10 @@ struct zl3073x_dpll;
 #define ZL_POLL_HWREG_TIMEOUT_US	(50 * USEC_PER_MSEC)
 #define ZL_POLL_MB_TIMEOUT_US		(30 * USEC_PER_MSEC)
 #define ZL_POLL_PHASE_ERR_TIMEOUT_US	(50 * USEC_PER_MSEC)
+#define ZL_POLL_PHASE_STEP_TIMEOUT_US	(3000 * USEC_PER_MSEC)
+#define ZL_POLL_TIE_WR_TIMEOUT_US	(1000 * USEC_PER_MSEC)
+#define ZL_POLL_TOD_RD_TIMEOUT_US	(30 * USEC_PER_MSEC)
+#define ZL_POLL_TOD_WR_TIMEOUT_US	(1000 * USEC_PER_MSEC)
 
 enum zl3073x_flags {
 	ZL3073X_FLAG_REF_PHASE_COMP_32_BIT,
@@ -55,6 +59,8 @@ struct zl3073x_chip_info {
  * @regmap: regmap to access device registers
  * @info: detected chip info
  * @multiop_lock: to serialize multiple register operations
+ * @tie_lock: to serialize TIE write operations
+ * @phase_step_lock: to serialize output phase step operations
  * @ref: array of input references' invariants
  * @out: array of outs' invariants
  * @synth: array of synths' invariants
@@ -71,6 +77,8 @@ struct zl3073x_dev {
 	struct regmap			*regmap;
 	const struct zl3073x_chip_info	*info;
 	struct mutex			multiop_lock;
+	struct mutex			tie_lock;
+	struct mutex			phase_step_lock;
 
 	/* Invariants */
 	struct zl3073x_ref	ref[ZL3073X_NUM_REFS];
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index b70ead7d4495b..447757e99845d 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -179,6 +179,20 @@
 #define ZL_DPLL_DF_READ_CMD			GENMASK(2, 0)
 #define ZL_DPLL_DF_READ_CMD_ACC_I		4
 
+#define ZL_REG_DPLL_TIE_CTRL			ZL_REG(5, 0x30, 1)
+#define ZL_DPLL_TIE_CTRL_OP			GENMASK(2, 0)
+#define ZL_DPLL_TIE_CTRL_OP_WR			4
+
+#define ZL_REG_DPLL_TIE_CTRL_MASK		ZL_REG(5, 0x31, 1)
+
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
@@ -193,6 +207,9 @@
 
 /*******************************
  * Register Pages 6-7, DPLL Data
+ *
+ * Per-channel registers with stride 0x20. Channels 0-3 reside on page 6,
+ * channel 4 on page 7.
  *******************************/
 
 #define ZL_REG_DPLL_DF_OFFSET_03(_idx)					\
@@ -202,6 +219,24 @@
 	((_idx) < 4 ? ZL_REG_DPLL_DF_OFFSET_03(_idx) : ZL_REG_DPLL_DF_OFFSET_4)
 #define ZL_DPLL_DF_OFFSET_UNKNOWN	S64_MIN
 
+#define ZL_REG_DPLL_TIE_DATA_03(_idx)					\
+	ZL_REG_IDX(_idx, 6, 0x0C, 6, 4, 0x20)
+#define ZL_REG_DPLL_TIE_DATA_4			ZL_REG(7, 0x0C, 6)
+#define ZL_REG_DPLL_TIE_DATA(_idx)					\
+	((_idx) < 4 ? ZL_REG_DPLL_TIE_DATA_03(_idx) : ZL_REG_DPLL_TIE_DATA_4)
+
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
@@ -221,6 +256,8 @@
 #define ZL_OUTPUT_CTRL_EN			BIT(0)
 #define ZL_OUTPUT_CTRL_SYNTH_SEL		GENMASK(6, 4)
 
+#define ZL_REG_OUTPUT_STEP_TIME_MASK		ZL_REG(9, 0x36, 2)
+
 /*******************************
  * Register Page 10, Ref Mailbox
  *******************************/
@@ -316,6 +353,25 @@
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


