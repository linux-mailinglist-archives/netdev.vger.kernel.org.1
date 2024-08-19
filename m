Return-Path: <netdev+bounces-119666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13CB9568A4
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9ED28193B
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F9E165F06;
	Mon, 19 Aug 2024 10:36:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576F815B972;
	Mon, 19 Aug 2024 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063789; cv=none; b=CGC78RK/7NxP2B5oMbMKDDQ20zeYF46eHtr1sq2sXoRVuUPrE4cmk7kTaS1tshdwuOEp2KE+d4v7+PPB8hFkXSnTyudIdY7/7hK0ZksCBQ+9DCMWtB0Wxd6RFgcexfvcQuTyA8Tv27oIg+Y391wEZRiGX++P6k6RMZcNflSGEOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063789; c=relaxed/simple;
	bh=GSSumoePGy/k2KhOJ0WiruHhGU8APi0PaNgrZE9NWRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMxdmNe04JQmFOjJr8SdPpYRrz3P+Ikk1xTLgk5YqfcZ5j1AnbEj66UoaMrLIptlqC3hL0oDoJj8t4lhhhoNsSqGISz2FlmHAuOo8wMQjtdpdvrXNJkVCLFay/BZnnqsqceM4wJxVO/1WznUsyhSMBhQ/WURktxjrCEInGHfKx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef23d04541so50273061fa.2;
        Mon, 19 Aug 2024 03:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724063785; x=1724668585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYTB7lUCin1+ML6M/dmlT1uvokEWXxQUZVupmBcApdc=;
        b=ivi2LTfp4GqgNK2kyr+cFWy914GcOrbO5FC4189WkTv7bU3DU3WbbixzFfG50kEru2
         wJP09imkxLLcoA10SPmk+mGPo6IJD6pEiZ2RFOOlB2cMbfAifNp78+ikWJ+ACuWQ4wCu
         /dvTWEQUfjog7cbXeMEV+t3xo3PSqtDYTvtYMmsXQAO66A6+wb7E727/yiV3sYiUAiGh
         PKP2vVXIkkcBSzOncIqwj+5zixFDbnviLGRdYP25GZhU9M4r9bsOkyHNNRntlALwXYzI
         nRTaxqDRF0ADos+Pd+Xh+qNN7xNjX9o6yP2iT/FxntTsTvlXTvhSxBzExLNIIQILj1N/
         MBdw==
X-Forwarded-Encrypted: i=1; AJvYcCXo94XUkaHpdV9hcD4MIDIHZYQF6IP0I5wwzhdp6v0K904hp+/qdqyqOXqqw0qjio07y/TZ749mJIHhRf3U2tgM3TzbgGd2JSMSkf0X
X-Gm-Message-State: AOJu0Yz/0UfWxLFKEy24HLrPRP8X5kRSMobSKun+/dFYd0h3qDfxj0XB
	uxAVNrqKPlF8dAcFhWKNeo2rb9ahlthSS5vPaVl+n1T2rIc1mgD4
X-Google-Smtp-Source: AGHT+IE+e0XTwBYtDKtsWVK5dTzQxesFBt5NXqXyTAbOtR50JIQ3BFITMTPjGnzBOlRh7WqVMb1IoQ==
X-Received: by 2002:a2e:9d44:0:b0:2f0:1fd5:2f29 with SMTP id 38308e7fff4ca-2f3be586ab8mr67293721fa.19.1724063784943;
        Mon, 19 Aug 2024 03:36:24 -0700 (PDT)
Received: from localhost (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5becf1f3442sm3997799a12.31.2024.08.19.03.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 03:36:24 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH net-next v2 1/3] netpoll: Ensure clean state on setup failures
Date: Mon, 19 Aug 2024 03:36:11 -0700
Message-ID: <20240819103616.2260006-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240819103616.2260006-1-leitao@debian.org>
References: <20240819103616.2260006-1-leitao@debian.org>
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
 net/core/netpoll.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index a58ea724790c..c5577d250a21 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -626,12 +626,10 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 	const struct net_device_ops *ops;
 	int err;
 
-	np->dev = ndev;
-	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
-
+	DEBUG_NET_WARN_ON_ONCE(np->dev);
 	if (ndev->priv_flags & IFF_DISABLE_NETPOLL) {
 		np_err(np, "%s doesn't support polling, aborting\n",
-		       np->dev_name);
+		       ndev->name);
 		err = -ENOTSUPP;
 		goto out;
 	}
@@ -649,7 +647,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 
 		refcount_set(&npinfo->refcnt, 1);
 
-		ops = np->dev->netdev_ops;
+		ops = ndev->netdev_ops;
 		if (ops->ndo_netpoll_setup) {
 			err = ops->ndo_netpoll_setup(ndev, npinfo);
 			if (err)
@@ -660,6 +658,8 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 		refcount_inc(&npinfo->refcnt);
 	}
 
+	np->dev = ndev;
+	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
 	npinfo->netpoll = np;
 
 	/* last thing to do is link it to the net device structure */
@@ -677,6 +677,7 @@ EXPORT_SYMBOL_GPL(__netpoll_setup);
 int netpoll_setup(struct netpoll *np)
 {
 	struct net_device *ndev = NULL;
+	bool ip_overwritten = false;
 	struct in_device *in_dev;
 	int err;
 
@@ -740,6 +741,7 @@ int netpoll_setup(struct netpoll *np)
 				goto put;
 			}
 
+			ip_overwritten = true;
 			np->local_ip.ip = ifa->ifa_local;
 			np_info(np, "local IP %pI4\n", &np->local_ip.ip);
 		} else {
@@ -757,6 +759,7 @@ int netpoll_setup(struct netpoll *np)
 					    !!(ipv6_addr_type(&np->remote_ip.in6) & IPV6_ADDR_LINKLOCAL))
 						continue;
 					np->local_ip.in6 = ifp->addr;
+					ip_overwritten = true;
 					err = 0;
 					break;
 				}
@@ -787,6 +790,9 @@ int netpoll_setup(struct netpoll *np)
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


