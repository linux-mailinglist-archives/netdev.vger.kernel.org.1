Return-Path: <netdev+bounces-242519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C45FC913FA
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 09:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1164A4E631C
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 08:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776D52E6CDF;
	Fri, 28 Nov 2025 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z8U6qp+Z"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8142DF143
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764319053; cv=none; b=utrlXvp/BsndcC7cpusQ2iXSHbpAlkf7O+0zoq/M+wlqJkTS79lzjjqfgzceP2aaxezGAGNCJL3xgsc3JBNMeq4R5RF0jsnbrmf8poxcDFnPVDGKwsznV5+nMKpksBLIlYwxNGurdK6KNzeXXUv5jgr32K3MPFoGSB2a2T9+9l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764319053; c=relaxed/simple;
	bh=9i+ZOslImSzH+rtTb32TMEw6DQ2RdZx+xwT+FK6/hBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BCPrGcJFObVCoFbID5QZMp/mSXDO0PiA4gbeCiyTWv4VI1VgeTiu2hJ0a7F2XxozQvM6jFfLUbsK/VTY5IJ4QHtc9DKuok2/lPmJIr/kTHf5omLHnXBjg28rhTZj+i3XFLSt80QbdZmwOp+x6bWDFDUO5SFWZybWsiTSgLMKCkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z8U6qp+Z; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764319046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AyCpr73GW8D3C48mDnr3WbOCxeZIjoR/nJdSxDsAdd8=;
	b=Z8U6qp+ZG8Kh9H8cEXi372x0/esxUPuU5GVuZBDLvbFQrOBF5Lc/+7zdBVgCs2ZZ4cpBec
	ErznVfrMxkj8BiqH3nlIFaDf3Zalb60kiHmSVWqW8CicvSGM0rBPfL1v7DxDSARjpd2/In
	gEl4GmftFAfRvAvXBi6CK2QSIunK6PA=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangfushuai@baidu.com,
	Fushuai Wang <fushuai.wang@linux.dev>
Subject: [PATCH] rtnl: Add guard support
Date: Fri, 28 Nov 2025 16:34:55 +0800
Message-Id: <20251128083455.67474-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce guard support to simplify the usage of the
lock about rtnl.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 include/linux/rtnetlink.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index ea39dd23a197..61e727c35927 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -7,6 +7,7 @@
 #include <linux/netdevice.h>
 #include <linux/wait.h>
 #include <linux/refcount.h>
+#include <linux/cleanup.h>
 #include <uapi/linux/rtnetlink.h>
 
 extern int rtnetlink_send(struct sk_buff *skb, struct net *net, u32 pid, u32 group, int echo);
@@ -158,6 +159,16 @@ static inline void ASSERT_RTNL_NET(struct net *net)
 	rcu_replace_pointer_rtnl(rp, p)
 #endif
 
+DEFINE_LOCK_GUARD_0(rtnl, rtnl_lock(), rtnl_unlock())
+
+DEFINE_GUARD(__rtnl_net, struct net *, __rtnl_net_lock(_T),
+	     __rtnl_net_unlock(_T))
+
+DEFINE_GUARD(rtnl_net, struct net *, rtnl_net_lock(_T),
+	     rtnl_net_unlock(_T))
+DEFINE_GUARD_COND(rtnl_net, _try, rtnl_net_trylock(_T))
+DEFINE_GUARD_COND(rtnl_net, _kill, rtnl_net_lock_killable(_T), _RET == 0)
+
 static inline struct netdev_queue *dev_ingress_queue(struct net_device *dev)
 {
 	return rtnl_dereference(dev->ingress_queue);
-- 
2.36.1


