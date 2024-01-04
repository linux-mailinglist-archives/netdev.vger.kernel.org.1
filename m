Return-Path: <netdev+bounces-61493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34148824061
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 12:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E4A1F26539
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 11:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6378E21109;
	Thu,  4 Jan 2024 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BuKRQccN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020D9210F3
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704366908; x=1735902908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=01oIGEc6Ohy6Rpabg8fxapMCJ78or9cM1DwlMsM2U/g=;
  b=BuKRQccNk7etufrmfkdjFLUVbE7EYUzo4obRSmptJ17xdUu+Y1qmvecc
   wDfB6RJ21a9AlD+/xTaVIdjoc5j14rqBinkgHpPLOd3FSqNgOg6++xaTc
   PSQYc/85AbRUW6NFMlBtRB7yD61nSK+9tTi3Rk5f2vkPlL9ZzOP8D1JXI
   wz2tLcejp7OLQRz6nThvBuXrsYSl0y2LuUFCnM8TLje/5TmP6MkT4fTWP
   q9izbhvUhEX6zN2ddQtiktVzyufFUbT0jN5xr+7fRlhyKrerQOczNDV1c
   XMucM3NxnzmePt9n+L3oXBPXc7othkMvoPiOZVvWY0s6jrOVBqgu7vWDm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="382174463"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="382174463"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 03:15:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="1027391611"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="1027391611"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2024 03:15:06 -0800
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
Subject: [PATCH net v2 4/4] dpll: hide "zombie" pins for userspace
Date: Thu,  4 Jan 2024 12:11:32 +0100
Message-Id: <20240104111132.42730-5-arkadiusz.kubalewski@intel.com>
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

If parent pin was unregistered but child pin was not, the userspace
would see the "zombie" pins - the ones that were registered with
parent pin (pins_pin_on_pin_register(..)).
Technically those are not available - as there is no dpll device in the
system. Do not dump those pins and prevent userspace from any
interaction with them.

Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
Reviewed-by: Jan Glaza <jan.glaza@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/dpll/dpll_netlink.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index f266db8da2f0..495dfc43c0be 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -949,6 +949,19 @@ dpll_pin_parent_pin_set(struct dpll_pin *pin, struct nlattr *parent_nest,
 	return 0;
 }
 
+static bool dpll_pin_parents_registered(struct dpll_pin *pin)
+{
+	struct dpll_pin_ref *par_ref;
+	struct dpll_pin *p;
+	unsigned long i, j;
+
+	xa_for_each(&pin->parent_refs, i, par_ref)
+		xa_for_each_marked(&dpll_pin_xa, j, p, DPLL_REGISTERED)
+			if (par_ref->pin == p)
+				return true;
+	return false;
+}
+
 static int
 dpll_pin_set_from_nlattr(struct dpll_pin *pin, struct genl_info *info)
 {
@@ -1153,6 +1166,9 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 
 	xa_for_each_marked_start(&dpll_pin_xa, i, pin, DPLL_REGISTERED,
 				 ctx->idx) {
+		if (!xa_empty(&pin->parent_refs) &&
+		    !dpll_pin_parents_registered(pin))
+			continue;
 		hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
 				  cb->nlh->nlmsg_seq,
 				  &dpll_nl_family, NLM_F_MULTI,
@@ -1179,6 +1195,10 @@ int dpll_nl_pin_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct dpll_pin *pin = info->user_ptr[0];
 
+	if (!xa_empty(&pin->parent_refs) &&
+	    !dpll_pin_parents_registered(pin))
+		return -ENODEV;
+
 	return dpll_pin_set_from_nlattr(pin, info);
 }
 
-- 
2.38.1


