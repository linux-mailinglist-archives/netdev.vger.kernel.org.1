Return-Path: <netdev+bounces-68614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1538847657
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDE3EB24702
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A6B14C595;
	Fri,  2 Feb 2024 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cRqEIwmw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177F514C585
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895611; cv=none; b=f8ySzRLsvAz444Cv2eL7Fua1kWA4fILqeTRdL1Oed6BRjpm8SI7ojoq8dspiEPjcGiVwrjbPcVlQpmlGQrFT5oGWxgB5p7Gxv5q3a1QyGRgqUp8y1fK+91Bp9sbr/0BK8/bqHWL7Gau1uzAtEc0FF8UvK/Mcw2nKqEylTqopfII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895611; c=relaxed/simple;
	bh=+yINh35bfAiZWKoTc2XjLbpWtXvlPFBYA2QJiwtwoYY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=STaQ5/E+pJZAiR0iKf+wvko4GlZ9bLR+aLfQpFOapU9c6wOKaaNihv7yT4+OcJ8WOSVvDyi9wN+QNG0uyxV4caad29fnWtBBS555/pDS7+xTIkVXe5Arh4866waeApWugCgdiAxV9cUOeeiA+E0R6s7iwDnQKqJMyoC6+OsgMHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cRqEIwmw; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604127be0a0so46145287b3.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 09:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706895609; x=1707500409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=be8DPM7QBRVgl+d52ElO4rhCMBDgqMy5KLVv6i8kX0Y=;
        b=cRqEIwmw9pV/XqpTyExe3ykt3sAqYkjIEAKMhfzKAnbuxK0T5rnwOqffBGjnlaQJf/
         zBBy3Vmz/DIdgDT/nsSBa/wY2JF5NvGFzF+88HqrDFu5uLApk2k252duQmfQqZ8JZyqW
         in03eo3Q2xPsAH00JlW8brJVwbKd0HPskO8vEjun39xOtYL8dugwLig/MNRne4cCVsSr
         WHGn7t7pgRPZER9qfn6OWo3Ljtj5zCzFR3ZVHOfLBt5/MWIrR3R0ycIdmfdMlDLdd24E
         XPuQbJ9YXXDUSH0lOH8iAyNvtJjHwdXYxolqFA4yJsIf7Yu66eG0lrW8wl4g8S5YgnMQ
         SR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895609; x=1707500409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=be8DPM7QBRVgl+d52ElO4rhCMBDgqMy5KLVv6i8kX0Y=;
        b=jLTySrtgyRMNa6JHpI+gCJdByMLz6WIPVYJZ0N0n74TPGEa21ceYISMkTvr19nXLRL
         GvVci/CuZlDCLCmlkxuaJB25HefC1hfxYdXycasg9TnkYSlEKtYkX+iAjNtc3y9eHkVr
         GAxyZ/waymwaIxxUdUEwxk03R0CznwWwHacMdHb4hbvZ12r2h+UWccFVp1hJwKbyFz2O
         HTm+bcYLo0tYKkntrI6SyhyzgZOPKXDUfXKUCYndJsZPiEdn+2fna2k0d7tcnsiBZpJH
         6t9IX4F7XSk0UAxXbLFSkdNGkpkMPTvhXTYAGw3ixGmuEvUfwTZ/deOo9PpKJhQ183Yy
         t0lw==
X-Gm-Message-State: AOJu0Yxob6lEKfQS4IgcLyqPialkEvFv0nLqnyJsmYmZXSaOOkq/THNP
	LmAE+dH+66vpecCbNbneU6vp3pCI1saPqErp6AgUqEta9Tav6WPdSko42xCLIxdi4yoN+uC0/0L
	xh6ktD6XSxA==
X-Google-Smtp-Source: AGHT+IF34QlCbmtBRccS65ko90M5Rt58/PxmhT5D9Ky5umD351GPOwQV2tshgclsvn/Cnik/LH1VElgexYj1ag==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2845:b0:dc6:dfd9:d431 with SMTP
 id ee5-20020a056902284500b00dc6dfd9d431mr1177795ybb.1.1706895609054; Fri, 02
 Feb 2024 09:40:09 -0800 (PST)
Date: Fri,  2 Feb 2024 17:39:46 +0000
In-Reply-To: <20240202174001.3328528-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202174001.3328528-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202174001.3328528-2-edumazet@google.com>
Subject: [PATCH v2 net-next 01/16] net: add exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Many (struct pernet_operations)->exit_batch() methods have
to acquire rtnl.

In presence of rtnl mutex pressure, this makes cleanup_net()
very slow.

This patch adds a new exit_batch_rtnl() method to reduce
number of rtnl acquisitions from cleanup_net().

exit_batch_rtnl() handlers are called while rtnl is locked,
and devices to be killed can be queued in a list provided
as their second argument.

A single unregister_netdevice_many() is called right
before rtnl is released.

exit_batch_rtnl() handlers are called before ->exit() and
->exit_batch() handlers.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/net_namespace.h |  3 +++
 net/core/net_namespace.c    | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 13b3a4e29fdb3b1f37649072ea71181ec1bad256..5e5b522eca88e9e19345792bd5137eb8cf374265 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -450,6 +450,9 @@ struct pernet_operations {
 	void (*pre_exit)(struct net *net);
 	void (*exit)(struct net *net);
 	void (*exit_batch)(struct list_head *net_exit_list);
+	/* Following method is called with RTNL held. */
+	void (*exit_batch_rtnl)(struct list_head *net_exit_list,
+				struct list_head *dev_kill_list);
 	unsigned int *id;
 	size_t size;
 };
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 72799533426b6162256d7c4eef355af96c66e844..233ec0cdd0111d5ca21c6f8a66f4c1f3fbc4657b 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -318,8 +318,9 @@ static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
 {
 	/* Must be called with pernet_ops_rwsem held */
 	const struct pernet_operations *ops, *saved_ops;
-	int error = 0;
 	LIST_HEAD(net_exit_list);
+	LIST_HEAD(dev_kill_list);
+	int error = 0;
 
 	refcount_set(&net->ns.count, 1);
 	ref_tracker_dir_init(&net->refcnt_tracker, 128, "net refcnt");
@@ -357,6 +358,15 @@ static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
 
 	synchronize_rcu();
 
+	ops = saved_ops;
+	rtnl_lock();
+	list_for_each_entry_continue_reverse(ops, &pernet_list, list) {
+		if (ops->exit_batch_rtnl)
+			ops->exit_batch_rtnl(&net_exit_list, &dev_kill_list);
+	}
+	unregister_netdevice_many(&dev_kill_list);
+	rtnl_unlock();
+
 	ops = saved_ops;
 	list_for_each_entry_continue_reverse(ops, &pernet_list, list)
 		ops_exit_list(ops, &net_exit_list);
@@ -573,6 +583,7 @@ static void cleanup_net(struct work_struct *work)
 	struct net *net, *tmp, *last;
 	struct llist_node *net_kill_list;
 	LIST_HEAD(net_exit_list);
+	LIST_HEAD(dev_kill_list);
 
 	/* Atomically snapshot the list of namespaces to cleanup */
 	net_kill_list = llist_del_all(&cleanup_list);
@@ -613,6 +624,14 @@ static void cleanup_net(struct work_struct *work)
 	 */
 	synchronize_rcu();
 
+	rtnl_lock();
+	list_for_each_entry_reverse(ops, &pernet_list, list) {
+		if (ops->exit_batch_rtnl)
+			ops->exit_batch_rtnl(&net_exit_list, &dev_kill_list);
+	}
+	unregister_netdevice_many(&dev_kill_list);
+	rtnl_unlock();
+
 	/* Run all of the network namespace exit methods */
 	list_for_each_entry_reverse(ops, &pernet_list, list)
 		ops_exit_list(ops, &net_exit_list);
@@ -1193,7 +1212,17 @@ static void free_exit_list(struct pernet_operations *ops, struct list_head *net_
 {
 	ops_pre_exit_list(ops, net_exit_list);
 	synchronize_rcu();
+
+	if (ops->exit_batch_rtnl) {
+		LIST_HEAD(dev_kill_list);
+
+		rtnl_lock();
+		ops->exit_batch_rtnl(net_exit_list, &dev_kill_list);
+		unregister_netdevice_many(&dev_kill_list);
+		rtnl_unlock();
+	}
 	ops_exit_list(ops, net_exit_list);
+
 	ops_free_list(ops, net_exit_list);
 }
 
-- 
2.43.0.594.gd9cf4e227d-goog


