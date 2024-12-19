Return-Path: <netdev+bounces-153260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04649F779D
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5741A7A2A4F
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 08:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BDD21D5B7;
	Thu, 19 Dec 2024 08:41:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD6141C79;
	Thu, 19 Dec 2024 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734597710; cv=none; b=fQAdJsPHoVQENWW5Dr3/2h2Fw7TFG3sCUjj1En2Y5OyJzZItdx27zSSiRq0eodhd3xKls5FOihSugFC2lpQXMbhmKyl5Ihi0ZUvZPrjFvQdI3EaZ1KCtoi1E7wxzcCKqLFVVpp6GMWp1Iba2al/ydQioX9HcBYfzVmlymMG4Z84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734597710; c=relaxed/simple;
	bh=snkC2yhtkrzPCscAJDw/TA1auWphpv+5kqavOBntcO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVWoG7ZSkHjkz6OR0p5742yHn3rogQmcB3pQtB6FfJXdAlswzjbC20v/7SrKpVIdCOiCQCmDYW37ZsEldyMJpHn2V6l7H1syyflGRbDk2jV6A7XIYxY/2DT7iJAof0o7Uco9aZpLljkEY9FVgtGpKEdX2QGAr26c8HZ8cYr5Zu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YDPD04Fsdz6K6RT;
	Thu, 19 Dec 2024 16:41:36 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id A034C140393;
	Thu, 19 Dec 2024 16:41:39 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 19 Dec
 2024 09:41:29 +0100
From: Gur Stavi <gur.stavi@huawei.com>
To: <andrew@lunn.ch>
CC: <andrew+netdev@lunn.ch>, <cai.huoqing@linux.dev>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <gongfan1@huawei.com>,
	<guoxin09@huawei.com>, <gur.stavi@huawei.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <meny.yossefi@huawei.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <shenchenyang1@hisilicon.com>,
	<shijing34@huawei.com>, <wulike1@huawei.com>, <zhoushuai28@huawei.com>
Subject: Re: [RFC net-next v02 1/3] net: hinic3: module initialization and tx/rx logic
Date: Thu, 19 Dec 2024 10:55:02 +0200
Message-ID: <20241219085502.2485372-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <b794027a-ef3b-4262-a952-db249a840e89@lunn.ch>
References: <b794027a-ef3b-4262-a952-db249a840e89@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 frapeml500005.china.huawei.com (7.182.85.13)

> > +static void hinic3_del_one_adev(struct hinic3_hwdev *hwdev,
> > +				enum hinic3_service_type svc_type)
> > +{
> > +	struct hinic3_pcidev *pci_adapter = hwdev->adapter;
> > +	struct hinic3_adev *hadev;
> > +	bool timeout = true;
> > +	unsigned long end;
> > +
> > +	end = jiffies + msecs_to_jiffies(HINIC3_EVENT_PROCESS_TIMEOUT);
> > +	do {
> > +		if (!test_and_set_bit(svc_type, &pci_adapter->state)) {
> > +			timeout = false;
> > +			break;
> > +		}
> > +		usleep_range(900, 1000);
> > +	} while (time_before(jiffies, end));
> > +
> > +	if (timeout && !test_and_set_bit(svc_type, &pci_adapter->state))
> > +		timeout = false;
>
> Please look at using iopoll.h
>

Ack

> > +static int hinic3_sw_init(struct net_device *netdev)
> > +{
> > +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> > +	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
> > +	int err;
> > +
> > +	nic_dev->q_params.sq_depth = HINIC3_SQ_DEPTH;
> > +	nic_dev->q_params.rq_depth = HINIC3_RQ_DEPTH;
> > +
> > +	hinic3_try_to_enable_rss(netdev);
> > +
> > +	eth_hw_addr_random(netdev);
>
> Is using a random MAC just a temporary thing until more code is added
> to access an OTP?
>

No, using a random MAC is not a temporary solution.
This device is designed for cloud environments. VFs are expected to be
used by VMs that may migrate from device to device. Therefore the HW does
not provide a MAC address to VFs, but rather the VF driver selects a
random MAC address and configures it into the (current) device.

Once the driver is extended to support PFs, the PF MAC will be obtained
from the device.

> > +	err = register_netdev(netdev);
> > +	if (err) {
> > +		err = -ENOMEM;
> > +		goto err_netdev;
> > +	}
> > +
> > +	netif_carrier_off(netdev);
> > +
> > +	dev_set_drvdata(&adev->dev, nic_dev);
>
> Is this used anywhere in the driver? Calling register_netdev() makes
> the interface live, even before it returns. If you have NFS root for
> example, it could be sending packets, etc, before drvdata is set.
>

Ack

> > +int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu)
> > +{
> > +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> > +	struct hinic3_func_tbl_cfg func_tbl_cfg = {};
> > +	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
> > +
> > +	if (new_mtu < HINIC3_MIN_MTU_SIZE) {
> > +		dev_err(hwdev->dev,
> > +			"Invalid mtu size: %ubytes, mtu size < %ubytes\n",
> > +			new_mtu, HINIC3_MIN_MTU_SIZE);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (new_mtu > HINIC3_MAX_JUMBO_FRAME_SIZE) {
> > +		dev_err(hwdev->dev, "Invalid mtu size: %ubytes, mtu size > %ubytes\n",
> > +			new_mtu, HINIC3_MAX_JUMBO_FRAME_SIZE);
> > +		return -EINVAL;
> > +	}
>
> The core can do this validation for you, if you set ndev->max_mtu,
> ndev->min_mtu.

Ack

