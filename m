Return-Path: <netdev+bounces-37240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF65C7B45B3
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 08:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 376BE282044
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 06:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6F61FD6;
	Sun,  1 Oct 2023 06:56:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B8ECA
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 06:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58091C433C8;
	Sun,  1 Oct 2023 06:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696143359;
	bh=WtOvsxSyDy2Ri8p3nkqCLB+0h+/ye1kzYWAJnyHQZSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mXGVdemoffS93wZWKJg68itmONSyRSQsT/6WsnKBOQskhr8vhd2eRGGz723MNYiDb
	 bJE6XVP7niuc0J0UbWMvsz0q2HwY5IODPQpvw0/qBG1XM9coRorAFcjaYIUPMxKbMk
	 3bYIo9N0N91JWMdeMMnbYit4M+PugaqDVYJ+3wT/o7X/7Ra4+WQiJ6AQ5ptxjPIBCr
	 u1S73LcxVgJN9ymj0Cx6glmiSk8K/wZqCYVwmqAY1os0mcT+i42bvWOwYfAsrn3gzZ
	 2xfTOuMFoI445w08jDEtbBCaNVyZ3piMAaCjONhp0YFUMc8xh0dKNzYYtZSdkqG2DJ
	 6th0TmfGqRptA==
Date: Sun, 1 Oct 2023 08:55:54 +0200
From: Simon Horman <horms@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladimir.oltean@nxp.com, s-vadapalli@ti.com,
	srk@ti.com, vigneshr@ti.com, p-varis@ti.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 2/4] net: ethernet: ti: am65-cpsw: add mqprio
 qdisc offload in channel mode
Message-ID: <20231001065554.GH92317@kernel.org>
References: <20230927072741.21221-1-rogerq@kernel.org>
 <20230927072741.21221-3-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927072741.21221-3-rogerq@kernel.org>

On Wed, Sep 27, 2023 at 10:27:39AM +0300, Roger Quadros wrote:

...

> +static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data)
> +{
> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
> +	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
> +	struct tc_mqprio_qopt_offload *mqprio = type_data;
> +	struct am65_cpsw_common *common = port->common;
> +	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
> +	int tc, offset, count, ret, prio;
> +	u8 num_tc = qopt->num_tc;
> +	u32 tx_prio_map = 0;
> +	int i;
> +
> +	memcpy(&p_mqprio->mqprio_hw, mqprio, sizeof(*mqprio));
> +
> +	ret = pm_runtime_get_sync(common->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(common->dev);
> +		return ret;
> +	}
> +
> +	if (!num_tc) {
> +		am65_cpsw_reset_tc_mqprio(ndev);
> +		goto exit_put;
> +	}
> +
> +	ret = am65_cpsw_mqprio_verify_shaper(port, mqprio);
> +	if (ret)
> +		goto exit_put;
> +
> +	netdev_set_num_tc(ndev, num_tc);
> +
> +	/* Multiple Linux priorities can map to a Traffic Class
> +	 * A Traffic Class can have multiple contiguous Queues,
> +	 * Queues get mapped to Channels (thread_id),
> +	 *	if not VLAN tagged, thread_id is used as packet_priority
> +	 *	if VLAN tagged. VLAN priority is used as packet_priorit

Hi,

I don't think it is worth respinning just because of this, but
there seems to be a 'y' missing from the end of the line above.

> +	 * packet_priority gets mapped to header_priority in p0_rx_pri_map,
> +	 * header_priority gets mapped to switch_priority in pn_tx_pri_map.
> +	 * As p0_rx_pri_map is left at defaults (0x76543210), we can
> +	 * assume that Queue_n gets mapped to header_priority_n. We can then
> +	 * set the switch priority in pn_tx_pri_map.
> +	 */

...

