Return-Path: <netdev+bounces-305911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /BqgNbCDTmodOQIAu9opvQ
	(envelope-from <netdev+bounces-305911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:06:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5647729037
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:06:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=euAIQBpm;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305911-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305911-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C5E3302FD5C
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 17:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650EB48A2B5;
	Wed,  8 Jul 2026 17:06:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A25480345
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 17:06:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530364; cv=none; b=HQTLikcEy8aquRw1ubYHyC4Q2l0SkE2LLAykmGKzM9kGYV4QDd/Cbbs6iOQc3XpzyRlfU8ZrsXZI3ktDqx7QH95PCBFeZPO9Rh7TNH9DGc3vo7ANrjI0VVJFKU5xwcxekDIlNT/04Ck+O82zntcl2pzJuf+lC0oas+Wd8cZb0yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530364; c=relaxed/simple;
	bh=H8bS1UFcnh/B7Biwahrore8Hq8sO6eq3rX2IEexuido=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+czMUrtFsITd41yBYMMuMbHulWVJWmkIPcNSu9S21TD9Y3TmM4Ql0XZ1Z3UhViGlksY6LgtNZQrIyEUBbp1i5YT3O2C/Gyq2oC9y6idkGcS1tjnOUdcUOz5GPfsF3pkTWpRrhLa/NZYAV+veJvzS/0T056Q9oHWYSm+muWvmMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=euAIQBpm; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783530361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHOAO6887vyjzWADp1OM6I7eeGX81KOA8UHyeKOZU70=;
	b=euAIQBpmls1ofd30wbmev9mySh9jEVs+05xpCforpGbdpN43i53ZTdIsDxpWQZkRQYyAsd
	vnA3Vq47WkMXIS0xL6d+T2MYISySAH30SCj7yMd/Q4gP6hSagmNpcvUQXu1MIwxoZWtcHu
	Y/nb33Twkdk8Mt+FLRxLB9bpVhyRhSg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-Nxx7q8_JPtahZDv1eflEjA-1; Wed,
 08 Jul 2026 13:05:58 -0400
X-MC-Unique: Nxx7q8_JPtahZDv1eflEjA-1
X-Mimecast-MFC-AGG-ID: Nxx7q8_JPtahZDv1eflEjA_1783530356
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C64951800844;
	Wed,  8 Jul 2026 17:05:56 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.50.138])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5973F195606C;
	Wed,  8 Jul 2026 17:05:51 +0000 (UTC)
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
Subject: [PATCH net-next 4/4] dpll: zl3073x: add PTP clock adjphase and TIE support
Date: Wed,  8 Jul 2026 19:05:27 +0200
Message-ID: <20260708170527.916035-5-ivecera@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[microchip.com,intel.com,davemloft.net,kernel.org,resnulli.us,redhat.com,gmail.com,linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305911-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5647729037

Add adjphase and getmaxphase PTP callbacks using TIE write for
sub-picosecond phase adjustment in AUTO and REFLOCK modes.

Extend the adjtime callback to handle non-NCO modes: in AUTO/REFLOCK
modes the sub-second remainder is applied via TIE write instead of
phase step. In modes that support neither, the full adjustment falls
back to ToD read-modify-write.

Remove the NCO-only gate from PTP clock registration since the PTP
clock now provides useful operations in all modes. Add a mode check
to adjfine so it returns -EOPNOTSUPP when not in NCO mode.

Tested-by: Chris du Quesnay <Chris.duQuesnay@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 102 +++++++++++++++++++++++++++---------
 1 file changed, 78 insertions(+), 24 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 86770dea3d652..74001e6d4a32f 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -2489,10 +2489,13 @@ static int zl3073x_dpll_ptp_adjtime_phase_step(struct zl3073x_dpll *zldpll,
  * @info: PTP clock info
  * @delta: time adjustment in nanoseconds
  *
- * For large deltas (>= 1 second), the seconds part is adjusted via ToD
- * read-modify-write at 1 Hz boundaries and the sub-second remainder via
- * output phase step. For sub-second deltas, uses phase step directly.
- * Falls back to full ToD read-modify-write if phase step is unavailable.
+ * In NCO mode, large deltas (>= 1 second) are split into a ToD
+ * read-modify-write for the seconds part and an output phase step for
+ * the sub-second remainder. Sub-second deltas use phase step directly,
+ * falling back to ToD read-modify-write if phase step is unavailable.
+ * In AUTO/REFLOCK modes, large deltas are split into ToD
+ * read-modify-write for seconds and TIE write for the sub-second
+ * remainder. Sub-second deltas use TIE write directly.
  *
  * Return: 0 on success, <0 on error
  */
@@ -2501,6 +2504,7 @@ static int zl3073x_dpll_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
 	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
 						   ptp_info);
 	struct zl3073x_dev *zldev = zldpll->dev;
+	const struct zl3073x_chan *chan;
 	bool sec_adjusted = false;
 	struct timespec64 ts;
 	int rc;
@@ -2510,8 +2514,16 @@ static int zl3073x_dpll_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
 
 	guard(mutex)(&zldpll->lock);
 
+	/* Modes without phase step or TIE use plain ToD adjust */
+	chan = zl3073x_chan_state_get(zldev, zldpll->id);
+	if (!zl3073x_chan_mode_is_nco(chan) &&
+	    !zl3073x_chan_mode_supports_tie(chan))
+		return zl3073x_chan_tod_adjust(zldev, zldpll->id,
+					       ns_to_timespec64(delta));
+
 	/* Split off seconds via ToD read-modify-write so the sub-second
-	 * remainder can be applied through the output-coherent phase step.
+	 * remainder can be applied through the output-coherent mechanism
+	 * (phase step or TIE write).
 	 */
 	if (abs(delta) >= NSEC_PER_SEC) {
 		s32 remainder;
@@ -2531,19 +2543,26 @@ static int zl3073x_dpll_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
 			return 0;
 	}
 
-	rc = zl3073x_dpll_ptp_adjtime_phase_step(zldpll, delta);
-	if (!rc)
-		return 0;
+	/* Apply sub-second delta via phase step (NCO) or TIE write */
+	if (zl3073x_chan_mode_is_nco(chan)) {
+		rc = zl3073x_dpll_ptp_adjtime_phase_step(zldpll, delta);
+		if (!rc)
+			return 0;
+	} else {
+		rc = zl3073x_chan_tie_write(zldev, zldpll->id, delta);
+		if (!rc)
+			return 0;
+	}
 
-	/* Phase step failed or unavailable, fall back to ToD adjust */
+	/* Phase step or TIE write failed, fall back to ToD adjust */
 	rc = zl3073x_chan_tod_adjust(zldev, zldpll->id,
 				     ns_to_timespec64(delta));
 
-	/* In the unlikely event that both phase step and fallback ToD adjust
-	 * fail after seconds were already committed, return success to prevent
-	 * the PTP servo from retrying the full delta and applying seconds
-	 * again. The sub-second residual will self-correct in the next servo
-	 * cycle.
+	/* In the unlikely event that both phase step/TIE write and fallback
+	 * ToD adjust fail after seconds were already committed, return
+	 * success to prevent the PTP servo from retrying the full delta and
+	 * applying seconds again. The sub-second residual will self-correct
+	 * in the next servo cycle.
 	 */
 	if (rc && sec_adjusted) {
 		dev_warn(zldev->dev,
@@ -2559,9 +2578,9 @@ static int zl3073x_dpll_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
  * @info: PTP clock info
  * @scaled_ppm: frequency adjustment in scaled ppm (ppm * 2^16)
  *
- * Writes the delta frequency offset register.
+ * Only supported in NCO mode. Writes the delta frequency offset register.
  *
- * Return: 0 on success, <0 on error
+ * Return: 0 on success, -EOPNOTSUPP if not in NCO mode, <0 on error
  */
 static int
 zl3073x_dpll_ptp_adjfine(struct ptp_clock_info *info, long scaled_ppm)
@@ -2583,12 +2602,53 @@ zl3073x_dpll_ptp_adjfine(struct ptp_clock_info *info, long scaled_ppm)
 	guard(mutex)(&zldpll->lock);
 
 	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+	if (!zl3073x_chan_mode_is_nco(chan))
+		return scaled_ppm ? -EOPNOTSUPP : 0;
 	if (offset == chan->df_offset)
 		return 0;
 
 	return zl3073x_chan_df_offset_set(zldpll->dev, zldpll->id, offset);
 }
 
+/**
+ * zl3073x_dpll_ptp_adjphase - adjust PTP clock phase
+ * @info: PTP clock info
+ * @delta: phase adjustment in nanoseconds
+ *
+ * Only supported in AUTO and REFLOCK modes. Uses TIE write for
+ * nanosecond resolution phase adjustment.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if mode doesn't support TIE, <0 on error
+ */
+static int zl3073x_dpll_ptp_adjphase(struct ptp_clock_info *info, s32 delta)
+{
+	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
+						   ptp_info);
+	struct zl3073x_dev *zldev = zldpll->dev;
+	const struct zl3073x_chan *chan;
+
+	if (!delta)
+		return 0;
+
+	guard(mutex)(&zldpll->lock);
+
+	chan = zl3073x_chan_state_get(zldev, zldpll->id);
+
+	if (!zl3073x_chan_mode_supports_tie(chan))
+		return -EOPNOTSUPP;
+
+	return zl3073x_chan_tie_write(zldev, zldpll->id, delta);
+}
+
+static s32
+zl3073x_dpll_ptp_getmaxphase(struct ptp_clock_info *info __always_unused)
+{
+	/* HW limits TIE write to +-1 second. Return the constant HW
+	 * limit and let adjphase handle mode-specific checks.
+	 */
+	return NSEC_PER_SEC - 1;
+}
+
 /**
  * zl3073x_dpll_ptp_perout_find_pin - find pin by perout channel index
  * @zldpll: DPLL channel
@@ -2678,6 +2738,8 @@ static const struct ptp_clock_info zl3073x_dpll_ptp_clock_info = {
 	.settime64	= zl3073x_dpll_ptp_settime64,
 	.adjtime	= zl3073x_dpll_ptp_adjtime,
 	.adjfine	= zl3073x_dpll_ptp_adjfine,
+	.adjphase	= zl3073x_dpll_ptp_adjphase,
+	.getmaxphase	= zl3073x_dpll_ptp_getmaxphase,
 	.enable		= zl3073x_dpll_ptp_enable,
 };
 
@@ -2685,21 +2747,13 @@ static const struct ptp_clock_info zl3073x_dpll_ptp_clock_info = {
  * zl3073x_dpll_ptp_register - register PTP clock for a DPLL channel
  * @zldpll: DPLL channel to register PTP clock for
  *
- * PTP clock is only registered when the channel is in NCO mode.
- * If the channel is not in NCO mode, this is a no-op.
- *
  * Return: 0 on success, <0 on error
  */
 static int zl3073x_dpll_ptp_register(struct zl3073x_dpll *zldpll)
 {
 	struct zl3073x_dev *zldev = zldpll->dev;
-	const struct zl3073x_chan *chan;
 	struct ptp_clock *ptp_clock;
 
-	chan = zl3073x_chan_state_get(zldev, zldpll->id);
-	if (!zl3073x_chan_mode_is_nco(chan))
-		return 0;
-
 	snprintf(zldpll->ptp_info.name, sizeof(zldpll->ptp_info.name),
 		 "zl3073x-dpll%u", zldpll->id);
 
-- 
2.53.0


