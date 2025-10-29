Return-Path: <netdev+bounces-234102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63183C1C762
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971E3188B76A
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196AE35029D;
	Wed, 29 Oct 2025 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ny4R1BdO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17117350D5F
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759242; cv=none; b=icHTEVZPY4W83nVKvSBcO5mOtuYRDuZxDfIytCQWOZ9R+av87aMoM1GZTGhUhZVL7oKA24QSR+aCpXu0E679iBitrJFxcoE4PjjUJ1CLOyAxQ/jja3AvOaWm6Snvgz12cDGX2W4z3Yd7LXXYJgahlgQ+qA1a0ewrCDxNHAm5lc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759242; c=relaxed/simple;
	bh=Jy3y2wr+nk7worZ6JERfFnbBRakL99dOr0ETdQI5GnU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d4gLb4ieOvbiDhKqm2J++Rzw2rjW166/aFJoZ6Dl8+fjgcBuRufyuARo5DL+eJF6Hzchdlaoi9JHbMmLO4ZBwX+n0Hun3gPUra3MHKX0gaT7yXR9Tu7U4WkvbSPV6MVB6Kj4jADqwgDROVChPozvqq3woXOGeFTkqvf2c8JYKMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ny4R1BdO; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7a26485fc5dso142110b3a.1
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 10:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761759239; x=1762364039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6InaxICDHdeZXXRomc0qvtCMwwLtXpdzWdfJw23IoxQ=;
        b=ny4R1BdOaJB31Dt8e3JXSi1Kby4WgpCmGF7SI5Ywk+15RrkXrW3YKQyMUwxmit0/LE
         BVZJM0LXkO3umfPYFbX0xFxhqghYRHZDfGyWBTTXDg9CTEnQrWZJhEz8bNoAkqcBg0D4
         e+K9b522qnjoUzwsA2PXiJx30l43wk9t0gq2j0ALObC4WfKeDuZcZuj7fcYQHVn2KKgI
         R+/LxOcVC8ZV54czZo/z08ZFoAJQzq0udI5UniN2vY2huCL0ePjoMDgxl61GsH2IewYa
         w8U4x9qHPKmOs+D7FbrV/t6IG4uUAXUdlz/z1x5mWqGYPKkQzIlAZZdb0VSa8Lx66bHf
         TUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759239; x=1762364039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6InaxICDHdeZXXRomc0qvtCMwwLtXpdzWdfJw23IoxQ=;
        b=F/R76MPQ7iOblnZNE4upywnCHqHwPJ+4xSxjyigNkQ8pO21eY2MuQv7qtxvxLcx/mB
         CwUssG6nVMtrCRZ3qO0d1ts1RdWl6jngw9clvph/1NS3UWamr4U5I3djtTcHEjALsHWc
         x1jic9yOyLHqIJrbZ/ASzwIqa5sS+jaESO2BZ1ueHqIfY8xtjugdvnd0jAYi78hjPo94
         C4NsOO/6xTwX0Ytav405z8sb/bdgcIowkzii0HHI0Gc5xDPWn+plk9Ki9yNaRHOeFuF6
         Y8fSHwcPVgutAI85QGurjUqcAvz+4MIWugeLhiULfQBZGsq8ApPM1kpcpLD/NvOwKex+
         0vZw==
X-Forwarded-Encrypted: i=1; AJvYcCVSkpmtIKQJaJomQYEeJEaZ6LxspDmuwlzHkGySPwDWhv5P8+6E36zIz9dQzydPSWPEI5AzNvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxreHuZMQ8ac4lg9AfGP8uf9XIkF5d1qfHtSAy1ymBY0/M44Nh4
	eu4xaHc77mxntw7Cwh0W+UNIw9DSXrfBpOePGZiUeoS7gf2x4IuV/xOeWNDYZxkGdv7foHa/b3M
	gRMuiLA==
X-Google-Smtp-Source: AGHT+IHOvqrbRKeKx1EHTNp6www9/HlDUkjpnMsEaZRvZ3dFDFSbQTTcpCFa+m5p1kZZxIMbmAxCa++OXg4=
X-Received: from pjbca20.prod.google.com ([2002:a17:90a:f314:b0:33b:da89:9788])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2584:b0:344:97a7:8c61
 with SMTP id adf61e73a8af0-34654a05a52mr4625651637.37.1761759239244; Wed, 29
 Oct 2025 10:33:59 -0700 (PDT)
Date: Wed, 29 Oct 2025 17:33:00 +0000
In-Reply-To: <20251029173344.2934622-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029173344.2934622-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029173344.2934622-9-kuniyu@google.com>
Subject: [PATCH v2 net-next 08/13] mpls: Add mpls_route_input().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

mpls_route_input_rcu() is called from mpls_forward() and
mpls_getroute().

The former is under RCU, and the latter is under RTNL, so
mpls_route_input_rcu() uses rcu_dereference_rtnl().

Let's use rcu_dereference() in mpls_route_input_rcu() and
add an RTNL variant for mpls_getroute().

Later, we will remove rtnl_dereference() there.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mpls/af_mpls.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index a715b12860e9..530f7e6f7b3c 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -75,16 +75,23 @@ static void rtmsg_lfib(int event, u32 label, struct mpls_route *rt,
 		       struct nlmsghdr *nlh, struct net *net, u32 portid,
 		       unsigned int nlm_flags);
 
-static struct mpls_route *mpls_route_input_rcu(struct net *net, unsigned index)
+static struct mpls_route *mpls_route_input(struct net *net, unsigned int index)
 {
-	struct mpls_route *rt = NULL;
+	struct mpls_route __rcu **platform_label;
 
-	if (index < net->mpls.platform_labels) {
-		struct mpls_route __rcu **platform_label =
-			rcu_dereference_rtnl(net->mpls.platform_label);
-		rt = rcu_dereference_rtnl(platform_label[index]);
-	}
-	return rt;
+	platform_label = rtnl_dereference(net->mpls.platform_label);
+	return rtnl_dereference(platform_label[index]);
+}
+
+static struct mpls_route *mpls_route_input_rcu(struct net *net, unsigned int index)
+{
+	struct mpls_route __rcu **platform_label;
+
+	if (index >= net->mpls.platform_labels)
+		return NULL;
+
+	platform_label = rcu_dereference(net->mpls.platform_label);
+	return rcu_dereference(platform_label[index]);
 }
 
 bool mpls_output_possible(const struct net_device *dev)
@@ -2373,12 +2380,12 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 	u32 portid = NETLINK_CB(in_skb).portid;
 	u32 in_label = LABEL_NOT_SPECIFIED;
 	struct nlattr *tb[RTA_MAX + 1];
+	struct mpls_route *rt = NULL;
 	u32 labels[MAX_NEW_LABELS];
 	struct mpls_shim_hdr *hdr;
 	unsigned int hdr_size = 0;
 	const struct mpls_nh *nh;
 	struct net_device *dev;
-	struct mpls_route *rt;
 	struct rtmsg *rtm, *r;
 	struct nlmsghdr *nlh;
 	struct sk_buff *skb;
@@ -2406,7 +2413,8 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 		}
 	}
 
-	rt = mpls_route_input_rcu(net, in_label);
+	if (in_label < net->mpls.platform_labels)
+		rt = mpls_route_input(net, in_label);
 	if (!rt) {
 		err = -ENETUNREACH;
 		goto errout;
-- 
2.51.1.851.g4ebd6896fd-goog


