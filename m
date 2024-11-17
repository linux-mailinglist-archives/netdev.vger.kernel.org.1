Return-Path: <netdev+bounces-145616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A089D0209
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 06:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2A0BB22F61
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 05:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70786179BC;
	Sun, 17 Nov 2024 05:00:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 189.cn (ptr.189.cn [183.61.185.104])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57D315C0;
	Sun, 17 Nov 2024 05:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.61.185.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731819617; cv=none; b=cB32ADrqRU1lIHcrvkyYubzSPLWKh9rSJRAMXnvJBzIjxy9wOX5Emn7JRnndUlddJaP7dRTR13Noj1yyBYyw0ZzbXqMa1o5DkM+5PsBuN58rzhw6YZsF0d3xgq1pOApxz35rToD3+i7JEc9Gls7qMYHqYB6LRnESNuW3FUWW920=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731819617; c=relaxed/simple;
	bh=XgFJjt5/DFGuMscEjrtcxG3CWGxgAUMArINndNWJhU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JkTfWhgsuCQ4Oqpoo/+/OSLNyjGeKv23anzi9Sm0SuN8pkNGaVTe86lh09R4/PcVbBWW1nTYquN5VdaUNeZAwkOq6h2Spf98INUFON2MBME6UFUaL2oA/iIvmhDbiaialy2OISZfobPskCOnxUVVnx5It+W5Vad2bA+/XpmX7W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=183.61.185.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.242.145:64623.961438416
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-60.24.208.28 (unknown [10.158.242.145])
	by 189.cn (HERMES) with SMTP id F3C7B10294C;
	Sun, 17 Nov 2024 12:55:15 +0800 (CST)
Received: from  ([60.24.208.28])
	by gateway-153622-dep-5c5f88b874-qw5z2 with ESMTP id 42bc408d85d145a9944272cc616e9566 for davem@davemloft.net;
	Sun, 17 Nov 2024 12:55:18 CST
X-Transaction-ID: 42bc408d85d145a9944272cc616e9566
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 60.24.208.28
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kory.maincent@bootlin.com,
	aleksander.lobakin@intel.com,
	willemb@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Chen <chensong_2000@189.cn>
Subject: [PATCH] net/core/dev_ioctl: avoid invoking modprobe with empty ifr_name
Date: Sun, 17 Nov 2024 12:55:12 +0800
Message-Id: <20241117045512.111515-1-chensong_2000@189.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev_ioctl handles requests from user space if a process calls
ioctl(sockfd, SIOCGIFINDEX, &ifr). However, if this user space
process doesn't have interface name well specified, dev_ioctl
doesn't give it an essential check, as a result, dev_load will
invoke modprobe with a nonsense module name if the user happens
to be sys admin or root, see following code in dev_load:

    no_module = !dev;
    if (no_module && capable(CAP_NET_ADMIN))
        no_module = request_module("netdev-%s", name);
    if (no_module && capable(CAP_SYS_MODULE))
        request_module("%s", name);

This patch checks if ifr_name is empty at the beginning, reduces
the overhead of calling modprobe.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 net/core/dev_ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 473c437b6b53..1371269f17d5 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -676,6 +676,9 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr,
 	if (cmd == SIOCGIFNAME)
 		return dev_ifname(net, ifr);
 
+	if (ifr->ifr_name[0] == '\0')
+		return -EINVAL;
+
 	ifr->ifr_name[IFNAMSIZ-1] = 0;
 
 	colon = strchr(ifr->ifr_name, ':');
-- 
2.25.1


