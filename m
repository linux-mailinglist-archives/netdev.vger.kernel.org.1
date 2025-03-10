Return-Path: <netdev+bounces-173424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB20A58C18
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 07:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261353A8549
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 06:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932A11C1ADB;
	Mon, 10 Mar 2025 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAeeCfQ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDDC38B;
	Mon, 10 Mar 2025 06:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741588361; cv=none; b=B4dJ5eDaeoGCe4JtUjOgaXL8kz3XUUHMXpdAHsj9SO/PEKwSz9Ou9IOa/jI6FyeaVWlDCadWt1Rq02BmohV9+giWc8RCAaEdpo5tReKdReELndJ/aHAqDbo+WBDnNtnWDbsYaMq/NwWkvpDxTyXuldwq+8nJRyLxdsniC2rjBYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741588361; c=relaxed/simple;
	bh=EUFbqtCL5HuUmUMcDgzovMNMOcqHYTpQD4V/27f19tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFImXPNz+SymWsES/LMZCuHAFA5iBsXQFWdVQNx8O9ravor0ntap5Z/744devulojmpQlV2c33C8YSPL6Vp+sBiIqPEjsgHQ5+PxEa2umZa0khTF5ymKhk4YDmR6gO+gUYbTuq4Tq4SInFJpxOEZTA/mBix2zK41KJw0Ee+PuiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAeeCfQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C08DC4CEE5;
	Mon, 10 Mar 2025 06:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741588359;
	bh=EUFbqtCL5HuUmUMcDgzovMNMOcqHYTpQD4V/27f19tI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IAeeCfQ5aG6wEK+82/lMCroHOsh9eITArhIPbTbwHdomFD1iskJihRV1NovpIspBQ
	 XPIf/RFfZVkMHiAbzgMOlEeg+zSci1qabQNsNJ6kXftClEYqkdi0V6VNXBYiGr1jdc
	 coikgZFKdcY60HIB98S+Hax/P0qIdVu+ei7LeM8+wXV7O60xwUh0WSsYz5kPYtHK95
	 zQUFgnchgBXyXaAHh3zhysR+/k6Z7lv4P3HuZLywY3kTUmrEQRIq7hHsZi7qwxxMX/
	 wVsEBHeukZxtlCwf5hSPh8HXaIYxMOAT6nByLcWkPv0+vDsGo99deagc53gy1iheUz
	 O5YZ30rrTeFqw==
Date: Mon, 10 Mar 2025 07:32:26 +0100
From: Simon Horman <horms@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: Fan Gong <gongfan1@huawei.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Lee Trager <lee@trager.us>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Cai Huoqing <cai.huoqing@linux.dev>, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Meny Yossefi <meny.yossefi@huawei.com>,
	Suman Ghosh <sumang@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joe Damato <jdamato@fastly.com>
Subject: Re: [PATCH net-next v08 1/1] hinic3: module initialization and tx/rx
 logic
Message-ID: <20250310063226.GE4159220@kernel.org>
References: <cover.1741247008.git.gur.stavi@huawei.com>
 <fc43342cbb9915da210792edcc8f6bf661b298e9.1741247008.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc43342cbb9915da210792edcc8f6bf661b298e9.1741247008.git.gur.stavi@huawei.com>

On Thu, Mar 06, 2025 at 09:50:28AM +0200, Gur Stavi wrote:
> From: Fan Gong <gongfan1@huawei.com>
> 
> This is [1/3] part of hinic3 Ethernet driver initial submission.
> With this patch hinic3 is a valid kernel module but non-functional
> driver.
> 
> The driver parts contained in this patch:
> Module initialization.
> PCI driver registration but with empty id_table.
> Auxiliary driver registration.
> Net device_ops registration but open/stop are empty stubs.
> tx/rx logic.
> 
> All major data structures of the driver are fully introduced with the
> code that uses them but without their initialization code that requires
> management interface with the hw.
> 
> Co-developed-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> Co-developed-by: Gur Stavi <gur.stavi@huawei.com>
> Signed-off-by: Gur Stavi <gur.stavi@huawei.com>

Hi Gur,

I've reviewed this patch paying particular attention to error handling.

Please find some minor feedback below.

...

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c

...

> +static int hinic3_probe_func(struct hinic3_pcidev *pci_adapter)
> +{
> +	struct pci_dev *pdev = pci_adapter->pdev;
> +	int err;
> +
> +	err = hinic3_mapping_bar(pdev, pci_adapter);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to map bar\n");
> +		goto err_map_bar;
> +	}
> +
> +	err = hinic3_func_init(pdev, pci_adapter);
> +	if (err)
> +		goto err_func_init;
> +
> +	return 0;
> +
> +err_func_init:
> +	hinic3_unmapping_bar(pci_adapter);
> +
> +err_map_bar:
> +	dev_err(&pdev->dev, "Pcie device probe function failed\n");

nit: PCIE

> +	return err;
> +}

...

> +static int hinic3_sw_init(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
> +	int err;
> +
> +	nic_dev->q_params.sq_depth = HINIC3_SQ_DEPTH;
> +	nic_dev->q_params.rq_depth = HINIC3_RQ_DEPTH;
> +
> +	/* VF driver always uses random MAC address. During VM migration to a
> +	 * new device, the new device should learn the VMs old MAC rather than
> +	 * provide its own MAC. The product design assumes that every VF is
> +	 * suspectable to migration so the device avoids offering MAC address
> +	 * to VFs.
> +	 */
> +	eth_hw_addr_random(netdev);
> +	err = hinic3_set_mac(hwdev, netdev->dev_addr, 0,
> +			     hinic3_global_func_id(hwdev));
> +	if (err) {
> +		dev_err(hwdev->dev, "Failed to set default MAC\n");
> +		goto err_out;

nit: I think it would be slightly nicer to simply return err here
     and drop the err_out label. This is because there is no
     unwind to perform in this error case.

     Likewise for any similar cases that may be in this patch
     (I didn't spot any so far).

> +	}
> +
> +	err = hinic3_alloc_txrxqs(netdev);
> +	if (err) {
> +		dev_err(hwdev->dev, "Failed to alloc qps\n");
> +		goto err_alloc_qps;
> +	}
> +
> +	return 0;
> +
> +err_alloc_qps:
> +	hinic3_del_mac(hwdev, netdev->dev_addr, 0, hinic3_global_func_id(hwdev));
> +
> +err_out:
> +	return err;
> +}
> +
> +static void hinic3_sw_deinit(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +
> +	hinic3_free_txrxqs(netdev);
> +	hinic3_del_mac(nic_dev->hwdev, netdev->dev_addr, 0,
> +		       hinic3_global_func_id(nic_dev->hwdev));
> +}

...

> +static int hinic3_nic_probe(struct auxiliary_device *adev,
> +			    const struct auxiliary_device_id *id)
> +{
> +	struct hinic3_hwdev *hwdev = hinic3_adev_get_hwdev(adev);
> +	struct pci_dev *pdev = hwdev->pdev;
> +	struct hinic3_nic_dev *nic_dev;
> +	struct net_device *netdev;
> +	u16 max_qps, glb_func_id;
> +	int err;
> +
> +	if (!hinic3_support_nic(hwdev)) {
> +		dev_dbg(&adev->dev, "HW doesn't support nic\n");
> +		return 0;
> +	}
> +
> +	hinic3_adev_event_register(adev, hinic3_nic_event);
> +
> +	glb_func_id = hinic3_global_func_id(hwdev);
> +	err = hinic3_func_reset(hwdev, glb_func_id, COMM_FUNC_RESET_BIT_NIC);
> +	if (err) {
> +		dev_err(&adev->dev, "Failed to reset function\n");
> +		goto err_undo_event_register;
> +	}
> +
> +	max_qps = hinic3_func_max_qnum(hwdev);
> +	netdev = alloc_etherdev_mq(sizeof(*nic_dev), max_qps);
> +	if (!netdev) {
> +		dev_err(&adev->dev, "Failed to allocate netdev\n");
> +		err = -ENOMEM;
> +		goto err_undo_event_register;
> +	}
> +
> +	nic_dev = netdev_priv(netdev);
> +	dev_set_drvdata(&adev->dev, nic_dev);
> +	err = hinic3_init_nic_dev(netdev, hwdev);
> +	if (err)
> +		goto err_undo_netdev_alloc;
> +
> +	err = hinic3_init_nic_io(nic_dev);
> +	if (err)
> +		goto err_undo_netdev_alloc;
> +
> +	err = hinic3_sw_init(netdev);
> +	if (err)
> +		goto err_sw_init;
> +
> +	hinic3_assign_netdev_ops(netdev);
> +
> +	netdev_feature_init(netdev);
> +	err = hinic3_set_default_hw_feature(netdev);
> +	if (err)
> +		goto err_set_features;
> +
> +	err = register_netdev(netdev);
> +	if (err) {
> +		err = -ENOMEM;

Could you clarify why err is being overridden here?
I would have expected this function to return the
error returned by register_netdev?

> +		goto err_register_netdev;
> +	}
> +
> +	netif_carrier_off(netdev);
> +	return 0;
> +
> +err_register_netdev:
> +	hinic3_update_nic_feature(nic_dev, 0);
> +	hinic3_set_nic_feature_to_hw(nic_dev);
> +
> +err_set_features:
> +	hinic3_sw_deinit(netdev);
> +
> +err_sw_init:
> +	hinic3_free_nic_io(nic_dev);
> +
> +err_undo_netdev_alloc:
> +	free_netdev(netdev);
> +
> +err_undo_event_register:
> +	hinic3_adev_event_unregister(adev);
> +	dev_err(&pdev->dev, "NIC service probe failed\n");
> +
> +	return err;
> +}

...

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c

...

> +static int hinic3_change_mtu(struct net_device *netdev, int new_mtu)
> +{
> +	int err;
> +
> +	err = hinic3_set_port_mtu(netdev, new_mtu);
> +	if (err) {
> +		netdev_err(netdev, "Failed to change port mtu to %d\n", new_mtu);
> +	} else {
> +		netdev_dbg(netdev, "Change mtu from %u to %d\n", netdev->mtu, new_mtu);
> +		WRITE_ONCE(netdev->mtu, new_mtu);
> +	}
> +
> +	return err;

The above is straightforward enough, but I do think it would
be nicer to stick with the idiomatic pattern of keeping the
non-error paths in the main flow of execution, while
error paths are handled conditionally.

And also, to keep lines less than 80 columns wide unless
it reduces readability.

Something like this (completely untested!):

	err = hinic3_set_port_mtu(netdev, new_mtu);
	if (err) {
		netdev_err(netdev, "Failed to change port mtu to %d\n",
			   new_mtu);
		return err;
	}

	netdev_dbg(netdev, "Change mtu from %u to %d\n", netdev->mtu, new_mtu);
	WRITE_ONCE(netdev->mtu, new_mtu);

	return 0;

> +}

...

