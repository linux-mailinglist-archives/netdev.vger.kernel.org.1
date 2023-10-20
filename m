Return-Path: <netdev+bounces-42846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07D67D0617
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 03:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A524B213A4
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 01:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E527D808;
	Fri, 20 Oct 2023 01:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot5K9W25"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7061C02
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 01:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021AFC433C7;
	Fri, 20 Oct 2023 01:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697764741;
	bh=WkjlebE+uQgY9ZblbfFKEjPqmY+WADIj8s8n39W8FlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ot5K9W25EtIWZUcuoN9f38vRTxCQgtfogvoHeDiI373vxvST8tI+iSCqbIzRloqR0
	 AgI3xhqUg1mDGgqYhYqv8tOiq88MwCAgjXI0ZcFX3Xkb78YPCAtBMq27Zl16uqHK1H
	 qgO3nUok7NJdjrMxwPiHXuf65EZ1R5IS5lbV9jocW1z8faBN2zkbFjXGKwaohPqQ7g
	 BObE4Gzj8VIc7SmIl+21dTmfGRcLANOTE07Ie7QyU8Ka4wW/1M5gumxK5lNGE8Hal5
	 1nIWHqk4w59U5yndIEnh3dzoEU7G4defhpNODAa3BU/U4B+Hwu5hnW7+kCheOYxT7N
	 bEG9Z+M5A8Ldw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	johannes.berg@intel.com,
	mpe@ellerman.id.au,
	j@w1.fi,
	jiri@resnulli.us
Subject: [PATCH net-next 6/6] net: remove else after return in dev_prep_valid_name()
Date: Thu, 19 Oct 2023 18:18:56 -0700
Message-ID: <20231020011856.3244410-7-kuba@kernel.org>
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

Remove unnecessary else clauses after return.
I copied this if / else construct from somewhere,
it makes the code harder to read.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0830f2967221..a37a932a3e14 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1131,14 +1131,13 @@ static int dev_prep_valid_name(struct net *net, struct net_device *dev,
 	if (!dev_valid_name(want_name))
 		return -EINVAL;
 
-	if (strchr(want_name, '%')) {
+	if (strchr(want_name, '%'))
 		return __dev_alloc_name(net, want_name, out_name);
-	} else if (netdev_name_in_use(net, want_name)) {
-		return -dup_errno;
-	} else if (out_name != want_name) {
-		strscpy(out_name, want_name, IFNAMSIZ);
-	}
 
+	if (netdev_name_in_use(net, want_name))
+		return -dup_errno;
+	if (out_name != want_name)
+		strscpy(out_name, want_name, IFNAMSIZ);
 	return 0;
 }
 
-- 
2.41.0


