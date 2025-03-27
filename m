Return-Path: <netdev+bounces-177965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AAEA733B5
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81290189B380
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC062185BD;
	Thu, 27 Mar 2025 13:57:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301F2218823
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743083838; cv=none; b=udDx8tEhWbMMQI2KVJQO24lSAYVpON2lSHgToxT9VsC9I4IZW6PHkpwSqRHV+iWDlg818ldrwHCx9ozFIXwnXQ6Eu3kZYJM5Aux/TDuT/ojBqA292RwMF6TuQjeTvdylSDnGI31LlzO90wZPpaJSVrZGoHiQSj+sZh1AfiFw+vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743083838; c=relaxed/simple;
	bh=CUR5I3UpwjbNO0hNnmCCSuAoAxW+HdofdbYjgHwMqZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAhufHTAfSJUkJWNVUoW35hl1sSaTtDGBygXvBFBImLxpHBn5iahSOF1qj3y58E9XYHIOllQywND2szHocq2dEbiRpsdL00T9xTPOjA99iqdWLVzIEbTcs6s4SL1+3U12PJ2idiv5au72v6Gf3wg60hZrDujaAHeo0P0c6VG5wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22401f4d35aso22773075ad.2
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 06:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743083836; x=1743688636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knTGk9lxkObf5m8zJBEYc+FoI0axfDUQp9+wJSH7C6k=;
        b=BnJzk/3patT4i3Z+XGB5vRhselNe2YihUBF7fyKUUYVpX6+AMf33Mmv/Q/l4in19HX
         Kql/qD0gU1VntKBWjxZH3sbdR4Ni8SoyugdPUNEv5XBNz+7R/nRWoZ79bNB/CoxelpOV
         x+0kOFF2uUn+fF3B+vP8dXfHVhEPDRu2eJ+o/aV+f6TY1MH4anwQAPCbsxERlUWYIlFQ
         JK91gBd969ePZLt548cB5q1wadnFHPmcW51k6EY9onm33gJ2teC7p/cVTZS8dOTd54rY
         47gfzuF1aeoFghiJTwUFAnw+BNgOsox3fVDxlRAmzGd8Y5JtL1lh9pOtLI0/KxGq+99+
         L4oA==
X-Gm-Message-State: AOJu0YxMz5vjpl+fzI2L+141XbhIr7+8/3YH1zaYzxryU6pcEl/z1Zaz
	50fWGrapDZBrmpeco8jSHL0yShNNZ8Bp4z/wGEG5/lO4YlUcRdGXktGyv5ho8A==
X-Gm-Gg: ASbGncuWYGfOmCjGodtO6xXlZtENolKos7uF1Pcsl0wlAWnKxR4J9pt+p21lIIovP12
	YAGuNVyO0FGnNbUnSWmhDw3qe+TMwaPWEA/9HRxt2RPfuKQ/wa6R1kJiT2lia/iy3GRrLcG3BkR
	mKWum2sBTjcGapRaX+/5XAp6QD86nL4w9dQ8W9sYVD4l/LCF7Jlg2cYfkUmYZeuW6BjYZSpG+qZ
	a3baIfMn84ctcrOSKY4CEfoGaIzX0MllkbqJcto6RnrnY9b5LZlG4SqD3rvukHYJcRjO3JT0na6
	XkgdN9ICy7Ic07vPEkj1JIK2VkGsGePXPYwNfhXnBvUr
X-Google-Smtp-Source: AGHT+IF0peGQVF7L4jTD8/d4Sadc653SulLHWWDndc7X5zqxyggPMPOgIs7sa8KrcOZurBIkzifbYA==
X-Received: by 2002:a05:6a21:618f:b0:1f5:59e5:8ad2 with SMTP id adf61e73a8af0-1fea2e9f4aamr7367098637.24.1743083836053;
        Thu, 27 Mar 2025 06:57:16 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af8a2a23634sm12786656a12.60.2025.03.27.06.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 06:57:15 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v2 11/11] netdev: don't hold rtnl_lock over nl queue info get when possible
Date: Thu, 27 Mar 2025 06:56:59 -0700
Message-ID: <20250327135659.2057487-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327135659.2057487-1-sdf@fomichev.me>
References: <20250327135659.2057487-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Netdev queue dump accesses: NAPI, memory providers, XSk pointers.
All three are "ops protected" now, switch to the op compat locking.
rtnl lock does not have to be taken for "ops locked" devices.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/netdev-genl.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index fd1cfa9707dc..39f52a311f07 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -481,18 +481,15 @@ int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!rsp)
 		return -ENOMEM;
 
-	rtnl_lock();
-
-	netdev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
+	netdev = netdev_get_by_index_lock_ops_compat(genl_info_net(info),
+						     ifindex);
 	if (netdev) {
 		err = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
-		netdev_unlock(netdev);
+		netdev_unlock_ops_compat(netdev);
 	} else {
 		err = -ENODEV;
 	}
 
-	rtnl_unlock();
-
 	if (err)
 		goto err_free_msg;
 
@@ -541,17 +538,17 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	if (info->attrs[NETDEV_A_QUEUE_IFINDEX])
 		ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
 
-	rtnl_lock();
 	if (ifindex) {
-		netdev = netdev_get_by_index_lock(net, ifindex);
+		netdev = netdev_get_by_index_lock_ops_compat(net, ifindex);
 		if (netdev) {
 			err = netdev_nl_queue_dump_one(netdev, skb, info, ctx);
-			netdev_unlock(netdev);
+			netdev_unlock_ops_compat(netdev);
 		} else {
 			err = -ENODEV;
 		}
 	} else {
-		for_each_netdev_lock_scoped(net, netdev, ctx->ifindex) {
+		for_each_netdev_lock_ops_compat_scoped(net, netdev,
+						       ctx->ifindex) {
 			err = netdev_nl_queue_dump_one(netdev, skb, info, ctx);
 			if (err < 0)
 				break;
@@ -559,7 +556,6 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 			ctx->txq_idx = 0;
 		}
 	}
-	rtnl_unlock();
 
 	return err;
 }
-- 
2.48.1


