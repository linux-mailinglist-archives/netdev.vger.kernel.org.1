Return-Path: <netdev+bounces-202226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D2BAECC80
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 14:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44EC916F48C
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 12:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D67F21B8F7;
	Sun, 29 Jun 2025 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="CZnPodQB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2981D5147;
	Sun, 29 Jun 2025 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751200735; cv=none; b=BHIE057CZbJpSx5c77bA+FWYekJJzI0UrBSvngMj59VQbYlVaqUq9l6xgnMkLIB+lJ5NrO+VgWFGRv+Y0mFG9qtjog+y1uBdu2ElVTDBBqdH15AfPJTRdT8WutIX2zsCP+F+bIAMPyD5XzN19VtoSlevHEgJkJgL1h1YQlAe+P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751200735; c=relaxed/simple;
	bh=1DdA58ZvfVyvyJne9xRI6nI4Y07XDp6bvgXl/BpBMvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CYLkxZiJce7ByD8ou1KNBSW8ByIOAug3VhB0XCKUgkhVHTRJpAgSAlK7x1xMHeSTR33EGGNrR9jWoQMwyRhQdh6jPm0b4IUdYBFp/H1+jGitmJSM8ig3oqObfg65kVamhWHuGr49jQ6lAaku9GM+9eNWnq8em7LixoksjxnRFro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=CZnPodQB; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id VrHvu4ESL84Z8VrHvuRtCb; Sun, 29 Jun 2025 14:37:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1751200661;
	bh=44hnpk8QrNSS6VHiUDSP4T2PPRW+akObYkldAFkniy8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=CZnPodQBdNXT9Mr/sMliR8L8M3B2O9YmcmRwUvSGvGfZhKQqGwsx/W949L8HaBRzF
	 5lI+xSU5Oh1MExu7B4mhsUwlgERFYbpQszo5XMUdvFE4zF87rQTBHicnEtJsAXeP+v
	 Drq5OSP9unjeMaDBskJFujZSlwngw+25j0eIrlJZprFPSw5+cNOoOwhRs1BxgiM1Fq
	 miqpmitAljqyn95n98RIjIJmw8VWM4qN0ahuTE7LCxSv8QteRWCSL/9PbpEa/ZIHdh
	 mtybCwbmOxJDOIHtx/ZRJWPN/K4FUNjPqJvxp79+Q8/gsWAwyOPcLNsWqRwiSSJuid
	 awnSn1PHQL2tQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 29 Jun 2025 14:37:41 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/2] net: dsa: mv88e6xxx: Constify struct devlink_region_ops and struct mv88e6xxx_region
Date: Sun, 29 Jun 2025 14:35:49 +0200
Message-ID: <46040062161dda211580002f950a6d60433243dc.1751200453.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct devlink_region_ops' and 'struct mv88e6xxx_region' are not modified
in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  18076	   6496	     64	  24636	   603c	drivers/net/dsa/mv88e6xxx/devlink.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  18652	   5920	     64	  24636	   603c	drivers/net/dsa/mv88e6xxx/devlink.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/net/dsa/mv88e6xxx/devlink.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/devlink.c b/drivers/net/dsa/mv88e6xxx/devlink.c
index 195460a0a0d4..aec652e33fc1 100644
--- a/drivers/net/dsa/mv88e6xxx/devlink.c
+++ b/drivers/net/dsa/mv88e6xxx/devlink.c
@@ -647,7 +647,7 @@ static struct mv88e6xxx_region_priv mv88e6xxx_region_global1_priv = {
 	.id = MV88E6XXX_REGION_GLOBAL1,
 };
 
-static struct devlink_region_ops mv88e6xxx_region_global1_ops = {
+static const struct devlink_region_ops mv88e6xxx_region_global1_ops = {
 	.name = "global1",
 	.snapshot = mv88e6xxx_region_global_snapshot,
 	.destructor = kfree,
@@ -658,32 +658,32 @@ static struct mv88e6xxx_region_priv mv88e6xxx_region_global2_priv = {
 	.id = MV88E6XXX_REGION_GLOBAL2,
 };
 
-static struct devlink_region_ops mv88e6xxx_region_global2_ops = {
+static const struct devlink_region_ops mv88e6xxx_region_global2_ops = {
 	.name = "global2",
 	.snapshot = mv88e6xxx_region_global_snapshot,
 	.destructor = kfree,
 	.priv = &mv88e6xxx_region_global2_priv,
 };
 
-static struct devlink_region_ops mv88e6xxx_region_atu_ops = {
+static const struct devlink_region_ops mv88e6xxx_region_atu_ops = {
 	.name = "atu",
 	.snapshot = mv88e6xxx_region_atu_snapshot,
 	.destructor = kfree,
 };
 
-static struct devlink_region_ops mv88e6xxx_region_vtu_ops = {
+static const struct devlink_region_ops mv88e6xxx_region_vtu_ops = {
 	.name = "vtu",
 	.snapshot = mv88e6xxx_region_vtu_snapshot,
 	.destructor = kfree,
 };
 
-static struct devlink_region_ops mv88e6xxx_region_stu_ops = {
+static const struct devlink_region_ops mv88e6xxx_region_stu_ops = {
 	.name = "stu",
 	.snapshot = mv88e6xxx_region_stu_snapshot,
 	.destructor = kfree,
 };
 
-static struct devlink_region_ops mv88e6xxx_region_pvt_ops = {
+static const struct devlink_region_ops mv88e6xxx_region_pvt_ops = {
 	.name = "pvt",
 	.snapshot = mv88e6xxx_region_pvt_snapshot,
 	.destructor = kfree,
@@ -696,13 +696,13 @@ static const struct devlink_port_region_ops mv88e6xxx_region_port_ops = {
 };
 
 struct mv88e6xxx_region {
-	struct devlink_region_ops *ops;
+	const struct devlink_region_ops *ops;
 	u64 size;
 
 	bool (*cond)(struct mv88e6xxx_chip *chip);
 };
 
-static struct mv88e6xxx_region mv88e6xxx_regions[] = {
+static const struct mv88e6xxx_region mv88e6xxx_regions[] = {
 	[MV88E6XXX_REGION_GLOBAL1] = {
 		.ops = &mv88e6xxx_region_global1_ops,
 		.size = 32 * sizeof(u16)
@@ -768,7 +768,7 @@ int mv88e6xxx_setup_devlink_regions_global(struct dsa_switch *ds)
 {
 	bool (*cond)(struct mv88e6xxx_chip *chip);
 	struct mv88e6xxx_chip *chip = ds->priv;
-	struct devlink_region_ops *ops;
+	const struct devlink_region_ops *ops;
 	struct devlink_region *region;
 	u64 size;
 	int i, j;
-- 
2.50.0


