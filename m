Return-Path: <netdev+bounces-82743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B051788F8A9
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 08:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FF91C2525D
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 07:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600EE51005;
	Thu, 28 Mar 2024 07:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AuZlg5Qu"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54268224D0
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711610878; cv=none; b=PDw5dpQ2JH5OmgwFrP+1Ew/hThkv6Mz1B94/znNEQwh4EgGzPFZJeaOT41Lb5uLSA0yCdJ7QBVIoVZVCELFE6KiKiAAY8rb9XBsD97iFHw3s17BePDp6Z8f5nFjYX4nPhZ41ARig2p7trhPLSIte16U9ItJXQLd6VP2AwmeOZeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711610878; c=relaxed/simple;
	bh=gIrnG1iBFeXw1dwlQxHrJsjRLf5N4eGIDkOmKNjFuJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NXrKxiNeU4eykkv6L9NMPlCxUdg+HfV2i0eISyHRhzDGl6hoqLQg0tw76ZDWo+raUm9IZQX+Mj1g87aTq7AYFfwhsP3GV0acgWh7n02hMvOj95Pfk519xB/WCnlO2ePQ45wlIVUNli53sV093SYrFZNXdf7mto+3bpYE9YAzFLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AuZlg5Qu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=0P3K3P8x7LTqL9tZ0XygcKdtIshRGr5idfmac1j0PiM=; t=1711610875; x=1712820475; 
	b=AuZlg5QuSvqWzc6wdAguOM3mSG15yWcWjyF30yeyFk9BrS3U1iiWNj3QranvPlvFE2WLcdX1Wo1
	Fh2wd4rVdv3i1b9PHkDObyNWJGTlOA9q+7PDMV/xdVZHItuVUcltcKM250m3B+jGCS/Ccz25wzUFk
	Ih0wgCxPAgzs6F2iMROfPYiyBQqL+ws7ld4MTC/BhtwXyBGqZBwl8VgZ35BlbdAwOM0b0barCqtnz
	22LLle00jn7h0EhamgYAZEWuH7fzW1uDAslelC2neW0tQjxL4DmDT1f/mSBvdw4O9nF7PKmmQDEfp
	OQxlhk4EKJ4AbBrLB/GMXGBcXMGfyTdS1vvw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpkAx-00000000jvG-34dK;
	Thu, 28 Mar 2024 08:27:51 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	victor@mojatatu.com,
	kuba@kernel.org,
	pctammela@mojatatu.com,
	martin@strongswan.org,
	horms@kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net-next v2 1/2] rtnetlink: add guard for RTNL
Date: Thu, 28 Mar 2024 08:27:49 +0100
Message-ID: <20240328082748.b6003379b15b.I9da87266ad39fff647828b5822e6ac8898857b71@changeid>
X-Mailer: git-send-email 2.44.0
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
v2: resend
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


