Return-Path: <netdev+bounces-114446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8066A942A04
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A101C210E0
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503AD1A8BE2;
	Wed, 31 Jul 2024 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOHjiF+r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8811A4B47
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417333; cv=none; b=Y+CGLjg7+ZOMuQEN5uvjs5gRnaOVoWj6RRDQwfz45I68CAi4EaHCLlEcqrlu0BDCL+wQHfb6fIhJeI0MB10odXWLXDo/8Pk+BeeQfBzJWbvhFWgqa6E/HWHImN7HQ6UHhuj96wsq0oT5E0i1+lErrIySFb6/zDFSjqkFOD8u+dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417333; c=relaxed/simple;
	bh=5dRH/gyWHuT7tv0mLIAqVK9bHuWlEWqJEFR+ZyD78HM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PdjhVj8n4tdLG9Nl3M8f6kHkTGCKLQjkTt/UU9spcIrgmdCOfTils4paMoaU/VwcPrBTw3FCKN0JAAG23DhGergkVgCK7x0u7VCxNlUAuh3CpTF9EjlFtBaB6rbUXJGJgXcK1VZILmhSGZYk+I5k6/pVITemIvRq7nUfOWP6uVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOHjiF+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7E4C116B1;
	Wed, 31 Jul 2024 09:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722417332;
	bh=5dRH/gyWHuT7tv0mLIAqVK9bHuWlEWqJEFR+ZyD78HM=;
	h=From:Date:Subject:To:Cc:From;
	b=lOHjiF+rWYQig3/4nV+bP2yFAMpgKIobLHqyDOP4pv+7LiDiXiNohE+PhAYr+DqGs
	 qFz6W4FWua9Pw4Mk5Z0HvMePT/h9SDOxA93peNGkDiF+DCK95wN1piSaz9ZHeR7+bL
	 A872Zvj9E4enM8/iR9G3Y7Q5TQNfVfF0/15Ifk9lnQAtcrDv84akcedvrdgCkYFZ9w
	 EPTSpraCqDZGxPJZdxjdEat3LG6EYvYqa+bJShWWMtfA6+xhZxF/CLkssCuJohlEGo
	 cK/35mv31yKaJ7LuETyW+V6nrsKAb409AdfmDOomC9ymMlpbTfuBrU3OdhBTBTbgFx
	 nvLJeW/9Ka0Uw==
From: Simon Horman <horms@kernel.org>
Date: Wed, 31 Jul 2024 10:15:28 +0100
Subject: [PATCH net-next] ethtool: Don't check for NULL info in
 prepare_data callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-prepare_data-null-check-v1-1-627f2320678f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAK8AqmYC/x2MUQqDMBAFryL73YUkLSpepRRJk9e6KFtJ0iKId
 2/wc2BmdspIgkxDs1PCT7J8tIK9NBQmr2+wxMrkjLuZ7mp5TVh9whh98azfZeEwIcxsrO1iG3r
 TuyfVunov2c7znRSFFVuhx3H8AeFb8gZzAAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.0

Since commit f946270d05c2 ("ethtool: netlink: always pass genl_info to
.prepare_data") the info argument of prepare_data callbacks is never
NULL. Remove checks present in callback implementations.

Link: https://lore.kernel.org/netdev/20240703121237.3f8b9125@kernel.org/
Signed-off-by: Simon Horman <horms@kernel.org>
---
 net/ethtool/linkinfo.c  | 2 +-
 net/ethtool/linkmodes.c | 2 +-
 net/ethtool/strset.c    | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/ethtool/linkinfo.c b/net/ethtool/linkinfo.c
index 5c317d23787b..30b8ce275159 100644
--- a/net/ethtool/linkinfo.c
+++ b/net/ethtool/linkinfo.c
@@ -35,7 +35,7 @@ static int linkinfo_prepare_data(const struct ethnl_req_info *req_base,
 	if (ret < 0)
 		return ret;
 	ret = __ethtool_get_link_ksettings(dev, &data->ksettings);
-	if (ret < 0 && info)
+	if (ret < 0)
 		GENL_SET_ERR_MSG(info, "failed to retrieve link settings");
 	ethnl_ops_complete(dev);
 
diff --git a/net/ethtool/linkmodes.c b/net/ethtool/linkmodes.c
index b2591db49f7d..259cd9ef1f2a 100644
--- a/net/ethtool/linkmodes.c
+++ b/net/ethtool/linkmodes.c
@@ -40,7 +40,7 @@ static int linkmodes_prepare_data(const struct ethnl_req_info *req_base,
 		return ret;
 
 	ret = __ethtool_get_link_ksettings(dev, &data->ksettings);
-	if (ret < 0 && info) {
+	if (ret < 0) {
 		GENL_SET_ERR_MSG(info, "failed to retrieve link settings");
 		goto out;
 	}
diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index c678b484a079..56b99606f00b 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -289,8 +289,7 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
 		for (i = 0; i < ETH_SS_COUNT; i++) {
 			if ((req_info->req_ids & (1U << i)) &&
 			    data->sets[i].per_dev) {
-				if (info)
-					GENL_SET_ERR_MSG(info, "requested per device strings without dev");
+				GENL_SET_ERR_MSG(info, "requested per device strings without dev");
 				return -EINVAL;
 			}
 		}


