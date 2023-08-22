Return-Path: <netdev+bounces-29741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F5F7848E3
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 19:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707F7280DA2
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606E61DDD9;
	Tue, 22 Aug 2023 17:59:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DE51DA54
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 17:59:12 +0000 (UTC)
Received: from [192.168.42.3] (194-45-78-10.static.kviknet.net [194.45.78.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 785C7C433CA;
	Tue, 22 Aug 2023 17:59:09 +0000 (UTC)
Subject: [PATCH net-next RFC v1 1/4] veth: use same bpf_xdp_adjust_head check
 as generic-XDP
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, edumazet@google.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, lorenzo@kernel.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, mtahhan@redhat.com,
 huangjie.albert@bytedance.com, Yunsheng Lin <linyunsheng@huawei.com>,
 Liang Chen <liangchen.linux@gmail.com>
Date: Tue, 22 Aug 2023 19:59:07 +0200
Message-ID: <169272714720.1975370.12172959079424954030.stgit@firesoul>
In-Reply-To: <169272709850.1975370.16698220879817216294.stgit@firesoul>
References: <169272709850.1975370.16698220879817216294.stgit@firesoul>
User-Agent: StGit/1.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This is a consistency patch, no functional change.

Both veth_xdp_rcv_skb() and bpf_prog_run_generic_xdp() checks if XDP bpf_prog
adjusted packet head via BPF-helper bpf_xdp_adjust_head(). The order of
subtracting orig_data and xdp->data are opposite between the two functions. This
is confusing when reviewing and reading the code.

This patch choose to follow generic-XDP and adjust veth_xdp_rcv_skb().

In veth_xdp_rcv_skb() the skb_mac_header length have been __skb_push()'ed.
Thus, we skip the skb->mac_header adjustments like bpf_prog_run_generic_xdp()
and instead do a skb_reset_mac_header() as skb->data point to Eth header.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/veth.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 953f6d8f8db0..be7b62f57087 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -897,12 +897,13 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	rcu_read_unlock();
 
 	/* check if bpf_xdp_adjust_head was used */
-	off = orig_data - xdp->data;
-	if (off > 0)
-		__skb_push(skb, off);
-	else if (off < 0)
-		__skb_pull(skb, -off);
-
+	off = xdp->data - orig_data;
+	if (off) {
+		if (off > 0)
+			__skb_pull(skb, off);
+		else if (off < 0)
+			__skb_push(skb, -off);
+	}
 	skb_reset_mac_header(skb);
 
 	/* check if bpf_xdp_adjust_tail was used */



