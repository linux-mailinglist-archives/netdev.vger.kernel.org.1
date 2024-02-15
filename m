Return-Path: <netdev+bounces-72189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A098D856E83
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 21:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FBDBB25D7B
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 20:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B11313AA5D;
	Thu, 15 Feb 2024 20:23:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA5113A879
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708028615; cv=none; b=RLRh8eKi66LrrlkzRkMlHqewx5nNuXzneZUL+3/IBZzVlp7eeIzlMSxBvFN8LABbCcDhLEQnPH2ei5MGm+0bk2qd+S2fV622BKtv9vEJPQcy9/uGugLjWADDD5+Zs5hwhbljHSJchtEMea7xVNw7Vz+F+jY7mXZB9rDqjhTtcjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708028615; c=relaxed/simple;
	bh=UmTpHsje2P8xOhy5wFmXSO4HJiI8a4wYhbZ5ZFI2yY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Feb31l1zgiuuE6GD97yBMWU64yC+lzYwCVxSXuebfIaO6PqfPTA83IVNjjn2AYT7hzNZwDZcvnwzb/gfhWQN29KzEFTHBMRGv/0hbjKV67jpGfAygk/LLCIR/D5d7dzDxin88cCf3DKrLdBwrnzsqM3KM9q7BNwAUrMrmrhnb/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 527CB2F2025B; Thu, 15 Feb 2024 20:23:23 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 312CB2F20259;
	Thu, 15 Feb 2024 20:23:20 +0000 (UTC)
From: kovalev@altlinux.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net,
	idosch@nvidia.com,
	kovalev@altlinux.org
Subject: [PATCH] genetlink: fix potencial use-after-free and null-ptr-deref in genl_dumpit()
Date: Thu, 15 Feb 2024 23:23:09 +0300
Message-Id: <20240215202309.29723-1-kovalev@altlinux.org>
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

Fixes: 134e63756d5f ("genetlink: make netns aware")
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 net/netlink/genetlink.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 8c7af02f845400..3bd628675a569f 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1879,14 +1879,16 @@ static int __init genl_init(void)
 {
 	int err;
 
-	err = genl_register_family(&genl_ctrl);
-	if (err < 0)
-		goto problem;
-
 	err = register_pernet_subsys(&genl_pernet_ops);
 	if (err)
 		goto problem;
 
+	err = genl_register_family(&genl_ctrl);
+	if (err < 0) {
+		unregister_pernet_subsys(&genl_pernet_ops);
+		goto problem;
+	}
+
 	return 0;
 
 problem:
-- 
2.33.8


