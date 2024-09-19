Return-Path: <netdev+bounces-128913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C7397C685
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 11:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3422284CBC
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 09:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756DF194C92;
	Thu, 19 Sep 2024 09:04:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC7C194C8D
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.92.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736661; cv=none; b=QP3lnRsfWARRGaQOnyKTzyk3FSxdZApzBKt4yGGOYH0zUEB1tcwgdXB+MRIyVeH7vGOM49CjJ2E1tRYLx8+MGkkMOSbtEdvBgfbPj7/BQ6Wv0CCcloRirRJ3GxVMCLoFiDvjSCLA6fraZBNcVznPgpivNyGtPTnvlMrIpWID0AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736661; c=relaxed/simple;
	bh=4K+e1x4Z4RivRvemlPPqtSJdD2gYEb0LHJglew0ayXk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qoFZ0dTNYOwb+KBRrF1tF9rFtXUOS5lNzp9SHIKHr6JiLzBTyvKpledTt+8AIewEhOsrBF2mEUzs2Q1lRxz6hybKkKmPeQE1CqIA28/nnOXjeGE8Jl/GYV0c7I68cdcMSRDh02evVS6YGqMa+qBHtcRQ7B27bFCiNhNQ5GyG+q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch; spf=none smtp.mailfrom=sym.noone.org; arc=none smtp.client-ip=178.63.92.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sym.noone.org
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 4X8Ttg11tTz3j19w; Thu, 19 Sep 2024 10:57:46 +0200 (CEST)
From: Tobias Klauser <tklauser@distanz.ch>
To: wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] wireguard: Omit unnecessary memset of netdev private data
Date: Thu, 19 Sep 2024 10:57:46 +0200
Message-Id: <20240919085746.16904-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The memory for netdev_priv is allocated using kvzalloc in
alloc_netdev_mqs before rtnl_link_ops->setup is called so there is no
need to zero it again in wg_setup.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/net/wireguard/device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 45e9b908dbfb..a2ba71fbbed4 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -302,7 +302,6 @@ static void wg_setup(struct net_device *dev)
 	/* We need to keep the dst around in case of icmp replies. */
 	netif_keep_dst(dev);
 
-	memset(wg, 0, sizeof(*wg));
 	wg->dev = dev;
 }
 
-- 
2.43.0


