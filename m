Return-Path: <netdev+bounces-126922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCCF97308B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1DA1F25872
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC19B18C025;
	Tue, 10 Sep 2024 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="W5EGoNSA"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA8818C00C;
	Tue, 10 Sep 2024 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962469; cv=none; b=PtB/O70k9R1bfYY4qxbxGdGJ+JYxG9MAsFH6qsnGVZwYJm57uTe3Sh1g4TTVlxUPF5EOGWbeLb5jfh7tWZLk4b/dtZbCl6qkkrRIjFEB4B9DeVZwoQ1Ht2AXvd4Mjv8yB8Ft/OvqDAbFMhSOXscH5QjLuC1Iipm/yJLYuyIQBqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962469; c=relaxed/simple;
	bh=6V9HMmnSNWWXc7YgMqOhzvnAXvRlAcjh7mRLo7LvQPs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DWL+QENsfkCVfijy6l7lootmOd7qrkTZnmn476z9xMYh9/cLQE6XkfLLuwEfATmRg1RZLmsOXUCNtS+E+WRlV44Ob5nslmvqP+Cw+ikN3FyX5Uc5QQF6VAjnePT+Usfj7SBh4OaFn6RKAdt0XnzHEvs3rxTsMBbYuNkXNrE9Z04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=W5EGoNSA; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 66EE1200DF81;
	Tue, 10 Sep 2024 12:00:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 66EE1200DF81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1725962459;
	bh=AwvMkIo/1KqTrDlY5ALqmh9pB7fSfgZAUHsv5hGUQxM=;
	h=From:To:Cc:Subject:Date:From;
	b=W5EGoNSAOpEyqAiWxmfXWc0gLq8vWjbKlosToT3YUr2NgjDgVMfTi8MuFC65DbJKQ
	 nHGbRsnO++C+K7e0wS+j01o7OAVUjGjdJyySzK7KtBXWykzFBhTfvH7nOOZDsuln6F
	 R+FoB98xwuG3b+V3RvXeE1acSauzUAY3jfS5FAGFjzCgFgippL3dKVkplaCVgC4RmD
	 RgYyh0NNijRzxupIH7daybhnew8FVB7LN80gzmi7iy686K0TP34YBKdC5PKrQo3jmq
	 b1oWI+K71VdF4ctczSQ6QmrvUQRquETg+NzyLBvLLoBCsCpZLRYKO7fAB18mhT323j
	 qthbwZxEyum0A==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	aahringo@redhat.com,
	justin.iurman@uliege.be
Subject: [PATCH net-next] ipv6: rpl: free skb
Date: Tue, 10 Sep 2024 12:00:32 +0200
Message-Id: <20240910100032.18168-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make rpl_input() free the skb before returning when skb_cow_head()
fails. Use a "drop" label and goto instructions.

Note: if you think it should be a fix and target "net" instead, let me
know.

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/rpl_iptunnel.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index 2c83b7586422..db3c19a42e1c 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -263,10 +263,8 @@ static int rpl_input(struct sk_buff *skb)
 	rlwt = rpl_lwt_lwtunnel(orig_dst->lwtstate);
 
 	err = rpl_do_srh(skb, rlwt);
-	if (unlikely(err)) {
-		kfree_skb(skb);
-		return err;
-	}
+	if (unlikely(err))
+		goto drop;
 
 	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
@@ -286,9 +284,13 @@ static int rpl_input(struct sk_buff *skb)
 
 	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
 	if (unlikely(err))
-		return err;
+		goto drop;
 
 	return dst_input(skb);
+
+drop:
+	kfree_skb(skb);
+	return err;
 }
 
 static int nla_put_rpl_srh(struct sk_buff *skb, int attrtype,
-- 
2.34.1


