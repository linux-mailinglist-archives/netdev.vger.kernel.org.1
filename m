Return-Path: <netdev+bounces-304277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IlAqDlnfRmqPewsAu9opvQ
	(envelope-from <netdev+bounces-304277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 23:59:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C606FD1C0
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 23:59:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=UUTxyPwA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304277-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304277-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF8E03017245
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 21:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BDD3B47F9;
	Thu,  2 Jul 2026 21:59:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9743B3BEF
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 21:59:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783029575; cv=none; b=eNQd9pudaXvm9gxk6EX97wc5uD9XamTGQI8+KRjMf8Xn1H5sYm1Pyf4zHgYL+2fL6+J8rE2bTM7DARE5yZrP8jNAjFyN58YPb03UVC2nI2xm09FPWWWOdH8IYlEs+giiFLNJzl+UpZRRA5pGqN+uCTsAkv/N8pxObDYFHwUK3C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783029575; c=relaxed/simple;
	bh=/V1rwNDFD9xRESqnFxeRFnzSWjZJMsSsU9RN0HJ2nfc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kOaiaQ6kbFsrqxncqsyaZPLAm4vdIa0DE8dnNKN7SG19UH5lijNT/ykgE+UE5azwopKTtwTC/NKqTdFVmdukmVI1SkHDyuAlDs9h8SgHsM3OV9sWYzBehi7lJ1qCBL3yNxU/hB7dgXDls2zKhCiTsLtcUQhZ4kfoYCha5EtsiXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UUTxyPwA; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cacaf479f9so8639225ad.3
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 14:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783029573; x=1783634373; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dj8SH38Ve++9Zk/H/OUEK4h6BqvUJVzU5G2pZidlHcg=;
        b=UUTxyPwAZefLoVtdXqIIANg2mm1w4IRrEY3lTkwyMtofQDXSfQIGsoGvbvrJYheeAX
         eXPIpdnviNeaMEROKRfQNiFJTS5PkoWDpYNwYZX58p5oT1G2HtzVM9xovMkqzh85b6rT
         7Vp0L8QKq76F7lZVaskD3yAsVSNqDYs9dXBMwmDSUV8E2d9m8vmS4/y46wDgiEhssyh9
         Ox760F7nxUaGYL3qQun9PpZ0w8BgxXs3YHFxBQ80rZYUWu5uT13f6i/kWrVGpFYwL7Oz
         P4hEIyYnuSowxusJSU/hxdMk9Y+dE6J0BOOuDLIZ+gSfjEBJt5UZbHqUZrzRpGCmcY5h
         KYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783029573; x=1783634373;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dj8SH38Ve++9Zk/H/OUEK4h6BqvUJVzU5G2pZidlHcg=;
        b=PxJIv5uYW2cP4wM6tYO1HYT26fJ6po66uXGCxbk+D8gOIABYe4+SrDZU91CP1IqPOP
         3nk2FXnzLGrEqH2r5+M/DncWnqqELrh0//m3vWLUNdHCBgBaqK3L0SIS3UFY+UTtVA9R
         a25YVgGKWmKxjkj0GfAcA30IHIgfZyR4oc4WL8/EjgQkeTPVoNrvlslf1+gQEA+/iCs5
         /EqZgMl7zcN3HJW6Shcut+oLrnh1B48oJJurhCFEP3c1j/NtfXHldAjC0Zr96N9am+Al
         IzNR/vzK2jsNjhrxuklpuHAzdb5EjmnzohSt3jFAE4eWHLEGxI3GwgTRmmJ4vbDG4afF
         7PPA==
X-Forwarded-Encrypted: i=1; AHgh+Rqzzio5ZSAEbMtTzhvQI3JsWFc6H0EqN0KuZ6f/QqNoNb2prwbKqqZKCKz4GBgHo6ncD9lsBwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Y43TYU1fB5Yucfb65+QcR0ecqf0J+jNjeT22Sgt8rnZ4rhkq
	Q1117Qz0v/l2H0HdnPX853+f5xYLEfD37RTGBTQEU5MVXtgPc9wG2pDxE8R1/723WV8lkmNeOT5
	XCYd/PA==
X-Received: from plge11.prod.google.com ([2002:a17:902:cf4b:b0:2b6:417:db8d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:230b:b0:2c9:98e2:76aa
 with SMTP id d9443c01a7336-2ca9121f078mr74456995ad.38.1783029572961; Thu, 02
 Jul 2026 14:59:32 -0700 (PDT)
Date: Thu,  2 Jul 2026 21:59:26 +0000
In-Reply-To: <6a461706.52c20a74.1f8b39.0008.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <6a461706.52c20a74.1f8b39.0008.GAE@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702215932.1418087-1-kuniyu@google.com>
Subject: Re: [syzbot ci] Re: net: Support per-netns device unregistration
From: Kuniyuki Iwashima <kuniyu@google.com>
To: syzbot+ci052b96c9bf56ca1d@syzkaller.appspotmail.com
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuni1840@gmail.com, kuniyu@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304277-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:syzbot+ci052b96c9bf56ca1d@syzkaller.appspotmail.com,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:kuni1840@gmail.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzbot@lists.linux.dev,m:syzkaller-bugs@googlegroups.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,redhat.com,lists.linux.dev,googlegroups.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,ci052b96c9bf56ca1d];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82C606FD1C0

From: syzbot ci <syzbot+ci052b96c9bf56ca1d@syzkaller.appspotmail.com>
Date: Thu, 02 Jul 2026 00:45:10 -0700
> syzbot ci has tested the following series
> 
> [v1] net: Support per-netns device unregistration
> https://lore.kernel.org/all/20260701214334.266991-1-kuniyu@google.com
> * [PATCH v1 net-next 01/14] rtnetlink: Lock sock_net(skb->sk) in rtnl_newlink().
> * [PATCH v1 net-next 02/14] rtnetlink: Call unregister_netdevice_many() only once in rtnl_link_unregister().
> * [PATCH v1 net-next 03/14] rtnetlink: Add per-netns rtnl_work.
> * [PATCH v1 net-next 04/14] net: Wrap default_device_exit_net() with __rtnl_net_lock().
> * [PATCH v1 net-next 05/14] net: Hold __rtnl_net_lock() in netdev_wait_allrefs_any().
> * [PATCH v1 net-next 06/14] net: Add per-netns netdev unregistration infra.
> * [PATCH v1 net-next 07/14] net: Call unregister_netdevice_many() per netns.
> * [PATCH v1 net-next 08/14] veth: Support per-netns device unregistration.
> * [PATCH v1 net-next 09/14] bareudp: Protect bareudp_list with mutex.
> * [PATCH v1 net-next 10/14] bareudp: Support per-netns netdev unregistration.
> * [PATCH v1 net-next 11/14] ipvlan: Convert ipvl_port.count to refcount_t.
> * [PATCH v1 net-next 12/14] ipvlan: Synchronise ipvlan_init() and ipvlan_uninit() for the same lower dev.
> * [PATCH v1 net-next 13/14] ipvlan: Protect ipvl_port.ipvlans with mutex.
> * [PATCH v1 net-next 14/14] ipvlan: Support per-netns netdev unregistration.
> 
> and found the following issue:
> possible deadlock in __dev_change_net_namespace
> 
> Full report is available here:
> https://ci.syzbot.org/series/a744b257-d741-4780-8a53-f156b2a7afc9
> 
> ***
> 
> possible deadlock in __dev_change_net_namespace
> 
> tree:      net-next
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
> base:      d6e81529749190123aa0040626c7e5dbc20fdc9a
> arch:      amd64
> compiler:  Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
> config:    https://ci.syzbot.org/builds/243cd0ec-28f9-4d21-8f16-3d2fbad8388d/config
> syz repro: https://ci.syzbot.org/findings/a8a0740d-fdec-4a20-9aa5-7cb955707913/syz_repro
> 
> veth0_macvtap: left promiscuous mode
> ============================================
> WARNING: possible recursive locking detected
> syzkaller #0 Not tainted
> --------------------------------------------
> syz.1.18/5814 is trying to acquire lock:
> ffffffff9a9b0418 (&net->dev_unreg_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:342 [inline]
> ffffffff9a9b0418 (&net->dev_unreg_lock){+.+.}-{3:3}, at: unregister_netdevice_move_net net/core/dev.c:-1 [inline]
> ffffffff9a9b0418 (&net->dev_unreg_lock){+.+.}-{3:3}, at: __dev_change_net_namespace+0x1479/0x2200 net/core/dev.c:12768
> 
> but task is already holding lock:
> ffff88810b6cf8d8 (&net->dev_unreg_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:342 [inline]
> ffff88810b6cf8d8 (&net->dev_unreg_lock){+.+.}-{3:3}, at: unregister_netdevice_move_net net/core/dev.c:-1 [inline]
> ffff88810b6cf8d8 (&net->dev_unreg_lock){+.+.}-{3:3}, at: __dev_change_net_namespace+0x146a/0x2200 net/core/dev.c:12768
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&net->dev_unreg_lock);
>   lock(&net->dev_unreg_lock);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation

Oh right, I'll squash this to patch 6.

---8<---
diff --git a/net/core/dev.c b/net/core/dev.c
index 57fb4741d0ac..fcd58c2aa030 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12574,10 +12574,10 @@ static void unregister_netdevice_move_net(struct net *net_old,
 {
 	if (net_old > net) {
 		spin_lock(&net->dev_unreg_lock);
-		spin_lock(&net_old->dev_unreg_lock);
+		spin_lock_nested(&net_old->dev_unreg_lock, SINGLE_DEPTH_NESTING);
 	} else {
 		spin_lock(&net_old->dev_unreg_lock);
-		spin_lock(&net->dev_unreg_lock);
+		spin_lock_nested(&net->dev_unreg_lock, SINGLE_DEPTH_NESTING);
 	}
 
 	if (!list_empty(&dev->unreg_list_net)) {
---8<---

