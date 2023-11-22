Return-Path: <netdev+bounces-50045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09B17F47A0
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9AA1F21B4C
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C786751033;
	Wed, 22 Nov 2023 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awyxEGm0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF204D12B
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 13:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC640C433C8;
	Wed, 22 Nov 2023 13:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700659290;
	bh=p2IYNSEdkepQ863Rvue+YZ3H/BoxsnDcf0ABUSyrJzU=;
	h=From:To:Cc:Subject:Date:From;
	b=awyxEGm02x/i8JJmzbOhY0NgNl1aIiBqWXBhOwJfMJCDR5Llxfkg7ZPHspsoy0Qee
	 rgpiLBa1weE0y1c3pfSIvRbzQCn/AUtt547wqMPC2NJnf9YkWfamxR8R+zXPl25Zud
	 tYA5WdetbizLbysADEhEUByE+WHYCBMn2o2+7cFUr3NcBE61zvCqG3FZZ3QtM75G9G
	 0A6C/oxisgpBKh0lUE4wneZrYyfZmB6sBOtwoKs3mAwrK4l9084fdjyYZFqx6xvunI
	 37JZAP7B7HH3jTv01EEab6G3HMRo5Zq1S7h3pbf+madcF8XfiiVM75Ueh9gthlvXt9
	 IeZ1DOpD25RMw==
From: Greg Ungerer <gerg@kernel.org>
To: rmk+kernel@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	Greg Ungerer <gerg@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH 2/2] net: dsa: mv88e6xxx: fix marvell 6350 probe crash
Date: Wed, 22 Nov 2023 23:21:16 +1000
Message-Id: <20231122132116.2180473-1-gerg@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of commit b92143d4420f ("net: dsa: mv88e6xxx: add infrastructure for
phylink_pcs") probing of a Marvell 88e6350 switch causes a NULL pointer
dereference like this example:

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

The Marvell 88e6350 switch has no SERDES interface and so has no
corresponding pcs_ops defined for it. But during probing a call is made
to mv88e6xxx_port_setup() which unconditionally expects pcs_ops to exist,
though the presence of the pcs_ops->pcs_init function is optional.

Modify the code to check for pcs_ops first, before checking for and calling
pcs_ops->pcs_init.

Fixes: b92143d4420f ("net: dsa: mv88e6xxx: add infrastructure for phylink_pcs")
Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Greg Ungerer <gerg@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index e9adf9711c09..38f76ee3035b 100644
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
-- 
2.25.1


