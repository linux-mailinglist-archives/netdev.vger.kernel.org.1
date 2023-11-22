Return-Path: <netdev+bounces-49935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495177F3EC7
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 08:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C129FB210CC
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 07:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A2F18629;
	Wed, 22 Nov 2023 07:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA7190;
	Tue, 21 Nov 2023 23:19:33 -0800 (PST)
X-UUID: 3cb444fcdc14419ba30ed73f5a5b594e-20231122
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:690b7766-bafe-4e14-9d4e-eccc00a34c8e,IP:5,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:10
X-CID-INFO: VERSION:1.1.32,REQID:690b7766-bafe-4e14-9d4e-eccc00a34c8e,IP:5,URL
	:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-META: VersionHash:5f78ec9,CLOUDID:5080ad95-10ce-4e4b-85c2-c9b5229ff92b,B
	ulkID:231122151928U26QUJM1,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 3cb444fcdc14419ba30ed73f5a5b594e-20231122
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1022259079; Wed, 22 Nov 2023 15:19:27 +0800
From: Kunwu Chan <chentao@kylinos.cn>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jkbs@redhat.com
Cc: kunwu.chan@hotmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH v3] ipv6: Correct/silence an endian warning in ip6_multipath_l3_keys
Date: Wed, 22 Nov 2023 15:19:24 +0800
Message-Id: <20231122071924.8302-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
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

Fixes: 23aebdacb05d ("ipv6: Compute multipath hash for ICMP errors from offending packet")
Suggested-by: Eric Dumazet <edumazet@google.com>
Suggested-by: Paolo Abeni <pabeni@redhat.com>
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


