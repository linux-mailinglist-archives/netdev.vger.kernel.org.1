Return-Path: <netdev+bounces-151473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2459EF91F
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6213177B75
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E1C221D93;
	Thu, 12 Dec 2024 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="StmJIb3w"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8606F2FE;
	Thu, 12 Dec 2024 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025314; cv=none; b=TF/OdLqR3OA3S6vBrWqCJDtgJtlrrlvicR7Ub8ZI1OUB7ZkDkCNcJWm4cqJA+j696Nckv5oiVtZRtt235aJeDarzn9Lc+sJuOgdq1IfPDWKEuQ1O0A84fpJS15vnkNuczO/lkcTFG33mlTh4HZ0/P+Lf29CYOHb3jMA+ZKJH5s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025314; c=relaxed/simple;
	bh=h1OgHvZrV/r+9yeGz1pyu/H5WwMytyQAVZq7j7iYJiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CN87d7WrbxAqzsK2LfPZEm9S32THvsk+qSTV1ZLgAS4ZpJE95TXrFn+76Jh1UKu0eu6GLs0GmwmcOKodRjeHg8vDwp4BaLpvC1QlbA93pNnb44oXY3+tWoudq1iRyOxuwaefC5nYEjYzcUjL5dkXFjSR3EI5P5EWHeO238tVHSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=StmJIb3w; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HzG8qPVDVt5NNcEUAYVGyZ32xnNQpVWDejnTHHrGg4E=; b=StmJIb3wJ/muDoGQcTNreEnU1y
	Ke910i7+CRU848GU0FmG06BjnyMVKmt+wBv8O3kTK+bB/aUhvz57K7HB1TVL2KnG7z7YRrSufRQJ+
	qT7yFGddfgKMkCamBuNDgMTZcc3vASZz52oE+oEKcWINr2bOQyjIG/VZ/7JiYXrRugF0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tLnC4-000ErC-8d; Thu, 12 Dec 2024 18:41:44 +0100
Date: Thu, 12 Dec 2024 18:41:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: gongfan <gongfan1@huawei.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Cai Huoqing <cai.huoqing@linux.dev>, Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Meny Yossefi <meny.yossefi@huawei.com>
Subject: Re: [RFC net-next v02 1/3] net: hinic3: module initialization and
 tx/rx logic
Message-ID: <b794027a-ef3b-4262-a952-db249a840e89@lunn.ch>
References: <cover.1733990727.git.gur.stavi@huawei.com>
 <7d62ca11c809ac646c2fd8613fd48729061c22b3.1733990727.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d62ca11c809ac646c2fd8613fd48729061c22b3.1733990727.git.gur.stavi@huawei.com>

> +static void hinic3_del_one_adev(struct hinic3_hwdev *hwdev,
> +				enum hinic3_service_type svc_type)
> +{
> +	struct hinic3_pcidev *pci_adapter = hwdev->adapter;
> +	struct hinic3_adev *hadev;
> +	bool timeout = true;
> +	unsigned long end;
> +
> +	end = jiffies + msecs_to_jiffies(HINIC3_EVENT_PROCESS_TIMEOUT);
> +	do {
> +		if (!test_and_set_bit(svc_type, &pci_adapter->state)) {
> +			timeout = false;
> +			break;
> +		}
> +		usleep_range(900, 1000);
> +	} while (time_before(jiffies, end));
> +
> +	if (timeout && !test_and_set_bit(svc_type, &pci_adapter->state))
> +		timeout = false;

Please look at using iopoll.h

> +static int hinic3_sw_init(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
> +	int err;
> +
> +	nic_dev->q_params.sq_depth = HINIC3_SQ_DEPTH;
> +	nic_dev->q_params.rq_depth = HINIC3_RQ_DEPTH;
> +
> +	hinic3_try_to_enable_rss(netdev);
> +
> +	eth_hw_addr_random(netdev);

Is using a random MAC just a temporary thing until more code is added
to access an OTP?

> +	err = register_netdev(netdev);
> +	if (err) {
> +		err = -ENOMEM;
> +		goto err_netdev;
> +	}
> +
> +	netif_carrier_off(netdev);
> +
> +	dev_set_drvdata(&adev->dev, nic_dev);

Is this used anywhere in the driver? Calling register_netdev() makes
the interface live, even before it returns. If you have NFS root for
example, it could be sending packets, etc, before drvdata is set.

> +int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_func_tbl_cfg func_tbl_cfg = {};
> +	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
> +
> +	if (new_mtu < HINIC3_MIN_MTU_SIZE) {
> +		dev_err(hwdev->dev,
> +			"Invalid mtu size: %ubytes, mtu size < %ubytes\n",
> +			new_mtu, HINIC3_MIN_MTU_SIZE);
> +		return -EINVAL;
> +	}
> +
> +	if (new_mtu > HINIC3_MAX_JUMBO_FRAME_SIZE) {
> +		dev_err(hwdev->dev, "Invalid mtu size: %ubytes, mtu size > %ubytes\n",
> +			new_mtu, HINIC3_MAX_JUMBO_FRAME_SIZE);
> +		return -EINVAL;
> +	}

The core can do this validation for you, if you set ndev->max_mtu,
ndev->min_mtu.


    Andrew

---
pw-bot: cr

