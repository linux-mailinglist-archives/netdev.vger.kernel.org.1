Return-Path: <netdev+bounces-69130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB419849B10
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59269B24FD0
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F534A99B;
	Mon,  5 Feb 2024 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mnJKQxfL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C898F48CDC
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137300; cv=none; b=fSouN8NfXTHuCRxS9qgYqmUK+HCA4sI2qAIj5/ej8OCttVsXpcAu2BceirTvwt+sIHZy4XgeaVPaUQN+LCnreEKBUB5E44qFW4Vh01uSYiiH3be1bRRcwYkanQFcuRjAEF+Jd4eQW3jcOmCVxCEnwdrpITWq6TX2GWkAC9lg/Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137300; c=relaxed/simple;
	bh=dCEVgCNsMJ2NjQ+g5ztXuI1Y/3IDivH/bTr3p3ZJ0Cw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SR7FYdWprrtU54Mt2/2GU0rHmgJ25CMv3+828DBBf2Shu+YTZJeVOK1Bory278GAfd5EYHg9NcpUvOUnv35tokRC69vnAJbPsxIY7ZFr1yRMa4h3v+ing/XBaxsq3kFVHX0hzVlr7ZKxmjnGKxoSXfFc2roIHDdMKrWSoIvk6II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mnJKQxfL; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7840f8118d5so661708085a.1
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 04:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707137297; x=1707742097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=up2PGM8Lh/PoX2yMsKcFPD+yGGD2E1QRR7UMzVqvJpM=;
        b=mnJKQxfLunviz61GjzASWNNP0HQMZSJjvv/Z+9BNlOm4U9Z0R+CgkBkU5pEPlQdGsJ
         FXeu/qsB3e40Ke1E89Z7NKx6zBCmncHNviEjLVtFCBnSdN+/2aYFfaSf1+rLOdqzXB+V
         NqFjOKY2l+2Gry672t1qwfSTDf5bPz+QeBFWpWAMbiUtjw0HEJlHhcJG8JUY+eX8dupm
         RFfxGnNlVkOu8SiLLZeGpdJOZPpa2PY8vITC65Jd3dYzxqPEVadi9Pnqt2w1Z+rLFxpC
         HrHojbtKfieRux0SrGO6TMRt08Ymui7rcVRpZDl8fiI/zCpG4uAOZwk/R3knOiOAfEHl
         Z90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137297; x=1707742097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=up2PGM8Lh/PoX2yMsKcFPD+yGGD2E1QRR7UMzVqvJpM=;
        b=ift/l5z6HaWlr1MvNf0jdXxIoTARjzLOk/KlHUuWeuKiMSbIAZ+SRDFRhjS56ce2J8
         O8FW/ekQGCPYx8rKuVh8D4culGVpdMACmQ3rYdtdSDXghinUHAolZA0l6Hd85ZXcR5Gg
         Z8uGtkjzgXJwlJ4OaeVOZGV6Sh3k7KU6EYpJ/vMLf+XZvaDrdh2ALGS0f9O+Z3I6O00I
         Wl+bkj8Luae4kfdp5E1XaoSgc70S6KbJgWUiOIkDyp8K1qz7cC4CfkZxaHi68KEfttmt
         KK7aX0nb9UjzbUwVl7pdhMh65ccyHeKFKcd4c93i9JzE8ahKbZL/qwKgqJlPVLfQ43Tb
         F7dw==
X-Gm-Message-State: AOJu0YyEGF4RN4H59dFdm8K9I8j/9ifdsVN4Vs6ljSty0Tjp7meS7Yyi
	ARRsxf2vourUomE+hWPe9dX4lBZSKM9P19ho9o6E/zaUWCX0ANA9iN+iUgkkM82IST3gruyou9J
	eMjxms6ImtA==
X-Google-Smtp-Source: AGHT+IFDDsDyRz79YaVpnmYc4QNRHqnfekOSsoVjkSWuSUJ7lMu6EBGNDKRTxurK0giDr4CFPXccmnb3y0nX4w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:46a1:b0:785:62ef:8458 with SMTP
 id bq33-20020a05620a46a100b0078562ef8458mr68612qkb.5.1707137297724; Mon, 05
 Feb 2024 04:48:17 -0800 (PST)
Date: Mon,  5 Feb 2024 12:47:49 +0000
In-Reply-To: <20240205124752.811108-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205124752.811108-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205124752.811108-13-edumazet@google.com>
Subject: [PATCH v3 net-next 12/15] sit: use exit_batch_rtnl() method
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
 net/ipv6/sit.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index cc24cefdb85c0944c03c019b1c4214302d18e2c8..61b2b71fa8bedea6d185348ff781356652434b33 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1875,22 +1875,19 @@ static int __net_init sit_init_net(struct net *net)
 	return err;
 }
 
-static void __net_exit sit_exit_batch_net(struct list_head *net_list)
+static void __net_exit sit_exit_batch_rtnl(struct list_head *net_list,
+					   struct list_head *dev_to_kill)
 {
-	LIST_HEAD(list);
 	struct net *net;
 
-	rtnl_lock();
+	ASSERT_RTNL();
 	list_for_each_entry(net, net_list, exit_list)
-		sit_destroy_tunnels(net, &list);
-
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+		sit_destroy_tunnels(net, dev_to_kill);
 }
 
 static struct pernet_operations sit_net_ops = {
 	.init = sit_init_net,
-	.exit_batch = sit_exit_batch_net,
+	.exit_batch_rtnl = sit_exit_batch_rtnl,
 	.id   = &sit_net_id,
 	.size = sizeof(struct sit_net),
 };
-- 
2.43.0.594.gd9cf4e227d-goog


