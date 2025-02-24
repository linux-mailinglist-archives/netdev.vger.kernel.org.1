Return-Path: <netdev+bounces-168884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65548A41460
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 05:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1391C7A42BB
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 04:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A001A3153;
	Mon, 24 Feb 2025 04:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dp5aZ59p"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25870EACE;
	Mon, 24 Feb 2025 04:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740370154; cv=none; b=t7qIHzO2/TucpElPQIX/s+lIrgo4QE+2tXbXLhlFOVchJVEOJ/ICcd3DkMj7nrv4xJMFHOUUNnmz9oR5PwtlwCGa9dW97/6Olzn/H/ZbxSgvn0xCdCLfLAxrgZmK+Lgx4Zub60RFlNIfZ7ldWAA/TOxD+eN06E6F/SCROGAKoC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740370154; c=relaxed/simple;
	bh=603MhIoDIG5eFmq189ghXU/BNq49N6zz5Jz6S1Bur2Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZT1lx8qX798InVllv/SjQOL4Ln0UR0Mw2VPy8d+m7oCpgtyFqo2vCzxjou7scRRDGNSQdlaFFndXFifnYJyyeUNqzhqjpvmH5JJOhficZ0jPfUt/obnyV1FPHkw2daVTibZBuZOxdmyHtqQOT+VQjK3/MClmJ1pAW5njOCZvWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dp5aZ59p; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51NNwPsL005215;
	Sun, 23 Feb 2025 20:08:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=dMA+Qv9h5KBgwgNmQIaajGuLz
	HS3+FjnopuYPOJKf7w=; b=dp5aZ59pabOoPHhyIYXtQZlaHFfrdtmM9OOeeq4Na
	OD+YE0GOgeCjAdCEJ9xs4BvVHNwAx/F+FiBA3KEE7ZuzOEIo9jar9nAD6xGANKeH
	6GQ7lkDgova9BvFj9yd2BdFBKqrZb5+D89vVQ1PaQ7qitXhkQc/sHYG9tZycQzS2
	6v5ZGkuob+3Mr86GolajaTi42TdmbtYXluUQiNwciOnoQh62tj63uayAS6jcrAo3
	UX90ELb/GVIXo4SDr6DB755V4TMadlZ3H51SzA+N0wYhpxQ3hfL1TGuVafu+9aO5
	wZd+xLGlrZItuhmCmk9P1Lg8LxXBZs8dbgWhzGWnsF7mA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44yeyktng5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 20:08:44 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 23 Feb 2025 20:08:43 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 23 Feb 2025 20:08:43 -0800
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id CA0FB3F7067;
	Sun, 23 Feb 2025 20:08:39 -0800 (PST)
Date: Mon, 24 Feb 2025 09:38:38 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <hfdevel@gmx.net>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        FUJITA Tomonori
	<fujita.tomonori@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 5/7] net: tn40xx: create swnode for mdio and
 aqr105 phy and add to mdiobus
Message-ID: <20250224040838.GA1655046@maili.marvell.com>
References: <20250222-tn9510-v3a-v5-0-99365047e309@gmx.net>
 <20250222-tn9510-v3a-v5-5-99365047e309@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250222-tn9510-v3a-v5-5-99365047e309@gmx.net>
X-Proofpoint-ORIG-GUID: 102jm9nJXvzcgV6BcdZHPn9t9HadZn2M
X-Proofpoint-GUID: 102jm9nJXvzcgV6BcdZHPn9t9HadZn2M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_01,2025-02-20_02,2024-11-22_01

On 2025-02-22 at 15:19:32, Hans-Frieder Vogt via B4 Relay (devnull+hfdevel.gmx.net@kernel.org) wrote:
> From: Hans-Frieder Vogt <hfdevel@gmx.net>
>  int tn40_mdiobus_init(struct tn40_priv *priv)
>  {
>  	struct pci_dev *pdev = priv->pdev;
> @@ -129,14 +181,36 @@ int tn40_mdiobus_init(struct tn40_priv *priv)
>
>  	bus->read_c45 = tn40_mdio_read_c45;
>  	bus->write_c45 = tn40_mdio_write_c45;
> +	priv->mdio = bus;
> +
> +	/* provide swnodes for AQR105-based cards only */
> +	if (pdev->device == 0x4025) {
> +		ret = tn40_swnodes_register(priv);
> +		if (ret) {
> +			pr_err("swnodes failed\n");
> +			return ret;
> +		}
> +
> +		ret = device_add_software_node(&bus->dev,
> +					       priv->nodes.group[SWNODE_MDIO]);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"device_add_software_node failed: %d\n", ret);
No need to return on this error ?
> +		}
> +	}
>
>  	ret = devm_mdiobus_register(&pdev->dev, bus);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to register mdiobus %d %u %u\n",
>  			ret, bus->state, MDIOBUS_UNREGISTERED);
> -		return ret;
> +		goto err_swnodes_cleanup;
>  	}
>  	tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_6MHZ);
> -	priv->mdio = bus;
>  	return 0;
> +
> +err_swnodes_cleanup:
No need to call device_remove_software_node() ?
> +	tn40_swnodes_cleanup(priv);
> +	return ret;
>  }
> +
> +MODULE_FIRMWARE(AQR105_FIRMWARE);
>
> --
> 2.47.2
>
>

