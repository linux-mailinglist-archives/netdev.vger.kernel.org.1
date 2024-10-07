Return-Path: <netdev+bounces-132678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1E7992C3E
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39FFB1C2284C
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126DF1D4344;
	Mon,  7 Oct 2024 12:41:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676C01D415D;
	Mon,  7 Oct 2024 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304918; cv=none; b=EK97b/i3LXZaf2M+MA7sbyPGs/SY2nKxytb9v90C1nOCNFtM3FlkjaZGlwwBX/ZcR3eP7uU9Ll6mNct03UGKHdChYkO5/7IRvM5/v087MvsHBJiDkSqBfv+71T9j0lO+WwMRet4ktT+1FoiPHbuyW2N7EII/eK4yEvr0qrHWW8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304918; c=relaxed/simple;
	bh=aBlOcBGpY6fSZAZ+sX+T0PzvypJLxIF4FfnR85bUerg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrNDMi0aQrioNMSduDyST/Yqndm+12dcOxYq9ISWCMtjfQAIZBYq9NPM2pUdFhRhCSwwc3OUvEnPVHcI7PMU1kcxG8xofXXOa+zDpR8cmXPQ0Gfd356mYgpMbdfUTo6EBJZo8EpbxqTwdFdkxcUabyL43E0YUBhWyBk/fUEagvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XMf0c4p5mz6K8kG;
	Mon,  7 Oct 2024 20:41:36 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id B7D39140581;
	Mon,  7 Oct 2024 20:41:48 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 7 Oct
 2024 14:41:44 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v01 1/4] af_packet: allow fanout_add when socket is not RUNNING
Date: Mon, 7 Oct 2024 15:40:24 +0300
Message-ID: <52a2ac061498e96e69a71e49ecb961b6a17dfff7.1728303615.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1728303615.git.gur.stavi@huawei.com>
References: <cover.1728303615.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 frapeml500005.china.huawei.com (7.182.85.13)

PACKET socket can retain its fanout membership through link down and up
and (obviously) leave a fanout while it is not RUNNING (link down).
However, socket was forbidden from joining a fanout while it was not
RUNNING.

This patch allows PACKET socket to join fanout while not RUNNING.

Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
---
 net/packet/af_packet.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a705ec214254..c28eee7f6ce0 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1846,21 +1846,21 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
 	err = -EINVAL;
 
 	spin_lock(&po->bind_lock);
-	if (packet_sock_flag(po, PACKET_SOCK_RUNNING) &&
-	    match->type == type &&
+	if (match->type == type &&
 	    match->prot_hook.type == po->prot_hook.type &&
 	    match->prot_hook.dev == po->prot_hook.dev) {
 		err = -ENOSPC;
 		if (refcount_read(&match->sk_ref) < match->max_num_members) {
-			__dev_remove_pack(&po->prot_hook);
-
 			/* Paired with packet_setsockopt(PACKET_FANOUT_DATA) */
 			WRITE_ONCE(po->fanout, match);
 
 			po->rollover = rollover;
 			rollover = NULL;
 			refcount_set(&match->sk_ref, refcount_read(&match->sk_ref) + 1);
-			__fanout_link(sk, po);
+			if (packet_sock_flag(po, PACKET_SOCK_RUNNING)) {
+				__dev_remove_pack(&po->prot_hook);
+				__fanout_link(sk, po);
+			}
 			err = 0;
 		}
 	}
-- 
2.45.2


