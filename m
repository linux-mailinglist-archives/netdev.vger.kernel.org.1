Return-Path: <netdev+bounces-234101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61124C1C9AE
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20876421E3
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDD5354705;
	Wed, 29 Oct 2025 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pASYb19+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4539E351FD6
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759238; cv=none; b=i3jcwGBD5PhcF7xXMzwvRfgPyt3/Xd3R0J/VNJo8AoRzYDLnUbQf5LMpmAIBFOJZKujYuLapvO+SRbR4JiKrxq7widl1p3REQ9iidYHjUVlv/o87kEsIiBZ7upmr23/JEznZCoEMgk8TpRva2u+JUsUsxw2CH5mwxfuTfyE/OG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759238; c=relaxed/simple;
	bh=t62v2UcW3JQfy3Z3xBt4KM6t9Hwd0jP2/Yi2WKSsJFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AWDtI5mSlwICiMjcdpUagsS8Hci7IYluXKmTM0A0uYPk03q3gfkdiF+6pfscMCacqyf/HKjfIohocD237/L+7pMyACgjrw5x8MTb1mH2nmnu3V0+Lj5Gc6KPyvwZr8O72qXprmaHYcAc0mu7XW8ECBP4lSrsIVclALahtam4cIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pASYb19+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33d75897745so299171a91.0
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 10:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761759236; x=1762364036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gNlI8nbdk53Q8ydY5c8X4OC/Zy9cxMqJqIA3Kc6FCs0=;
        b=pASYb19+YbGDqYlcNd8wIxhCGJ+7dslscYQkAUnt4XwBRk8pPa/1VuvO98GheSI+mE
         2FxI3CPXh5m6JkH1ZiOvIzqE/ouRB7hAkeSr7GaIABQXf2XGCUVPMecwkEo9jgymxg/i
         62ui3KHdHVEuud7XvoOzes9YZyRdt2oR+Ecksopa9FJUoEjoVSaeAoiJN3L+PAhnmAOe
         GdIfkh0MZvU0lEDIETFC7sQjKLfE3GKGnqwPxKqIeOt0S/EPHWN1X+iVOU9Qld8DO+x1
         STKMc5GKhvSEtYe6DGkYsNcvrsG09XnWQp/eQS8NL83G3kTxwCd9yhrNipijjXDf5tTM
         rR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759236; x=1762364036;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNlI8nbdk53Q8ydY5c8X4OC/Zy9cxMqJqIA3Kc6FCs0=;
        b=jENB15sQQJwkOnS8p9GvghspjAPNvzEmE5WHPXBlh0W1aognIj/jbJN9c2HbAxiJ/C
         FvvkciCY8f9+dCzlTwqec/Pkj6kFqQ3ehcjEmr2VidU52ieTL4aBAhmVHGMWA3Fe9Ozc
         JBZiQ8q8kiqMNnJlORd1bvMvweuxtX2PO0+OwXFLqG/D1/nhWT48j+CPMw7Oo49jMu7i
         I6nqXuwhd99S+OeGVKXfd0cKmZc/TPz7A2zxvtvFFS9R5Z32o+niVnelcrol4dv8m/kq
         jdRp86Z9aRMcmzosl/qPNZiDgmew7RhOzQuFJy3BWcPGN5HdBznV8AjNgyr/DPFj1wBy
         Id0w==
X-Forwarded-Encrypted: i=1; AJvYcCWhbKvrJM4oXEz52b1FzWHHuM8DFvL/7931Zrnm/MfmNpL3u/ybK7ta8w7MdKYeh+LPh7HKFQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLvhZjoFl/VmKu98Wa/j7+VcnFCAKqxQzWT1cftLuXIvJ6B/69
	pLm107mX9lJCyvrvSCwe0kPqrEqIt+wVfeRKZ8aI1Vx2CJdNC/taMw0ngvpfa4Ki9L7RwL4DKqs
	MTbTB5Q==
X-Google-Smtp-Source: AGHT+IHEUG4mUblmfZ77Htaa8rzoQl407pF0uL8mOvx1D1k8Pim+HB7WPJzRYHX/KRyKFz9a56GJEGQZGpQ=
X-Received: from pjca5.prod.google.com ([2002:a17:90b:5b85:b0:33b:51fe:1a93])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3944:b0:32b:623d:ee91
 with SMTP id 98e67ed59e1d1-3403a2f21a3mr3719893a91.27.1761759236376; Wed, 29
 Oct 2025 10:33:56 -0700 (PDT)
Date: Wed, 29 Oct 2025 17:32:58 +0000
In-Reply-To: <20251029173344.2934622-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029173344.2934622-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029173344.2934622-7-kuniyu@google.com>
Subject: [PATCH v2 net-next 06/13] mpls: Add mpls_dev_rcu().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

mpls_dev_get() uses rcu_dereference_rtnl() to fetch dev->mpls_ptr.

We will replace RTNL with a dedicated mutex to protect the field.

Then, we will use rcu_dereference_protected() for clarity.

Let's add mpls_dev_rcu() for the RCU reader.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mpls/af_mpls.c       | 12 ++++++------
 net/mpls/internal.h      |  5 +++++
 net/mpls/mpls_iptunnel.c |  2 +-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index efc6c7da5766..10130b90c439 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -136,7 +136,7 @@ void mpls_stats_inc_outucastpkts(struct net *net,
 	struct mpls_dev *mdev;
 
 	if (skb->protocol == htons(ETH_P_MPLS_UC)) {
-		mdev = mpls_dev_get(dev);
+		mdev = mpls_dev_rcu(dev);
 		if (mdev)
 			MPLS_INC_STATS_LEN(mdev, skb->len,
 					   tx_packets,
@@ -358,7 +358,7 @@ static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
 
 	/* Careful this entire function runs inside of an rcu critical section */
 
-	mdev = mpls_dev_get(dev);
+	mdev = mpls_dev_rcu(dev);
 	if (!mdev)
 		goto drop;
 
@@ -467,7 +467,7 @@ static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
 	return 0;
 
 tx_err:
-	out_mdev = out_dev ? mpls_dev_get(out_dev) : NULL;
+	out_mdev = out_dev ? mpls_dev_rcu(out_dev) : NULL;
 	if (out_mdev)
 		MPLS_INC_STATS(out_mdev, tx_errors);
 	goto drop;
@@ -1118,7 +1118,7 @@ static int mpls_fill_stats_af(struct sk_buff *skb,
 	struct mpls_dev *mdev;
 	struct nlattr *nla;
 
-	mdev = mpls_dev_get(dev);
+	mdev = mpls_dev_rcu(dev);
 	if (!mdev)
 		return -ENODATA;
 
@@ -1138,7 +1138,7 @@ static size_t mpls_get_stats_af_size(const struct net_device *dev)
 {
 	struct mpls_dev *mdev;
 
-	mdev = mpls_dev_get(dev);
+	mdev = mpls_dev_rcu(dev);
 	if (!mdev)
 		return 0;
 
@@ -1341,7 +1341,7 @@ static int mpls_netconf_dump_devconf(struct sk_buff *skb,
 
 	rcu_read_lock();
 	for_each_netdev_dump(net, dev, ctx->ifindex) {
-		mdev = mpls_dev_get(dev);
+		mdev = mpls_dev_rcu(dev);
 		if (!mdev)
 			continue;
 		err = mpls_netconf_fill_devconf(skb, mdev,
diff --git a/net/mpls/internal.h b/net/mpls/internal.h
index e491427ea08a..080e82010022 100644
--- a/net/mpls/internal.h
+++ b/net/mpls/internal.h
@@ -185,6 +185,11 @@ static inline struct mpls_entry_decoded mpls_entry_decode(struct mpls_shim_hdr *
 	return result;
 }
 
+static inline struct mpls_dev *mpls_dev_rcu(const struct net_device *dev)
+{
+	return rcu_dereference(dev->mpls_ptr);
+}
+
 static inline struct mpls_dev *mpls_dev_get(const struct net_device *dev)
 {
 	return rcu_dereference_rtnl(dev->mpls_ptr);
diff --git a/net/mpls/mpls_iptunnel.c b/net/mpls/mpls_iptunnel.c
index cfbab7b2fec7..1a1a0eb5b787 100644
--- a/net/mpls/mpls_iptunnel.c
+++ b/net/mpls/mpls_iptunnel.c
@@ -153,7 +153,7 @@ static int mpls_xmit(struct sk_buff *skb)
 	return LWTUNNEL_XMIT_DONE;
 
 drop:
-	out_mdev = out_dev ? mpls_dev_get(out_dev) : NULL;
+	out_mdev = out_dev ? mpls_dev_rcu(out_dev) : NULL;
 	if (out_mdev)
 		MPLS_INC_STATS(out_mdev, tx_errors);
 	kfree_skb(skb);
-- 
2.51.1.851.g4ebd6896fd-goog


