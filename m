Return-Path: <netdev+bounces-53521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA7080382C
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34741F211D5
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 15:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2C628E3A;
	Mon,  4 Dec 2023 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adHKSs53"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F21428E38
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 15:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD40C433C8;
	Mon,  4 Dec 2023 15:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701702122;
	bh=2hXL1swgJPfbfY+P/f66gxPBpIw8NLnTbHKbznWtPVE=;
	h=From:To:Cc:Subject:Date:From;
	b=adHKSs53icJxAvzFZUBUZOjeXKoKpLcRQKg4/GmdpaHA/sHTsuBiFI3QTLbII8d4P
	 Uk+dl247pOvT8tVcN5E2yB68+Gn51qSbkWlzAIhkodAuPnEMNUzrFiU5GLJVgbXMNv
	 YClu/RAL43NmTPMYYHGSw5J4Zk1wzcmLSD8sd7OmJc0cvHkcFi9jXwdy/T+Skc7Ryb
	 kMEacADXr6Sb3SPWaeZ1wdwvbvEWvSTFqk4BKvMxXkknt3DgyeZfhEop7e9BEpFJAc
	 sLq6IkuoeC4PyWgG2V77W1PyBsj4DIyu/ZA9m0OkT5Pqf/9buDuUwWgOMFrEvA65uJ
	 O67yVGDHswm+g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lorenzo.bianconi@redhat.com,
	linyunsheng@huawei.com,
	alexander.duyck@gmail.com,
	aleksander.lobakin@intel.com,
	liangchen.linux@gmail.com
Subject: [PATCH net] net: veth: fix packet segmentation in veth_convert_skb_to_xdp_buff
Date: Mon,  4 Dec 2023 16:01:48 +0100
Message-ID: <eddfe549e7e626870071930964ac3c38a1dc8068.1701702000.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on the previous allocated packet, page_offset can be not null
in veth_convert_skb_to_xdp_buff routine.
Take into account page fragment offset during the skb paged area copy
in veth_convert_skb_to_xdp_buff().

Fixes: 2d0de67da51a ("net: veth: use newly added page pool API for veth with xdp")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/veth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 57efb3454c57..977861c46b1f 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -790,7 +790,8 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 
 			skb_add_rx_frag(nskb, i, page, page_offset, size,
 					truesize);
-			if (skb_copy_bits(skb, off, page_address(page),
+			if (skb_copy_bits(skb, off,
+					  page_address(page) + page_offset,
 					  size)) {
 				consume_skb(nskb);
 				goto drop;
-- 
2.43.0


