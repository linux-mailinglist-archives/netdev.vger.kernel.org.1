Return-Path: <netdev+bounces-73935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCBB85F615
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72B11F25C56
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 10:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D594595D;
	Thu, 22 Feb 2024 10:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nFZaBo5K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779BD44C84
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599032; cv=none; b=pqVH/M4V5CqkYTPJSL8IOW5R1ulHVhG5Ck+FY0+kT4lKeDwXvzSa0Rgan087XGDlIvd5xRjlhIkE2Uq1iquYBiyPbujdygOccJ7Ly9FEih0zDkTba+OqzzzYGJTPvtS9XPg9FSgr2ThfTTcASN9pql6KiLmGvv+vP+z4dvca/ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599032; c=relaxed/simple;
	bh=yAuw9NcokKQt3vDKO0nI8Z/lV2mVAHlNYUQ892v6+Tg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J9CL9KcNG+KEe0glc/ZPmDS+dU1gnHji0EDNJapDXQ8NpTZWimLJjs6OgVIAXObwpEoekkcV4DnI1v4gmb1LF4SoNTss+AFsxGQZw9S/nzWqxmMadyrju6723elybHY7q6Erl7kl/cPLJkmPtZGmDWi2n4l8ZWYdWGRePERNzc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nFZaBo5K; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6047a047f58so124381307b3.3
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 02:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708599029; x=1709203829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5id54P25+TJipOJgL9vLNvIfegTcV21bvu/osxFDOtY=;
        b=nFZaBo5KZVZd2JeevwpAnAZzyxIcwRydUOiGALL3eYvLxmfSSAMDIq2Nm4PtVz55gZ
         BeFWAuPGTbyEsYiFSswJSPRM7DkGz4WfE9Y/mIZhgCFX2pX6TXOypRMmlR9Hu9Q1yYsw
         Ww4GCqejkGrppGA4ExuAqFZ/OWc3KHHWrf8tgjvnB4zsM9lzRWYtQDTCcn/7EugqGXwY
         zxiuv/X5qupl5Z8xHO/qUtEpEwvSqrizNYbNeqjcTrvMt/45CnZhg/QD3jY2mL1ClBwK
         on7iWg63j/xl0+9bRpL86zRNgw7SefFx26Ro66uhJv10NdIX6dxkSLze1/7s9Mne4o79
         XNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599029; x=1709203829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5id54P25+TJipOJgL9vLNvIfegTcV21bvu/osxFDOtY=;
        b=ri4kC9W3ndbNWx8x92kZdQ2SqJCZfTBTiL50EyqY6YHSCmgWbmyEE2+KsXor0/AwLN
         dWPym0NQ2LGiNVGO8SPzYjoL1WK5z/2ewzFa+k+SC3wYso7aNvLbIE3Nfts1ifzk1LqS
         cD08Cxefjo3SWEX9UbLyjA2eazA30ab78UiJ+Cz+wYjnSgp4IR+Yg16PogWvXX9mgpDb
         E/u8K7+RkzIYvxPxEnaCPwaqf/KEmIxAVaBMX3gIE+p5+bM2ZPZYk+5O8Q7acjQ7d+os
         vaH2OCc4N5JTjNpm4rKVrw8Ik8OZymvWl3jOr3kkcFGRx1EJ7RPLINH7eLioaIPxq0Il
         O/Uw==
X-Gm-Message-State: AOJu0YyHt8ZQ9ZxO4IMbo4Wc21xahEiXIlNsVx6fnzfO1gwpUs5PpyH9
	iPzPcUvFdHarKFspn+le6C87jhnbiSLq7Okauq3iZYL8qwVvzmkECW46KW5OXC4j4iIO4G1adSM
	rw1O6w/y/Bg==
X-Google-Smtp-Source: AGHT+IHhb9rf+grlrqEWfQ0pY2Ar20jPWYJA7Wn1BJNeltygLpQwRQoAqS2A7S41VP1keqbcE+O6o/giBkEkaQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:360a:b0:608:1dad:a37e with SMTP
 id ft10-20020a05690c360a00b006081dada37emr3359953ywb.1.1708599029495; Thu, 22
 Feb 2024 02:50:29 -0800 (PST)
Date: Thu, 22 Feb 2024 10:50:11 +0000
In-Reply-To: <20240222105021.1943116-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222105021.1943116-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222105021.1943116-5-edumazet@google.com>
Subject: [PATCH v2 net-next 04/14] ipv6: use xarray iterator to implement inet6_dump_ifinfo()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Prepare inet6_dump_ifinfo() to run with RCU protection
instead of RTNL and use for_each_netdev_dump() interface.

Also properly return 0 at the end of a dump, avoiding
an extra recvmsg() system call and RTNL acquisition.

Note that RTNL-less dumps need core changes, coming later
in the series.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
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
2.44.0.rc1.240.g4c46232300-goog


