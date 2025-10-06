Return-Path: <netdev+bounces-227975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2ECBBE607
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 16:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DEE318994BA
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 14:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F802D6626;
	Mon,  6 Oct 2025 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R1KrgpF/"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B401E2D594F;
	Mon,  6 Oct 2025 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761642; cv=none; b=iRyyNGMcOAooKuWm4X8l8CQpPQvpcdmJYMd6i17hpbvWc5M7lddp8EP1ABHnma+Xqd9adoWPAfcm5XY/fD3rao1pRjOsZM0nxkWMyVMPgyq7im7D4MmCklxIk+++cy1jrh9ACR1/8J6/6r4YlKb37eo6mf6tCVCqTc79uOj9BRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761642; c=relaxed/simple;
	bh=ssMBs0Xff6jpWsw9MVlUeHDAVz2fC+L6zGBjNDN2ni4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BPuvTLHBk7qSzAyXwFL5g8kIp1dawfDWqtzynPIgk/e2ZSuGslnr+XCOb28Agxrkx/wn0a3+IAvOt31YcIO1slOvQg598TW0DhRzxlon4qURRTio5a0FViOfJWFAC40Y1WzCGtM+6gBQHeZvE1o1mfgf0U6G/fys/lsQ3Pg5sOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R1KrgpF/; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 596EcFqJ4077801;
	Mon, 6 Oct 2025 09:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759761495;
	bh=6MqGd4dGQEDc9B35okJhvbxyP0Rp/RpHorOynofVJnc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=R1KrgpF/shgqXllPhZJn/0LOpFciTL6MxG/JLmDVRcjn2xYQwsrQ9d3DBH+zjTfLS
	 xQ5hMGIA3orlHB0wHs0O1q42sFjL+9loFEz+3MXLx4Q9CUP05+l9PZr22hOQl2+k0F
	 /QAyH6TZb8vhvWHFDbmJP44M08Rp030eAo0ESwzQ=
Received: from DFLE210.ent.ti.com (dfle210.ent.ti.com [10.64.6.68])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 596EcF6Z2292605
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 6 Oct 2025 09:38:15 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Oct
 2025 09:38:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Oct 2025 09:38:14 -0500
Received: from [10.249.130.74] ([10.249.130.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 596Ec8NT3823059;
	Mon, 6 Oct 2025 09:38:09 -0500
Message-ID: <44ed3d16-a8d2-49f3-a6b4-16d9a14d1cc6@ti.com>
Date: Mon, 6 Oct 2025 20:08:07 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 3/3] net: ti: icssm-prueth: Adds support
 for ICSSM RSTP switch
To: Parvathi Pudi <parvathi@couthit.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <danishanwar@ti.com>, <rogerq@kernel.org>,
        <pmohan@couthit.com>, <basharath@couthit.com>, <afd@ti.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <pratheesh@ti.com>,
        <prajith@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>, <srk@ti.com>,
        <rogerq@ti.com>, <krishna@couthit.com>, <mohan@couthit.com>
References: <20251006104908.775891-1-parvathi@couthit.com>
 <20251006104908.775891-4-parvathi@couthit.com>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20251006104908.775891-4-parvathi@couthit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Parvathi,

On 10/6/2025 4:17 PM, Parvathi Pudi wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> Adds support for RSTP switch mode by enhancing the existing ICSSM dual EMAC
> driver with switchdev support.
> 
> With this patch, the PRU-ICSSM is now capable of operating in switch mode
> with the 2 PRU ports acting as external ports and the host acting as an
> internal port. Packets received from the PRU ports will be forwarded to
> the host (store and forward mode) and also to the other PRU port (either
> using store and forward mode or via cut-through mode). Packets coming
> from the host will be transmitted either from one or both of the PRU ports
> (depending on the FDB decision).
> 
> By default, the dual EMAC firmware will be loaded in the PRU-ICSS
> subsystem. To configure the PRU-ICSS to operate as a switch, a different
> firmware must to be loaded.
> 
> Reviewed-by: Mohan Reddy Putluru <pmohan@couthit.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
> ---

[ ... ]>
> +static void icssm_prueth_change_to_switch_mode(struct prueth *prueth)
> +{
> +	bool portstatus[PRUETH_NUM_MACS];
> +	struct prueth_emac *emac;
> +	struct net_device *ndev;
> +	int i, ret;
> +
> +	for (i = 0; i < PRUETH_NUM_MACS; i++) {
> +		emac = prueth->emac[i];
> +		ndev = emac->ndev;
> +
> +		portstatus[i] = netif_running(ndev);
> +		if (!portstatus[i])
> +			continue;
> +
> +		ret = ndev->netdev_ops->ndo_stop(ndev);
> +		if (ret < 0) {
> +			netdev_err(ndev, "failed to stop: %d", ret);
> +			return;
> +		}
> +	}
> +
> +	prueth->eth_type = PRUSS_ETHTYPE_SWITCH;
> +
> +	for (i = 0; i < PRUETH_NUM_MACS; i++) {
> +		emac = prueth->emac[i];
> +		ndev = emac->ndev;
> +
> +		if (!portstatus[i])
> +			continue;
> +
> +		ret = ndev->netdev_ops->ndo_open(ndev);
> +		if (ret < 0) {
> +			netdev_err(ndev, "failed to start: %d", ret);
> +			return;
> +		}
> +	}
> +
> +	dev_info(prueth->dev, "TI PRU ethernet now in Switch mode\n");
> +}
> +
> +static void icssm_prueth_change_to_emac_mode(struct prueth *prueth)
> +{
> +	bool portstatus[PRUETH_NUM_MACS];
> +	struct prueth_emac *emac;
> +	struct net_device *ndev;
> +	int i, ret;
> +
> +	for (i = 0; i < PRUETH_NUM_MACS; i++) {
> +		emac = prueth->emac[i];
> +		ndev = emac->ndev;
> +
> +		portstatus[i] = netif_running(ndev);
> +		if (!portstatus[i])
> +			continue;
> +
> +		ret = ndev->netdev_ops->ndo_stop(ndev);
> +		if (ret < 0) {
> +			netdev_err(ndev, "failed to stop: %d", ret);
> +			return;
> +		}
> +	}
> +
> +	prueth->eth_type = PRUSS_ETHTYPE_EMAC;
> +
> +	for (i = 0; i < PRUETH_NUM_MACS; i++) {
> +		emac = prueth->emac[i];
> +		ndev = emac->ndev;
> +
> +		if (!portstatus[i])
> +			continue;
> +
> +		ret = ndev->netdev_ops->ndo_open(ndev);
> +		if (ret < 0) {
> +			netdev_err(ndev, "failed to start: %d", ret);
> +			return;
> +		}
> +	}
> +
> +	dev_info(prueth->dev, "TI PRU ethernet now in Dual EMAC mode\n");
> +}


The APIs icssm_prueth_change_to_emac_mode and
icssm_prueth_change_to_switch_mode seems identical. Won't it be better
to have one function to change modes and which mode to go to passed as
function argument.

	icssm_prueth_change_mode(prueth,mode);

This will also work seemlessly if you add more modes in future. With
current approach you will need to add new APIs
icssm_prueth_change_to_xyz_mode()


-- 
Thanks and Regards,
Md Danish Anwar


