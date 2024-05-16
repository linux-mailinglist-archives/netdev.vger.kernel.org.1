Return-Path: <netdev+bounces-96671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F6A8C70B0
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 05:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6371C21D90
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 03:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73414441D;
	Thu, 16 May 2024 03:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="vlijCOyx"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75814411;
	Thu, 16 May 2024 03:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715830441; cv=none; b=fyVTJ91MtuNDSi2PjmMSe4wgPto1+DaaZhfsxBk/40cBp4rawqht9ok80nd9Gp4iHkKVsj+hBwKru2N4PX/oP8we7ISYbFY2SCkTQei+U3zhu61OHK37nHB5a0xRYWxNu1G05lKk16kc6xb83v6nA8ZzxOJCwTvniGUBHKv8uhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715830441; c=relaxed/simple;
	bh=EhOfJamrX1GR0p/9hZ+xovyjdb1m8SmtOvrT3d8NEXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gf8x9PDRPAqk4DqMXi8oUyxfMD5fsZV7MX/cznkIJlvuCM62Vl2jdSWilYnnDNE/hMChFFwNURRFhmI3ZtGXF/amhF9fvQNNXcwy16RNfYINMVWDEVJT4pDeJOPWP13+GO5QEJqpCeqtqAzuGM1kpKRhDD+aj0o17Iwlnnenbws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=vlijCOyx; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 3AFBCC0000D8;
	Wed, 15 May 2024 20:33:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 3AFBCC0000D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1715830435;
	bh=EhOfJamrX1GR0p/9hZ+xovyjdb1m8SmtOvrT3d8NEXY=;
	h=From:To:Cc:Subject:Date:From;
	b=vlijCOyx8JATzmAmOCZ1JjpwQgpmZemiUVxXK68dIcLah3OK/EBvQ8rtzny+4gLw+
	 ZPVDk4Wt5lWa10qjIDdu6GIWxPVGi0OJWajntteex5S4cWyaQO1OD18boXBV3vQ1w3
	 G8a7q68nmb5m2NnH5X3wVssai+9o12GtVDBecNtg=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 38BFA18041CAC4;
	Wed, 15 May 2024 20:33:53 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: masahiroy@kernel.org,
	aleksander.lobakin@intel.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Stephen Langstaff <stephenlangstaff1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <alobakin@pm.me>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: Always descend into dsa/ folder
Date: Wed, 15 May 2024 20:33:45 -0700
Message-Id: <20240516033345.1813070-1-florian.fainelli@broadcom.com>
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

Fixes: 227d72063fcc ("dsa: simplify Kconfig symbols and dependencies")
Reported-by: Stephen Langstaff <stephenlangstaff1@gmail.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 9c053673d6b2..0f6f0f091e0e 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -49,7 +49,7 @@ obj-$(CONFIG_MHI_NET) += mhi_net.o
 obj-$(CONFIG_ARCNET) += arcnet/
 obj-$(CONFIG_CAIF) += caif/
 obj-$(CONFIG_CAN) += can/
-obj-$(CONFIG_NET_DSA) += dsa/
+obj-y += dsa/
 obj-$(CONFIG_ETHERNET) += ethernet/
 obj-$(CONFIG_FDDI) += fddi/
 obj-$(CONFIG_HIPPI) += hippi/
-- 
2.34.1


