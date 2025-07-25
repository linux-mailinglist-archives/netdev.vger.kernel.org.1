Return-Path: <netdev+bounces-209935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46800B115A7
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 03:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B723A40E5
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 01:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059C817CA1B;
	Fri, 25 Jul 2025 01:16:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D3BB676;
	Fri, 25 Jul 2025 01:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753406204; cv=none; b=i/72iDmL8sFoRDAXE3MbcDNEfWAKeg75a4RdxfblXDUEc5JDauinYpNtweL5/e+54ZvpLiJe4RotK/8F+F/vIldPdQR9Hk/uFzcX8c5d9indcE0qjlIHegm6+tAOx/ZZjK8PKzuH1TASPgvFeL87iN5vgGHfF0vmcjof/7eU22s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753406204; c=relaxed/simple;
	bh=tgJjmb3D/EBX50l0+VI6F0vwMmlQ/g6/llxOIyaa9H0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KDeHYOdBuN9+If5oNBvemd588NYuj4JsVLgqLgNILjM2Hosna9GNDEzWfipRNYGgLMkGDUWY+aierh7zPx83mlEvGMgjtrmJUyZn94aa0Dd5D7I6fwo1C6FceTMFMsPVVaUMC7zsWqYwDJsA63Xt3FplxhXRHr3LeFF+DZOzBok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bp8zN2fTmz2RVxc;
	Fri, 25 Jul 2025 09:14:24 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id CDF271400D4;
	Fri, 25 Jul 2025 09:16:39 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 25 Jul
 2025 09:16:38 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <sgarzare@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <virtualization@lists.linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] vsock: remove unnecessary null check in vsock_getname()
Date: Fri, 25 Jul 2025 09:38:08 +0800
Message-ID: <20250725013808.337924-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500016.china.huawei.com (7.185.36.197)

The local variable 'vm_addr' is always not NULL, no need to check it.

Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/vmw_vsock/af_vsock.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 1053662725f8..fae512594849 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1028,11 +1028,6 @@ static int vsock_getname(struct socket *sock,
 		vm_addr = &vsk->local_addr;
 	}
 
-	if (!vm_addr) {
-		err = -EINVAL;
-		goto out;
-	}
-
 	/* sys_getsockname() and sys_getpeername() pass us a
 	 * MAX_SOCK_ADDR-sized buffer and don't set addr_len.  Unfortunately
 	 * that macro is defined in socket.c instead of .h, so we hardcode its
-- 
2.34.1


