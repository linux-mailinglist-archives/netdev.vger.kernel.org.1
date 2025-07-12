Return-Path: <netdev+bounces-206366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA176B02CE0
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 22:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDA24A4622
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 20:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3483F226D03;
	Sat, 12 Jul 2025 20:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNtDmmsM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17142264BB
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752352527; cv=none; b=iv294i+4ob/fSqfbYVBpz8uEmeVHDguAvDCocKYo56HDO+lcaQOCBM7Dk5dZfyIPu4OLVJzCJ4OWtZB/d0busfpf1No6DuWUMyravMXF8fR5dt4RVL6TpglCDmEOymh9O6K305KVdHJT1aOpifVU1PfbxpPwMxb0aBzu5Vh9JIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752352527; c=relaxed/simple;
	bh=ncVbN1qLu8kTVNK0xRqJIzJwmakkxGurtcA+nGTpryg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q08QykRySs5qUOFTKZcfevEsq6EM/NoBULI1H1yyUJVhEomrEvxqARyyB2jEovZNJpvIAAY1NmHeRRWeLjKYYuotbAVbtq4HQlVC/zUyIWjnhJ0D6xH9aysrFZGX1wXW8MJPsRsR2R0Ky1WCkc9+n+1jABvsgcz+nQgzQr5Gar8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NNtDmmsM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3132c8437ffso4988813a91.1
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 13:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752352525; x=1752957325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J9mgTTkrwNJeyerld9CLyAZlYSdZO/lR64P5ZZCiosY=;
        b=NNtDmmsMwpH5XKQus1ZhETjJ6yfxAri9sfYQhuhJZc6ncNvbWX4d8OBL3DFDjmsv45
         sdBWRlY+dtqpR33n2/+USez5OuTFGPMGNFcmQv8rSSHmh5ryBdUA0aG3HO5eZkijUigH
         W4yu6rFDvBod6ZQSlwKPUSnOfTk9bkHTJ03Q2MnRuohfJTHfa+Up6kZqo/V7n/SRu9+q
         dTG7ZNtEEszmOQkaTU1JF4s2nfRr30w0Htt95TNMfA4/eXahCSGiXF6ON9X1Bu3TRgiJ
         2WwkvS2uvHk1SIXtw8fyex9teD4up2up1Tw1ABZQlyFpeYw+F/5a8E0/9sebns0lrC5a
         rOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752352525; x=1752957325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9mgTTkrwNJeyerld9CLyAZlYSdZO/lR64P5ZZCiosY=;
        b=bl9nvoKfwUy3tbILUeCKSZFUOcu1NrWNjEPxZETY2BwqRCC4Ws697TIdLYcRiGBj8Q
         3nCtd3ZJ1ztz4YmtFEwgvXSfYL/cTGiJ7pLFh/LDur2S0zDt8BunPJoUs+qGpEBCeKeq
         1teLBS91e1qzyUmH2a6U6ODQ8F8PkjzA+VEXkTmvK507hD7ooYmQ2eDD0VOW8mJ12sKW
         pd9N916N5qd5gtNGAX4ze5J+XuiYNR9pjvoTMqraxggQiaKriXx1bZJ6//qoI+j67peF
         j6DRG4FT0v4icWuz9NdZVKhr6kvf0zwnKMvbK2hLxX0ZxWn82Z6nL7VfHRS1r9/V7DpY
         Efvw==
X-Forwarded-Encrypted: i=1; AJvYcCWT0GVewTMqHplxFsuMEPY+tOCwf/xhecGzVSvfGH7Hdu6sR5EVRRwt8VmkoLKwIlK0G9AhW9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YysmyE8MwnNGPUyUuXYBGv8VpEVy2sDdWjo+jh8oIUgtWcSuoUL
	z29uGBVfEsaP8Y1IvDBx/AjWLHPvFA4iO0v8+y/tuylpHseJdz9ciVZICCBH9FvidyoIGoczpOM
	4FpVaZw==
X-Google-Smtp-Source: AGHT+IEyacg3hWyLWuPzYPimMG0drWm/yT+mGE9bNNpgKJQP24RxmGPR3r8YF1KuczdwH8R9ivlAAsebZbo=
X-Received: from pjbok7.prod.google.com ([2002:a17:90b:1d47:b0:314:626:7b97])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ecb:b0:311:f99e:7f4a
 with SMTP id 98e67ed59e1d1-31c4ccedab5mr11732812a91.26.1752352525095; Sat, 12
 Jul 2025 13:35:25 -0700 (PDT)
Date: Sat, 12 Jul 2025 20:34:13 +0000
In-Reply-To: <20250712203515.4099110-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250712203515.4099110-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712203515.4099110-5-kuniyu@google.com>
Subject: [PATCH v2 net-next 04/15] neighbour: Move neigh_find_table() to neigh_get().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

neigh_valid_get_req() calls neigh_find_table() to fetch neigh_tables[].

neigh_find_table() uses rcu_dereference_rtnl(), but RTNL actually does
not protect it at all; neigh_table_clear() can be called without RTNL
and only waits for RCU readers by synchronize_rcu().

Fortunately, there is no bug because IPv4 is built-in, IPv6 cannot be
unloaded, and DECNET was removed.

To fetch neigh_tables[] by rcu_dereference() later, let's move
neigh_find_table() from neigh_valid_get_req() to neigh_get().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index df5938b6020f1..ad79f173e6229 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2911,10 +2911,9 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 }
 
 static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
-					 struct neigh_table **tbl, void **dst,
+					 struct nlattr **tb,
 					 struct netlink_ext_ack *extack)
 {
-	struct nlattr *tb[NDA_MAX + 1];
 	struct ndmsg *ndm;
 	int err, i;
 
@@ -2949,13 +2948,6 @@ static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
 	if (err < 0)
 		goto err;
 
-	*tbl = neigh_find_table(ndm->ndm_family);
-	if (!*tbl) {
-		NL_SET_ERR_MSG(extack, "Unsupported family in header for neighbor get request");
-		err = -EAFNOSUPPORT;
-		goto err;
-	}
-
 	for (i = 0; i <= NDA_MAX; ++i) {
 		switch (i) {
 		case NDA_DST:
@@ -2964,13 +2956,6 @@ static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
 				err = -EINVAL;
 				goto err;
 			}
-
-			if (nla_len(tb[i]) != (int)(*tbl)->key_len) {
-				NL_SET_ERR_MSG(extack, "Invalid network address in neighbor get request");
-				err = -EINVAL;
-				goto err;
-			}
-			*dst = nla_data(tb[i]);
 			break;
 		default:
 			if (!tb[i])
@@ -3011,16 +2996,17 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 {
 	struct net *net = sock_net(in_skb->sk);
 	u32 pid = NETLINK_CB(in_skb).portid;
+	struct nlattr *tb[NDA_MAX + 1];
 	struct net_device *dev = NULL;
-	struct neigh_table *tbl = NULL;
 	u32 seq = nlh->nlmsg_seq;
+	struct neigh_table *tbl;
 	struct neighbour *neigh;
 	struct sk_buff *skb;
 	struct ndmsg *ndm;
-	void *dst = NULL;
+	void *dst;
 	int err;
 
-	ndm = neigh_valid_get_req(nlh, &tbl, &dst, extack);
+	ndm = neigh_valid_get_req(nlh, tb, extack);
 	if (IS_ERR(ndm))
 		return PTR_ERR(ndm);
 
@@ -3031,6 +3017,21 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (!skb)
 		return -ENOBUFS;
 
+	tbl = neigh_find_table(ndm->ndm_family);
+	if (!tbl) {
+		NL_SET_ERR_MSG(extack, "Unsupported family in header for neighbor get request");
+		err = -EAFNOSUPPORT;
+		goto err;
+	}
+
+	if (nla_len(tb[NDA_DST]) != (int)tbl->key_len) {
+		NL_SET_ERR_MSG(extack, "Invalid network address in neighbor get request");
+		err = -EINVAL;
+		goto err;
+	}
+
+	dst = nla_data(tb[NDA_DST]);
+
 	if (ndm->ndm_ifindex) {
 		dev = __dev_get_by_index(net, ndm->ndm_ifindex);
 		if (!dev) {
-- 
2.50.0.727.gbf7dc18ff4-goog


