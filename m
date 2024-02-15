Return-Path: <netdev+bounces-72195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E8C856EA1
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 21:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96E71C2181E
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 20:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4426813A88D;
	Thu, 15 Feb 2024 20:34:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8106213AA41
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 20:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708029252; cv=none; b=Abhk3YsmbS5WGApLt99Hs3m2gEokKp/yyxAqc2cWSYyEUa/O5nMqZHCAdsV3ohM8QUiK7yRDQTBlIdQWuyAY8bvxf/PGXmKdLysWHHw51ujgxJU0N6yoWqAbIGYcRJhy2+73/cfIFH9x2E3u+dhuoDAQL62599YxY3xduPchKo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708029252; c=relaxed/simple;
	bh=n9UOB8nvEd+Y11BBYfMxjFpbDzeo2dcoe/pz9JCyHak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aYfKF+5HT7sRADmTEa3UlHbsigqpSt0TAWqWpcPhbLx5Nyp9CqrJHQcaE0QG/f1/ewgiKn3gHZ0Ptj6+rh/xw+XFW0B8wRZ+1MVUOop2zR/ZkCmPKXvSn+icug/ib5f7Tm8DR3322hTUHpxKFQ+WQCMVttwnD4jnDidDhUjD5hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id ADD432F20259; Thu, 15 Feb 2024 20:34:08 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id C1BB12F20259;
	Thu, 15 Feb 2024 20:34:06 +0000 (UTC)
From: kovalev@altlinux.org
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jacob.e.keller@intel.com,
	kovalev@altlinux.org
Subject: [PATCH] devlink: fix possible use-after-free and memory leaks in devlink_init()
Date: Thu, 15 Feb 2024 23:34:00 +0300
Message-Id: <20240215203400.29976-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasiliy Kovalev <kovalev@altlinux.org>

The pernet operations structure for the subsystem must be registered
before registering the generic netlink family.

Make an unregister in case of unsuccessful registration.

Fixes: 687125b5799c ("devlink: split out core code")
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 net/devlink/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 4275a2bc6d8e06..b3178512878d65 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -529,14 +529,20 @@ static int __init devlink_init(void)
 {
 	int err;
 
-	err = genl_register_family(&devlink_nl_family);
-	if (err)
-		goto out;
 	err = register_pernet_subsys(&devlink_pernet_ops);
 	if (err)
 		goto out;
+	err = genl_register_family(&devlink_nl_family);
+	if (err)
+		goto out_unreg_pernet_subsys;
 	err = register_netdevice_notifier(&devlink_port_netdevice_nb);
+	if (!err)
+		return 0;
+
+	genl_unregister_family(&devlink_nl_family);
 
+out_unreg_pernet_subsys:
+	unregister_pernet_subsys(&devlink_pernet_ops);
 out:
 	WARN_ON(err);
 	return err;
-- 
2.33.8


