Return-Path: <netdev+bounces-46591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427867E5378
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 11:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0E01C20D9B
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 10:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F4011CB0;
	Wed,  8 Nov 2023 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDopcxxk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9F97EF
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 10:35:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFD210D5
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 02:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699439731; x=1730975731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C55NGJMFSOPoojVxAshi+3XCIrD5QW5iFAdOspXeMLs=;
  b=kDopcxxktggSLlVec3+PhHd29UVcrro5G9tilsIknQEg0pEJa+md81HS
   F2+wTLqLmYl+oHncdll8k3YKOjEvNPockBxPzSof4SDbbVnysjs8QuT2g
   6yLOSSjJTpHPl6lcVj2jK5gpFuBVz9Se2wzjDuGOAp0s7XuSCfm22qdDe
   +U6xEd2MMDzvId6Enzr9CD5vs1DTL6LJ71y5lEj4n6oohzLxfeC8J2NVK
   8n899l9fZROcP/MEkteiSTaEsI1yeZDlSO2cUploovZtHDZTFy4bWsqa9
   xQIZD0cfEWZmkvGNKH9SBkHGe8EuwDvF2EwvtY+I4cLgvk5rYwhpVp4bA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="393651313"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="393651313"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 02:35:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="766606291"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="766606291"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga007.fm.intel.com with ESMTP; 08 Nov 2023 02:35:29 -0800
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	michal.michalik@intel.com,
	milena.olech@intel.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net 1/3] dpll: fix pin dump crash after module unbind
Date: Wed,  8 Nov 2023 11:32:24 +0100
Message-Id: <20231108103226.1168500-2-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disallow dump of unregistered parent pins, it is possible when parent
pin and dpll device registerer kernel module instance unbinds, and
other kernel module instances of the same dpll device have pins
registered with the parent pin. The user can invoke a pin-dump but as
the parent was unregistered, thus shall not be accessed by the
userspace, prevent that by checking if parent pin is still registered.

Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/dpll/dpll_netlink.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index a6dc3997bf5c..93fc6c4b8a78 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -328,6 +328,13 @@ dpll_msg_add_pin_parents(struct sk_buff *msg, struct dpll_pin *pin,
 		void *parent_priv;
 
 		ppin = ref->pin;
+		/*
+		 * dump parent only if it is registered, thus prevent crash on
+		 * pin dump called when driver which registered the pin unbinds
+		 * and different instance registered pin on that parent pin
+		 */
+		if (!xa_get_mark(&dpll_pin_xa, ppin->id, DPLL_REGISTERED))
+			continue;
 		parent_priv = dpll_pin_on_dpll_priv(dpll_ref->dpll, ppin);
 		ret = ops->state_on_pin_get(pin,
 					    dpll_pin_on_pin_priv(ppin, pin),
-- 
2.38.1


