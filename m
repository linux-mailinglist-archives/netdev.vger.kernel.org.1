Return-Path: <netdev+bounces-69123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49247849B03
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AACD1C223B8
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7162D60F;
	Mon,  5 Feb 2024 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hzjdnJB+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248772D052
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137289; cv=none; b=sl2iDSBNX5GijyNsfQWhaBwUq/CoLLDYqkzih3DaVK4jW6Nk1F28xtjJ2f2aQt0n7mv0OsSRvliOBLlxe3irtLY0gDhhI26Ix7XHZqyXx1QktYjKd9UhOQk2QR2Dru2S14WnXsX+YSYHGtO/BYcTIZ65Q8vHKJVgH9qaZYzEhR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137289; c=relaxed/simple;
	bh=k9fUrSbW5szIVxWYbDGkn3eO8e2dGBLXV1Es3iOfIW4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YO+p/UVUVqBEVnb1pyFtCf+yZ4DWknpQpQmS2hW2RCd2d1f00DUj7TUIFIg4fGFqTnvo3FxVQtpXQN8MKRjFGKPRdSji/Wk9fW47eReBHeiGmiIJUS0EUjSOenL468ze4QdOJq0hl9boMo3yqvc6ZnkN0vtJGKZFLl0S7lTXTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hzjdnJB+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6043c795ee9so20629907b3.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 04:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707137287; x=1707742087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NmH2mXx1hk7X3+z9/4AcTNACq0Ffa/sBHF+P4vNg8bc=;
        b=hzjdnJB+Od/iJh8b+Ku0iILhC+FTBR5kdoQJaKjdYUsakl75rlJV0TGXcpNHFHxBvf
         wwGk+hkxaiSAzYcy3XOI0A4Ac15A6+5sRJIwqLS9/xY+VMn9oN3DzNUFMm0KMeKy6/FS
         fYLLufIrFlsH5quG1rDFWjW4lmIu/CIDoPMxKxxsIBZuqWG9ILxcRkPZ7HMseGUwlw40
         I0u78TgcHmQnNqp3suLXgtYlOSZMQt0VnCj/Sud98gQ/j+RoX1AmKRnRIHFK1UNn/iY4
         v/vUqcO4mKy2aPg6fGFfAaYbvS0BmBu4D2Omfs42ChJtpj/QNsn8H1ikV8C/e05qZ7A0
         kATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137287; x=1707742087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmH2mXx1hk7X3+z9/4AcTNACq0Ffa/sBHF+P4vNg8bc=;
        b=ckQYLsdtDw0RE+gBQ2BzJQyH/aLfuptIBsn+7MJuYKLOidBDu6vlH/7kSIsgxB+KBb
         VlYztoIYwXNO7Jpml9kr1r5dIPaHVR1hfurcY7XYwP4nmskpguXEACmlzCW+rsqtmCjx
         02XJy+H5Eu2zMzGpHebMYusn0iCghnG1AW98Jwu3EOsVm4zraL5H4Lc3xfw1Q4rpeeSI
         4bTa5o3JpshvENZzXiNmQjO68u6yGs1/26fkefyPFYNnp5Ij9lZh00UjUYKtCoPILTvi
         vcoA3TOEeSBevZujMcUVyOtnhAseN9uZXGJxu3wz6pr1W5BBNh+ARbXvHT+E3utqoAag
         O6PQ==
X-Gm-Message-State: AOJu0Yz6cGVsY7ECPqoN2z6nrlrYe4An7l7iKIYcRqNWEgjx2pKkEAr8
	5ZE1cBjw/kqgRX6/X6SIOG2ge/LbfTDcr6NE1FQ7XStxkcq6E3k5O2pa/DFqY7iW4JhIyTw+0JI
	JYsqsxoZDpQ==
X-Google-Smtp-Source: AGHT+IHAGfM+wGDq2ECDMM0oKtmTBhFNEJEtUf0/af//t507wxeHyVsgLcXoh5cj7A8LXl3f1KMy8MnoZyabeg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:4c84:0:b0:604:269:9d85 with SMTP id
 z126-20020a814c84000000b0060402699d85mr2384274ywa.6.1707137287113; Mon, 05
 Feb 2024 04:48:07 -0800 (PST)
Date: Mon,  5 Feb 2024 12:47:42 +0000
In-Reply-To: <20240205124752.811108-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205124752.811108-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205124752.811108-6-edumazet@google.com>
Subject: [PATCH v3 net-next 05/15] geneve: use exit_batch_rtnl() method
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


