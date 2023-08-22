Return-Path: <netdev+bounces-29743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FF27848E8
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C241328119C
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0E11DA43;
	Tue, 22 Aug 2023 17:59:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8171D307
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 17:59:25 +0000 (UTC)
Received: from [192.168.42.3] (194-45-78-10.static.kviknet.net [194.45.78.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 8D89DC433C7;
	Tue, 22 Aug 2023 17:59:22 +0000 (UTC)
Subject: [PATCH net-next RFC v1 3/4] veth: lift skb_head_is_locked restriction
 for SKB based XDP
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, edumazet@google.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, lorenzo@kernel.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, mtahhan@redhat.com,
 huangjie.albert@bytedance.com, Yunsheng Lin <linyunsheng@huawei.com>,
 Liang Chen <liangchen.linux@gmail.com>
Date: Tue, 22 Aug 2023 19:59:20 +0200
Message-ID: <169272716036.1975370.9471039093816465682.stgit@firesoul>
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

As veth_xdp_rcv_skb() no-longer steals SKB data and no-longer uses
XDP native xdp_do_redirect(), then it is possible to handle
more types of SKBs with other memory types.

Replacing skb_head_is_locked() with skb_cloned().

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/veth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 192547035194..8e117cc44fda 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -720,7 +720,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	struct sk_buff *skb = *pskb;
 	u32 frame_sz;
 
-	if (skb_shared(skb) || skb_head_is_locked(skb) ||
+	if (skb_shared(skb) || skb_cloned(skb) ||
 	    skb_shinfo(skb)->nr_frags ||
 	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
 		u32 size, len, max_head_size, off;



