Return-Path: <netdev+bounces-169936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3044AA4685F
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74C318866D1
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C9F2253EA;
	Wed, 26 Feb 2025 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJwsaH88"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7005021B1B5
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592008; cv=none; b=hfC503fm8Glr4UrbsWi2OqOw8dKeCqSkPcEgpUEJCHZ1NLwcYou/Raj2oy36h6NsDrZiJKW0ivyEGNYcBr1Z2eFYVPKCTzItb3FUG+9n8afpswdx2NY3dwulZ3Tr72djlUXgQ9DqndCc30kkf9wBbWkZk/Fsq4CAG3ztWua8o5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592008; c=relaxed/simple;
	bh=LfGBLrGpGH/YsIaXXwgD11dgcGeRcTeR2vO1kQFqFCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwpRD47VnrbvyRMMCry2CoLubt3GWEC++2SppYeeZD6iiwWg7llnli2DXWGMWPiLl5YxysXl4dbal1qkDZrEu7hE5VQJ1Vzx2I9fdW7cDMF+4Hc5CaUN0RkHWxz/JwU1Vixlfr1U9SodVX/rc5YC3QOUs9167+gTagy8hU7C9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJwsaH88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626EAC4CEE8;
	Wed, 26 Feb 2025 17:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740592007;
	bh=LfGBLrGpGH/YsIaXXwgD11dgcGeRcTeR2vO1kQFqFCU=;
	h=From:To:Cc:Subject:Date:From;
	b=kJwsaH88eVrM+7IkWFhI92Xa3DvOmr3aPhGbAWydol9uixMKB6CmnZ1XEPdl+r1ap
	 honr30tqqWI8oMCgChj6Vmf3cNLTfJM8cEToP4wMYzI/A8k68xU5mrj2lxIgpAAWTg
	 xp7xr/kBR5WlmrlA74AugDeuUhEWq1LQrOudVOT9MRmj6QteHrDytBpT4cec5CUHZK
	 75KDqm9EJVel6Hnx/ifCiqjGZ67Mj78PtMqKzvvu8ZkXiSbZNogfFttqZjFWmN3V8k
	 M0mcGTO/q9+BqbC8VYDx55shrCSV+LUjCes8y4HSmHPDLIKTHEfVkGfAetskNKGegw
	 2ldDcM0Pqwclg==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net-sysfs: remove unused initial ret values
Date: Wed, 26 Feb 2025 18:46:43 +0100
Message-ID: <20250226174644.311136-1-atenart@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some net-sysfs functions the ret value is initialized but never used
as it is always overridden. Remove those.

Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/core/net-sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index f61c1d829811..8d9dc048a548 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -568,7 +568,7 @@ static ssize_t ifalias_store(struct device *dev, struct device_attribute *attr,
 	struct net_device *netdev = to_net_dev(dev);
 	struct net *net = dev_net(netdev);
 	size_t count = len;
-	ssize_t ret = 0;
+	ssize_t ret;
 
 	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
@@ -597,7 +597,7 @@ static ssize_t ifalias_show(struct device *dev,
 {
 	const struct net_device *netdev = to_net_dev(dev);
 	char tmp[IFALIASZ];
-	ssize_t ret = 0;
+	ssize_t ret;
 
 	ret = dev_get_alias(netdev, tmp, sizeof(tmp));
 	if (ret > 0)
@@ -638,7 +638,7 @@ static ssize_t phys_port_id_show(struct device *dev,
 {
 	struct net_device *netdev = to_net_dev(dev);
 	struct netdev_phys_item_id ppid;
-	ssize_t ret = -EINVAL;
+	ssize_t ret;
 
 	/* The check is also done in dev_get_phys_port_id; this helps returning
 	 * early without hitting the locking section below.
@@ -664,8 +664,8 @@ static ssize_t phys_port_name_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct net_device *netdev = to_net_dev(dev);
-	ssize_t ret = -EINVAL;
 	char name[IFNAMSIZ];
+	ssize_t ret;
 
 	/* The checks are also done in dev_get_phys_port_name; this helps
 	 * returning early without hitting the locking section below.
@@ -693,7 +693,7 @@ static ssize_t phys_switch_id_show(struct device *dev,
 {
 	struct net_device *netdev = to_net_dev(dev);
 	struct netdev_phys_item_id ppid = { };
-	ssize_t ret = -EINVAL;
+	ssize_t ret;
 
 	/* The checks are also done in dev_get_phys_port_name; this helps
 	 * returning early without hitting the locking section below. This works
-- 
2.48.1


