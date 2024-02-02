Return-Path: <netdev+bounces-68619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7874884765B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274721F267BD
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F319914D434;
	Fri,  2 Feb 2024 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2HTYJEtx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595BD14C596
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895618; cv=none; b=PqAZquGcNKtkonuFmpEaefsU1TqobZxcI+qQvYNaatyQQg7cZe6qqk93WixEM2clt05+FI6T21c73kyYsm9WweaHrx+8nLok/qrp56hyblKiglZKmP1eeW9sbYoZkuqPmlvLvk0vp/3+1J58IhRoDjzRASef6SaW0kM2e3uBztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895618; c=relaxed/simple;
	bh=k9fUrSbW5szIVxWYbDGkn3eO8e2dGBLXV1Es3iOfIW4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KVy1Roog6oRwdw1JLcGuVGmd6U97jvB11qJGTiE2YUSYJHb6dilHNU7oLJkheENgZn70nAnNN4S8kofl9YQUneJLSQNd51WQP0Fgws5w+BJmA9M8KqpJop5KQZpVM/Am7/JtzSfhnqYfcy7lzo/fLZZkqHk2pQvuy+JHgRojIAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2HTYJEtx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc657e9bdc4so3179517276.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 09:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706895616; x=1707500416; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NmH2mXx1hk7X3+z9/4AcTNACq0Ffa/sBHF+P4vNg8bc=;
        b=2HTYJEtxZXz0Z16ao8xkLnrM3sho3gPA2XhIu7FBbTaVGo+zeuODF045I6KGkbYo/i
         sk0s6iO444me4Vkalth0W8vHg7GmD3yqFJLpR2e69Al41UFcvx/Rm84KgjAIomglac5R
         jwwqXSWhRlcTyWpA4Z9cD9bgGg5+y5lzeIvdgIvaNaYyX3PtKU2qvP72YY4LO5uzvz3H
         jdMV4P6RSQv7rsN76wmQPEXJmHoUTpgVUSf03skwlcRMccmwBIxIyaDbbgMlRYUk1dS5
         qIk+n7OZxhrt+IdLb0Gvm2DPY/7LHJB1+Ah5qn3HcnBzQ6ABftQNJVXvq8gfnp0uB7RL
         AnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895616; x=1707500416;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmH2mXx1hk7X3+z9/4AcTNACq0Ffa/sBHF+P4vNg8bc=;
        b=Hc+noOQx70fkhVBE5cWydG7pmCwwsoI1749Y85lC5eLq+fHPFvyOJF0s8poNXvU8Hq
         pTa61GIEGBP104Uz+cZ9YPkYK40RLobaTZQG8PG23VKsNE4g4Dtsa3dzdYqY+Zu+5dVq
         BhgEnCWbPlt0vcA1bbFpL0rE2aRXGOnarcmKpfy0boSJ3Y4dJk0VNk17ROMJS+BXrIPa
         Wd4po/dDaOjU16Etl5vZqN05vzv7FrTF66Lo3DM4m/D8xLRbXTD3y4b79ORXCmNu1lEX
         XNLqS3MrlEJiVjzjiksznRvjFACoTyLqsc9vPlAA/r/XiHfx56Gxvx9j6BuLd7Fm/6r2
         azhQ==
X-Gm-Message-State: AOJu0Yx/DSK/VPAMjfBctg4bfoKP0dJZy1uyfyNK+0uHpMotlYqIl/OI
	MWMs03ksTFcqVn11o292IbTFw6zI+7b0vUqOQpFRPEcLr3H9Ah0yoaYze6cMbF6B0muWGMgx7CT
	Wz7zO1uafcw==
X-Google-Smtp-Source: AGHT+IGRrme8FaSwnbDpNPgBaItw6bZFXeH9vEPOp21pCLULFQS/JEjp7EFYcReMrTmmxqoXy3MrQoyZH83l6w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2402:b0:dc2:2ace:860 with SMTP
 id dr2-20020a056902240200b00dc22ace0860mr144195ybb.2.1706895616415; Fri, 02
 Feb 2024 09:40:16 -0800 (PST)
Date: Fri,  2 Feb 2024 17:39:51 +0000
In-Reply-To: <20240202174001.3328528-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202174001.3328528-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202174001.3328528-7-edumazet@google.com>
Subject: [PATCH v2 net-next 06/16] geneve: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair,
and one unregister_netdevice_many() call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/geneve.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 32c51c244153bd760b9f58001906c04c8b0f37ff..f31fc52ef397dfe0eba854385f783fbcad7e870f 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1900,18 +1900,13 @@ static void geneve_destroy_tunnels(struct net *net, struct list_head *head)
 	}
 }
 
-static void __net_exit geneve_exit_batch_net(struct list_head *net_list)
+static void __net_exit geneve_exit_batch_rtnl(struct list_head *net_list,
+					      struct list_head *dev_to_kill)
 {
 	struct net *net;
-	LIST_HEAD(list);
 
-	rtnl_lock();
 	list_for_each_entry(net, net_list, exit_list)
-		geneve_destroy_tunnels(net, &list);
-
-	/* unregister the devices gathered above */
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+		geneve_destroy_tunnels(net, dev_to_kill);
 
 	list_for_each_entry(net, net_list, exit_list) {
 		const struct geneve_net *gn = net_generic(net, geneve_net_id);
@@ -1922,7 +1917,7 @@ static void __net_exit geneve_exit_batch_net(struct list_head *net_list)
 
 static struct pernet_operations geneve_net_ops = {
 	.init = geneve_init_net,
-	.exit_batch = geneve_exit_batch_net,
+	.exit_batch_rtnl = geneve_exit_batch_rtnl,
 	.id   = &geneve_net_id,
 	.size = sizeof(struct geneve_net),
 };
-- 
2.43.0.594.gd9cf4e227d-goog


