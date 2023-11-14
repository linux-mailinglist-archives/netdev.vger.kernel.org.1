Return-Path: <netdev+bounces-47637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AB17EACF3
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 10:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF9C281120
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 09:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423D713FE4;
	Tue, 14 Nov 2023 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A92168A4
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 09:24:33 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA664131
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 01:24:31 -0800 (PST)
X-UUID: e302d29e1b324cbc8bfd64536ba6843f-20231114
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:0a7f7e13-d856-4602-bf5a-760c1f80a367,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.32,REQID:0a7f7e13-d856-4602-bf5a-760c1f80a367,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:375283fc-4a48-46e2-b946-12f04f20af8c,B
	ulkID:231114172423TALI5MUC,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: e302d29e1b324cbc8bfd64536ba6843f-20231114
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1750452863; Tue, 14 Nov 2023 17:24:21 +0800
From: heminhong <heminhong@kylinos.cn>
To: stephen@networkplumber.org,
	netdev@vger.kernel.org
Cc: heminhong <heminhong@kylinos.cn>
Subject: [PATCH] iproute2: prevent memory leak
Date: Tue, 14 Nov 2023 17:24:10 +0800
Message-Id: <20231114092410.43635-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'rtnl_talk' allocated memory for 'answer',
in the exception handling branch, memory should be free,
otherwise it will cause memory leak.

Signed-off-by: heminhong <heminhong@kylinos.cn>
---
 ip/link_gre.c    | 4 ++++
 ip/link_gre6.c   | 4 ++++
 ip/link_ip6tnl.c | 4 ++++
 ip/link_iptnl.c  | 4 ++++
 ip/link_vti.c    | 4 ++++
 ip/link_vti6.c   | 4 ++++
 6 files changed, 24 insertions(+)

diff --git a/ip/link_gre.c b/ip/link_gre.c
index 74a5b5e9..b1c49ace 100644
--- a/ip/link_gre.c
+++ b/ip/link_gre.c
@@ -111,6 +111,10 @@ static int gre_parse_opt(struct link_util *lu, int argc, char **argv,
 
 		if (rtnl_talk(&rth, &req.n, &answer) < 0) {
 get_failed:
+			if (NULL != answer)
+			{
+				free(answer);
+			}
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
 			return -1;
diff --git a/ip/link_gre6.c b/ip/link_gre6.c
index b03bd65a..64302d63 100644
--- a/ip/link_gre6.c
+++ b/ip/link_gre6.c
@@ -113,6 +113,10 @@ static int gre_parse_opt(struct link_util *lu, int argc, char **argv,
 
 		if (rtnl_talk(&rth, &req.n, &answer) < 0) {
 get_failed:
+			if (NULL != answer)
+			{
+				free(answer);
+			}
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
 			return -1;
diff --git a/ip/link_ip6tnl.c b/ip/link_ip6tnl.c
index b27d696f..16ed6e0d 100644
--- a/ip/link_ip6tnl.c
+++ b/ip/link_ip6tnl.c
@@ -99,6 +99,10 @@ static int ip6tunnel_parse_opt(struct link_util *lu, int argc, char **argv,
 
 		if (rtnl_talk(&rth, &req.n, &answer) < 0) {
 get_failed:
+			if (NULL != answer)
+			{
+				free(answer);
+			}
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
 			return -1;
diff --git a/ip/link_iptnl.c b/ip/link_iptnl.c
index 1315aebe..27326382 100644
--- a/ip/link_iptnl.c
+++ b/ip/link_iptnl.c
@@ -103,6 +103,10 @@ static int iptunnel_parse_opt(struct link_util *lu, int argc, char **argv,
 
 		if (rtnl_talk(&rth, &req.n, &answer) < 0) {
 get_failed:
+			if (NULL != answer)
+			{
+				free(answer);
+			}
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
 			return -1;
diff --git a/ip/link_vti.c b/ip/link_vti.c
index 50943254..92d5c5ad 100644
--- a/ip/link_vti.c
+++ b/ip/link_vti.c
@@ -67,6 +67,10 @@ static int vti_parse_opt(struct link_util *lu, int argc, char **argv,
 
 		if (rtnl_talk(&rth, &req.n, &answer) < 0) {
 get_failed:
+			if (NULL != answer)
+			{
+				free(answer);
+			}
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
 			return -1;
diff --git a/ip/link_vti6.c b/ip/link_vti6.c
index 5764221e..b50158fe 100644
--- a/ip/link_vti6.c
+++ b/ip/link_vti6.c
@@ -69,6 +69,10 @@ static int vti6_parse_opt(struct link_util *lu, int argc, char **argv,
 
 		if (rtnl_talk(&rth, &req.n, &answer) < 0) {
 get_failed:
+			if (NULL != answer)
+			{
+				free(answer);
+			}
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
 			return -1;
-- 
2.25.1


