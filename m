Return-Path: <netdev+bounces-25490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC0A7743EE
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258632812E5
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0E61FA6;
	Tue,  8 Aug 2023 18:09:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BCC1B7C5
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C7AC433C8;
	Tue,  8 Aug 2023 18:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691518160;
	bh=0Iglnq2fpte6cxrqAZ35FOOgTYJYUr/M3Egg8lt/i/o=;
	h=From:To:Cc:Subject:Date:From;
	b=D87HJEuRByRjIP5Ii5iVJddzuzcvbuwu2gx3ZrdN6g7/bI9JHED4Is3X1zsFEkD0z
	 /g/MRu4pJHh5fhqEIgVyaviMRLXUHKgjdVGMLfU3D+MsNsGzvkDO5B9/dmOcI881mI
	 clFhxm2hfhClH3DWXiP8aSDkZTThkAOnBO/tO3+rDT8hIQIryubkIqqPwfpRy0h8rg
	 oL2dQA6y/VcmYWBBHearUOCDuYmvHkT53dyDDDhoz1O8H2LLPu06bNX4IRM+1mC3pI
	 KT5lOUl8Ih89Mrw/B3FxD1+4KvhubvQWT3sYbFe+Kv26/qgLccZnmk6SD39g6wVj/S
	 rxaLonQRptQLQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	dhowells@redhat.com
Subject: [PATCH net] net: tls: set MSG_SPLICE_PAGES consistently
Date: Tue,  8 Aug 2023 11:09:17 -0700
Message-ID: <20230808180917.1243540-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We used to change the flags for the last segment, because
non-last segments had the MSG_SENDPAGE_NOTLAST flag set.
That flag is no longer a thing so remove the setting.

Since flags most likely don't have MSG_SPLICE_PAGES set
this avoids passing parts of the sg as splice and parts
as non-splice. Before commit under Fixes we'd have called
tcp_sendpage() which would add the MSG_SPLICE_PAGES.

Why this leads to trouble remains unclear but Tariq
reports hitting the WARN_ON(!sendpage_ok()) due to
page refcount of 0.

Fixes: e117dcfd646e ("tls: Inline do_tcp_sendpages()")
Reported-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://lore.kernel.org/all/4c49176f-147a-4283-f1b1-32aac7b4b996@gmail.com/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: borisp@nvidia.com
CC: john.fastabend@gmail.com
CC: dhowells@redhat.com
---
 net/tls/tls_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 7dbb8cd8f809..f550c84f3408 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -139,9 +139,6 @@ int tls_push_sg(struct sock *sk,
 
 	ctx->splicing_pages = true;
 	while (1) {
-		if (sg_is_last(sg))
-			msg.msg_flags = flags;
-
 		/* is sending application-limited? */
 		tcp_rate_check_app_limited(sk);
 		p = sg_page(sg);
-- 
2.41.0


