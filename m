Return-Path: <netdev+bounces-271620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMaJLZ7+w2lXvQQAu9opvQ
	(envelope-from <netdev+bounces-271620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:26:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F338327E9A
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF3CD3281DC3
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3488234107F;
	Wed, 25 Mar 2026 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDScY74N"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE30323EAAD
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451487; cv=none; b=Sd0fb1NNri2r8mbkw5KI5Oqtd6zlzYlWKQ3DoM9t8V4ooVq2lvzC7ETqsNq4BfEkEEG1F757YorMWt9UMSoq5QsboQ5yYlycHUJxTq7nfE++jQ+UBc3pWwxjwNcVkUGScg/oLKoTEndeQEhn0YszHbEO1WNYctKM7pE3FeAgwlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451487; c=relaxed/simple;
	bh=WFQAyjaLM4KVhrZUNNxuTCai/SGkmdrTFo0QZenHJOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dCNNwnF5gOYTRRDyQAxI5A0wJUWddUm68vAIbH0O7yiMGbwU+j1a9D1ibCcC402QhPQ1oLXRW3qSxnOVeoiJpKhtu9ihJO4hhcBr/A6o8ZCVguMvQ1tLfgYTV+GK9VXWYPio82dVQLFnHc0xilXSR+Yk48XoGMg7x+rn5lE29oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hDScY74N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774451484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jbo0Ad/kP5wlt8QZq7dLLcRaxS2hXarbNY4mrADEEb4=;
	b=hDScY74NReOZsKRlo+xbyx4JI4jZkTOq3h9392wli9n3xkEG+bZQzzG+vf3DLrAtAAr46J
	AgGxk9n6XBG33Kpor4dQ7R3GKrKG2GbecGchfbijhwSVX7Fyv9XBV3iYSEduaLQX0WGNU4
	P3oEqWbOpBgYihxGDq6VwPrPYg36lqE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-xN6BkXvYN_6RTTSwpmcFdA-1; Wed,
 25 Mar 2026 11:11:19 -0400
X-MC-Unique: xN6BkXvYN_6RTTSwpmcFdA-1
X-Mimecast-MFC-AGG-ID: xN6BkXvYN_6RTTSwpmcFdA_1774451475
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C04B180894D;
	Wed, 25 Mar 2026 15:11:11 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.45.224.50])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C72C43000223;
	Wed, 25 Mar 2026 15:11:06 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Michal Michalik <michal.michalik@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net] ice: fix U.FL pin state set affecting paired SMA pin
Date: Wed, 25 Mar 2026 16:10:50 +0100
Message-ID: <20260325151050.2081977-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271620-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F338327E9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When setting a U.FL pin to disconnected state, ice_dpll_ufl_pin_state_set()
blindly modifies SMA control register bits and disables the shared
underlying output/input pin without checking whether the U.FL pin is
currently active.

SMA1 and U.FL1 share the same physical output pin, controlled by
ICE_SMA1_DIR_EN and ICE_SMA1_TX_EN bits. When SMA1 is in output mode
(DIR_EN=1, TX_EN=0), U.FL1 is already inactive. Disconnecting U.FL1
sets TX_EN=1, which combined with DIR_EN=1 causes
ice_dpll_sw_pins_update() to mark SMA1 as inactive too. The subsequent
ice_dpll_pin_disable() then disables the shared output pin entirely,
breaking SMA1's connection.

Fix by checking whether U.FL1/U.FL2 is already inactive before
proceeding with the disconnect. If the pin is not currently controlling
the shared output/input, return success immediately without modifying
the SMA control register or disabling the underlying pin.

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 5cfa19da099bfc..76c68f54a1cc97 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1253,6 +1253,14 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 			data &= ~ICE_SMA1_MASK;
 			enable = true;
 		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
+			/* Skip if U.FL1 is not active, setting TX_EN
+			 * while DIR_EN is set would also deactivate
+			 * the paired SMA1 output.
+			 */
+			if (data & (ICE_SMA1_DIR_EN | ICE_SMA1_TX_EN)) {
+				ret = 0;
+				goto unlock;
+			}
 			data |= ICE_SMA1_TX_EN;
 			enable = false;
 		} else {
@@ -1267,6 +1275,15 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 			data &= ~ICE_SMA2_UFL2_RX_DIS;
 			enable = true;
 		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
+			/* Skip if U.FL2 is not active, setting
+			 * UFL2_RX_DIS could also disable the paired
+			 * SMA2 input.
+			 */
+			if (!(data & ICE_SMA2_DIR_EN) ||
+			    (data & ICE_SMA2_UFL2_RX_DIS)) {
+				ret = 0;
+				goto unlock;
+			}
 			data |= ICE_SMA2_UFL2_RX_DIS;
 			enable = false;
 		} else {
-- 
2.52.0


