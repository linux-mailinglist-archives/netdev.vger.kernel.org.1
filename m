Return-Path: <netdev+bounces-296290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id alf3OQq6JWr3KwIAu9opvQ
	(envelope-from <netdev+bounces-296290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 20:35:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6740F651409
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 20:35:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=nUSTTO6V;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296290-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296290-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40901300F9C6
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47D230C360;
	Sun,  7 Jun 2026 18:35:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0822EEE73;
	Sun,  7 Jun 2026 18:35:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780857322; cv=none; b=Oe3f5ypRR1JKBHRfDLPBDBjRechC4iakgOccVlL5uCbl4FvHuDPEJAMgcEZ0/33juyPjh2uqkWAlcNb/oGzm5cT+1Bwhi4QQvcrfwRiZ2045fESIqajwrrw5TIuYs09cE1CI92POcl+Cx1o4kxgj6f1HDTHEFI4HEUNLKzjM2Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780857322; c=relaxed/simple;
	bh=iUOOCQLHdnrNfXF3HMHs/v47S8LPHgGnXOXq/FTBrw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BuKWk6Yaow5GzKaq/pJ/pgr8EhXyDTO7QazBwKHvCISX+c+x2n0vE+E5CJtr3+/2CQV54ir1awT81n7Ut/rK2hQNfUUg/l4nJutd9oAc5zhbNg+Y78fSCaeSseXA1ZUV8ka8H2t0e1zlOxIHew3gL6YFDbJnOT7Z16v5MDqFOlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUSTTO6V; arc=none smtp.client-ip=198.175.65.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780857321; x=1812393321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iUOOCQLHdnrNfXF3HMHs/v47S8LPHgGnXOXq/FTBrw4=;
  b=nUSTTO6V39hXRdTEoCYGYS6yglWKEPh4GQBE02z7K83jjh7LheaRdnfA
   IEbV3qkqdJZVxctouRxiw/wKk+19vFq1hGp1T2OD/LA+Xi1CtniwVPu+V
   HtzkZbHCr/N4ZAdOo+G6RbgOiipz0zR3ykG5k0gfifRRSKeTVUEcBkbZi
   Ouw/jDGP1b2Ra382ClfVIGTq+CQYOi85ZGXyNJMJ8prD/Ig2+QnHpDcx0
   3Zn0hSL4dyfgvVIBIucACYSQaouqqPWkaho3vCxwg7mQkhSRzoNxIzBOw
   xHeaHpFKdkss8Y8b14nVZY3pdup5j+LEfsUq88pl0a7+HZedpAuHnSVNh
   g==;
X-CSE-ConnectionGUID: jni6/UllTrGr3MplD2zYmw==
X-CSE-MsgGUID: iXuFlKT+TA2FLW8q3AkaZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81601996"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="81601996"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 11:35:21 -0700
X-CSE-ConnectionGUID: yOn+nP6JRVaJvlKBzACHmQ==
X-CSE-MsgGUID: YiaQfJ1GQsC6kLMWJJEcZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="245171300"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa008.jf.intel.com with ESMTP; 07 Jun 2026 11:35:15 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	poros@redhat.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	Prathosh.Satish@microchip.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	donald.hunter@gmail.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH v14 net-next 01/13] dpll: add generic DPLL type
Date: Sun,  7 Jun 2026 20:30:33 +0200
Message-Id: <20260607183045.1213735-2-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
References: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296290-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:poros@redhat.com,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:Prathosh.Satish@microchip.com,m:ivecera@redhat.com,m:jiri@resnulli.us,m:arkadiusz.kubalewski@intel.com,m:vadim.fedorenko@linux.dev,m:donald.hunter@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:grzegorz.nitka@intel.com,m:aleksandr.loktionov@intel.com,m:jiri@nvidia.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6740F651409

Add DPLL_TYPE_GENERIC to represent DPLL devices which do not fit the
existing PPS or EEC classes.

The UAPI type is intentionally generic. During netdev discussion,
maintainers pointed out that introducing identifiers tied to a specific
placement or single design does not scale across ASICs and vendors.
The role of a DPLL is already inferable from the spawning driver,
bus device, and pin topology, without encoding additional
purpose-specific taxonomy in the type name.

Using a generic type keeps the UAPI extensible and avoids premature
naming that may become incorrect as new hardware topologies are
exposed through the DPLL subsystem.

Expose the new type through UAPI and netlink specification as "generic".

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 Documentation/netlink/specs/dpll.yaml | 3 +++
 drivers/dpll/dpll_nl.c                | 2 +-
 include/uapi/linux/dpll.h             | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 91a172617b3a..2bf83f6732ab 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -138,6 +138,9 @@ definitions:
       -
         name: eec
         doc: dpll drives the Ethernet Equipment Clock
+      -
+        name: generic
+        doc: generic dpll type for devices outside PPS/EEC classes
     render-max: true
   -
     type: enum
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index b1d9182c7802..ed3bbe9841ea 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -37,7 +37,7 @@ const struct nla_policy dpll_reference_sync_nl_policy[DPLL_A_PIN_STATE + 1] = {
 static const struct nla_policy dpll_device_id_get_nl_policy[DPLL_A_TYPE + 1] = {
 	[DPLL_A_MODULE_NAME] = { .type = NLA_NUL_STRING, },
 	[DPLL_A_CLOCK_ID] = { .type = NLA_U64, },
-	[DPLL_A_TYPE] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
+	[DPLL_A_TYPE] = NLA_POLICY_RANGE(NLA_U32, 1, 3),
 };
 
 /* DPLL_CMD_DEVICE_GET - do */
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index cb363cccf2e2..55eaa82f5f98 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -109,10 +109,12 @@ enum dpll_clock_quality_level {
  * enum dpll_type - type of dpll, valid values for DPLL_A_TYPE attribute
  * @DPLL_TYPE_PPS: dpll produces Pulse-Per-Second signal
  * @DPLL_TYPE_EEC: dpll drives the Ethernet Equipment Clock
+ * @DPLL_TYPE_GENERIC: generic dpll type for devices outside PPS/EEC classes
  */
 enum dpll_type {
 	DPLL_TYPE_PPS = 1,
 	DPLL_TYPE_EEC,
+	DPLL_TYPE_GENERIC,
 
 	/* private: */
 	__DPLL_TYPE_MAX,
-- 
2.39.3


