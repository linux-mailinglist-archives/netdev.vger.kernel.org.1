Return-Path: <netdev+bounces-107302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BC591A828
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B45E281C13
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C119F1946BA;
	Thu, 27 Jun 2024 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tlIWuaUk"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6921946B0
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719495717; cv=none; b=jm1EWxOCpyAitSs0+qXK8WeC6di5yowLIAJpiGU3XeZwhGRdg+VoS/56oyZlp4v+lgmvJaTpPaLcCl2T8Iq+f7tkzpDSqZROpa36Ng+A8fYJ6sRxmhSceW/XXH/MMPWYOKuxFVrufDsbJHXz4AeGWkSRC0tE/ph+SxkdH9oZOfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719495717; c=relaxed/simple;
	bh=LvnwTTVBC8Pm58VGJIqSPohg+jb8ST48pPrk5lkB638=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WIJyk1zK+Hs1YkyZQgr7r1HGgvasudyhwBxGnjegnZCtPk9D669G5Y7RV7XVAD61i/K0jFoRFeM1X3aEkOAuWDSbsC1ZNpHBMtRCSch7W0m+oorlR9SLYcOH/OCU9JlXMVp4PRUEPrl2fOc9hJG26rYtdZrL9949Omvnez0Koeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tlIWuaUk; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: davem@davemloft.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719495713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OnzNShyOnYC0lhEHFrSf9wHqYEcOBjNwOI0BR7nekY0=;
	b=tlIWuaUk1W/Cq/3WtLCpX5chO/ckgwGmFjqK16Q8P5kyczuuDkqvR1o1Q0b+eHDlhKtw9d
	XR5/rREOhMf2987SBsUyjcZELDz7EoPNBqMEOU+bHvvKcJUoHucnvVMFvnkNcgR6bDxGkJ
	DnD/CCc95Cx3Tc7wwRINmgBJfIvblnU=
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: yajun.deng@linux.dev
X-Envelope-To: jiri@nvidia.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next v2] net: core: Remove the dup_errno parameter in dev_prep_valid_name()
Date: Thu, 27 Jun 2024 21:41:31 +0800
Message-Id: <20240627134131.3018-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

netdev_name_in_use() in dev_prep_valid_name() return -EEXIST makes
more sense if it's not NULL, but dev_alloc_name() should keep the
-ENFILE errno.

There are three callers to dev_prep_valid_name(), the dup_errno
parameter is only for dev_alloc_name, it's not necessary for the other
callers.

Remove the dup_errno parameter in dev_prep_valid_name() and add a
conditional operator to dev_alloc_name(), replace -EEXIST with
-ENFILE.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
v2: Make the commit more detailed.
v1: https://lore.kernel.org/all/20240618131743.2690-1-yajun.deng@linux.dev/
---
 net/core/dev.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0a23d7da7fbc..00e8c785e5ee 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1153,8 +1153,7 @@ static int __dev_alloc_name(struct net *net, const char *name, char *res)
 
 /* Returns negative errno or allocated unit id (see __dev_alloc_name()) */
 static int dev_prep_valid_name(struct net *net, struct net_device *dev,
-			       const char *want_name, char *out_name,
-			       int dup_errno)
+			       const char *want_name, char *out_name)
 {
 	if (!dev_valid_name(want_name))
 		return -EINVAL;
@@ -1163,7 +1162,7 @@ static int dev_prep_valid_name(struct net *net, struct net_device *dev,
 		return __dev_alloc_name(net, want_name, out_name);
 
 	if (netdev_name_in_use(net, want_name))
-		return -dup_errno;
+		return -EEXIST;
 	if (out_name != want_name)
 		strscpy(out_name, want_name, IFNAMSIZ);
 	return 0;
@@ -1185,7 +1184,10 @@ static int dev_prep_valid_name(struct net *net, struct net_device *dev,
 
 int dev_alloc_name(struct net_device *dev, const char *name)
 {
-	return dev_prep_valid_name(dev_net(dev), dev, name, dev->name, ENFILE);
+	int ret;
+
+	ret = dev_prep_valid_name(dev_net(dev), dev, name, dev->name);
+	return ret == -EEXIST ? -ENFILE : ret;
 }
 EXPORT_SYMBOL(dev_alloc_name);
 
@@ -1194,7 +1196,7 @@ static int dev_get_valid_name(struct net *net, struct net_device *dev,
 {
 	int ret;
 
-	ret = dev_prep_valid_name(net, dev, name, dev->name, EEXIST);
+	ret = dev_prep_valid_name(net, dev, name, dev->name);
 	return ret < 0 ? ret : 0;
 }
 
@@ -11446,7 +11448,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 		/* We get here if we can't use the current device name */
 		if (!pat)
 			goto out;
-		err = dev_prep_valid_name(net, dev, pat, new_name, EEXIST);
+		err = dev_prep_valid_name(net, dev, pat, new_name);
 		if (err < 0)
 			goto out;
 	}
-- 
2.25.1


