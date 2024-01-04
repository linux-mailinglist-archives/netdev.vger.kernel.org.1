Return-Path: <netdev+bounces-61490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D95F382405E
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 12:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704661F26057
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 11:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B983210FB;
	Thu,  4 Jan 2024 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HmoAeUs4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98098210F6
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704366902; x=1735902902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=latcYaoADu/BdubtmjoFleX7eq/oqt473BrRvC/yq2o=;
  b=HmoAeUs4TK4V5p4xUGyyPqJbkSdLWTY2xhdxJ40DFpBBg6/B3JhcBAIB
   DdluSRbYrb8/ACAb7VWJ8KrPhRVvHFHxYqcFOOKR7fNdsBveXPIXHlX7r
   xDVP2XJThmrAWWImd9SuSBRLYr5lMyNsncuoutLFmCK4Uhiusojz1WUxX
   WQg5o/TW0uQpH+EYmwNSfCOop+y7pE3FmDEBtcFp2vmY1cycc0ToUx9DL
   c4q7RoC6Mq2FjVvYRAKOEoAOsVqQ/UAJtEO0OgVXZliG70WdMxA374AhD
   nYYw83rspMSRsEZoNTwFLMd/Yff/zhKI55zKdIIxIeuNOKzxG3LFI7olf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="382174426"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="382174426"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 03:15:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="1027391537"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="1027391537"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2024 03:14:59 -0800
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	michal.michalik@intel.com,
	milena.olech@intel.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jan Glaza <jan.glaza@intel.com>
Subject: [PATCH net v2 1/4] dpll: fix pin dump crash after module unbind
Date: Thu,  4 Jan 2024 12:11:29 +0100
Message-Id: <20240104111132.42730-2-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240104111132.42730-1-arkadiusz.kubalewski@intel.com>
References: <20240104111132.42730-1-arkadiusz.kubalewski@intel.com>
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
the parent was unregistered, those shall not be accessed by the
userspace, prevent that by checking if parent pin is still registered.

Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
Reviewed-by: Jan Glaza <jan.glaza@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/dpll/dpll_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index ce7cf736f020..b53478374a38 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -328,6 +328,8 @@ dpll_msg_add_pin_parents(struct sk_buff *msg, struct dpll_pin *pin,
 		void *parent_priv;
 
 		ppin = ref->pin;
+		if (!xa_get_mark(&dpll_pin_xa, ppin->id, DPLL_REGISTERED))
+			continue;
 		parent_priv = dpll_pin_on_dpll_priv(dpll_ref->dpll, ppin);
 		ret = ops->state_on_pin_get(pin,
 					    dpll_pin_on_pin_priv(ppin, pin),
-- 
2.38.1


