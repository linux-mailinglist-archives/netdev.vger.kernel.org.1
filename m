Return-Path: <netdev+bounces-167924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B67A3CDD4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 00:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1F73ADF17
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C7C25EF9B;
	Wed, 19 Feb 2025 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mn7FhBCv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE90625E479
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009007; cv=none; b=fRAzo2kdD15sUKrbJK0fq8C198iJ8YOmc+ewp9gsioH+ygAc8x4S9vAwoWw1Xj6gmMdOvcVQzysJvQ2x2yyQWeVy3SZXC/tJ3zpPqKJlTiN2pOdD2M3xA3nVWK73Vy3K2MoG1p71sy392uAjwLGlVosjGdZoeW9H/PKZEqoZDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009007; c=relaxed/simple;
	bh=xEF9eVoNLJJNZj4PWeSjK79kfLFLXYFafxa5opxCOYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSvQvDRJkbBczaYaTDA/MKxzMkKK/3JtB9YtszehRT6dlK9NVXk9o03RbbJ/Nj6ju/5yQX8DZvAsqsAHBP1jKkRoeOTuGeBmhiGEnjhQKOHvd4cSOyfXEzOMI3FQFuZkJ8kHvHu5hXhOqp1Rho1AbwX8xuRsxPzziDHWAkEO0uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mn7FhBCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030A7C4CED6;
	Wed, 19 Feb 2025 23:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740009007;
	bh=xEF9eVoNLJJNZj4PWeSjK79kfLFLXYFafxa5opxCOYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mn7FhBCvzHK448m7QSPiEVQW8vqeLLDoBCUhkpQ1DFZFC68VpUmba1smK2PHkVNya
	 bisnxHa20J0EWbSyTtaYPi1oWkDfpcGNlQbWjoxCwkc10pIA9WrhQkWD7sFtmP1J6C
	 bPNoBvVDyIjTUczyZCKzi5btB6a5HFSEbo1c/PgBOJi1v50TERip/knOl2SseQn/Ts
	 nK5g5eZJ1oZAuW1sLvbqAg+o4sGeWteKi61HuTf2a6aa9/wyUgxIFDIIGumgyG0VuH
	 THg8v3ydPvva4ZC4ER4HXG3eeKv5EeBPNIL03oI+9hIGBdrXxlsDBx/XW8KHw9zpFX
	 Y1fKampqQd4DQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	stfomichev@gmail.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v2 2/7] selftests: drv-net: use cfg.rpath() in netlink xsk attr test
Date: Wed, 19 Feb 2025 15:49:51 -0800
Message-ID: <20250219234956.520599-3-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219234956.520599-1-kuba@kernel.org>
References: <20250219234956.520599-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cfg.rpath() helper was been recently added to make formatting
paths for helper binaries easier.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Joe Damato <jdamato@fastly.com>
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


