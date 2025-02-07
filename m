Return-Path: <netdev+bounces-164001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA499A2C440
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179371691E9
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546421F91F3;
	Fri,  7 Feb 2025 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PWsUIA6i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00F31F8ADF
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936729; cv=none; b=hlKV4GFFz8uQSy2hvdBObko/PDn9JjpzZ7yeHdJROPIKmzltFcPN/o8pYWYiSyC2TZ/P88lVrGVjc5rI2oKFDh0vJOElaGLt0XjedX6gN8BP9abdpb8Zq77q+Jih+GZaHY7ToBYiKpZGs3IZIuffgNf1Qg2RBAndgPrsezlR4g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936729; c=relaxed/simple;
	bh=Ey9D0myTHFybB+mk2X5BH0D2AOX5G5an0ZMPI6LUv+4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qmz+BZNBnPUDeAJcR7v1teVA9eY+2hhl+VNTYSHfVkQW2mXi5nrZxKAX3s82CsJwdk/fqs5hXPLLj/J2emVK+HMfU9JJg+DolAEDffG6TLBmTjgfCJPG4ahdc38zm59+l+6VzFdVm+dJMRh5LBPaOCF0q0INXhXw/RvXQaU1Qn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PWsUIA6i; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-46fa764f79cso37711861cf.1
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 05:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738936726; x=1739541526; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EuAkC8js7OWqN8SrJuSMS11ikDteqHmCsrIPFXDdhCw=;
        b=PWsUIA6iZoLGyKGbkhmEa7wDIAhGUSMRPVatNTCQ37l6tzGWKxHKm36fV4kXF7U7v3
         wNM/ELRkuKJD5+RSECP5cXboRIcMaU/+Axddx9IViMNZrWAxbVoIR/zQJSrWH40gZRGC
         A65XRqGPwoFoaGUMzmtIvEl9Yfh9uP59ZQ4tQrzTf5j0F/dX+WrExE2vH9U5EegcjGtQ
         5A4Qv7ZWelK/4jsT10hCGRmhuw8JhjFTm02pCFvnbUw5b8T8eN8OKbHnoomMHH7DSdGI
         Fd41ygP11u6cgO02xCGA5xdLFrc4nBfSFEucO3n+TuaEHBAgAFKpuLu6ZhW4bwPIe6mH
         E74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738936726; x=1739541526;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EuAkC8js7OWqN8SrJuSMS11ikDteqHmCsrIPFXDdhCw=;
        b=gOedoVCgvCm+nAVEu/ekES2DCCNHR8CVYQbqRFFfnYWf78aTJ9RZGsoFSLTLD7v6Xv
         HhELbHSDYojCDao1kRk94z2FObhYh8elE2wOKS4j5R8k2Io3sbfy3Q8nFSRIQex6v5Mo
         owQdmZS0NTu7kEIs1/ntSDeDi18C0MDRfw3dh3lwXPetkKg1gMq0F5EygxpB7II3ijHr
         iFxwTH30+WbD+oOy8DLZtvLbvG8duV39f2WN3HBw2Y9PYgLUSxhF/Ay5ggCvX8eNYJq3
         u6Mm93uBcRwCaLb92Gt6nAp64lCDL63eIPw+A0bd6ShO8nGb8ViOxSgPZn+9vBeQFlKX
         Nf+A==
X-Gm-Message-State: AOJu0YweufT24GxljQgqPf82U8BAr36l6flYyNaEATN0uXFhoj50Dtd2
	NuCLuboyTZHe2NXtlDlG1Z0ukz6fOzZwRN+xQ7HBwrMsre0txiTtHpeW6FpBFULSr0GIkm+QIJ4
	94UwZkt7Tcw==
X-Google-Smtp-Source: AGHT+IGTrfBBOvLlvKjNsHln1ogSj0p+V3GHUCSsKIT9Sat/YEyP/XIBaGFy1i6+ca+JLQsb5dmPjFtsdfD1Xg==
X-Received: from qtbbz14.prod.google.com ([2002:a05:622a:1e8e:b0:46e:5a71:22a1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5856:0:b0:467:6c61:b70a with SMTP id d75a77b69052e-471679dc928mr47315061cf.17.1738936726730;
 Fri, 07 Feb 2025 05:58:46 -0800 (PST)
Date: Fri,  7 Feb 2025 13:58:35 +0000
In-Reply-To: <20250207135841.1948589-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207135841.1948589-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250207135841.1948589-4-edumazet@google.com>
Subject: [PATCH net 3/8] neighbour: use RCU protection in __neigh_notify()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

__neigh_notify() can be called without RTNL or RCU protection.

Use RCU protection to avoid potential UAF.

Fixes: 426b5303eb43 ("[NETNS]: Modify the neighbour table code so it handles multiple network namespaces")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/neighbour.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 89656d180bc60c57516d56be69774ed0c7b352b2..bd0251bd74a1f8e08543642e5dc938ed2c5fdfda 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3447,10 +3447,12 @@ static const struct seq_operations neigh_stat_seq_ops = {
 static void __neigh_notify(struct neighbour *n, int type, int flags,
 			   u32 pid)
 {
-	struct net *net = dev_net(n->dev);
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
+	struct net *net;
 
+	rcu_read_lock();
+	net = dev_net_rcu(n->dev);
 	skb = nlmsg_new(neigh_nlmsg_size(), GFP_ATOMIC);
 	if (skb == NULL)
 		goto errout;
@@ -3463,9 +3465,11 @@ static void __neigh_notify(struct neighbour *n, int type, int flags,
 		goto errout;
 	}
 	rtnl_notify(skb, net, 0, RTNLGRP_NEIGH, NULL, GFP_ATOMIC);
-	return;
+	goto out;
 errout:
 	rtnl_set_sk_err(net, RTNLGRP_NEIGH, err);
+out:
+	rcu_read_unlock();
 }
 
 void neigh_app_ns(struct neighbour *n)
-- 
2.48.1.502.g6dc24dfdaf-goog


