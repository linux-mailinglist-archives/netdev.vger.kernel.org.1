Return-Path: <netdev+bounces-157363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA76A0A162
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 08:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82183AB11F
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 06:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E5E16BE3A;
	Sat, 11 Jan 2025 07:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOEAy8UV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75E915C14B
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736578800; cv=none; b=pXRuxD5yq6TkmMiXh6GwFosALaAefQTF9wBZbuBG3Db8nxihWrAfGB7tyOQoXvcNEAZhzo5L2mTsXgWJlAEZshelxxfx2fqpRwnfbSHXiGGZPr9TCuaAVv4z4d9i80gSwD2WzDa/5yzo/8p9GAJSXOJ1+os7sfT5YtEQtHpA8o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736578800; c=relaxed/simple;
	bh=5bjW9UykZ73QaYBBneKCgwiFbjOIELdWmUp3WpwdnOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slmufF6z0kaEsKbjwBRGpqQdqj2DjquWja84pHYq0xy6txQ40jrSdeHgEHBhK1IaM5XYWd+Rpw7V5/bY10sUmSezNjSGb04BZZ2XxaGWG/BWOUHrQzOOhVDS08RYQaagzCxYmIstWyz2OnFpB8twfXecQsnddkwZx0WRlW5Bups=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOEAy8UV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFEDC4CED3;
	Sat, 11 Jan 2025 06:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736578799;
	bh=5bjW9UykZ73QaYBBneKCgwiFbjOIELdWmUp3WpwdnOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rOEAy8UV7C62wjQiZWsV/mGLfclkNLU59b+aFTrq5sUY0/OGPSfjMqp7oP6mcP2oS
	 Mb7SLM+g+hA9rR6O/A8bB5XdUs49QzU+Qwm7u4NCM70ZrForXL6IP2wyldfbnbQsIh
	 w3gkHuGHGgNtuKeqiWoH+/5kYJb5uE17FrdQh9bQ02Fpci8LHcW3EuQM6cqZmJUkY3
	 7/rpqltgv44/uFm3qUVBOeG/DzYlvyQ4ebPNpFkFBv3XNaBomix3sBgQgpjYpVwh6W
	 AHvh/ShHwxX2azLJWckiEgkZ2I8EHvYBJSGN6VWKGeErNOOqpjILTeyjeCPbrrTIHI
	 jkWW3uObLO2xw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/2] net: initialize netdev->lock on dummy devices
Date: Fri, 10 Jan 2025 22:59:55 -0800
Message-ID: <20250111065955.3698801-2-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250111065955.3698801-1-kuba@kernel.org>
References: <20250111065955.3698801-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure netdev->lock is always valid, even on dummy netdevs.

Apparently it's legal to call mutex_destroy() on an uninitialized
mutex (and we do that in free_netdev()), but it doesn't seem right.
Plus we'll soon want to take netdev->lock on more paths which dummy
netdevs may reach.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 23e7f6a3925b..00552197d601 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10756,6 +10756,8 @@ static void init_dummy_netdev_core(struct net_device *dev)
 	/* napi_busy_loop stats accounting wants this */
 	dev_net_set(dev, &init_net);
 
+	mutex_init(&dev->lock);
+
 	/* Note : We dont allocate pcpu_refcnt for dummy devices,
 	 * because users of this 'device' dont need to change
 	 * its refcount.
-- 
2.47.1


