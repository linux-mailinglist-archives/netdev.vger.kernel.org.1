Return-Path: <netdev+bounces-115373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D744E9460B4
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 17:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F73DB2364A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B395B136327;
	Fri,  2 Aug 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6BnkVgQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90803175D56
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613415; cv=none; b=fuVbv4k5WsmnK6iG30MOFBqg542m8GGL5dN9KPJHnZMmRkrM2UHiKQ9rrJMrQSW5UJTmKriXHJI8CyXPq3CHqlFLscpFkSGsMwu3wBJHChohpJ7KbdKDJpjnnUtajEw18JOA8LS7P8beMJ51z1LSSsF0GpQbn3tiIagwY5nPP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613415; c=relaxed/simple;
	bh=xh19M0hf5gp2mMCQ6SAGxV6urD3d20jD25i5l7K9K1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DJdP5TFiSyMmNo3SDCjlH1dIl/anMz6nxf7cYVg5oK4ASSjyGLO+I9lBmY39CQidbRN53pU+/IdoNTZtjpU5nYjFeyzfCvnLmoOgG8Az4eDRy91RDuExWGjsJokhDQg3xypvFMDjr7RDmq4u/pXDLcmCovVM8W4aWXps/iS5odM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6BnkVgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E133EC4AF0A;
	Fri,  2 Aug 2024 15:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722613415;
	bh=xh19M0hf5gp2mMCQ6SAGxV6urD3d20jD25i5l7K9K1Y=;
	h=From:Date:Subject:To:Cc:From;
	b=N6BnkVgQ7U+p0AiEgnRjr7MLDn0oyBFg7c65UrJBoCoBEHNxvcVScEoZL1RuCKtpi
	 N6/DjGZ+fzktXtXTimMu9RkzS2xnbSNIQsA1L4dCb9dMQx4sOH1efWffnNNhY0ndRM
	 TwP4AYcIcgkn6k1uWEdKnPCPcp9OjEOqMw0dcid9R3q3ZAslz4xp0SiexniPnBQxv4
	 GC3h34PHWBMucIKZRDdcscLDHzV/BbZAp4BiQ53PJJfI/7/r9+iAJndsiaJ1pE00c7
	 sB4LkWoWFRSMbbOIAO5pi1V9NEoOeRfhSQI1zKatrFHNkhFXYaMjXQlD8vXWfqdWfm
	 Jkr7TlFbdhAGA==
From: Simon Horman <horms@kernel.org>
Date: Fri, 02 Aug 2024 16:43:17 +0100
Subject: [PATCH net-next v2] eth: fbnic: select DEVLINK and PAGE_POOL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-fbnic-select-v2-1-41f82a3e0178@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJT+rGYC/x3MQQqDMBBG4avIrB0YQ0TrVYqLGH/bgTKWJIgg3
 r2hy2/x3kUZSZFpai5KODTrbhWubSi+g73AulaTE+dlFMfbYho544NYeByC7+Sxdl56qsk3YdP
 zv3uSobDhLDTf9w/0oWROaAAAAA==
To: Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>, 
 Kernel Test Robot <lkp@intel.com>, kernel-team@meta.com, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.0

Build bot reports undefined references to devlink functions.
And local testing revealed undefined references to page_pool functions.

Based on a patch by Jakub Kicinski <kuba@kernel.org>

Fixes: 1a9d48892ea5 ("eth: fbnic: Allocate core device specific structures and devlink interface")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408011219.hiPmwwAs-lkp@intel.com/
Signed-off-by: Simon Horman <horms@kernel.org>
---
-- 
Changes since v1:
* Also select PAGE_POOL
* Link to v1: https://lore.kernel.org/netdev/20240802015924.624368-1-kuba@kernel.org/
---
 drivers/net/ethernet/meta/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/meta/Kconfig b/drivers/net/ethernet/meta/Kconfig
index c002ede36402..85519690b837 100644
--- a/drivers/net/ethernet/meta/Kconfig
+++ b/drivers/net/ethernet/meta/Kconfig
@@ -23,6 +23,8 @@ config FBNIC
 	depends on !S390
 	depends on MAX_SKB_FRAGS < 22
 	depends on PCI_MSI
+	select NET_DEVLINK
+	select PAGE_POOL
 	select PHYLINK
 	help
 	  This driver supports Meta Platforms Host Network Interface.


