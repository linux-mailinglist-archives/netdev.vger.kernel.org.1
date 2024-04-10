Return-Path: <netdev+bounces-86500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D98BA89F08A
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 13:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E690283A41
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBB615959A;
	Wed, 10 Apr 2024 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ibpU4Dyn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EA013D274
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712747994; cv=none; b=QvPCwKqy8WpA5RKZz34mbQ7t8XLM/szaftcAnTKTX2boq7LcOABCKALbXXANJp7NvaxPy6IYK4OaZHE0TPV67kJx6PmPGpsXsUBo5AXWVK1agT7RUCr/kc4GGDT/1VelYDkba+3uA2mGUoZ0f+UDbEnJn1lAi4iLvgdps8TBZE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712747994; c=relaxed/simple;
	bh=YAGkWYZifCkXDVHScftxaCZUk8IaTwIU/7+0wDxryyY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DJaCkFYCa6d6oqwlpiA+/6k5BbeKkIIERq2tcwZEoj7PEV5ktADroPijZTu7YWZB+NSMkCQ3cdY3HhvjyGLgTnK7Bn9ixSFaJWufjg/7lQNGMpa7BNtuyrXmj2LqisfubWnfBQwkElrgQpLDfvF+hroHJqv32lxqvv/jmUsdrTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ibpU4Dyn; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4347187e8b3so44528651cf.3
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 04:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712747992; x=1713352792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o4COSb0g1cktMwafCTGoFjhFPTnFs1BUvbdlglR3qGs=;
        b=ibpU4DynVa3TUT5UwZg6kG9TyTEhlBuo2srrBZsqLebxcaHQl2G3MfzprXFbGc8V88
         5CkcTaAPyEnlyE5Z4TGkJNJ1xq5rZYBDwA03j2NlltH+mcEGl5y/lszlFOX06xPt5ujQ
         reOzXsRbv7nBG0SpHvo/pP974yaLAySgNcKLwbgVcAdZURFmh9p89XBEzY9HmBWX+fKS
         UpJPw1jsuHsPxhFHNyNh5rLjWSnPvwm9CMf+p0OkkYSofRiDhdhq+vECJRCdzlIff7W4
         MnFRC2kWKo9d9qS1bQqyDmRo33NTrq8ZsDVds5lcXK5mwiHvnWB0KnF587jNOYl7tLiR
         sKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712747992; x=1713352792;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o4COSb0g1cktMwafCTGoFjhFPTnFs1BUvbdlglR3qGs=;
        b=i/zjYUQFKbU9cEMzJxW3hBQ2xgZETc89w4TJaJpcJxx2+wuSp4mQVNLNQuxMQ2UM39
         lZ0JuBQkXcNrycJnLp0ZvPJO9qsjKmD4AvRzSjv7O4hJJxkovjb1k743m6jksROmayxW
         /wfdsixhlD+GW8QyeFR4jufmvHroLjoED9oXT+Khwi+PWARXZPAuQxQduzZwb+wrfpkw
         /rlWVw7/VE245Wx6yhzN9z28DhU7+52EUxbV3W4jhRMgJC3BMvEsbR8KQXQJw5/dliJe
         1J87GskLABzJiaSYn44yf7oEQDQIlHr0+h9yPaEyUqVOHAFxiidJw5qSrLbpWCVOpSlf
         tKYQ==
X-Gm-Message-State: AOJu0YyUHC6oGQtG36+bvRj0KzNApvNLI+hQ26A5XoglhleEVMnkXZVK
	mM01PyC0zl3bCbNrNfEyAWD7gA1pH+Rirpp1GOzcLFfpXk6H7j7lOJ+OmTs660Nd6DRZ4BmWXOm
	OkRDUjvPC0Q==
X-Google-Smtp-Source: AGHT+IHPNnEHrIXNv2p94CUrZoeIbXQCYN1uBmxQ6l4UnlUq52vhxuuM5Wb8ECWx7QagBspS/B/xIaFfi420xA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:ac8:73d8:0:b0:434:fe03:15d7 with SMTP id
 v24-20020ac873d8000000b00434fe0315d7mr17023qtp.12.1712747992312; Wed, 10 Apr
 2024 04:19:52 -0700 (PDT)
Date: Wed, 10 Apr 2024 11:19:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240410111951.2673193-1-edumazet@google.com>
Subject: [PATCH net-next] mpls: no longer hold RTNL in mpls_netconf_dump_devconf()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

- Use for_each_netdev_dump() to no longer rely
  on net->dev_index_head hash table.

- No longer care of net->dev_base_seq

- Fix return value at the end of a dump,
  so that NLMSG_DONE can be appended to current skb,
  saving one recvmsg() system call.

- No longer grab RTNL, RCU protection is enough,
  afer adding one READ_ONCE(mdev->input_enabled)
  in mpls_netconf_fill_devconf()

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/mpls/af_mpls.c | 59 +++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 37 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 1303acb9cdd23f48f22c35e019115895d14df8b4..0315b8deed3ffeec7778acc4a098e5dc17aff209 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -1154,7 +1154,7 @@ static int mpls_netconf_fill_devconf(struct sk_buff *skb, struct mpls_dev *mdev,
 
 	if ((all || type == NETCONFA_INPUT) &&
 	    nla_put_s32(skb, NETCONFA_INPUT,
-			mdev->input_enabled) < 0)
+			READ_ONCE(mdev->input_enabled)) < 0)
 		goto nla_put_failure;
 
 	nlmsg_end(skb, nlh);
@@ -1303,11 +1303,12 @@ static int mpls_netconf_dump_devconf(struct sk_buff *skb,
 {
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
-	struct hlist_head *head;
+	struct {
+		unsigned long ifindex;
+	} *ctx = (void *)cb->ctx;
 	struct net_device *dev;
 	struct mpls_dev *mdev;
-	int idx, s_idx;
-	int h, s_h;
+	int err = 0;
 
 	if (cb->strict_check) {
 		struct netlink_ext_ack *extack = cb->extack;
@@ -1324,40 +1325,23 @@ static int mpls_netconf_dump_devconf(struct sk_buff *skb,
 		}
 	}
 
-	s_h = cb->args[0];
-	s_idx = idx = cb->args[1];
-
-	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
-		idx = 0;
-		head = &net->dev_index_head[h];
-		rcu_read_lock();
-		cb->seq = net->dev_base_seq;
-		hlist_for_each_entry_rcu(dev, head, index_hlist) {
-			if (idx < s_idx)
-				goto cont;
-			mdev = mpls_dev_get(dev);
-			if (!mdev)
-				goto cont;
-			if (mpls_netconf_fill_devconf(skb, mdev,
-						      NETLINK_CB(cb->skb).portid,
-						      nlh->nlmsg_seq,
-						      RTM_NEWNETCONF,
-						      NLM_F_MULTI,
-						      NETCONFA_ALL) < 0) {
-				rcu_read_unlock();
-				goto done;
-			}
-			nl_dump_check_consistent(cb, nlmsg_hdr(skb));
-cont:
-			idx++;
-		}
-		rcu_read_unlock();
+	rcu_read_lock();
+	for_each_netdev_dump(net, dev, ctx->ifindex) {
+		mdev = mpls_dev_get(dev);
+		if (!mdev)
+			continue;
+		err = mpls_netconf_fill_devconf(skb, mdev,
+						NETLINK_CB(cb->skb).portid,
+						nlh->nlmsg_seq,
+						RTM_NEWNETCONF,
+						NLM_F_MULTI,
+						NETCONFA_ALL);
+		if (err < 0)
+			break;
 	}
-done:
-	cb->args[0] = h;
-	cb->args[1] = idx;
+	rcu_read_unlock();
 
-	return skb->len;
+	return err;
 }
 
 #define MPLS_PERDEV_SYSCTL_OFFSET(field)	\
@@ -2773,7 +2757,8 @@ static int __init mpls_init(void)
 			     mpls_getroute, mpls_dump_routes, 0);
 	rtnl_register_module(THIS_MODULE, PF_MPLS, RTM_GETNETCONF,
 			     mpls_netconf_get_devconf,
-			     mpls_netconf_dump_devconf, 0);
+			     mpls_netconf_dump_devconf,
+			     RTNL_FLAG_DUMP_UNLOCKED);
 	err = ipgre_tunnel_encap_add_mpls_ops();
 	if (err)
 		pr_err("Can't add mpls over gre tunnel ops\n");
-- 
2.44.0.478.gd926399ef9-goog


