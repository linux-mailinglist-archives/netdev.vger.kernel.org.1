Return-Path: <netdev+bounces-178147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88603A74EB2
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 17:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F9E1890A0D
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 16:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F194D1CEE8D;
	Fri, 28 Mar 2025 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsuv6XFC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD69717F7
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743180467; cv=none; b=SknxYEDqy15AcpMMUnBzCCLaJudHiq2FNZPGJBgENrwvNpCzNhUFQQP/k7rhK13/izeveQvllxnelJ3Vdzxq5V24pEbAqDs6oquGimtcQmeQlWV03gsvcFtiwK3cnrsCXQQlRw29qWcSu4aPSKfGsE00x4Kwttf2yMdjOTdDaS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743180467; c=relaxed/simple;
	bh=Lgh1usXZ7BJLqRjptBGWv+q6RYJAhA9COqNHTPYHQ28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E7e+U67aqtShV8bSCHlppjvsUK9LT2xIKa/lz0dPmdQQ2eSaZnkhAmO50BZUyzy1yQtlLh5NYjpPVbtS6Etbkmg5xLgoNvSgiz9VwgsS2MVrXY/kZyAwFQQioxq2es8IuHxS7THTxMwc2RxXzYZZtralHIBEUu8MbgmLebIOeGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsuv6XFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D173CC4CEE4;
	Fri, 28 Mar 2025 16:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743180466;
	bh=Lgh1usXZ7BJLqRjptBGWv+q6RYJAhA9COqNHTPYHQ28=;
	h=From:To:Cc:Subject:Date:From;
	b=hsuv6XFCJ56PXfPmm4Nj/DdntuiW1W0GrLkU38YBUBK6brdHI/UL3mpkeXIJLzFI1
	 ThtENW9TG6YuQmJPL61sQ1wffZPMpNPTznO2K2ZYt6MRm6CZbYuzagb5sFuqdHtlPD
	 s32LSS/ndM4tS5NjsvURs6RwfTioUp3ntdG5PQgFgtdMb47gsYx/jP4n/QY5RdPO8C
	 AVndhHO7maYXnh8QrNyV4HlWYi5gmcjiPIRcWES/k91PRg4iK3DXm7zRRhRMxvzT3R
	 NYziYrCWf+HsBnma+xajL2j4ESr0gQhAxlttSxtmaUxFocAEeCoZ8hsTtcZo98iXFy
	 j1us0uOHk0/HQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	jeroendb@google.com,
	hramamurthy@google.com,
	pkaligineedi@google.com,
	willemb@google.com,
	shailend@google.com,
	joshwash@google.com,
	sdf@fomichev.me
Subject: [PATCH net] eth: gve: add missing netdev locks on reset and shutdown paths
Date: Fri, 28 Mar 2025 09:47:42 -0700
Message-ID: <20250328164742.1268069-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All the misc entry points end up calling into either gve_open()
or gve_close(), they take rtnl_lock today but since the recent
instance locking changes should also take the instance lock.

Found by code inspection and untested.

Fixes: cae03e5bdd9e ("net: hold netdev instance lock during queue operations")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jeroendb@google.com
CC: hramamurthy@google.com
CC: pkaligineedi@google.com
CC: willemb@google.com
CC: shailend@google.com
CC: joshwash@google.com
CC: sdf@fomichev.me
---
 drivers/net/ethernet/google/gve/gve_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index cb2f9978f45e..f9a73c956861 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2077,7 +2077,9 @@ static void gve_handle_reset(struct gve_priv *priv)
 
 	if (gve_get_do_reset(priv)) {
 		rtnl_lock();
+		netdev_lock(priv->dev);
 		gve_reset(priv, false);
+		netdev_unlock(priv->dev);
 		rtnl_unlock();
 	}
 }
@@ -2714,6 +2716,7 @@ static void gve_shutdown(struct pci_dev *pdev)
 	bool was_up = netif_running(priv->dev);
 
 	rtnl_lock();
+	netdev_lock(netdev);
 	if (was_up && gve_close(priv->dev)) {
 		/* If the dev was up, attempt to close, if close fails, reset */
 		gve_reset_and_teardown(priv, was_up);
@@ -2721,6 +2724,7 @@ static void gve_shutdown(struct pci_dev *pdev)
 		/* If the dev wasn't up or close worked, finish tearing down */
 		gve_teardown_priv_resources(priv);
 	}
+	netdev_unlock(netdev);
 	rtnl_unlock();
 }
 
-- 
2.49.0


