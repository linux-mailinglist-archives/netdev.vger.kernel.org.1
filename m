Return-Path: <netdev+bounces-234103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83507C1C76B
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B613D188B5FA
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCECD35471D;
	Wed, 29 Oct 2025 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aDqQWnpo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEFF31E0EF
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759242; cv=none; b=HWviENL1894dKd+OS7XaqTDksYF/yn76gDa78PEHUEra5G+K/2TwxP5AsUhPil3kKuYXkhC9s7jMpEqfB9azJL1ddsuw/qqMGFgoOaHEXRcqsREA0GgTEHg9wOQPxwtvEQ48YHKPpgXcZfn8JH4HVAc4XAcfceZOqlTu6Y/02hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759242; c=relaxed/simple;
	bh=f3nk4+U3nOmUxJr9AM2HyrxMjnh0al+zRLpskLYNEvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jv1j6CZqbAl5C7PMLqZUOe88BPrpCrwCtLVoHGd3sX5+VhJj6C65VWYxS0ZJ+2TQ9earAmKhGwN6XnlkD+tWmhsWcLaKIH+cAwkVgcbwZcr+sFRA0pXcbvBSUGKBXuqvaFHD2hh4KAmVnVuultiDV5JotJEySWvZUqOi1+LhdTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aDqQWnpo; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34029b3dbfeso153097a91.3
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761759238; x=1762364038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nu79IFT8r7Oa0Efx+AE/8FX/F1Gyz9uRnmrOAWXL0kY=;
        b=aDqQWnpohpOcHklhgRRAlrk8wRwktsOQw0OI62RLwClLO63lk5VebTyN8ulwxqulOW
         lt8MnVoo5+OTUxo9dVm9BZtsz+3NEj99j56LPpYP0bZmZd7d3h00CJUu066saH8wPByz
         o9ZCFjegAwKlye3CdwZKMss1+ji6saPMdF2QJ9YO1Y2AbaAF5mHLneEWZ88KaAbLJDWU
         Lx0qn2tAU8i8M9HvsOqRVFgfaO/GwAbWfUP2TQ6M6/fsnrJsrY1GAP/rauZhUfe+fw0O
         iTB/6xjj6EyZ+c1NQkpPUyytZCnP80hJPmKyc56A/EnfFvZbO2CKSFNTQn0hDdKCpIUX
         Rx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759238; x=1762364038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nu79IFT8r7Oa0Efx+AE/8FX/F1Gyz9uRnmrOAWXL0kY=;
        b=f3kcmE2pzJpKGnJDVuK7f152l8npZkDn0G8d+6QW+51kTPGA4xZ5wGruxkFiQfCFzW
         oJVHovr72dxBl8M031EDu2R+NxG/X8IeYGvk/CYRDxUzeZkr5L61HNiZyZLMl7ZdzX81
         qtm4unYYuJUsVxKMW4JfEvamrBvtUfSQDv0JPOCj0l9fmSD9Xf+i/fpJLkCU9GUwFH0u
         MhM3vZ9+e7a5qb8tZnMtL+dkug4oPFc5rxdI0zednMHNdK/0oFX0V+hEaaDgVtRX+Pvc
         5QciyrPpoTC4rmQlB5c8qyECTj0d3m9iatwMCh8Xy8vi2/gbxrbeO3IkCdGYiAR5pxVL
         wsvw==
X-Forwarded-Encrypted: i=1; AJvYcCX3ZEeJTeRar5azhlYRCDe3QAThdbI7Oy4VdjrjvdZ6Z8fancRDHbpxnorrpxGcGUu3wZwq/rE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsnkT6ZnFxe2NzeYKqO/Xql/hny7FI33xCLKqhQqyA+GQ7fk7C
	HECSjAVmEDLhU+Lm+faCIuiWFvfsxBnkEdKNpMYy73OcpVfORaxXp+XMxod1oMfTH8+FcrS/XOt
	PvFsICw==
X-Google-Smtp-Source: AGHT+IEVfzX661Rr/DRHmtxvcFflU1SfC3loEkj7j5xI36ALHHbDCjvlMCFuHl2NTKifYbRKnPw1TSa1cGo=
X-Received: from pjbse12.prod.google.com ([2002:a17:90b:518c:b0:32e:aa46:d9ab])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c09:b0:33b:b0f7:fdc3
 with SMTP id 98e67ed59e1d1-3403a1435f1mr4301905a91.8.1761759237789; Wed, 29
 Oct 2025 10:33:57 -0700 (PDT)
Date: Wed, 29 Oct 2025 17:32:59 +0000
In-Reply-To: <20251029173344.2934622-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029173344.2934622-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029173344.2934622-8-kuniyu@google.com>
Subject: [PATCH v2 net-next 07/13] mpls: Pass net to mpls_dev_get().
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
2.51.1.851.g4ebd6896fd-goog


