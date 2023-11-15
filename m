Return-Path: <netdev+bounces-47871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A687EBB3B
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 03:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F25628139F
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 02:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2284B644;
	Wed, 15 Nov 2023 02:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA6647
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 02:37:25 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97994C8
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 18:37:23 -0800 (PST)
X-UUID: 429ab363acfa40eb9c3de3b20ff86178-20231115
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:5431c1d9-948b-498f-bd0e-de8e823d5942,IP:5,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-INFO: VERSION:1.1.32,REQID:5431c1d9-948b-498f-bd0e-de8e823d5942,IP:5,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-10
X-CID-META: VersionHash:5f78ec9,CLOUDID:60b71160-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:231115103715UUNPGVFJ,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 429ab363acfa40eb9c3de3b20ff86178-20231115
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1045942641; Wed, 15 Nov 2023 10:37:14 +0800
From: heminhong <heminhong@kylinos.cn>
To: stephen@networkplumber.org
Cc: heminhong@kylinos.cn,
	netdev@vger.kernel.org
Subject: [PATCH v2] iproute2: prevent memory leak
Date: Wed, 15 Nov 2023 10:37:03 +0800
Message-Id: <20231115023703.15417-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231114163617.25a7990f@hermes.local>
References: <20231114163617.25a7990f@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the return value of rtnl_talk() is less than 0, 'answer' does not
need to release. When the return value of rtnl_talk() is greater than
or equal to 0, 'answer' will be allocated, if subsequent processing fails,
the memory should be free, otherwise it will cause memory leak.

Signed-off-by: heminhong <heminhong@kylinos.cn>
---
 ip/link_gre.c    | 2 ++
 ip/link_gre6.c   | 2 ++
 ip/link_ip6tnl.c | 2 ++
 ip/link_iptnl.c  | 2 ++
 ip/link_vti.c    | 2 ++
 ip/link_vti6.c   | 2 ++
 6 files changed, 12 insertions(+)

diff --git a/ip/link_gre.c b/ip/link_gre.c
index 74a5b5e9..b86ec22d 100644
--- a/ip/link_gre.c
+++ b/ip/link_gre.c
@@ -111,6 +111,8 @@ static int gre_parse_opt(struct link_util *lu, int argc, char **argv,
 
 		if (rtnl_talk(&rth, &req.n, &answer) < 0) {
 get_failed:
+			if (answer)
+				free(answer);
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
 			return -1;
diff --git a/ip/link_gre6.c b/ip/link_gre6.c
index b03bd65a..72ce148a 100644
--- a/ip/link_gre6.c
+++ b/ip/link_gre6.c
@@ -113,6 +113,8 @@ static int gre_parse_opt(struct link_util *lu, int argc, char **argv,
 
 		if (rtnl_talk(&rth, &req.n, &answer) < 0) {
 get_failed:
+			if (answer)
+				free(answer);
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
 			return -1;
diff --git a/ip/link_ip6tnl.c b/ip/link_ip6tnl.c
index b27d696f..cffa8345 100644
--- a/ip/link_ip6tnl.c
+++ b/ip/link_ip6tnl.c
@@ -99,6 +99,8 @@ static int ip6tunnel_parse_opt(struct link_util *lu, int argc, char **argv,
 
 		if (rtnl_talk(&rth, &req.n, &answer) < 0) {
 get_failed:
+			if (answer)
+				free(answer);
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
 			return -1;
diff --git a/ip/link_iptnl.c b/ip/link_iptnl.c
index 1315aebe..b4ffed25 100644
--- a/ip/link_iptnl.c
+++ b/ip/link_iptnl.c
@@ -103,6 +103,8 @@ static int iptunnel_parse_opt(struct link_util *lu, int argc, char **argv,
 
 		if (rtnl_talk(&rth, &req.n, &answer) < 0) {
 get_failed:
+			if (answer)
+				free(answer);
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
 			return -1;
diff --git a/ip/link_vti.c b/ip/link_vti.c
index 50943254..3e4fd95e 100644
--- a/ip/link_vti.c
+++ b/ip/link_vti.c
@@ -67,6 +67,8 @@ static int vti_parse_opt(struct link_util *lu, int argc, char **argv,
 
 		if (rtnl_talk(&rth, &req.n, &answer) < 0) {
 get_failed:
+			if (answer)
+				free(answer);
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
 			return -1;
diff --git a/ip/link_vti6.c b/ip/link_vti6.c
index 5764221e..e70f5612 100644
--- a/ip/link_vti6.c
+++ b/ip/link_vti6.c
@@ -69,6 +69,8 @@ static int vti6_parse_opt(struct link_util *lu, int argc, char **argv,
 
 		if (rtnl_talk(&rth, &req.n, &answer) < 0) {
 get_failed:
+			if (answer)
+				free(answer);
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
 			return -1;
-- 
2.25.1


