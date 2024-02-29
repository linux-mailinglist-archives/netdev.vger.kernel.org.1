Return-Path: <netdev+bounces-76298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF3386D2CB
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 20:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7EB01F23DB0
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D421361B5;
	Thu, 29 Feb 2024 19:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yo0Go+Cd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A419A79933
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709233527; cv=none; b=HedJe/cX1MAs6jsh5v7UeSy38ActvCf3WEQBpcC3SeplcfxotYRN1bMqkaxLZCrBSR0vew3js+u3fY2YYriTJHIxTzB28cRHWsbDioySB+CCLoC0ARmp9qfRtfPM4bbuZmO7Bbm5qg+N2BjBoJqp4aa0WQJTrOUSaABlNdgGKIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709233527; c=relaxed/simple;
	bh=Yj/8ylZVagQQYAg9vwLPnRlYBQO3Cl0Tj9liB1zXD2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XaWPb85xaou73E4h1Xp7MmkeuICavmFOLTfduC5/8FCTaULHPKzBA2BeGRRMdBsohmltR7Ol+lonvPmhazkjeq8NGZWTmxRFTQhwbZLGQPbmbg3TI3dkdX6HvNVW2C8ODekaRZ0dCvHhESaT8IUeVPm/beWO09UF680w8NtKOYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yo0Go+Cd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9832DC433F1;
	Thu, 29 Feb 2024 19:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709233527;
	bh=Yj/8ylZVagQQYAg9vwLPnRlYBQO3Cl0Tj9liB1zXD2g=;
	h=From:To:Cc:Subject:Date:From;
	b=Yo0Go+CdyPqtHCa6WidEFxY64/npwXWslQJfiZxESGf5QSJ4d5/frLMVcgAy6hrcb
	 7bWdALC1tuHyIPS+vl8WPfFE+ZM3JKF2xGGIvq+xsnbPzShlE1+7Wd0tpaRuTEk4NK
	 RzLVpSZJQs4XnVOQCnlRm/e9uVv54C+JQVVOYtzTHNm2C4FjRXUiYrrVCHqh4klpoU
	 DzIMVhq//YhW3oO7fiXQMe8A5dntjj0gGlcys+yK3FuJWaT3OzZtnHcAr1xVR4UWeb
	 rr4hpCEps+Ly7zdtrzOq6eVhwQraOXkalH+hsUQjTXi2tRUHgQxXlqnOGlyGB7y9z5
	 HjZxkW+4XUnhA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	jiri@resnulli.us
Subject: [PATCH net] dpll: fix build failure due to rcu_dereference_check() on unknown type
Date: Thu, 29 Feb 2024 11:05:15 -0800
Message-ID: <20240229190515.2740221-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

Tasmiya reports that their compiler complains that we deref
a pointer to unknown type with rcu_dereference_rtnl():

include/linux/rcupdate.h:439:9: error: dereferencing pointer to incomplete type ‘struct dpll_pin’

Unclear what compiler it is, at the moment, and we can't report
but since DPLL can't be a module - move the code from the header
into the source file.

Fixes: 0d60d8df6f49 ("dpll: rely on rcu for netdev_dpll_pin()")
Reported-by: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Link: https://lore.kernel.org/all/3fcf3a2c-1c1b-42c1-bacb-78fdcd700389@linux.vnet.ibm.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Sending officially the solution Eric suggested in the report
thread. The bug is pending in the net tree, so I'd like to
put this on an express path, to make today's PR...

CC: vadim.fedorenko@linux.dev
CC: arkadiusz.kubalewski@intel.com
CC: jiri@resnulli.us
---
 drivers/dpll/dpll_core.c | 5 +++++
 include/linux/dpll.h     | 8 ++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 4c2bb27c99fe..507dd9cfb075 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -42,6 +42,11 @@ struct dpll_pin_registration {
 	void *priv;
 };
 
+struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
+{
+       return rcu_dereference_rtnl(dev->dpll_pin);
+}
+
 struct dpll_device *dpll_device_get_by_id(int id)
 {
 	if (xa_get_mark(&dpll_device_xa, id, DPLL_REGISTERED))
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 4ec2fe9caf5a..c60591308ae8 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -169,13 +169,13 @@ int dpll_device_change_ntf(struct dpll_device *dpll);
 
 int dpll_pin_change_ntf(struct dpll_pin *pin);
 
+#if !IS_ENABLED(CONFIG_DPLL)
 static inline struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
 {
-#if IS_ENABLED(CONFIG_DPLL)
-	return rcu_dereference_rtnl(dev->dpll_pin);
-#else
 	return NULL;
-#endif
 }
+#else
+struct dpll_pin *netdev_dpll_pin(const struct net_device *dev);
+#endif
 
 #endif
-- 
2.43.2


