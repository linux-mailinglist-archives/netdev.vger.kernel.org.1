Return-Path: <netdev+bounces-38141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A626D7B98CF
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 01:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 56C7E280DF4
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 23:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB151328CD;
	Wed,  4 Oct 2023 23:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1HNdcts"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A067D262B9
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 23:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BBAC433C7;
	Wed,  4 Oct 2023 23:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696463168;
	bh=w/dViWUp5YB4XWOD8iU7p44DNYRKqwMviFPAo/c2t4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L1HNdctsKN3OkW7bquF41Qx2kws3c3JE3cvcr7O2PBsIpqYDKYOhwwyAdnS7/SPx4
	 m6CZvhdhNOpqXdMtZFSiPczebVXIrVM9+H9PerfKqoslki3wZHLw03PzdCSj1+P8DX
	 dAkTTBYeqtfHTasruC5xabsWRxl8ycOYDuMYKb1Ah/Q6P+qJIacsSerJ9HNPLOyajv
	 HjOSeWMe2XFFjWLRKyKIKgt5E9HxFE1AtB9j9tUkVPIY/DSj6e5pPoiJtDKPvgxJ19
	 uadusabvjZ8L+6uY5u78kTIFGPyfuKo7EoSEwYNPswdOP3+9r0mb8dYmUsN2OjrLMg
	 NZEzz/hEtQDGA==
Date: Wed, 4 Oct 2023 16:46:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew@lunn.ch, mengyuanlou@net-swift.com
Subject: Re: [RESEND PATCH net-next v2 1/3] net: libwx: support hardware
 statistics
Message-ID: <20231004164606.31e98eb6@kernel.org>
In-Reply-To: <20230927061457.993277-2-jiawenwu@trustnetic.com>
References: <20230927061457.993277-1-jiawenwu@trustnetic.com>
	<20230927061457.993277-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Sep 2023 14:14:55 +0800 Jiawen Wu wrote:
> +static const struct wx_stats wx_gstrings_stats[] = {
> +	WX_NETDEV_STAT("rx_packets", rx_packets),
> +	WX_NETDEV_STAT("tx_packets", tx_packets),
> +	WX_NETDEV_STAT("rx_bytes", rx_bytes),
> +	WX_NETDEV_STAT("tx_bytes", tx_bytes),
> +	WX_NETDEV_STAT("multicast", multicast),
> +	WX_NETDEV_STAT("rx_errors", rx_errors),
> +	WX_NETDEV_STAT("rx_length_errors", rx_length_errors),
> +	WX_NETDEV_STAT("rx_crc_errors", rx_crc_errors),

Please don't report standard netdev statistics in ethtool -S.
Users can get them thru any of the (too) many standard APIs.

> +	WX_STAT("rx_pkts_nic", stats.gprc),
> +	WX_STAT("tx_pkts_nic", stats.gptc),
> +	WX_STAT("rx_bytes_nic", stats.gorc),
> +	WX_STAT("tx_bytes_nic", stats.gotc),
> +	WX_STAT("rx_total_pkts", stats.tpr),
> +	WX_STAT("tx_total_pkts", stats.tpt),
> +	WX_STAT("rx_broadcast", stats.bprc),
> +	WX_STAT("tx_broadcast", stats.bptc),
> +	WX_STAT("rx_multicast", stats.mprc),
> +	WX_STAT("tx_multicast", stats.mptc),
> +	WX_STAT("rx_long_length_count", stats.roc),
> +	WX_STAT("rx_short_length_count", stats.ruc),
> +	WX_STAT("rx_flow_control_xon_xoff", stats.lxonoffrxc),
> +	WX_STAT("tx_flow_control_xon", stats.lxontxc),
> +	WX_STAT("tx_flow_control_xoff", stats.lxofftxc),

Please take a look at the statistics defined in ethtool.h
Look for callbacks in struct ethtool_ops with "stats" in the name.
Anything that matches one of the callbacks should go into those
APIs no to ethtool -S.

> +	WX_STAT("os2bmc_rx_by_bmc", stats.o2bgptc),
> +	WX_STAT("os2bmc_tx_by_bmc", stats.b2ospc),
> +	WX_STAT("os2bmc_tx_by_host", stats.o2bspc),
> +	WX_STAT("os2bmc_rx_by_host", stats.b2ogprc),
> +	WX_STAT("rx_no_dma_resources", stats.rdmdrop),
> +	WX_STAT("tx_busy", tx_busy),
> +	WX_STAT("non_eop_descs", non_eop_descs),
> +	WX_STAT("tx_restart_queue", restart_queue),
> +	WX_STAT("rx_csum_offload_good_count", hw_csum_rx_good),
> +	WX_STAT("rx_csum_offload_errors", hw_csum_rx_error),
> +	WX_STAT("alloc_rx_buff_failed", alloc_rx_buff_failed),
> +};
> +
> +static const char wx_gstrings_test[][ETH_GSTRING_LEN] = {
> +	"Register test  (offline)", "Eeprom test    (offline)",
> +	"Interrupt test (offline)", "Loopback test  (offline)",
> +	"Link test   (on/offline)"
> +};

You said this adds stats. Why are strings for tests here?
-- 
pw-bot: cr

