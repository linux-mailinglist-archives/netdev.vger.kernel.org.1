Return-Path: <netdev+bounces-48589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566E57EEEA8
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860FE1C20836
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B863312E6F;
	Fri, 17 Nov 2023 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BB31BF4;
	Fri, 17 Nov 2023 01:31:22 -0800 (PST)
X-UUID: 741c89e8083b44548c3e8f5979b47101-20231117
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:1dbef51b-9855-4ee6-a412-64bef59f35a1,IP:5,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:15
X-CID-INFO: VERSION:1.1.32,REQID:1dbef51b-9855-4ee6-a412-64bef59f35a1,IP:5,URL
	:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-META: VersionHash:5f78ec9,CLOUDID:2ca5c472-1bd3-4f48-b671-ada88705968c,B
	ulkID:231117172305AN6C5S4D,BulkQuantity:1,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 741c89e8083b44548c3e8f5979b47101-20231117
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 842865564; Fri, 17 Nov 2023 17:31:14 +0800
From: Kunwu Chan <chentao@kylinos.cn>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kunwu.chan@hotmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] net: sched: Fix an endian bug in tcf_proto_create
Date: Fri, 17 Nov 2023 17:31:10 +0800
Message-Id: <20231117093110.1842011-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

net/sched/cls_api.c:390:22: warning: incorrect type in assignment (different base types)
net/sched/cls_api.c:390:22:    expected restricted __be16 [usertype] protocol
net/sched/cls_api.c:390:22:    got unsigned int [usertype] protocol

Fixes: 33a48927c193 ("sched: push TC filter protocol creation into a separate function")

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 net/sched/cls_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 1976bd163986..f73f39f61f66 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -387,7 +387,7 @@ static struct tcf_proto *tcf_proto_create(const char *kind, u32 protocol,
 		goto errout;
 	}
 	tp->classify = tp->ops->classify;
-	tp->protocol = protocol;
+	tp->protocol = cpu_to_be16(protocol);
 	tp->prio = prio;
 	tp->chain = chain;
 	spin_lock_init(&tp->lock);
-- 
2.34.1


