Return-Path: <netdev+bounces-81846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1220188B450
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 23:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4470B1C3D208
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 22:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8E5811F1;
	Mon, 25 Mar 2024 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JVJo6Q1r"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DF87F7E9
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406354; cv=none; b=PezB7f7QqAcxbtyvLYh2u39EhcQ5QhjiROSLGAUBKx9VTRfhCEyXbMXLwul99EBayZ0QVVTxDxyCrSYrrK7Z1geia/5Wy9DruLVeGpzqXU9wau+OXBO8sl5XmiwSUbjSL2emkF55T+ZwTWjOxUVYgj6qOPd9b1mT6X2xGdiuk5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406354; c=relaxed/simple;
	bh=1FieoFOHFGkPhHUbnmAQfSzUN33IQJ5R9hcRj0lhlpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQr9qqK268iWSPHS2912kaytLoCilNuXtH0UryQeGteEatL73f4l18i9ktd7dAF7FlyWN4mewtZRXeyFA+i8DHLNflLuP7XVCxf/h+SjCesAsXQ/X9V+vJGnm2ecB6LWKp3grawrefERSRHWYJEnOyru/IfyIBIED6195Om3J7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JVJo6Q1r; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mSwHA2/gMqY4XCSjCXvGK3fgyb9SB0U4fOx/i8xSLTQ=;
	t=1711406351; x=1712615951; b=JVJo6Q1roTgbbnIyDEcTRfsdVH5ym4yYPZM7XnyYExDHKCl
	erz1eqZktr9aJYLPyu6J9/JRY+mZvvlBe885hHBzyBSfzMgOcxk/+ITpQJ1nTHqQA3YUMDoOm1i2V
	UQ9G2NVvBRJPCeaieHeAzTOExtLRBoxTnjpnc9YLfJhCSHJq9z27RHWqjeaTI12jMUcHV/b9uZjEa
	4e4UK/h65i+/yzdwZIFJMDugg2ezoVIN1I0v5yGKdh7HfOLZ6fOscLJPfnP1UGaIJb8sYuRIXvXer
	doBV131YnrQLsnIamHUFQfXjo+03yAMXVJxldEtTDieGQ4Sd9OHM22iEZ6O8CL7A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rosyC-0000000Ee2Q-3hvP;
	Mon, 25 Mar 2024 23:39:09 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/3] rtnetlink: add guard for RTNL
Date: Mon, 25 Mar 2024 23:31:26 +0100
Message-ID: <20240325233905.94899774f596.I9da87266ad39fff647828b5822e6ac8898857b71@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325223905.100979-5-johannes@sipsolutions.net>
References: <20240325223905.100979-5-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The new guard/scoped_gard can be useful for the RTNL as well,
so add a guard definition for it. It gets used like

 {
   guard(rtnl)();
   // RTNL held until end of block
 }

or

  scoped_guard(rtnl) {
    // RTNL held in this block
  }

as with any other guard/scoped_guard.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/rtnetlink.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index cdfc897f1e3c..a7da7dfc06a2 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -7,6 +7,7 @@
 #include <linux/netdevice.h>
 #include <linux/wait.h>
 #include <linux/refcount.h>
+#include <linux/cleanup.h>
 #include <uapi/linux/rtnetlink.h>
 
 extern int rtnetlink_send(struct sk_buff *skb, struct net *net, u32 pid, u32 group, int echo);
@@ -46,6 +47,8 @@ extern int rtnl_is_locked(void);
 extern int rtnl_lock_killable(void);
 extern bool refcount_dec_and_rtnl_lock(refcount_t *r);
 
+DEFINE_LOCK_GUARD_0(rtnl, rtnl_lock(), rtnl_unlock())
+
 extern wait_queue_head_t netdev_unregistering_wq;
 extern atomic_t dev_unreg_count;
 extern struct rw_semaphore pernet_ops_rwsem;
-- 
2.44.0


