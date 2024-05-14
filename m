Return-Path: <netdev+bounces-96370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705BB8C5780
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 16:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBDA1C21B82
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 14:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A3B144D0B;
	Tue, 14 May 2024 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="YXefpqV4"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612341448C0
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695394; cv=none; b=TKqTG0qQxXBP8ssxLkoQ1fh8DSozTff74883gZOXR711YyB0c61Y8GvufBYvclVHmuRy5dIfsj0Z5YzyLb8rjkL47Gs+Ha+3zXGonH7t4eZccFRn1GShncHMGdx0m1Axqeuk5vn1J4up7p7RqXY9DzuBSWk2LJ/eeBgK9b8SayA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695394; c=relaxed/simple;
	bh=rJ1bEBTgSxSquKgwJJiKhvgfHb2b9Isu5iXQlP8lCYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imLOxKW+VKrQzb9I8GbnFkdacB7O/hFB1zcNN43y1aYZBFyIarrBE59P0lZ9ELjygvBOpvUtgZXtSfCfiY4bCqWM2/IwjfWaCmNDnsvGzCArRMo+RjlNrL4Iku7mCF4YEl4x6qwGqlNA+ffqo9oUDDmRAeRNMiOhTZIrNkhj93g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=YXefpqV4; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202405141222383a10f55a3263344500
        for <netdev@vger.kernel.org>;
        Tue, 14 May 2024 14:22:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=tsaZAj3Jx2EVatXqxBgzLIi1v9yYsiVqwyTwHBhftSA=;
 b=YXefpqV4Agi268CpNi4MsSWtVTARJapJQuFGnZm2fmbD4BfupF/yA2HVv6AT2/nrLJ5XMg
 2Z39VHrPrfk3WaRxIc/ZKRwhlHIFu5uXNId/hTKHS5Ec7LrbPWRH608EaIzQGrPlEr7icgsa
 YNdZcVdEVapD4+tGt7z80Fj5VJABQ=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Roger Quadros <rogerq@kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH 2/2] net: ethernet: ti: am65-cpsw-nuss: populate netdev of_node
Date: Tue, 14 May 2024 14:22:28 +0200
Message-ID: <20240514122232.662060-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20240514122232.662060-1-alexander.sverdlin@siemens.com>
References: <20240514122232.662060-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

So that of_find_net_device_by_node() can find cpsw-nuss ports and other DSA
switches can be stacked downstream.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index eaadf8f09c401..e6f87ac394fe6 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2703,6 +2703,7 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
 	mutex_init(&ndev_priv->mm_lock);
 	port->qos.link_speed = SPEED_UNKNOWN;
 	SET_NETDEV_DEV(port->ndev, dev);
+	port->ndev->dev.of_node = port->slave.port_np;
 
 	eth_hw_addr_set(port->ndev, port->slave.mac_addr);
 
-- 
2.44.0


