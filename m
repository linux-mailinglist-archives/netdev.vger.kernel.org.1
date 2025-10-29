Return-Path: <netdev+bounces-234104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD02C1C76E
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B86F734BD5D
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D19354AC5;
	Wed, 29 Oct 2025 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dccHOZvJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F3934FF4E
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759243; cv=none; b=VgAVZrPc1RMeJlv6OJ0weQh8JoYIrII0W+kZb6BBc9D3q56vO4X/BgeqAqYsGsHS9WS2vkjzTiEMYtT3NpbICQHyFmQnBXf5UwttzOzsfL814TBCE+wqH/+OcBV/N70BcD7XXc9+IMDs2vqUX54Wr5pg8JOBuzFoYPl/8LRT9jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759243; c=relaxed/simple;
	bh=uK9tlA9QMlE/NgkMgj6v52k6J67U8KLaWdn7aIGHmag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PyZ0+OfcbjhH5xhAUkS2yULTLKmB8N6btkbFaccPT3ldCkqAbVmwx6xzkIRxP4XhO92UzgkkyvV8LlWdc+lX3aPsCMAMsdh2H9DWvUJBOyiugIzwSjToekV2wRc7WrPPCasBxbRPfuFTzcecdkYwt3yo34Q+l7HGZAqaBOK2mgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dccHOZvJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2904e9e0ef9so1230285ad.3
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 10:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761759241; x=1762364041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q6rhepyps7eu0a27ARnpm5d4uPV7wKbQwoeQFp4b1bI=;
        b=dccHOZvJL9HPc5mD6/SFcUA9xNNc1VFbRtSBwo78AW1/PfqQNqto5yepB/AhqA1BA5
         Mow09bD0WWraMgTOPRh5fAAYupZNXdgQOPn+f1mf9ocAcHJyH+Q1j/rG8BdFUb+PBv2y
         DmKQHv/XN6t2ndqW6pSLGPFRx3Vt8/a2Nm6124uzXELhIKbg27jryvntZ5xIc0hhSLFC
         BBfNGXuNxMYZcmgNJZRAhrQrDvwJ1bLAmq0AVHgtS3pWOHk0wHNFKNV+seVzM0Z/ex8g
         Q9q0EuaeoDN3YOxpcQxR/Lp5B1GubFnTBQD60c3l2pzFZchq303G5eFwt+TTQaoPADlk
         6bcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759241; x=1762364041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6rhepyps7eu0a27ARnpm5d4uPV7wKbQwoeQFp4b1bI=;
        b=rkEIQHAaMwyNX70iekNIbIG+ha4saHMspRX675/EvK4GRNrF1aW0CVTS4Tpdp/gO81
         zC/hLm0hHtXguOLGwVLloNK8HRF3M2YrT4U23ujNvBm+77Pz5dTyKzBBRUXJn98NNxjG
         JlvByx7bNLVdK4XV69wM/pfY14DZYM1hTUDjNTgaNZRVuj56pYRWcX+BVYRm0v46TS/e
         RlxYL1AJbZ89XFyAjWEFvRSrg9T7AAXOBTAYKDPo66ft6ADnVZzg59dNXQ0TbLDAz+09
         VQDN3P/QUf2WOVClIVEfJ8ZAaL+UTnUzesAKUfqHZ+fa1SPEJfJfUiaU7KoRSJRD+NUz
         zRVw==
X-Forwarded-Encrypted: i=1; AJvYcCXg6n/iaKi4gnqV+x6LjicuCtu+vX73I7h7wnEZnnBwPRFDj3JBIUjBaRA+n7KNhph8hhfwbr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwomJw/ZeOmyx/xLqU2BniWuhGtmpgRMHwrba/3mrRO1DIFNsek
	iRtEl4Ce4ccEcXPEuhJAELELNKxxvyEcLLXVXAcDZoU950YXH1PpCF44CQ5gFb9Djiv5CY3GBuj
	/L0KJ6g==
X-Google-Smtp-Source: AGHT+IE0cmqxws2I/IdlDqQIhyENNWvR3A+XWIK6Ku3DzrjITLn3fgtAdbnoV0Zyy4OPLQ/brq7li33lS/M=
X-Received: from plok4.prod.google.com ([2002:a17:903:3bc4:b0:25e:8dce:6855])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce8c:b0:25c:d4b6:f119
 with SMTP id d9443c01a7336-294dedd430emr49914285ad.12.1761759240915; Wed, 29
 Oct 2025 10:34:00 -0700 (PDT)
Date: Wed, 29 Oct 2025 17:33:01 +0000
In-Reply-To: <20251029173344.2934622-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029173344.2934622-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029173344.2934622-10-kuniyu@google.com>
Subject: [PATCH v2 net-next 09/13] mpls: Use mpls_route_input() where appropriate.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In many places, we uses rtnl_dereference() twice for
net->mpls.platform_label and net->mpls.platform_label[index].

Let's replace the code with mpls_route_input().

We do not use mpls_route_input() in mpls_dump_routes() since
we will rely on RCU there.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mpls/af_mpls.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 530f7e6f7b3c..35ae3dbd7bdc 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -590,19 +590,17 @@ static void mpls_route_update(struct net *net, unsigned index,
 	mpls_rt_free(rt);
 }
 
-static unsigned find_free_label(struct net *net)
+static unsigned int find_free_label(struct net *net)
 {
-	struct mpls_route __rcu **platform_label;
-	size_t platform_labels;
-	unsigned index;
+	unsigned int index;
 
-	platform_label = rtnl_dereference(net->mpls.platform_label);
-	platform_labels = net->mpls.platform_labels;
-	for (index = MPLS_LABEL_FIRST_UNRESERVED; index < platform_labels;
+	for (index = MPLS_LABEL_FIRST_UNRESERVED;
+	     index < net->mpls.platform_labels;
 	     index++) {
-		if (!rtnl_dereference(platform_label[index]))
+		if (!mpls_route_input(net, index))
 			return index;
 	}
+
 	return LABEL_NOT_SPECIFIED;
 }
 
@@ -985,7 +983,6 @@ static bool mpls_label_ok(struct net *net, unsigned int *index,
 static int mpls_route_add(struct mpls_route_config *cfg,
 			  struct netlink_ext_ack *extack)
 {
-	struct mpls_route __rcu **platform_label;
 	struct net *net = cfg->rc_nlinfo.nl_net;
 	struct mpls_route *rt, *old;
 	int err = -EINVAL;
@@ -1013,8 +1010,7 @@ static int mpls_route_add(struct mpls_route_config *cfg,
 	}
 
 	err = -EEXIST;
-	platform_label = rtnl_dereference(net->mpls.platform_label);
-	old = rtnl_dereference(platform_label[index]);
+	old = mpls_route_input(net, index);
 	if ((cfg->rc_nlflags & NLM_F_EXCL) && old)
 		goto errout;
 
@@ -1503,16 +1499,15 @@ static void mpls_dev_destroy_rcu(struct rcu_head *head)
 
 static int mpls_ifdown(struct net_device *dev, int event)
 {
-	struct mpls_route __rcu **platform_label;
 	struct net *net = dev_net(dev);
-	unsigned index;
+	unsigned int index;
 
-	platform_label = rtnl_dereference(net->mpls.platform_label);
 	for (index = 0; index < net->mpls.platform_labels; index++) {
-		struct mpls_route *rt = rtnl_dereference(platform_label[index]);
+		struct mpls_route *rt;
 		bool nh_del = false;
 		u8 alive = 0;
 
+		rt = mpls_route_input(net, index);
 		if (!rt)
 			continue;
 
@@ -1583,15 +1578,14 @@ static int mpls_ifdown(struct net_device *dev, int event)
 
 static void mpls_ifup(struct net_device *dev, unsigned int flags)
 {
-	struct mpls_route __rcu **platform_label;
 	struct net *net = dev_net(dev);
-	unsigned index;
+	unsigned int index;
 	u8 alive;
 
-	platform_label = rtnl_dereference(net->mpls.platform_label);
 	for (index = 0; index < net->mpls.platform_labels; index++) {
-		struct mpls_route *rt = rtnl_dereference(platform_label[index]);
+		struct mpls_route *rt;
 
+		rt = mpls_route_input(net, index);
 		if (!rt)
 			continue;
 
-- 
2.51.1.851.g4ebd6896fd-goog


