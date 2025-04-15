Return-Path: <netdev+bounces-182650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F85A897D1
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575AE3B63B4
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCF227FD66;
	Tue, 15 Apr 2025 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxXfPiGo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C08B205AA3
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709072; cv=none; b=Th/92MctXx6DmIYV+JT0FIAH1jEPcAA+wG6cUdM+sXkpL2xeBs8FL7zzsLbLmdnAiGXthMRddhogb5ILdkQ+iz4TlL3xURGiQ7mkf5U/ehvpFNJcaHLfxIIiUTd0EcVfBZtb/4uSNgG9oICVTitdkwc7hn69QUDVs95mSXNiBCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709072; c=relaxed/simple;
	bh=NxjoYHHmnDhpzSXn6aJmKSKNF2wigwOV+J/pVNiA4M4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NZ52CWXNw/vARQUXbgpQEOhDE4pfLMJFYwPY+vt68Pr5kmVLaAflO7aSCrUKx7QB0iJnUx9VAionE1w6fA+bzMpw/OHp5b2XiUtQafBzPa/0CkD0xmKJtk1mVLgwcDmGlHIYUN8OvMpWSrEM3oGfgQAjMq8bOKlS/UaPM2vwi98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxXfPiGo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22423adf751so48257435ad.2
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 02:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744709070; x=1745313870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q8VOjAcay7IU5rMXJPK5JEuQkg1/PraEcObQ6HCw9QU=;
        b=HxXfPiGoF0wOUtthWMEReuzzTxGq6gUN+V5jtyIm26JATZMrIXcBI0kGZ516XN5q7m
         vaC1TnbeNZFLy6CJ+Un2rHhv6D3K/Mi+RrgCItjoVyHw90cGRKdulW1T5ZNkg3tN0LG0
         Gx0GEAsQwwgD33M1JznbEcxNxMi8dDVnr9zoxN3220CC3tt3NRlR2tgsOnKG1dsGpKcw
         z2uNgz55e9Q0JQujX7gny3NvLUdiA0pSq9KjwumssZmNFTfU3Iy7rNmuO+4ooBHxnU71
         itaigo9HAHe+H+DkDoB0I+Ol3DQetalWHAQq664M4hCi+FMKE21c5XDgPSqYD+s4NTig
         AMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744709070; x=1745313870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8VOjAcay7IU5rMXJPK5JEuQkg1/PraEcObQ6HCw9QU=;
        b=KnpCr5sJh6VBOhickZc9sZPJJYy4W89NegOBMNebIk8IpQF++QWy+hDx9q2tOQ88AN
         H67vhOUe+p0GBpDTPaPXI9fHxQvTrEhtjwp866BWUkkOZG8NCGAcs61nMs3GZv9E1IWB
         DnsUP6U05PsLUaU+lWW0JBHycSJpTPo4/a5WiP5RzEpLVVPtI8eldtRevN2bRuFE4Tdc
         A6x8as59nzvg8kwyMEm2Izv9Qpa+ZZCs6Ry7UNW81t0UH414p8f+SPHthnzMCueqwd9u
         TiNzrja5S8g/E02b+D6zuyFDvP9WOYiGRyBef6Z0MPvnWeGqMqYTPjy4UhY9Yhn6xMcE
         Jopw==
X-Forwarded-Encrypted: i=1; AJvYcCUA+xMSj+W6tz5Fxi4v+AX0W9mJFxwDEG9CuAwOxmtTmjD1Io0ZQLXlaqiADgXES4uprs0NNHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YybVJ7HhB0MeLXm0xyxQ3lvIZX1/2gK2DREV1gMOfkpiQDZblpC
	Sfo5mjL44uNPQY5Jh77yeusRP5R0g1trd+Qx5MWzLA2oR2jNGdSS
X-Gm-Gg: ASbGncsbPkqfetcdWuwaemkcinDVXEIegJe/Q/NPPdmOoFtx9DbTqI/D62giwnzrA0R
	sFjKSvQDiacNfkZYsHdqQijhXlmFX2hCHmz4pik7rEwXTKo6WW8s5Ox/MLgAOP5cwT7idoCoS7g
	t2YjrTf0hjyIMhVvfpim+KNECeCKoISUC7WHtR8t6emxkkJcPo/n3A/8M6ccNPGxynbEOdUxvcZ
	xDoW3dk0IAzB/j6hIkquHsxLkyPUsC4Cg4aJu+2+A4KLxOAaN3Vl0WDtULrYIz8gCSiJJG8UYn3
	R3VY74n9mlkDqKgjGCErp8PAsf4EsQ==
X-Google-Smtp-Source: AGHT+IFbtJTmezhMCV9cgDrk/3dKTx5jU7Bb7T5ayQ6o2kbZ7gDVkxL1afLSuYEkU6/HyDs5CE8pKw==
X-Received: by 2002:a17:902:db0e:b0:223:66bb:8995 with SMTP id d9443c01a7336-22bea4ab827mr172517225ad.20.1744709070006;
        Tue, 15 Apr 2025 02:24:30 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7caf884sm112650515ad.166.2025.04.15.02.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 02:24:29 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	asml.silence@gmail.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	skhawaja@google.com,
	simona.vetter@ffwll.ch,
	kaiyuanz@google.com,
	netdev@vger.kernel.org
Cc: ap420073@gmail.com
Subject: [PATCH net] net: devmem: fix kernel panic when socket close after module unload
Date: Tue, 15 Apr 2025 09:24:17 +0000
Message-Id: <20250415092417.1437488-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel panic occurs when a devmem TCP socket is closed after NIC module
is unloaded.

This is Devmem TCP unregistration scenarios. number is an order.
(a)socket close    (b)pp destroy    (c)uninstall    result
1                  2                3               OK
1                  3                2               (d)Impossible
2		   1                3               OK
3                  1                2               (e)Kernel panic
2                  3                1               (d)Impossible
3                  2                1               (d)Impossible

(a) netdev_nl_sock_priv_destroy() is called when devmem TCP socket is
    closed.
(b) page_pool_destroy() is called when the interface is down.
(c) mp_ops->uninstall() is called when an interface is unregistered.
(d) There is no scenario in mp_ops->uninstall() is called before
    page_pool_destroy().
    Because unregister_netdevice_many_notify() closes interfaces first
    and then calls mp_ops->uninstall().
(e) netdev_nl_sock_priv_destroy() accesses struct net_device.
    But if the interface module has already been removed, net_device
    pointer is invalid, so it causes kernel panic.

In summary, there are only 3 possible scenarios.
 A. sk close -> pp destroy -> uninstall.
 B. pp destroy -> sk close -> uninstall.
 C. pp destroy -> uninstall -> sk close.

Case C is a kernel panic scenario.

In order to fix this problem, it makes netdev_nl_sock_priv_destroy() do
nothing if a module is already removed.
The mp_ops->uninstall() handles these instead.

The netdev_nl_sock_priv_destroy() iterates binding->list and releases
them all with net_devmem_unbind_dmabuf().
The net_devmem_unbind_dmabuf() has the below steps.
1. Delete binding from a list.
2. Call _net_mp_close_rxq() for all rxq's bound to a binding.
3. Call net_devmem_dmabuf_binding_put() to release resources.

The mp_ops->uninstall() doesn't need to call _net_mp_close_rxq() because
resources are already released properly when an interface is being down.

From now on netdev_nl_sock_priv_destroy() will do nothing if a module
has been removed because all bindings are removed from a list by
mp_ops->uninstall().

netdev_nl_sock_priv_destroy() internally sets mp_ops to NULL.
So mp_ops->uninstall has not been called if devmem TCP socket was
already closed.

Tests:
Scenario A:
    ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
	-v 7 -t 1 -q 1 &
    pid=$!
    sleep 10
    ip link set $interface down
    kill $pid
    modprobe -rv $module

Scenario B:
    ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
	-v 7 -t 1 -q 1 &
    pid=$!
    sleep 10
    ip link set $interface down
    kill $pid
    modprobe -rv $module

Scenario C:
    ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
	-v 7 -t 1 -q 1 &
    pid=$!
    sleep 10
    modprobe -rv $module
    sleep 5
    kill $pid

Splat looks like:
Oops: general protection fault, probably for non-canonical address 0xdffffc001fffa9f7: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
KASAN: probably user-memory-access in range [0x00000000fffd4fb8-0x00000000fffd4fbf]
CPU: 0 UID: 0 PID: 2041 Comm: ncdevmem Tainted: G    B   W           6.15.0-rc1+ #2 PREEMPT(undef)  0947ec89efa0fd68838b78e36aa1617e97ff5d7f
Tainted: [B]=BAD_PAGE, [W]=WARN
RIP: 0010:__mutex_lock (./include/linux/sched.h:2244 kernel/locking/mutex.c:400 kernel/locking/mutex.c:443 kernel/locking/mutex.c:605 kernel/locking/mutex.c:746)
Code: ea 03 80 3c 02 00 0f 85 4f 13 00 00 49 8b 1e 48 83 e3 f8 74 6a 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 34 48 89 fa 48 c1 ea 03 <0f> b6 f
RSP: 0018:ffff88826f7ef730 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: 00000000fffd4f88 RCX: ffffffffaa9bc811
RDX: 000000001fffa9f7 RSI: 0000000000000008 RDI: 00000000fffd4fbc
RBP: ffff88826f7ef8b0 R08: 0000000000000000 R09: ffffed103e6aa1a4
R10: 0000000000000007 R11: ffff88826f7ef442 R12: fffffbfff669f65e
R13: ffff88812a830040 R14: ffff8881f3550d20 R15: 00000000fffd4f88
FS:  0000000000000000(0000) GS:ffff888866c05000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563bed0cb288 CR3: 00000001a7c98000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
<TASK>
 ...
 netdev_nl_sock_priv_destroy (net/core/netdev-genl.c:953 (discriminator 3))
 genl_release (net/netlink/genetlink.c:653 net/netlink/genetlink.c:694 net/netlink/genetlink.c:705)
 ...
 netlink_release (net/netlink/af_netlink.c:737)
 ...
 __sock_release (net/socket.c:647)
 sock_close (net/socket.c:1393)

Fixes: 170aafe35cb9 ("netdev: support binding dma-buf to netdevice")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

In order to test this patch, driver side implementation of devmem TCP[1]
is needed to be applied.

[1] https://lore.kernel.org/netdev/20250415052458.1260575-1-ap420073@gmail.com/T/#u

 net/core/devmem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 6e27a47d0493..8948796b0af5 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -379,6 +379,11 @@ static void mp_dmabuf_devmem_uninstall(void *mp_priv,
 	xa_for_each(&binding->bound_rxqs, xa_idx, bound_rxq) {
 		if (bound_rxq == rxq) {
 			xa_erase(&binding->bound_rxqs, xa_idx);
+
+			if (xa_empty(&binding->bound_rxqs)) {
+				list_del(&binding->list);
+				net_devmem_dmabuf_binding_put(binding);
+			}
 			break;
 		}
 	}
-- 
2.34.1


