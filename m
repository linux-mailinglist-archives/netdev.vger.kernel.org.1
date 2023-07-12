Return-Path: <netdev+bounces-17181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DB1750BD4
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850DD28197C
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB7134CF5;
	Wed, 12 Jul 2023 15:07:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B58834CF1
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 15:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A58C433D9;
	Wed, 12 Jul 2023 15:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689174454;
	bh=6hu2QLAnatQP5UFKHqQxLipPsz8mKS6yWJMOvqrfh4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oi9YDlwcTqrVxqhOw1EZZr9PArfNBsj2F7xdvu0hNxBS+lAeoSYV+yVW2SkbjXuJ9
	 ZJnTmXOAJffEds4stKmwQUKBJJcyNs70h0BlapfpbgY5pD1AJjN1xDNQXr1Kku+9+m
	 auOKDvO9TbLw9TkKvY5TzgBK7NBJrZWU9zIZG7DFZkfIMpxm8Zzy/3UcucoiDBHo5X
	 5qNcGoh4zLdrErmwDnPVA+H/DYbdaG6VwkSiyrQToE9d/5aGcI7LcpplpauC2PZS+i
	 nq2szRaVXz/UQU53cI4Vffdjg8b+M8Srm+/DE6dFL+kh5iwQ8jT3uyTTzczc/W+mBM
	 s+gJJSuSDsjuw==
From: Michael Walle <mwalle@kernel.org>
Date: Wed, 12 Jul 2023 17:07:01 +0200
Subject: [PATCH net-next v3 01/11] net: phy: get rid of redundant is_c45
 information
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-feature-c45-over-c22-v3-1-9eb37edf7be0@kernel.org>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
In-Reply-To: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Xu Liang <lxu@maxlinear.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <simon.horman@corigine.com>, Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2

phy_device_create() will be called with is_c45 and c45_ids. If c45_ids
are set, is_c45 is (usually) true. Change the only caller which do
things differently, then drop the is_c45 check in phy_device_create().

This is a preparation patch to replace the is_c45 boolean with an enum
which will indicate how the PHY is accessed (by c22, c45 or
c45-over-c22).

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/net/phy/phy_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0c2014accba7..226d5507c865 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -689,7 +689,7 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 	 * driver will get bored and give up as soon as it finds that
 	 * there's no driver _already_ loaded.
 	 */
-	if (is_c45 && c45_ids) {
+	if (c45_ids) {
 		const int num_ids = ARRAY_SIZE(c45_ids->device_ids);
 		int i;
 
@@ -970,7 +970,8 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
 						 true, &c45_ids);
 	}
 
-	return phy_device_create(bus, addr, phy_id, is_c45, &c45_ids);
+	return phy_device_create(bus, addr, phy_id, is_c45,
+				 !is_c45 ? NULL : &c45_ids);
 }
 EXPORT_SYMBOL(get_phy_device);
 

-- 
2.39.2


