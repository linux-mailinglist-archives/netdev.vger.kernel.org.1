Return-Path: <netdev+bounces-29744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BE27848E9
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3196C280DA2
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8EA1DA5A;
	Tue, 22 Aug 2023 17:59:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9911D307
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 17:59:31 +0000 (UTC)
Received: from [192.168.42.3] (194-45-78-10.static.kviknet.net [194.45.78.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 75C82C433C7;
	Tue, 22 Aug 2023 17:59:28 +0000 (UTC)
Subject: [PATCH net-next RFC v1 4/4] veth: when XDP is loaded increase
 needed_headroom
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, edumazet@google.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, lorenzo@kernel.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, mtahhan@redhat.com,
 huangjie.albert@bytedance.com, Yunsheng Lin <linyunsheng@huawei.com>,
 Liang Chen <liangchen.linux@gmail.com>
Date: Tue, 22 Aug 2023 19:59:26 +0200
Message-ID: <169272716651.1975370.10514711233878278884.stgit@firesoul>
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

When sending (sendmsg) SKBs out an veth device, the SKB headroom is too small
to satisfy XDP on the receiving veth peer device.

For AF_XDP (normal non-zero-copy) it is worth noticing that xsk_build_skb()
adjust headroom according to dev->needed_headroom. Other parts of the kernel
also take this into account (see macro LL_RESERVED_SPACE).

This solves the XDP_PACKET_HEADROOM check in veth_convert_skb_to_xdp_buff().

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/veth.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 8e117cc44fda..3630e9124071 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1649,6 +1649,7 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		if (!old_prog) {
 			peer->hw_features &= ~NETIF_F_GSO_SOFTWARE;
 			peer->max_mtu = max_mtu;
+			veth_set_rx_headroom(dev, XDP_PACKET_HEADROOM);
 		}
 
 		xdp_features_set_redirect_target(peer, true);
@@ -1666,6 +1667,7 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 				peer->hw_features |= NETIF_F_GSO_SOFTWARE;
 				peer->max_mtu = ETH_MAX_MTU;
 			}
+			veth_set_rx_headroom(dev, -1);
 		}
 		bpf_prog_put(old_prog);
 	}



