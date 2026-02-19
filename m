Return-Path: <netdev+bounces-259462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABTNAAENl2mTuAIAu9opvQ
	(envelope-from <netdev+bounces-259462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 14:15:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C6C15EF4D
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 14:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECD10300491D
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 13:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0DE1DF261;
	Thu, 19 Feb 2026 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gj6ddKej"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1A31B3925
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771506942; cv=none; b=pr7JUtQe4dMvpZi+c/dDtCtRRKTl7cXRIZ6NTYH40YIjizvjdZJGHjeNzZ9KbPxarqqqw4gis8clWXT2wxCWXLfuhpvlB/8HsbViMbvm2JFH0ze91iCBQWR3sOIou7CQr23dmP5i4Gh8tCWr3VSGzWcJVwEeCSRXlROjxgk1Clg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771506942; c=relaxed/simple;
	bh=Yt/Qne72t7ZUyx9gmAiN9PIbOHzYWhjojDp2xGX8Qf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QIbBaM3ko7UdZm83MXDiPDIINtu6AviE8nrou8Xb7KDvvF7y2arjYdLdniNJ+iJZw98SSvMr3alDya8rbNAc2LqODYM2nD+tDEszfKEkGcphxoFJxA9m4a+QJT6xS46whpDUZ1Wk3+b2A+FM4URHOduneb1CrBeRo26I5TGsb7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gj6ddKej; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771506940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8d/gcwZgVClPwsFGUuCBPxWwtUzzW80Rcoy/zgCLPmA=;
	b=gj6ddKejVNU7euqdyVtHWP2TSeXYPO2NEOB37Q42BPIyQRaRf4uBgYQEXPsqhmaniCfhqU
	wdw+3vY94KJwkAjVJmQj+uc7n5n+9SLT1sXa6E7y/d4QXj9BAmPmV/qh9Fl6RF5oq+dflw
	wwA1lcUIzL+jDP0KeweKRtYuMVuZqqM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517--NOQNMZJOUiwED6UfB8QYA-1; Thu,
 19 Feb 2026 08:15:37 -0500
X-MC-Unique: -NOQNMZJOUiwED6UfB8QYA-1
X-Mimecast-MFC-AGG-ID: -NOQNMZJOUiwED6UfB8QYA_1771506935
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7443C1956070;
	Thu, 19 Feb 2026 13:15:35 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.59])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 217DD1954111;
	Thu, 19 Feb 2026 13:15:30 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: ivecera@redhat.com,
	Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	piotr.kwapulinski@intel.com
Subject: [PATCH iwl-net v2] ice: fix missing dpll notification for SW pins
Date: Thu, 19 Feb 2026 14:15:00 +0100
Message-ID: <20260219131500.2271897-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259462-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98C6C15EF4D
X-Rspamd-Action: no action

ice_dpll_notify_changes() sends dpll_pin_change_ntf() only for the
direct CGU input pin stored in d->active_input. Software-controlled
pins (SMA/U.FL) are separate dpll_pin objects that wrap a backing CGU
input, but they never receive a change notification. As a result,
userspace consumers such as synce4l that monitor SMA pins via dpll
netlink never learn when the pin state transitions (e.g. from
SELECTABLE to CONNECTED), even though 'dpll pin show' reports the
correct state on demand.

When the active input changes, also send dpll_pin_change_ntf() for any
registered SMA/U.FL input pin whose backing CGU input matches the old
or new active input.

v2:
- Extract ice_dpll_sw_pin_needs_notify() helper for readability,
- Move loop variable into for() scope.

Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index c2ad39bfe177db..2a505d924fcbae 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2468,8 +2468,18 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
  *
  * Once change detected appropriate event is submitted to the dpll subsystem.
  */
+static bool
+ice_dpll_sw_pin_needs_notify(struct ice_dpll_pin *p,
+			     struct dpll_pin *active, struct dpll_pin *old)
+{
+	return p->pin &&
+	       p->direction == DPLL_PIN_DIRECTION_INPUT &&
+	       (p->input->pin == active || p->input->pin == old);
+}
+
 static void ice_dpll_notify_changes(struct ice_dpll *d)
 {
+	struct ice_dplls *dplls = &d->pf->dplls;
 	bool pin_notified = false;
 
 	if (d->prev_dpll_state != d->dpll_state) {
@@ -2477,6 +2487,8 @@ static void ice_dpll_notify_changes(struct ice_dpll *d)
 		dpll_device_change_ntf(d->dpll);
 	}
 	if (d->prev_input != d->active_input) {
+		struct dpll_pin *old = d->prev_input;
+
 		if (d->prev_input)
 			dpll_pin_change_ntf(d->prev_input);
 		d->prev_input = d->active_input;
@@ -2484,6 +2496,14 @@ static void ice_dpll_notify_changes(struct ice_dpll *d)
 			dpll_pin_change_ntf(d->active_input);
 			pin_notified = true;
 		}
+		for (int i = 0; i < ICE_DPLL_PIN_SW_NUM; i++) {
+			if (ice_dpll_sw_pin_needs_notify(&dplls->sma[i],
+							 d->active_input, old))
+				dpll_pin_change_ntf(dplls->sma[i].pin);
+			if (ice_dpll_sw_pin_needs_notify(&dplls->ufl[i],
+							 d->active_input, old))
+				dpll_pin_change_ntf(dplls->ufl[i].pin);
+		}
 	}
 	if (d->prev_phase_offset != d->phase_offset) {
 		d->prev_phase_offset = d->phase_offset;
-- 
2.52.0


