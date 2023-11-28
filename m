Return-Path: <netdev+bounces-51531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0458D7FB035
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 03:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2618281BE6
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 02:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AE953AB;
	Tue, 28 Nov 2023 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from 2.mo545.mail-out.ovh.net (2.mo545.mail-out.ovh.net [178.33.110.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F6E192
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 18:50:02 -0800 (PST)
Received: from ex4.mail.ovh.net (unknown [10.111.208.147])
	by mo545.mail-out.ovh.net (Postfix) with ESMTPS id E601624BB4;
	Tue, 28 Nov 2023 02:34:47 +0000 (UTC)
Received: from bf-dev-miffies.localdomain (92.184.96.55) by
 DAG10EX1.indiv4.local (172.16.2.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 28 Nov 2023 03:31:25 +0100
From: Quentin Deslandes <qde@naccy.de>
To: <netdev@vger.kernel.org>
CC: David Ahern <dsahern@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>,
	Quentin Deslandes <qde@naccy.de>
Subject: [PATCH 1/3] ss: prevent "Process" column from being printed unless requested
Date: Mon, 27 Nov 2023 18:30:56 -0800
Message-ID: <20231128023058.53546-2-qde@naccy.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128023058.53546-1-qde@naccy.de>
References: <20231128023058.53546-1-qde@naccy.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS12.indiv4.local (172.16.1.12) To DAG10EX1.indiv4.local
 (172.16.2.91)
X-Ovh-Tracer-Id: 5892960114290978472
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudeivddggeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomhepsfhuvghnthhinhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrthhtvghrnhepudeludfgieeltedvleeiueejtdettdevtdfgteetveefjefhffekueejteffgfdunecukfhppeduvdejrddtrddtrddupdelvddrudekgedrleeirdehheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehquggvsehnrggttgihrdguvgeqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdgushgrhhgvrhhnsehgmhgrihhlrdgtohhmpdhmrghrthhinhdrlhgruheskhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehgeehpdhmohguvgepshhmthhpohhuth

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


