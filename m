Return-Path: <netdev+bounces-196727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD1DAD6144
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 23:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AFF47A94DE
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 21:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B452242D94;
	Wed, 11 Jun 2025 21:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SuBhTbwA"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE874236457;
	Wed, 11 Jun 2025 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677260; cv=none; b=jpbIWWb4ZSMzBj+PYMqR358iyfoV8Ka6lZi18frg3EvbbGDZYF8fcN/ged0ebCOI6la+i/AnfAUfVpl0dLnHCiPgThp4csdHmTWXXzLeACtE2W/oMweGL/UQ/UyFGrBCCcHs28kQQLWt6ud2VGoausqgmbZi28iuVxdYxfvPRpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677260; c=relaxed/simple;
	bh=zhY1k/sLMn4MWgTbf/3hZAY4Z5DhtE0MLr/4MyfmzAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jVde4glo3mevWAjIr3LWnDw2kMKKgemYwsVb6znYQhQb2nOP6ro16V1BLE0m3sHY9ktkJnAhvx6f4ULo8DGsYNuY3/gaFOUM3CvNB+S8DCsn5+aUKIQ8i3iB87Ey9M/iwkaz0X/u8s+RjPEGcUhdMLQYrU//TZcMncoX67vepyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SuBhTbwA; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 69389C000C61;
	Wed, 11 Jun 2025 14:27:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 69389C000C61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1749677252;
	bh=zhY1k/sLMn4MWgTbf/3hZAY4Z5DhtE0MLr/4MyfmzAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SuBhTbwAdHVriXjE+upbYMpwh/lK3dzrOVhrdibZXpJYC3sCyWYykrABmOB0tDWDo
	 VBlcp9V0NMnmmtemXv6YB6dRiNMBmy40ARGfynSlQ0J3yspcw2WQgVxXvrqNVzMKmk
	 ESjWYeavhXin12FIslJan6dYld/daFIcKlyADnuA=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 18E8D1800051E;
	Wed, 11 Jun 2025 14:27:32 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/2] net: bcmasp: enable GRO software interrupt coalescing by default
Date: Wed, 11 Jun 2025 14:27:30 -0700
Message-Id: <20250611212730.252342-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611212730.252342-1-florian.fainelli@broadcom.com>
References: <20250611212730.252342-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Utilize netdev_sw_irq_coalesce_default_on() to provide conservative
default settings for GRO software interrupt coalescing.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Justin Chen <justin.chen@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index 7dc28166d337..a6ea477bce3c 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -1279,6 +1279,8 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
 	ndev->hw_features |= ndev->features;
 	ndev->needed_headroom += sizeof(struct bcmasp_pkt_offload);
 
+	netdev_sw_irq_coalesce_default_on(ndev);
+
 	return intf;
 
 err_free_netdev:
-- 
2.34.1


