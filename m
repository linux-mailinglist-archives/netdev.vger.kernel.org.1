Return-Path: <netdev+bounces-144288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FB39C672B
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 03:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB771F21A38
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 02:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3584C13BAE7;
	Wed, 13 Nov 2024 02:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="bMEjZzhl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B2613A3EC
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 02:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731464292; cv=none; b=MegOS/9zUJHSQYP0YU+NOdUC3ylyD6gNnPyJB2Ya32awNZsAUmwd5d3g4zPRvQjIHwZ8bQtKgqfNWlj8vemQIlCKAPDhHmYQD4WUUvDPkU63v6UkY/bleYzUhEYKhc+MwNf5IudGvBc9VNn6R4FimqAiaLcIeUo+JMN54ZBSwf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731464292; c=relaxed/simple;
	bh=VBaKG7sS3+bFmnPdr4IqHzNMfBCmbNJFBokvNs/FN3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dNypBqY0v5muNZFFEANPdhOeZ63aU/XJMMbpWskAjFKXdwLiTgKHecRHkwfQ3j/h7XvSGwoTHcjd8ExZQaN0CNd/WJ+a3NFEkzM9elSwtMbX311ASYd4HCPwlxbSv/AQTEkpovp+6wHfLz5clgW9D9hbflJCIbnXaDjx+t7BCF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=bMEjZzhl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c8c50fdd9so1894205ad.0
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 18:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731464290; x=1732069090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKBid5QRb/kAhtogYHDhzeEdvI0mEg25tnKEi7AhX6E=;
        b=bMEjZzhlgYy/rZ2YCX43m3dvJcUX3qf5Uaw/8u2QHOO1vMxh9rTOFCCj6QyXpbUDGj
         3OJt3fEKv3UOIANBiLDF6Hc8U5eaILVZVrTjmWfCyi/89gw07/zEf/UcxvQ1kGoBD59+
         35KUcBSC3gycZNUgvodM4+Mxsd5JGd3HeFmwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731464290; x=1732069090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKBid5QRb/kAhtogYHDhzeEdvI0mEg25tnKEi7AhX6E=;
        b=n+9tjvsOdmb9K+NYarfjTR9zCS690DN8s0m99e8O/9S1AKVEkk4fIWRraWM7K//8wP
         CsyI76hEKIStKpqhmhVSxWqgE7X81Z63pOVJPq0RSGvbnPcjUJwHo66aKdF5aItwyoK9
         vs6gMaR7VRgpMlQ3P5DhbzwGgWUbpYR9WPQL+Hy/pFvGaLqo558zmhgoYfuH0Bit3rmX
         78TD8sHXBM8WlIDZtERgHGZxLfRu7GkmFFDL9el6MvOuKaZ8FNT6NoSJfSkl0JEU1EIe
         Ed1YM/UGbI/445ShxCoE1iWShhxhSP4O65EQpuO4OrP2mL+KhaZlBxuQvsvMEfFJMu/l
         7jpA==
X-Gm-Message-State: AOJu0Yw+RDXcY7nFRSl2uv1ti4yVSr3sFUeZ+LVVpqKR5o6JcCTt/zSD
	2L1dmxHjYZUzxZc/7ytN2/VNidwvzEpCjyOWnfE4BEJMUMDMgUL65BGA1Zu17hktppvx6ltKTTD
	kJLl26vTvANx4CUpFHnRQE93Rl5fYjXo7fbwkvncM7Y8PlMTee3I4BmrN/LZmFuqipfLAMmP8rv
	1Lt8O5Q08+MjZJsE7BJI5lDHwtWfFP5Yyhiq0=
X-Google-Smtp-Source: AGHT+IHI5KSL7qnXQ088ADYDMAiYRAqIH80E+3/aTvBMuDhB8SyMPvP3rnQzeByPamSOepx19J3iNA==
X-Received: by 2002:a17:903:228d:b0:20c:5d5a:af6f with SMTP id d9443c01a7336-211836e6dcemr267759715ad.10.1731464289523;
        Tue, 12 Nov 2024 18:18:09 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dcb1dfsm100209505ad.14.2024.11.12.18.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 18:18:09 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net v2 1/2] netdev-genl: Hold rcu_read_lock in napi_get
Date: Wed, 13 Nov 2024 02:17:51 +0000
Message-Id: <20241113021755.11125-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241113021755.11125-1-jdamato@fastly.com>
References: <20241113021755.11125-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hold rcu_read_lock in netdev_nl_napi_get_doit, which calls napi_by_id
and is required to be called under rcu_read_lock.

Cc: stable@vger.kernel.org
Fixes: 27f91aaf49b3 ("netdev-genl: Add netlink framework functions for napi")
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 v2:
   - Simplified by removing the helper and calling rcu_read_lock /
     unlock directly instead.

 net/core/netdev-genl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 765ce7c9d73b..0b684410b52d 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -233,6 +233,7 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 		return -ENOMEM;
 
 	rtnl_lock();
+	rcu_read_lock();
 
 	napi = napi_by_id(napi_id);
 	if (napi) {
@@ -242,6 +243,7 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 		err = -ENOENT;
 	}
 
+	rcu_read_unlock();
 	rtnl_unlock();
 
 	if (err)
-- 
2.25.1


