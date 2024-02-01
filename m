Return-Path: <netdev+bounces-68125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DD3845E29
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54DB1F24BAE
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5697315DBDC;
	Thu,  1 Feb 2024 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rth1MPtp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C208415DBCD
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807387; cv=none; b=A9Kw4VjWJL53KbQqbRdWFhtRmoenqknXOxQaafT8HgjXW0x30l8PhTapG9cYRkMqZO0QOq73kg7mvBhy+gHarNvXMTjUTrXyphxxj7WJIHDMxZYEqa1zA19fQyB4pMCDMVpgLHS2Rf2bzLUd69rqbBU/IRFm9l5D5WWwH+Lx9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807387; c=relaxed/simple;
	bh=UyNXHL0AAbquyRryjTWHlEfC9CbwVr85rRbcyASMaUU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j+/UzdSP63hn/5NJ3Xkyts1Qy9OKAMuNZ0XvJNDX1ZWtws2laSXfmW08CShIAGRpdl7fCuRmYQWptLbvBhJSOXl586OxhtfXYg5ZHa8tY7ReZO81hBsBOOS5QtxsWf6QsWs6CNAgG8RYHZ681nxCNmVO8QsPEW/MF7NkGDakBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rth1MPtp; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso1680641276.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 09:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706807384; x=1707412184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZHMaqb9bXqw89uowGjnODMeAm3e3dYrZmUj9VUKXTM=;
        b=rth1MPtprZoXUKcvHNoMQjMuY1JfPBkOldrVSohb8fDpC9GutOb0NDdBt6XsvOY/oo
         5UcXIfdkhM7QXep9aJBgc5pFb95M/FErYkvNW4NcRn7DVtEcikfCDGbQukD5TrShJlID
         c3vKGd0i/AnwiJ368lL7lcgeRm967XDKiZOYmFegB7nFWejnS7t35d9URELrcoTgn5Me
         wUx7qGLWWj8Wlzv5L9dfw8iH8CzsirNdYW2OGLKsuck5bblGwEfuQOVnfUT/jtUN3bot
         EU6CZPLR+kRB99ocoMglghTe6sFLBtY8SjfdabkaGM0MNjwJI2tE6hrlpkJRSaOBeVV4
         LvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807384; x=1707412184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZHMaqb9bXqw89uowGjnODMeAm3e3dYrZmUj9VUKXTM=;
        b=eVcaS3xNL683hjrOKb2D2GlUCBxFlbWJeIPynMph4IakYQGfkPIuqWAJhm+0Ir3Y4J
         JWgREOrjeyFTxbnv/2GJ7V8sFO5qtsgYWPtgXWkV9F5hgk3unsXrCM8rEgcLAIAN6GqU
         /yMN7oV9eUrN0M4sL2xlrKg2xo9NjCPqHv3ATS4hzd+hVXkhhyRKjyNYEW+PiuWBX3j3
         0cvZon7NDubTqZUCQIFCZaGr65kBqpURmmHKmi9vYdBVQw2xyw3GzwOAPYWhXfYxgOpe
         XX65zLAIvQjOqCgshj6YiMmDW4bBs62xjpVXzBnp82nh8WlpTFGTNeCmiV6Lm1F9cIvf
         UHmQ==
X-Gm-Message-State: AOJu0Yze7xNtKJimploDgOF5qSykkDddfQZCKsQ/dtt1aUSXsSLaowdW
	mBIokfvxqSgZbgMdKrc1eaANeoBeVAsnVLKp/w7ZcwKMp4mJgqg7J95Qm3Pw5cgi3Db4xxCmXDk
	US4lt+TKTSw==
X-Google-Smtp-Source: AGHT+IFp2xuPnvmXpomNvkJyYxjGOcXlzNthWRSYoO4U8MQ3r8/BleNS9iPC1R1yDdMSOMKoMkjPKABzoGwezA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1691:b0:dc2:23db:1bc8 with SMTP
 id bx17-20020a056902169100b00dc223db1bc8mr95715ybb.3.1706807384698; Thu, 01
 Feb 2024 09:09:44 -0800 (PST)
Date: Thu,  1 Feb 2024 17:09:25 +0000
In-Reply-To: <20240201170937.3549878-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201170937.3549878-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201170937.3549878-5-edumazet@google.com>
Subject: [PATCH net-next 04/16] bareudp: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair,
and one unregister_netdevice_many() call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/bareudp.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 31377bb1cc97cba08e02dc7d48761068627af3fb..4db6122c9b43032a36b98916bb4390e3d6f08f68 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -760,23 +760,18 @@ static void bareudp_destroy_tunnels(struct net *net, struct list_head *head)
 		unregister_netdevice_queue(bareudp->dev, head);
 }
 
-static void __net_exit bareudp_exit_batch_net(struct list_head *net_list)
+static void __net_exit bareudp_exit_batch_rtnl(struct list_head *net_list,
+					       struct list_head *dev_kill_list)
 {
 	struct net *net;
-	LIST_HEAD(list);
 
-	rtnl_lock();
 	list_for_each_entry(net, net_list, exit_list)
-		bareudp_destroy_tunnels(net, &list);
-
-	/* unregister the devices gathered above */
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+		bareudp_destroy_tunnels(net, dev_kill_list);
 }
 
 static struct pernet_operations bareudp_net_ops = {
 	.init = bareudp_init_net,
-	.exit_batch = bareudp_exit_batch_net,
+	.exit_batch_rtnl = bareudp_exit_batch_rtnl,
 	.id   = &bareudp_net_id,
 	.size = sizeof(struct bareudp_net),
 };
-- 
2.43.0.429.g432eaa2c6b-goog


