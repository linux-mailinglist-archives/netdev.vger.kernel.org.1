Return-Path: <netdev+bounces-159451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C7AA15857
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 20:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF7467A3671
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0EE1ACEBA;
	Fri, 17 Jan 2025 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWMnH20Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AAF1ACEB6
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737143301; cv=none; b=lX7ku0/letcjYYe3rwaRjE1grInKWbUDAL0NWRPiFh8UQ+Yn+KRQ1+ZnqqvLSVB7/udwvLkzjvFh633rKd4OCI/3u+G1yskXSiGYvlSvjWP3IfGIbmS+KzHDaVzuTXSkCOZxrH/YMAZe3TIG2bYdNjFx1jQE67IwkKNDa/iJmLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737143301; c=relaxed/simple;
	bh=liEb6FrciZS5IMCArR+0U4lSsdrh9MYWLJ5LVZqT+gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IattHLJGiYWvYicmgBv1aqyy39+R3nmAChMuZlmSIsEcmxo8dHVT/aREAySKCtaUMnw5JZz83UXEItts1QeNIaPpxf7GJ5s8FeXHOUirhGalDWrLTvQAeiXNLakHhgudR/G0V+njdtMsBFaonXPI9z6VIWQpTgUVzR1m7RRG9iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWMnH20Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C871C4CEE8;
	Fri, 17 Jan 2025 19:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737143301;
	bh=liEb6FrciZS5IMCArR+0U4lSsdrh9MYWLJ5LVZqT+gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QWMnH20Y68ZKLqtv8S3/izdDnjs3k2/iGdUddZp3njckEDVESQCy07jtDIwTCak1/
	 5pDcXeqRcwY7BQXd6aZEz0mEys3+iU0KCM6+OT23427rk45KiidY8032ekqRxAC2ym
	 Emi0pXGVhdSCpTn3xjEfmr9XLHi/XorE+fO9lK+FgrNkjmSmHlxyJtkJvZ8W9s1vFG
	 6lVwqfKk2qIswsIjLwZOzXO1Vho7/xkae8cnM+AMI7nPxBWkPnpfoNWD48sELNhl7e
	 /SZxrHzfs5ZTn+CRNL6119W/pcxDKee7/zGl1bOUaULqQm2vzvsAhuxOybZ84pszVM
	 Nrc8NTXvZFJRw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ap420073@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/6] eth: bnxt: allocate enough buffer space to meet HDS threshold
Date: Fri, 17 Jan 2025 11:48:14 -0800
Message-ID: <20250117194815.1514410-6-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250117194815.1514410-1-kuba@kernel.org>
References: <20250117194815.1514410-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we can configure HDS threshold separately from the rx_copybreak
HDS threshold may be higher than rx_copybreak.

We need to make sure that we have enough space for the headers.

Fixes: 6b43673a25c3 ("bnxt_en: add support for hds-thresh ethtool command")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2eeed4c11b64..19e723493c4e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4671,9 +4671,10 @@ void bnxt_set_ring_params(struct bnxt *bp)
 				  ALIGN(max(NET_SKB_PAD, XDP_PACKET_HEADROOM), 8) -
 				  SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 		} else {
-			rx_size = SKB_DATA_ALIGN(max(BNXT_DEFAULT_RX_COPYBREAK,
-						     bp->rx_copybreak) +
-						 NET_IP_ALIGN);
+			rx_size = max3(BNXT_DEFAULT_RX_COPYBREAK,
+				       bp->rx_copybreak,
+				       bp->dev->cfg_pending->hds_thresh);
+			rx_size = SKB_DATA_ALIGN(rx_size + NET_IP_ALIGN);
 			rx_space = rx_size + NET_SKB_PAD +
 				SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 		}
-- 
2.48.1


