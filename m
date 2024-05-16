Return-Path: <netdev+bounces-96771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1068C7ABE
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 18:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46921F21996
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 16:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72DF2555B;
	Thu, 16 May 2024 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NNOqXQe8"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9394A3D;
	Thu, 16 May 2024 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715878600; cv=none; b=SSs+5HRT3nWLnRM440wirCHFBoYXnZcPECw1JLvUnzTSYzmd/vgr/LClFyPijdyNr3Wtp4s9tw51akLnqtgY80H5GsQPu7a4fMQTf9w3zPp6xEZjIq62RLZs/RIsFTqyHLv9UCKDW6nWSmRkNHwwNIngIb+hW7ky/cUa3mr+0VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715878600; c=relaxed/simple;
	bh=JiYIaXNGNN4bIc2eJBmYK2Cz7bigDfMqs63xzVRAJwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EZY893JEN/wZBlbS7NHryAf3DafV/qTZ4ydaidqeOX0ulbXdOKvBeCP1DghuCL15250g3ttGwQkWiO/h3Ox9Qnji7hNP+ib9Y+wNw9ave9PjzCeA9M//otUawF6GyBLFhOtRoFyjT48ypT4afDyoM3GPCjQC8QAADhxuLnb/5tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NNOqXQe8; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 0654AC0000FB;
	Thu, 16 May 2024 09:56:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 0654AC0000FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1715878598;
	bh=JiYIaXNGNN4bIc2eJBmYK2Cz7bigDfMqs63xzVRAJwM=;
	h=From:To:Cc:Subject:Date:From;
	b=NNOqXQe8wsUijRd5kdUTEIdp5jeUQ1WriTZTnw9Up1z0G1Neqlj6GF83bBP9s01Is
	 7MBryZms/6v5og1Cxa0BN2MohVAfQqGXUevJ3BwDU0MxGTngHotRLNVK46u69soXGu
	 Joy58c7aI9Ec3cwdafRP7Nr9J6HzZi1H+EKzBWHc=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 025ED18041CAC4;
	Thu, 16 May 2024 09:56:35 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: stephenlangstaff1@gmail.com,
	aleksander.lobakin@intel.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Alexander Lobakin <alobakin@pm.me>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] net: Always descend into dsa/ folder with CONFIG_NET_DSA enabled
Date: Thu, 16 May 2024 09:56:30 -0700
Message-Id: <20240516165631.1929731-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stephen reported that he was unable to get the dsa_loop driver to get
probed, and the reason ended up being because he had CONFIG_FIXED_PHY=y
in his kernel configuration. As Masahiro explained it:

  "obj-m += dsa/" means everything under dsa/ must be modular.

  If there is a built-in object under dsa/ with CONFIG_NET_DSA=m,
  you cannot do  "obj-$(CONFIG_NET_DSA) += dsa/".

  You need to change it back to "obj-y += dsa/".

This was the case here whereby CONFIG_NET_DSA=m, and so the
obj-$(CONFIG_FIXED_PHY) += dsa_loop_bdinfo.o rule is not executed and
the DSA loop mdio_board info structure is not registered with the
kernel, and eventually the device is simply not found.

To preserve the intention of the original commit of limiting the amount
of folder descending, conditionally descend into drivers/net/dsa when
CONFIG_NET_DSA is enabled.

Fixes: 227d72063fcc ("dsa: simplify Kconfig symbols and dependencies")
Reported-by: Stephen Langstaff <stephenlangstaff1@gmail.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
Changes in v2:

- conditionally descend into the dsa folder based upon CONFIG_NET_DSA
- change subject a bit to reflect the change

 drivers/net/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 9c053673d6b2..13743d0e83b5 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -49,7 +49,9 @@ obj-$(CONFIG_MHI_NET) += mhi_net.o
 obj-$(CONFIG_ARCNET) += arcnet/
 obj-$(CONFIG_CAIF) += caif/
 obj-$(CONFIG_CAN) += can/
-obj-$(CONFIG_NET_DSA) += dsa/
+ifdef CONFIG_NET_DSA
+obj-y += dsa/
+endif
 obj-$(CONFIG_ETHERNET) += ethernet/
 obj-$(CONFIG_FDDI) += fddi/
 obj-$(CONFIG_HIPPI) += hippi/
-- 
2.34.1


