Return-Path: <netdev+bounces-69509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D7F84B828
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFF211F24B4B
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A2C132C20;
	Tue,  6 Feb 2024 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FUzMbEKU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D426E132C00
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230605; cv=none; b=gD6USA2jyemUwJCEtggSnHPdhzLxyyVasJYgVlJZa6PIBZ7cLoX6DB/NqMp/ymt/+nPvuwzONgPtachTQiPuCSXTPjDyDP1lO908MR34oWOcI5VH2OCePau6pbtVv8WE2iLjHEc+MVP+GB49HaD/hoRoKIRtWvscWj0pyAM9Um8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230605; c=relaxed/simple;
	bh=vPm6pRfPkizcwo9J6YgQaA07StlJsDdt+GI12hUd+jg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FtAfPyjSQ7LPgr6E6zMIcJMUp6p7o/yEYjpYdOEnddWVFqAREXdmgxJICbQGCwh/u2XwniwNxcKBKCV6ltZ1yeVdchsY6O3tu+D/wP+riTi2rbgj6On3uzNaO2jWXWYrWmkKKQfjHnPEmEB3IJHa7SM+ZQTqaw+bLCCniIA39Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FUzMbEKU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60484dba283so2116797b3.3
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707230602; x=1707835402; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Fia+sb8RWUNVXU3q1v1Z4jGJuuRjbjpwW2R8X5o5BY=;
        b=FUzMbEKUbYi53Vwy3G41c0IqYCuxzeNdnH/1jWEAI6eAu/yvTfOWHIgVpFqvaD+TFj
         sumOUdrjgi3TxWIhNUeysaTdIzaNC6YHZOJPTqpnKlztlRxxBO3qUbt0Lt97Dp0K1NpA
         ufLq+a7WNI5gJvsAvtt3qvtKVJ6AX8w9ie07ZpJu4bpfi7ycjdrKpHoM4EgcwJfBYfMW
         Nbj9QOp2gCOk/VrTFB4yCAdy3S1HO3JIsrophRc85SI8Gg0muL8jZ4bS3BHDGFuDsDuO
         i9XFCv/wn76lPG1QRU9pEPUeNA1XhzwIz2XBmfpV+yx4LnSkj/7LQoF2PhDXIymkwLkK
         M9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230602; x=1707835402;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Fia+sb8RWUNVXU3q1v1Z4jGJuuRjbjpwW2R8X5o5BY=;
        b=lz8h7foqqxYgSpIFMr8lLXlYgslicFQPPG375PkzsvhMA0+LhI/SUAop+vDYPc75j2
         /BGhJKhJSqaEFCqJRDWsyMWXuRrcwghRDK1R9YX0FQeAUjpQUGYLOaMtD1YNoicrww9h
         MuQ+lMxOdlR+/N+/dnFl61aYc1Kw0sevkBTpzRVCwtCJ4EBRhFGFAn+fBt6en409mud1
         QruqmudElnrxP0X1wPCKex5cFd80X3qSjA8efeZ4OQmcHkb5G6LUTx0FolsavJd6u9uH
         p/wUWWfgiBagoiuhl0uE0zJzIx0kVUl4PGyJ2PuJQmkMGKToZwEHM9rGliF0p3KiMBG+
         ektg==
X-Gm-Message-State: AOJu0YzlCu0mLiEk110N4eW6swa9GCRCk1vZY5djL9PxyBnySvj8mEF7
	jHL7pLAgC/SD8Jwchnzx4zmh5zKl+FuG08WI/UjtzpHq5Dmjd2JxmB6RbzvTdaTQ3n86Nj+ZEck
	rpBLAUhsulg==
X-Google-Smtp-Source: AGHT+IEeZFtChH5yRTdjjwFczR8LWxl07znuNmpQ2P3fJOa5rZCwqcGc6C9p7AMW//aCb8r6pJwmhp9rt37/Cg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1b07:b0:dbe:d0a9:2be8 with SMTP
 id eh7-20020a0569021b0700b00dbed0a92be8mr55430ybb.0.1707230602749; Tue, 06
 Feb 2024 06:43:22 -0800 (PST)
Date: Tue,  6 Feb 2024 14:42:59 +0000
In-Reply-To: <20240206144313.2050392-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206144313.2050392-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206144313.2050392-4-edumazet@google.com>
Subject: [PATCH v4 net-next 02/15] nexthop: convert nexthop_net_exit_batch to
 exit_batch_rtnl method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held.

This saves one rtnl_lock()/rtnl_unlock() pair.

We also need to create nexthop_net_exit()
to make sure net->nexthop.devhash is not freed too soon,
otherwise we will not be able to unregister netdev
from exit_batch_rtnl() methods.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/nexthop.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index bbff68b5b5d4a1d835c9785fbe84f4cab32a1db0..7270a8631406c508eebf85c42eb29a5268d7d7cf 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3737,16 +3737,20 @@ void nexthop_res_grp_activity_update(struct net *net, u32 id, u16 num_buckets,
 }
 EXPORT_SYMBOL(nexthop_res_grp_activity_update);
 
-static void __net_exit nexthop_net_exit_batch(struct list_head *net_list)
+static void __net_exit nexthop_net_exit_batch_rtnl(struct list_head *net_list,
+						   struct list_head *dev_to_kill)
 {
 	struct net *net;
 
-	rtnl_lock();
-	list_for_each_entry(net, net_list, exit_list) {
+	ASSERT_RTNL();
+	list_for_each_entry(net, net_list, exit_list)
 		flush_all_nexthops(net);
-		kfree(net->nexthop.devhash);
-	}
-	rtnl_unlock();
+}
+
+static void __net_exit nexthop_net_exit(struct net *net)
+{
+	kfree(net->nexthop.devhash);
+	net->nexthop.devhash = NULL;
 }
 
 static int __net_init nexthop_net_init(struct net *net)
@@ -3764,7 +3768,8 @@ static int __net_init nexthop_net_init(struct net *net)
 
 static struct pernet_operations nexthop_net_ops = {
 	.init = nexthop_net_init,
-	.exit_batch = nexthop_net_exit_batch,
+	.exit = nexthop_net_exit,
+	.exit_batch_rtnl = nexthop_net_exit_batch_rtnl,
 };
 
 static int __init nexthop_init(void)
-- 
2.43.0.594.gd9cf4e227d-goog


