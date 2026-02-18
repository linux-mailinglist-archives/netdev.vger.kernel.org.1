Return-Path: <netdev+bounces-259361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PRrCd4rlmlPbwIAu9opvQ
	(envelope-from <netdev+bounces-259361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 22:15:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C3099159CDC
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 22:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00EF2300753B
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 21:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A65533439A;
	Wed, 18 Feb 2026 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRI9H51E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046A30F943
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 21:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771449308; cv=none; b=OGAkC5iuqrPo1nuG9q3qeoe3vUaAEGR55DLWlhhBeortXJqMHgtathxD3vHLGB+o1YmtwROq1U7UNRdC4tQ7jq6EbLxIInZA9G2CplFA5nHSHPKAdLZnXe2XLUeUUZMDDtML25k52mLQ64VxZYkYoboSIgetZN7j6/3sq6p+/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771449308; c=relaxed/simple;
	bh=SgZvd8Sskv0y3be4d0fIiN0IEvSgTvHHZpYtU5oVIAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bGUc7yPdQeFO115n58kUwOrUsTPpwn8OSURcgDwZtj3zLRU0jRg1yqrpBTCbY3F5RkoCFWWp2fG+jHdu218Mi1hY+jb5NsSvlqBeo+KEkE2fO6C/JMJDZAYSD2PF/iMMWpZGXrfVsL3gPdTElSHaKcensT9hbWALdZDSgzvHdJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRI9H51E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771449305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eZU4gWKyKnQkKunk/pkzGylRrazxnAm7GHvdG5YZ6SY=;
	b=hRI9H51E4tlB2V1xwUEUNIf2/Ode5I7By/9mboHICZoKE8xp4V8mbzgBD7RKA9yqlLQ99j
	CYTdzuHRvI503IQx8C80oV+MUXtj0CWnlCDAwZvJsHtv+WPgglceWHR93ug4E4YHBIwKd5
	EZD8x8DcY3/W/MPH4Uf8nsyHpT+yYkE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-vkcSGc0kMhSmxjFwUGM44w-1; Wed,
 18 Feb 2026 16:15:02 -0500
X-MC-Unique: vkcSGc0kMhSmxjFwUGM44w-1
X-Mimecast-MFC-AGG-ID: vkcSGc0kMhSmxjFwUGM44w_1771449300
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C4081955BC4;
	Wed, 18 Feb 2026 21:15:00 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.59])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 770CB180066F;
	Wed, 18 Feb 2026 21:14:56 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net] ice: fix missing dpll notification for SW pins
Date: Wed, 18 Feb 2026 22:14:14 +0100
Message-ID: <20260218211414.1411163-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259361-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3099159CDC
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

Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index c2ad39bfe177db..6f855fe4c78d62 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2470,13 +2470,17 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
  */
 static void ice_dpll_notify_changes(struct ice_dpll *d)
 {
+	struct ice_dplls *dplls = &d->pf->dplls;
 	bool pin_notified = false;
+	int i;
 
 	if (d->prev_dpll_state != d->dpll_state) {
 		d->prev_dpll_state = d->dpll_state;
 		dpll_device_change_ntf(d->dpll);
 	}
 	if (d->prev_input != d->active_input) {
+		struct dpll_pin *old = d->prev_input;
+
 		if (d->prev_input)
 			dpll_pin_change_ntf(d->prev_input);
 		d->prev_input = d->active_input;
@@ -2484,6 +2488,20 @@ static void ice_dpll_notify_changes(struct ice_dpll *d)
 			dpll_pin_change_ntf(d->active_input);
 			pin_notified = true;
 		}
+		for (i = 0; i < ICE_DPLL_PIN_SW_NUM; i++) {
+			if (dplls->sma[i].pin &&
+			    dplls->sma[i].direction ==
+			    DPLL_PIN_DIRECTION_INPUT &&
+			    (dplls->sma[i].input->pin == d->active_input ||
+			     dplls->sma[i].input->pin == old))
+				dpll_pin_change_ntf(dplls->sma[i].pin);
+			if (dplls->ufl[i].pin &&
+			    dplls->ufl[i].direction ==
+			    DPLL_PIN_DIRECTION_INPUT &&
+			    (dplls->ufl[i].input->pin == d->active_input ||
+			     dplls->ufl[i].input->pin == old))
+				dpll_pin_change_ntf(dplls->ufl[i].pin);
+		}
 	}
 	if (d->prev_phase_offset != d->phase_offset) {
 		d->prev_phase_offset = d->phase_offset;
-- 
2.52.0


