Return-Path: <netdev+bounces-141020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611109B91E7
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBB07B23583
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 13:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDC2174EFC;
	Fri,  1 Nov 2024 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="l5MDxFoS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EFB4594D;
	Fri,  1 Nov 2024 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467295; cv=none; b=XoE8oNbDZcKuiX1snndieaPtEGVdb2wiMfI6ueVNzaWBQSHY6Oz+KE7fATMGTy34DMdkEPOi7PZ6sx5bncYl6afClQfCK+tWCzdVNnysZc/yRQv9xFrsiCrcjAqMuQz4XdfZMLofFRwu1HTeg3IKidw7+j2AOZEUbQbgkSlbSUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467295; c=relaxed/simple;
	bh=XH6sbjoUubWTMqj04hlHJ/0gNF+lGmSqpStKlrwmfKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjBdqUTj8cJR340UsYTRdRKo1/KdRvTrjZhnSdDYOqbpmQna3cMQ7mm2/Ns50jLhsEqZV6k/9EM1sCbnbi9YUzuK63q2FyRO8wbS9126+lbZudm5xd5/yuBRHItNZFJQjWvWixLRwFxjSmCFSrzG1pkkBXpH2SUj3wxKSqS9Shc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=l5MDxFoS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AxLfJZD1nRRu4KvUSAP3JkzEZBYL1jUH+DoBIelmnw8=; b=l5MDxFoSFb1dXXTHNz6iakONe1
	mM2kJ8bqyYp0kuCRqVJvzSmGTHlgg+dedtcPTnMGVhu6Jv4BcDVfHViNvZIe6ulLoh59PQyxtSm+X
	K54p0JGMCMFmXjssTmT6NRJy57q7x8fcU6wEKNoqsEKt54LJe7XIlp1SELZwXa7yXtKI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t6rae-00Bskr-Oc; Fri, 01 Nov 2024 14:21:24 +0100
Date: Fri, 1 Nov 2024 14:21:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lei Wei <quic_leiwei@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_kkumarcs@quicinc.com, quic_suruchia@quicinc.com,
	quic_pavir@quicinc.com, quic_linchen@quicinc.com,
	quic_luoj@quicinc.com, srinivas.kandagatla@linaro.org,
	bartosz.golaszewski@linaro.org, vsmuthu@qti.qualcomm.com,
	john@phrozen.org
Subject: Re: [PATCH net-next 3/5] net: pcs: qcom-ipq: Add PCS create and
 phylink operations for IPQ9574
Message-ID: <d7782a5e-2f67-4f62-a594-0f52144a368f@lunn.ch>
References: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
 <20241101-ipq_pcs_rc1-v1-3-fdef575620cf@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101-ipq_pcs_rc1-v1-3-fdef575620cf@quicinc.com>

> +static int ipq_pcs_config_mode(struct ipq_pcs *qpcs,
> +			       phy_interface_t interface)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	/* Configure PCS interface mode */
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +		/* Select Qualcomm SGMII AN mode */
> +		ret = regmap_update_bits(qpcs->regmap, PCS_MODE_CTRL,
> +					 PCS_MODE_SEL_MASK | PCS_MODE_AN_MODE,
> +					 PCS_MODE_SGMII);

How does Qualcomm SGMII AN mode differ from Cisco SGMII AN mode?

> +static int ipq_pcs_config_sgmii(struct ipq_pcs *qpcs,
> +				int index,
> +				unsigned int neg_mode,
> +				phy_interface_t interface)
> +{
> +	int ret;
> +
> +	/* Access to PCS registers such as PCS_MODE_CTRL which are
> +	 * common to all MIIs, is lock protected and configured
> +	 * only once. This is required only for interface modes
> +	 * such as QSGMII.
> +	 */
> +	if (interface == PHY_INTERFACE_MODE_QSGMII)
> +		mutex_lock(&qpcs->config_lock);

Is there a lot of contention on this lock? Why not take it for every
interface mode? It would make the code simpler.

> +struct phylink_pcs *ipq_pcs_create(struct device_node *np)
> +{
> +	struct platform_device *pdev;
> +	struct ipq_pcs_mii *qpcs_mii;
> +	struct device_node *pcs_np;
> +	struct ipq_pcs *qpcs;
> +	int i, ret;
> +	u32 index;
> +
> +	if (!of_device_is_available(np))
> +		return ERR_PTR(-ENODEV);
> +
> +	if (of_property_read_u32(np, "reg", &index))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (index >= PCS_MAX_MII_NRS)
> +		return ERR_PTR(-EINVAL);
> +
> +	pcs_np = of_get_parent(np);
> +	if (!pcs_np)
> +		return ERR_PTR(-ENODEV);
> +
> +	if (!of_device_is_available(pcs_np)) {
> +		of_node_put(pcs_np);
> +		return ERR_PTR(-ENODEV);
> +	}

How have you got this far if the parent is not available?

> +	for (i = 0; i < PCS_MII_CLK_MAX; i++) {
> +		qpcs_mii->clk[i] = of_clk_get_by_name(np, pcs_mii_clk_name[i]);
> +		if (IS_ERR(qpcs_mii->clk[i])) {
> +			dev_err(qpcs->dev,
> +				"Failed to get MII %d interface clock %s\n",
> +				index, pcs_mii_clk_name[i]);
> +			goto err_clk_get;
> +		}
> +
> +		ret = clk_prepare_enable(qpcs_mii->clk[i]);
> +		if (ret) {
> +			dev_err(qpcs->dev,
> +				"Failed to enable MII %d interface clock %s\n",
> +				index, pcs_mii_clk_name[i]);
> +			goto err_clk_en;
> +		}
> +	}

Maybe devm_clk_bulk_get() etc will help you here? I've never actually
used them, so i don't know for sure.

	Andrew

