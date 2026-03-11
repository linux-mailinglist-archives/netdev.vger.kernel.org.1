Return-Path: <netdev+bounces-266753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE8dBeC8sWmxEwAAu9opvQ
	(envelope-from <netdev+bounces-266753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:05:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A52326903A
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6E97321B531
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C00C2D3A75;
	Wed, 11 Mar 2026 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLZYiPPJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BB62C0285
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773255694; cv=none; b=dffs3TJZbc2HMN53Ol99/s105VwkhSeWP4ki5lFgVlO8F37mnuoA0n/2EOr+ZWZk1vOSyJDUoclhrtH5DYP87f1lVFC24jv2qTEshAMEQ0DCO47cnOa7xja9yFIiH4VXj2LXt5dgyamoBbNFvYkCLj7qLkvlcXpnh7mWGPE37FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773255694; c=relaxed/simple;
	bh=oG7rvCoOKXKwMnAzaUaK9nccyKQrhw1VQFUTsP5pPck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcGI/mw4+llR2aLAx1lcQnzV0E3bs6t8MnGuxwkPGAMWO97JKHcgifXZaBlK4v+RAkUOu+Ns0JiqSi2e49TgDxAqv00aoYdLSfHTVGl7+S9sKHKQ4V6CJAMT/uDNobdXef1Nf1zFUsrxvJNTUq+c7YWIi9uLWg5ZU/HSTksElxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jLZYiPPJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773255691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xua4qw+59Vj5kyryE6cUo10utHZ6qVhM/FuQe5mMHCU=;
	b=jLZYiPPJ4Q3nMisySHqj89X+Dhn7X9lOVrYZrGknnudbMUFO2rzQF3+sEYHUdshNQxVdwy
	wIBQsXgjnBIUOdG0tOSg2x9pPKziLAPK5yfYnI3+lYoD0i7Ckz+LgDsmzXmazA9ESHh8Nn
	FYxSFyH+DmTqNQzqndkWDPKojo6nSqc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-YQ-44fIGMoe8Kmmb5glz-Q-1; Wed,
 11 Mar 2026 15:01:28 -0400
X-MC-Unique: YQ-44fIGMoe8Kmmb5glz-Q-1
X-Mimecast-MFC-AGG-ID: YQ-44fIGMoe8Kmmb5glz-Q_1773255683
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA7691956067;
	Wed, 11 Mar 2026 19:01:22 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.49])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED50E30002D2;
	Wed, 11 Mar 2026 19:01:19 +0000 (UTC)
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
Subject: [PATCH net-next 6/6] dpll: zl3073x: drop selected and simplify connected ref getter
Date: Wed, 11 Mar 2026 20:00:55 +0100
Message-ID: <20260311190055.139006-7-ivecera@redhat.com>
In-Reply-To: <20260311190055.139006-1-ivecera@redhat.com>
References: <20260311190055.139006-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-266753-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6A52326903A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The HW reports the currently selected reference in the
dpll_refsel_status register regardless of the DPLL mode. Use this to
delete zl3073x_dpll_selected_ref_get() and have callers read the
register directly via the cached channel state.

Simplify zl3073x_dpll_connected_ref_get() to check refsel_state for
LOCK directly and return the reference index, changing the return
type from int to u8. The redundant ref_is_status_ok check is removed
since the DPLL cannot be in LOCK state with a failed reference.

In zl3073x_dpll_mode_set(), replace the selected_ref_get() call with
zl3073x_chan_refsel_ref_get() to read the currently selected
reference directly from the cached channel state.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 94 +++++++------------------------------
 1 file changed, 18 insertions(+), 76 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 31e4ccff96d89..8a85e8be2d829 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -243,72 +243,27 @@ zl3073x_dpll_input_pin_frequency_set(const struct dpll_pin *dpll_pin,
 	return zl3073x_ref_state_set(zldev, ref_id, &ref);
 }
 
-/**
- * zl3073x_dpll_selected_ref_get - get currently selected reference
- * @zldpll: pointer to zl3073x_dpll
- * @ref: place to store selected reference
- *
- * Check for currently selected reference the DPLL should be locked to
- * and stores its index to given @ref.
- *
- * Return: 0 on success, <0 on error
- */
-static int
-zl3073x_dpll_selected_ref_get(struct zl3073x_dpll *zldpll, u8 *ref)
-{
-	const struct zl3073x_chan *chan;
-
-	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
-
-	switch (zl3073x_chan_mode_get(chan)) {
-	case ZL_DPLL_MODE_REFSEL_MODE_AUTO:
-		/* Return the reference only if the DPLL is locked to it */
-		if (zl3073x_chan_refsel_state_get(chan) ==
-		    ZL_DPLL_REFSEL_STATUS_STATE_LOCK)
-			*ref = zl3073x_chan_refsel_ref_get(chan);
-		else
-			*ref = ZL3073X_DPLL_REF_NONE;
-		break;
-	case ZL_DPLL_MODE_REFSEL_MODE_REFLOCK:
-		/* For manual mode return stored value */
-		*ref = zl3073x_chan_ref_get(chan);
-		break;
-	default:
-		/* For other modes like NCO, freerun... there is no input ref */
-		*ref = ZL3073X_DPLL_REF_NONE;
-		break;
-	}
-
-	return 0;
-}
-
 /**
  * zl3073x_dpll_connected_ref_get - get currently connected reference
  * @zldpll: pointer to zl3073x_dpll
- * @ref: place to store selected reference
  *
- * Looks for currently connected the DPLL is locked to and stores its index
- * to given @ref.
+ * Looks for currently connected reference the DPLL is locked to.
  *
- * Return: 0 on success, <0 on error
+ * Return: reference index if locked, ZL3073X_DPLL_REF_NONE otherwise
  */
-static int
-zl3073x_dpll_connected_ref_get(struct zl3073x_dpll *zldpll, u8 *ref)
+static u8
+zl3073x_dpll_connected_ref_get(struct zl3073x_dpll *zldpll)
 {
-	struct zl3073x_dev *zldev = zldpll->dev;
-	int rc;
-
-	/* Get currently selected input reference */
-	rc = zl3073x_dpll_selected_ref_get(zldpll, ref);
-	if (rc)
-		return rc;
+	const struct zl3073x_chan *chan = zl3073x_chan_state_get(zldpll->dev,
+								 zldpll->id);
+	u8 state;
 
-	/* If the monitor indicates an error nothing is connected */
-	if (ZL3073X_DPLL_REF_IS_VALID(*ref) &&
-	    !zl3073x_dev_ref_is_status_ok(zldev, *ref))
-		*ref = ZL3073X_DPLL_REF_NONE;
+	/* A reference is connected only when the DPLL is locked to it */
+	state = zl3073x_chan_refsel_state_get(chan);
+	if (state == ZL_DPLL_REFSEL_STATUS_STATE_LOCK)
+		return zl3073x_chan_refsel_ref_get(chan);
 
-	return 0;
+	return ZL3073X_DPLL_REF_NONE;
 }
 
 static int
@@ -324,12 +279,9 @@ zl3073x_dpll_input_pin_phase_offset_get(const struct dpll_pin *dpll_pin,
 	const struct zl3073x_ref *ref;
 	u8 conn_id, ref_id;
 	s64 ref_phase;
-	int rc;
 
 	/* Get currently connected reference */
-	rc = zl3073x_dpll_connected_ref_get(zldpll, &conn_id);
-	if (rc)
-		return rc;
+	conn_id = zl3073x_dpll_connected_ref_get(zldpll);
 
 	/* Report phase offset only for currently connected pin if the phase
 	 * monitor feature is disabled and only if the input pin signal is
@@ -367,7 +319,7 @@ zl3073x_dpll_input_pin_phase_offset_get(const struct dpll_pin *dpll_pin,
 
 	*phase_offset = ref_phase * DPLL_PHASE_OFFSET_DIVIDER;
 
-	return rc;
+	return 0;
 }
 
 static int
@@ -447,18 +399,13 @@ zl3073x_dpll_ref_state_get(struct zl3073x_dpll_pin *pin,
 	struct zl3073x_dpll *zldpll = pin->dpll;
 	struct zl3073x_dev *zldev = zldpll->dev;
 	const struct zl3073x_chan *chan;
-	u8 ref, ref_conn;
-	int rc;
+	u8 ref;
 
 	chan = zl3073x_chan_state_get(zldev, zldpll->id);
 	ref = zl3073x_input_pin_ref_get(pin->id);
 
-	/* Get currently connected reference */
-	rc = zl3073x_dpll_connected_ref_get(zldpll, &ref_conn);
-	if (rc)
-		return rc;
-
-	if (ref == ref_conn) {
+	/* Check if the pin reference is connected */
+	if (ref == zl3073x_dpll_connected_ref_get(zldpll)) {
 		*state = DPLL_PIN_STATE_CONNECTED;
 		return 0;
 	}
@@ -1087,13 +1034,8 @@ zl3073x_dpll_mode_set(const struct dpll_device *dpll, void *dpll_priv,
 	u8 hw_mode, ref;
 	int rc;
 
-	rc = zl3073x_dpll_selected_ref_get(zldpll, &ref);
-	if (rc) {
-		NL_SET_ERR_MSG_MOD(extack, "failed to get selected reference");
-		return rc;
-	}
-
 	chan = *zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+	ref = zl3073x_chan_refsel_ref_get(&chan);
 
 	if (mode == DPLL_MODE_MANUAL) {
 		/* We are switching from automatic to manual mode:
-- 
2.52.0


