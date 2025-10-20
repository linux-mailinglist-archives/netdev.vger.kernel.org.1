Return-Path: <netdev+bounces-230865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9515BBF0BBA
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4320A1894582
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3EF2F6587;
	Mon, 20 Oct 2025 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ddZS/Sn9"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609EA230BCB;
	Mon, 20 Oct 2025 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958460; cv=none; b=QZYT2gekgoI0qeKjF0PlXNJ8QlZmqPJfmlghBWrz0PZnhaULz2umgSUp0YrGBIvmFkqPcAKY4g9xCaw4GiFpmrBa1gSdGpTp8rDqdQrQ40ZVChT2H5KgIqQFrjUl3gKu46F7NtVy6xOseoTn0c1EfmA6HAz71duuIHpRkVqzwyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958460; c=relaxed/simple;
	bh=37JXeaabSnQEBCgvzFMhmKS7+aCd6QldkTzU3wu9728=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JDz5539/l9MfZR+VER+Ot2KfvvqcCCPQJhpAw5dSb+Vxt3QD7CGXBNaz5jhFErFoLg+nO+cgj/X94P0TZPNBqc/A9hocXN3S4yROLYmoCW+XOKG3UNS6ToO34GANwhrEsAFTGM3E5Gq5ia7z9Z+zBn0V2b/BBklushiu6I3nxQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ddZS/Sn9; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nQ0chgf8+QUyTzowyJfqVEnK894JZa7lGc3+hmjC1Yo=;
	b=ddZS/Sn9zzzc8Kf5fxuDeSAb2exjusBlWN7RobWM674HE7ExtsIcj3uJw6wB3xYX/wTy7PhQg
	DxAj9XoxB911hHx53WA7FFF8Qbjhxm6jMqsc7aYXBU4upkKMFUNyWMsZyHF2WIwI3kBGYtxFTs1
	sfgFUoJN6tXSYbRFG/Hth3g=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cqt0Y5NBcz1T4Jx;
	Mon, 20 Oct 2025 19:06:37 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 467EE180491;
	Mon, 20 Oct 2025 19:07:29 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Oct
 2025 19:07:28 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <syzbot+3df59a64502c71cab3d5@syzkaller.appspotmail.com>
CC: <syzkaller-bugs@googlegroups.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>
Subject: [PATCH net] Re: [syzbot] [net?] WARNING in xfrm6_tunnel_net_exit (4)
Date: Mon, 20 Oct 2025 19:30:26 +0800
Message-ID: <20251020113026.2461281-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500016.china.huawei.com (7.185.36.197)

#syz test

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index f3014e4f54fc..2e7ab56db152 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -441,6 +441,7 @@ int xfrm_input_register_afinfo(const struct xfrm_input_afinfo *afinfo);
 int xfrm_input_unregister_afinfo(const struct xfrm_input_afinfo *afinfo);
 
 void xfrm_flush_gc(void);
+void xfrm_state_delete_tunnel(struct xfrm_state *x);
 
 struct xfrm_type {
 	struct module		*owner;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index d213ca3653a8..5d982e4e6526 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -806,7 +806,6 @@ void __xfrm_state_destroy(struct xfrm_state *x)
 }
 EXPORT_SYMBOL(__xfrm_state_destroy);
 
-static void xfrm_state_delete_tunnel(struct xfrm_state *x);
 int __xfrm_state_delete(struct xfrm_state *x)
 {
 	struct net *net = xs_net(x);
@@ -3085,7 +3084,7 @@ void xfrm_flush_gc(void)
 }
 EXPORT_SYMBOL(xfrm_flush_gc);
 
-static void xfrm_state_delete_tunnel(struct xfrm_state *x)
+void xfrm_state_delete_tunnel(struct xfrm_state *x)
 {
 	if (x->tunnel) {
 		struct xfrm_state *t = x->tunnel;
@@ -3096,6 +3095,7 @@ static void xfrm_state_delete_tunnel(struct xfrm_state *x)
 		x->tunnel = NULL;
 	}
 }
+EXPORT_SYMBOL(xfrm_state_delete_tunnel);
 
 u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 {
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 010c9e6638c0..7f769617882c 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1031,6 +1031,7 @@ static int xfrm_add_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0) {
 		x->km.state = XFRM_STATE_DEAD;
 		xfrm_dev_state_delete(x);
+		xfrm_state_delete_tunnel(x);
 		__xfrm_state_put(x);
 		goto out;
 	}
-- 
2.34.1


