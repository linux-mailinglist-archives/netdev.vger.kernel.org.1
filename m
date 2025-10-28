Return-Path: <netdev+bounces-233410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AF2C12C6A
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5380A1AA6CEF
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9692848AF;
	Tue, 28 Oct 2025 03:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AfiBR3Wb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA9F27E7F0
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622719; cv=none; b=pYtgMxQmwmGF/fxkYmZcb8Vs//S1qsy0sgv6QOo2FeEHjmOT8Rfr/g589GqiF9za9jDieX10PJP4IjeHqNKD1WvbtP/12ostgjt+1Hrx/EA/MfoQFTqg+VrFZWb+0tU6Xg7Kx0PjFrz1o/wcOOxDDtHoZGGSnPRUnqpNxYTF/mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622719; c=relaxed/simple;
	bh=Ciy85sL/Ok8WRgT++rHLwRqkbPGQQI9Af6kG6VtjlpM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Drh9aRnUSNereXnG14Lj+cqwSul4L17VIBo4W0K0skV2ZQzOk1okFyELXUBh20RHXOlrODde1/5lMusaQbgDxiRm9nsXQNeGhyIK/1OfT0Qr7R7usHvf4GGrQHznB3/5iZXHGBrkdH9ArkaRpQ/7TiAuDgPjYasufEOT/aC45DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AfiBR3Wb; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b62ebb4e7c7so4186304a12.3
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 20:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761622717; x=1762227517; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KAS+ToV0wmB6/IwwMCqaHREdhZGb/0nnGDLX49eqJ2A=;
        b=AfiBR3WbMlZGcsspUUQUEMEsuPFZh1SfdN2c11A4ltAi5SVQck0TWM3kdzTgFy3mwN
         feMcbtWHdkFerHnMLZbCBkBjrtLgwv/3l2DZYzrrzO1Qha3U++4ejmEqFj3PnU2GsuMz
         0O7RjfIxXmgqz1phozYh1H4ii81ptsneof0S42NvEiS/RJRFfvtuCBc+kNXAcdNRXW1F
         l1FMYqjlLWBOMJXkY609QnLnJRmp9oETST0+XkRe694w4s0yMlnuOqcmAJmimtr1FpCk
         zvPN1RbxNSHiQXGkhkU3jhGXrFBi/Si8s5HSsZGWEpasvbv1414+ylGmELxJVUkFPnkU
         YOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761622717; x=1762227517;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KAS+ToV0wmB6/IwwMCqaHREdhZGb/0nnGDLX49eqJ2A=;
        b=F/MWEQeay5HP02XrA0hVyybah3gcyPO0LXAzZOcRQtymcCI6D3rSnrGUSvr0oq/RDT
         bJqKynAajtp6C8LdYfAXFuv6JR0PMX8+K45u3lJWzyzYql3ssDF7DtPId7R8YNlnSYV7
         meE7pFvhHcF7WRnbmT6bIaEGrILBp0+2F3vtyrd9qXPmkxRplAXkXNEK8gzUHkPQ9tUi
         sUPYZ7BXM+DLufPMOgjYhezClO42lR2uHzKD39HCYhm/kCGSzoW4LqTNp6rtL87Sajw5
         0JDO00y+DVgrPAwjs/3U1+8E3o9wbODuGxjnAp6DO6ogAUXBef+Jd6bvaa4MpByuDBxZ
         K2xw==
X-Forwarded-Encrypted: i=1; AJvYcCVxX/nPBljmNxEpTaGjevihrtSeez79AAyI4CNV5ukxWN2wOqH7npuSm40sees6dcJtx3f6suQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJnpJxZCMdAinL3ZOKRACvZPABJv2OWXnNqZHjp4WijPpA+5/I
	pv/h5Keeq3fxUgoqGOM/pAuSowASuy4iqV+ZnXetvTPfvv6zjh0wNosD9xuM+rezfKNC5nTfkxs
	f/eDxfA==
X-Google-Smtp-Source: AGHT+IHg9A2OaZZjr5OFVM5B3wlIQW8Etd1z0644vxnh0GN8k3EXwsTICq5M505+21F9o9G20gUth5edIDQ=
X-Received: from pjwx16.prod.google.com ([2002:a17:90a:c2d0:b0:33f:df7f:3c2b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:734c:b0:2b0:ff55:f830
 with SMTP id adf61e73a8af0-344d3e46471mr2330281637.51.1761622716916; Mon, 27
 Oct 2025 20:38:36 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:37:02 +0000
In-Reply-To: <20251028033812.2043964-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028033812.2043964-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028033812.2043964-8-kuniyu@google.com>
Subject: [PATCH v1 net-next 07/13] mpls: Pass net to mpls_dev_get().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We will replace RTNL with a per-netns mutex to protect dev->mpls_ptr.

Then, we will use rcu_dereference_protected() with the lockdep_is_held()
annotation, which requires net to access the per-netns mutex.

However, dev_net(dev) is not safe without RTNL.

Let's pass net to mpls_dev_get().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mpls/af_mpls.c  | 11 ++++++-----
 net/mpls/internal.h |  3 ++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 10130b90c439..a715b12860e9 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -708,7 +708,7 @@ static int mpls_nh_assign_dev(struct net *net, struct mpls_route *rt,
 
 	/* Ensure this is a supported device */
 	err = -EINVAL;
-	if (!mpls_dev_get(dev))
+	if (!mpls_dev_get(net, dev))
 		goto errout_put;
 
 	if ((nh->nh_via_table == NEIGH_LINK_TABLE) &&
@@ -1288,7 +1288,7 @@ static int mpls_netconf_get_devconf(struct sk_buff *in_skb,
 	if (!dev)
 		goto errout;
 
-	mdev = mpls_dev_get(dev);
+	mdev = mpls_dev_get(net, dev);
 	if (!mdev)
 		goto errout;
 
@@ -1611,6 +1611,7 @@ static int mpls_dev_notify(struct notifier_block *this, unsigned long event,
 			   void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct net *net = dev_net(dev);
 	struct mpls_dev *mdev;
 	unsigned int flags;
 	int err;
@@ -1625,7 +1626,7 @@ static int mpls_dev_notify(struct notifier_block *this, unsigned long event,
 		goto out;
 	}
 
-	mdev = mpls_dev_get(dev);
+	mdev = mpls_dev_get(net, dev);
 	if (!mdev)
 		goto out;
 
@@ -1658,7 +1659,7 @@ static int mpls_dev_notify(struct notifier_block *this, unsigned long event,
 		if (err)
 			goto err;
 
-		mdev = mpls_dev_get(dev);
+		mdev = mpls_dev_get(net, dev);
 		if (mdev) {
 			mpls_dev_sysctl_unregister(dev, mdev);
 			RCU_INIT_POINTER(dev->mpls_ptr, NULL);
@@ -1666,7 +1667,7 @@ static int mpls_dev_notify(struct notifier_block *this, unsigned long event,
 		}
 		break;
 	case NETDEV_CHANGENAME:
-		mdev = mpls_dev_get(dev);
+		mdev = mpls_dev_get(net, dev);
 		if (mdev) {
 			mpls_dev_sysctl_unregister(dev, mdev);
 			err = mpls_dev_sysctl_register(dev, mdev);
diff --git a/net/mpls/internal.h b/net/mpls/internal.h
index 080e82010022..0df01a5395ee 100644
--- a/net/mpls/internal.h
+++ b/net/mpls/internal.h
@@ -190,7 +190,8 @@ static inline struct mpls_dev *mpls_dev_rcu(const struct net_device *dev)
 	return rcu_dereference(dev->mpls_ptr);
 }
 
-static inline struct mpls_dev *mpls_dev_get(const struct net_device *dev)
+static inline struct mpls_dev *mpls_dev_get(const struct net *net,
+					    const struct net_device *dev)
 {
 	return rcu_dereference_rtnl(dev->mpls_ptr);
 }
-- 
2.51.1.838.g19442a804e-goog


