Return-Path: <netdev+bounces-120928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB9F95B387
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D7D1F226B3
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785B2184547;
	Thu, 22 Aug 2024 11:11:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0C918453F;
	Thu, 22 Aug 2024 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724325067; cv=none; b=s2+Epgs01bx3MNlBtBUbcRQBEj9A0l4WgLkiqosCf8I6cOtI1ocG1ZHBkMfejmnMVTUWmVHH/nyClZmE4JHbjBIfJqXy/0ge92gc1Hrmf8oROO7YP5gnkIsB5F5NKuseb4G7Po1hwwtPFIcnT9Y1lTD9PppPIgK9SbQClY8X83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724325067; c=relaxed/simple;
	bh=M/PmFDpdZFaBf7+pWLNAYBuslNFTP9mFmrdhr859Z+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZbdnS7m2oaFKhTRWrxW142X9Mj5lcp50zRdwa060GoGZ6O4hAoiDAas5o3SxHuXlnuTsICAxLSnP1TTlI4UxZOqwkLQRysv6ujTFkm3rN0pRz9KaEUkp9sLldezfmjKXWi6TW0KkJtlbsEmBBozwnmNnjQMooV4AasJ/xk7N8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7ab5fc975dso82341366b.1;
        Thu, 22 Aug 2024 04:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724325064; x=1724929864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUXyWsZ9L+lxzJt/JKaoXYfJk6aufjVbNH6bOrUE/QY=;
        b=ndkhTZMxJcFJxXVQ8ddoimArSBdyY3Rojwmi/N/EdMoeGZwPtbOhp6okCh5a1DNelc
         EiEG4nPcTyOpjCfpbTONlMQRrxPGsXXqNhwrI0JEQX2J1xemSt26GN1iWAMsXgHT/RJM
         DB6N6lQgQsJbqexKjqv1sMFhSWsDMhFwWhD2jXzfRz5Q1yeI1nyTr7hbVJrso3LO4ns9
         T9apErpmZzsEdvOCTdWKPkzQj427n/P8362m36K+WPux8qVo58xEra/xjSmHzSc6uNc9
         JtY8K4wbqa/RHeYtyS/oujHSj3dlRLfur4+GNz6vS7DiQ15UrzsUQLDca50rtItT3f4q
         zQrw==
X-Forwarded-Encrypted: i=1; AJvYcCX9YHIFpkdAoSwy7By9aBIglvAO7l2AASa5gDhrALRHymb9Lijvk/rT81TG5qdDzja7ZnZABObwElyKTeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3hqvgaf4O9Q6XqmQiNE/UFqziobbaGBcp/3ItbUYmJ+iqrZ1r
	JlHSW0Sk8pCg+IFrFAZWld++cKCVh/FU73Sl9Tk6hk48konVby+u
X-Google-Smtp-Source: AGHT+IGdlMAV8iQTUrF/ulPlsHCFNyCUOE/hLu5HPUO4KineJYFOE6PhVFVuSf4v1mXj1tsnchqkuw==
X-Received: by 2002:a17:907:3f24:b0:a86:86f2:f3f1 with SMTP id a640c23a62f3a-a8686f2f635mr269638666b.27.1724325063438;
        Thu, 22 Aug 2024 04:11:03 -0700 (PDT)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2200bcsm104736266b.4.2024.08.22.04.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 04:11:02 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH net-next v3 1/2] netpoll: Ensure clean state on setup failures
Date: Thu, 22 Aug 2024 04:10:47 -0700
Message-ID: <20240822111051.179850-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240822111051.179850-1-leitao@debian.org>
References: <20240822111051.179850-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify netpoll_setup() and __netpoll_setup() to ensure that the netpoll
structure (np) is left in a clean state if setup fails for any reason.
This prevents carrying over misconfigured fields in case of partial
setup success.

Key changes:
- np->dev is now set only after successful setup, ensuring it's always
  NULL if netpoll is not configured or if netpoll_setup() fails.
- np->local_ip is zeroed if netpoll setup doesn't complete successfully.
- Added DEBUG_NET_WARN_ON_ONCE() checks to catch unexpected states.
- Reordered some operations in __netpoll_setup() for better logical flow.

These changes improve the reliability of netpoll configuration, since it
assures that the structure is fully initialized or totally unset.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index a58ea724790c..647db1e45548 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -626,12 +626,9 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 	const struct net_device_ops *ops;
 	int err;
 
-	np->dev = ndev;
-	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
-
 	if (ndev->priv_flags & IFF_DISABLE_NETPOLL) {
 		np_err(np, "%s doesn't support polling, aborting\n",
-		       np->dev_name);
+		       ndev->name);
 		err = -ENOTSUPP;
 		goto out;
 	}
@@ -649,7 +646,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 
 		refcount_set(&npinfo->refcnt, 1);
 
-		ops = np->dev->netdev_ops;
+		ops = ndev->netdev_ops;
 		if (ops->ndo_netpoll_setup) {
 			err = ops->ndo_netpoll_setup(ndev, npinfo);
 			if (err)
@@ -660,6 +657,8 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 		refcount_inc(&npinfo->refcnt);
 	}
 
+	np->dev = ndev;
+	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
 	npinfo->netpoll = np;
 
 	/* last thing to do is link it to the net device structure */
@@ -677,6 +676,7 @@ EXPORT_SYMBOL_GPL(__netpoll_setup);
 int netpoll_setup(struct netpoll *np)
 {
 	struct net_device *ndev = NULL;
+	bool ip_overwritten = false;
 	struct in_device *in_dev;
 	int err;
 
@@ -741,6 +741,7 @@ int netpoll_setup(struct netpoll *np)
 			}
 
 			np->local_ip.ip = ifa->ifa_local;
+			ip_overwritten = true;
 			np_info(np, "local IP %pI4\n", &np->local_ip.ip);
 		} else {
 #if IS_ENABLED(CONFIG_IPV6)
@@ -757,6 +758,7 @@ int netpoll_setup(struct netpoll *np)
 					    !!(ipv6_addr_type(&np->remote_ip.in6) & IPV6_ADDR_LINKLOCAL))
 						continue;
 					np->local_ip.in6 = ifp->addr;
+					ip_overwritten = true;
 					err = 0;
 					break;
 				}
@@ -787,6 +789,9 @@ int netpoll_setup(struct netpoll *np)
 	return 0;
 
 put:
+	DEBUG_NET_WARN_ON_ONCE(np->dev);
+	if (ip_overwritten)
+		memset(&np->local_ip, 0, sizeof(np->local_ip));
 	netdev_put(ndev, &np->dev_tracker);
 unlock:
 	rtnl_unlock();
-- 
2.43.5


