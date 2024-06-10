Return-Path: <netdev+bounces-102394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED03E902C4F
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 01:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BED41C21B51
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 23:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB42F1527B6;
	Mon, 10 Jun 2024 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aWPsxiAZ"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C56E152503
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718061035; cv=none; b=eHFmN3DGsOA1ANRiHhgX7SEqQ5roCbXBko6g2zjRWEWcNwUZUkX+62hTd8ELdADIuZ+r9imni5YWyf7Pv+YIgf/9CnNFjo8qw23kZk8acylSrdxJOLRpmP+NEz0q9L9XQp6Ncg2frppGEX2HIDVEhrVrwGbfS+s5z6LN7I2Zi/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718061035; c=relaxed/simple;
	bh=GFaYaJtsfE/rjCCrgvMKC46RB3LB0XYd4/10z+G9YBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WJK+lkmP+v4JF/JmmeZ0Tg+DMYB5VRyoYec6RRtEPOMrFH/4R3XNIHBwhV9FYcV04IwzyG4U+pBWLfDgBIQf9D4XR2cjR9nGyvrmZezhNzMucAxmlkKRzjy0nTpxSL2L5kXLzymZjthoHsJI/+ZNmGzgN0nZ6AByJP2TemZAqJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aWPsxiAZ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: radhey.shyam.pandey@amd.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718061031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sIDawGWKnyBrcoVqu6SX/m8fgf8mjjwXZDoaerxtp0I=;
	b=aWPsxiAZ15vIqd70WUR9Qmw0LCIk6kOncWlKNdnMpa/c1XxyAD+2xD7Yes+lV1Q2hXcl+V
	0Q6JHYWOk44Q2MlyNIkmiG4E58qd253f9n2Aao+FvLYCrd1O1JUnMRmgjBb5UgOIEB4zgM
	p9mwIKJPtAoaqKGEexY9FGJeyU2+X4c=
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: linux@armlinux.org.uk
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: edumazet@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: davem@davemloft.net
X-Envelope-To: sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next 1/3] net: xilinx: axienet: Use NL_SET_ERR_MSG instead of netdev_err
Date: Mon, 10 Jun 2024 19:10:20 -0400
Message-Id: <20240610231022.2460953-2-sean.anderson@linux.dev>
In-Reply-To: <20240610231022.2460953-1-sean.anderson@linux.dev>
References: <20240610231022.2460953-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This error message can be triggered by userspace. Use NL_SET_ERR_MSG so
the message is returned to the user and to avoid polluting the kernel
logs.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index c29809cd9201..5f98daa5b341 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1945,9 +1945,9 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
 	struct axienet_local *lp = netdev_priv(ndev);
 
 	if (netif_running(ndev)) {
-		netdev_err(ndev,
-			   "Please stop netif before applying configuration\n");
-		return -EFAULT;
+		NL_SET_ERR_MSG(extack,
+			       "Please stop netif before applying configuration");
+		return -EBUSY;
 	}
 
 	if (ecoalesce->rx_max_coalesced_frames)
-- 
2.35.1.1320.gc452695387.dirty


