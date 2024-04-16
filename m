Return-Path: <netdev+bounces-88357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B68C8A6D57
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 16:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D46B23997
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF4512CD91;
	Tue, 16 Apr 2024 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LYd0zphF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5C112CD99
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276463; cv=none; b=sLPwic3UkgiA8n+QCKROI37jRCxiL3ZWuwH7iUSJ8rFsrru4a9AEfbl3bD4kLg3iy5XnDwjE6bNFxUmfwNqVEMFDrlKbyy3CYf68zLA0jjFRQMfEvtaZFxEXXQPWm+KMSf0WO0s36mAdxTmldZ7aLxvZy7wImr6th1tXUSMiJrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276463; c=relaxed/simple;
	bh=T4QBNTdPWgn2+Y70k/HETB3HkKN076WpzzT0wssNHxI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PM+z58O2bH1XTNkdGRseynBf6KJPJiqUHL0LZVl6Zc8Nr1HBdtjya+p5fiX6eWbfT/UHYPq7qyCVbUIX3U7hnFi8uP/O54OIKTB7hAJzaGkXZ4jKbl+OI0SgdsaP3/cYqz0F4DgoPY3V01FIwo4S7MC4FpZBE5dd38SNLp/8QUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LYd0zphF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd8e82dd47eso6089213276.2
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 07:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713276461; x=1713881261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MXqb6WMJmglkxwoGnQhBGCaU/Lemolzb8pYRtLYA7N4=;
        b=LYd0zphF7Ejnjn7yt/9LnsWf7DDVAjZ6Fj3ieRdp1VsZT4jKDfBPvCBtxBXCjlWzmW
         p4NK6EW/Nss9BA2OQbtMPn9FiUurjmOcfMlpTzuKaV8bO8QuhUxBtqWy0+8prKWi+3Gb
         5loeRkb/dqFoadh/hs4pbqrK+q6pcHvHYuLocqiFafPaPIyMKAPXhIOthRjGVCAVV2sC
         kGicLYzYN7B/aCOd4a/IwZfa+NyvEubphSSxNbMLZkNeiDbDCohrEJXQyOw5oFCA86sH
         dDC/ZvlAguza5Hz07qhLGBg3mQyCVV+UT0/PFr2nDXj2549RREBs9j5tTdIPhMe7UhKa
         /mFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713276461; x=1713881261;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MXqb6WMJmglkxwoGnQhBGCaU/Lemolzb8pYRtLYA7N4=;
        b=ISjQjy91fFNkTKUk9Euf9s0GHSs0mo3DJx0w9MdoAbJK5tyACoDZSOLE2ac4GOWuQd
         jqKgGs3i7BKvz9jdxOHFfLgo1il228+A5UfK4yQWaplkb29/rTt4/AD2cJDvcferNOZm
         ZIj5EIUE+6h7tNOQjlJj/w2AfXjKAzY9TEuqhCEzgF/zquBKrTL7crbKErDDArKtyqzd
         tgu4J7Lbo8zNyadG0+zww94JOEPKywZ0AH9o0SkIqeevIZye/nKOhFXnmog/oFBIVbIt
         6izGV1r/Oid0CPaG2WHrqgYihiAlJUNx20Oyzr3YVLTRWaNU/mmCHEMWyzmQ2sTIRVr+
         DbNw==
X-Gm-Message-State: AOJu0Yxd5AIjXCAGGSeBAlIRzR9KJ8Xn+D2FZiQGA73/VyCJaP2IKws7
	KsgMhnY8weVeEdR6Zq1OI8tDnQyKppKLSDcDBF+0A0Wyyga1iU+GPZsoj1Q0C2WmwHSxRRDaL9C
	vEQNyXUKhiw==
X-Google-Smtp-Source: AGHT+IGgUf/hhPTlLB9wB2vJNsWfNneTdnwBh2OvYf/n8ZZIOX/YCgJV15BET8nbY+Bw3YcMlrAYwpkx41JeOA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:154b:b0:dc7:3189:4e75 with SMTP
 id r11-20020a056902154b00b00dc731894e75mr796038ybu.3.1713276461460; Tue, 16
 Apr 2024 07:07:41 -0700 (PDT)
Date: Tue, 16 Apr 2024 14:07:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240416140739.967941-1-edumazet@google.com>
Subject: [PATCH net-next] netns: no longer hold RTNL in rtnl_net_dumpid()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Guillaume Nault <gnault@redhat.com>
Content-Type: text/plain; charset="UTF-8"

- rtnl_net_dumpid() is already fully RCU protected,
  RTNL is not needed there.

- Fix return value at the end of a dump,
  so that NLMSG_DONE can be appended to current skb,
  saving one recvmsg() system call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Guillaume Nault <gnault@redhat.com>
---
 net/core/net_namespace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index f0540c5575157135b1dc5dece2220f81a408fb7e..2f5190aa2f15cec2e934ebee9c502fb426cf0d7d 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -1090,7 +1090,7 @@ static int rtnl_net_dumpid(struct sk_buff *skb, struct netlink_callback *cb)
 end:
 	if (net_cb.fillargs.add_ref)
 		put_net(net_cb.tgt_net);
-	return err < 0 ? err : skb->len;
+	return err;
 }
 
 static void rtnl_net_notifyid(struct net *net, int cmd, int id, u32 portid,
@@ -1205,7 +1205,8 @@ void __init net_ns_init(void)
 	rtnl_register(PF_UNSPEC, RTM_NEWNSID, rtnl_net_newid, NULL,
 		      RTNL_FLAG_DOIT_UNLOCKED);
 	rtnl_register(PF_UNSPEC, RTM_GETNSID, rtnl_net_getid, rtnl_net_dumpid,
-		      RTNL_FLAG_DOIT_UNLOCKED);
+		      RTNL_FLAG_DOIT_UNLOCKED |
+		      RTNL_FLAG_DUMP_UNLOCKED);
 }
 
 static void free_exit_list(struct pernet_operations *ops, struct list_head *net_exit_list)
-- 
2.44.0.683.g7961c838ac-goog


