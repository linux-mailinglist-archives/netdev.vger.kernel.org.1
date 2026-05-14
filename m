Return-Path: <netdev+bounces-287981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APsCEdrXBWqacAIAu9opvQ
	(envelope-from <netdev+bounces-287981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:10:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A58C8542CE9
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0BAB30794CD
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0BA3F9F3D;
	Thu, 14 May 2026 14:04:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B83F3E558F;
	Thu, 14 May 2026 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767478; cv=none; b=s8NiighOMZT+dQGXkqZLCUOQ+asEXobPnrfXa/LHPCD8KWZg3q/ROXcjOT1GsaeF76feDL6cfjc6W0PtoSmHOjgWx8rRG3zHfC0re0BdBcWZme83J3q15C5gomgbmbruSAH5K+D8tBOC3ni6/cXsFlu0BRFOnQnpRMaSK5CsYzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767478; c=relaxed/simple;
	bh=bR5Pl/3eezFMUUbL5A/W+/2nfYEPaSrHHptlvVvw6mk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTR8XcpdUQhVvjDzvfZswOHKN2P04/VFnEyMW9+tant2tOtNAJamXM152nLiC/Q4Bh54oSLiBwcVG+2fFGV2FMQILePU8xlNBih5xRO0DgHW2Z7k8r0d/AUe2oFMdz9L8q4W04gkEvolwP4rWsY5jogeLt7d2qo0cBco5KMzxXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wNWfo-00000000448-26bb;
	Thu, 14 May 2026 14:04:24 +0000
Date: Thu, 14 May 2026 15:04:21 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v2 1/5] net: dsa: mt7530: fix FDB entries not aging out
 with short timeout
Message-ID: <7788ded12dc07b1bce329ec35fa70f4b45f3f9b7.1778766629.git.daniel@makrotopia.org>
References: <cover.1778766629.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778766629.git.daniel@makrotopia.org>
X-Rspamd-Queue-Id: A58C8542CE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287981-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[arinc9.com,makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bridge_vlan_unaware.sh:url,makrotopia.org:email,makrotopia.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bridge_vlan_aware.sh:url]
X-Rspamd-Action: no action

The DSA forwarding selftests bridge_vlan_aware.sh and
bridge_vlan_unaware.sh configure the bridge with ageing_time set to
LOW_AGEING_TIME (1000 centiseconds, i.e. 10 seconds) and then run
learning_test() in lib.sh, which expects a learned FDB entry to be
removed after ageing_time + 10 seconds. On MT7530/MT7531 the entry
persisted past the deadline and the "Found FDB record when should
not" assertion failed.

With msecs=10000, the algorithm in mt7530_set_ageing_time() finds
AGE_CNT=0 and AGE_UNIT=9 as the first exact match (starting the
search from tmp_age_count=0). The per-entry aging counter is
initialized to AGE_CNT when a MAC address is learned, so with
AGE_CNT=0 new entries start with a counter value of 0, which the
hardware treats as "already aged" and never removes, effectively
disabling aging.

Fix this by starting the search from tmp_age_count=1 to ensure
entries always have a non-zero initial aging counter. For a
10-second ageing time this yields AGE_CNT=1 and AGE_UNIT=4 instead:
the timer ticks every 5 seconds and entries are removed after 2
ticks.

Starting the search at AGE_CNT=1 raises the minimum representable
ageing time from 1 to 2 seconds. Without bounds, a stale ageing_time
of 1 second would now make the loop fall through without setting
age_count and age_unit, leaving them uninitialized when written to
the MT7530_AAC hardware register. Set ds->ageing_time_min and
ds->ageing_time_max so the DSA core validates the range before the
callback is invoked, and drop the now-redundant range check from
mt7530_set_ageing_time().

Fixes: ea6d5c924e39 ("net: dsa: mt7530: support setting ageing time")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2:
 - Set ds->ageing_time_min = 2 * 1000 and
   ds->ageing_time_max = (AGE_CNT_MAX + 1) * (AGE_UNIT_MAX + 1) * 1000
   in mt7530_setup() and mt7531_setup_common() so the DSA core
   rejects out-of-range values before calling the driver.
 - Drop the now-redundant `if (secs < 1 || ...)` range check from
   mt7530_set_ageing_time(); v1 left it in place and would have
   written uninitialized age_count/age_unit to MT7530_AAC for
   secs == 1 (loop falls through without ever finding a match
   once tmp_age_count starts at 1).
 - Reworked commit message to lead with the bridge_vlan_aware.sh /
   bridge_vlan_unaware.sh learning_test() scenario that exposes
   the bug, walk through the search-loop math for LOW_AGEING_TIME
   (10 s), and document the new lower bound.

 drivers/net/dsa/mt7530.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 44d670904ad8..cd311dfd3600 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1023,12 +1023,16 @@ mt7530_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 	unsigned int age_count;
 	unsigned int age_unit;
 
-	/* Applied timer is (AGE_CNT + 1) * (AGE_UNIT + 1) seconds */
-	if (secs < 1 || secs > (AGE_CNT_MAX + 1) * (AGE_UNIT_MAX + 1))
-		return -ERANGE;
-
-	/* iterate through all possible age_count to find the closest pair */
-	for (tmp_age_count = 0; tmp_age_count <= AGE_CNT_MAX; ++tmp_age_count) {
+	/* Applied timer is (AGE_CNT + 1) * (AGE_UNIT + 1) seconds.
+	 * The DSA core has already validated the range using
+	 * ds->ageing_time_min and ds->ageing_time_max.
+	 *
+	 * Iterate through all possible age_count values to find the closest
+	 * pair. Start from 1 because the per-entry aging counter is
+	 * initialized to AGE_CNT and a value of 0 means the entry will
+	 * never be aged out.
+	 */
+	for (tmp_age_count = 1; tmp_age_count <= AGE_CNT_MAX; ++tmp_age_count) {
 		unsigned int tmp_age_unit = secs / (tmp_age_count + 1) - 1;
 
 		if (tmp_age_unit <= AGE_UNIT_MAX) {
@@ -2428,6 +2432,8 @@ mt7530_setup(struct dsa_switch *ds)
 
 	ds->assisted_learning_on_cpu_port = true;
 	ds->mtu_enforcement_ingress = true;
+	ds->ageing_time_min = 2 * 1000;
+	ds->ageing_time_max = (AGE_CNT_MAX + 1) * (AGE_UNIT_MAX + 1) * 1000;
 
 	if (priv->id == ID_MT7530) {
 		regulator_set_voltage(priv->core_pwr, 1000000, 1000000);
@@ -2617,6 +2623,8 @@ mt7531_setup_common(struct dsa_switch *ds)
 
 	ds->assisted_learning_on_cpu_port = true;
 	ds->mtu_enforcement_ingress = true;
+	ds->ageing_time_min = 2 * 1000;
+	ds->ageing_time_max = (AGE_CNT_MAX + 1) * (AGE_UNIT_MAX + 1) * 1000;
 
 	mt753x_trap_frames(priv);
 
-- 
2.54.0

