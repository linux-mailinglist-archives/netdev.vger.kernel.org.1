Return-Path: <netdev+bounces-69510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C290A84B829
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386D71F23A74
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B96132C37;
	Tue,  6 Feb 2024 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yggKnr67"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26BD131E44
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230606; cv=none; b=FKEVQsmLPCYYQ7JW3K15rRUj0LTcsp2A0RiOVaeMt+W3dJUJSp61gsiJyR+VfLtVSBYRI5NJsrHmNjk9ANKEYLJulS4ncMbcGPBecYnycDwbrc67+VwmnKASU2+jV3BNadzz39A3TqL1tTs+gX0iSZzbYNzlZPt7xgdUoYnwzhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230606; c=relaxed/simple;
	bh=ayxOrI72K6/MWZME44DpehPtpq+P0Zcwx9RlGIOMnUw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e+VFPRft061q5uJmFAYiWfXq+1atQiaITP/E8mR7q3vaxD8nzTMqSgb/Atpy3RtQ9PEyeBorhpvoceF5TD24eA3mYDVAR+wrLMWG+hfdeiAZYzX3Qv/PxrcXT7coCgMatu8m7O8utYhoKpA0ckYK0fFlmYf/SjoKhAlEbq2wabE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yggKnr67; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso1464258276.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707230604; x=1707835404; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BFeVsJGz6LUPJVJRWx6DWARi15RK/k8eAVyBBsCykA=;
        b=yggKnr672+BSpIgDq4U4jbXNvUAqBxb5ILy4TKAC221bxqucm40LjC4msLtXWhqjM0
         5Bsl7ZeRjoKZL0adN8RpNT2p06unaTl8Vx3JXljnpZ/bHoogSLpeeFEC0BjA7B07WYcY
         8kRmXXkRHIg+LZ6ONndKVbkgOBxH4xGIZVaDBxRBUZ1M9WlYDvv0JtJ6KKpHy6aJ4XaR
         +lRL8vigTuTj1FzQTGYMd+MuQaRFi3tZqwR8vyJjhoIK4uMUFEVrj8HPsehLsNTq4mub
         PLXyptNQ/EtILSkZgKGegrK2KtzCTmAvqsCF6Cl+jWVXKqYbfgiOoZHxfIPOwefGGxV3
         zzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230604; x=1707835404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BFeVsJGz6LUPJVJRWx6DWARi15RK/k8eAVyBBsCykA=;
        b=ZJRLbsTteliGeivIwmIsltrSwG2F6AQH4OhFt/6osac8heCIGjZ6YvLsRjdjyQlA9q
         LLSdtgiV/oQPbSD9vS8v+7IwsdFwWX+Q8+y3/VDh9aXYA7uk3PVOQfHGoosPJYWDkXKL
         GTGxlX9dQ3Dody9TSNY0XILPAjBvXdHLepfFIpe2dD2fHxQ5Uta4+hGSChBXQFrXGNn8
         kudpBupMzOy7ACOkDsIXGrlEPatqQKrpbxay898Fhi7PToNb1DA2wWRix24eQRI4RR8x
         BMDcl0CYcrOYLrEbKGYKIK9xI71oI2SZ/N3Y7R1YU1XxH0J7qPtPuoG8TGmgVWhbjL7p
         8TbA==
X-Gm-Message-State: AOJu0YyDmpZUOEu71Dc6jQKxhEpoJkdncckpFgnp4WJG4mNeMnYcoOhg
	NtPjLP5l7hBtSvuNNhQX14na2WePjlhnU7XB6fMiliu8Y0nro80o+TEisX9/BgzPkKWPtyJIIM7
	RBQu41gD8eQ==
X-Google-Smtp-Source: AGHT+IGCR81BKjUfDWonQXz75soYvq8YP4kahHcJGM3IpE8Qc5z4HJC6C+S4cmbSrRJ1IR7KHuq/sloq+zxyJg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2512:b0:dc6:f90f:e37f with SMTP
 id dt18-20020a056902251200b00dc6f90fe37fmr54813ybb.13.1707230604098; Tue, 06
 Feb 2024 06:43:24 -0800 (PST)
Date: Tue,  6 Feb 2024 14:43:00 +0000
In-Reply-To: <20240206144313.2050392-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206144313.2050392-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206144313.2050392-5-edumazet@google.com>
Subject: [PATCH v4 net-next 03/15] bareudp: use exit_batch_rtnl() method
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
2.43.0.594.gd9cf4e227d-goog


