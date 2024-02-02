Return-Path: <netdev+bounces-68625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8139D847661
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F431F2A28D
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762E714E2E4;
	Fri,  2 Feb 2024 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E9fMlScm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D4E14D447
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895627; cv=none; b=AfdbrdN/RoMAJvl9d4OOrkN4mfkTuToEIdtXs2xAsKTTLmrNYPBP1O9pYj7Cpbep51p8JcOM4/R3Z3optmjhRs2b28z1vDnXCvtZwORp+4k6yQF/dehzx5SJHVshjUAPdnwLms9rYH21HhP+LWni2j6uDE1zXwmo+lPKzF/JmPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895627; c=relaxed/simple;
	bh=JMN+6+qy7+2YBgl8bpl2o9VZJSrVMjIkLeNGM71Q5u4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fhGWn7/x0Gr3ucwAudvo2yc1q3IhQ2JhFLZzsoGBzqve5OWCXTKsPmBn/oog9SgUwZ8Q0/kyulCESrQZGkI/4+q2m6Kt4ldFOiHrz+KM54rZZ5GHzqd7iW4JcbcOoyZMcrmlGiC/xcJT+p8c5YW8IBnl8ZUSClv7Hbv/BD2mHq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E9fMlScm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6040597d005so44982217b3.2
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 09:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706895625; x=1707500425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JNq7fovMjY+uQyu+qQl8ejtpYY0RqTC2Fjxd4aNS7Fw=;
        b=E9fMlScm1tPStZDH6xmSymET9/nUupBCbHngrKd1dK934HZsT6WXmNePz+14a+uc8N
         Ofq/6rkbaLc6IYCrh2pSN5gDazZdZk9V/xJDlxp0RN/DUn7wzddl6mvwYydQZjDn12bE
         aKaZ3DlN8nLfg0vgqMEtAmX9wbxMCGAGJ8DSU+8JVMTxdxJN3P/oi47yrqcGHPwGtrTv
         N+vdzOI0kBSWzygPV4M4PL2mJmfH/AAh30z+FDO8HTSjXMWNroY4+5yerwugiQy/aQQ3
         w/XfuutdNuP+VY9u93IbRnwOkGVyzlRxSkFTH9ZhtvuEf9q6uHUQkaUZ8TEu0ncmB6lB
         8UOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895625; x=1707500425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNq7fovMjY+uQyu+qQl8ejtpYY0RqTC2Fjxd4aNS7Fw=;
        b=EzmnJLGIKfcwyMomG7275TeLcf62KhrfrlQlL5TLJYRqnwnGtS0SNE/ob4hcjn44bU
         6B0VZY4hyoU2nRQARnBFPgDFmg9+Sdh+uYiiceA2YqJfkVR6REKxesZ4Wenjy5Rrsv1T
         jJe8/Kz4Sr31vtV3LHDYGLCJslXONKBvVpUQLGjvg/wKOFqvvjocWlRtz9BJJUF9iYlH
         MNnXCpJ2c6aBNPYZstGwEQPQuVLj9UMTc8ubE65PvlJt1TLgPbtjNeQLpEUR8SVxpb94
         NTnQ9DA/YGHQUqZP76kjGBa6MeZtW6lvc3nugivEa3aMCLVMg3a+HzMczCbnIDbBAfI3
         3Trg==
X-Gm-Message-State: AOJu0Ywy3FIsueklPN8llxrRmqwDJMfXsAGVpyGcxwRdKEIm/J0hWvWB
	6OyAsWiDZIk12PvIyGUxXHn1kFhUhWsH+GMEKq4C8G3qrMoTKOilztudP+P0/kR88Do11G2Oe0C
	esVgV3V3Wnw==
X-Google-Smtp-Source: AGHT+IG/APxG40vsyR8wzXk/9BTnXHdtPEcYdJyuqEZ/dpF5B0obTu1t1oGEcSij+SL8jX47a4dIT2ydV66RGA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:988a:0:b0:5ff:780b:f3d8 with SMTP id
 p132-20020a81988a000000b005ff780bf3d8mr1949084ywg.8.1706895624933; Fri, 02
 Feb 2024 09:40:24 -0800 (PST)
Date: Fri,  2 Feb 2024 17:39:57 +0000
In-Reply-To: <20240202174001.3328528-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202174001.3328528-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202174001.3328528-13-edumazet@google.com>
Subject: [PATCH v2 net-next 12/16] ip6_vti: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair
and one unregister_netdevice_many() call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_vti.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index e550240c85e1c9f2fe2b835e903de28e1f08b3bc..cfe1b1ad4d85d303597784d5eeb3077383978d95 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -1174,24 +1174,22 @@ static int __net_init vti6_init_net(struct net *net)
 	return err;
 }
 
-static void __net_exit vti6_exit_batch_net(struct list_head *net_list)
+static void __net_exit vti6_exit_batch_rtnl(struct list_head *net_list,
+					    struct list_head *dev_to_kill)
 {
 	struct vti6_net *ip6n;
 	struct net *net;
-	LIST_HEAD(list);
 
-	rtnl_lock();
+	ASSERT_RTNL();
 	list_for_each_entry(net, net_list, exit_list) {
 		ip6n = net_generic(net, vti6_net_id);
-		vti6_destroy_tunnels(ip6n, &list);
+		vti6_destroy_tunnels(ip6n, dev_to_kill);
 	}
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
 }
 
 static struct pernet_operations vti6_net_ops = {
 	.init = vti6_init_net,
-	.exit_batch = vti6_exit_batch_net,
+	.exit_batch_rtnl = vti6_exit_batch_rtnl,
 	.id   = &vti6_net_id,
 	.size = sizeof(struct vti6_net),
 };
-- 
2.43.0.594.gd9cf4e227d-goog


