Return-Path: <netdev+bounces-282738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPGOBY8n82mwxgEAu9opvQ
	(envelope-from <netdev+bounces-282738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 11:57:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF4A4A0552
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 11:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2CAB3056EBE
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62BD3FE35D;
	Thu, 30 Apr 2026 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bNvuzaRi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21AD3FFAD2;
	Thu, 30 Apr 2026 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542407; cv=none; b=j2d123cTBdb/JWUx6kYpKi596Ga9m6+ugbIF4dZGnL5mNkkvm22fyDTEVvHYsWXDveQkXh4oDlqrvya5UAqIKArxNoiCxHmJhoI/ft7+lqQVierDKp3UsSoEyfQD/PAgChidz/0W3U6OIWAagsSpDWhJybpKzQteThuavvSclsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542407; c=relaxed/simple;
	bh=y/QDmxkfTXgNMhmlNvETtV7zJKHS/M5pTaNjnoyYTkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DJZS5ZfuVRfM0TTNlL7X2yfH85hLFCbh67dZhfQNR3NkjkAbnqBcPVwZnWLJKWwAld9cbNho9OgKM6Ccmfgq3mT1yT1YxhGtQpGJbTyoibPVKpe8UL/qW9xGqpS2p7fuX20grScIKOykKhY9LLuuxIPdNgTP195T519uRPETcmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bNvuzaRi; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777542406; x=1809078406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y/QDmxkfTXgNMhmlNvETtV7zJKHS/M5pTaNjnoyYTkE=;
  b=bNvuzaRi5yCNXaVXzEBn325Nwa0RxTG+mkCU5tzrIHLMjCZA2+wYk4LU
   YAk8T7QANKdZUr0u8bFcYRBuJRsM/LNzyQ+ijKd1RisYKhy7tu3rR9xMn
   B9p4crY70T0GiHbVeTMb/0soNYSrmaBXLAmC+RYxBwXNfZfpSU4Yrpck8
   hCmQtk48KzSiB7WwRO8Mj7ZqRxUtgOoxZfvE9+4im9hA5Up0/MZvdAf71
   jREw9iS/CSLhkW6Sg2IfKeHQBwFkv82qmxOQDKopRWsKBQJZ2xMvLoA48
   j/7QDnd3xQ6RISo5zPIjS6yeoHKRVrHkMU+6iVg8L+F/RV8k+7VefoKv0
   w==;
X-CSE-ConnectionGUID: qyjRAp8RSj6nLdzpauQ4zg==
X-CSE-MsgGUID: Zy8bU5G5Se6fJfnRW6pi0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="82342569"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="82342569"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 02:46:45 -0700
X-CSE-ConnectionGUID: 1v08t+jyRlmPqWBOaXe4dA==
X-CSE-MsgGUID: GuN+VYnSRaeWpnRZC+5SLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="272649735"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa001.jf.intel.com with ESMTP; 30 Apr 2026 02:46:41 -0700
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
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH v7 net-next 1/8] dpll: add generic DPLL type
Date: Thu, 30 Apr 2026 11:42:31 +0200
Message-Id: <20260430094238.987976-2-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260430094238.987976-1-grzegorz.nitka@intel.com>
References: <20260430094238.987976-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1EF4A4A0552
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282738-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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

Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 Documentation/netlink/specs/dpll.yaml | 3 +++
 drivers/dpll/dpll_nl.c                | 2 +-
 include/uapi/linux/dpll.h             | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 40465a3d7fc2..572cf7ae5f36 100644
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
index 1e652340a5d7..9a3b70ea3ae0 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -34,7 +34,7 @@ const struct nla_policy dpll_reference_sync_nl_policy[DPLL_A_PIN_STATE + 1] = {
 static const struct nla_policy dpll_device_id_get_nl_policy[DPLL_A_TYPE + 1] = {
 	[DPLL_A_MODULE_NAME] = { .type = NLA_NUL_STRING, },
 	[DPLL_A_CLOCK_ID] = { .type = NLA_U64, },
-	[DPLL_A_TYPE] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
+	[DPLL_A_TYPE] = NLA_POLICY_RANGE(NLA_U32, 1, 3),
 };
 
 /* DPLL_CMD_DEVICE_GET - do */
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index 871685f7c353..648553053cd8 100644
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


