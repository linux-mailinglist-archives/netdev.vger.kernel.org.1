Return-Path: <netdev+bounces-276447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMApESs31mlZBwgAu9opvQ
	(envelope-from <netdev+bounces-276447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:08:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E323BB16B
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37B0F301DA56
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 11:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BF337F72B;
	Wed,  8 Apr 2026 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/OFrS5V"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8EC37BE71
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775646499; cv=none; b=HMXzaSQSsaPjHeAYlm7hBHxou9x40dMoe/WAfNuEh4Nvb1DtrASa1SMx/6qUVoqdOjRU6JIMvF6g3n2qeHB/9Dcq+Dg2g1YeYw/TNlsY6q6driKRN8W+QX3LzBoVs0UHoedPIIIfkCL/Z+nGK3vuQIQxRqw8VkAihLtOqAwQ6fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775646499; c=relaxed/simple;
	bh=XIo/YwY1I7tCOlr+w5JwdgVzbYG6CBoE7ZT3BId8Gns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M2D3gU9aDmaHxCwTwjNbsCFa3XvuJT8DhkCINuZGQUAucMMwfhaSI58e9mvpm+/1icU9GqysJ13MwEX6w+cpqdeuUowUzXBsJqcqP83U3lcgS2zGCmIluwK/WxDPj7DfAM3qvPJHDLZN/IkwUW5OamSDkV+O8upPD4sCQv6G6qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f/OFrS5V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775646497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eHfeMlveuGcx7hW6Gtzk+PwguxJpEiOHLrc6d7D9JwM=;
	b=f/OFrS5VA9qaymRI1I0oU0aMz1maC6OtW5psMhhyX74u9wdkZ+gmescfmNeqxwvSl9ZQsa
	N05vZJQIF/w8zooptsF8QoxRH6SgliFjF1QsznaZxhZAYzMCYvNjF7xQIIrUdwpqaNepYD
	qqnROZ86XLb5vLP6ewyFulmTSLYEOHI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-uv3yoqhQMdeNODp07RMQCA-1; Wed,
 08 Apr 2026 07:08:12 -0400
X-MC-Unique: uv3yoqhQMdeNODp07RMQCA-1
X-Mimecast-MFC-AGG-ID: uv3yoqhQMdeNODp07RMQCA_1775646490
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36615195605C;
	Wed,  8 Apr 2026 11:08:10 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.48.174])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 45FF81955D84;
	Wed,  8 Apr 2026 11:08:05 +0000 (UTC)
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
	Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net v2] ice: fix SMA and U.FL pin state changes affecting paired pin
Date: Wed,  8 Apr 2026 13:05:04 +0200
Message-ID: <20260408110504.1032879-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276447-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2E323BB16B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SMA and U.FL pins share physical signal paths in pairs (SMA1/U.FL1 and
SMA2/U.FL2) controlled by the PCA9575 GPIO expander.  Each pair can
only have one active pin at a time: SMA1 output and U.FL1 output share
the same CGU output, SMA2 input and U.FL2 input share the same CGU
input.  The PCA9575 register bits determine which connector in each
pair owns the signal path.

The driver does not account for this pairing in two places:

ice_dpll_ufl_pin_state_set() modifies PCA9575 bits and disables the
backing CGU pin without checking whether the U.FL pin is currently
active.  Disconnecting an already inactive U.FL pin flips bits that
the paired SMA pin relies on, breaking its connection.

ice_dpll_sma_direction_set() does not propagate direction changes to
the paired U.FL pin.  For SMA2/U.FL2 the ICE_SMA2_UFL2_RX_DIS bit is
never managed, so U.FL2 stays disconnected after SMA2 switches to
output.  For both pairs the backing CGU pin of the U.FL side is never
enabled when a direction change activates it, so userspace sees the
pin as disconnected even though the routing is correct.

Fix by guarding the U.FL disconnect path against inactive pins and by
updating the paired U.FL pin fully on SMA direction changes: manage
ICE_SMA2_UFL2_RX_DIS for the SMA2/U.FL2 pair and enable the backing
CGU pin whenever the peer becomes active.

Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v2:
 - fix ice_dpll_sma_direction_set() to manage ICE_SMA2_UFL2_RX_DIS
   when SMA2 direction changes
 - enable paired U.FL backing CGU pin when direction change makes
   it active, so it reports as connected immediately
 - (both reported by Intel test on the SMA init and notification
   patch threads)
v1: https://lore.kernel.org/all/20260325151050.2081977-1-poros@redhat.com/
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 50 ++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 498ec2c045f384..3f8cd5b8298b57 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1171,6 +1171,8 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 				      enum dpll_pin_direction direction,
 				      struct netlink_ext_ack *extack)
 {
+	struct ice_dplls *d = &p->pf->dplls;
+	struct ice_dpll_pin *peer;
 	u8 data;
 	int ret;
 
@@ -1189,8 +1191,9 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 	case ICE_DPLL_PIN_SW_2_IDX:
 		if (direction == DPLL_PIN_DIRECTION_INPUT) {
 			data &= ~ICE_SMA2_DIR_EN;
+			data |= ICE_SMA2_UFL2_RX_DIS;
 		} else {
-			data &= ~ICE_SMA2_TX_EN;
+			data &= ~(ICE_SMA2_TX_EN | ICE_SMA2_UFL2_RX_DIS);
 			data |= ICE_SMA2_DIR_EN;
 		}
 		break;
@@ -1202,6 +1205,34 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 		ret = ice_dpll_pin_state_update(p->pf, p,
 						ICE_DPLL_PIN_TYPE_SOFTWARE,
 						extack);
+	if (ret)
+		return ret;
+
+	/* When a direction change activates the paired U.FL pin, enable
+	 * its backing CGU pin so the pin reports as connected. Without
+	 * this the U.FL routing is correct but the CGU pin stays disabled
+	 * and userspace sees the pin as disconnected.  Do not disable the
+	 * backing pin when U.FL becomes inactive because the SMA pin may
+	 * still be using it.
+	 */
+	peer = &d->ufl[p->idx];
+	if (peer->active) {
+		struct ice_dpll_pin *target;
+		enum ice_dpll_pin_type type;
+
+		if (peer->output) {
+			target = peer->output;
+			type = ICE_DPLL_PIN_TYPE_OUTPUT;
+		} else {
+			target = peer->input;
+			type = ICE_DPLL_PIN_TYPE_INPUT;
+		}
+		ret = ice_dpll_pin_enable(&p->pf->hw, target,
+					  d->eec.dpll_idx, type, extack);
+		if (!ret)
+			ret = ice_dpll_pin_state_update(p->pf, target,
+							type, extack);
+	}
 
 	return ret;
 }
@@ -1253,6 +1284,14 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
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
@@ -1267,6 +1306,15 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
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


