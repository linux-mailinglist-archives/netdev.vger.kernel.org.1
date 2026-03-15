Return-Path: <netdev+bounces-267951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LCHIuDvtmnnKgEAu9opvQ
	(envelope-from <netdev+bounces-267951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 18:44:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD41A291D29
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 18:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62A6230200FC
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCFF37B00F;
	Sun, 15 Mar 2026 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTzAVYDd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FA937A496
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773596575; cv=none; b=Zs+NfNFbsplK5SVAlRUthcgGAdIbDVSKNapeXqopT2Puphj65U+vBDt5nu4m4edsEjB9Q8OjaV55ZGe9SnUI8qqKffEm38mDupaZ0zGK9KLcWN5vRB30H0/MZ786C5h/NXIqw6UI9dMIqnv40SSuF9U/3H0po9RxaocFsDz14MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773596575; c=relaxed/simple;
	bh=li8KTu82/nej6Q4/jwJSBSo0aTJ0MpPUSZVsFqSeog4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hf3bEjzZW0X1nJPeyk2En/VYEUtxjqDK6dBxcuJDZ1DIidvsWL/Qd8u5csW5pfV8DfJEa4op2Ph772Cj8ChO2/wutX56ImFjpnR2mgFyWcd6GbE63YtWUo37OhXZ4a6HsnZl4n02B/3JJB5qBUwzd4PBQIRx27cqL9Yh6yJ4nFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTzAVYDd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773596571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WE3mL1A+bKtzhtw8lQrzsG2OulPc/S3iPd+9KWmoUDY=;
	b=KTzAVYDdhxKFvjm4R/MSA7wX6jgPxMveyuDspoLogvQGNAf0zeX+xxF9KWYCtu3cqlJ/AM
	8TgWALkfWnvpOhoBu4TXJVKAKZLWa+OIdSOXuhWntDFmZS6Hk7qNTLu+cDKJ+SB5YRe3qm
	rMT2YRXml9y9l4LyEZlUipDqNr4Gb4s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-17Q5xSh6PZeiAzv-DXgAzw-1; Sun,
 15 Mar 2026 13:42:48 -0400
X-MC-Unique: 17Q5xSh6PZeiAzv-DXgAzw-1
X-Mimecast-MFC-AGG-ID: 17Q5xSh6PZeiAzv-DXgAzw_1773596567
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5949E180047F;
	Sun, 15 Mar 2026 17:42:47 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.46])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F74C1955D87;
	Sun, 15 Mar 2026 17:42:43 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Oros <poros@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 4/6] dpll: zl3073x: add DPLL channel status fields to zl3073x_chan
Date: Sun, 15 Mar 2026 18:42:22 +0100
Message-ID: <20260315174224.399074-5-ivecera@redhat.com>
In-Reply-To: <20260315174224.399074-1-ivecera@redhat.com>
References: <20260315174224.399074-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-267951-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AD41A291D29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add mon_status and refsel_status fields to struct zl3073x_chan in a
stat group to cache the 'dpll_mon_status' and 'dpll_refsel_status'
registers.

Add zl3073x_chan_lock_state_get(), zl3073x_chan_is_ho_ready(),
zl3073x_chan_refsel_state_get() and zl3073x_chan_refsel_ref_get()
inline helpers for reading cached state, and zl3073x_chan_state_update()
for refreshing both registers from hardware. Call it from
zl3073x_chan_state_fetch() as well so that channel status is
initialized at device startup.

Call zl3073x_dev_chan_states_update() from the periodic work to
keep the cached state up to date and convert
zl3073x_dpll_lock_status_get() and zl3073x_dpll_selected_ref_get()
to use the cached state via the new helpers instead of direct register
reads.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/chan.c | 32 +++++++++++++++++++++++
 drivers/dpll/zl3073x/chan.h | 52 +++++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/core.c | 17 ++++++++++++
 drivers/dpll/zl3073x/dpll.c | 41 +++++++----------------------
 4 files changed, 111 insertions(+), 31 deletions(-)

diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
index 8019b8ce73514..71fb60a9859bf 100644
--- a/drivers/dpll/zl3073x/chan.c
+++ b/drivers/dpll/zl3073x/chan.c
@@ -7,6 +7,27 @@
 #include "chan.h"
 #include "core.h"
 
+/**
+ * zl3073x_chan_state_update - update DPLL channel status from HW
+ * @zldev: pointer to zl3073x_dev structure
+ * @index: DPLL channel index
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index)
+{
+	struct zl3073x_chan *chan = &zldev->chan[index];
+	int rc;
+
+	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MON_STATUS(index),
+			     &chan->mon_status);
+	if (rc)
+		return rc;
+
+	return zl3073x_read_u8(zldev, ZL_REG_DPLL_REFSEL_STATUS(index),
+			       &chan->refsel_status);
+}
+
 /**
  * zl3073x_chan_state_fetch - fetch DPLL channel state from hardware
  * @zldev: pointer to zl3073x_dev structure
@@ -30,6 +51,17 @@ int zl3073x_chan_state_fetch(struct zl3073x_dev *zldev, u8 index)
 	dev_dbg(zldev->dev, "DPLL%u mode: %u, ref: %u\n", index,
 		zl3073x_chan_mode_get(chan), zl3073x_chan_ref_get(chan));
 
+	rc = zl3073x_chan_state_update(zldev, index);
+	if (rc)
+		return rc;
+
+	dev_dbg(zldev->dev,
+		"DPLL%u lock_state: %u, ho: %u, sel_state: %u, sel_ref: %u\n",
+		index, zl3073x_chan_lock_state_get(chan),
+		zl3073x_chan_is_ho_ready(chan) ? 1 : 0,
+		zl3073x_chan_refsel_state_get(chan),
+		zl3073x_chan_refsel_ref_get(chan));
+
 	return 0;
 }
 
diff --git a/drivers/dpll/zl3073x/chan.h b/drivers/dpll/zl3073x/chan.h
index 3e6ffaef0c743..f73a076108551 100644
--- a/drivers/dpll/zl3073x/chan.h
+++ b/drivers/dpll/zl3073x/chan.h
@@ -14,11 +14,17 @@ struct zl3073x_dev;
 /**
  * struct zl3073x_chan - DPLL channel state
  * @mode_refsel: mode and reference selection register value
+ * @mon_status: monitor status register value
+ * @refsel_status: reference selection status register value
  */
 struct zl3073x_chan {
 	struct_group(cfg,
 		u8	mode_refsel;
 	);
+	struct_group(stat,
+		u8	mon_status;
+		u8	refsel_status;
+	);
 };
 
 int zl3073x_chan_state_fetch(struct zl3073x_dev *zldev, u8 index);
@@ -27,6 +33,8 @@ const struct zl3073x_chan *zl3073x_chan_state_get(struct zl3073x_dev *zldev,
 int zl3073x_chan_state_set(struct zl3073x_dev *zldev, u8 index,
 			   const struct zl3073x_chan *chan);
 
+int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index);
+
 /**
  * zl3073x_chan_mode_get - get DPLL channel operating mode
  * @chan: pointer to channel state
@@ -71,4 +79,48 @@ static inline void zl3073x_chan_ref_set(struct zl3073x_chan *chan, u8 ref)
 	chan->mode_refsel |= FIELD_PREP(ZL_DPLL_MODE_REFSEL_REF, ref);
 }
 
+/**
+ * zl3073x_chan_lock_state_get - get DPLL channel lock state
+ * @chan: pointer to channel state
+ *
+ * Return: lock state of the given DPLL channel
+ */
+static inline u8 zl3073x_chan_lock_state_get(const struct zl3073x_chan *chan)
+{
+	return FIELD_GET(ZL_DPLL_MON_STATUS_STATE, chan->mon_status);
+}
+
+/**
+ * zl3073x_chan_is_ho_ready - check if holdover is ready
+ * @chan: pointer to channel state
+ *
+ * Return: true if holdover is ready, false otherwise
+ */
+static inline bool zl3073x_chan_is_ho_ready(const struct zl3073x_chan *chan)
+{
+	return !!FIELD_GET(ZL_DPLL_MON_STATUS_HO_READY, chan->mon_status);
+}
+
+/**
+ * zl3073x_chan_refsel_state_get - get reference selection state
+ * @chan: pointer to channel state
+ *
+ * Return: reference selection state of the given DPLL channel
+ */
+static inline u8 zl3073x_chan_refsel_state_get(const struct zl3073x_chan *chan)
+{
+	return FIELD_GET(ZL_DPLL_REFSEL_STATUS_STATE, chan->refsel_status);
+}
+
+/**
+ * zl3073x_chan_refsel_ref_get - get currently selected reference in auto mode
+ * @chan: pointer to channel state
+ *
+ * Return: reference selected by the DPLL in automatic mode
+ */
+static inline u8 zl3073x_chan_refsel_ref_get(const struct zl3073x_chan *chan)
+{
+	return FIELD_GET(ZL_DPLL_REFSEL_STATUS_REFSEL, chan->refsel_status);
+}
+
 #endif /* _ZL3073X_CHAN_H */
diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index b03e59fa0834b..6363002d48d46 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -566,6 +566,20 @@ zl3073x_dev_ref_states_update(struct zl3073x_dev *zldev)
 	}
 }
 
+static void
+zl3073x_dev_chan_states_update(struct zl3073x_dev *zldev)
+{
+	int i, rc;
+
+	for (i = 0; i < zldev->info->num_channels; i++) {
+		rc = zl3073x_chan_state_update(zldev, i);
+		if (rc)
+			dev_warn(zldev->dev,
+				 "Failed to get DPLL%u state: %pe\n", i,
+				 ERR_PTR(rc));
+	}
+}
+
 /**
  * zl3073x_ref_phase_offsets_update - update reference phase offsets
  * @zldev: pointer to zl3073x_dev structure
@@ -691,6 +705,9 @@ zl3073x_dev_periodic_work(struct kthread_work *work)
 	/* Update input references' states */
 	zl3073x_dev_ref_states_update(zldev);
 
+	/* Update DPLL channels' states */
+	zl3073x_dev_chan_states_update(zldev);
+
 	/* Update DPLL-to-connected-ref phase offsets registers */
 	rc = zl3073x_ref_phase_offsets_update(zldev, -1);
 	if (rc)
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index f56f073e57df4..49e3f9f130848 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -258,28 +258,16 @@ zl3073x_dpll_input_pin_frequency_set(const struct dpll_pin *dpll_pin,
 static int
 zl3073x_dpll_selected_ref_get(struct zl3073x_dpll *zldpll, u8 *ref)
 {
-	struct zl3073x_dev *zldev = zldpll->dev;
 	const struct zl3073x_chan *chan;
-	u8 state, value;
-	int rc;
 
-	chan = zl3073x_chan_state_get(zldev, zldpll->id);
+	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
 
 	switch (zl3073x_chan_mode_get(chan)) {
 	case ZL_DPLL_MODE_REFSEL_MODE_AUTO:
-		/* For automatic mode read refsel_status register */
-		rc = zl3073x_read_u8(zldev,
-				     ZL_REG_DPLL_REFSEL_STATUS(zldpll->id),
-				     &value);
-		if (rc)
-			return rc;
-
-		/* Extract reference state */
-		state = FIELD_GET(ZL_DPLL_REFSEL_STATUS_STATE, value);
-
 		/* Return the reference only if the DPLL is locked to it */
-		if (state == ZL_DPLL_REFSEL_STATUS_STATE_LOCK)
-			*ref = FIELD_GET(ZL_DPLL_REFSEL_STATUS_REFSEL, value);
+		if (zl3073x_chan_refsel_state_get(chan) ==
+		    ZL_DPLL_REFSEL_STATUS_STATE_LOCK)
+			*ref = zl3073x_chan_refsel_ref_get(chan);
 		else
 			*ref = ZL3073X_DPLL_REF_NONE;
 		break;
@@ -1089,12 +1077,9 @@ zl3073x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
 			     struct netlink_ext_ack *extack)
 {
 	struct zl3073x_dpll *zldpll = dpll_priv;
-	struct zl3073x_dev *zldev = zldpll->dev;
 	const struct zl3073x_chan *chan;
-	u8 mon_status, state;
-	int rc;
 
-	chan = zl3073x_chan_state_get(zldev, zldpll->id);
+	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
 
 	switch (zl3073x_chan_mode_get(chan)) {
 	case ZL_DPLL_MODE_REFSEL_MODE_FREERUN:
@@ -1107,16 +1092,9 @@ zl3073x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
 		break;
 	}
 
-	/* Read DPLL monitor status */
-	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MON_STATUS(zldpll->id),
-			     &mon_status);
-	if (rc)
-		return rc;
-	state = FIELD_GET(ZL_DPLL_MON_STATUS_STATE, mon_status);
-
-	switch (state) {
+	switch (zl3073x_chan_lock_state_get(chan)) {
 	case ZL_DPLL_MON_STATUS_STATE_LOCK:
-		if (FIELD_GET(ZL_DPLL_MON_STATUS_HO_READY, mon_status))
+		if (zl3073x_chan_is_ho_ready(chan))
 			*status = DPLL_LOCK_STATUS_LOCKED_HO_ACQ;
 		else
 			*status = DPLL_LOCK_STATUS_LOCKED;
@@ -1126,8 +1104,9 @@ zl3073x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
 		*status = DPLL_LOCK_STATUS_HOLDOVER;
 		break;
 	default:
-		dev_warn(zldev->dev, "Unknown DPLL monitor status: 0x%02x\n",
-			 mon_status);
+		dev_warn(zldpll->dev->dev,
+			 "Unknown DPLL monitor status: 0x%02x\n",
+			 chan->mon_status);
 		*status = DPLL_LOCK_STATUS_UNLOCKED;
 		break;
 	}
-- 
2.52.0


