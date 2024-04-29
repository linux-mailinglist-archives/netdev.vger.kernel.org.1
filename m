Return-Path: <netdev+bounces-92154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6F18B5A3C
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 15:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC146B21D5A
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 13:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAE66A00B;
	Mon, 29 Apr 2024 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvU1gQ6E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671C23C24
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397920; cv=none; b=bsNO1ooyoEHssECsKSdQJRsFbe61ofMfJDflTtMlHEsTS4/ZIUKYOdjBR2S/bNHvtqtOnTFYntqhWF/E35Dgpr/Q0ao4Vnqy7KtkuSZjv1ap1YpCpHo05NFmcKv+QdIcP9OUYE7Ei5SBY4HyUf0Vy6H9h8vYxU9Vr1OWSdjKwuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397920; c=relaxed/simple;
	bh=tCjIq9XXF5mifq2vWnAC+idO1UTk7ra5AimNlBwYXqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ENDG0HfXEQgnjGVsOKVGKRo873MaLK8boWZOQrD/i2MnbQHKPyvgEt+yLmkTES18uiApTKzJ+xXehJ/uA4CwVAB0AW7mgdaorQCIe43PouJaNgTA4R3LkP1Pbzkx5PtEgOCKxYuDONQi6/+V8NlPV2bSxLyvfYVO9+Xbhe4vo44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvU1gQ6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431E9C113CD;
	Mon, 29 Apr 2024 13:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714397920;
	bh=tCjIq9XXF5mifq2vWnAC+idO1UTk7ra5AimNlBwYXqc=;
	h=From:To:Cc:Subject:Date:From;
	b=FvU1gQ6E5bi/kBIHbCIDiGOELQUz2zj/q72Gp9DPVOJeeRpZYcJOlUv2zj8Nhs51F
	 Epwxs1FNVFZe5Az9+M3OmPnGNANqsjTKhzMjw0KSALKtPv/0gt1Vn/xx8eHekRrEzm
	 9Cu0uKuyArGIoLRHD1DB1MGYgajCfWP44jGzMA0SqWfTBankFnht9CUNCLacZ3o6NI
	 RejPY1MXRF3d5CBSDfwlJ8FUCbFbZTIvFfKQilfFPu+HhrgtSHlL0+ZZ7Y9vWWY427
	 LSEF3I+68HnDTSMo4fAGQ59qSl9NWKWdu2rkt8gDEkRJBPdMox6qo1SE9zok4uT9px
	 rPV4Jfe94onMg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Vivien Didelot <vivien.didelot@gmail.com>
Subject: [PATCH net] net: dsa: mv88e6xxx: Fix number of databases for 88E6141 / 88E6341
Date: Mon, 29 Apr 2024 15:38:32 +0200
Message-ID: <20240429133832.9547-1-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Topaz family (88E6141 and 88E6341) only support 256 Forwarding
Information Tables.

Fixes: a75961d0ebfd ("net: dsa: mv88e6xxx: Add support for ethernet switch 88E6341")
Fixes: 1558727a1c1b ("net: dsa: mv88e6xxx: Add support for ethernet switch 88E6141")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 59b5dd0e2f41..14daf432f30b 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5705,7 +5705,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.prod_num = MV88E6XXX_PORT_SWITCH_ID_PROD_6141,
 		.family = MV88E6XXX_FAMILY_6341,
 		.name = "Marvell 88E6141",
-		.num_databases = 4096,
+		.num_databases = 256,
 		.num_macs = 2048,
 		.num_ports = 6,
 		.num_internal_phys = 5,
@@ -6164,7 +6164,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.prod_num = MV88E6XXX_PORT_SWITCH_ID_PROD_6341,
 		.family = MV88E6XXX_FAMILY_6341,
 		.name = "Marvell 88E6341",
-		.num_databases = 4096,
+		.num_databases = 256,
 		.num_macs = 2048,
 		.num_internal_phys = 5,
 		.num_ports = 6,
-- 
2.43.2


