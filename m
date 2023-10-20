Return-Path: <netdev+bounces-42843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C727D0614
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 03:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C86BB214B6
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 01:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C92811;
	Fri, 20 Oct 2023 01:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIcd0zSD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089F808
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 01:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DFDC433CB;
	Fri, 20 Oct 2023 01:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697764739;
	bh=lL4gbfWmP27dPiZgO+7HF5Cy++dpF+1q2A/5lFk9Xc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mIcd0zSDJ1aqpgZIc+MLU74rxoL2ocZuxcFlak20U1GDmVgZ+KmSM5SZhBV9fHV4b
	 eUD/permyBbMOfwLOzUWlKR95zrv3cMIcnCYtIxSVb+0Y7MgeAy4Did11qpg15Xv/T
	 swiylSz8P6UKS9Md+N1BrpKnMzMczHZi7LdKde2JMzB3eLahJTsT2Q7scnj+TPwXqY
	 ARu8sET6nIyVvLDVVjQMH3/ImaylPt+2WQu1znHGd7VEkTouCQ8JN7FEHZvsSKD4rl
	 tQK517rnParwSQIVg+1E975SENaVSLhfR3s7KYmZ0zRp2OU4XEsOS4vx8tciAFRY6o
	 Zna7KJtAcEaKQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	johannes.berg@intel.com,
	mpe@ellerman.id.au,
	j@w1.fi,
	jiri@resnulli.us
Subject: [PATCH net-next 3/6] net: reduce indentation of __dev_alloc_name()
Date: Thu, 19 Oct 2023 18:18:53 -0700
Message-ID: <20231020011856.3244410-4-kuba@kernel.org>
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

All callers of __dev_valid_name() go thru dev_prep_valid_name()
which handles the non-printf case. Focus __dev_alloc_name() on
the sprintf case, remove the indentation level.

Minor functional change of returning -EINVAL if % is not found,
which should now never happen.

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


