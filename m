Return-Path: <netdev+bounces-14584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A78157427CC
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 15:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3831C20A81
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 13:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D71F125BA;
	Thu, 29 Jun 2023 13:57:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91048125B9
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 13:57:07 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AEECF;
	Thu, 29 Jun 2023 06:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688047026; x=1719583026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KHiB3abkj5VcQDjRlKOb0Tkf6LNR98NT71l0fvJAq0Y=;
  b=SvEDfQv0E7bWrTuc3zhRtxTVgJ1D5S7JX5zoEXKRPtK5jz2S5tj5yDc2
   nJuMACCxFF51CWn1xuwjymNfxpo9VFwVspFoh9g+XtiSH9cAXXI6s2Qz4
   b8GKqhW1yJDuSpV/aClTO+FM3uPhD+QeOTWSSGuUVPn9S7RIKq8TBNqaE
   pW7UurB629zh4Z8qI8TfXzABa2qdAnSeqTNK7zJ7kHTHo1PDt6wiz1g6v
   5FV0POvtwsomD7KFAgfH38bc2Y8KyAGHBgnq2b0MFrNJ3Z6y0iuQFpNMb
   Tb9WcydAGyv+cqkjoqNzMyWq7Le4t0D8/Lsf64xRjrIWo6WwgGJ6JGEQV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="365584724"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="365584724"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 06:22:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="711430122"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="711430122"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 29 Jun 2023 06:22:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E2BC93DA; Thu, 29 Jun 2023 16:22:47 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] netlink: Make use of __assign_bit() API
Date: Thu, 29 Jun 2023 16:22:40 +0300
Message-Id: <20230629132240.80372-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230629132240.80372-1-andriy.shevchenko@linux.intel.com>
References: <20230629132240.80372-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We have for some time the __assign_bit() API to replace open coded

	if (foo)
		__set_bit(n, bar);
	else
		__clear_bit(n, bar);

Use this API in the code. No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 net/netlink/af_netlink.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 383631873748..9c9df143a2ec 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1629,10 +1629,7 @@ static void netlink_update_socket_mc(struct netlink_sock *nlk,
 
 	old = test_bit(group - 1, nlk->groups);
 	subscriptions = nlk->subscriptions - old + new;
-	if (new)
-		__set_bit(group - 1, nlk->groups);
-	else
-		__clear_bit(group - 1, nlk->groups);
+	__assign_bit(group - 1, nlk->groups, new);
 	netlink_update_subscriptions(&nlk->sk, subscriptions);
 	netlink_update_listeners(&nlk->sk);
 }
-- 
2.40.0.1.gaa8946217a0b


