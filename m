Return-Path: <netdev+bounces-71156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121ED8527B4
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 04:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DC61F2325E
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 03:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63875A92E;
	Tue, 13 Feb 2024 03:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dw3CQuHz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6B812E48
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 03:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707794273; cv=none; b=EtHgO+RKGDuBds/UvQIN4R+/EjkXKVpoPTmz6HXCCxuVKyEY/pqfuBpIw0BjKZpLawmyUfcYLXGmV5eH5KJbM/qYuyG1EX5ewdwWcQHJGBhoZqPGHSY5vbPRxLFtPfifHxUv7s33hQfPn7D1tmV44RxoGV5ojV80+oTtCAjsYTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707794273; c=relaxed/simple;
	bh=7QnbyZv639A7+qtsKxlPKa2Tv7exBq//jqAxjNG5mMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VBCZJwRehLH/3rnii7ESxcLpL1MHwZrsMIZzG4OEN6oPOFLCJHlnhxSqMcFoHRlKKJG/r6fnLUNVbCLfktWSURFP5hBqj+FSBn667x15Grb7Ibv93ioKB5Wzct2AZ6ywP9Bm7AP/C6vy+dor9BOJqP0ghU1aI6Ajap5sMaWRc1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dw3CQuHz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707794270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sWJRAqDENff6rxpAFGcRw8+X7K0Hop6D3F2FzfpiRoo=;
	b=dw3CQuHziPuS3cYgdQv6DIskumgCIEI2Fc0aZ8NVQki6EdPvpdJRi5ayfpbWCmnNI4hr85
	mdCuaBpYQSO6TC/B6ZcsrJQI1USsfWfUVhhq1lUpqM0eWCsvQir/pmqQfHfWvjR1II++AM
	yf2y786astyRf7aG9pXuoLOL/TPkoZM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-r6pCNxRROpqPsvC2sqzx-w-1; Mon,
 12 Feb 2024 22:17:47 -0500
X-MC-Unique: r6pCNxRROpqPsvC2sqzx-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A057383CCE3;
	Tue, 13 Feb 2024 03:17:47 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.33.232])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A15051C060AF;
	Tue, 13 Feb 2024 03:17:46 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Shay Agroskin <shayagr@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH net-next] net: ena: Remove redundant assignment
Date: Mon, 12 Feb 2024 22:17:18 -0500
Message-ID: <20240213031718.2270350-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

There is no point in initializing an ndo to NULL, therefor the
assignment is redundant and can be removed.

Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 1c0a7828d397..88d7e785e10f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2867,7 +2867,6 @@ static const struct net_device_ops ena_netdev_ops = {
 	.ndo_get_stats64	= ena_get_stats64,
 	.ndo_tx_timeout		= ena_tx_timeout,
 	.ndo_change_mtu		= ena_change_mtu,
-	.ndo_set_mac_address	= NULL,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_bpf		= ena_xdp,
 	.ndo_xdp_xmit		= ena_xdp_xmit,
-- 
2.43.0


