Return-Path: <netdev+bounces-42845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DEF7D0616
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 03:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BCF2823BD
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 01:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DFF1844;
	Fri, 20 Oct 2023 01:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGp4afcy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5437117D3
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 01:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71588C433C8;
	Fri, 20 Oct 2023 01:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697764740;
	bh=N7q0nY7TNQy4Cbw7fiBk47VxXEXIPG5CF+M3HOATVv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TGp4afcyqQXoXn81MK7TdHEb7geiCbOGTRA4opOIEaXg5SJQuB4cgHAJ+CYXEzqfs
	 sK/uuz52mRbhWL3ePSSFUZeTZYjD2a8yHcdHMfHoFspSZdXnXFr5SDhSVruCQ34OQ7
	 EwhVfsFtyPJUN6rzZ+XjHSR+EyzSSqtd4yEs4HZgt2ocNoAFh4NYDBpKuHTKnO6unS
	 SV3iQbHAiAENhtS2NjPx/bgKKVoaPKL7E3Pqwq0eKz7X52I7t1O6+z7PBt7Tzl37Lf
	 7fbuNfuGQkkNtYatgJS/GV6Y0zzWJauHdD974BdrWGRFmJdnFRGWfRbu173r3e2XJ3
	 Us1AkA8pzrxuA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	johannes.berg@intel.com,
	mpe@ellerman.id.au,
	j@w1.fi,
	jiri@resnulli.us
Subject: [PATCH net-next 5/6] net: remove dev_valid_name() check from __dev_alloc_name()
Date: Thu, 19 Oct 2023 18:18:55 -0700
Message-ID: <20231020011856.3244410-6-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020011856.3244410-1-kuba@kernel.org>
References: <20231020011856.3244410-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__dev_alloc_name() is only called by dev_prep_valid_name(),
which already checks that name is valid.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index d2698b4bbad4..0830f2967221 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1077,9 +1077,6 @@ static int __dev_alloc_name(struct net *net, const char *name, char *res)
 	struct net_device *d;
 	char buf[IFNAMSIZ];
 
-	if (!dev_valid_name(name))
-		return -EINVAL;
-
 	/* Verify the string as this thing may have come from the user.
 	 * There must be one "%d" and no other "%" characters.
 	 */
-- 
2.41.0


