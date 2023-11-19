Return-Path: <netdev+bounces-49023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3843E7F06EC
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 15:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBDD1F22724
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 14:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FF510A13;
	Sun, 19 Nov 2023 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9BAF2;
	Sun, 19 Nov 2023 06:39:22 -0800 (PST)
X-UUID: 3b9dc7fb7fcb49fb901ac7174b03b4ad-20231119
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:3ba2caa6-653b-4cea-bb62-e699b52e651f,IP:5,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-9
X-CID-INFO: VERSION:1.1.32,REQID:3ba2caa6-653b-4cea-bb62-e699b52e651f,IP:5,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-9
X-CID-META: VersionHash:5f78ec9,CLOUDID:255e8f95-10ce-4e4b-85c2-c9b5229ff92b,B
	ulkID:231119223919E33CYRYY,BulkQuantity:0,Recheck:0,SF:66|24|17|19|45|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 3b9dc7fb7fcb49fb901ac7174b03b4ad-20231119
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 238283989; Sun, 19 Nov 2023 22:39:16 +0800
From: Kunwu Chan <chentao@kylinos.cn>
To: edumazet@google.com
Cc: chentao@kylinos.cn,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	kunwu.chan@hotmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: [PATCH v2] ipv6: Correct/silence an endian warning in ip6_multipath_l3_keys
Date: Sun, 19 Nov 2023 22:39:13 +0800
Message-Id: <20231119143913.654381-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANn89iKJ=Na2hWGv9Dau36Ojivt-icnd1BRgke033Z=a+E9Wcw@mail.gmail.com>
References: <CANn89iKJ=Na2hWGv9Dau36Ojivt-icnd1BRgke033Z=a+E9Wcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

net/ipv6/route.c:2332:39: warning: incorrect type in assignment (different base types)
net/ipv6/route.c:2332:39:    expected unsigned int [usertype] flow_label
net/ipv6/route.c:2332:39:    got restricted __be32

Fixes: fa1be7e01ea8 ("ipv6: omit traffic class when calculating flow hash")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 net/ipv6/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b132feae3393..1fdae8d71339 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2329,7 +2329,7 @@ static void ip6_multipath_l3_keys(const struct sk_buff *skb,
 	} else {
 		keys->addrs.v6addrs.src = key_iph->saddr;
 		keys->addrs.v6addrs.dst = key_iph->daddr;
-		keys->tags.flow_label = ip6_flowlabel(key_iph);
+		keys->tags.flow_label = (__force u32)ip6_flowlabel(key_iph);
 		keys->basic.ip_proto = key_iph->nexthdr;
 	}
 }
-- 
2.34.1


