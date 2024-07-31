Return-Path: <netdev+bounces-114527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A51B942D42
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 13:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9331C225CE
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067C61AD40E;
	Wed, 31 Jul 2024 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b="lkAMj6F2"
X-Original-To: netdev@vger.kernel.org
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC2B145FEF;
	Wed, 31 Jul 2024 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.61.200.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425365; cv=none; b=o1RBKioH8BToU53ytf/FIf02nSjXLFRqW7WEMM2Ip+1WwYBvFeEzMjj4Pho3yL8nxIM6bDBYJCwobl664swBDSNO+c/YQBZiTDfLgGsvSZfoehL3ibkSIevKr0yCLuKJ2APfyz9Qona9r7hAb15UOartaFrAZzbK5QSq3el4zN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425365; c=relaxed/simple;
	bh=cvYcCNPyHR43Mieu10aU4cHyG0KjJGlFvBgtRmmYfag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yt3SeQqHz8UttM/2q3jQBlhC+iI4/4NOYlimTh9yULdVH763oMCujR3js993PXOB+ciGnTJ18uJ2uETEG+wdWc9Az+9j0wKYDKhA8/ddSnFdOjkjmGKwHrAesU6ALI6L6eFTpUdXZjlu0tD5zqctcpVsfxmsR7pnzjRfynB2q/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info; spf=pass smtp.mailfrom=soulik.info; dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b=lkAMj6F2; arc=none smtp.client-ip=108.61.200.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soulik.info
Received: from ritsuko.sh.sumomo.pri (unknown [10.0.12.132])
	by kozue.soulik.info (Postfix) with ESMTPSA id B73D02FDA00;
	Wed, 31 Jul 2024 20:20:17 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info B73D02FDA00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
	t=1722424819; bh=hCUjMQaMhFJAPCSczpu0OcSyTOQ67dI8mk5P2p4URU0=;
	h=From:To:Cc:Subject:Date:From;
	b=lkAMj6F2mSX6fvi2Q6uJc6bp7S+Rzxd2Gfi4ianoGnuY42xTITlAJtex7RCjiECIV
	 6TqUb1GvIVqPldiG6dRWrprEJoeR3P9qW9yNjMW1jtt9KlVCjZaYXQeQS5N3w1PIek
	 +i/9y8G0RnqQ3EhUgd58a7vIRtGo9k1kMvgjRs/0=
From: Randy Li <ayaka@soulik.info>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Randy Li <ayaka@soulik.info>
Subject: [PATCH] net: tuntap: add ioctl() TUNGETQUEUEINDX to fetch queue index
Date: Wed, 31 Jul 2024 19:19:37 +0800
Message-ID: <20240731111940.8383-1-ayaka@soulik.info>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need the queue index in qdisc mapping rule. There is no way to
fetch that.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 drivers/net/tap.c           | 9 +++++++++
 drivers/net/tun.c           | 4 ++++
 include/uapi/linux/if_tun.h | 1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 77574f7a3bd4..6099f27a0a1f 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1120,6 +1120,15 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 		rtnl_unlock();
 		return ret;
 
+	case TUNGETQUEUEINDEX:
+		rtnl_lock();
+		if (!q->enabled)
+			ret = -EINVAL;
+
+		ret = put_user(q->queue_index, up);
+		rtnl_unlock();
+		return ret;
+
 	case SIOCGIFHWADDR:
 		rtnl_lock();
 		tap = tap_get_tap_dev(q);
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 1d06c560c5e6..5473a0fca2e1 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3115,6 +3115,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
 		return open_related_ns(&net->ns, get_net_ns);
+	} else if (cmd == TUNGETQUEUEINDEX) {
+		if (tfile->detached)
+			return -EINVAL;
+		return put_user(tfile->queue_index, (unsigned int __user*)argp);
 	}
 
 	rtnl_lock();
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 287cdc81c939..2668ca3b06a5 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -61,6 +61,7 @@
 #define TUNSETFILTEREBPF _IOR('T', 225, int)
 #define TUNSETCARRIER _IOW('T', 226, int)
 #define TUNGETDEVNETNS _IO('T', 227)
+#define TUNGETQUEUEINDEX _IOR('T', 228, unsigned int)
 
 /* TUNSETIFF ifr flags */
 #define IFF_TUN		0x0001
-- 
2.45.2


