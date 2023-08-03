Return-Path: <netdev+bounces-23901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A2A76E152
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 09:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE471C20F99
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 07:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AD29444;
	Thu,  3 Aug 2023 07:26:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181138F5D
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 07:25:59 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E573F0
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 00:25:58 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RGgKL1CflzNmpc;
	Thu,  3 Aug 2023 15:22:30 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.111) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 15:25:56 +0800
From: Xiang Yang <xiangyang3@huawei.com>
To: <matthieu.baerts@tessares.net>, <martineau@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <mptcp@lists.linux.dev>, <xiangyang3@huawei.com>
Subject: [PATCH -next] mptcp: fix the incorrect judgment for msk->cb_flags
Date: Thu, 3 Aug 2023 07:24:38 +0000
Message-ID: <20230803072438.1847500-1-xiangyang3@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.111]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Coccicheck reports the error below:
net/mptcp/protocol.c:3330:15-28: ERROR: test of a variable/field address

Since the address of msk->cb_flags is used in __test_and_clear_bit, the
address should not be NULL. The judgment for if (unlikely(msk->cb_flags))
will always be true, we should check the real value of msk->cb_flags here.

Fixes: 65a569b03ca8 ("mptcp: optimize release_cb for the common case")
Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 65ee949a8a44..fae31dab49c9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3327,7 +3327,7 @@ static void mptcp_release_cb(struct sock *sk)
 
 	if (__test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->cb_flags))
 		__mptcp_clean_una_wakeup(sk);
-	if (unlikely(&msk->cb_flags)) {
+	if (unlikely(msk->cb_flags)) {
 		/* be sure to set the current sk state before tacking actions
 		 * depending on sk_state, that is processing MPTCP_ERROR_REPORT
 		 */
-- 
2.34.1


