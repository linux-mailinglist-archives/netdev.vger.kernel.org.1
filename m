Return-Path: <netdev+bounces-22011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E89765AB4
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 19:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24792823F6
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 17:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52528F41;
	Thu, 27 Jul 2023 17:47:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B14327150
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 17:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237CCC433C7;
	Thu, 27 Jul 2023 17:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690480040;
	bh=QfaodoqmhOaqVb7r9DJuHMcMwJQYPs4wOqOC0JVyr0k=;
	h=From:To:Cc:Subject:Date:From;
	b=MvW3RuPCZ/4dSoKiUmYb11DUaNNa07/NIWH1PeKw/LetAbx1oysjUrNBE64fFDL3d
	 a1z0Z4umsyOz95ktHIveSWhNRHjMR3PyKDHl+Bkp/EX9i5KlutIy9FwVXneiaWZ+LN
	 633DK6235IIchcG3EFpjCbSYX10Q5sL0eILuUyUD9miJQiFkZW6lDGM1G5k52YY3sk
	 91Z5PJW0DS56CM+xbZgJXkjfTFnBbyymltrD45RZaOGyjixyrNRRYebrXDwnzFVddN
	 xDFNN1Rnk0BdzRjhIxMiLw5LYIPmEzFnUE2pglwC3vNzEDUixpKzSiGAHzyGUJLRix
	 WBv/HjZydJn/A==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: M A Ramdhan <ramdhan@starlabs.sg>,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hailmo@amazon.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 4.19] net/sched: cls_fw: Fix improper refcount update leads to use-after-free
Date: Thu, 27 Jul 2023 17:46:28 +0000
Message-Id: <20230727174629.55740-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: M A Ramdhan <ramdhan@starlabs.sg>

[ Upstream commit 0323bce598eea038714f941ce2b22541c46d488f ]

In the event of a failure in tcf_change_indev(), fw_set_parms() will
immediately return an error after incrementing or decrementing
reference counter in tcf_bind_filter().  If attacker can control
reference counter to zero and make reference freed, leading to
use after free.

In order to prevent this, move the point of possible failure above the
point where the TC_FW_CLASSID is handled.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: M A Ramdhan <ramdhan@starlabs.sg>
Signed-off-by: M A Ramdhan <ramdhan@starlabs.sg>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Message-ID: <20230705161530.52003-1-ramdhan@starlabs.sg>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 net/sched/cls_fw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index cb2c62605fc76..5284a473c697f 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -221,11 +221,6 @@ static int fw_set_parms(struct net *net, struct tcf_proto *tp,
 	if (err < 0)
 		return err;
 
-	if (tb[TCA_FW_CLASSID]) {
-		f->res.classid = nla_get_u32(tb[TCA_FW_CLASSID]);
-		tcf_bind_filter(tp, &f->res, base);
-	}
-
 #ifdef CONFIG_NET_CLS_IND
 	if (tb[TCA_FW_INDEV]) {
 		int ret;
@@ -244,6 +239,11 @@ static int fw_set_parms(struct net *net, struct tcf_proto *tp,
 	} else if (head->mask != 0xFFFFFFFF)
 		return err;
 
+	if (tb[TCA_FW_CLASSID]) {
+		f->res.classid = nla_get_u32(tb[TCA_FW_CLASSID]);
+		tcf_bind_filter(tp, &f->res, base);
+	}
+
 	return 0;
 }
 
-- 
2.40.1


