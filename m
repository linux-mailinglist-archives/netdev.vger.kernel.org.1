Return-Path: <netdev+bounces-42841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 649707D0612
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 03:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA484B21503
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 01:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600FE638;
	Fri, 20 Oct 2023 01:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqAhyEQD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404C939E
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 01:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BA9C433C9;
	Fri, 20 Oct 2023 01:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697764738;
	bh=jwf0kIkzjClGiJzzxrsDWzhWMg0TOqyIQL/vjbwvzwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PqAhyEQDGWBvS0/bASrp1K2q1oVryM2UDQ5tP1ZmDz7Xe1y0n6ns75ch+WJj1M86j
	 +svbHUxQerWLDr/6dOsL4/9N9HnGGQFx0H6cDi9OUSE11ynL869pNCJKJLWcycKyLr
	 IPweU8k5LODuEZIptOciyMx/DRZnrMHBaUpHmC1AlQCJP1xz6bxNaPrCmEp4MyCopd
	 3uiSVPulmzhfZRlsEMqlDXzov8GU+9Jk0EfuS44c3TunQlQmwiDfqx4fZPLEquBwak
	 eAqa7XtmcIkSCDbCXgVFpq3FFLCJZOQ8ACRkH+v5FOkvC3h1Ao4FEzwq5Blp+yirQt
	 BhDoAhZ7SXKrw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	johannes.berg@intel.com,
	mpe@ellerman.id.au,
	j@w1.fi,
	jiri@resnulli.us
Subject: [PATCH net-next 1/6] net: don't use input buffer of __dev_alloc_name() as a scratch space
Date: Thu, 19 Oct 2023 18:18:51 -0700
Message-ID: <20231020011856.3244410-2-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020011856.3244410-1-kuba@kernel.org>
References: <20231020011856.3244410-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers of __dev_alloc_name() want to pass dev->name as
the output buffer. Make __dev_alloc_name() not clobber
that buffer on failure, and remove the workarounds
in callers.

dev_alloc_name_ns() is now completely unnecessary.

The extra strscpy() added here will be gone by the end
of the patch series.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1025dc79bc49..874c7daa81f5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1057,7 +1057,7 @@ EXPORT_SYMBOL(dev_valid_name);
  *	__dev_alloc_name - allocate a name for a device
  *	@net: network namespace to allocate the device name in
  *	@name: name format string
- *	@buf:  scratch buffer and result name string
+ *	@res: result name string
  *
  *	Passed a format string - eg "lt%d" it will try and find a suitable
  *	id. It scans list of devices to build up a free map, then chooses
@@ -1068,13 +1068,14 @@ EXPORT_SYMBOL(dev_valid_name);
  *	Returns the number of the unit assigned or a negative errno code.
  */
 
-static int __dev_alloc_name(struct net *net, const char *name, char *buf)
+static int __dev_alloc_name(struct net *net, const char *name, char *res)
 {
 	int i = 0;
 	const char *p;
 	const int max_netdevices = 8*PAGE_SIZE;
 	unsigned long *inuse;
 	struct net_device *d;
+	char buf[IFNAMSIZ];
 
 	if (!dev_valid_name(name))
 		return -EINVAL;
@@ -1124,8 +1125,10 @@ static int __dev_alloc_name(struct net *net, const char *name, char *buf)
 	}
 
 	snprintf(buf, IFNAMSIZ, name, i);
-	if (!netdev_name_in_use(net, buf))
+	if (!netdev_name_in_use(net, buf)) {
+		strscpy(res, buf, IFNAMSIZ);
 		return i;
+	}
 
 	/* It is possible to run out of possible slots
 	 * when the name is long and there isn't enough space left
@@ -1154,20 +1157,6 @@ static int dev_prep_valid_name(struct net *net, struct net_device *dev,
 	return 0;
 }
 
-static int dev_alloc_name_ns(struct net *net,
-			     struct net_device *dev,
-			     const char *name)
-{
-	char buf[IFNAMSIZ];
-	int ret;
-
-	BUG_ON(!net);
-	ret = __dev_alloc_name(net, name, buf);
-	if (ret >= 0)
-		strscpy(dev->name, buf, IFNAMSIZ);
-	return ret;
-}
-
 /**
  *	dev_alloc_name - allocate a name for a device
  *	@dev: device
@@ -1184,20 +1173,14 @@ static int dev_alloc_name_ns(struct net *net,
 
 int dev_alloc_name(struct net_device *dev, const char *name)
 {
-	return dev_alloc_name_ns(dev_net(dev), dev, name);
+	return __dev_alloc_name(dev_net(dev), name, dev->name);
 }
 EXPORT_SYMBOL(dev_alloc_name);
 
 static int dev_get_valid_name(struct net *net, struct net_device *dev,
 			      const char *name)
 {
-	char buf[IFNAMSIZ];
-	int ret;
-
-	ret = dev_prep_valid_name(net, dev, name, buf);
-	if (ret >= 0)
-		strscpy(dev->name, buf, IFNAMSIZ);
-	return ret;
+	return dev_prep_valid_name(net, dev, name, dev->name);
 }
 
 /**
-- 
2.41.0


