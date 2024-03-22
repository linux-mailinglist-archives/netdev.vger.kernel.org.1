Return-Path: <netdev+bounces-81250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 508ED886BF9
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 13:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741A91C225AD
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAB13FBAA;
	Fri, 22 Mar 2024 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S12cgfqu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BD93FB04
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110253; cv=none; b=qxNWdEcqztET2P6yhdfzlPsNj4kUefmo3MfanF6/roHz9xNC62n5+hHfPN5KXMuQR/vwpqjKG1PfXgwiXlYeTtACHBwg0NwjqlaxjGkBUXKihGLy3JHUwnooD41M88zGFz2kXFbTNpwuXX3gBsEM7SO56Qk8JEtUuosNqSXRp3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110253; c=relaxed/simple;
	bh=wDj657IbuDZ2v2XsQ+fL2x8EzSha6fPYCWrxI4syeAw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oOhKSIR3qwMJuhK9LM2lVUMHSFCn+tD2YeYqVs4Y/L3ka3eRxe2XRMExz4yvh7TNJYnFdHJ6xqGYasztbrp9W3GyMG/nD/aWsCfQZajigb6EHMA0DXcykeyRzAheuOmsChThGpXvAgh6CnDDKsg4XOW6fzWos1jv2UaN9LKVJh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S12cgfqu; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6903ea40d25so15323316d6.0
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 05:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711110251; x=1711715051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c+bsfk+7GnNR3QW1NyI2y0t8bsxNvVv/cq4ocDvOM9s=;
        b=S12cgfquDJ2u+3ruDxNqBVo3EniW6AsOxUdIccU9OwYNxj3vrRV+iMu+4qM0//dA3e
         30jDHRPQ8GIECddKkay+leeHou319dodl9JbQOTCMt83BYf7ufe4FlfACf4E2I+96vY+
         blmjsicgMtKGMxlR1dHWc15o+fSUQ8m6/TbO01uxQtGf5Ox6oCePAjsJ2S9vcmM5wZoK
         fTTjayo8MvlABm1nwG7ndZ3wl0zihIs8lK3Tttg/XEYCyb5OvSTbxjm2MwCTKfDh5m94
         3S8ciyfuKkzqsHwc2eEAUWP9GN5x9LTiHhJiXarfibhwGC9dpKnWDW9aS+rUt3Dqj6ri
         sO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711110251; x=1711715051;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c+bsfk+7GnNR3QW1NyI2y0t8bsxNvVv/cq4ocDvOM9s=;
        b=qkx81vni8VsCgJOHv6HuXyUEgwTCvnF/GY3eXEBRhgQj1Log5/mEoQ1rIdeH/Lbv7K
         PiueveU9swqTCAQDmZxnB/tjxPJxy5sk6YOrjmJl2WWMVCt0gDmikcG7dnVqsZeT52td
         sQYNlWZJN4Bozyy/64lqPZzQkoShFq8fUbSzP5/430rgfxk6Q+aymcQha+/cPmDK4dVo
         kbCM6wvrtBU5wsBahqTRhaaRClPxSB1PMh9rZLhaOk/b2FcZ0DtoGkoaHtFocjKWfz+2
         i9EUc6mW9/0/hNUsT3OSkNfQYvVNmu9k8d22SxK0ZHdXWZVLC5JBluGFJkYGY4pfpZUW
         WM4A==
X-Forwarded-Encrypted: i=1; AJvYcCWNzY7XY0G979GZ0aNNbj4mNTFTAVjNfRkWvuo57k4jdNKt/uSFJE4mqwvv2J6RxKuLbfSC/31biN6Xl+Z9pj6v6Fq1FoJX
X-Gm-Message-State: AOJu0YzhBgT/w/4k8Xc4VYWsko6CMtO4KNq3VqznUmb3FT0jcDrvSva7
	T4SVmoiP5DCIq/OcSz15Gjopo3dPGtsx4Op/zfunj62y2y+iWoITeO3K9Y0aY/sM5Yf7JwtsETX
	Hh+L3KRId6w==
X-Google-Smtp-Source: AGHT+IEenSpHKemEGh4wgzSilfm15HdibY9ILeqQlwbV29ijGCTERFJT/eWmlOsLds85//cBD0YvjJa/fDEHgA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6214:570d:b0:690:dc39:176c with SMTP
 id qn13-20020a056214570d00b00690dc39176cmr20467qvb.9.1711110250311; Fri, 22
 Mar 2024 05:24:10 -0700 (PDT)
Date: Fri, 22 Mar 2024 12:24:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322122407.1329861-1-edumazet@google.com>
Subject: [PATCH net] bpf: Don't redirect too small packets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+9e27778c0edc62cb97d8@syzkaller.appspotmail.com, 
	Stanislav Fomichev <sdf@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

Some drivers ndo_start_xmit() expect a minimal size, as shown
by various syzbot reports [1].

Willem added in commit 217e6fa24ce2 ("net: introduce device min_header_len")
the missing attribute that can be used by upper layers.

We need to use it in __bpf_redirect_common().

[1]

BUG: KMSAN: uninit-value in erspan_build_header+0x170/0x2f0 include/net/erspan.h:197
  erspan_build_header+0x170/0x2f0 include/net/erspan.h:197
  erspan_xmit+0x128a/0x1ec0 net/ipv4/ip_gre.c:706
  __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
  netdev_start_xmit include/linux/netdevice.h:4917 [inline]
  xmit_one net/core/dev.c:3531 [inline]
  dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3547
  sch_direct_xmit+0x3c5/0xd50 net/sched/sch_generic.c:343
  __dev_xmit_skb net/core/dev.c:3760 [inline]
  __dev_queue_xmit+0x2e6a/0x52c0 net/core/dev.c:4301
  dev_queue_xmit include/linux/netdevice.h:3091 [inline]
  __bpf_tx_skb net/core/filter.c:2136 [inline]
  __bpf_redirect_common net/core/filter.c:2180 [inline]
  __bpf_redirect+0x14a6/0x1620 net/core/filter.c:2187
  ____bpf_clone_redirect net/core/filter.c:2460 [inline]
  bpf_clone_redirect+0x328/0x470 net/core/filter.c:2432
  ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
  __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2238
  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
  __bpf_prog_run include/linux/filter.h:657 [inline]
  bpf_prog_run include/linux/filter.h:664 [inline]
  bpf_test_run+0x499/0xc30 net/bpf/test_run.c:425
  bpf_prog_test_run_skb+0x14ea/0x1f20 net/bpf/test_run.c:1058
  bpf_prog_test_run+0x6b7/0xad0 kernel/bpf/syscall.c:4240
  __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5649
  __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
  __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5736
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was created at:
  slab_post_alloc_hook mm/slub.c:3804 [inline]
  slab_alloc_node mm/slub.c:3845 [inline]
  kmem_cache_alloc_node+0x613/0xc50 mm/slub.c:3888
  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
  pskb_expand_head+0x222/0x19d0 net/core/skbuff.c:2245
  __skb_cow include/linux/skbuff.h:3671 [inline]
  skb_cow_head include/linux/skbuff.h:3705 [inline]
  erspan_xmit+0xb08/0x1ec0 net/ipv4/ip_gre.c:692
  __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
  netdev_start_xmit include/linux/netdevice.h:4917 [inline]
  xmit_one net/core/dev.c:3531 [inline]
  dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3547
  sch_direct_xmit+0x3c5/0xd50 net/sched/sch_generic.c:343
  __dev_xmit_skb net/core/dev.c:3760 [inline]
  __dev_queue_xmit+0x2e6a/0x52c0 net/core/dev.c:4301
  dev_queue_xmit include/linux/netdevice.h:3091 [inline]
  __bpf_tx_skb net/core/filter.c:2136 [inline]
  __bpf_redirect_common net/core/filter.c:2180 [inline]
  __bpf_redirect+0x14a6/0x1620 net/core/filter.c:2187
  ____bpf_clone_redirect net/core/filter.c:2460 [inline]
  bpf_clone_redirect+0x328/0x470 net/core/filter.c:2432
  ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
  __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2238
  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
  __bpf_prog_run include/linux/filter.h:657 [inline]
  bpf_prog_run include/linux/filter.h:664 [inline]
  bpf_test_run+0x499/0xc30 net/bpf/test_run.c:425
  bpf_prog_test_run_skb+0x14ea/0x1f20 net/bpf/test_run.c:1058
  bpf_prog_test_run+0x6b7/0xad0 kernel/bpf/syscall.c:4240
  __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5649
  __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
  __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5736
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

CPU: 0 PID: 5041 Comm: syz-executor167 Not tainted 6.8.0-syzkaller-11743-ga4145ce1e7bc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024

Fixes: fd1894224407 ("bpf: Don't redirect packets with invalid pkt_len")
Reported-by: syzbot+9e27778c0edc62cb97d8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/000000000000205af206143ece22@google.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Willem de Bruijn <willemb@google.com>
---
 net/core/filter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 8adf95765cdd967a15b2661dfb454db0ccf350b0..745697c08acb3a74721d26ee93389efa81e973a0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2175,6 +2175,11 @@ static int __bpf_redirect_common(struct sk_buff *skb, struct net_device *dev,
 		return -ERANGE;
 	}
 
+	if (unlikely(skb->len < dev->min_header_len)) {
+		kfree_skb(skb);
+		return -ERANGE;
+	}
+
 	bpf_push_mac_rcsum(skb);
 	return flags & BPF_F_INGRESS ?
 	       __bpf_rx_skb(dev, skb) : __bpf_tx_skb(dev, skb);
-- 
2.44.0.396.g6e790dbe36-goog


