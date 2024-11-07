Return-Path: <netdev+bounces-142765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7981F9C04D5
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93431C23A62
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922EF20E335;
	Thu,  7 Nov 2024 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wr3dtCax"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C064E1E1048
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980215; cv=none; b=T8ap5Us4I6kYjl2IwrX6pRTPvpTKFw3PKd2hoo91PKWR/K5DcTIrmcyJ1pfp5veQlVfrfP/XoIy0nhjqZVROfkDbhkrs1nD4f6U/wIfwfkEAyGueKtkEaPTOsJbOHAzrTnlzRVwcJ4Yy7f/ZLQ+Vx9Vm8rBQRqWO6lBJBp0Vft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980215; c=relaxed/simple;
	bh=TmLNVfAn83sJo6dyYoeIvyKWI8wwLjOjZ/md2hOnBYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qhold5DFkITs3VLQVw0jO/afHD90/gjOBGoTf3lLTxEXJbBW2jiI3bSesj/36r4+WqJqoThwg6QJr2BC5ZixLA5bQ//d8lBH0CJyLnsgyM0/wXYtIyqVwDLKkO3QpXop3iPgqnQsC3gNY1Q8ugoXmdBX1TERUaoxojYueAEfRQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wr3dtCax; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730980212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XelEzEaUIkt9lsCzh2lI9eYg3SJvIyf2KXkRX7QzSaw=;
	b=Wr3dtCaxq8y4Ww7s4um9E7cDPGaARitymx0ESNXnx/zx3RZznR0aKk0DunqfFJoopmSsgo
	yNTC0ixZJprSf1B/qo+VQjWSkUJVZtGz9KG0TeQmwerBKyTco+c8IHva8Oc8j5axEP4rVS
	+Z39DuSD2Bjl6WqGSnY+mtfg4x91beI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-uPXkRypyOLuKvLbdHGNxdw-1; Thu,
 07 Nov 2024 06:50:09 -0500
X-MC-Unique: uPXkRypyOLuKvLbdHGNxdw-1
X-Mimecast-MFC-AGG-ID: uPXkRypyOLuKvLbdHGNxdw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AECE91956069;
	Thu,  7 Nov 2024 11:50:08 +0000 (UTC)
Received: from mheiblap.localdomain.com (unknown [10.47.238.111])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7BD61953880;
	Thu,  7 Nov 2024 11:50:06 +0000 (UTC)
From: Mohammad Heib <mheib@redhat.com>
To: netdev@vger.kernel.org,
	oss-drivers@corigine.com,
	louis.peens@corigine.com
Cc: Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net] nfp: use irq_update_affinity_hint()
Date: Thu,  7 Nov 2024 13:50:02 +0200
Message-Id: <20241107115002.413358-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

irq_set_affinity_hint() is deprecated, Use irq_update_affinity_hint()
instead. This removes the side-effect of actually applying the affinity.

The driver does not really need to worry about spreading its IRQs across
CPUs. The core code already takes care of that. when the driver applies the
affinities by itself, it breaks the users' expectations:

1. The user configures irqbalance with IRQBALANCE_BANNED_CPULIST in
   order to prevent IRQs from being moved to certain CPUs that run a
   real-time workload.

2. nfp device reopening will resets the affinity
   in nfp_net_netdev_open().

3. nfp has no idea about irqbalance's config, so it may move an IRQ to
   a banned CPU. The real-time workload suffers unacceptable latency.

Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 6e0929af0f72..98e098c09c03 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -829,7 +829,7 @@ nfp_net_prepare_vector(struct nfp_net *nn, struct nfp_net_r_vector *r_vec,
 		return err;
 	}
 
-	irq_set_affinity_hint(r_vec->irq_vector, &r_vec->affinity_mask);
+	irq_update_affinity_hint(r_vec->irq_vector, &r_vec->affinity_mask);
 
 	nn_dbg(nn, "RV%02d: irq=%03d/%03d\n", idx, r_vec->irq_vector,
 	       r_vec->irq_entry);
@@ -840,7 +840,7 @@ nfp_net_prepare_vector(struct nfp_net *nn, struct nfp_net_r_vector *r_vec,
 static void
 nfp_net_cleanup_vector(struct nfp_net *nn, struct nfp_net_r_vector *r_vec)
 {
-	irq_set_affinity_hint(r_vec->irq_vector, NULL);
+	irq_update_affinity_hint(r_vec->irq_vector, NULL);
 	nfp_net_napi_del(&nn->dp, r_vec);
 	free_irq(r_vec->irq_vector, r_vec);
 }
-- 
2.34.3


