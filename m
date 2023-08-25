Return-Path: <netdev+bounces-30693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D2F788901
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 15:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC1E281841
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA0BDF5C;
	Fri, 25 Aug 2023 13:50:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE9FFBE5
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 13:50:10 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64822139
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 06:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=jzRX7/qnR+t1YEbmQetntI2PCqfRqtvfwyNmtZbD3GA=; b=L3HmVNwz916N19prEEb3uVjEVz
	11fynssVFGTSJC1amtvmrh4pYBMeVct91Bcs+1EF9yhroXF9U29eSxVnE/Mv87vZ6MSGX7BqEGj/Q
	lFNamicT+qUYKnCgdXXjDh9UUTMs/SyKc5cpCed+Mn/93uQTFREkXyfSFzXN3wpRoPtBBUb8DUztk
	zKUUzBsghi4/zVwhWr9QPEjR2ZgEwkfDEdJIk7B9RH4IoRGKoVhMWjzS9UfciEJ9BDNcMvw+lQrpT
	MFHd+MdgVhFmPmzj0v5eQXm4O04ofwzLY8CVRhiQIr8gXOoclYcbSriRSdVUelm8ezT7XlsDo6oMm
	CtuIL53Q==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qZXCF-000Eu1-3Z; Fri, 25 Aug 2023 15:49:55 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	pabeni@redhat.com,
	kuba@kernel.org,
	gal@nvidia.com,
	martin.lau@linux.dev,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next 1/2] net: Fix skb consume leak in sch_handle_egress
Date: Fri, 25 Aug 2023 15:49:45 +0200
Message-Id: <20230825134946.31083-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27011/Fri Aug 25 09:40:47 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix a memory leak for the tc egress path with TC_ACT_{STOLEN,QUEUED,TRAP}:

  [...]
  unreferenced object 0xffff88818bcb4f00 (size 232):
  comm "softirq", pid 0, jiffies 4299085078 (age 134.028s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 80 70 61 81 88 ff ff 00 41 31 14 81 88 ff ff  ..pa.....A1.....
  backtrace:
    [<ffffffff9991b938>] kmem_cache_alloc_node+0x268/0x400
    [<ffffffff9b3d9231>] __alloc_skb+0x211/0x2c0
    [<ffffffff9b3f0c7e>] alloc_skb_with_frags+0xbe/0x6b0
    [<ffffffff9b3bf9a9>] sock_alloc_send_pskb+0x6a9/0x870
    [<ffffffff9b6b3f00>] __ip_append_data+0x14d0/0x3bf0
    [<ffffffff9b6ba24e>] ip_append_data+0xee/0x190
    [<ffffffff9b7e1496>] icmp_push_reply+0xa6/0x470
    [<ffffffff9b7e4030>] icmp_reply+0x900/0xa00
    [<ffffffff9b7e42e3>] icmp_echo.part.0+0x1a3/0x230
    [<ffffffff9b7e444d>] icmp_echo+0xcd/0x190
    [<ffffffff9b7e9566>] icmp_rcv+0x806/0xe10
    [<ffffffff9b699bd1>] ip_protocol_deliver_rcu+0x351/0x3d0
    [<ffffffff9b699f14>] ip_local_deliver_finish+0x2b4/0x450
    [<ffffffff9b69a234>] ip_local_deliver+0x174/0x1f0
    [<ffffffff9b69a4b2>] ip_sublist_rcv_finish+0x1f2/0x420
    [<ffffffff9b69ab56>] ip_sublist_rcv+0x466/0x920
  [...]

I was able to reproduce this via:

  ip link add dev dummy0 type dummy
  ip link set dev dummy0 up
  tc qdisc add dev eth0 clsact
  tc filter add dev eth0 egress protocol ip prio 1 u32 match ip protocol 1 0xff action mirred egress redirect dev dummy0
  ping 1.1.1.1
  <stolen>

After the fix, there are no kmemleak reports with the reproducer. This is
in line with what is also done on the ingress side, and from debugging the
skb_unref(skb) on dummy xmit and sch_handle_egress() side, it is visible
that these are two different skbs with both skb_unref(skb) as true. The two
seen skbs are due to mirred doing a skb_clone() internally as use_reinsert
is false in tcf_mirred_act() for egress. This was initially reported by Gal.

Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
Reported-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/bdfc2640-8f65-5b56-4472-db8e2b161aab@nvidia.com
---
 net/core/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 17e6281e408c..9f6ed6d97f89 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4061,6 +4061,7 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 	case TC_ACT_STOLEN:
 	case TC_ACT_QUEUED:
 	case TC_ACT_TRAP:
+		consume_skb(skb);
 		*ret = NET_XMIT_SUCCESS;
 		return NULL;
 	}
-- 
2.34.1


