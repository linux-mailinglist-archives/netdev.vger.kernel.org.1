Return-Path: <netdev+bounces-98422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B038D15ED
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDEF1F22E8F
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C32913C80E;
	Tue, 28 May 2024 08:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="IL1LWw/G"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7590F13BC30
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883815; cv=none; b=u8jnysmNVstZpZYJV5tCNxQGkdfaqHnJGznUCAonbWVvK33ZAxABwW2BG9HUAR/K2wP+a3F3cijMLnTY4XLcYL9JRyKV61lFxSWUu0W1+iBZ0EBriInMpRqzC/KJzqX/CMZFlVaxxcuOsb3CvGZzC29K1u4yJBVXC9/MZ/9bw6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883815; c=relaxed/simple;
	bh=YdJDctJoSckcHLcu8sDTb8HINLSl4mIgP7YF35sk59c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mp4NsUCkMaHsI5qHaNkbdMXWhZz+JvPxhdX/0tVinH0EsvoSgafIkD//zOmBN98xjwXcUCawuNnnN6OO4y9X/S9GSfSH8oYB+KWmDfnaHQ3ZGQTVERdpHyFMmd8YEhjtaxaobTvghnNclLZgK7o5iy5NFnso75SdYv3CP/Pr1Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=IL1LWw/G; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202405280759592173ece50092a254f3
        for <netdev@vger.kernel.org>;
        Tue, 28 May 2024 10:00:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=hqeHiFX2feFPDsDW9TNHwgZeiG/g+0FZh77IEWKdYa0=;
 b=IL1LWw/GkXj7USF80GS/1A5v992/j7GTvt0RPdu3F9FHbu0jmKECMGSsF3MVmxkjRRv77I
 En2dCeVIKGYAe2iEdW7NWoX+k8SjrRLIBllSXuOtLmrIirF2xPwHuoECwxKQvib7rrt6gNVR
 w+CF+Bg76Db4FoxrS5+KH59wN8G3g=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Roger Quadros <rogerq@kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH net-next 0/2] net: ethernet: ti: am65-cpsw-nuss: support stacked switches
Date: Tue, 28 May 2024 09:59:48 +0200
Message-ID: <20240528075954.3608118-1-alexander.sverdlin@siemens.com>
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

Currently an external Ethernet switch connected to a am65-cpsw-nuss CPU
port will not be probed successfully because of_find_net_device_by_node()
will not be able to find the netdev of the CPU port.

It's necessary to populate of_node of the struct device for the
am65-cpsw-nuss ports. DT nodes of the ports are already stored in per-port
private data, but because of some legacy reasons the naming ("phy_node")
was misleading.

Alexander Sverdlin (2):
  net: ethernet: ti: am65-cpsw-nuss: rename phy_node -> port_np
  net: ethernet: ti: am65-cpsw-nuss: populate netdev of_node

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 7 ++++---
 drivers/net/ethernet/ti/am65-cpsw-nuss.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.45.0


