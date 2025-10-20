Return-Path: <netdev+bounces-230863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2872BF0B69
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC52189E29E
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54C829D270;
	Mon, 20 Oct 2025 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ddZS/Sn9"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C9C25A2B5;
	Mon, 20 Oct 2025 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958181; cv=none; b=t8DRKhcPsI1Jn1DjwcHq5EZ5epHiqjuB6LyiUjJtzyqxhwqAGUhXNjoaQeDQuoDoTQcb//5odHsKj0dt4a5fW/JFhmIh+9BR+4RqZKNCuevo8KZB6qG9YwlvAv9MioFOwvBeYoVazSwD8mNmIlqy4Gu0jGDUO6tDrCn369Xy6ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958181; c=relaxed/simple;
	bh=37JXeaabSnQEBCgvzFMhmKS7+aCd6QldkTzU3wu9728=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=to9ygj4nBqgXzbkxEMuNusN97wGuatazBAo8gY0jQKhkWYpa02AAUu0FmnljSvv9Q6SMD6yole+Mgz2S8mXSeITo/EyJM6XQb5vEuR5A+3CzZBrE2cW7licxYOHZT9INTbiI3hmH4sNhcA52pfV8+2anNkjA4cqutw1sMvEj5/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ddZS/Sn9; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nQ0chgf8+QUyTzowyJfqVEnK894JZa7lGc3+hmjC1Yo=;
	b=ddZS/Sn9zzzc8Kf5fxuDeSAb2exjusBlWN7RobWM674HE7ExtsIcj3uJw6wB3xYX/wTy7PhQg
	DxAj9XoxB911hHx53WA7FFF8Qbjhxm6jMqsc7aYXBU4upkKMFUNyWMsZyHF2WIwI3kBGYtxFTs1
	sfgFUoJN6tXSYbRFG/Hth3g=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cqsvr6CF4zLlVc;
	Mon, 20 Oct 2025 19:02:32 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 484B61400CB;
	Mon, 20 Oct 2025 19:02:56 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Oct
 2025 19:02:55 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com>
CC: <syzkaller-bugs@googlegroups.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>
Subject: [PATCH net] Re: [syzbot] [net?] WARNING in xfrm_state_fini (4)
Date: Mon, 20 Oct 2025 19:25:53 +0800
Message-ID: <20251020112553.2345296-1-wangliang74@huawei.com>
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


