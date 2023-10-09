Return-Path: <netdev+bounces-39124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DF37BE261
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0D42816F3
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E35F34CDC;
	Mon,  9 Oct 2023 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kceedgEg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174018043
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 14:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254CEC433C9;
	Mon,  9 Oct 2023 14:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696861172;
	bh=5o5h5CgRG4H4Z5qjk2eknSticE7hPec++pW0EBNapec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kceedgEgxB0UHzObI+BxpbPFb2TW/hw2iIrUfxd4PzxqAKsk4kc7/5bgS/m2df2Rr
	 pFCHqRphEgn++36GwJAYtuus7JFWLWIczkpZmO8ULOzfpcOVbVhhfU0WeE+bEmKgUj
	 elp7YAJXXhDCrh5P1qYP/SY0B0I0eXuzwXab3UJLZ2WiVyhmSZWiZyoU0gEjYGaiNL
	 uAOk52d9TRaOqrwFHkm/9F2NHv+gZflDypnBwDFLQixvpwGwC3+rJthjdWPqhOu5y5
	 rLgnWgWUFXVO4Zoz7gNUUz03rsxjzwx+3MI9kAKzvMBPsvR4vtVlKnxGnF9VmkM35K
	 dL4YZseD/J+Jg==
From: Arnd Bergmann <arnd@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wpan@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	Doug Brown <doug@schmorgal.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 03/10] ethernet: sp7021: fix ioctl callback pointer
Date: Mon,  9 Oct 2023 16:19:01 +0200
Message-Id: <20231009141908.1767241-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009141908.1767241-1-arnd@kernel.org>
References: <20231009141908.1767241-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The old .ndo_do_ioctl() callback is never called any more, instead the
driver should set .ndo_eth_ioctl() for the phy operations.

Fixes: fd3040b9394c5 ("net: ethernet: Add driver for Sunplus SP7021")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/sunplus/spl2sw_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sunplus/spl2sw_driver.c b/drivers/net/ethernet/sunplus/spl2sw_driver.c
index 391a1bc7f4463..bb4514f4e8157 100644
--- a/drivers/net/ethernet/sunplus/spl2sw_driver.c
+++ b/drivers/net/ethernet/sunplus/spl2sw_driver.c
@@ -199,7 +199,7 @@ static const struct net_device_ops netdev_ops = {
 	.ndo_start_xmit = spl2sw_ethernet_start_xmit,
 	.ndo_set_rx_mode = spl2sw_ethernet_set_rx_mode,
 	.ndo_set_mac_address = spl2sw_ethernet_set_mac_address,
-	.ndo_do_ioctl = phy_do_ioctl,
+	.ndo_eth_ioctl = phy_do_ioctl,
 	.ndo_tx_timeout = spl2sw_ethernet_tx_timeout,
 };
 
-- 
2.39.2


