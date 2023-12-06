Return-Path: <netdev+bounces-54391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 305DB806E1B
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 12:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626401C20986
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D3431A90;
	Wed,  6 Dec 2023 11:36:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 1087 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Dec 2023 03:36:21 PST
Received: from 5.mo619.mail-out.ovh.net (5.mo619.mail-out.ovh.net [46.105.40.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5992D3
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 03:36:21 -0800 (PST)
Received: from ex4.mail.ovh.net (unknown [10.109.146.73])
	by mo619.mail-out.ovh.net (Postfix) with ESMTPS id 0360123197;
	Wed,  6 Dec 2023 11:18:12 +0000 (UTC)
Received: from bf-dev-miffies.localdomain (93.21.160.242) by
 DAG10EX1.indiv4.local (172.16.2.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 12:14:52 +0100
From: Quentin Deslandes <qde@naccy.de>
To: <netdev@vger.kernel.org>
CC: David Ahern <dsahern@gmail.com>, Quentin Deslandes <qde@naccy.de>
Subject: [PATCH] ss: prevent "Process" column from being printed unless requested
Date: Wed, 6 Dec 2023 12:14:44 +0100
Message-ID: <20231206111444.191173-1-qde@naccy.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS8.indiv4.local (172.16.1.8) To DAG10EX1.indiv4.local
 (172.16.2.91)
X-Ovh-Tracer-Id: 6374000850996686527
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudektddgvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfgtihesthekredtredttdenucfhrhhomhepsfhuvghnthhinhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrthhtvghrnhepfeduteevveeluedvvedtieegleefveetjeeukeeigefgtdekudeuheduudegfeefnecukfhppeduvdejrddtrddtrddupdelfedrvddurdduiedtrddvgedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoqhguvgesnhgrtggthidruggvqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpughsrghhvghrnhesghhmrghilhdrtghomhdpoffvtefjohhsthepmhhoieduledpmhhouggvpehsmhhtphhouhht

Commit 5883c6eba517 ("ss: show header for --processes/-p") added
"Process" to the list of columns printed by ss. However, the "Process"
header is now printed even if --processes/-p is not used.

This change aims to fix this by moving the COL_PROC column ID to the same
index as the corresponding column structure in the columns array, and
enabling it if --processes/-p is used.

Fixes: 5883c6eba517 ("ss: show header for --processes/-p")
Signed-off-by: Quentin Deslandes <qde@naccy.de>
---
 misc/ss.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/misc/ss.c b/misc/ss.c
index 9438382b..09dc1f37 100644
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
 
@@ -5795,6 +5795,9 @@ int main(int argc, char *argv[])
 	if (ssfilter_parse(&current_filter.f, argc, argv, filter_fp))
 		usage();
 
+	if (!show_processes)
+		columns[COL_PROC].disabled = 1;
+
 	if (!(current_filter.dbs & (current_filter.dbs - 1)))
 		columns[COL_NETID].disabled = 1;
 
-- 
2.43.0


