Return-Path: <netdev+bounces-303175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mU3TIRLAQ2ofggoAu9opvQ
	(envelope-from <netdev+bounces-303175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:09:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AC06E4A4A
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:09:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Zkb7nI7Y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303175-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303175-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CADAF323D0A0
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F04425CC1;
	Tue, 30 Jun 2026 12:56:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14AE421F0D
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:56:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824169; cv=none; b=GGxBQkW/FxPpUfUnFvni2CkczEzpwBfXVCCP0EHdk8kb6YxBIIh9YjzqaOEwQUhU+HSn0JViFG2+KAs6D5DLuh+fBaydNKFf5YfZpH/Bd0P5I2vdoioB2NzZ5paD4BzIFb/WWWiEIXoBNNkRCx8r2oU87LF0MRsd+GE/0OAkrcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824169; c=relaxed/simple;
	bh=iHECOGxPTMoU6phEeonKO2rAx5aWC90n1gZ0ftvOCdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Elo7EpzH24oHkMbDGxSNp/qPY4Y2VFjhPM43rLdyC9Sm2KpGBLxwbmlXrLFZZcq6hLcQ1fgzr9CXiBA/Zi7v614Nv10AXyeeMG0/MP7ZXN+mk/FFPF8pfoEzSZV31NYa90hRArI/wVEm1vji7sUU0bs5frgdM99fR0QDDlMSBl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zkb7nI7Y; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782824166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4qSOAGtpGyzVipgbBUwmUY3+ENcGPAHIYsvGYm4D7LE=;
	b=Zkb7nI7Y6ivugT/nyDXjkjMKBEZ798zQnsVQYD12kQGbgFum1OHvBnPwmRZamJghmGzUlr
	VplEYGEnBhfwogoUYrKaNQDGaeEELD5Pu/baaU7L8JBxaocoIEEXPiGsm0YtYX5VNSOu6N
	aVaPP1SCXFkeAmcfo0yCKGVfDCvebtQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-_vatnphlORW3JhBU0iRdcA-1; Tue,
 30 Jun 2026 08:56:04 -0400
X-MC-Unique: _vatnphlORW3JhBU0iRdcA-1
X-Mimecast-MFC-AGG-ID: _vatnphlORW3JhBU0iRdcA_1782824162
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18EE31955E7A;
	Tue, 30 Jun 2026 12:56:02 +0000 (UTC)
Received: from p16v.bos2.lab (unknown [10.43.2.199])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 476D418005AC;
	Tue, 30 Jun 2026 12:55:58 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Chris du Quesnay <Chris.duQuesnay@microchip.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pasi Vaananen <pvaanane@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 5/5] dpll: zl3073x: add NCO virtual input pin
Date: Tue, 30 Jun 2026 14:55:36 +0200
Message-ID: <20260630125536.720717-6-ivecera@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303175-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[redhat.com,microchip.com,intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,linux.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:poros@redhat.com,m:Chris.duQuesnay@microchip.com,m:arkadiusz.kubalewski@intel.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:kuba@kernel.org,m:jiri@resnulli.us,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,microchip.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0AC06E4A4A

Add a virtual NCO (Numerically Controlled Oscillator) input pin that
lets userspace switch a DPLL channel into NCO mode. A single NCO pin
is shared across all DPLL channels - each channel has its own
independent connection state. The NCO pin is registered with the new
DPLL_PIN_TYPE_INT_NCO type and reports DPLL_PIN_STATE_CONNECTED /
DPLL_PIN_OPERSTATE_ACTIVE when the channel is in NCO mode.

At NCO pin registration the following bits are configured in
dpll_ctrl_x:
  - nco_auto_read: auto-capture tracking offset on NCO entry
  - tod_step_reset: apply negated ToD step accumulator on NCO exit
  - tie_clear: PPS DPLLs set 1 to re-align outputs on NCO exit,
               EEC DPLLs keep 0 to prevent an unwanted TIE write

Before switching to NCO mode, dpll_df_read_x is configured with
ref_ofst=0 and cmd=ACC_I so that nco_auto_read captures the
accumulated I-part offset relative to the master clock. Without
this, the captured df_offset would be near zero (offset relative
to the input reference after lock).

On NCO entry the df_offset captured by nco_auto_read is read from
the register. Per the datasheet, nco_auto_read only captures a valid
offset when entering NCO from reflock, auto or holdover mode; from
freerun the captured value is not meaningful and df_offset is marked as
ZL_DPLL_DF_OFFSET_UNKNOWN. The same sentinel is set in
chan_state_update() when the channel is not locked, and both FFO
consumers (NCO pin and input pin) guard against it.

Disconnecting the NCO pin switches to freerun rather than holdover
because holdover averaging is not updated during NCO mode.

When connecting the NCO pin displaces a previously connected input
pin (reflock mode), a change notification is sent for that input pin.

Input reference pins are now always registered regardless of the
initial DPLL mode. Previously they were skipped when the DPLL was
in NCO mode, but the NCO pin provides the proper mechanism for
mode transitions.

Reviewed-by: Petr Oros <poros@redhat.com>
Tested-by: Chris du Quesnay <Chris.duQuesnay@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
Changes:
v6:
   - Increase nco_auto_read delays to 25 ms (worst-case internal
     register update time reported by Chris du Quesnay, Microchip).
   - Add 25 ms delay between df_read configuration and NCO mode
     switch.
v5:
   - Configure dpll_df_read register before NCO mode switch:
     ref_ofst=0 to read offset relative to master clock,
     cmd=ACC_I for accumulated I-part. Without this, nco_auto_read
     captures incorrect df_offset (reported by Chris du Quesnay).
v4:
   - Drop multiop_lock from chan_state_update() and nco_mode_set(),
     df_offset access is now serialized by the per-DPLL
     zldpll->lock introduced in the new lock patch.
   - Add zldpll->lock guard to all NCO pin callbacks for
     consistency with the lock patch.
   - Use mutex_lock/unlock in nco_pin_register,
     nco_pin_state_on_dpll_set, and input_pin_state_on_dpll_set
     instead of guard()/scoped_guard() to avoid mixing cleanup
     helpers with goto-based error handling.
   - Filter NCO pin in the deferred notification loop to match the
     monitoring loop filter.
   - Introduce ZL_DPLL_DF_OFFSET_UNKNOWN (S64_MIN) sentinel for
     df_offset: set on read failure, when entering NCO from a
     freerun mode, and when
     chan_state_update() finds the channel not locked. Guard both
     NCO pin and input pin FFO consumers against the sentinel.
   - Send __dpll_pin_change_ntf() for the displaced input pin when
     connecting the NCO pin from reflock mode.
   - Read df_offset from register at probe when firmware left the
     channel in NCO mode.
   - Add comment clarifying that nco_auto_read completes before the
     mode switch (specified by the datasheet and verified by
     HW testing).
   - Unify df_offset sign convention comments with datasheet
     reference (f_offset = f_nom * (-df_offset) / 2^48).
v3:
  - Fixed Signed-off-by position
v2:
  - Configure nco_auto_read, tod_step_reset and tie_clear once at
    NCO pin registration since these are persistent R/W bits.
    In v1 nco_auto_read was set at registration, while tod_step_reset
    and tie_clear were set on each NCO exit path.
  - Add zl3073x_chan_nco_mode_set() helper that writes mode_refsel
    directly and reads df_offset from the register without the
    DF_READ semaphore protocol. A 25 ms delay is needed for the
    device to update internal registers before nco_auto_read
    populates the df_offset register (determined by HW testing).
    In v1 the full DF_READ semaphore protocol with
    zl3073x_chan_state_update() was used.
  - Zero df_offset on read failure instead of keeping stale value.
  - Serialize zl3073x_chan_state_update() and
    zl3073x_chan_nco_mode_set() with multiop_lock to prevent
    concurrent df_offset access from the periodic worker.
  - Gate df_offset read in zl3073x_chan_state_update() on LOCK state
    instead of skipping NCO channels in chan_states_update(). This
    keeps mon_status and refsel_status fresh in all modes.
  - Send __dpll_pin_change_ntf() for the NCO pin when leaving NCO
    mode via mode_set() or input pin connect, since the periodic
    worker skips the NCO pin.
  - Add comments explaining the inverted sign convention of the
    dpll_df_offset register.
  - Document why NCO disconnect selects freerun over holdover, the
    shared NCO pin design, and the input pin registration change.
---
 drivers/dpll/zl3073x/chan.c | 122 +++++++++++++-
 drivers/dpll/zl3073x/chan.h |  48 ++++++
 drivers/dpll/zl3073x/dpll.c | 308 ++++++++++++++++++++++++++++++++----
 drivers/dpll/zl3073x/dpll.h |   2 +
 drivers/dpll/zl3073x/regs.h |  11 ++
 5 files changed, 462 insertions(+), 29 deletions(-)

diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
index 677a920c16254..4ec2cf53dad46 100644
--- a/drivers/dpll/zl3073x/chan.c
+++ b/drivers/dpll/zl3073x/chan.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/cleanup.h>
+#include <linux/delay.h>
 #include <linux/dev_printk.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -31,7 +32,15 @@ int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index)
 	if (rc)
 		return rc;
 
-	/* Read df_offset vs tracked reference */
+	/* Read df_offset only when locked to a reference. In NCO mode
+	 * df_offset was captured at entry by nco_mode_set() - preserve it.
+	 */
+	if (!zl3073x_chan_is_locked(chan)) {
+		if (!zl3073x_chan_mode_is_nco(chan))
+			chan->df_offset = ZL_DPLL_DF_OFFSET_UNKNOWN;
+		return 0;
+	}
+
 	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_DPLL_DF_READ(index),
 				  ZL_DPLL_DF_READ_SEM,
 				  ZL_POLL_DF_READ_TIMEOUT_US);
@@ -58,6 +67,96 @@ int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index)
 	return 0;
 }
 
+/**
+ * zl3073x_chan_nco_mode_set - switch DPLL channel to NCO mode
+ * @zldev: pointer to zl3073x_dev structure
+ * @index: DPLL channel index
+ *
+ * Switches the channel to NCO mode and reads the df_offset
+ * auto-captured by nco_auto_read directly from the register.
+ * No DF_READ handshake is needed as nco_auto_read populates
+ * the register before the mode switch completes.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_chan_nco_mode_set(struct zl3073x_dev *zldev, u8 index)
+{
+	struct zl3073x_chan *chan = &zldev->chan[index];
+	u8 prev_mode, df_read;
+	u64 val;
+	int rc;
+
+	prev_mode = zl3073x_chan_mode_get(chan);
+
+	/* nco_auto_read captures the tracking offset at NCO entry only
+	 * from reflock, auto or holdover mode. From freerun the captured
+	 * value is not meaningful.
+	 */
+	if (prev_mode == ZL_DPLL_MODE_REFSEL_MODE_FREERUN) {
+		zl3073x_chan_mode_set(chan, ZL_DPLL_MODE_REFSEL_MODE_NCO);
+
+		rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(index),
+				      chan->mode_refsel);
+		if (rc) {
+			zl3073x_chan_mode_set(chan, prev_mode);
+			return rc;
+		}
+
+		chan->df_offset = ZL_DPLL_DF_OFFSET_UNKNOWN;
+		return 0;
+	}
+
+	/* Configure df_read for nco_auto_read:
+	 * ref_ofst=0 - reads offset relative to master clock (not input ref)
+	 * cmd=CMD_ACC_I - accumulated I-part covering both locked and
+	 *                 holdover entry.
+	 *
+	 * No semaphore is set - this only configures what the df_offset
+	 * value represents after the mode switch; nco_auto_read performs
+	 * the actual read automatically.
+	 */
+	df_read = FIELD_PREP(ZL_DPLL_DF_READ_REF_OFST, 0) |
+		  FIELD_PREP(ZL_DPLL_DF_READ_CMD, ZL_DPLL_DF_READ_CMD_ACC_I);
+	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_DF_READ(index), df_read);
+	if (rc)
+		return rc;
+
+	/* Wait for df_read configuration to take effect before
+	 * triggering nco_auto_read via mode switch. The worst-case
+	 * internal register update time is 25 ms.
+	 */
+	fsleep(25000);
+
+	zl3073x_chan_mode_set(chan, ZL_DPLL_MODE_REFSEL_MODE_NCO);
+	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(index),
+			      chan->mode_refsel);
+	if (rc) {
+		zl3073x_chan_mode_set(chan, prev_mode);
+		return rc;
+	}
+
+	/* Wait for nco_auto_read to populate df_offset. The worst-case
+	 * internal register update time is 25 ms.
+	 */
+	fsleep(25000);
+
+	/* Read df_offset captured by nco_auto_read during mode switch.
+	 * No DF_READ semaphore handshake needed. Mode switch already
+	 * succeeded, so don't propagate a read failure back to userspace.
+	 */
+	rc = zl3073x_read_u48(zldev, ZL_REG_DPLL_DF_OFFSET(index), &val);
+	if (rc) {
+		dev_warn(zldev->dev,
+			 "Failed to read DPLL%u df_offset: %pe\n",
+			 index, ERR_PTR(rc));
+		chan->df_offset = ZL_DPLL_DF_OFFSET_UNKNOWN;
+	} else {
+		chan->df_offset = sign_extend64(val, 47);
+	}
+
+	return 0;
+}
+
 /**
  * zl3073x_chan_state_fetch - fetch DPLL channel state from hardware
  * @zldev: pointer to zl3073x_dev structure
@@ -73,6 +172,10 @@ int zl3073x_chan_state_fetch(struct zl3073x_dev *zldev, u8 index)
 	struct zl3073x_chan *chan = &zldev->chan[index];
 	int rc, i;
 
+	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_CTRL(index), &chan->ctrl);
+	if (rc)
+		return rc;
+
 	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(index),
 			     &chan->mode_refsel);
 	if (rc)
@@ -85,6 +188,13 @@ int zl3073x_chan_state_fetch(struct zl3073x_dev *zldev, u8 index)
 	if (rc)
 		return rc;
 
+	/* If firmware left the channel in NCO mode, mark df_offset as
+	 * unknown - we cannot know whether the preconditions for a valid
+	 * nco_auto_read capture were met.
+	 */
+	if (zl3073x_chan_mode_is_nco(chan))
+		chan->df_offset = ZL_DPLL_DF_OFFSET_UNKNOWN;
+
 	dev_dbg(zldev->dev,
 		"DPLL%u lock_state: %u, ho: %u, sel_state: %u, sel_ref: %u\n",
 		index, zl3073x_chan_lock_state_get(chan),
@@ -147,7 +257,15 @@ int zl3073x_chan_state_set(struct zl3073x_dev *zldev, u8 index,
 	if (!memcmp(&dchan->cfg, &chan->cfg, sizeof(chan->cfg)))
 		return 0;
 
-	/* Direct register write for mode_refsel */
+	/* Direct register writes for ctrl and mode_refsel */
+	if (dchan->ctrl != chan->ctrl) {
+		rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_CTRL(index),
+				      chan->ctrl);
+		if (rc)
+			return rc;
+		dchan->ctrl = chan->ctrl;
+	}
+
 	if (dchan->mode_refsel != chan->mode_refsel) {
 		rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(index),
 				      chan->mode_refsel);
diff --git a/drivers/dpll/zl3073x/chan.h b/drivers/dpll/zl3073x/chan.h
index 4353809c69122..dc9c6d95bdee7 100644
--- a/drivers/dpll/zl3073x/chan.h
+++ b/drivers/dpll/zl3073x/chan.h
@@ -13,6 +13,7 @@ struct zl3073x_dev;
 
 /**
  * struct zl3073x_chan - DPLL channel state
+ * @ctrl: DPLL control register value
  * @mode_refsel: mode and reference selection register value
  * @ref_prio: reference priority registers (4 bits per ref, P/N packed)
  * @mon_status: monitor status register value
@@ -21,6 +22,7 @@ struct zl3073x_dev;
  */
 struct zl3073x_chan {
 	struct_group(cfg,
+		u8	ctrl;
 		u8	mode_refsel;
 		u8	ref_prio[ZL3073X_NUM_REFS / 2];
 	);
@@ -38,6 +40,7 @@ int zl3073x_chan_state_set(struct zl3073x_dev *zldev, u8 index,
 			   const struct zl3073x_chan *chan);
 
 int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index);
+int zl3073x_chan_nco_mode_set(struct zl3073x_dev *zldev, u8 index);
 
 /**
  * zl3073x_chan_df_offset_get - get cached df_offset vs tracked reference
@@ -152,6 +155,51 @@ static inline u8 zl3073x_chan_lock_state_get(const struct zl3073x_chan *chan)
 	return FIELD_GET(ZL_DPLL_MON_STATUS_STATE, chan->mon_status);
 }
 
+/**
+ * zl3073x_chan_is_locked - check if channel is locked to a reference
+ * @chan: pointer to channel state
+ *
+ * Return: true if channel is locked, false otherwise
+ */
+static inline bool zl3073x_chan_is_locked(const struct zl3073x_chan *chan)
+{
+	u8 lock_state = zl3073x_chan_lock_state_get(chan);
+	return lock_state == ZL_DPLL_MON_STATUS_STATE_LOCK;
+}
+
+/**
+ * zl3073x_chan_mode_is_auto - check if channel is in automatic mode
+ * @chan: pointer to channel state
+ *
+ * Return: true if channel is in automatic mode, false otherwise
+ */
+static inline bool zl3073x_chan_mode_is_auto(const struct zl3073x_chan *chan)
+{
+	return zl3073x_chan_mode_get(chan) == ZL_DPLL_MODE_REFSEL_MODE_AUTO;
+}
+
+/**
+ * zl3073x_chan_mode_is_nco - check if channel is in NCO mode
+ * @chan: pointer to channel state
+ *
+ * Return: true if channel is in NCO mode, false otherwise
+ */
+static inline bool zl3073x_chan_mode_is_nco(const struct zl3073x_chan *chan)
+{
+	return zl3073x_chan_mode_get(chan) == ZL_DPLL_MODE_REFSEL_MODE_NCO;
+}
+
+/**
+ * zl3073x_chan_mode_is_reflock - check if channel is in reflock mode
+ * @chan: pointer to channel state
+ *
+ * Return: true if channel is in reflock mode, false otherwise
+ */
+static inline bool zl3073x_chan_mode_is_reflock(const struct zl3073x_chan *chan)
+{
+	return zl3073x_chan_mode_get(chan) == ZL_DPLL_MODE_REFSEL_MODE_REFLOCK;
+}
+
 /**
  * zl3073x_chan_is_ho_ready - check if holdover is ready
  * @chan: pointer to channel state
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 87e8b7c865485..d91f52b58eae3 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -80,6 +80,18 @@ zl3073x_dpll_is_input_pin(struct zl3073x_dpll_pin *pin)
 	return pin->dir == DPLL_PIN_DIRECTION_INPUT;
 }
 
+/**
+ * zl3073x_dpll_is_nco_pin - check if the pin is a virtual NCO pin
+ * @pin: pin to check
+ *
+ * Return: true if pin is a virtual NCO pin, false otherwise.
+ */
+static bool
+zl3073x_dpll_is_nco_pin(struct zl3073x_dpll_pin *pin)
+{
+	return pin->id == ZL3073X_NCO_PIN_ID;
+}
+
 /**
  * zl3073x_dpll_is_p_pin - check if the pin is P-pin
  * @pin: pin to check
@@ -119,6 +131,19 @@ zl3073x_dpll_pin_get_by_ref(struct zl3073x_dpll *zldpll, u8 ref_id)
 	return NULL;
 }
 
+static struct zl3073x_dpll_pin *
+zl3073x_dpll_nco_pin_get(struct zl3073x_dpll *zldpll)
+{
+	struct zl3073x_dpll_pin *pin;
+
+	list_for_each_entry(pin, &zldpll->pins, list) {
+		if (zl3073x_dpll_is_nco_pin(pin))
+			return pin;
+	}
+
+	return NULL;
+}
+
 static int
 zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
 				 void *pin_priv,
@@ -635,6 +660,7 @@ zl3073x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,
 {
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dpll_pin *pin = pin_priv;
+	struct zl3073x_dpll_pin *nco_pin = NULL;
 	struct zl3073x_chan chan;
 	u8 mode, ref;
 	int rc = 0;
@@ -666,6 +692,10 @@ zl3073x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,
 			goto invalid_state;
 		}
 		break;
+	case ZL_DPLL_MODE_REFSEL_MODE_NCO:
+		if (state == DPLL_PIN_STATE_CONNECTED)
+			nco_pin = zl3073x_dpll_nco_pin_get(zldpll);
+		fallthrough;
 	case ZL_DPLL_MODE_REFSEL_MODE_FREERUN:
 	case ZL_DPLL_MODE_REFSEL_MODE_HOLDOVER:
 		if (state == DPLL_PIN_STATE_CONNECTED) {
@@ -713,6 +743,13 @@ zl3073x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,
 	rc = -EINVAL;
 unlock:
 	mutex_unlock(&zldpll->lock);
+
+	/* If leaving NCO mode, notify userspace about the NCO pin
+	 * state change - the periodic worker skips the NCO pin.
+	 */
+	if (!rc && nco_pin)
+		__dpll_pin_change_ntf(nco_pin->dpll_pin);
+
 	return rc;
 }
 
@@ -1039,6 +1076,144 @@ zl3073x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
 	return 0;
 }
 
+static int
+zl3073x_dpll_nco_pin_operstate_on_dpll_get(const struct dpll_pin *dpll_pin,
+					   void *pin_priv,
+					   const struct dpll_device *dpll,
+					   void *dpll_priv,
+					   enum dpll_pin_operstate *operstate,
+					   struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	const struct zl3073x_chan *chan;
+
+	guard(mutex)(&zldpll->lock);
+
+	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+	if (zl3073x_chan_mode_is_nco(chan))
+		*operstate = DPLL_PIN_OPERSTATE_ACTIVE;
+	else
+		*operstate = DPLL_PIN_OPERSTATE_STANDBY;
+
+	return 0;
+}
+
+static int
+zl3073x_dpll_nco_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
+				       void *pin_priv,
+				       const struct dpll_device *dpll,
+				       void *dpll_priv,
+				       enum dpll_pin_state *state,
+				       struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	const struct zl3073x_chan *chan;
+
+	guard(mutex)(&zldpll->lock);
+
+	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+	if (zl3073x_chan_mode_is_nco(chan))
+		*state = DPLL_PIN_STATE_CONNECTED;
+	else
+		*state = DPLL_PIN_STATE_DISCONNECTED;
+
+	return 0;
+}
+
+static int
+zl3073x_dpll_nco_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,
+				       void *pin_priv,
+				       const struct dpll_device *dpll,
+				       void *dpll_priv,
+				       enum dpll_pin_state state,
+				       struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll_pin *ref_pin = NULL;
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_chan chan;
+	u8 ref;
+	int rc;
+
+	mutex_lock(&zldpll->lock);
+
+	chan = *zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+
+	switch (state) {
+	case DPLL_PIN_STATE_CONNECTED:
+		if (zl3073x_chan_mode_is_nco(&chan)) {
+			mutex_unlock(&zldpll->lock);
+			return 0;
+		}
+		if (zl3073x_chan_mode_is_auto(&chan)) {
+			NL_SET_ERR_MSG(extack,
+				       "NCO pin cannot be connected in automatic mode");
+			mutex_unlock(&zldpll->lock);
+			return -EINVAL;
+		}
+		if (zl3073x_chan_mode_is_reflock(&chan)) {
+			/* Get currently connected pin */
+			ref = zl3073x_chan_ref_get(&chan);
+			ref_pin = zl3073x_dpll_pin_get_by_ref(zldpll, ref);
+		}
+		rc = zl3073x_chan_nco_mode_set(zldpll->dev, zldpll->id);
+		break;
+	case DPLL_PIN_STATE_DISCONNECTED:
+		if (!zl3073x_chan_mode_is_nco(&chan)) {
+			mutex_unlock(&zldpll->lock);
+			return 0;
+		}
+		/* Switch to freerun - holdover averaging was not
+		 * updated during NCO mode.
+		 */
+		zl3073x_chan_mode_set(&chan,
+				      ZL_DPLL_MODE_REFSEL_MODE_FREERUN);
+		rc = zl3073x_chan_state_set(zldpll->dev, zldpll->id, &chan);
+		break;
+	default:
+		NL_SET_ERR_MSG(extack, "invalid pin state for NCO pin");
+		mutex_unlock(&zldpll->lock);
+		return -EINVAL;
+	}
+
+	mutex_unlock(&zldpll->lock);
+
+	if (!rc && ref_pin)
+		__dpll_pin_change_ntf(ref_pin->dpll_pin);
+
+	return rc;
+}
+
+static int
+zl3073x_dpll_nco_pin_ffo_get(const struct dpll_pin *dpll_pin, void *pin_priv,
+			     const struct dpll_device *dpll, void *dpll_priv,
+			     struct dpll_ffo_param *ffo,
+			     struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	const struct zl3073x_chan *chan;
+	s64 df_offset;
+
+	guard(mutex)(&zldpll->lock);
+
+	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+	if (!zl3073x_chan_mode_is_nco(chan))
+		return -ENODATA;
+
+	/* Do not report FFO if a failure occurred during switching to NCO. */
+	df_offset = zl3073x_chan_df_offset_get(chan);
+	if (df_offset == ZL_DPLL_DF_OFFSET_UNKNOWN)
+		return -ENODATA;
+
+	/* dpll_df_offset register has inverted sign per datasheet:
+	 * f_offset = f_nom * (-df_offset) / 2^48
+	 * NCO pin reports DPLL output offset from nominal, so negate.
+	 * Convert to PPT: ppt = -df * 5^12 / 2^36
+	 */
+	ffo->ffo = -mul_s64_u64_shr(df_offset, 244140625, 36);
+
+	return 0;
+}
+
 static int
 zl3073x_dpll_temp_get(const struct dpll_device *dpll, void *dpll_priv,
 		      s32 *temp, struct netlink_ext_ack *extack)
@@ -1121,21 +1296,7 @@ zl3073x_dpll_supported_modes_get(const struct dpll_device *dpll,
 				 void *dpll_priv, unsigned long *modes,
 				 struct netlink_ext_ack *extack)
 {
-	struct zl3073x_dpll *zldpll = dpll_priv;
-	const struct zl3073x_chan *chan;
-
-	guard(mutex)(&zldpll->lock);
-
-	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
-
-	/* We support switching between automatic and manual mode, except in
-	 * a case where the DPLL channel is configured to run in NCO mode.
-	 * In this case, report only the manual mode to which the NCO is mapped
-	 * as the only supported one.
-	 */
-	if (zl3073x_chan_mode_get(chan) != ZL_DPLL_MODE_REFSEL_MODE_NCO)
-		__set_bit(DPLL_MODE_AUTOMATIC, modes);
-
+	__set_bit(DPLL_MODE_AUTOMATIC, modes);
 	__set_bit(DPLL_MODE_MANUAL, modes);
 
 	return 0;
@@ -1224,11 +1385,12 @@ zl3073x_dpll_mode_set(const struct dpll_device *dpll, void *dpll_priv,
 		      enum dpll_mode mode, struct netlink_ext_ack *extack)
 {
 	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dpll_pin *nco_pin = NULL;
 	struct zl3073x_chan chan;
 	u8 hw_mode, ref;
 	int rc;
 
-	guard(mutex)(&zldpll->lock);
+	mutex_lock(&zldpll->lock);
 
 	chan = *zl3073x_chan_state_get(zldpll->dev, zldpll->id);
 	ref = zl3073x_chan_refsel_ref_get(&chan);
@@ -1249,6 +1411,9 @@ zl3073x_dpll_mode_set(const struct dpll_device *dpll, void *dpll_priv,
 		else
 			hw_mode = ZL_DPLL_MODE_REFSEL_MODE_HOLDOVER;
 	} else {
+		if (zl3073x_chan_mode_is_nco(&chan))
+			nco_pin = zl3073x_dpll_nco_pin_get(zldpll);
+
 		/* We are switching from manual to automatic mode:
 		 * - if there is a valid reference selected then ensure that
 		 *   it is selectable after switch to automatic mode
@@ -1277,9 +1442,18 @@ zl3073x_dpll_mode_set(const struct dpll_device *dpll, void *dpll_priv,
 	if (rc) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "failed to set reference selection mode");
+		mutex_unlock(&zldpll->lock);
 		return rc;
 	}
 
+	mutex_unlock(&zldpll->lock);
+
+	/* If leaving NCO mode, notify userspace about the NCO pin
+	 * state change - the periodic worker skips the NCO pin.
+	 */
+	if (nco_pin)
+		__dpll_pin_change_ntf(nco_pin->dpll_pin);
+
 	return 0;
 }
 
@@ -1388,6 +1562,15 @@ static const struct dpll_pin_ops zl3073x_dpll_output_pin_ops = {
 	.state_on_dpll_get = zl3073x_dpll_output_pin_state_on_dpll_get,
 };
 
+static const struct dpll_pin_ops zl3073x_dpll_nco_pin_ops = {
+	.supported_ffo = BIT(DPLL_FFO_PIN_DEVICE),
+	.direction_get = zl3073x_dpll_pin_direction_get,
+	.ffo_get = zl3073x_dpll_nco_pin_ffo_get,
+	.operstate_on_dpll_get = zl3073x_dpll_nco_pin_operstate_on_dpll_get,
+	.state_on_dpll_get = zl3073x_dpll_nco_pin_state_on_dpll_get,
+	.state_on_dpll_set = zl3073x_dpll_nco_pin_state_on_dpll_set,
+};
+
 static const struct dpll_device_ops zl3073x_dpll_device_ops = {
 	.lock_status_get = zl3073x_dpll_lock_status_get,
 	.mode_get = zl3073x_dpll_mode_get,
@@ -1535,7 +1718,9 @@ zl3073x_dpll_pin_unregister(struct zl3073x_dpll_pin *pin)
 
 	WARN(!pin->dpll_pin, "DPLL pin is not registered\n");
 
-	if (zl3073x_dpll_is_input_pin(pin))
+	if (zl3073x_dpll_is_nco_pin(pin))
+		ops = &zl3073x_dpll_nco_pin_ops;
+	else if (zl3073x_dpll_is_input_pin(pin))
 		ops = &zl3073x_dpll_input_pin_ops;
 	else
 		ops = &zl3073x_dpll_output_pin_ops;
@@ -1588,20 +1773,13 @@ zl3073x_dpll_pin_is_registrable(struct zl3073x_dpll *zldpll,
 				enum dpll_pin_direction dir, u8 index)
 {
 	struct zl3073x_dev *zldev = zldpll->dev;
-	const struct zl3073x_chan *chan;
 	bool is_diff, is_enabled;
 	const char *name;
 
-	chan = zl3073x_chan_state_get(zldev, zldpll->id);
-
 	if (dir == DPLL_PIN_DIRECTION_INPUT) {
 		u8 ref_id = zl3073x_input_pin_ref_get(index);
 		const struct zl3073x_ref *ref;
 
-		/* Skip the pin if the DPLL is running in NCO mode */
-		if (zl3073x_chan_mode_get(chan) == ZL_DPLL_MODE_REFSEL_MODE_NCO)
-			return false;
-
 		name = "REF";
 		ref = zl3073x_ref_state_get(zldev, ref_id);
 		is_diff = zl3073x_ref_is_diff(ref);
@@ -1642,6 +1820,66 @@ zl3073x_dpll_pin_is_registrable(struct zl3073x_dpll *zldpll,
 	return true;
 }
 
+static const struct dpll_pin_properties zl3073x_dpll_nco_pin_props = {
+	.type = DPLL_PIN_TYPE_INT_NCO,
+	.package_label = "NCO",
+	.capabilities = DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE,
+};
+
+static int
+zl3073x_dpll_nco_pin_register(struct zl3073x_dpll *zldpll)
+{
+	struct zl3073x_dpll_pin *pin;
+	struct zl3073x_chan chan;
+	int rc;
+
+	/* Ensure that ctrl bits are configured for NCO operation:
+	 * - nco_auto_read: auto-capture tracking offset on NCO entry
+	 * - tod_step_reset: apply negated ToD step on NCO exit
+	 * - tie_clear: PPS DPLLs re-align outputs on NCO exit
+	 */
+	mutex_lock(&zldpll->lock);
+	chan = *zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+	FIELD_MODIFY(ZL_DPLL_CTRL_NCO_AUTO_READ, &chan.ctrl, 1);
+	FIELD_MODIFY(ZL_DPLL_CTRL_TOD_STEP_RST, &chan.ctrl, 1);
+	FIELD_MODIFY(ZL_DPLL_CTRL_TIE_CLEAR, &chan.ctrl,
+		     zldpll->type == DPLL_TYPE_PPS ? 1 : 0);
+	rc = zl3073x_chan_state_set(zldpll->dev, zldpll->id, &chan);
+	mutex_unlock(&zldpll->lock);
+	if (rc)
+		return rc;
+
+	pin = zl3073x_dpll_pin_alloc(zldpll, DPLL_PIN_DIRECTION_INPUT,
+				     ZL3073X_NCO_PIN_ID);
+	if (IS_ERR(pin))
+		return PTR_ERR(pin);
+
+	pin->dpll_pin = dpll_pin_get(zldpll->dev->clock_id, ZL3073X_NCO_PIN_ID,
+				     THIS_MODULE, &zl3073x_dpll_nco_pin_props,
+				     &pin->tracker);
+	if (IS_ERR(pin->dpll_pin)) {
+		rc = PTR_ERR(pin->dpll_pin);
+		goto err_pin_get;
+	}
+
+	rc = dpll_pin_register(zldpll->dpll_dev, pin->dpll_pin,
+			       &zl3073x_dpll_nco_pin_ops, pin);
+	if (rc)
+		goto err_register;
+
+	list_add(&pin->list, &zldpll->pins);
+
+	return 0;
+
+err_register:
+	dpll_pin_put(pin->dpll_pin, &pin->tracker);
+err_pin_get:
+	pin->dpll_pin = NULL;
+	kfree(pin);
+
+	return rc;
+}
+
 /**
  * zl3073x_dpll_pins_register - register all registerable DPLL pins
  * @zldpll: pointer to zl3073x_dpll structure
@@ -1689,6 +1927,11 @@ zl3073x_dpll_pins_register(struct zl3073x_dpll *zldpll)
 		list_add(&pin->list, &zldpll->pins);
 	}
 
+	/* Register NCO virtual input pin */
+	rc = zl3073x_dpll_nco_pin_register(zldpll);
+	if (rc)
+		goto error;
+
 	return 0;
 
 error:
@@ -1724,8 +1967,8 @@ zl3073x_dpll_device_register(struct zl3073x_dpll *zldpll)
 		return rc;
 	}
 
-	rc = dpll_device_register(zldpll->dpll_dev,
-				  zl3073x_prop_dpll_type_get(zldev, zldpll->id),
+	zldpll->type = zl3073x_prop_dpll_type_get(zldev, zldpll->id);
+	rc = dpll_device_register(zldpll->dpll_dev, zldpll->type,
 				  &zldpll->ops, zldpll);
 	if (rc) {
 		dpll_device_put(zldpll->dpll_dev, &zldpll->tracker);
@@ -1836,6 +2079,14 @@ zl3073x_dpll_pin_ffo_check(struct zl3073x_dpll_pin *pin)
 		return false;
 
 	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+	if (zl3073x_chan_df_offset_get(chan) == ZL_DPLL_DF_OFFSET_UNKNOWN)
+		return false;
+
+	/* dpll_df_offset register has inverted sign per datasheet:
+	 * f_offset = f_nom * (-df_offset) / 2^48
+	 * Input pin FFO is pin-vs-DPLL (opposite of DPLL-vs-reference),
+	 * so the two inversions cancel out: ppt = df * 5^12 / 2^36
+	 */
 	ffo = mul_s64_u64_shr(zl3073x_chan_df_offset_get(chan),
 			      244140625, 36);
 
@@ -1948,7 +2199,9 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 	list_for_each_entry(pin, &zldpll->pins, list) {
 		enum dpll_pin_operstate operstate;
 
-		if (!zl3073x_dpll_is_input_pin(pin))
+		/* Only physical input pins need monitoring */
+		if (!zl3073x_dpll_is_input_pin(pin) ||
+		    zl3073x_dpll_is_nco_pin(pin))
 			continue;
 
 		rc = zl3073x_dpll_ref_operstate_get(pin, &operstate);
@@ -1989,6 +2242,7 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 
 	list_for_each_entry(pin, &zldpll->pins, list) {
 		if (zl3073x_dpll_is_input_pin(pin) &&
+		    !zl3073x_dpll_is_nco_pin(pin) &&
 		    test_bit(pin->id, changed_pins))
 			dpll_pin_change_ntf(pin->dpll_pin);
 	}
diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
index 9f57c944a0077..faebc402ba1b7 100644
--- a/drivers/dpll/zl3073x/dpll.h
+++ b/drivers/dpll/zl3073x/dpll.h
@@ -19,6 +19,7 @@
  * @dpll_dev: pointer to registered DPLL device
  * @tracker: tracking object for the acquired reference
  * @lock: per-DPLL mutex serializing all operations
+ * @type: DPLL type (PPS or EEC)
  * @lock_status: last saved DPLL lock status
  * @pins: list of pins
  */
@@ -32,6 +33,7 @@ struct zl3073x_dpll {
 	struct dpll_device		*dpll_dev;
 	dpll_tracker			tracker;
 	struct mutex			lock;
+	enum dpll_type			type;
 	enum dpll_lock_status		lock_status;
 	struct list_head		pins;
 };
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index 9578f00095282..b70ead7d4495b 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -5,6 +5,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/limits.h>
 
 /*
  * Hardware limits for ZL3073x chip family
@@ -17,6 +18,7 @@
 #define ZL3073X_NUM_OUTPUT_PINS	(ZL3073X_NUM_OUTS * 2)
 #define ZL3073X_NUM_PINS	(ZL3073X_NUM_INPUT_PINS + \
 				 ZL3073X_NUM_OUTPUT_PINS)
+#define ZL3073X_NCO_PIN_ID	ZL3073X_NUM_PINS
 
 /*
  * Register address structure:
@@ -164,10 +166,18 @@
 #define ZL_DPLL_MODE_REFSEL_MODE_NCO		4
 #define ZL_DPLL_MODE_REFSEL_REF			GENMASK(7, 4)
 
+#define ZL_REG_DPLL_CTRL(_idx)						\
+	ZL_REG_IDX(_idx, 5, 0x05, 1, ZL3073X_MAX_CHANNELS, 4)
+#define ZL_DPLL_CTRL_TIE_CLEAR			BIT(0)
+#define ZL_DPLL_CTRL_TOD_STEP_RST		BIT(2)
+#define ZL_DPLL_CTRL_NCO_AUTO_READ		BIT(7)
+
 #define ZL_REG_DPLL_DF_READ(_idx)					\
 	ZL_REG_IDX(_idx, 5, 0x28, 1, ZL3073X_MAX_CHANNELS, 1)
 #define ZL_DPLL_DF_READ_SEM			BIT(4)
 #define ZL_DPLL_DF_READ_REF_OFST		BIT(3)
+#define ZL_DPLL_DF_READ_CMD			GENMASK(2, 0)
+#define ZL_DPLL_DF_READ_CMD_ACC_I		4
 
 #define ZL_REG_DPLL_MEAS_CTRL			ZL_REG(5, 0x50, 1)
 #define ZL_DPLL_MEAS_CTRL_EN			BIT(0)
@@ -190,6 +200,7 @@
 #define ZL_REG_DPLL_DF_OFFSET_4		ZL_REG(7, 0x00, 6)
 #define ZL_REG_DPLL_DF_OFFSET(_idx)					\
 	((_idx) < 4 ? ZL_REG_DPLL_DF_OFFSET_03(_idx) : ZL_REG_DPLL_DF_OFFSET_4)
+#define ZL_DPLL_DF_OFFSET_UNKNOWN	S64_MIN
 
 /***********************************
  * Register Page 9, Synth and Output
-- 
2.53.0


