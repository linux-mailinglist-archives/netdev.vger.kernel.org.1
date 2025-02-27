Return-Path: <netdev+bounces-170124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD663A476CE
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 08:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7911A188B663
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 07:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDB322170B;
	Thu, 27 Feb 2025 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="CeVlpRfs"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E1B221DA6
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740642512; cv=none; b=VdOKxkGliPdhY0cNq31i/XEPJGybd6QBNcINE3Et3hfmBRXYX2CkD0esjbefq08UTe0PY+7mbbl7f2jrefY8Ij6ngRGOhUQG2Jj9R3y5yu0a2C0/tUeVmwK7r4AT2kFMJypczKsFK2h3VPz0K7QO9jEUjjA0RR5g/0PR1T1c9m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740642512; c=relaxed/simple;
	bh=LcTTmUaiUueHzxkqqk4T+6kRWsuH1UVWB8bDZx3I/t4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lE1fYUXm0gCnAQ4zJbp5Ofm+DmKnS/cpJM0V3GzF+EFeTwo2HSgNtD9dUVkc1uR0Un0nqvokTPj3G5/cSyNFN4N7z9vvpuME4xBIlPiP80daMyjnJLVR77sMCoDFamgbM8SqXtXX+QtECg7YY1asxJEa2srzs3qzZDYXVF5HYWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=CeVlpRfs; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250227074824e30a8128e1efc1a18d
        for <netdev@vger.kernel.org>;
        Thu, 27 Feb 2025 08:48:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=is2ITOYKTL7kmTYspiTeObOPS74J39ADsO954CSY7t8=;
 b=CeVlpRfsRHIVS/dTMY+Uq9NSXNSfWpXZdFo+B6VL2fIU53UFm+HimvRh6Oxe+cZsrBS1j7
 z4UzWbEhxkPCws2te2J1N64dyB3Qrnw2DzGaxPhVz68WQpn22CNL40JLSF+tucBpLAcVxs0c
 IyKoL0fsHXxXoHWJEyBJ4j38HHgFvZun3uq0hLQB8I8VmUkrbAPH7z5YvkCqb1WmntMDkj9E
 kFPvSrVN/kgu62T+yMGmspC4iZ6NZGQjZ217BoNLRqbCdNIbBEjlAsUDml+rfCRqN1psL6ii
 qTACQc1MVvQCxTyynCuuRpzuZxAvk0IUpkpH4EkVBIQ791PTioPiuRmQ==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ethernet: ti: cpsw_new: populate netdev of_node
Date: Thu, 27 Feb 2025 08:46:46 +0100
Message-ID: <20250227074704.4067481-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

So that of_find_net_device_by_node() can find cpsw-nuss ports and other DSA
switches can be stacked downstream. Tested in conjunction with KSZ8873.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/net/ethernet/ti/cpsw_new.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index cec0a90659d94..66713bc931741 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1418,6 +1418,7 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 		ndev->netdev_ops = &cpsw_netdev_ops;
 		ndev->ethtool_ops = &cpsw_ethtool_ops;
 		SET_NETDEV_DEV(ndev, dev);
+		ndev->dev.of_node = slave_data->slave_node;
 
 		if (!napi_ndev) {
 			/* CPSW Host port CPDMA interface is shared between
-- 
2.48.1


