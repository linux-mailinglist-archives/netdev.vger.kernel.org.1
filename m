Return-Path: <netdev+bounces-106040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 154579146BA
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22F21F24492
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 09:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFD813328E;
	Mon, 24 Jun 2024 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9Ph+RSg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF67132811
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719222834; cv=none; b=RgvCBtnYtneuPjHc1K+Hm2im3RJJlVo1I7OkWGGHUDaWQbCCGQ3RVbxVRikKwhPTG7UokHH5npExHJMRKXs0JhKa+dAUJzGQTTHEr1IZE0m7hvMY/jM9ZvQHjDhlHfmFq+qOpElElz0zSJ0blRhZZ+CKz8SGzXJBAwnA93utpyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719222834; c=relaxed/simple;
	bh=XAaDQ5iPzkABaGaYwJr6swiwTs2OLJ96Uge/J7R5UVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i8fagUAeDmNBW6FCe7N/4xPhvgYRHiDSqHeylMiem6b4HaK/2bHZr3NnH9XkJwlONHbI+a//qNj7kBq3gRfEmV9UYS0A5KECavXJGf2NifMdTBovPG58h4dcpo10Gr+aDxN+M6R7I7zd9QUdyHInAJN9Pxw7h1p0OkuPaRFJgbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E9Ph+RSg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719222831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AwVCdgZlUDmJ45VLLA4nNde1IIXg185F51iHXPPd7UE=;
	b=E9Ph+RSgt0bmkPGrUOw56CBQg4X0VQaTqZMTghsQs6JY5+ZLzBtvETT7QB1hENBsIpLLbf
	rrRR1FfIlok3vlMPC0g/PoP0dHUPlNYfxbt4sIUQTI0kxdF2gh3P+YLC9TBZNpxRPK7/qv
	hSW1ecZY90CcS3MRLJv1QgDcR/f04BE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-itAe-O5pPban2wpqRFSoXQ-1; Mon,
 24 Jun 2024 05:53:45 -0400
X-MC-Unique: itAe-O5pPban2wpqRFSoXQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74CAB195609F;
	Mon, 24 Jun 2024 09:53:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.153])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4704D1955E91;
	Mon, 24 Jun 2024 09:53:40 +0000 (UTC)
From: =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@redhat.com>
To: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	=?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@redhat.com>
Subject: [PATCH net-next] net: igc: return error for link autoneg=off
Date: Mon, 24 Jun 2024 11:53:31 +0200
Message-ID: <20240624095331.351039-1-ihuguet@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The driver doesn't support force mode for the link settings. However, if
the user request it, it's just ignored and success is returned. Return
ENOTSUPP instead.

Signed-off-by: Íñigo Huguet <ihuguet@redhat.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 93bce729be76..b7b32344d074 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1832,6 +1832,12 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
 		}
 	}
 
+	/* The driver does not support force mode yet */
+	if (cmd->base.autoneg == AUTONEG_DISABLE) {
+		netdev_err(dev, "Force mode currently not supported\n");
+		return -EOPNOTSUPP;
+	}
+
 	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
 		usleep_range(1000, 2000);
 
@@ -1844,14 +1850,10 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
 	if (ethtool_link_ksettings_test_link_mode(cmd, advertising, 2500baseT_Full))
 		advertising |= ADVERTISE_2500_FULL;
 
-	if (cmd->base.autoneg == AUTONEG_ENABLE) {
-		hw->mac.autoneg = 1;
-		hw->phy.autoneg_advertised = advertising;
-		if (adapter->fc_autoneg)
-			hw->fc.requested_mode = igc_fc_default;
-	} else {
-		netdev_info(dev, "Force mode currently not supported\n");
-	}
+	hw->mac.autoneg = 1;
+	hw->phy.autoneg_advertised = advertising;
+	if (adapter->fc_autoneg)
+		hw->fc.requested_mode = igc_fc_default;
 
 	/* MDI-X => 2; MDI => 1; Auto => 3 */
 	if (cmd->base.eth_tp_mdix_ctrl) {
-- 
2.44.0


