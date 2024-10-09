Return-Path: <netdev+bounces-133967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B47E99791D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A40F282F1B
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D561E3DFA;
	Wed,  9 Oct 2024 23:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHBf7fZ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA46C169397
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 23:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516455; cv=none; b=dKrkVsIJr6hOa4hzlvzGRjf1GvaxpwywkCdnkITsodifztS3PqX6eX4RGdgDk2Fg+NxVW8qtF2wXDP+CCFWJr3aYZQkFfsciWefL9/E67L+7z0LiLi4WmPjkHsaaLhwgt0l46Jlzk5f7ycmuFOcCPkHx2x9plQyax7yzMcH7ZsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516455; c=relaxed/simple;
	bh=9e5NVnFlYh52V5Y7TKhKo5ND9jlu6kZOqoh/zMnVK6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gN4cFABmKmj6ameUcnn1mIdUTRuSF4ECiv69BQXNSU5krbB/YTPvS257kdINfHHMCZulP+8pjCUO9b6qbpGoD6M9qMKExfEVogNSvjlaQ6DjVJOj3XECjz39slfuWv6u+Ml/hnAs8Pc+WWifFW9snquEOBQ3V5sUvycYTdEW4zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BHBf7fZ9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e290947f6f8so481636276.2
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 16:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728516453; x=1729121253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rnxgshIYbuVJCiGrknu4Z8mFt0ASB2N/zPVqtnxTtmA=;
        b=BHBf7fZ9aEuMWvNwQcnmI33ir+ONea7B6rkzeHSvGTJj2OvxVB0CFLE8vqUoi/mOeU
         L250iP41+ML5VBqYWihxdU8ain5FszIHDGxmQUOgKx0fFFwDdAnT63eZtV1eqe+Hio6G
         WLlddakFXX5wsSTvaDbNri8LbIYP084wCar4rPwg765fqZoj1iEjSLPY0/GHhqVm4IX2
         a90e+lAU7XV72qkmujKUmi+bm7MC7IQPqzrjGcIwRMm3VkCjUXHfaLGs8AhQ8rEgHmrO
         pl/awVn99W8dP8nqyVW/93FAiYxFi8qRTQ+4AbvwOsEaUAmt7O4npN1jXRk/fVg/care
         Zebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728516453; x=1729121253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rnxgshIYbuVJCiGrknu4Z8mFt0ASB2N/zPVqtnxTtmA=;
        b=Fdg+gbe12us9IKdAXrvShf+3PSl5hBSi9B96gEeGw4TTm+HZFCERm6NGHau1LpFU7R
         5qqLrXy/wlaElFuykoKHZ9IhMEER8GBSpZsPFN8YcmWfKnWs9QQSf88erlJ70ZKNgCLz
         b1BmQ57ouu+mUNRTkUWqcZIUDPGrSvm/wVioK6XKfU2pnQzWh0GGWCQu2lMSUzxMX5w8
         ut4lnQpQBLMb8Bsf6KcQHlbTjJWaMXjoJkXC+n20MVR3nWHbtuIIB5zLbm6cVSTyf+lW
         AYxjZECVR8V3weKBNrZbc2sn8ZVe0v5Q3ky4ME2vG/s7myMCeNeH3e2N9b/7uVhHhByn
         v7+w==
X-Forwarded-Encrypted: i=1; AJvYcCWF18jURz+3aPfA242rKvfFDAjtb1oNwUDQsJoTJvK6I9MGqLIFv+TIV4zVPg3hm5IyhiP/zmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3jfVrlD+rSEBAZHvDSnB2SBzIdYMxAGYMKDBp3Jpb2Oz093cb
	Ss1NT0+KFgu2OQSL5u8TEybJqV6Cb35KWTz7Zkr4bKMsvFbWoY35iy7ww395mvfmJpoa24ydl3M
	41mStObRbCQ==
X-Google-Smtp-Source: AGHT+IF637qS8mJFxMYIcdsgrckDpeFMdr5YoCa/A9CPFg6Ai4GpmpOSOD/H/DiNA7T7VYhpqyu/GL0DRvTtcQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:51c1:0:b0:e28:ee8e:ed9 with SMTP id
 3f1490d57ef6-e28fe3205fbmr4131276.0.1728516452755; Wed, 09 Oct 2024 16:27:32
 -0700 (PDT)
Date: Wed,  9 Oct 2024 23:27:27 +0000
In-Reply-To: <20241009232728.107604-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009232728.107604-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009232728.107604-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] netdev-genl: do not use rtnl in netdev_nl_napi_get_dumpit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Both netdev_nl_napi_dump_one() and netdev_nl_napi_get_dumpit()
can use RCU instead of RTNL to dump napi related information,
after prior patch prepared netdev_nl_napi_fill_one().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/netdev-genl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 0dcfe3527c122884c5713e56d5e27d4e638d936f..22f766619630f3dc43e3b0ed1708fa9ef38a5451 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -245,10 +245,10 @@ netdev_nl_napi_dump_one(struct net_device *netdev, struct sk_buff *rsp,
 	struct napi_struct *napi;
 	int err = 0;
 
-	if (!(netdev->flags & IFF_UP))
+	if (!(READ_ONCE(netdev->flags) & IFF_UP))
 		return err;
 
-	list_for_each_entry(napi, &netdev->napi_list, dev_list) {
+	list_for_each_entry_rcu(napi, &netdev->napi_list, dev_list) {
 		if (ctx->napi_id && napi->napi_id >= ctx->napi_id)
 			continue;
 
@@ -272,9 +272,9 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	if (info->attrs[NETDEV_A_NAPI_IFINDEX])
 		ifindex = nla_get_u32(info->attrs[NETDEV_A_NAPI_IFINDEX]);
 
-	rtnl_lock();
+	rcu_read_lock();
 	if (ifindex) {
-		netdev = __dev_get_by_index(net, ifindex);
+		netdev = dev_get_by_index_rcu(net, ifindex);
 		if (netdev)
 			err = netdev_nl_napi_dump_one(netdev, skb, info, ctx);
 		else
@@ -287,7 +287,7 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 			ctx->napi_id = 0;
 		}
 	}
-	rtnl_unlock();
+	rcu_read_unlock();
 
 	return err;
 }
-- 
2.47.0.rc0.187.ge670bccf7e-goog


