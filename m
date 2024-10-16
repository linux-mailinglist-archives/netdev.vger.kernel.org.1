Return-Path: <netdev+bounces-136044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C81D59A0153
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 08:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11381C22102
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 06:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8313B18CC1B;
	Wed, 16 Oct 2024 06:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDuKTfsf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5F60B8A;
	Wed, 16 Oct 2024 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059789; cv=none; b=Nl7LJ4uReJy2JhO9i1AKSMOJVcUx4fTP8JzxQnRpwG3qV5k8WkkDQjDEdehDEujvVHJYCtYygTscvh8fbjTy6YCneQaVoMuFPtG6loPfkj2k6MLTrAHL6Fu/7/8vTIkqyjpolCHEGkLsFtwyEIm1JV1w+ivFN1DW/auhVRMUSAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059789; c=relaxed/simple;
	bh=9/Awi+ArhEANRER83g2LYfAGAW5xtoAqhywO3+Wyt7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=crv+EPJat4mPCnlYFGz7/Q+NAaarOOsfA+kn7s6n2GEbEk1mN59a5ijw4FRqy4gOTm358MbRnp1Te4Fj2gh0MVZ+4g/whAuzR9kiBOvQzHHj8b7rRIAKva5tdln5dqoQ54I3/VbNdS9NWHE54lc2wKx3QLwp1e90Sui/iSpdRxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDuKTfsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9C4C4CEC5;
	Wed, 16 Oct 2024 06:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729059788;
	bh=9/Awi+ArhEANRER83g2LYfAGAW5xtoAqhywO3+Wyt7k=;
	h=From:To:Cc:Subject:Date:From;
	b=NDuKTfsf+GnDeUf9ZAjQAGu1Fj/a2QNa/0VHfvudTHbPg9SO7KX6s++jhqDGaBkMt
	 Oo0dsYUyPObbfi6ZhAmGOBABfgs9NSIr5z6Ct4OSR8/5STHis/O5rEH/AxAvxXRa4j
	 2UdajvRrMDoXXknV4MWG+yDmGhhI91LDoAZZrejZMVagqU6/YzS2r2bH0ik3PMZV6y
	 4eupgAQtj6ukVf59s7WPcf6faflCN41IW0FjunVjEpiilgDJa1umlqGNMRWBNEqwM3
	 KlxOVRvlMI7jWNC3J1x7gmsguAST8b/rm3D9sXZsbh2hFIAMNdALgk6/BEtKgp6Abx
	 df7Uc2Pk83OiQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>,
	kernel-team@meta.com,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] eth: fbnic: add CONFIG_PTP_1588_CLOCK_OPTIONAL dependency
Date: Wed, 16 Oct 2024 06:22:58 +0000
Message-Id: <20241016062303.2551686-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

fbnic fails to link as built-in when PTP support is in a loadable
module:

aarch64-linux-ld: drivers/net/ethernet/meta/fbnic/fbnic_ethtool.o: in function `fbnic_get_ts_info':
fbnic_ethtool.c:(.text+0x428): undefined reference to `ptp_clock_index'
aarch64-linux-ld: drivers/net/ethernet/meta/fbnic/fbnic_time.o: in function `fbnic_time_start':
fbnic_time.c:(.text+0x820): undefined reference to `ptp_schedule_worker'
aarch64-linux-ld: drivers/net/ethernet/meta/fbnic/fbnic_time.o: in function `fbnic_ptp_setup':
fbnic_time.c:(.text+0xa68): undefined reference to `ptp_clock_register'

Add the appropriate dependency to enforce this.

Fixes: 6a2b3ede9543 ("eth: fbnic: add RX packets timestamping support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/meta/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/meta/Kconfig b/drivers/net/ethernet/meta/Kconfig
index 85519690b837..831921b9d4d5 100644
--- a/drivers/net/ethernet/meta/Kconfig
+++ b/drivers/net/ethernet/meta/Kconfig
@@ -23,6 +23,7 @@ config FBNIC
 	depends on !S390
 	depends on MAX_SKB_FRAGS < 22
 	depends on PCI_MSI
+	depends on PTP_1588_CLOCK_OPTIONAL
 	select NET_DEVLINK
 	select PAGE_POOL
 	select PHYLINK
-- 
2.39.5


