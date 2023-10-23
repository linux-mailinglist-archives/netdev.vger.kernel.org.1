Return-Path: <netdev+bounces-43500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849BF7D3A9D
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 17:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850921C2095A
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 15:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B501C282;
	Mon, 23 Oct 2023 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CymZUY9X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE99C1BDFF
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 15:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7AEC433CD;
	Mon, 23 Oct 2023 15:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698074629;
	bh=QA9GEVBIRSRF4wOSHtS3lLaM/EEh15jDC/cig/sgPYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CymZUY9XEUOOIbzcEEBCVMVqqis6Rl+ISlq85iMFbm085NAHvceAV5F6Z3AGF7ZhV
	 k3y988bxujplQwF30k3C60bvy3NfElrKPFR2NR0Xt+hw3Fc3XeNNhAyuGYCqrT1gPA
	 SBf40Qyx4haw4d4QUiHMWpFaaIMBefFbX8GW+qNpzXSNZKptil++1VuNsFtwKyOgpS
	 JWZawLIK8rHbjKhU1E+ZwTNnsTBoUuRwkfn+mpFNZG1dfy065zemf/bRjDO5eR8qkA
	 2DDFpNOs0rD9wG31r1AOndLlFfz8/FbscyryQIBToyK9UE7o/FZLIhym7TiBtB3EIK
	 5Bz0uKLxkQmMw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	johannes.berg@intel.com,
	mpe@ellerman.id.au,
	j@w1.fi,
	jiri@resnulli.us
Subject: [PATCH net-next v2 3/6] net: reduce indentation of __dev_alloc_name()
Date: Mon, 23 Oct 2023 08:23:43 -0700
Message-ID: <20231023152346.3639749-4-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023152346.3639749-1-kuba@kernel.org>
References: <20231023152346.3639749-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers of __dev_valid_name() go thru dev_prep_valid_name()
which handles the non-printf case. Focus __dev_alloc_name() on
the sprintf case, remove the indentation level.

Minor functional change of returning -EINVAL if % is not found,
which should now never happen.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.c | 56 +++++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 004e9f26b160..bbfb02b4a228 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1080,50 +1080,46 @@ static int __dev_alloc_name(struct net *net, const char *name, char *res)
 	if (!dev_valid_name(name))
 		return -EINVAL;
 
+	/* Verify the string as this thing may have come from the user.
+	 * There must be one "%d" and no other "%" characters.
+	 */
 	p = strchr(name, '%');
-	if (p) {
-		/*
-		 * Verify the string as this thing may have come from
-		 * the user.  There must be either one "%d" and no other "%"
-		 * characters.
-		 */
-		if (p[1] != 'd' || strchr(p + 2, '%'))
-			return -EINVAL;
+	if (!p || p[1] != 'd' || strchr(p + 2, '%'))
+		return -EINVAL;
 
-		/* Use one page as a bit array of possible slots */
-		inuse = bitmap_zalloc(max_netdevices, GFP_ATOMIC);
-		if (!inuse)
-			return -ENOMEM;
+	/* Use one page as a bit array of possible slots */
+	inuse = bitmap_zalloc(max_netdevices, GFP_ATOMIC);
+	if (!inuse)
+		return -ENOMEM;
 
-		for_each_netdev(net, d) {
-			struct netdev_name_node *name_node;
+	for_each_netdev(net, d) {
+		struct netdev_name_node *name_node;
 
-			netdev_for_each_altname(d, name_node) {
-				if (!sscanf(name_node->name, name, &i))
-					continue;
-				if (i < 0 || i >= max_netdevices)
-					continue;
-
-				/*  avoid cases where sscanf is not exact inverse of printf */
-				snprintf(buf, IFNAMSIZ, name, i);
-				if (!strncmp(buf, name_node->name, IFNAMSIZ))
-					__set_bit(i, inuse);
-			}
-			if (!sscanf(d->name, name, &i))
+		netdev_for_each_altname(d, name_node) {
+			if (!sscanf(name_node->name, name, &i))
 				continue;
 			if (i < 0 || i >= max_netdevices)
 				continue;
 
-			/*  avoid cases where sscanf is not exact inverse of printf */
+			/* avoid cases where sscanf is not exact inverse of printf */
 			snprintf(buf, IFNAMSIZ, name, i);
-			if (!strncmp(buf, d->name, IFNAMSIZ))
+			if (!strncmp(buf, name_node->name, IFNAMSIZ))
 				__set_bit(i, inuse);
 		}
+		if (!sscanf(d->name, name, &i))
+			continue;
+		if (i < 0 || i >= max_netdevices)
+			continue;
 
-		i = find_first_zero_bit(inuse, max_netdevices);
-		bitmap_free(inuse);
+		/* avoid cases where sscanf is not exact inverse of printf */
+		snprintf(buf, IFNAMSIZ, name, i);
+		if (!strncmp(buf, d->name, IFNAMSIZ))
+			__set_bit(i, inuse);
 	}
 
+	i = find_first_zero_bit(inuse, max_netdevices);
+	bitmap_free(inuse);
+
 	snprintf(buf, IFNAMSIZ, name, i);
 	if (!netdev_name_in_use(net, buf)) {
 		strscpy(res, buf, IFNAMSIZ);
-- 
2.41.0


