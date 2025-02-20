Return-Path: <netdev+bounces-168079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6CAA3D49A
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 10:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0DB3B9877
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EA41EEA5E;
	Thu, 20 Feb 2025 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JA1HLaGc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8951EC017;
	Thu, 20 Feb 2025 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043306; cv=none; b=uhosGHXD2zQtzTJ++wdoc1avocvMsCL9KcoduvrR7llnWH92q9dOK+pXE6BUTRrlrpGfhc61l+89MEwZ+jDalhuikqBeFt64aZbepGcEQVsq80BZXxcRAIHN/5HdmpzdFjcI+jkNCsoB6+BJCDLkzl3yPXZXMDzagqy3210G/+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043306; c=relaxed/simple;
	bh=1ZbDgEjUMlMPwkjWk2+5MSacMuvC5THJOJR7tBYLl9M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mxq6bCPqH9widlIk9edBQzus6WaUJG/HhZ3l7SZ9o+hpFKyxTUEuQCPivRnaFEY2WhKBDCfvqCq7LftC14dcvqzghvzsLa2Wbbr/DjGLGxS16Bf00H7nu3+exfrXCoiJVz0ivEQF9EXdX6/oDhqYJUXQfKJg+0nzOoxzd69/kEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JA1HLaGc; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K7Zctf023149;
	Thu, 20 Feb 2025 01:19:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=V6z79uj0D+hvHkgcPpuUpI1aZ
	TG2v3akXnDlrGc8hqU=; b=JA1HLaGcYiGl7zln21xvb7uit6enZw6xlti8mDBlR
	G4SJbwbdO7iO819Aev81Ct6m/q/6A1Kc4n+tXBmtMZehhrJPWZL4LkJCOexaL01n
	tiQUPOBB9Ho/r3kG8CDGMp5SyIPW5rgylecfEDo7M64xRQgi971JyIQSkDNW2l8H
	LWGW5gZac97OMItRvqat+JY/TRgM0rwWnCxHupHXGrZhusaDqKyNhO2Hvy+M+lca
	SQwWFYwWbr0su9QcSS6+vo984zcS3e2kBZ7Mfob/SoXWFI83t6FmQzXWFsgzy7uk
	gbzH1GqlhrS+2R2j6pCRF1BSHmawI4HEWaIp6vX+CDKMA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44x04yg88b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 01:19:16 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 20 Feb 2025 01:19:15 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 20 Feb 2025 01:19:15 -0800
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id BE6253F7058;
	Thu, 20 Feb 2025 01:19:05 -0800 (PST)
Date: Thu, 20 Feb 2025 14:49:04 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: parvathi <parvathi@couthit.com>
CC: <danishanwar@ti.com>, <rogerq@kernel.org>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <richardcochran@gmail.com>, <basharath@couthit.com>,
        <schnelle@linux.ibm.com>, <diogo.ivo@siemens.com>,
        <m-karicheri2@ti.com>, <horms@kernel.org>, <jacob.e.keller@intel.com>,
        <m-malladi@ti.com>, <javier.carrasco.cruz@gmail.com>, <afd@ti.com>,
        <s-anna@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pratheesh@ti.com>, <prajith@ti.com>,
        <vigneshr@ti.com>, <praneeth@ti.com>, <srk@ti.com>, <rogerq@ti.com>,
        <krishna@couthit.com>, <pmohan@couthit.com>, <mohan@couthit.com>
Subject: Re: [PATCH net-next v3 02/10] net: ti: prueth: Adds ICSSM Ethernet
 driver
Message-ID: <20250220091904.GA1230612@maili.marvell.com>
References: <20250214054702.1073139-1-parvathi@couthit.com>
 <20250214054702.1073139-3-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250214054702.1073139-3-parvathi@couthit.com>
X-Proofpoint-ORIG-GUID: PTTJNwmlFUm2mcEocC2aGHWKxK5J707q
X-Proofpoint-GUID: PTTJNwmlFUm2mcEocC2aGHWKxK5J707q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_03,2025-02-20_02,2024-11-22_01

On 2025-02-14 at 11:16:54, parvathi (parvathi@couthit.com) wrote:
> From: Roger Quadros <rogerq@ti.com>
>
> +static int icssm_prueth_probe(struct platform_device *pdev)
> +{
> +	struct device_node *eth0_node = NULL, *eth1_node = NULL;
> +	struct device_node *eth_node, *eth_ports_node;
> +	enum pruss_pru_id pruss_id0, pruss_id1;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np;
> +	struct prueth *prueth;
> +	int i, ret;
> +
> +	np = dev->of_node;
> +	if (!np)
> +		return -ENODEV; /* we don't support non DT */
> +
> +	prueth = devm_kzalloc(dev, sizeof(*prueth), GFP_KERNEL);
> +	if (!prueth)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, prueth);
> +	prueth->dev = dev;
> +	prueth->fw_data = device_get_match_data(dev);
> +
> +	eth_ports_node = of_get_child_by_name(np, "ethernet-ports");
> +	if (!eth_ports_node)
> +		return -ENOENT;
> +
> +	for_each_child_of_node(eth_ports_node, eth_node) {
> +		u32 reg;
> +
> +		if (strcmp(eth_node->name, "ethernet-port"))
> +			continue;
> +		ret = of_property_read_u32(eth_node, "reg", &reg);
> +		if (ret < 0) {
> +			dev_err(dev, "%pOF error reading port_id %d\n",
> +				eth_node, ret);
> +		}
> +
> +		of_node_get(eth_node);
> +
> +		if (reg == 0) {
> +			eth0_node = eth_node;
> +			if (!of_device_is_available(eth0_node)) {
> +				of_node_put(eth0_node);
> +				eth0_node = NULL;
> +			}
> +		} else if (reg == 1) {
> +			eth1_node = eth_node;
> +			if (!of_device_is_available(eth1_node)) {
> +				of_node_put(eth1_node);
> +				eth1_node = NULL;
> +			}
It depends on your DT, but is there any chance that more than once, we reach here in else case.
 { if (of_device_is_availabke(...) } ?

> +		} else {
> +			dev_err(dev, "port reg should be 0 or 1\n");
> +		}
> +	}
> +
> +	of_node_put(eth_ports_node);
> +
> +	/* At least one node must be present and available else we fail */
> +	if (!eth0_node && !eth1_node) {
> +		dev_err(dev, "neither port0 nor port1 node available\n");
> +		return -ENODEV;
> +	}
> +
> +	if (eth0_node == eth1_node) {
> +		dev_err(dev, "port0 and port1 can't have same reg\n");
> +		of_node_put(eth0_node);
> +		return -ENODEV;
> +	}
> +
> +	prueth->eth_node[PRUETH_MAC0] = eth0_node;
> +	prueth->eth_node[PRUETH_MAC1] = eth1_node;
  ...
+
> +	if (eth0_node) {
> +		prueth->pru0 = pru_rproc_get(np, 0, &pruss_id0);
> +		if (IS_ERR(prueth->pru0)) {
> +			ret = PTR_ERR(prueth->pru0);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(dev, "unable to get PRU0: %d\n", ret);
> +			goto put_pru;
> +		}
> +	}
> +
> +	if (eth1_node) {
> +		prueth->pru1 = pru_rproc_get(np, 1, &pruss_id1);
> +		if (IS_ERR(prueth->pru1)) {
> +			ret = PTR_ERR(prueth->pru1);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(dev, "unable to get PRU1: %d\n", ret);
> +			goto put_pru;
> +		}
> +	}
> +
> +	/* setup netdev interfaces */
> +	if (eth0_node) {
> +		ret = icssm_prueth_netdev_init(prueth, eth0_node);
> +		if (ret) {
> +			if (ret != -EPROBE_DEFER) {
> +				dev_err(dev, "netdev init %s failed: %d\n",
> +					eth0_node->name, ret);
> +			}
> +			goto put_pru;
> +		}
> +	}
> +
> +	if (eth1_node) {
> +		ret = icssm_prueth_netdev_init(prueth, eth1_node);
> +		if (ret) {
> +			if (ret != -EPROBE_DEFER) {
> +				dev_err(dev, "netdev init %s failed: %d\n",
> +					eth1_node->name, ret);
> +			}
> +			goto netdev_exit;
> +		}
> +	}
> +
> +	/* register the network devices */
> +	if (eth0_node) {
> +		ret = register_netdev(prueth->emac[PRUETH_MAC0]->ndev);
> +		if (ret) {
> +			dev_err(dev, "can't register netdev for port MII0");
> +			goto netdev_exit;
> +		}
> +
> +		prueth->registered_netdevs[PRUETH_MAC0] =
> +			prueth->emac[PRUETH_MAC0]->ndev;
> +	}
> +
> +	if (eth1_node) {
> +		ret = register_netdev(prueth->emac[PRUETH_MAC1]->ndev);
> +		if (ret) {
> +			dev_err(dev, "can't register netdev for port MII1");
> +			goto netdev_unregister;
> +		}
> +
> +		prueth->registered_netdevs[PRUETH_MAC1] =
> +			prueth->emac[PRUETH_MAC1]->ndev;
> +	}
> +
> +	if (eth1_node)
> +		of_node_put(eth1_node);
> +	if (eth0_node)
> +		of_node_put(eth0_node);
nit: A function would be better than code duplication for eth0_node and eth1_node ?
> +	return 0;
> +
> +netdev_unregister:
> +	for (i = 0; i < PRUETH_NUM_MACS; i++) {
> +		if (!prueth->registered_netdevs[i])
> +			continue;
> +		unregister_netdev(prueth->registered_netdevs[i]);
> +	}
> +
> +netdev_exit:
> +	for (i = 0; i < PRUETH_NUM_MACS; i++) {
> +		eth_node = prueth->eth_node[i];
> +		if (!eth_node)
> +			continue;
> +
> +		icssm_prueth_netdev_exit(prueth, eth_node);
> +	}
> +
> +put_pru:
> +	if (eth1_node) {
> +		if (prueth->pru1)
> +			pru_rproc_put(prueth->pru1);
> +		of_node_put(eth1_node);
> +	}
> +
> +	if (eth0_node) {
> +		if (prueth->pru0)
> +			pru_rproc_put(prueth->pru0);
> +		of_node_put(eth0_node);
> +	}
> +
> +	return ret;
> +}
> +

