Return-Path: <netdev+bounces-268933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJgRFwVtumnRWQIAu9opvQ
	(envelope-from <netdev+bounces-268933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:14:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B96722B8BE7
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03F873097EB7
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC0B38F95A;
	Wed, 18 Mar 2026 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dTFhORp1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66B0346E56;
	Wed, 18 Mar 2026 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773825054; cv=none; b=oB7v16epK6089uHYdYn6NB2LKwB9dFtrsjfLRSPJFyKnlmElqQSAnjgLVpl56Owtqr6k0RmVVQax3bGhoyjI4ZZPsWVWfHFm0sTPr1e+TNArxSIB8lvM8At+G0zCbg6w/HGkHa/moXIfzYJucvnM9SXFEL3NrFfcOY6RmNWf+7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773825054; c=relaxed/simple;
	bh=JwAYdusPC5by170hmQjS6FQlF/xAWF9PHx4rEUFWEJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uyFB3OaX1z1EkOTmbpw/qEMD/VzOhgJxShEur/7Ku4F0BqEcIypJ98mJeVyE9d7zYDLEYlxc2cBEpbsgebMSHqND4JpquArNyKxhyNpUpHgzBQ1mwZTwp3gACyg8cRW8zS3ktZWNAUKRAPcDMhksOK9LKDkMRyQL5emIzloK/Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dTFhORp1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773825052; x=1805361052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JwAYdusPC5by170hmQjS6FQlF/xAWF9PHx4rEUFWEJk=;
  b=dTFhORp1+8SBbMrAZK7YR9vanLs3Dk6VcOgalzMAEDvxCH2Q0PrQvKXX
   Papk1bSS3mP/Y3WS2C8avnw2gs9UTRmhQY3BTvoSPEl4bcKDneduo/kLa
   F+A6ZcwkuXXX1EbpygnJtBaUEosYb9CDG+cVnYbDH0bOMXbBYO52WYy6E
   oJkKB0p+q1H1v2FBlD6P4EncDd/QAkcKnTZabde+9mmTkasFnlAFbVair
   rLdCqodnKm11zv1o3TxFgmlPCg+yDcSNQ08YzY4Gu+uFGHKXwA4eFb6bz
   pitcJBPCMdryGQlyeDLJ8GIWv8qNwZUjTnRepN5WArMzWYM39LJh48HF/
   g==;
X-CSE-ConnectionGUID: onWDpYyBSrm4ZqnlxX3lbQ==
X-CSE-MsgGUID: h6JLCA5YSMKQw5yFmuZJaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="77484389"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="77484389"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 02:10:52 -0700
X-CSE-ConnectionGUID: e0rUIBs0TJiHtivit/Gyhw==
X-CSE-MsgGUID: VkKlT6VSSvG6ZBFeI/8iTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="226699909"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa003.jf.intel.com with ESMTP; 18 Mar 2026 02:10:48 -0700
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
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 1/8] dpll: add new DPLL type for transmit clock (TXC) usage
Date: Wed, 18 Mar 2026 10:06:47 +0100
Message-Id: <20260318090654.611349-2-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260318090654.611349-1-grzegorz.nitka@intel.com>
References: <20260318090654.611349-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-268933-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B96722B8BE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend the DPLL subsystem with a new DPLL type, DPLL_TYPE_TXC,
representing devices that drive a transmit reference clock. Certain
PHYs, MACs and SerDes blocks use a dedicated TX reference clock for
link operation, and this clock domain is distinct from PPS- and
EEC-driven synchronization sources. Defining a dedicated type allows
user space and drivers to correctly classify and configure DPLLs
intended for TX clock generation.

The corresponding netlink specification is updated to expose "txc"

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 Documentation/netlink/specs/dpll.yaml | 3 +++
 include/uapi/linux/dpll.h             | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 3dd48a32f783..2a2ee37a1fc0 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -138,6 +138,9 @@ definitions:
       -
         name: eec
         doc: dpll drives the Ethernet Equipment Clock
+      -
+        name: txc
+        doc: dpll drives Tx reference clock
     render-max: true
   -
     type: enum
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index de0005f28e5c..a277d08ac264 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -109,10 +109,12 @@ enum dpll_clock_quality_level {
  * enum dpll_type - type of dpll, valid values for DPLL_A_TYPE attribute
  * @DPLL_TYPE_PPS: dpll produces Pulse-Per-Second signal
  * @DPLL_TYPE_EEC: dpll drives the Ethernet Equipment Clock
+ * @DPLL_TYPE_TXC: dpll drives Tx reference clock signal
  */
 enum dpll_type {
 	DPLL_TYPE_PPS = 1,
 	DPLL_TYPE_EEC,
+	DPLL_TYPE_TXC,
 
 	/* private: */
 	__DPLL_TYPE_MAX,
-- 
2.39.3


