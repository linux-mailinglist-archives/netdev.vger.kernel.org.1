Return-Path: <netdev+bounces-61492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA11824060
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 12:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F3ABB23F7C
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 11:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACAF2110D;
	Thu,  4 Jan 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dr4JWvON"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F9D21109
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704366906; x=1735902906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=or6bprJ6TdJStRBqGMaArHe9smvxrsAGlIvp+wkzmo8=;
  b=dr4JWvONNB6VBmAT66ZjDtBMcGYzwsoTgOMfaxB5PFAqcRzDlqsLIK0o
   ONsqHU+0JxaBOPtQXlR+rXezNjKrpk91gkl427Z5rcihtNTAv/8qOYwY6
   nBqKJQQXunoZLupC6l60EnHjOiZ52EWJtbNifOQRJVrLzRODy/cAU6Xbj
   MkUhkLLRnxx7xzytRaEPeim6P3LpSAWTbAlN0hKURqKxH0VgVlPOOB4Cx
   GOk7Ng0b2bJW2/Ch/DGOja9eOKqjicDJR8K//XWeiveoE0mhGVe0fg3Ik
   Nh9xrdKtbRZ/yk3aVuKVZOP9PkkXXGwAZvTPCPBNyDdhcvjr0zLCo7aSI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="382174448"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="382174448"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 03:15:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="1027391580"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="1027391580"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2024 03:15:04 -0800
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
Subject: [PATCH net v2 3/4] dpll: fix register pin with unregistered parent pin
Date: Thu,  4 Jan 2024 12:11:31 +0100
Message-Id: <20240104111132.42730-4-arkadiusz.kubalewski@intel.com>
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

In case of multiple kernel module instances using the same dpll device:
if only one registers dpll device, then only that one can register
directly connected pins with a dpll device. When unregistered parent is
responsible for determining if the muxed pin can be registered with it
or not, the drivers need to be loaded in serialized order to work
correctly - first the driver instance which registers the direct pins
needs to be loaded, then the other instances could register muxed type
pins.

Allow registration of a pin with a parent even if the parent was not
yet registered, thus allow ability for unserialized driver instance
load order.
Do not WARN_ON notification for unregistered pin, which can be invoked
for described case, instead just return error.

Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
Reviewed-by: Jan Glaza <jan.glaza@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/dpll/dpll_core.c    | 4 ----
 drivers/dpll/dpll_netlink.c | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 0b469096ef79..c8a2129f5699 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -28,8 +28,6 @@ static u32 dpll_xa_id;
 	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
 #define ASSERT_DPLL_NOT_REGISTERED(d)	\
 	WARN_ON_ONCE(xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
-#define ASSERT_PIN_REGISTERED(p)	\
-	WARN_ON_ONCE(!xa_get_mark(&dpll_pin_xa, (p)->id, DPLL_REGISTERED))
 
 struct dpll_device_registration {
 	struct list_head list;
@@ -664,8 +662,6 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 	    WARN_ON(!ops->state_on_pin_get) ||
 	    WARN_ON(!ops->direction_get))
 		return -EINVAL;
-	if (ASSERT_PIN_REGISTERED(parent))
-		return -EINVAL;
 
 	mutex_lock(&dpll_lock);
 	ret = dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv);
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 3ce9995013f1..f266db8da2f0 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -553,7 +553,7 @@ dpll_pin_event_send(enum dpll_cmd event, struct dpll_pin *pin)
 	int ret = -ENOMEM;
 	void *hdr;
 
-	if (WARN_ON(!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED)))
+	if (!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))
 		return -ENODEV;
 
 	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
-- 
2.38.1


