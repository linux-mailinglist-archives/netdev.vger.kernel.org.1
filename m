Return-Path: <netdev+bounces-193308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ED3AC3817
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 04:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C691702E1
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 02:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE09172BB9;
	Mon, 26 May 2025 02:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="B1J92tiA"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D735661
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 02:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748227489; cv=none; b=g3Q5+1KCoMZdexsjtE9NmaB2x8q8KpONpFP3/RO8vEdikN75zuFB19jqclr8Aa5r7I2g5aMHiRefxzU/KBBBzyoqUeO/kaYgYYewA7hmTCcF5mxXjCRj3GV5ocZZycMFdAUYg4BBPeQzApX+bxUzSNMcIubUGpCrCR0EJvcG7p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748227489; c=relaxed/simple;
	bh=wqqt1SenbZYwpwGR2xtSylq8plwZy/5Szi309ryPKIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AJDuyk3ef8AvyUz1MHFCcxdYoNJ1kXPzweo8YAASz0PtHSch2EVAddecPU/8r+Pq0Mp6TFDZab01rkJSHiMZIKalIdQtEznxLh4BOuxBzbaquSFOFiu6innSyt5ffG/ica4p3XUkQ4tp4UQyjQ96UhfZ9DYbGFS30m/ma+Cmkzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=B1J92tiA; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1748227479;
	bh=FsFQjqLMP/DTxqyPOC4s+EPqx6H6swGcvaY2nE6/QmA=;
	h=From:Date:Subject:To:Cc;
	b=B1J92tiAwWAVnQgtIDwD/2plULlrvlhnuqy1/vByyZyOKCo+QiPHNP/KydxsXBcIj
	 kINMM33g5/AB7MAS9s99dIoSM7/06KVzg8kGApcCHChYGG2CmU8G0pPz2jNGhLuP6Q
	 nmazaz805BwaDVGPOLeahX1jE0a3Cic3D3MKARI8oujwpd5U8s25ubOcSQKiQ5nmfE
	 ChDKIoT0fBEUQNLhfdv7C11u/Dg7pCftG6NQ7AqRNFWE3WlU6PBdrtG6SL8kX0WnCl
	 7teMaLXb9hz/0DyLJ5VoQN6W63UFT0a4YUYvjmSHWtnIOeauU4jSu+N5GPtKUqk8qT
	 M8YHIAIJ71UsA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 6781E7F78E; Mon, 26 May 2025 10:44:39 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 26 May 2025 10:44:33 +0800
Subject: [PATCH net] net: mctp: start tx queue on netdev open
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-dev-mctp-usb-v1-1-c7bd6cb75aa0@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAJDVM2gC/x3MQQ5AMBBA0avIrE1SU5VwFbGgHcxCSYtIGnfXW
 L7F/wkiB+EIXZEg8C1Rdp9RlQXYdfQLo7hsIEVGGWrQ8Y2bPQ+84oStpblmp7VWBDk5As/y/Ls
 ePJ8wvO8HVREq2GMAAAA=
X-Change-ID: 20250526-dev-mctp-usb-9c2f4ed33302
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Nitin Singh <nitsingh@nvidia.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

We stop queues in ndo_stop, so they need to be restarted in ndo_open.
This allows us to resume tx after a link down/up cycle.

Suggested-by: Nitin Singh <nitsingh@nvidia.com>
Fixes: 0791c0327a6e ("net: mctp: Add MCTP USB transport driver")
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index e8d4b01c3f34588fb8df97e550f35708c6582344..775a386d0aca1242e5d3c8a750c1d0825341caa6 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -257,6 +257,8 @@ static int mctp_usb_open(struct net_device *dev)
 
 	WRITE_ONCE(mctp_usb->stopped, false);
 
+	netif_start_queue(dev);
+
 	return mctp_usb_rx_queue(mctp_usb, GFP_KERNEL);
 }
 

---
base-commit: 5cdb2c77c4c3d36bdee83d9231649941157f8204
change-id: 20250526-dev-mctp-usb-9c2f4ed33302

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


