Return-Path: <netdev+bounces-196671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0900AD5D67
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 19:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 726687ABE70
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 17:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B66204096;
	Wed, 11 Jun 2025 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjHvxKUy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69341273FE
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749664006; cv=none; b=iIXWw/t/S+eMxYc+POcnDsD2F744jXZyEQbKeiZr3jTo12nYDPhtnT3D3CQ3O3kbpPX5crMFftEk481uW/ucC4t0x5YgIPHZdeZ+9zpc9JRfTnOI3KuH/K37cxIgAVoyEocjuA2Ps8cb6/s+TtXjnBaLjUOWgCjeViDd6VrK4/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749664006; c=relaxed/simple;
	bh=Uah8nOC5sBq39D5mMDtdMlFlA738Qynzcjz2QMVFZrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ow5WHVpXlfzo6ThtWb0fSKa7SJQDNg6mb5IZlvkJ2Pp1P7mtHmHfkembTuTO19CdkkcP/xjzs5ZkNc7gG33rIrC5YejecGXh5BF8Ny6H3NoorlHHVEiM0KZEion1lzhUucdSbnucWkpeP9JjiR9itmq33f8Y0ClJSJQ/iiXjI4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjHvxKUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE86C4CEE3;
	Wed, 11 Jun 2025 17:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749664004;
	bh=Uah8nOC5sBq39D5mMDtdMlFlA738Qynzcjz2QMVFZrQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ZjHvxKUy7saaKsn+avSG1kFOb4tby3ru2Dk4ZFXY5oz3AjrDbB+avHyPUCNlOlV1S
	 CIRvF8xP/DiFKSJ9w7cZhVFNv+0D6AYI/TG0zXa3nCFMi8FfVapELKsFakrZ1a8hlM
	 Ag9w78eYsqBRDa9n5ijWNreYGt18jKCEUcEsNjC9Su0N5fGNjOpv3PFLxKj1exxzq3
	 lh7DWrVwGlBkEcZEwJBVh9S6Q3qwTWWvI4etPrcPaxtOsGvcXtnj0UgXSPYOozE6Fz
	 ENHvvHEeaUcJi/aslHz0/0VW00piCy8OBLP7XB/JHR8T+LEe9RaGGLzxoj6y+2zYzW
	 NBsq87A3l9Alw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	dw@davidwei.uk
Subject: [PATCH net] net: drv: netdevsim: don't napi_complete() from netpoll
Date: Wed, 11 Jun 2025 10:46:43 -0700
Message-ID: <20250611174643.2769263-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdevsim supports netpoll. Make sure we don't call napi_complete()
from it, since it may not be scheduled. Breno reports hitting a
warning in napi_complete_done():

WARNING: CPU: 14 PID: 104 at net/core/dev.c:6592 napi_complete_done+0x2cc/0x560
  __napi_poll+0x2d8/0x3a0
  handle_softirqs+0x1fe/0x710

This is presumably after netpoll stole the SCHED bit prematurely.

Reported-by: Breno Leitao <leitao@debian.org>
Fixes: 3762ec05a9fb ("netdevsim: add NAPI support")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: dw@davidwei.uk
---
 drivers/net/netdevsim/netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index af545d42961c..fa5fbd97ad69 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -371,7 +371,8 @@ static int nsim_poll(struct napi_struct *napi, int budget)
 	int done;
 
 	done = nsim_rcv(rq, budget);
-	napi_complete(napi);
+	if (done < budget)
+		napi_complete_done(napi, done);
 
 	return done;
 }
-- 
2.49.0


