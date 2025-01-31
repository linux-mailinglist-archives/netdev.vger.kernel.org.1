Return-Path: <netdev+bounces-161794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BC7A241A5
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8A73A9C28
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 17:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3D21F03D0;
	Fri, 31 Jan 2025 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XiLjb8y1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AF21F03EA
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343625; cv=none; b=JLNuQ6PWdXYCosyElAR9PzK3oTPpsWe7a1MjIps/SVmxJkt2fweLmnCrv6pTmZW/UBMhKhA0XwR5PmieFJy3ROgomkkaT9Fti9hE35EnN8AoiMulWkZp72VrPipdPiXqELBfsLwOsIcw+lbLMY0ekBnP9mg0ci5FL3mxEb7v/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343625; c=relaxed/simple;
	bh=BodILEqoM6R13yJno10qoCeODTvI8TaHTkPMRluv028=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WKU+gob9+J387P/zstM35bmfhWaI4V8S7Z0R5e+/K7OpVMSYOej8Z2xkI526zTQu/cyEpFRCsfV6lxgwIg9HV6qy0ZJERLqG0VEn6gFY2LDbfPYKJdJ0kHq3l99ErnrlrMVO9lsrzrKFmnWipnjh4kRHUAiem0sIxyfXCfIQFtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XiLjb8y1; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-46798d74f0cso39281911cf.0
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 09:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738343623; x=1738948423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f0xiPGCTpYZx77YCAKyVU7G46XthSwJFii7DkQ0pGtk=;
        b=XiLjb8y1EYNo4147Go2Y7nmKp1lmoM+jSjPmGtGVE6zMKZAJyWM/WXu/5NxwSbR+BA
         L0OLRltIi4gqFPTf/x2Q8E940P2VcmWYgdzEpzLbOZQ/rDsRh+BCFQ9Is22BIFWmjCyQ
         mZgWDx2VOkkSP9a2anpaEq8amBkYeWurtMLCj3IkEFw2Vx4A8zW8lGu0eEaVjFOO4ef0
         WLKvo/OZNB0FosEahDXwUDqH3l0EBsGrFt0Kyn45N7K31+vl2z+SL2CQxj6AW6qxdbDZ
         oE8CiFuZDw2KbWF6T7A/k3uVoMrOoyt65qJiyutQpRnfk/e+vcNJoIXO0fEd/BXwA9jJ
         /Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738343623; x=1738948423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0xiPGCTpYZx77YCAKyVU7G46XthSwJFii7DkQ0pGtk=;
        b=OrYqZ6stry2Zou7yB+4tVMSbkvxqm1s8EFY42IuLNWGw+fgnsaPt12oMOBaTFubSoy
         7ssF/vUrPzfRZrhQYOqVOx+/kYYOlnwz6NMUiYFoBAJF/c5a9KerMncAh+vrblXslhLx
         my6kF0NwCMUNew+/6M2WQeFtqnzPlIRNqh7WPkAk9YI2aT8Ewtjbx9DFF+OQSFN389Re
         uA8iJwAa/NmFwb3q5Z+Y9dun10/UF2NIBgW3aD7jZ3rKqq0Ve3LpLWeMT87B4EoG6/m9
         DphTCUN+ltnhf20pxNPhLnMgFQXRKgIHOv9Q9yzYuNC7CV3FXBI2Gi6nCQ+vgDIxednc
         KDHQ==
X-Gm-Message-State: AOJu0YwgfjwAuGJt4NW0O5M1WbSWrAEkmdm8SNF/c8C6eeKtGICA5Qkr
	geu5G+RihUBV51PNitXcotoHEPAKsChR3Rp+DAQKQEvLMY28uaIP52uX5Acc4ZSWhiSPyf5iK2D
	6EW0qy+UZyQ==
X-Google-Smtp-Source: AGHT+IEtBkKu4jl0hLEvHF3ox7t2a5WCkB9bouLQ/RBt1N02xYWpfLjTX8Hj1puxaWSH3xD5bPKE/5SMqXMALg==
X-Received: from qtbfe12.prod.google.com ([2002:a05:622a:4d4c:b0:467:8783:e486])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1314:b0:467:5910:255f with SMTP id d75a77b69052e-46fd0ace290mr183152261cf.30.1738343623019;
 Fri, 31 Jan 2025 09:13:43 -0800 (PST)
Date: Fri, 31 Jan 2025 17:13:21 +0000
In-Reply-To: <20250131171334.1172661-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250131171334.1172661-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250131171334.1172661-4-edumazet@google.com>
Subject: [PATCH net 03/16] ipv4: use RCU protection in ip_dst_mtu_maybe_forward()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ip_dst_mtu_maybe_forward() must use RCU protection to make
sure the net structure it reads does not disappear.

Fixes: f87c10a8aa1e8 ("ipv4: introduce ip_dst_mtu_maybe_forward and protect forwarding path against pmtu spoofing")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 9f5e33e371fcdd8ea88c54584b8d4b6c50e7d0c9..ba7b43447775e51b3b9a8cbf5c3345d6308bb525 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -471,9 +471,12 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 						    bool forwarding)
 {
 	const struct rtable *rt = dst_rtable(dst);
-	struct net *net = dev_net(dst->dev);
-	unsigned int mtu;
+	unsigned int mtu, res;
+	struct net *net;
+
+	rcu_read_lock();
 
+	net = dev_net_rcu(dst->dev);
 	if (READ_ONCE(net->ipv4.sysctl_ip_fwd_use_pmtu) ||
 	    ip_mtu_locked(dst) ||
 	    !forwarding) {
@@ -497,7 +500,11 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 out:
 	mtu = min_t(unsigned int, mtu, IP_MAX_MTU);
 
-	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
+	res = mtu - lwtunnel_headroom(dst->lwtstate, mtu);
+
+	rcu_read_unlock();
+
+	return res;
 }
 
 static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
-- 
2.48.1.362.g079036d154-goog


