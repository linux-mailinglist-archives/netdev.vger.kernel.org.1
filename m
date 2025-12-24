Return-Path: <netdev+bounces-245951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 523D5CDB86F
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 07:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 199B03032ABC
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 06:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75A72C237F;
	Wed, 24 Dec 2025 06:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b="J6L2wKYj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49239.qiye.163.com (mail-m49239.qiye.163.com [45.254.49.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6706929B204
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766558252; cv=none; b=u/B4kBgvn9N0Z9XITGZLWz13HjEcZS/YfUi57kqQCr6+1IEueHsJpFFwMPMOORL8Kt/m3YUGtsocCs6czJVmActYwIhZxGUUVdJOxGf1Blq6YSfws0SqUz+JLntmAa1BgFi/qQ2jO9JPpHN+K0E4K8UPfSRA1E+sDxygKfvqgfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766558252; c=relaxed/simple;
	bh=p8R1rg8MgFKGxMJfWxTDIlz+lFNXNAGHqT9vNuTdZ4k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SF9Qn2idAqdhswhQJ47RlAAsw9G/brSMlkR8HryXvXiwYcXqx3dTdnEVbU/sa0/yvEE7E/ceOd+XaEkEAUdC1k26n5GR7o+IaCWsR0umyQ5lhXTQ4OOzsvxz5AuRXvXz2UwiGN0jIfCwli/RKA7femD3N7DMTLbC9wLeWX6Nevc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn; spf=pass smtp.mailfrom=ucloud.cn; dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b=J6L2wKYj; arc=none smtp.client-ip=45.254.49.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucloud.cn
Received: from yuangap.. (unknown [106.75.220.2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 14bcb6d18;
	Wed, 24 Dec 2025 14:32:12 +0800 (GMT+08:00)
From: yuan.gao@ucloud.cn
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	segoon@openwall.com
Cc: netdev@vger.kernel.org,
	yuan.gao@ucloud.cn
Subject: [PATCH] inet: ping: Fix icmp out counting
Date: Wed, 24 Dec 2025 14:31:45 +0800
Message-Id: <20251224063145.3615282-1-yuan.gao@ucloud.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b4f0eda2e0229kunm1ff5929760255
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTx5OVh9ITEIZTUhCGhpNT1YVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlKS01VTE5VSUlLVUlZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
	pCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=J6L2wKYjv3kcseRkPempx/fRwNkjELAQP7DKS69flhEAb6HQJEvLSqIZNJTRh44W9yBQ9bI8IPriOkwJrXHpiPOCfkgXc7wIwHCyNrxuouhoONcxdRY/DKfDF+Zlr2I2ieUiugIzqWJPq+3EIqy5eUF3AAIWmLQrO5JVmR88xks=; c=relaxed/relaxed; s=default; d=ucloud.cn; v=1;
	bh=gdLYGMcYTs6dKDUfMelNeZy5jBu+tsm7t2ysbJ6CnXw=;
	h=date:mime-version:subject:message-id:from;

From: "yuan.gao" <yuan.gao@ucloud.cn>

When the ping program uses an IPPROTO_ICMP socket to send ICMP_ECHO
messages, ICMP_MIB_OUTMSGS is counted twice.

    ping_v4_sendmsg
      ping_v4_push_pending_frames
        ip_push_pending_frames
          ip_finish_skb
            __ip_make_skb
              icmp_out_count(net, icmp_type); // first count
      icmp_out_count(sock_net(sk), user_icmph.type); // second count

However, when the ping program uses an IPPROTO_RAW socket,
ICMP_MIB_OUTMSGS is counted correctly only once.

Therefore, the first count should be removed.

Fixes: c319b4d76b9e ("net: ipv4: add IPPROTO_ICMP socket kind")
Signed-off-by: yuan.gao <yuan.gao@ucloud.cn>
---
 net/ipv4/ping.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 4cb0c896c..c662d6821 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -833,10 +833,8 @@ static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 out_free:
 	if (free)
 		kfree(ipc.opt);
-	if (!err) {
-		icmp_out_count(sock_net(sk), user_icmph.type);
+	if (!err)
 		return len;
-	}
 	return err;
 
 do_confirm:
-- 
2.32.0


