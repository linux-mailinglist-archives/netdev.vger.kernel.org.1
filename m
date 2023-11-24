Return-Path: <netdev+bounces-50691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAAB7F6B30
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 05:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC001C20C4F
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 04:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1071D138C;
	Fri, 24 Nov 2023 04:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEfs/Z7X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40173C1E
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 04:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7C1C433C8;
	Fri, 24 Nov 2023 04:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700799342;
	bh=fEcMc77/7gfRw9SdToE7MqkpAdywNycv2AMRThP2z6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sEfs/Z7XS4kMslhO3iEOdFin1P40SfpYNJ5UhbFb/GKh1pOs5MSf95vVcrxIqjNGV
	 9rw+rzwNDUw1Rr216H+EHMqtnm4WVnYdpGZj+VWhcenlj8pCWinWl4F1w7Y2oEoZPz
	 /B7NvpeAF6/n+8Hl3wI7/u1T6pNsiwit5Oui8X7DmN9HKhARTUpURwPBwSwYSwF6CO
	 cjKguGN5QRwuPKU9OEmz0C0Vk6bKjmXpNdMsQiOqbxmopOHQRSvwJF8sYzuMZ/aJ+e
	 B8o2AgGSWJyvaEZQIqD89QZ7I6hIUkd+k6olUwUdY/OJdBlj7NqoH/K5L9E5d5CcFC
	 eq1RMlgj/kTDw==
From: Greg Ungerer <gerg@kernel.org>
To: rmk+kernel@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	Greg Ungerer <gerg@kernel.org>
Subject: [PATCHv2 2/2] net: dsa: mv88e6xxx: fix marvell 6350 probe crash
Date: Fri, 24 Nov 2023 14:15:29 +1000
Message-Id: <20231124041529.3450079-2-gerg@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231124041529.3450079-1-gerg@kernel.org>
References: <20231124041529.3450079-1-gerg@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of commit b92143d4420f ("net: dsa: mv88e6xxx: add infrastructure for
phylink_pcs") probing of a Marvell 88e6350 switch causes a NULL pointer
de-reference like this example:

    ...
    mv88e6085 d0072004.mdio-mii:11: switch 0x3710 detected: Marvell 88E6350, revision 2
    8<--- cut here ---
    Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
    [00000000] *pgd=00000000
    Internal error: Oops: 5 [#1] ARM
    Modules linked in:
    CPU: 0 PID: 8 Comm: kworker/u2:0 Not tainted 6.7.0-rc2-dirty #26
    Hardware name: Marvell Armada 370/XP (Device Tree)
    Workqueue: events_unbound deferred_probe_work_func
    PC is at mv88e6xxx_port_setup+0x1c/0x44
    LR is at dsa_port_devlink_setup+0x74/0x154
    pc : [<c057ea24>]    lr : [<c0819598>]    psr: a0000013
    sp : c184fce0  ip : c542b8f4  fp : 00000000
    r10: 00000001  r9 : c542a540  r8 : c542bc00
    r7 : c542b838  r6 : c5244580  r5 : 00000005  r4 : c5244580
    r3 : 00000000  r2 : c542b840  r1 : 00000005  r0 : c1a02040
    ...

The Marvell 6350 switch has no SERDES interface and so has no
corresponding pcs_ops defined for it. But during probing a call is made
to mv88e6xxx_port_setup() which unconditionally expects pcs_ops to exist -
though the presence of the pcs_ops->pcs_init function is optional.

Modify code to check for pcs_ops first, before checking for and calling
pcs_ops->pcs_init. Modify checking and use of pcs_ops->pcs_teardown
which may potentially suffer the same problem.

Fixes: b92143d4420f ("net: dsa: mv88e6xxx: add infrastructure for phylink_pcs")
Signed-off-by: Greg Ungerer <gerg@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

v2: apply same change to use of pcs_ops->teardown

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index d8a67bf4e595..07a22c74fe81 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3892,7 +3892,8 @@ static int mv88e6xxx_port_setup(struct dsa_switch *ds, int port)
 	struct mv88e6xxx_chip *chip = ds->priv;
 	int err;
 
-	if (chip->info->ops->pcs_ops->pcs_init) {
+	if (chip->info->ops->pcs_ops &&
+	    chip->info->ops->pcs_ops->pcs_init) {
 		err = chip->info->ops->pcs_ops->pcs_init(chip, port);
 		if (err)
 			return err;
@@ -3907,7 +3908,8 @@ static void mv88e6xxx_port_teardown(struct dsa_switch *ds, int port)
 
 	mv88e6xxx_teardown_devlink_regions_port(ds, port);
 
-	if (chip->info->ops->pcs_ops->pcs_teardown)
+	if (chip->info->ops->pcs_ops &&
+	    chip->info->ops->pcs_ops->pcs_teardown)
 		chip->info->ops->pcs_ops->pcs_teardown(chip, port);
 }
 
-- 
2.25.1


