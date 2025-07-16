Return-Path: <netdev+bounces-207547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D21B07B95
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 18:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9825016B88E
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E2817BD6;
	Wed, 16 Jul 2025 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQa2iTQY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1728C283FE0
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752685118; cv=none; b=IfqsSlk7saaOpZFHIWCf6aY5fHemuPxPuUCYf58j5/WBLKvNGLNGg2ZRZo3OYMrEsvGSOpHmv39N0KdPkUQBmebbFEqx07c/6tzw6n3src/h+aRFmkZzblLDArgk6my8e/l+0H78hRIYl26P0Erjimt0/V121fzr/sFvTm3Lfkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752685118; c=relaxed/simple;
	bh=znrtFd+3pYrmNj/6KkuxGD/t0thGTxPuFhvo/fit7ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KvlYg4zOdQbzLksdG6nPeCrsv9o1D8HxcTzhnZtcatlulSCNuGoIKjnuFXTxbG5e0uxoX0BS9/GLRYs+HB/qVmU1ErI9nAaer8ucHTgxLecDLOJOaqUkFQGlweu+64GxLgd2ivx7ej0lKAMQT4pB//sYKJnu9Luk4D0v+nM7qso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HQa2iTQY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752685112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iWqtSmFsDIQIAJPIXD1c3vNONug1HVQ3+lu1znbDl1c=;
	b=HQa2iTQYspEMQFaNvMB4Elzssfj9QTWNDtBGh0YTWq4I53QOzpaPJ8Y4zV96oUOgulrhUp
	C1r9+C3HP1jUAvFFq9a96Hpw0gtSRtZvi7wkaORCs0B4TvxmCsb/oh2In/e8HtMXWaJxmB
	rCZeTvnBxNhHST5hljHT0rgbT50IopE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-aFBPGWBUNOWLoGpr4XTxBA-1; Wed,
 16 Jul 2025 12:58:29 -0400
X-MC-Unique: aFBPGWBUNOWLoGpr4XTxBA-1
X-Mimecast-MFC-AGG-ID: aFBPGWBUNOWLoGpr4XTxBA_1752685108
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E3A7180028C;
	Wed, 16 Jul 2025 16:58:28 +0000 (UTC)
Received: from lima-lima (unknown [10.22.82.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B815519560AB;
	Wed, 16 Jul 2025 16:58:26 +0000 (UTC)
From: Dennis Chen <dechen@redhat.com>
To: netdev@vger.kernel.org
Cc: dechen@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netdevsim: remove redundant branch
Date: Wed, 16 Jul 2025 12:57:50 -0400
Message-ID: <20250716165750.561175-1-dechen@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

bool notify is referenced nowhere else in the function except to check
whether or not to call rtnl_offload_xstats_notify(). Remove it and move
the call to the previous branch.

Signed-off-by: Dennis Chen <dechen@redhat.com>
---
 drivers/net/netdevsim/hwstats.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/netdevsim/hwstats.c b/drivers/net/netdevsim/hwstats.c
index 66b3215db3acd..1abe48e35ca3a 100644
--- a/drivers/net/netdevsim/hwstats.c
+++ b/drivers/net/netdevsim/hwstats.c
@@ -220,7 +220,6 @@ nsim_dev_hwstats_enable_ifindex(struct nsim_dev_hwstats *hwstats,
 	struct nsim_dev_hwstats_netdev *hwsdev;
 	struct nsim_dev *nsim_dev;
 	struct net_device *netdev;
-	bool notify = false;
 	struct net *net;
 	int err = 0;
 
@@ -251,11 +250,9 @@ nsim_dev_hwstats_enable_ifindex(struct nsim_dev_hwstats *hwstats,
 
 	if (netdev_offload_xstats_enabled(netdev, type)) {
 		nsim_dev_hwsdev_enable(hwsdev, NULL);
-		notify = true;
+		rtnl_offload_xstats_notify(netdev);
 	}
 
-	if (notify)
-		rtnl_offload_xstats_notify(netdev);
 	rtnl_unlock();
 	return err;
 
-- 
2.50.1


