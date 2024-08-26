Return-Path: <netdev+bounces-121755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC2695E642
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 03:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5C21C20898
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 01:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5181B7E6;
	Mon, 26 Aug 2024 01:26:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E832210E3
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 01:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724635576; cv=none; b=LbmHRJRBxI5H1jMYFjv/yMr4q4TtzZu07XGucuJ1TLPjY9XxtdWDd2nNNisfy3eZnsdno21MBnKqqQOCSnR4Z9LQ4TYlCaAmhGzVqEa6gwdkUVNmduZKQoWQ3zaR4A0wOoac8CFwcdXx40uuc1gcp+lPanqR+qjKEmZBlr8TMMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724635576; c=relaxed/simple;
	bh=0ZiGBOJHOPnpRujsxIgwmWiaCQ1iYfL9aDIqptPPPF4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=maWXHUsq3BXqLP6Di7XzkktNU6Xg+T0Wdk4SCbKBIPA5jS4LOAwRrT1lMPpivoTuQLj6eBjvEGxeP3f5cn9Qr94OaugLzgvwRcemhU6jqhg5zcz3LmMnhs9qOsC6IS2JkR/lsysOSd1x8w+w35fGzB8YuVUgIlw3Ok0TBoge+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WsXws1gp7z6LCdq;
	Mon, 26 Aug 2024 09:22:53 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (unknown [7.191.160.78])
	by mail.maildlp.com (Postfix) with ESMTPS id CE870140CF4;
	Mon, 26 Aug 2024 09:26:05 +0800 (CST)
Received: from huawei.com (10.67.174.89) by lhrpeml500002.china.huawei.com
 (7.191.160.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 26 Aug
 2024 02:26:03 +0100
From: Liu Mingrui <liumingrui@huawei.com>
To: <willemdebruijn.kernel@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <liumingrui@huawei.com>
Subject: [PATCH -next] af_packet: display drop field in packet_seq_show
Date: Mon, 26 Aug 2024 09:26:25 +0000
Message-ID: <20240826092625.2637632-1-liumingrui@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhrpeml500002.china.huawei.com (7.191.160.78)

Display the dropped count of the packet, which could provide more
information for debugging.

Signed-off-by: Liu Mingrui <liumingrui@huawei.com>
---
 net/packet/af_packet.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 4a364cdd445e..22c59ee61888 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4771,14 +4771,14 @@ static int packet_seq_show(struct seq_file *seq, void *v)
 {
 	if (v == SEQ_START_TOKEN)
 		seq_printf(seq,
-			   "%*sRefCnt Type Proto  Iface R Rmem   User   Inode\n",
+			   "%*sRefCnt Type Proto  Iface R Rmem   User   Inode   Drops\n",
 			   IS_ENABLED(CONFIG_64BIT) ? -17 : -9, "sk");
 	else {
 		struct sock *s = sk_entry(v);
 		const struct packet_sock *po = pkt_sk(s);
 
 		seq_printf(seq,
-			   "%pK %-6d %-4d %04x   %-5d %1d %-6u %-6u %-6lu\n",
+			   "%pK %-6d %-4d %04x   %-5d %1d %-6u %-6u %-6lu %u\n",
 			   s,
 			   refcount_read(&s->sk_refcnt),
 			   s->sk_type,
@@ -4787,7 +4787,8 @@ static int packet_seq_show(struct seq_file *seq, void *v)
 			   packet_sock_flag(po, PACKET_SOCK_RUNNING),
 			   atomic_read(&s->sk_rmem_alloc),
 			   from_kuid_munged(seq_user_ns(seq), sock_i_uid(s)),
-			   sock_i_ino(s));
+			   sock_i_ino(s),
+			   atomic_read(&po->tp_drops));
 	}
 
 	return 0;
-- 
2.25.1


