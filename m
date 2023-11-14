Return-Path: <netdev+bounces-47620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD37B7EAB64
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 09:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4711F2290B
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 08:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6DE134B7;
	Tue, 14 Nov 2023 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D13B13ACF
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 08:13:37 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74A6181
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 00:13:34 -0800 (PST)
X-UUID: 26c337aefe0d40acbd033bd6813c4d1c-20231114
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:c5bea7b8-ebdd-4e8a-b14a-0091a3466db8,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.32,REQID:c5bea7b8-ebdd-4e8a-b14a-0091a3466db8,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:3bf30960-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:231114161324042340J6,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 26c337aefe0d40acbd033bd6813c4d1c-20231114
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1309422577; Tue, 14 Nov 2023 16:13:21 +0800
From: heminhong <heminhong@kylinos.cn>
To: stephen@networkplumber.org,
	netdev@vger.kernel.org
Cc: heminhong <heminhong@kylinos.cn>
Subject: [PATCH] iproute2: prevent memory leak on error return
Date: Tue, 14 Nov 2023 16:13:07 +0800
Message-Id: <20231114081307.36926-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When rtnl_statsdump_req_filter() or rtnl_dump_filter() failed to process,
just return will cause memory leak.

Signed-off-by: heminhong <heminhong@kylinos.cn>
---
 ip/iplink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ip/iplink.c b/ip/iplink.c
index 9a548dd3..c7e5021c 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -1722,11 +1722,13 @@ static int iplink_afstats(int argc, char **argv)
 	if (rtnl_statsdump_req_filter(&rth, AF_UNSPEC, filt_mask,
 				      NULL, NULL) < 0) {
 		perror("Cannont send dump request");
+		delete_json_obj();
 		return 1;
 	}
 
 	if (rtnl_dump_filter(&rth, print_af_stats, &ctx) < 0) {
 		fprintf(stderr, "Dump terminated\n");
+		delete_json_obj();
 		return 1;
 	}
 
-- 
2.25.1


