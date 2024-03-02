Return-Path: <netdev+bounces-76817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DBE86EFFF
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 11:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04452833FB
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 10:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A1414284;
	Sat,  2 Mar 2024 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxBVSXwW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAE013FF1
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709374068; cv=none; b=fMxye99EyIfL3YVrOwCCjJg5RlIx2kK264iGjI8PrurG5lo/dDTzVYnxLanH+uRMzrWt6OjEjTjIYzSumm6h4A6vfsgU4u6E/slGOjtmNXYa/ytqSGqSGBqQVUk5zfGrIxIB2kOG+zPDMyRr6quhScuraPz/1rB4k6UDm8V6ecw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709374068; c=relaxed/simple;
	bh=FTYx5qez++KkUv5yDK2jAqM9mqDamcYB51Z6/Y1FNQY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Mry7NglcE3RrCg/B0Ajn0WxmLfJlD9dP3gh/5H2r5bTFPKJnXDUe+/tzEB166vz6q5E7TiFb96Wbrv+oWCgbQbHBmMInhmvDFNSejVdBz5JKSTinFE0qzBfhodriSC0MVBxdOMaTd/9+8hIrJEMc8I5E7/wfA0d6kkS+T6+WMAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oxBVSXwW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso4497878276.0
        for <netdev@vger.kernel.org>; Sat, 02 Mar 2024 02:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709374066; x=1709978866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pHDDdxJ+oSK0bRwd/e4P7FdFaAyR5yWe3wl+pUciMSs=;
        b=oxBVSXwWRbNEKAKPUjtp8hOUTYTVQl4y6Sicy1lv0jsfKgP56bcuqNsDxU7XXuQOiH
         PsMinvZ7wyjxhkY92wZ3oE2RaXTeqnYl53+vsQmgxgqVOGhjF7aahrPABPjnnIeQ+p66
         21TOyIzxlBM3l8pWn4YUsQXQP3AyhhqXWZgE/sHIUurGx/yC2OvHh3jmCA5KIt1cdzyR
         uihIYsYM1oXvTisWvc3+VikCNiJxA73iVoj8Lj6TBlYMdfiGkwhomzR3X2xbaGfmfelk
         yX1EzYwCNS2mpFaG4YntwQV8luOIpubDP6s/8E/5Eko7trhQs4A/b4zqrTUFePfxk9i8
         N/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709374066; x=1709978866;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pHDDdxJ+oSK0bRwd/e4P7FdFaAyR5yWe3wl+pUciMSs=;
        b=v3KIYXpGki6LT/W7NLrBe+HB5mGaqWvyIOnFqtpzCotn735XkwFJB9MBoTNe1CyjxB
         fj1MPbAxFHIdmWzSjjFzICMbg0gapCRn40RGTkMdl1Ob4quxuladcV3tZVqemFseDLU+
         X1l6V73xvCH35veLvfIrCgKPNWfLQDfE3RFK5TO/mjsIbh5LKND+kQ7OjxHN9BAP9iHU
         r5fh8kFtjD0uv2XY6wJnIpCGTEdtuPhnno/QHH7HmbWs3AJygHJO6P+VXFv8Ob3QL7UW
         E/8Wk0zEVb6CPDukUL7BHqdMQcCLhHTxokdFlHmpl1/WWoEhKYq0YiMgy8RlJVUi6Z6z
         h89Q==
X-Gm-Message-State: AOJu0YwMxJfWdcTRb+/nbgl34kRNJiuN4RqxxglFuISW0y/XapBFHqEv
	qtZnNiq1bSnDrszCDfMCGYM4aDMmDzjwdEScUgtHjUmlewj2XiK02PPoUvl7c3weWnschszjRvK
	xd4KRwqWK4A==
X-Google-Smtp-Source: AGHT+IFGUjVt8lOwgsqY3g9t07YH8rJUMC7tH7zWb8768Lk6+BUsu1BcmjeAvpT5aEw8Yp4EW97z6Jfz1BGmcw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:fce:b0:609:e1f:5a42 with SMTP id
 dg14-20020a05690c0fce00b006090e1f5a42mr816245ywb.2.1709374066155; Sat, 02 Mar
 2024 02:07:46 -0800 (PST)
Date: Sat,  2 Mar 2024 10:07:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240302100744.3868021-1-edumazet@google.com>
Subject: [PATCH net-next] net/smc: reduce rtnl pressure in smc_pnet_create_pnetids_list()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

Many syzbot reports show extreme rtnl pressure, and many of them hint
that smc acquires rtnl in netns creation for no good reason [1]

This patch returns early from smc_pnet_net_init()
if there is no netdevice yet.

I am not even sure why smc_pnet_create_pnetids_list() even exists,
because smc_pnet_netdev_event() is also calling
smc_pnet_add_base_pnetid() when handling NETDEV_UP event.

[1] extract of typical syzbot reports

2 locks held by syz-executor.3/12252:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.4/12253:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.1/12257:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.2/12261:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.0/12265:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.3/12268:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.4/12271:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.1/12274:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.2/12280:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Jan Karcher <jaka@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>
Cc: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_pnet.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 9f2c58c5a86b7d78cdd07a996e6f7c3766d6886c..2adb92b8c4699c592eddeefb4222f70713d13895 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -806,6 +806,16 @@ static void smc_pnet_create_pnetids_list(struct net *net)
 	u8 ndev_pnetid[SMC_MAX_PNETID_LEN];
 	struct net_device *dev;
 
+	/* Newly created netns do not have devices.
+	 * Do not even acquire rtnl.
+	 */
+	if (list_empty(&net->dev_base_head))
+		return;
+
+	/* Note: This might not be needed, because smc_pnet_netdev_event()
+	 * is also calling smc_pnet_add_base_pnetid() when handling
+	 * NETDEV_UP event.
+	 */
 	rtnl_lock();
 	for_each_netdev(net, dev)
 		smc_pnet_add_base_pnetid(net, dev, ndev_pnetid);
-- 
2.44.0.278.ge034bb2e1d-goog


