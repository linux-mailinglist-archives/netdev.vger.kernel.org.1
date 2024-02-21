Return-Path: <netdev+bounces-73619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342F185D63D
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9537EB248C5
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C203FE31;
	Wed, 21 Feb 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZT6XksT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5677C3FE20
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513166; cv=none; b=qbTe4tyyh7H8ztenn/Z+DiDgYbKCRO6mZ1S36gfoDw43EgTKxzCIYKnt61/Q+IwSWbhvMLo4dTlLgsJJsKpnNrzoOa/DMnlJjfEHIiykS/c+kyPaLChz1dNq5QMnJxq/pCYoNd7Ht23z4t+p7e5Z9pZxWXmCzgdYnCBI/yKGkWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513166; c=relaxed/simple;
	bh=tiuFNpcOy1HKDWRPdENapP7XWeP0Jl4WNHII1P3GGCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h9iO81OqMy3AGFCT21xA/E42z6JNHLomquoruUHm/JNU0KzA0q3v3ltXeG+pI6J9pon1mDjf/4otgBKiNomPd2ePZTcSATmvmz831PAh8CF/1wCW7FK6eC0X2HqsB1rNAqzM+MlGirna2z3qmWzu/2idsY8zFteCt4gS56iZnNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZT6XksT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc05887ee9so7642487276.1
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708513164; x=1709117964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+vLbi3EHpUUv8uJrMTv76Jg3K5tYbpl2ruddz9ZyCjY=;
        b=QZT6XksToJG7XfhiObq5h19qLBJ8ttCVEp7r8rKFq1mLDt+Ce1lqz2+ZaxGjD7Nk9R
         S3ofr6mJCsGpaZztp+E5rxJ+tfJpb0kNuYRXnU27qJgo3QqpCszfdYpNCT7u5uroKF69
         42nTHBiMuKvRAgl9yaahE9X1hA7ZFfX4AzemGWigV+BxoOl5SbNoG0VbGoJOey9WZ493
         cFfpkhd5W2lC7FZlRw3nv1mmnBl9Hz+OnL4+7WSrZN6tWkB4XnxipDaR89mrO3hJO5Gp
         HPITE/rk6ZT8NWEDk8tZbYFpSfAeTEtlJ16opx377/jZFxFTMhcq8YD0ZKV9e/Mvqc8m
         T1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513164; x=1709117964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vLbi3EHpUUv8uJrMTv76Jg3K5tYbpl2ruddz9ZyCjY=;
        b=uN7K3qj+7ZtPVElN30UjnhT8l0Hy03EX/Hiue1qhFjxD5iskEjwhqb5dOifAsIRnE7
         2Zf1+JNDlUvKv2Qaqsiw4GnRgGqpYlVTuTdnQaL7bWvgy/L3QleFguu/ImQdLhyJ0Ynu
         uy+AK/f5c15VlyWjuOlpENIBh49/4zZUZpFbARf1/iq6WG4gCaB/S3C0ywkHkl5lgCLF
         87weE5OuPGliiHExoaXbueCSlcU+eubZw/IbbtjGh+p4bzJoMPiWEyUgQ4d9H8C6DYvC
         vmR+pRM/houI0Lb/YXdr+gfpKs0BqS2sycDovhXuHZyM+7QP2ZDQVgYpTjNrptjXuTwd
         STBQ==
X-Gm-Message-State: AOJu0Yw4JGPL+rn9fzzaU0zyAxu8fWmy7T/lFizJYp2I7HCJVqKOkpMX
	xdikbWDTzEJvQNCrWf33V8tcSpabvsgCysveL0k71aUlVdHVkjy5bBsGeDHWjsfwGOghDQDsLJe
	6FE3RgXjbqA==
X-Google-Smtp-Source: AGHT+IGCigqNWx6eduA/9cMwNtHg2XjtLJvDk/fiQ3g/HmzgU4xhJgT2zLBSi3rpM/NooqwvyRB3gTZTnxbg1g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:b18d:0:b0:dc7:82ba:ba6e with SMTP id
 h13-20020a25b18d000000b00dc782baba6emr678009ybj.7.1708513164334; Wed, 21 Feb
 2024 02:59:24 -0800 (PST)
Date: Wed, 21 Feb 2024 10:59:06 +0000
In-Reply-To: <20240221105915.829140-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221105915.829140-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221105915.829140-5-edumazet@google.com>
Subject: [PATCH net-next 04/13] ipv6: use xarray iterator to implement inet6_dump_ifinfo()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Prepare inet6_dump_ifinfo() to run with RCU protection
instead of RTNL and use for_each_netdev_dump() interface.

Also properly return 0 at the end of a dump, avoiding
an extra recvmsg() system call and RTNL acquisition.

Note that RTNL-less dumps need core changes, yet to come.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/addrconf.c | 46 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index df3c6feea74e2d95144140eceb6df5cef2dce1f4..8994ddc6c859e6bc68303e6e61663baf330aee00 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6117,50 +6117,42 @@ static int inet6_valid_dump_ifinfo(const struct nlmsghdr *nlh,
 static int inet6_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct net *net = sock_net(skb->sk);
-	int h, s_h;
-	int idx = 0, s_idx;
+	struct {
+		unsigned long ifindex;
+	} *ctx = (void *)cb->ctx;
 	struct net_device *dev;
 	struct inet6_dev *idev;
-	struct hlist_head *head;
+	int err;
 
 	/* only requests using strict checking can pass data to
 	 * influence the dump
 	 */
 	if (cb->strict_check) {
-		int err = inet6_valid_dump_ifinfo(cb->nlh, cb->extack);
+		err = inet6_valid_dump_ifinfo(cb->nlh, cb->extack);
 
 		if (err < 0)
 			return err;
 	}
 
-	s_h = cb->args[0];
-	s_idx = cb->args[1];
-
+	err = 0;
 	rcu_read_lock();
-	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
-		idx = 0;
-		head = &net->dev_index_head[h];
-		hlist_for_each_entry_rcu(dev, head, index_hlist) {
-			if (idx < s_idx)
-				goto cont;
-			idev = __in6_dev_get(dev);
-			if (!idev)
-				goto cont;
-			if (inet6_fill_ifinfo(skb, idev,
-					      NETLINK_CB(cb->skb).portid,
-					      cb->nlh->nlmsg_seq,
-					      RTM_NEWLINK, NLM_F_MULTI) < 0)
-				goto out;
-cont:
-			idx++;
+	for_each_netdev_dump(net, dev, ctx->ifindex) {
+		idev = __in6_dev_get(dev);
+		if (!idev)
+			continue;
+		err = inet6_fill_ifinfo(skb, idev,
+					NETLINK_CB(cb->skb).portid,
+					cb->nlh->nlmsg_seq,
+					RTM_NEWLINK, NLM_F_MULTI);
+		if (err < 0) {
+			if (likely(skb->len))
+				err = skb->len;
+			break;
 		}
 	}
-out:
 	rcu_read_unlock();
-	cb->args[1] = idx;
-	cb->args[0] = h;
 
-	return skb->len;
+	return err;
 }
 
 void inet6_ifinfo_notify(int event, struct inet6_dev *idev)
-- 
2.44.0.rc0.258.g7320e95886-goog


