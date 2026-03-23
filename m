Return-Path: <netdev+bounces-270552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEcxOjdEwWnpRwQAu9opvQ
	(envelope-from <netdev+bounces-270552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 14:46:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A622F33F6
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 14:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A86B13004261
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5B33A960E;
	Mon, 23 Mar 2026 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="St+L4OCQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BA5340298
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273099; cv=none; b=HHe8m20SxuBUPa9QxRlvS6oqbFwrpTT1AU+3hgNEbBEHXSnTpDT6vjvb8oqwosQvAQXTCyELREiOkQ7z1rg50oAklUqMZpKBs19VX43AbVR/2V7rkm5j6HffvwrDTEcDVjXStLlQD5MMvlHFexFcvR/S1GPGhwKT87uMbjuhZPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273099; c=relaxed/simple;
	bh=KW53xm4EMUmaDFLpHeXdsNCoOkBX60KScnX9/yJEVTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U4aAOvaEDFiDDdHDDwmqF7BqWK5/iGrGhaEPSF5i22U2LQXawhQgVdsmRILdUt1Oxruc2urMTsYyRL+yAfUinvxi91gbQCAtqx34rQlW5YVcY9X1nF1vOZfG9I5+VsJUOpAYw3LKXoFW5qwYTgTXxZNpEMNuIn3mv+E7Z90yZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=St+L4OCQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774273098; x=1805809098;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KW53xm4EMUmaDFLpHeXdsNCoOkBX60KScnX9/yJEVTw=;
  b=St+L4OCQwGiy/GpHA92eeL9Ry++cBV+Kr1c0RjE6O2fl6zljicupztio
   /eky8xgnTRaMxs4bLVAUY6BNaen/bGh5a/LYM0gJUfSv6zPqH68CloVP1
   foValaeFnEL6hhbt11W3CApBB4AJcE3BgOwaJL38sXmb/zghdBjyAYUUE
   BNoVdP5whjjf7tVRJ9atWcFs+FfZw+5MdM0WHAI9DD/h7km+DL1BYm/Bl
   TJKFaEDiEvyajZZSyMPbcUn1lw4FOpUnpD4qQ9S8bG716Tfz6uyqFnLWh
   Wc86p56Te79etFLQ1bbB74ow8/4xMNB1LEEL1gXjuSWEB270KlqXbhRYe
   w==;
X-CSE-ConnectionGUID: hwkyMrn6SeuTc7QoLLDEFg==
X-CSE-MsgGUID: YCIH2hThTz65XX+f5zKifQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75151813"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75151813"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 06:38:18 -0700
X-CSE-ConnectionGUID: yHgcV4CaQt2aO8f9ubyb8w==
X-CSE-MsgGUID: l5AuL3eaS2CC5X0dXEFqLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="228103783"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 23 Mar 2026 06:38:13 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 949452879A;
	Mon, 23 Mar 2026 13:38:12 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Simon Horman <horms@kernel.org>,
	Michal Schmidt <mschmidt@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next] devlink: unify devlink_shd_get_priv() into devlink_priv()
Date: Mon, 23 Mar 2026 14:21:36 +0100
Message-Id: <20260323132136.13191-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270552-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65A622F33F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Unify access API to shared devlink priv data with normal devlink.

Thanks to Jiri Piro, we now have ability to create shared devlink
instances [1]. Introduction series have added usege of those for mlx, but
without priv data attached to the shared devlink.

Current API makes it possible to access shared devlink instance's priv
data:

	void *devlink_shd_get_priv(struct devlink *devlink);

but it is easy to to forget (especially during rebase from "before shared
devlinks" era) and call:

	void *devlink_priv(struct devlink *devlink);

which even has the same signature, so it's hard to catch the error.

New proposed API unifies both calls into one, without any increase in the
observerd struct size. (Alternative could be to store additional pointer,
set during devlink_alloc).

Unexport the less convenient API call.

[1] commit 411ad0605875 ("Merge branch 'devlink-introduce-shared-devlink-instance-for-pfs-on-same-chip'")
[1] https://lore.kernel.org/all/20260312100407.551173-1-jiri@resnulli.us

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
sorry that I have not mentioned it during [1] review, it got obvious
for me only after working with the code
---
 net/devlink/devl_internal.h |  4 ++++
 net/devlink/core.c          |  3 +++
 net/devlink/sh_dev.c        | 11 ++++++++---
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 7dfb7cdd2d23..abbe308ee9bd 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -58,6 +58,7 @@ struct devlink {
 	struct mutex lock;
 	struct lock_class_key lock_key;
 	u8 reload_failed:1;
+	u8 is_shd:1;
 	refcount_t refcount;
 	struct rcu_work rwork;
 	struct devlink_rel *rel;
@@ -72,6 +73,9 @@ struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
 				struct net *net, struct device *dev,
 				const struct device_driver *dev_driver);
 
+/* Get private data from shared devlink instance */
+void *devlink_shd_get_priv(struct devlink *devlink);
+
 #define devl_warn(devlink, format, args...)				\
 	do {								\
 		if ((devlink)->dev)					\
diff --git a/net/devlink/core.c b/net/devlink/core.c
index eeb6a71f5f56..4c97e2e2c073 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -232,6 +232,9 @@ int devlink_rel_devlink_handle_put(struct sk_buff *msg, struct devlink *devlink,
 
 void *devlink_priv(struct devlink *devlink)
 {
+	if (devlink->is_shd)
+		return devlink_shd_get_priv(devlink);
+
 	return &devlink->priv;
 }
 EXPORT_SYMBOL_GPL(devlink_priv);
diff --git a/net/devlink/sh_dev.c b/net/devlink/sh_dev.c
index 9b7456d64b57..450e3218759e 100644
--- a/net/devlink/sh_dev.c
+++ b/net/devlink/sh_dev.c
@@ -31,6 +31,11 @@ static struct devlink_shd *devlink_shd_lookup(const char *id)
 	return NULL;
 }
 
+static struct devlink_shd *devlink_to_shd(struct devlink *devlink)
+{
+	return &devlink->priv;
+}
+
 static struct devlink_shd *devlink_shd_create(const char *id,
 					      const struct devlink_ops *ops,
 					      size_t priv_size,
@@ -43,13 +48,14 @@ static struct devlink_shd *devlink_shd_create(const char *id,
 				  &init_net, NULL, driver);
 	if (!devlink)
 		return NULL;
-	shd = devlink_priv(devlink);
+	shd = devlink_to_shd(devlink);
 
 	shd->id = kstrdup(id, GFP_KERNEL);
 	if (!shd->id)
 		goto err_devlink_free;
 	shd->priv_size = priv_size;
 	refcount_set(&shd->refcount, 1);
+	devlink->is_shd = 1;
 
 	devl_lock(devlink);
 	devl_register(devlink);
@@ -137,7 +143,7 @@ void devlink_shd_put(struct devlink *devlink)
 	struct devlink_shd *shd;
 
 	mutex_lock(&shd_mutex);
-	shd = devlink_priv(devlink);
+	shd = devlink_to_shd(devlink);
 	if (refcount_dec_and_test(&shd->refcount))
 		devlink_shd_destroy(shd);
 	mutex_unlock(&shd_mutex);
@@ -159,4 +165,3 @@ void *devlink_shd_get_priv(struct devlink *devlink)
 
 	return shd->priv;
 }
-EXPORT_SYMBOL_GPL(devlink_shd_get_priv);
-- 
2.39.3


