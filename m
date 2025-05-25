Return-Path: <netdev+bounces-193248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C0FAC335E
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 11:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B8F3A7FE8
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087F51DF260;
	Sun, 25 May 2025 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UV0MBtNN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8462DCC03;
	Sun, 25 May 2025 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748164989; cv=none; b=Uqr7cn0VjDgb2IironCpgjaLvqo1QTtr+UyMBclhHDfrtBsFWCxssGNR11zywDOGDExmSMylIQAuL/OxoLFFtutCl5S4qpNbH2PXyJK89/UbpYdajxC9L+g48zPUfhJitSXVJ1XsBZzOmxEgkuhIPIciFpkCrS5SbcMlCRb6Ivg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748164989; c=relaxed/simple;
	bh=uvHTxQ84Ysob1tsgW2B03xQqPXtMT7RwsE2x2QwnLoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A9iNmkHs9SjB5ATmrmdluSmLcPcjKVsDhYfoH7H6VruMk+EheZufZDRwPWmRaMwVOy6jfnnVTZJV7V9KPHyt9oyf33+uxkt+nCG7eBlUWyk6vTYHibYdmMaVTgEDrNEc/BIKnu1+WOfYmQmQUJdlWpICJDbbwabeDMiJ/iIKJ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UV0MBtNN; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id J7QBu3SUfgtceJ7QBuSZBl; Sun, 25 May 2025 11:13:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1748164415;
	bh=CUMAhSXxdBVNza4s5knUWYkuEAmOJkwcH4eDMlwo1C8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UV0MBtNNbiyONMxMtKBia+gag2nRRiRAz6Jh/6+Ec6vto5IeYF8g/ZzNlgUcMgIXL
	 8GwqCHoHjNQ5OFjYMfVqHL3qFCiB3EOLXK8ZykEelaRTyPGDY34VBcyRYI+YPV0okv
	 3ccDcu17S39Bw27HWfdQbfLma06K8HyEv62k422+r4XxhIi81yyOtKY0JFXcJag8yy
	 I9BfdmuRTBeFhCtgTuc187I15LRbFqM9aQFEEbRBCb9Sez7flF6Panw+0zVO59hC3w
	 sHQq8ra2OBpLtieWAsZd3VOtPStmRd/HLw9nyIie5mACQF7ufbFtK8Uh/9ZW6Xrf/p
	 InNq7mZQ58DwQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 25 May 2025 11:13:35 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] mlxsw: core_thermal: Constify struct thermal_zone_device_ops
Date: Sun, 25 May 2025 11:13:17 +0200
Message-ID: <4516676973f5adc1cdb76db1691c0f98b6fa6614.1748164348.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct thermal_zone_device_ops' are not modified in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

While at it, also constify a struct thermal_zone_params.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  24899	   8036	      0	  32935	   80a7	drivers/net/ethernet/mellanox/mlxsw/core_thermal.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  25379	   7556	      0	  32935	   80a7	drivers/net/ethernet/mellanox/mlxsw/core_thermal.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only,
---
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index e746cd9c68ed..eac9a14a6058 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -205,11 +205,11 @@ static int mlxsw_thermal_get_temp(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static struct thermal_zone_params mlxsw_thermal_params = {
+static const struct thermal_zone_params mlxsw_thermal_params = {
 	.no_hwmon = true,
 };
 
-static struct thermal_zone_device_ops mlxsw_thermal_ops = {
+static const struct thermal_zone_device_ops mlxsw_thermal_ops = {
 	.should_bind = mlxsw_thermal_should_bind,
 	.get_temp = mlxsw_thermal_get_temp,
 };
@@ -252,7 +252,7 @@ static int mlxsw_thermal_module_temp_get(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static struct thermal_zone_device_ops mlxsw_thermal_module_ops = {
+static const struct thermal_zone_device_ops mlxsw_thermal_module_ops = {
 	.should_bind	= mlxsw_thermal_module_should_bind,
 	.get_temp	= mlxsw_thermal_module_temp_get,
 };
@@ -280,7 +280,7 @@ static int mlxsw_thermal_gearbox_temp_get(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static struct thermal_zone_device_ops mlxsw_thermal_gearbox_ops = {
+static const struct thermal_zone_device_ops mlxsw_thermal_gearbox_ops = {
 	.should_bind	= mlxsw_thermal_module_should_bind,
 	.get_temp	= mlxsw_thermal_gearbox_temp_get,
 };
-- 
2.49.0


