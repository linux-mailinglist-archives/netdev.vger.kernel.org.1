Return-Path: <netdev+bounces-157934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3516A0FDDB
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 02:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8096B3A6586
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 01:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1253DBB6;
	Tue, 14 Jan 2025 01:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2SW05CYz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A323597C
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 01:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736817239; cv=none; b=e514IyMAPPfagtzHqWW3PV1Iqd8e9uPJjqahweNOK5ERSYLQ9cWSA+S5fqtbPkQKNjnQABktUWS09GItfuQL0kHwDUVU/Mzh/o9o/xt3Htbu43aFKXbK5PWdX7I19vNqeAx654GHn54t+gpD77Hr+4oXaZgMKiG33//J1kz1/Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736817239; c=relaxed/simple;
	bh=wKP7+nTqhr4z4cIR7G0PFrg8nmUTf9lSv9CPtPGuyNk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WLt4zgqx7V5KvyEwlsNqzar4fnX6uIh7YgJBguASiLlVfY4imiaDPKAFWwSTUmc+xv7RRZzaE+jrI7PAAs1Mz3QbBfyJ7BD5oNJ/twvCpbqsDphc9GRN/2yfDKUkPw1ZJ728lzKpn3EKS9SNx46WH4G6O7/roUO6Iu5a/X/6r2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2SW05CYz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21661949f23so144332525ad.3
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 17:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736817238; x=1737422038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XAzDAxtu20dr8XYgb047LzpHrNmp4KBAkv49IhDbPG4=;
        b=2SW05CYzxWxlLFsGFeHfhH1x5hvQBwVSQq3G1xJIaig1AXdQ5d+aU2ZmyRFhZo2uYv
         P5nvORsDncXKoMwrjdTNvnqrXtkC1R3TvGSNfrPJ1kRdy7SVbVs4OMThnN489yM1gcYG
         eR1AYLWplqpfHohmHhIAILRGwFF0xdF8fTplHkAdC7llnZRK7Gs9SrxY5gHBP4XWFzCk
         b8jWIAQRIZq+zwb8eDEgX4NDl2Xxd3cOTabC2p9f/NcUZD4hBk/uCI841EonKKMLJb+P
         oWaIQbuNr0k8RdwFW4RV5auIr3zpHwA24oYq4sFPz+sPl3kPX50fcHHxzApTV8EaC5TY
         uy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736817238; x=1737422038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XAzDAxtu20dr8XYgb047LzpHrNmp4KBAkv49IhDbPG4=;
        b=oACYaI/+oX2iwYIzaElY8JUQ8CJBtBYBRbeBfc8PTr2l66rVe0rpW3AYl8kcnsOilC
         PahygxfkaegqZDv+lM0PBMIvGEtktn/Fg5Nt7T2O6imdcc9KU3mxIhqML9ejZxEowKPc
         e/68jlZh27hRoqvjSZ50pSj+N4Ea6V8HQHblaj8z10OWDLtnMAnTNrrKjO/5qD3c90Bf
         UwqX8riwli6H/QtJ+I7uZuoAUqdSeuXdjWYeXJXN0hhr10VN4tv0PAYzBc6h7OL+O8cQ
         2yXlh7RLPtvRIUqT7eQgTvhyRB6In/enLrcN+3iBRk9Ss0RvZoRt7KRYTdnvYytzGtxe
         4n7w==
X-Forwarded-Encrypted: i=1; AJvYcCVyAJ5y+maQhCkSijNIMrDNCIWqO4qokxrOWQB2jCMIa/B214sTmnaqJxe0F8l5xHkg6rDUPxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHPhendrdneWtNRb9f7XoaNEiLzHta/7Ocn1NwlKwt/X85/aCH
	nr2f5oLGaLRr/P/PEZnTv1k25VK2uV0ROzKgm1tF+g8hN4wMm5YKON8o4s0B4vBNGK7EJVNaTlq
	2qhvpqDTvmlTy9g==
X-Google-Smtp-Source: AGHT+IEYE4rj7JPPK704b5FMveW5K/HOICJPeWFgC3g/nVjUE2Skl72kfSUMF9Y2bxDQAPcchvh6turKB9LnkyI=
X-Received: from pjbpq5.prod.google.com ([2002:a17:90b:3d85:b0:2ef:8ef8:2701])
 (user=jsperbeck job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fc8f:b0:216:48dd:d15c with SMTP id d9443c01a7336-21a83f65a79mr342092635ad.27.1736817237793;
 Mon, 13 Jan 2025 17:13:57 -0800 (PST)
Date: Mon, 13 Jan 2025 17:13:54 -0800
In-Reply-To: <20250113-spotted-independent-kittiwake-309cab@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250113-spotted-independent-kittiwake-309cab@leitao>
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <20250114011354.2096812-1-jsperbeck@google.com>
Subject: [PATCH net v3] net: netpoll: ensure skb_pool list is always initialized
From: John Sperbeck <jsperbeck@google.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, kuba@kernel.org, jsperbeck@google.com
Content-Type: text/plain; charset="UTF-8"

When __netpoll_setup() is called directly, instead of through
netpoll_setup(), the np->skb_pool list head isn't initialized.
If skb_pool_flush() is later called, then we hit a NULL pointer
in skb_queue_purge_reason().  This can be seen with this repro,
when CONFIG_NETCONSOLE is enabled as a module:

    ip tuntap add mode tap tap0
    ip link add name br0 type bridge
    ip link set dev tap0 master br0
    modprobe netconsole netconsole=4444@10.0.0.1/br0,9353@10.0.0.2/
    rmmod netconsole

The backtrace is:

    BUG: kernel NULL pointer dereference, address: 0000000000000008
    #PF: supervisor write access in kernel mode
    #PF: error_code(0x0002) - not-present page
    ... ... ...
    Call Trace:
     <TASK>
     __netpoll_free+0xa5/0xf0
     br_netpoll_cleanup+0x43/0x50 [bridge]
     do_netpoll_cleanup+0x43/0xc0
     netconsole_netdev_event+0x1e3/0x300 [netconsole]
     unregister_netdevice_notifier+0xd9/0x150
     cleanup_module+0x45/0x920 [netconsole]
     __se_sys_delete_module+0x205/0x290
     do_syscall_64+0x70/0x150
     entry_SYSCALL_64_after_hwframe+0x76/0x7e

Move the skb_pool list setup and initial skb fill into __netpoll_setup().

Fixes: 221a9c1df790 ("net: netpoll: Individualize the skb pool")
Signed-off-by: John Sperbeck <jsperbeck@google.com>
---

Updated mail message subject to target the 'net' tree.

 net/core/netpoll.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 2e459b9d88eb..96a6ed37d4cc 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -627,6 +627,8 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 	const struct net_device_ops *ops;
 	int err;
 
+	skb_queue_head_init(&np->skb_pool);
+
 	if (ndev->priv_flags & IFF_DISABLE_NETPOLL) {
 		np_err(np, "%s doesn't support polling, aborting\n",
 		       ndev->name);
@@ -662,6 +664,9 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
 	npinfo->netpoll = np;
 
+	/* fill up the skb queue */
+	refill_skbs(np);
+
 	/* last thing to do is link it to the net device structure */
 	rcu_assign_pointer(ndev->npinfo, npinfo);
 
@@ -681,8 +686,6 @@ int netpoll_setup(struct netpoll *np)
 	struct in_device *in_dev;
 	int err;
 
-	skb_queue_head_init(&np->skb_pool);
-
 	rtnl_lock();
 	if (np->dev_name[0]) {
 		struct net *net = current->nsproxy->net_ns;
@@ -782,9 +785,6 @@ int netpoll_setup(struct netpoll *np)
 		}
 	}
 
-	/* fill up the skb queue */
-	refill_skbs(np);
-
 	err = __netpoll_setup(np, ndev);
 	if (err)
 		goto flush;
-- 
2.47.1.688.g23fc6f90ad-goog


