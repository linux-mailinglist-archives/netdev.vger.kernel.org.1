Return-Path: <netdev+bounces-233412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626FAC12C88
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3215E24C0
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AD1285C8D;
	Tue, 28 Oct 2025 03:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QynrLoQ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E525A2857CA
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622722; cv=none; b=ZSnq4KpmURIwLWUyet3FahVn9edVq5NPYYC0tWww1yNAHef0K/43Tj0Fo4TNZAugsG+BRyQjKj2OiA8sZ5E+87u4aphnw8jYlP0nHFCV6fyMxZfGrGtPPhQ+JDWEbYTBHgS72UdjuYU+jMUzHZN+2lzEEuwMdXp3Kh4uch/h2co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622722; c=relaxed/simple;
	bh=hUlSA9xwj3wG76cHhech75bXpZt6DN7dWD3Vv6lWmbo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F2yNbdhx9DW62k4APtepTp0V/ozAAP6h7PVvQAYdKk8lP4fYMiMPtzt1+Cn6nVw5wdMmkgueCLgWb64s3PFBABTaXhoHLkYYO34u0iUbe4mGu2vYnaJlicIkONujGyeUq63TYlCDSe5Hc542E9SP0CeM8T7kfyIAbGVTY+kZkKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QynrLoQ+; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b55283ff3fcso3464391a12.3
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 20:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761622720; x=1762227520; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dSQjZU20BmwUT3/7fKtErHeJ9mTPv8sUY6SNSIJdiCM=;
        b=QynrLoQ+GuUgLm1DvT1XYxrTW7tiX1cmGuq5TebDUPb/DSvkbPUPSBgT47ufPaSY3l
         5Lz8ALWrEXVV7PlD1WofqHWZ0dm/h2efFnJvCclogiQQz9OYwCLzJje5o+gXj3LjYf+t
         jzRCsi8wBB7cca6ddPlLX6e20+STUZDKDFDygoH4ptGPKKL62dpmzJc/QpNyG2MV/pbS
         PmqA02NEQShnIi3cZCaCthIsX8TZM8k1ooBkMBg6c+ITW2r2/UGpc9XhynMEJAVhbm/O
         dCRPH4UoXq9nu8iBzSUX2mmq1Mow6GqNiQCdZ7tFQbjQ3N3hHjGz51buXiaNgfX0TGYr
         Il9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761622720; x=1762227520;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSQjZU20BmwUT3/7fKtErHeJ9mTPv8sUY6SNSIJdiCM=;
        b=AqfVrXFDpkbmLMt0YyBCAZR4kit99gqacMNiKugePd9VP5Jpa/XuwF7JGRVRGvsBMe
         BwCKMYAxf8LS9xMDKZmUtiWf91gR+EimURl0En959gI+Vwtv6kM3BM0paZMRYc+b79pp
         qrO70GneBhbfgE3fH/fT8Whfu+X2j3ca1dVR+P7JTeHRTd0NWAxziPIQd0rYtp7y6b+W
         RBeC86/ZWHF0szL3glnTHPwZ1VWR9p/BK263b6fV+FnZxVvTObgmZDzEVzpCkJlczIOr
         nJ4fV5KtVTtuPrC+cursGjia7rphVboU0dYqBdG4SoYvp44JEtEbtu3kgP16tGVA3KIH
         Gejw==
X-Forwarded-Encrypted: i=1; AJvYcCV/EG5wPPmdwVCsJz8qZvoeHBvN0y0mVopoD+v1cpq5XIDsed0QWxtevMqBnEMTY/TulZ5tx2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuuxryaqmUVeKTmZh1BVMtpPlsvz79xXqyV0f3FSdHQm5oj+ye
	FXo02ZuYvPut8EYMZG85vlMEnpFjVLJHtqKeaOQ8QSGKxX0CdOmPIgQyJJ/of1LYZULYe8DBIjk
	6jb1b3w==
X-Google-Smtp-Source: AGHT+IHTKRnhokvyCIHhnEDdXJWwbkVkPJuazsiVVr560bab3pRv9hN1lOHGqDSCopKAiBYGUdBR4Scfie4=
X-Received: from pjyd6.prod.google.com ([2002:a17:90a:dfc6:b0:33b:dd01:d6fc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:430b:b0:342:378e:44b5
 with SMTP id adf61e73a8af0-344d432826fmr2535062637.40.1761622720186; Mon, 27
 Oct 2025 20:38:40 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:37:04 +0000
In-Reply-To: <20251028033812.2043964-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028033812.2043964-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028033812.2043964-10-kuniyu@google.com>
Subject: [PATCH v1 net-next 09/13] mpls: Use mpls_route_input() where appropriate.
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
2.51.1.838.g19442a804e-goog


