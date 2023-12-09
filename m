Return-Path: <netdev+bounces-55508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3E080B15E
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 02:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784551F21334
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 01:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311AD7FB;
	Sat,  9 Dec 2023 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfI18qrG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F48A7F8
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 01:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3569CC433C7;
	Sat,  9 Dec 2023 01:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702084802;
	bh=hVigKT550531qlZ6qSXnMPAArwz4M9cfZgioruTdoHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YfI18qrGrWk9KPLmgAl2jP8K9xzJRqQygRyjWX8BK9iAw2S0XC+agrNxPERLIDY/F
	 wgGv68XnntykaehIhnYcPPSB6BYJc32coGUQxvBKZvkORXwldzv50lFf084rIROXnX
	 6p5iwmrkdZO2R3IJ4nFrc5CIBYqtbYR7nGgpKxrRzX/GfnyumoLQtKnLo/lycNdLwO
	 QgZR8r4NOxiwdR2oWTyWhw7mSkjrRSIKEb3nxrkdPgkWP4scnmOIghQw7O2QyEYaEb
	 O92Ho9a2U1rs8MQacPFRVtRa6lN4TcQOQg7Tc2elGJpKr/S5jRx70usD7R6GG8wyjJ
	 kzpMuSSbTvoqQ==
Date: Fri, 8 Dec 2023 17:20:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, Pucha
 Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next] i40e: remove fake support of rx-frames-irq
Message-ID: <20231208172001.55550653@kernel.org>
In-Reply-To: <20231207183648.2819987-1-anthony.l.nguyen@intel.com>
References: <20231207183648.2819987-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Dec 2023 10:36:47 -0800 Tony Nguyen wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Since we never support this feature for I40E driver, we don't have to
> display the value when using 'ethtool -c eth0'.
> 
> Before this patch applied, the rx-frames-irq is 256 which is consistent
> with tx-frames-irq. Apparently it could mislead users.

IIUC now the rx-frames-irq will be 0 / not set, so you should also:

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index a0b10230268d..611996a35943 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5786,7 +5786,7 @@ static const struct ethtool_ops i40e_ethtool_recovery_mode_ops = {
 
 static const struct ethtool_ops i40e_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
-				     ETHTOOL_COALESCE_MAX_FRAMES_IRQ |
+				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
 				     ETHTOOL_COALESCE_RX_USECS_HIGH |
 				     ETHTOOL_COALESCE_TX_USECS_HIGH,
-- 
pw-bot: cr

