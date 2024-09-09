Return-Path: <netdev+bounces-126589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D7D971ED1
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 18:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE4BAB242B7
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 16:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6469F152E1C;
	Mon,  9 Sep 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WMwpFzo0"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801F91494BA;
	Mon,  9 Sep 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898231; cv=none; b=nGGNYBCQIE219dfHWTGPjmsrLvnoA6IM0ezRyuX4as1nXLrleAfwcDMoeFbjIFmO44b+2VoNO/dRVQ52ycE8zIcEZ8FijK6aGeCWMiQg/6boR2l5a4sJPCPtU76NxuViCEreR3de+Wbgvp/R8G4dS+q4h66cpfX0m1M2QWX+ZA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898231; c=relaxed/simple;
	bh=Q7PpYi7/+ndB8e5BYvLIv7xeoZYc3tbMmj33jNf78j4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MYPiCLKyPTSXZMdkAOLAe9dnBfGD18A54sJEhFUjubIql+YpDPD+A+eiztxklan5GOoJ2oSzyWDC0mq4wSnpsFEyed0Xf3EGrPvxysnT+NlfdFij/ilAxu74FoJYgZqu01MuTrLlIgR1sPlIWBDgSAdSfx2dyAEmtNdTS8r1Su4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WMwpFzo0; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725898227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19quJ8EY+Cd/sjvlTdES6J8MCKiXC6Ag5+CEkCU5nos=;
	b=WMwpFzo0pw4JmPy1X46W/muKBh4whAMOfVtsKIzGGVe8CB6S1tZR2gvzgdGXNSEDmFxOBw
	BfdMByBIN0Fql23i1D/jaiyy4wb77jPzNdATlalFUontaQQdzq1AnFElzzML/TzxRJsAna
	m0OpznsksfqzjgbAlg5ZPnM+O+SunN4=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v2 3/4] net: xilinx: axienet: Set RXCSUM in features
Date: Mon,  9 Sep 2024 12:10:15 -0400
Message-Id: <20240909161016.1149119-4-sean.anderson@linux.dev>
In-Reply-To: <20240909161016.1149119-1-sean.anderson@linux.dev>
References: <20240909161016.1149119-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When it is supported by hardware, we enable receive checksum offload
unconditionally. Update features to reflect this.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- New

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 74fade5a95c2..2f7ab0922aed 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2647,9 +2647,11 @@ static int axienet_probe(struct platform_device *pdev)
 		switch (value) {
 		case 1:
 			lp->features |= XAE_FEATURE_PARTIAL_RX_CSUM;
+			ndev->features |= NETIF_F_RXCSUM;
 			break;
 		case 2:
 			lp->features |= XAE_FEATURE_FULL_RX_CSUM;
+			ndev->features |= NETIF_F_RXCSUM;
 			break;
 		}
 	}
-- 
2.35.1.1320.gc452695387.dirty


