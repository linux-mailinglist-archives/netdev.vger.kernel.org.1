Return-Path: <netdev+bounces-171108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC07CA4B87E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 08:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFC218917D6
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 07:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEA01E9B30;
	Mon,  3 Mar 2025 07:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="CYcVlL/P"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1740B8635F
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740988037; cv=none; b=kw9yhmZDk4xorrVBNsp+BTDQDGQswd9znE1YiFe9jv+IHU21qF454qnd2AJygbIHb9ttZWjt2+iiVxncmEyfVWwWenrrs79cgNKSlawRnJd3ixA6kKGIhPidvnvVi0kACqllWWjW/DystSpGbHz9UGGNGthkVwszUjCYtY2MD5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740988037; c=relaxed/simple;
	bh=dZjutVIqRkydhliHBlHKI06qmvIDPbtRY2hMGF3LUjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k71R0NkG1QS2gGpcelc3BsVufcW/9s2OcRYMzBIs1hUxu5u8f/2M0DlxpZ8bdEcT3uajh+f7YQT0mygQFuyfaasg6SPSsdOxfcaTdD1QYAGUxDBIWX4UYRQ96utG9Pe6YklpSgen6x4n0T9eq7NRx0DCEcYEyFiHS0IuJlxHPWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=CYcVlL/P; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250303074707ca266c5c6caa77625b
        for <netdev@vger.kernel.org>;
        Mon, 03 Mar 2025 08:47:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=zrUY1LdFYD+ZIm9007t+7YM/d7JBcqpKOI6aIegZ2eU=;
 b=CYcVlL/PjL68bJNlRASUCQFR3d/gIjvM8s4AWiorZd6ei35cbjWVNs6MczurZckPUN1Rcs
 iHZ5t/HOJYIxhnroa7iKaNK1OChsV3p0HcM/IK+AJlqz/Bh0kPTHIBJ69rCl3Fe5g7U4F2JF
 pIXIbZVy081/oEQpulGIusFY+b7+6j+EuKJfie3f2YKeQCiyaScowPbnyR6APxUWfNP7ES0z
 MQuc2WdhLii8ZsqxFztRSOL+PjlwH2s2r6+Pcf4FCquunpcwJydjFZ+MhpDWQD2yNesOcYzP
 ZTikariIq1dGzkrS1XGfgIM1tAB3A+rsx4vlwGVyua8NZ0jD3tVlUg0w==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: Roger Quadros <rogerq@kernel.org>,
	netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v2] net: ethernet: ti: cpsw_new: populate netdev of_node
Date: Mon,  3 Mar 2025 08:46:57 +0100
Message-ID: <20250303074703.1758297-1-alexander.sverdlin@siemens.com>
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

So that of_find_net_device_by_node() can find CPSW ports and other DSA
switches can be stacked downstream. Tested in conjunction with KSZ8873.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v2: cpsw-nuss (am6x or K3 naming) -> CPSW (am33x naming) in commit message

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


