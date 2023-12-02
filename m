Return-Path: <netdev+bounces-53293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE808801E93
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 22:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8861C2074A
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 21:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C039721362;
	Sat,  2 Dec 2023 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJPo5J9s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30B62F3E
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 21:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A58C433C7;
	Sat,  2 Dec 2023 21:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701551594;
	bh=tyRYPsGFpWLErC/uL5hEu7tmjRb13c75uUF17rQv8og=;
	h=From:To:Cc:Subject:Date:From;
	b=rJPo5J9s6rcvSNHMBexX/4B6Liqt0MNBnb2cFRx8wkI1gqPbU1bNmrSx+V9FTxEml
	 YBWHkGJ/xbQaeYvckmLUUtDy5W78uBhLDk6gh9sybwis0MPyUB89Q12ol6wf3EX1SB
	 TS0Ynu4gvjTqaVJ6g07HP+dp2TOSFcYFywYfLySLTGNLnw/HYTp0dE/e6+/ZunFfyR
	 OQNViw1Y+C+jKo1xrC0IwCNSPUo/2SCX8a6sEM59bF8769rYTnUB8zZxB33bmmeWBL
	 Mrkir2uEOqX9S7koAlz49G8jwdyJHoPOOlMk5TmpeQMBYBjVNKp04SIFSpJuck2/Qb
	 iiuu74eycYCeQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jacob.e.keller@intel.com,
	nicolas.dichtel@6wind.com,
	jiri@resnulli.us
Subject: [PATCH net-next] tools: ynl: use strerror() if no extack of note provided
Date: Sat,  2 Dec 2023 13:13:10 -0800
Message-ID: <20231202211310.342716-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If kernel didn't give use any meaningful error - print
a strerror() to the ynl error message.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jacob.e.keller@intel.com
CC: nicolas.dichtel@6wind.com
CC: jiri@resnulli.us
---
 tools/net/ynl/lib/ynl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 830d25097009..587286de10b5 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -145,8 +145,10 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
 	const struct nlattr *attr;
 	const char *str = NULL;
 
-	if (!(nlh->nlmsg_flags & NLM_F_ACK_TLVS))
+	if (!(nlh->nlmsg_flags & NLM_F_ACK_TLVS)) {
+		yerr_msg(ys, "%s", strerror(ys->err.code));
 		return MNL_CB_OK;
+	}
 
 	mnl_attr_for_each(attr, nlh, hlen) {
 		unsigned int len, type;
@@ -249,6 +251,8 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
 		yerr_msg(ys, "Kernel %s: %s%s",
 			 ys->err.code ? "error" : "warning",
 			 bad_attr, miss_attr);
+	else
+		yerr_msg(ys, "%s", strerror(ys->err.code));
 
 	return MNL_CB_OK;
 }
-- 
2.43.0


