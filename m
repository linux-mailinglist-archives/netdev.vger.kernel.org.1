Return-Path: <netdev+bounces-47915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C178E7EBE4A
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 08:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CA4DB20AED
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 07:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54044416;
	Wed, 15 Nov 2023 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE8D4683
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 07:57:22 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C5ADF
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 23:57:20 -0800 (PST)
X-UUID: ce9a1f6715334c44a6b4085671728ffd-20231115
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:243d9842-c331-4b9d-9b26-682e620c9a3c,IP:5,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-INFO: VERSION:1.1.32,REQID:243d9842-c331-4b9d-9b26-682e620c9a3c,IP:5,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-10
X-CID-META: VersionHash:5f78ec9,CLOUDID:26deac72-1bd3-4f48-b671-ada88705968c,B
	ulkID:231115155707MSYSYJBK,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: ce9a1f6715334c44a6b4085671728ffd-20231115
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1227758986; Wed, 15 Nov 2023 15:57:05 +0800
From: heminhong <heminhong@kylinos.cn>
To: stephen@networkplumber.org
Cc: heminhong@kylinos.cn,
	netdev@vger.kernel.org
Subject: [PATCH v3] iproute2: prevent memory leak
Date: Wed, 15 Nov 2023 15:56:50 +0800
Message-Id: <20231115075650.33219-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231114193350.475050ae@hermes.local>
References: <20231114193350.475050ae@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the return value of rtnl_talk() is greater than
or equal to 0, 'answer' will be allocated.
The 'answer' should be free after using,
otherwise it will cause memory leak.

Signed-off-by: heminhong <heminhong@kylinos.cn>
---
 ip/link_gre.c    | 1 +
 ip/link_gre6.c   | 1 +
 ip/link_ip6tnl.c | 1 +
 ip/link_iptnl.c  | 1 +
 ip/link_vti.c    | 1 +
 ip/link_vti6.c   | 1 +
 6 files changed, 6 insertions(+)

diff --git a/ip/link_gre.c b/ip/link_gre.c
index 74a5b5e9..3d3fcbae 100644
--- a/ip/link_gre.c
+++ b/ip/link_gre.c
@@ -113,6 +113,7 @@ static int gre_parse_opt(struct link_util *lu, int argc, char **argv,
 get_failed:
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
+			free(answer);
 			return -1;
 		}
 
diff --git a/ip/link_gre6.c b/ip/link_gre6.c
index b03bd65a..d74472d2 100644
--- a/ip/link_gre6.c
+++ b/ip/link_gre6.c
@@ -115,6 +115,7 @@ static int gre_parse_opt(struct link_util *lu, int argc, char **argv,
 get_failed:
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
+			free(answer);
 			return -1;
 		}
 
diff --git a/ip/link_ip6tnl.c b/ip/link_ip6tnl.c
index b27d696f..8498b726 100644
--- a/ip/link_ip6tnl.c
+++ b/ip/link_ip6tnl.c
@@ -101,6 +101,7 @@ static int ip6tunnel_parse_opt(struct link_util *lu, int argc, char **argv,
 get_failed:
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
+			free(answer);
 			return -1;
 		}
 
diff --git a/ip/link_iptnl.c b/ip/link_iptnl.c
index 1315aebe..2ee4011d 100644
--- a/ip/link_iptnl.c
+++ b/ip/link_iptnl.c
@@ -105,6 +105,7 @@ static int iptunnel_parse_opt(struct link_util *lu, int argc, char **argv,
 get_failed:
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
+			free(answer);
 			return -1;
 		}
 
diff --git a/ip/link_vti.c b/ip/link_vti.c
index 50943254..dbbfcb2b 100644
--- a/ip/link_vti.c
+++ b/ip/link_vti.c
@@ -69,6 +69,7 @@ static int vti_parse_opt(struct link_util *lu, int argc, char **argv,
 get_failed:
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
+			free(answer);
 			return -1;
 		}
 
diff --git a/ip/link_vti6.c b/ip/link_vti6.c
index 5764221e..096759e6 100644
--- a/ip/link_vti6.c
+++ b/ip/link_vti6.c
@@ -71,6 +71,7 @@ static int vti6_parse_opt(struct link_util *lu, int argc, char **argv,
 get_failed:
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
+			free(answer);
 			return -1;
 		}
 
-- 
2.25.1


