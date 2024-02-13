Return-Path: <netdev+bounces-71462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5238535C5
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 17:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73CBA1F248EE
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 16:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC305DF29;
	Tue, 13 Feb 2024 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmbNtoWM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448B55F840
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840923; cv=none; b=k/lgiIE98eq+KQuvGKqEMw9+jYzOZ4I5q+bkyBfxJd+D6/Z3EpfzeaPHGATo+Pgt1uH3OELPYD4a/UCNL0+Azu3RGClytkwpmkLHRbE2X6tMPS+wc0IUVDpBPKT6rF78s1LX3BczxqFeJRbsd5eaNhKIGsX5I8Jvs43oorHR3Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840923; c=relaxed/simple;
	bh=97SB8pqr6LD3Kh4WNx54N8OiBp0HHD44F7ZoUlu0efM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7Ravo6jBNQSpf7RFWw+bsExo5RauNn0fVdvoSrSRqy0E1HYyL1cuOFJqh6RNqt0Lrn2gPa24kUdwWUFmP56W/cRXg4Suev8nZM8xbOiZVo/uAEfkUbgOzURp31TLxvzpm41eOWj/E/wDiYe0nAtCeut76TSEa8yy57vP+Scv1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LmbNtoWM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707840921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x9aBx/puW5q0zP1GymR9YWTP+crwFcDPpAc0PIJBdQI=;
	b=LmbNtoWMFyDrfP+npbwayHpAAOSVStSnC9R7OP5x3djXNITtWkRSodVDwRhx2qXAlaFXbe
	EpGm+MGzPTY/ZZn4ATqiCBxXH0oV7B2lHzkwlStnPo9B7icHc/xYRbZisiJN5Gq76TeQbE
	gdWrHqK0AA6cHXUhRdq4gIv8gJWp9tk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-_NWDzBX3M_uHIyIOZbUkkg-1; Tue, 13 Feb 2024 11:15:17 -0500
X-MC-Unique: _NWDzBX3M_uHIyIOZbUkkg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 220FA1005055;
	Tue, 13 Feb 2024 16:15:17 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.33.232])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A5F7F492C2D;
	Tue, 13 Feb 2024 16:15:16 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Shay Agroskin <shayagr@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH net-next] net: ena: Remove unlikely() from IS_ERR() condition
Date: Tue, 13 Feb 2024 11:15:02 -0500
Message-ID: <20240213161502.2297048-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

IS_ERR() is already using unlikely internally.

Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 03be2c008c4d..10e70d869cce 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -545,7 +545,7 @@ static int ena_alloc_rx_buffer(struct ena_ring *rx_ring,
 
 	/* We handle DMA here */
 	page = ena_alloc_map_page(rx_ring, &dma);
-	if (unlikely(IS_ERR(page)))
+	if (IS_ERR(page))
 		return PTR_ERR(page);
 
 	netif_dbg(rx_ring->adapter, rx_status, rx_ring->netdev,
-- 
2.43.0


