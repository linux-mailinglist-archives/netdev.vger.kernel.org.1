Return-Path: <netdev+bounces-44375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6CB7D7AE4
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 04:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39FB8281E09
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 02:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA348F47;
	Thu, 26 Oct 2023 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmQxp4oA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA2F2F44
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 02:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D408C433C7;
	Thu, 26 Oct 2023 02:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698287359;
	bh=1CibCq0Kyu0ElVY8wg0jgw0Tv9e0nIvv2sB62YcRwrY=;
	h=From:To:Cc:Subject:Date:From;
	b=jmQxp4oAGewFn9D93NwKSTdCAJMeSo0jZ3MFf9RSSlRunyWlpNRUyTJZ3iwlWvxnP
	 jk7G1n39kQkRI65fYKYLVwiELppk6qqfprCPcj0wUHApKBYoKCaguwakRm78rLaKwG
	 OyBVHUwMkVgTBW+sk5B00fv4rQcFGhcbbS01tQEjpRoykPz+sHRMC7koO8MWNF+o5+
	 b9k9inA4oKAcLpZiD7Q0Kkd3CGLqY5W8h5ahYt3vqMhsWeMfyr/mfp6zl36Y06/zzQ
	 4BHfiVCcvbtdMCLM+BAJTqNx7FkhSjwcmXyDqAhk/G1HYk1i2YikA91LA4AbsZ7g6y
	 nj2XEphK3O5cQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	o.rempel@pengutronix.de
Subject: [PATCH net-next] net: selftests: use ethtool_sprintf()
Date: Wed, 25 Oct 2023 19:29:16 -0700
Message-ID: <20231026022916.566661-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

During a W=1 build GCC 13.2 says:

net/core/selftests.c: In function ‘net_selftest_get_strings’:
net/core/selftests.c:404:52: error: ‘%s’ directive output may be truncated writing up to 279 bytes into a region of size 28 [-Werror=format-truncation=]
  404 |                 snprintf(p, ETH_GSTRING_LEN, "%2d. %s", i + 1,
      |                                                    ^~
net/core/selftests.c:404:17: note: ‘snprintf’ output between 5 and 284 bytes into a destination of size 32
  404 |                 snprintf(p, ETH_GSTRING_LEN, "%2d. %s", i + 1,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  405 |                          net_selftests[i].name);
      |                          ~~~~~~~~~~~~~~~~~~~~~~

avoid it by using ethtool_sprintf().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: o.rempel@pengutronix.de
---
 net/core/selftests.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/core/selftests.c b/net/core/selftests.c
index acb1ee97bbd3..94fe3146a959 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -397,14 +397,11 @@ EXPORT_SYMBOL_GPL(net_selftest_get_count);
 
 void net_selftest_get_strings(u8 *data)
 {
-	u8 *p = data;
 	int i;
 
-	for (i = 0; i < net_selftest_get_count(); i++) {
-		snprintf(p, ETH_GSTRING_LEN, "%2d. %s", i + 1,
-			 net_selftests[i].name);
-		p += ETH_GSTRING_LEN;
-	}
+	for (i = 0; i < net_selftest_get_count(); i++)
+		ethtool_sprintf(&data, "%2d. %s", i + 1,
+				net_selftests[i].name);
 }
 EXPORT_SYMBOL_GPL(net_selftest_get_strings);
 
-- 
2.41.0


