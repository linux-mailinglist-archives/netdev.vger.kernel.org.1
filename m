Return-Path: <netdev+bounces-167494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E70A3A800
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB97A173B10
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3521EB5CA;
	Tue, 18 Feb 2025 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBDNRjwU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EE51E833E
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739908251; cv=none; b=qETK21L8VYHdCLNGZSXLJasmWUyu4CEJLb1jNrTx9r4L1QWQ2qdDVW4ArKKHZSzR4BcSJwMZxQ3WJpaLEP6KMBgnVbfBRFk0w8GyJw0nAgsbmKddZLcwOX99DcS+L0JZaaLB9SG04h5HtN8mydlxSAZ5NGvg9GteypGsn1I58Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739908251; c=relaxed/simple;
	bh=NLx9GZyFLU6g3QBAaFtCVw1r3jWF/wCxM/hGRYyzJUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5awGfgNnGVIqEqZipsarj8yQtIewGHafVDcGMZPGu0T/30+NcPklgp7n63wMnqEJW9sxoxWiE0lC54yfMHIa8agauE3hgSJ2NqpyNBKMrv+XbJdto28khgezVwohLAmxH4bmBU2kxcXVSqEiCBSA2XgE0wt+/qvZ/VLG1htfXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBDNRjwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6400C4CEEA;
	Tue, 18 Feb 2025 19:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739908251;
	bh=NLx9GZyFLU6g3QBAaFtCVw1r3jWF/wCxM/hGRYyzJUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EBDNRjwUgj2D6/ACMYwrPTC2kC5YH3i9/uNOczAPxm32XZF+pBsKs+Vlol030kCB2
	 p/lSlH1RBcngjiD0IGQ59mFUlgQncBWWkxIFD5RPyWUT65VvRDO9YLx0kgIAB765DP
	 Bjb4DF7FYT8dJkOZ1gUdEr+g2oPwbnaGLvbIserlaH7qtJhWC1ssMD86305QexyQOY
	 q3p7q404kerY1kWl/JG5iWeHMq8PSe54OGSU4u/Qqhzh2UJWY09Meec1uDZsftlHXH
	 0GTLzxhhGitGVFRKEg6n3VE9DUmI83ivWIq0tcwl+BkB9I6FGXLzUxZSqh+3oOUxKD
	 m2ClmF7r4m2LA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	petrm@nvidia.com,
	jdamato@fastly.com,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/4] selftests: drv-net: use cfg.rpath() in netlink xsk attr test
Date: Tue, 18 Feb 2025 11:50:45 -0800
Message-ID: <20250218195048.74692-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218195048.74692-1-kuba@kernel.org>
References: <20250218195048.74692-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cfg.rpath() helper was been recently added to make formatting
paths for helper binaries easier.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/queues.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
index 5fdfebc6415f..b6896a57a5fd 100755
--- a/tools/testing/selftests/drivers/net/queues.py
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -25,8 +25,7 @@ import subprocess
     return None
 
 def check_xdp(cfg, nl, xdp_queue_id=0) -> None:
-    test_dir = os.path.dirname(os.path.realpath(__file__))
-    xdp = subprocess.Popen([f"{test_dir}/xdp_helper", f"{cfg.ifindex}", f"{xdp_queue_id}"],
+    xdp = subprocess.Popen([cfg.rpath("xdp_helper"), f"{cfg.ifindex}", f"{xdp_queue_id}"],
                            stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=1,
                            text=True)
     defer(xdp.kill)
-- 
2.48.1


