Return-Path: <netdev+bounces-30395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF0F7871DB
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4B01C20EBF
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 14:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346A414ABC;
	Thu, 24 Aug 2023 14:36:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD83214282;
	Thu, 24 Aug 2023 14:36:34 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB1A1BC5;
	Thu, 24 Aug 2023 07:36:16 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RWltT19C4zJrdj;
	Thu, 24 Aug 2023 22:33:05 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 24 Aug
 2023 22:36:10 +0800
From: Liu Jian <liujian56@huawei.com>
To: <john.fastabend@gmail.com>, <jakub@cloudflare.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <liujian56@huawei.com>
Subject: [PATCH bpf-next v3 6/7] selftests/bpf: add tests for verdict skmsg to itself
Date: Thu, 24 Aug 2023 22:39:58 +0800
Message-ID: <20230824143959.1134019-7-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824143959.1134019-1-liujian56@huawei.com>
References: <20230824143959.1134019-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add tests for verdict skmsg to itself in sockmap_basic.c

Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 32 +++++++++++++------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 1a29e76fe29f..1fcfa30720c6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -476,7 +476,7 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 		test_sockmap_drop_prog__destroy(drop);
 }
 
-static void test_sockmap_msg_verdict(bool is_ingress, bool is_permanent)
+static void test_sockmap_msg_verdict(bool is_ingress, bool is_permanent, bool is_self)
 {
 	int key, sent, recvd, recv_fd;
 	int err, map, verdict, s, c0, c1, p0, p1;
@@ -519,13 +519,23 @@ static void test_sockmap_msg_verdict(bool is_ingress, bool is_permanent)
 		goto out_close;
 
 	if (is_ingress) {
-		recv_fd = c1;
 		skel->bss->skmsg_redir_flags = BPF_F_INGRESS;
-		skel->bss->skmsg_redir_key = 1;
+		if (is_self) {
+			skel->bss->skmsg_redir_key = 0;
+			recv_fd = p1;
+		} else {
+			skel->bss->skmsg_redir_key = 1;
+			recv_fd = c1;
+		}
 	} else {
-		recv_fd = c0;
 		skel->bss->skmsg_redir_flags = 0;
-		skel->bss->skmsg_redir_key = 2;
+		if (is_self) {
+			skel->bss->skmsg_redir_key = 0;
+			recv_fd = c1;
+		} else {
+			skel->bss->skmsg_redir_key = 2;
+			recv_fd = c0;
+		}
 	}
 
 	if (is_permanent)
@@ -590,11 +600,15 @@ void test_sockmap_basic(void)
 	if (test__start_subtest("sockmap skb_verdict fionread on drop"))
 		test_sockmap_skb_verdict_fionread(false);
 	if (test__start_subtest("sockmap msg_verdict"))
-		test_sockmap_msg_verdict(false, false);
+		test_sockmap_msg_verdict(false, false, false);
 	if (test__start_subtest("sockmap msg_verdict ingress"))
-		test_sockmap_msg_verdict(true, false);
+		test_sockmap_msg_verdict(true, false, false);
 	if (test__start_subtest("sockmap msg_verdict permanent"))
-		test_sockmap_msg_verdict(false, true);
+		test_sockmap_msg_verdict(false, true, false);
 	if (test__start_subtest("sockmap msg_verdict ingress permanent"))
-		test_sockmap_msg_verdict(true, true);
+		test_sockmap_msg_verdict(true, true, false);
+	if (test__start_subtest("sockmap msg_verdict permanent self"))
+		test_sockmap_msg_verdict(false, true, true);
+	if (test__start_subtest("sockmap msg_verdict ingress permanent self"))
+		test_sockmap_msg_verdict(true, true, true);
 }
-- 
2.34.1


