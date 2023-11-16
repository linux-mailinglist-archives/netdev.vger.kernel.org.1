Return-Path: <netdev+bounces-48232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCFA7ED9DC
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 04:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E431C20312
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 03:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59F9567E;
	Thu, 16 Nov 2023 03:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A610D98
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 19:13:32 -0800 (PST)
X-UUID: 49044a8c23d44ba589a67bdfa68980cc-20231116
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:c257b4ec-7f36-45bd-ad1e-91fdc931c136,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.1.32,REQID:c257b4ec-7f36-45bd-ad1e-91fdc931c136,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:5f78ec9,CLOUDID:c62596fc-4a48-46e2-b946-12f04f20af8c,B
	ulkID:231116111328P6JX90GU,BulkQuantity:0,Recheck:0,SF:42|101|66|24|100|17
	|19|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 49044a8c23d44ba589a67bdfa68980cc-20231116
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1545244580; Thu, 16 Nov 2023 11:13:25 +0800
From: heminhong <heminhong@kylinos.cn>
To: petrm@nvidia.com
Cc: heminhong@kylinos.cn,
	netdev@vger.kernel.org,
	stephen@networkplumber.org
Subject: [PATCH v4] iproute2: prevent memory leak
Date: Thu, 16 Nov 2023 11:13:08 +0800
Message-Id: <20231116031308.16519-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <87y1ezwbk8.fsf@nvidia.com>
References: <87y1ezwbk8.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the return value of rtnl_talk() is not less than 0,
'answer' will be allocated. The 'answer' should be free
after using, otherwise it will cause memory leak.

Signed-off-by: heminhong <heminhong@kylinos.cn>
---
 ip/link_gre.c    | 3 ++-
 ip/link_gre6.c   | 3 ++-
 ip/link_ip6tnl.c | 3 ++-
 ip/link_iptnl.c  | 3 ++-
 ip/link_vti.c    | 3 ++-
 ip/link_vti6.c   | 3 ++-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/ip/link_gre.c b/ip/link_gre.c
index 74a5b5e9..6d71864c 100644
--- a/ip/link_gre.c
+++ b/ip/link_gre.c
@@ -76,7 +76,7 @@ static int gre_parse_opt(struct link_util *lu, int argc, char **argv,
 		.i.ifi_family = preferred_family,
 		.i.ifi_index = ifi->ifi_index,
 	};
-	struct nlmsghdr *answer;
+	struct nlmsghdr *answer = NULL;
 	struct rtattr *tb[IFLA_MAX + 1];
 	struct rtattr *linkinfo[IFLA_INFO_MAX+1];
 	struct rtattr *greinfo[IFLA_GRE_MAX + 1];
@@ -113,6 +113,7 @@ static int gre_parse_opt(struct link_util *lu, int argc, char **argv,
 get_failed:
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
+			free(answer);
 			return -1;
 		}
 
diff --git a/ip/link_gre6.c b/ip/link_gre6.c
index b03bd65a..4d1c6574 100644
--- a/ip/link_gre6.c
+++ b/ip/link_gre6.c
@@ -79,7 +79,7 @@ static int gre_parse_opt(struct link_util *lu, int argc, char **argv,
 		.i.ifi_family = preferred_family,
 		.i.ifi_index = ifi->ifi_index,
 	};
-	struct nlmsghdr *answer;
+	struct nlmsghdr *answer = NULL;
 	struct rtattr *tb[IFLA_MAX + 1];
 	struct rtattr *linkinfo[IFLA_INFO_MAX+1];
 	struct rtattr *greinfo[IFLA_GRE_MAX + 1];
@@ -115,6 +115,7 @@ static int gre_parse_opt(struct link_util *lu, int argc, char **argv,
 get_failed:
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
+			free(answer);
 			return -1;
 		}
 
diff --git a/ip/link_ip6tnl.c b/ip/link_ip6tnl.c
index b27d696f..3a30dca9 100644
--- a/ip/link_ip6tnl.c
+++ b/ip/link_ip6tnl.c
@@ -72,7 +72,7 @@ static int ip6tunnel_parse_opt(struct link_util *lu, int argc, char **argv,
 		.i.ifi_family = preferred_family,
 		.i.ifi_index = ifi->ifi_index,
 	};
-	struct nlmsghdr *answer;
+	struct nlmsghdr *answer = NULL;
 	struct rtattr *tb[IFLA_MAX + 1];
 	struct rtattr *linkinfo[IFLA_INFO_MAX+1];
 	struct rtattr *iptuninfo[IFLA_IPTUN_MAX + 1];
@@ -101,6 +101,7 @@ static int ip6tunnel_parse_opt(struct link_util *lu, int argc, char **argv,
 get_failed:
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
+			free(answer);
 			return -1;
 		}
 
diff --git a/ip/link_iptnl.c b/ip/link_iptnl.c
index 1315aebe..879202f7 100644
--- a/ip/link_iptnl.c
+++ b/ip/link_iptnl.c
@@ -73,7 +73,7 @@ static int iptunnel_parse_opt(struct link_util *lu, int argc, char **argv,
 		.i.ifi_family = preferred_family,
 		.i.ifi_index = ifi->ifi_index,
 	};
-	struct nlmsghdr *answer;
+	struct nlmsghdr *answer = NULL;
 	struct rtattr *tb[IFLA_MAX + 1];
 	struct rtattr *linkinfo[IFLA_INFO_MAX+1];
 	struct rtattr *iptuninfo[IFLA_IPTUN_MAX + 1];
@@ -105,6 +105,7 @@ static int iptunnel_parse_opt(struct link_util *lu, int argc, char **argv,
 get_failed:
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
+			free(answer);
 			return -1;
 		}
 
diff --git a/ip/link_vti.c b/ip/link_vti.c
index 50943254..7a95dc02 100644
--- a/ip/link_vti.c
+++ b/ip/link_vti.c
@@ -48,7 +48,7 @@ static int vti_parse_opt(struct link_util *lu, int argc, char **argv,
 		.i.ifi_family = preferred_family,
 		.i.ifi_index = ifi->ifi_index,
 	};
-	struct nlmsghdr *answer;
+	struct nlmsghdr *answer = NULL;
 	struct rtattr *tb[IFLA_MAX + 1];
 	struct rtattr *linkinfo[IFLA_INFO_MAX+1];
 	struct rtattr *vtiinfo[IFLA_VTI_MAX + 1];
@@ -69,6 +69,7 @@ static int vti_parse_opt(struct link_util *lu, int argc, char **argv,
 get_failed:
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
+			free(answer);
 			return -1;
 		}
 
diff --git a/ip/link_vti6.c b/ip/link_vti6.c
index 5764221e..aaf701d3 100644
--- a/ip/link_vti6.c
+++ b/ip/link_vti6.c
@@ -50,7 +50,7 @@ static int vti6_parse_opt(struct link_util *lu, int argc, char **argv,
 		.i.ifi_family = preferred_family,
 		.i.ifi_index = ifi->ifi_index,
 	};
-	struct nlmsghdr *answer;
+	struct nlmsghdr *answer = NULL;
 	struct rtattr *tb[IFLA_MAX + 1];
 	struct rtattr *linkinfo[IFLA_INFO_MAX+1];
 	struct rtattr *vtiinfo[IFLA_VTI_MAX + 1];
@@ -71,6 +71,7 @@ static int vti6_parse_opt(struct link_util *lu, int argc, char **argv,
 get_failed:
 			fprintf(stderr,
 				"Failed to get existing tunnel info.\n");
+			free(answer);
 			return -1;
 		}
 
-- 
2.25.1


