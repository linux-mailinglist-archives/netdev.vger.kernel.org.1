Return-Path: <netdev+bounces-146711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C99D9D5382
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 20:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538511F210FC
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 19:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C23C1C2337;
	Thu, 21 Nov 2024 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xcVJg9f2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C342919E7E0
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732218070; cv=none; b=GQH9a7qREtD3faUmGiQk+R3EWY7DSK6xOsqGJ/Zh+FA7k5R7xrjlkCzQp6P8bsCnzVwDwxUpFoiy41sjF5t67sc37oSHBB3IcUE3objRDmOhgesAgL0OLP55pNyiO2CCFFu5Hw44eXb6EgHHngdnFsGPUafGkMNVtjENhY9R6XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732218070; c=relaxed/simple;
	bh=QmhdxhyD8h1s2sgtvIIpIgCrdUwuOQcajjQRDbdgvkY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ErPaGVfzmwxCMefYa3eHZH48AycjBrQn7kKXk4TrvGFoeQG6aD0M0wB8JkHlTdsZHkpPjsEXRPlEK/zXXbSgyetPIeXoAQVvZ0s9nYyfqeNmqdA+z8fs7cPQ5KKMQX7KVr//1XP5nC+EPjceP1xRSVEJTOusZb2fSm5STAOJOkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xcVJg9f2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ee7856bcf2so22042957b3.1
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 11:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732218068; x=1732822868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uYafjHjMfevY6HyxR8rSAcCI0JfpTjAEZTP5feHZYQ4=;
        b=xcVJg9f2V+pwflWwtPKGFwezRqKWOop2tM8aYZRqJidJ5gAmeItLT2PQVv9iG9SzcV
         NORkslLHrG8DtqJOpaI+LINu9p2JBuKT1TRf2gYH7xWxiFdYDs6Bk8kKlyz/Ed2ZvoQK
         Sql/kCxq366GqaEGCQD/Eorc4hMRYs+RUqdbz2xQFl1s1LtRlnwhjCGgynmeyZc7SU7W
         KKlZTP/YOLLDvFEthQeRYMKRVr56J9HKiJVl8T6YvDdx66ppxwzArhDmSLhiqKP7pQXm
         LjjwRrYkfQejV2Bjpw40nkQSzwezBkg/ALsD9ly5ycok9kCIAYzOS9Y6vRcE1o6pdM6c
         X2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732218068; x=1732822868;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uYafjHjMfevY6HyxR8rSAcCI0JfpTjAEZTP5feHZYQ4=;
        b=r2886jiV9tJbBnH3o0zX6Sl28DDshMykrEMc2R1QGB4jtaBwqcK29saQFs5eYi73Ub
         u71TKH19FzYHDpqpBBJ/hppczoWo4hMdzt9JEkcKYfVwpsO9UaJNjUrA0lsZhKaf7bK0
         rD05tE7A2ThmttYzsE7WvanYM55Sr+d+lN7p0G7VjAq1MjzuOfBTBCRLQlahj/q2Ge4o
         ySTNr1kTrFernXO7XB8KWEK66vV1ypE84EowtswlSd2dsaTSdxMY8FXiRurCmkG2yLGw
         i0juBOh1BCzeAa42hVQ7/E0SlzVi3tm5KSAv+bYRFuHpP7u4wx5z7cBfAxn2HVOfJS84
         7i9Q==
X-Gm-Message-State: AOJu0YzrBaaXEaqXYjqZm5/UaGhkEEDfbm227Np4QQbHEgyFvay+dber
	BG8X5wr57rOfDXmXIEY0QBeax2s25T0sUTQzwkbYDLrCyergJNbUzt3k9858EkxPY3L7HixfMXq
	dji5jD66h7w==
X-Google-Smtp-Source: AGHT+IFSDrVyfjLNBpby2LzDQ2CXgpb8d+VPkhpY9O1d6+2Vx+YRn8EOpJsNEnwwJ91hX9TkOxqxWTo/firJ2g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:2d08:0:b0:e38:e8d:2c02 with SMTP id
 3f1490d57ef6-e38f8bbb5acmr28276.5.1732218067704; Thu, 21 Nov 2024 11:41:07
 -0800 (PST)
Date: Thu, 21 Nov 2024 19:41:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121194105.3632507-1-edumazet@google.com>
Subject: [PATCH net] rtnetlink: fix rtnl_dump_ifinfo() error path
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"

syzbot found that rtnl_dump_ifinfo() could return with a lock held [1]

Move code around so that rtnl_link_ops_put() and put_net()
can be called at the end of this function.

[1]
WARNING: lock held when returning to user space!
6.12.0-rc7-syzkaller-01681-g38f83a57aa8e #0 Not tainted
syz-executor399/5841 is leaving the kernel with locks still held!
1 lock held by syz-executor399/5841:
  #0: ffffffff8f46c2a0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
  #0: ffffffff8f46c2a0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
  #0: ffffffff8f46c2a0 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x22/0x250 net/core/rtnetlink.c:555

Fixes: 43c7ce69d28e ("rtnetlink: Protect struct rtnl_link_ops with SRCU.")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index dd142f444659d9a5da084bddb26736b1602cc2cb..58df76fe408a4677db52a3c1f94674119dc4c925 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2442,7 +2442,9 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 			tgt_net = rtnl_get_net_ns_capable(skb->sk, netnsid);
 			if (IS_ERR(tgt_net)) {
 				NL_SET_ERR_MSG(extack, "Invalid target network namespace id");
-				return PTR_ERR(tgt_net);
+				err = PTR_ERR(tgt_net);
+				netnsid = -1;
+				goto out;
 			}
 			break;
 		case IFLA_EXT_MASK:
@@ -2457,7 +2459,8 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 		default:
 			if (cb->strict_check) {
 				NL_SET_ERR_MSG(extack, "Unsupported attribute in link dump request");
-				return -EINVAL;
+				err = -EINVAL;
+				goto out;
 			}
 		}
 	}
@@ -2479,11 +2482,14 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 			break;
 	}
 
-	if (kind_ops)
-		rtnl_link_ops_put(kind_ops, ops_srcu_index);
 
 	cb->seq = tgt_net->dev_base_seq;
 	nl_dump_check_consistent(cb, nlmsg_hdr(skb));
+
+out:
+
+	if (kind_ops)
+		rtnl_link_ops_put(kind_ops, ops_srcu_index);
 	if (netnsid >= 0)
 		put_net(tgt_net);
 
-- 
2.47.0.371.ga323438b13-goog


