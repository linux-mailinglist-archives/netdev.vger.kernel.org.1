Return-Path: <netdev+bounces-188132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61319AAB70F
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 280D67AB84C
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 06:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE022EC281;
	Tue,  6 May 2025 00:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3gnGefx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D46E2EC288;
	Mon,  5 May 2025 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486616; cv=none; b=LHUt0DCEWp2QZrvG4m0A7+TxraAmlSrU0fnQSX0bevy3oNFWHxef6E67hS8hpl/I0VpZ5ht/B4pDI/uHb4P5jo6a1DpR+Ov0XyCHxoa5gTviKHnfCfWdjFhouA5QnQKx1TZngF4Qttln1Eu4tXqSb7S2B+jAlOZG9YnsxIAvHng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486616; c=relaxed/simple;
	bh=JFhIQAL0dJT7ZGzwUod4Y5ApAOyYZQd5iKFN0uqTNBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nv+0qFD4IaPbSRd02AWRBAlBlJ+2ZB7ioh+KUOwhjRpCjpzdrgzosxW5knGiPaSmvc4mcS6ui0rHxFjOUyAONqwlecL5oRo6E1UjScwwp4wuvofjrAWlhKeQqxQhcgaFizvZIz6MmXbI7GjAgAarPIqxXCofxtpc/0yatX4VlXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3gnGefx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A371C4CEE4;
	Mon,  5 May 2025 23:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486616;
	bh=JFhIQAL0dJT7ZGzwUod4Y5ApAOyYZQd5iKFN0uqTNBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J3gnGefxrOVL7b6rkM8bGT4LRkRN9WFY6BWvSmNVZuwJSLYYYZZNqafJK/WmkoGkJ
	 JNR7+mDlaCUQzW9WQZ8kWzuJxRrgIeXz0IAQ1nbEXjPvi4JGWzleOVNxRiWfsv7BLf
	 IbDqdqO14ttoAC5va7T1ytWUeEMCIrTnrYipPQ5pI+HBTPtkbNS3l4v/myC8Yaj6OB
	 wJtDiKkW17MbvAHoo9jrIU+Vu7LkIzb1KjEFeUslbBNnYyHmiCk4xTG/XJqSnFmnXY
	 8lgop9sz/R1PvQC0pkQSgpaXqiqcvXihn7a0Zc8E8nPaygGufKoJdHSuycPuKEIS50
	 y6kaDbcok6f9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hangbin Liu <liuhangbin@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jv@jvosburgh.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 120/212] bonding: report duplicate MAC address in all situations
Date: Mon,  5 May 2025 19:04:52 -0400
Message-Id: <20250505230624.2692522-120-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 28d68d396a1cd21591e8c6d74afbde33a7ea107e ]

Normally, a bond uses the MAC address of the first added slave as the bond’s
MAC address. And the bond will set active slave’s MAC address to bond’s
address if fail_over_mac is set to none (0) or follow (2).

When the first slave is removed, the bond will still use the removed slave’s
MAC address, which can lead to a duplicate MAC address and potentially cause
issues with the switch. To avoid confusion, let's warn the user in all
situations, including when fail_over_mac is set to 2 or not in active-backup
mode.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/20250225033914.18617-1-liuhangbin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index ded9e369e4038..3cedadef9c8ab 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2431,7 +2431,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 
 	RCU_INIT_POINTER(bond->current_arp_slave, NULL);
 
-	if (!all && (!bond->params.fail_over_mac ||
+	if (!all && (bond->params.fail_over_mac != BOND_FOM_ACTIVE ||
 		     BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)) {
 		if (ether_addr_equal_64bits(bond_dev->dev_addr, slave->perm_hwaddr) &&
 		    bond_has_slaves(bond))
-- 
2.39.5


