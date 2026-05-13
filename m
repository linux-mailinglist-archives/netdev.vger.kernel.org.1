Return-Path: <netdev+bounces-287638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEVrMuubBGoQMAIAu9opvQ
	(envelope-from <netdev+bounces-287638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:42:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3770C5365C9
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA1363321E53
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732C638D419;
	Wed, 13 May 2026 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JtGBv6sa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB6A40B6DD
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684239; cv=none; b=MUfHZMa7XRKy64YER5X2GujQRULyBIf0b0hl42rPFuYWGQQ6ZT0A+8++W0usmAPC88AthsE5aiwizjY/0vfAnRBj/Vasip9ImTDlmmTtAlgF4VqCqEc3McZt2zZhEx23Ef+3a6iW9NfMQlf+5/4XQyHsi92BehXRMTp9iOy74sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684239; c=relaxed/simple;
	bh=Pnpg35y72RzTsUkwS80TgULTpf3F0V9tDHttKTAdaks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEAirJz/RJx6HF2XmKGPdfddAtXn9XXpn8EbCJNXgAqHXYFxzBoeCuAkc+whiAfB7tzgw3IHMMVqz1Y5cDY4lkPsNEHZOdBWZ4FJ4CkQWzu8f9Akt6kfAowcntgr3zjdqRDDVLcE9xMkO94JmNntXOnBkQkrPIHTihSNzhOv9OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JtGBv6sa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778684233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3EVTOcgcej7sGfSJK1xAE8RWrY9IOXxmoABW8tdrf4=;
	b=JtGBv6saJYeLju8EWKQOmhAxO5Ua/lptuckD8zdEAecRvEsibLr+4D+b5R9N8BY71Ol30s
	HiiOwCvf6wb31iFNlnxO7uaO+BCiGBhTIkhNC6MC6OqCSReqijmub3chz7sb2f7tsSijEs
	5A72q5PRLIcUgMl8/ZR7N9surrTkKQY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-qWIjckw-MhGK5ap7-18W-w-1; Wed,
 13 May 2026 10:57:09 -0400
X-MC-Unique: qWIjckw-MhGK5ap7-18W-w-1
X-Mimecast-MFC-AGG-ID: qWIjckw-MhGK5ap7-18W-w_1778684223
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3CBD19560BB;
	Wed, 13 May 2026 14:57:02 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3326819560A2;
	Wed, 13 May 2026 14:56:57 +0000 (UTC)
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
Subject: [PATCH net-next 2/2] dpll: zl3073x: add NCO virtual input pin
Date: Wed, 13 May 2026 16:56:45 +0200
Message-ID: <20260513145645.175451-3-ivecera@redhat.com>
In-Reply-To: <20260513145645.175451-1-ivecera@redhat.com>
References: <20260513145645.175451-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 3770C5365C9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,microchip.com,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287638-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add a virtual NCO (Numerically Controlled Oscillator) input pin that
lets userspace switch a DPLL channel into NCO mode. The NCO pin is
registered with the new DPLL_PIN_TYPE_INT_NCO type and reports
DPLL_PIN_STATE_CONNECTED / ACTIVE when the channel is in NCO mode.

When entering NCO mode the nco_auto_read bit in dpll_ctrl_x causes the
hardware to automatically capture the current tracking offset into
df_offset.  This is refreshed immediately after the mode switch so
userspace sees an up-to-date FFO value.

When leaving NCO mode set tod_step_reset and tie_clear in dpll_ctrl_x
to preserve the output 1PPS phase.  PPS DPLLs set tie_clear=1 to
re-align to the new reference; EEC DPLLs set tie_clear=0 to prevent
an unwanted TIE write.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/chan.c |  14 +-
 drivers/dpll/zl3073x/chan.h |  24 ++++
 drivers/dpll/zl3073x/core.c |   7 +
 drivers/dpll/zl3073x/dpll.c | 259 ++++++++++++++++++++++++++++++------
 drivers/dpll/zl3073x/dpll.h |   2 +
 drivers/dpll/zl3073x/regs.h |   7 +
 6 files changed, 274 insertions(+), 39 deletions(-)

diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
index 2fe3c3da84bb5..70db3dbfc4b11 100644
--- a/drivers/dpll/zl3073x/chan.c
+++ b/drivers/dpll/zl3073x/chan.c
@@ -71,6 +71,10 @@ int zl3073x_chan_state_fetch(struct zl3073x_dev *zldev, u8 index)
 	struct zl3073x_chan *chan = &zldev->chan[index];
 	int rc, i;
 
+	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_CTRL(index), &chan->ctrl);
+	if (rc)
+		return rc;
+
 	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(index),
 			     &chan->mode_refsel);
 	if (rc)
@@ -145,7 +149,15 @@ int zl3073x_chan_state_set(struct zl3073x_dev *zldev, u8 index,
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
index 4353809c69122..aa89728433710 100644
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
@@ -152,6 +154,28 @@ static inline u8 zl3073x_chan_lock_state_get(const struct zl3073x_chan *chan)
 	return FIELD_GET(ZL_DPLL_MON_STATUS_STATE, chan->mon_status);
 }
 
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
 /**
  * zl3073x_chan_is_ho_ready - check if holdover is ready
  * @chan: pointer to channel state
diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index b3345060490db..1326b431c7bb4 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -572,6 +572,13 @@ zl3073x_dev_chan_states_update(struct zl3073x_dev *zldev)
 	int i, rc;
 
 	for (i = 0; i < zldev->info->num_channels; i++) {
+		const struct zl3073x_chan *chan;
+
+		/* Skip channels in NCO mode - no reference tracking */
+		chan = zl3073x_chan_state_get(zldev, i);
+		if (zl3073x_chan_mode_is_nco(chan))
+			continue;
+
 		rc = zl3073x_chan_state_update(zldev, i);
 		if (rc)
 			dev_warn(zldev->dev,
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index cff85cdb9d0e5..0407c072b604c 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -81,6 +81,18 @@ zl3073x_dpll_is_input_pin(struct zl3073x_dpll_pin *pin)
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
@@ -634,6 +646,18 @@ zl3073x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,
 			goto invalid_state;
 		}
 		break;
+	case ZL_DPLL_MODE_REFSEL_MODE_NCO:
+		if (state == DPLL_PIN_STATE_CONNECTED) {
+			/* Preserve output phase when leaving NCO:
+			 * PPS needs tie_clear=1 to re-align to the new ref,
+			 * EEC needs tie_clear=0 to prevent an unwanted TIE
+			 * write.
+			 */
+			FIELD_MODIFY(ZL_DPLL_CTRL_TOD_STEP_RST, &chan.ctrl, 1);
+			FIELD_MODIFY(ZL_DPLL_CTRL_TIE_CLEAR, &chan.ctrl,
+				     zldpll->type == DPLL_TYPE_PPS ? 1 : 0);
+		}
+		fallthrough;
 	case ZL_DPLL_MODE_REFSEL_MODE_FREERUN:
 	case ZL_DPLL_MODE_REFSEL_MODE_HOLDOVER:
 		if (state == DPLL_PIN_STATE_CONNECTED) {
@@ -989,6 +1013,129 @@ zl3073x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
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
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_chan chan;
+	int rc;
+
+	chan = *zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+
+	switch (state) {
+	case DPLL_PIN_STATE_CONNECTED:
+		/* Already in NCO mode, nothing to do */
+		if (zl3073x_chan_mode_is_nco(&chan))
+			return 0;
+		/* NCO is only allowed in manual mode */
+		if (zl3073x_chan_mode_is_auto(&chan)) {
+			NL_SET_ERR_MSG(extack,
+				       "NCO pin cannot be connected in automatic mode");
+			return -EINVAL;
+		}
+		/* Switch to NCO mode */
+		zl3073x_chan_mode_set(&chan, ZL_DPLL_MODE_REFSEL_MODE_NCO);
+		break;
+	case DPLL_PIN_STATE_DISCONNECTED:
+		/* Not in NCO mode, nothing to do */
+		if (!zl3073x_chan_mode_is_nco(&chan))
+			return 0;
+		/* Preserve output phase when leaving NCO:
+		 * PPS needs tie_clear=1 to re-align to the new ref,
+		 * EEC needs tie_clear=0 to prevent an unwanted TIE write.
+		 */
+		FIELD_MODIFY(ZL_DPLL_CTRL_TOD_STEP_RST, &chan.ctrl, 1);
+		FIELD_MODIFY(ZL_DPLL_CTRL_TIE_CLEAR, &chan.ctrl,
+			     zldpll->type == DPLL_TYPE_PPS ? 1 : 0);
+		/* Leave NCO, switch to freerun */
+		zl3073x_chan_mode_set(&chan, ZL_DPLL_MODE_REFSEL_MODE_FREERUN);
+		break;
+	default:
+		NL_SET_ERR_MSG(extack, "invalid pin state for NCO pin");
+		return -EINVAL;
+	}
+
+	rc = zl3073x_chan_state_set(zldpll->dev, zldpll->id, &chan);
+	if (rc)
+		return rc;
+
+	/* Refresh cached df_offset after entering NCO - nco_auto_read
+	 * causes HW to capture the tracking offset.
+	 */
+	if (state == DPLL_PIN_STATE_CONNECTED) {
+		rc = zl3073x_chan_state_update(zldpll->dev, zldpll->id);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
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
+
+	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+	if (!zl3073x_chan_mode_is_nco(chan))
+		return -ENODATA;
+
+	/* Convert df_offset (2^-48) to PPT: ppt = -df * 5^12 / 2^36 */
+	ffo->ffo = -mul_s64_u64_shr(zl3073x_chan_df_offset_get(chan),
+				    244140625, 36);
+
+	return 0;
+}
+
 static int
 zl3073x_dpll_temp_get(const struct dpll_device *dpll, void *dpll_priv,
 		      s32 *temp, struct netlink_ext_ack *extack)
@@ -1057,19 +1204,7 @@ zl3073x_dpll_supported_modes_get(const struct dpll_device *dpll,
 				 void *dpll_priv, unsigned long *modes,
 				 struct netlink_ext_ack *extack)
 {
-	struct zl3073x_dpll *zldpll = dpll_priv;
-	const struct zl3073x_chan *chan;
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
@@ -1310,6 +1445,15 @@ static const struct dpll_pin_ops zl3073x_dpll_output_pin_ops = {
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
@@ -1457,7 +1601,9 @@ zl3073x_dpll_pin_unregister(struct zl3073x_dpll_pin *pin)
 
 	WARN(!pin->dpll_pin, "DPLL pin is not registered\n");
 
-	if (zl3073x_dpll_is_input_pin(pin))
+	if (zl3073x_dpll_is_nco_pin(pin))
+		ops = &zl3073x_dpll_nco_pin_ops;
+	else if (zl3073x_dpll_is_input_pin(pin))
 		ops = &zl3073x_dpll_input_pin_ops;
 	else
 		ops = &zl3073x_dpll_output_pin_ops;
@@ -1510,20 +1656,13 @@ zl3073x_dpll_pin_is_registrable(struct zl3073x_dpll *zldpll,
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
@@ -1564,6 +1703,57 @@ zl3073x_dpll_pin_is_registrable(struct zl3073x_dpll *zldpll,
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
+	/* Enable automatic df_offset capture on NCO entry */
+	chan = *zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+	FIELD_MODIFY(ZL_DPLL_CTRL_NCO_AUTO_READ, &chan.ctrl, 1);
+	rc = zl3073x_chan_state_set(zldpll->dev, zldpll->id, &chan);
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
@@ -1609,6 +1799,11 @@ zl3073x_dpll_pins_register(struct zl3073x_dpll *zldpll)
 		list_add(&pin->list, &zldpll->pins);
 	}
 
+	/* Register NCO virtual input pin */
+	rc = zl3073x_dpll_nco_pin_register(zldpll);
+	if (rc)
+		goto error;
+
 	return 0;
 
 error:
@@ -1644,8 +1839,8 @@ zl3073x_dpll_device_register(struct zl3073x_dpll *zldpll)
 		return rc;
 	}
 
-	rc = dpll_device_register(zldpll->dpll_dev,
-				  zl3073x_prop_dpll_type_get(zldev, zldpll->id),
+	zldpll->type = zl3073x_prop_dpll_type_get(zldev, zldpll->id);
+	rc = dpll_device_register(zldpll->dpll_dev, zldpll->type,
 				  &zldpll->ops, zldpll);
 	if (rc) {
 		dpll_device_put(zldpll->dpll_dev, &zldpll->tracker);
@@ -1815,10 +2010,8 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 	struct zl3073x_dev *zldev = zldpll->dev;
 	enum dpll_lock_status lock_status;
 	struct device *dev = zldev->dev;
-	const struct zl3073x_chan *chan;
 	struct zl3073x_dpll_pin *pin;
 	int rc;
-	u8 mode;
 
 	zldpll->check_count++;
 
@@ -1837,15 +2030,6 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 		dpll_device_change_ntf(zldpll->dpll_dev);
 	}
 
-	/* Input pin monitoring does make sense only in automatic
-	 * or forced reference modes.
-	 */
-	chan = zl3073x_chan_state_get(zldev, zldpll->id);
-	mode = zl3073x_chan_mode_get(chan);
-	if (mode != ZL_DPLL_MODE_REFSEL_MODE_AUTO &&
-	    mode != ZL_DPLL_MODE_REFSEL_MODE_REFLOCK)
-		return;
-
 	/* Update phase offset latch registers for this DPLL if the phase
 	 * offset monitor feature is enabled.
 	 */
@@ -1863,10 +2047,9 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 		enum dpll_pin_operstate operstate;
 		bool pin_changed = false;
 
-		/* Output pins change checks are not necessary because output
-		 * states are constant.
-		 */
-		if (!zl3073x_dpll_is_input_pin(pin))
+		/* Only physical input pins need monitoring */
+		if (!zl3073x_dpll_is_input_pin(pin) ||
+		    zl3073x_dpll_is_nco_pin(pin))
 			continue;
 
 		rc = zl3073x_dpll_ref_operstate_get(pin, &operstate);
diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
index 434c32a7db123..0920e4d31ab35 100644
--- a/drivers/dpll/zl3073x/dpll.h
+++ b/drivers/dpll/zl3073x/dpll.h
@@ -19,6 +19,7 @@
  * @ops: DPLL device operations for this instance
  * @dpll_dev: pointer to registered DPLL device
  * @tracker: tracking object for the acquired reference
+ * @type: DPLL type (PPS or EEC)
  * @lock_status: last saved DPLL lock status
  * @pins: list of pins
  * @change_work: device change notification work
@@ -33,6 +34,7 @@ struct zl3073x_dpll {
 	struct dpll_device_ops		ops;
 	struct dpll_device		*dpll_dev;
 	dpll_tracker			tracker;
+	enum dpll_type			type;
 	enum dpll_lock_status		lock_status;
 	struct list_head		pins;
 	struct work_struct		change_work;
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index 9578f00095282..8f1dd3a2ac214 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -17,6 +17,7 @@
 #define ZL3073X_NUM_OUTPUT_PINS	(ZL3073X_NUM_OUTS * 2)
 #define ZL3073X_NUM_PINS	(ZL3073X_NUM_INPUT_PINS + \
 				 ZL3073X_NUM_OUTPUT_PINS)
+#define ZL3073X_NCO_PIN_ID	ZL3073X_NUM_PINS
 
 /*
  * Register address structure:
@@ -164,6 +165,12 @@
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
-- 
2.53.0


