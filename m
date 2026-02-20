Return-Path: <netdev+bounces-259723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI6iGhFrmGn4IAMAu9opvQ
	(envelope-from <netdev+bounces-259723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 15:09:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D78E1682D3
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 15:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A71BC302F997
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1941434C124;
	Fri, 20 Feb 2026 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoExOIj/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A434B697
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771596554; cv=none; b=bwH3ocnwCxzFYcLaybeV8Y1e+2yaplqSeBup9lmvWipebEJZfex+MF/kcp4voAPwPIZkej7WkPPN8YCBos7Z2eEONlVU/0gAp2otcoGBWtT7Iy3UMdHiy7CEe51DumtLeg3HwcFAsYxMm1+ejZuejjoK0wZ9knFtPCwrBEo7bbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771596554; c=relaxed/simple;
	bh=2Is8BBPkbUnDVr+QWhtNfhLEsAn7u2IviBcT/OtwIr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HeubB7kd5Tev9B1K8bh19fjU2y0NgzY50Qpc6WChn1Rlj4WXT3RAduG4XLzXFZLWyuNujBFCBI8GX+RKH7p5yfATQkEkbALDL6GN+m4s0vg5s2flm/ZpC7OYDiE7XHpixY4nZZqY9kiMhImIJ+n2510CUSDB4ot/8Q3oqKWFq7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DoExOIj/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771596552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u9HFZ3wYiKgrM2IQhKwmMk6ouL5om03wQDjATLkkZss=;
	b=DoExOIj/dijo5x0H9yYnW74WNC9uvdbJ6dlGWbGnORDl2O8XTYCQ+YpBdes5YUa6scD/Lg
	m1nhezRS2gUej4yGcWQz7s+9Xz726dxUwTr1vdZaPO9I9vbg4FzCog7+ZT0KcNygleR6Ed
	SPJPFTIGVwzEXa2aaWTW92pmiVwN5Fc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-zyhEqfHvMeyU4SFqLpwb3A-1; Fri,
 20 Feb 2026 09:09:08 -0500
X-MC-Unique: zyhEqfHvMeyU4SFqLpwb3A-1
X-Mimecast-MFC-AGG-ID: zyhEqfHvMeyU4SFqLpwb3A_1771596546
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F84119001A4;
	Fri, 20 Feb 2026 14:08:03 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.59])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 61B3A1955EA0;
	Fri, 20 Feb 2026 14:07:43 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: ivecera@redhat.com,
	Petr Oros <poros@redhat.com>,
	kernel test robot <lkp@intel.com>,
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
Subject: [PATCH iwl-net v3] ice: fix missing dpll notification for SW pins
Date: Fri, 20 Feb 2026 15:07:00 +0100
Message-ID: <20260220140700.2910174-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259723-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email]
X-Rspamd-Queue-Id: 1D78E1682D3
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
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602200046.SGwK2tWh-lkp@intel.com/
Signed-off-by: Petr Oros <poros@redhat.com>
---
v3:
- Add kdoc for the helper.
v2:
- Extract ice_dpll_sw_pin_needs_notify() helper for readability,
- Move loop variable into for() scope.

drivers/net/ethernet/intel/ice/ice_dpll.c | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index c2ad39bfe177db..a9db85a1026388 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2462,6 +2462,24 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
 	return pci_get_dsn(pf->pdev);
 }
 
+/**
+ * ice_dpll_sw_pin_needs_notify - check if SW pin needs change notification
+ * @p: pointer to SW pin (SMA or U.FL)
+ * @active: currently active input pin (or NULL)
+ * @old: previously active input pin (or NULL)
+ *
+ * Return: true if the SW pin is an input whose backing CGU pin matches either
+ * the old or new active input, meaning its state has changed.
+ */
+static bool
+ice_dpll_sw_pin_needs_notify(struct ice_dpll_pin *p,
+			     struct dpll_pin *active, struct dpll_pin *old)
+{
+	return p->pin &&
+	       p->direction == DPLL_PIN_DIRECTION_INPUT &&
+	       (p->input->pin == active || p->input->pin == old);
+}
+
 /**
  * ice_dpll_notify_changes - notify dpll subsystem about changes
  * @d: pointer do dpll
@@ -2470,6 +2488,7 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
  */
 static void ice_dpll_notify_changes(struct ice_dpll *d)
 {
+	struct ice_dplls *dplls = &d->pf->dplls;
 	bool pin_notified = false;
 
 	if (d->prev_dpll_state != d->dpll_state) {
@@ -2477,6 +2496,8 @@ static void ice_dpll_notify_changes(struct ice_dpll *d)
 		dpll_device_change_ntf(d->dpll);
 	}
 	if (d->prev_input != d->active_input) {
+		struct dpll_pin *old = d->prev_input;
+
 		if (d->prev_input)
 			dpll_pin_change_ntf(d->prev_input);
 		d->prev_input = d->active_input;
@@ -2484,6 +2505,14 @@ static void ice_dpll_notify_changes(struct ice_dpll *d)
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


