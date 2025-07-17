Return-Path: <netdev+bounces-207995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67179B093C9
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 20:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEF6A43085
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 18:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8CF1EF38F;
	Thu, 17 Jul 2025 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="mGO3XBOJ"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0655EEBB;
	Thu, 17 Jul 2025 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752776321; cv=none; b=uCTKDVFFj0ksc7jUXOR0dzSjkNmknhYaUHF6qjb2h0QekmtoqVBJpLe9bhyT2jDdWiSIfF6c0A3xq3mOOUfgm+/rXaKKub11E7Fz7LTMVl5nRwgDThu4NLar8BjdEnWv1KFvjgD0rjyIDtdbqgteN9gxVKZkwD/4Iq6AK7LG6+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752776321; c=relaxed/simple;
	bh=4DaqWPa/HyE4W07tuy0+aI9nfAoTwm3ka5QQYmyeGN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R5Xue3FoypIujni2MGMKjkq4T99/gdhad2IiUxXFp+N7NH8ZsZA9mBXyeAy3UMQNOWhXNclwoOi/stiAFxYU58umGN/39paY7DCeW5l9UlWflr8L67t0tRPhr6VBHw97PqcBbdsi/sJjPzgqVXp9GfVVWosMvS+Cxzb7JpFTNoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=mGO3XBOJ; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id EA4AEC0005FD;
	Thu, 17 Jul 2025 11:09:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com EA4AEC0005FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1752775763;
	bh=4DaqWPa/HyE4W07tuy0+aI9nfAoTwm3ka5QQYmyeGN4=;
	h=From:To:Cc:Subject:Date:From;
	b=mGO3XBOJLDKZIxfRFB7i39DxIkCYpDRHuejglthHaXjyai8VPnv95jVsaAe+1ikDl
	 0jQqww8uy30dRmOaCPjUa9OrFRr47UmgYu+y5rMm/1ODNazqEGJuHbNFCRJ75ksbZv
	 2C6yRVDZ+sI1PASz2srED9yUjuqBIFBWn3ux9WMc=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id B9E0A18000530;
	Thu, 17 Jul 2025 11:09:22 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Justin Chen <justin.chen@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM ASP 2.0 ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: bcmasp: Add support for re-starting auto-negotiation
Date: Thu, 17 Jul 2025 11:09:15 -0700
Message-ID: <20250717180915.2611890-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wire-up ethtool_ops::nway_reset to phy_ethtool_nway_reset in order to
support re-starting auto-negotiation.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
index 4381a4cfd8c6..63f1a8c3a7fb 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
@@ -430,4 +430,5 @@ const struct ethtool_ops bcmasp_ethtool_ops = {
 	.get_ethtool_stats	= bcmasp_get_ethtool_stats,
 	.get_sset_count		= bcmasp_get_sset_count,
 	.get_ts_info		= ethtool_op_get_ts_info,
+	.nway_reset		= phy_ethtool_nway_reset,
 };
-- 
2.43.0


