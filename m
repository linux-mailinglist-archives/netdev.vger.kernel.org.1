Return-Path: <netdev+bounces-217516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57401B38F56
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 01:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190955E802F
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 23:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082F130F932;
	Wed, 27 Aug 2025 23:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCgTlRnC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D678C2E0B5B
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756338215; cv=none; b=l3POBcGyJ1g3GWYSC2fD1ljg9YzhYhbniAkZH4OEftPC10GPml/5WaEDV7WMN7sP1IPSJIEX14VfxzA0xJvASpvTuHfjHdebjblSKDN49y2fMT0JB48fMGSl0iLujOHKejkFcNFczRxW5eqqfflxwA715z1b4NXkgj1ulKC4Snw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756338215; c=relaxed/simple;
	bh=2LLH/roDZj+bbYWjOuLxmmWqfvNsjFtwdsAdGunuMWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eWjC6ics40suhUEMNS/RbBCoRh7yj66FOgW/jdqkx7PwOLvPbnABvwmUZRvQDQ3lUBHoL6wBhF+6TJ84JHHS16j+eO11ny41xPi1snCNM9eArwuSt4r4k1ewp0pMU13/bl6RvYHVsxW++qaHIIGu23gxHehgrp/lREfy2Oea/Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCgTlRnC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63F1C4CEEB;
	Wed, 27 Aug 2025 23:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756338215;
	bh=2LLH/roDZj+bbYWjOuLxmmWqfvNsjFtwdsAdGunuMWo=;
	h=From:To:Cc:Subject:Date:From;
	b=NCgTlRnCNvUYQROK8rs01+677xcxKfxW1npqS9jHrX5lYsqC9cPBbQQ1/ysdPmnxF
	 OI4C15syG+ITIGLjqkln22g9f6/gUNH9pEy3Qf4jrsDX+VyLtv1dGzZgFE8C5vgy+N
	 cTsrAgE4834V5u8Ou+49DJCxd2zS/6mloBguNunGcY15x/EfDlZIk7ARAacF+HsHtn
	 kPRlxWeo1poMCgkeOY4nDJ4sPkG0f6AyZnJBD7WhLMxSc7T7Ae4tn4ZEDpHuB0orwG
	 Y8CCFRQozzaEUZUlax4BmnMUR20qHRf2NK+Eu9OYDWhsQVzFRx5tpWzXRbCJWqLOvb
	 1OWtiWz0Oum+A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com
Subject: [PATCH net-next] eth: mlx5: remove Kconfig co-dependency with VXLAN
Date: Wed, 27 Aug 2025 16:43:19 -0700
Message-ID: <20250827234319.3504852-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx5 has a Kconfig co-dependency on VXLAN, even tho it doesn't
call any VXLAN function (unlike mlxsw). Perhaps this dates back
to very old days when tunnel ports were fetched directly from
VXLAN.

Remove the dependency to allow MLX5=y + VXLAN=m kernel configs.
But still avoid compiling in the lib/vxlan code if VXLAN=n.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: saeedm@nvidia.com
CC: leon@kernel.org
CC: tariqt@nvidia.com
CC: mbloch@nvidia.com
---
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig  | 1 -
 drivers/net/ethernet/mellanox/mlx5/core/Makefile | 4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
index 6ec7d6e0181d..8ef2ac2060ba 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
@@ -8,7 +8,6 @@ config MLX5_CORE
 	depends on PCI
 	select AUXILIARY_BUS
 	select NET_DEVLINK
-	depends on VXLAN || !VXLAN
 	depends on MLXFW || !MLXFW
 	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on PCI_HYPERV_INTERFACE || !PCI_HYPERV_INTERFACE
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index a253c73db9e5..206223ce63a8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -85,7 +85,9 @@ mlx5_core-$(CONFIG_MLX5_BRIDGE)    += esw/bridge.o esw/bridge_mcast.o esw/bridge
 
 mlx5_core-$(CONFIG_HWMON)          += hwmon.o
 mlx5_core-$(CONFIG_MLX5_MPFS)      += lib/mpfs.o
-mlx5_core-$(CONFIG_VXLAN)          += lib/vxlan.o
+ifneq ($(CONFIG_VXLAN),)
+	mlx5_core-y		   += lib/vxlan.o
+endif
 mlx5_core-$(CONFIG_PTP_1588_CLOCK) += lib/clock.o
 mlx5_core-$(CONFIG_PCI_HYPERV_INTERFACE) += lib/hv.o lib/hv_vhca.o
 
-- 
2.51.0


