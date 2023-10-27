Return-Path: <netdev+bounces-44738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BE27D97E5
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88AEDB21273
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2001A703;
	Fri, 27 Oct 2023 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75C18C10
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:24:24 +0000 (UTC)
Received: from smtpout5.r2.mail-out.ovh.net (smtpout5.r2.mail-out.ovh.net [54.36.141.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C72FA
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:24:23 -0700 (PDT)
Received: from ex4.mail.ovh.net (unknown [10.108.4.173])
	by mo511.mail-out.ovh.net (Postfix) with ESMTPS id 3C894283FB;
	Fri, 27 Oct 2023 12:15:58 +0000 (UTC)
Received: from localhost.localdomain (93.21.160.242) by DAG10EX1.indiv4.local
 (172.16.2.91) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.34; Fri, 27 Oct
 2023 14:12:37 +0200
From: Quentin Deslandes <qde@naccy.de>
To: <netdev@vger.kernel.org>
CC: David Ahern <dsahern@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>,
	Quentin Deslandes <qde@naccy.de>
Subject: [RFC PATCH 1/3] ss: prevent "Process" column from being printed unless requested
Date: Fri, 27 Oct 2023 14:11:53 +0200
Message-ID: <20231027121155.1244308-2-qde@naccy.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027121155.1244308-1-qde@naccy.de>
References: <20231027121155.1244308-1-qde@naccy.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [93.21.160.242]
X-ClientProxiedBy: CAS8.indiv4.local (172.16.1.8) To DAG10EX1.indiv4.local
 (172.16.2.91)
X-Ovh-Tracer-Id: 12249228039132016296
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpefsuhgvnhhtihhnucffvghslhgrnhguvghsuceoqhguvgesnhgrtggthidruggvqeenucggtffrrghtthgvrhhnpeduledugfeileetvdelieeujedttedtvedtgfetteevfeejhfffkeeujeetfffgudenucfkphepuddvjedrtddrtddruddpleefrddvuddrudeitddrvdegvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehquggvsehnrggttgihrdguvgeqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdgushgrhhgvrhhnsehgmhgrihhlrdgtohhmpdhmrghrthhinhdrlhgruheskhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehuddupdhmohguvgepshhmthhpohhuth

Commit 5883c6eba517 ("ss: show header for --processes/-p") added
"Process" to the list of columns printed by ss. However, the "Process"
header is now printed even if --processes/-p is not used.

This change aims to fix this by moving the COL_PROC column ID to the same
index as the corresponding column structure in the columns array, and
enabling it if --processes/-p is used.

Signed-off-by: Quentin Deslandes <qde@naccy.de>
---
 misc/ss.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/misc/ss.c b/misc/ss.c
index 7e67dbe4..e35a16e5 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -100,8 +100,8 @@ enum col_id {
 	COL_SERV,
 	COL_RADDR,
 	COL_RSERV,
-	COL_EXT,
 	COL_PROC,
+	COL_EXT,
 	COL_MAX
 };
 
@@ -5786,6 +5786,9 @@ int main(int argc, char *argv[])
 	if (ssfilter_parse(&current_filter.f, argc, argv, filter_fp))
 		usage();
 
+	if (!show_processes)
+		columns[COL_PROC].disabled = 1;
+
 	if (!(current_filter.dbs & (current_filter.dbs - 1)))
 		columns[COL_NETID].disabled = 1;
 
-- 
2.41.0


