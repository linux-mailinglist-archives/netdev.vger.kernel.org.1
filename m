Return-Path: <netdev+bounces-20962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 795CB76203A
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3372C2811EE
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B67525911;
	Tue, 25 Jul 2023 17:32:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDA01F932
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 17:32:25 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B3E2118
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6tjWrSxC2H4l/c6Gio8R4cfMpS/3KCsRCIXHndZIcXI=; b=Kzg7zj2nCe9Roe5JHfo9c8MAZi
	q4hDxgDV4CImbJ2P/qjuALwG8a+UlprjN4TRTdFZTg1bkheFuKBtkInToJItizDqm7IKLbFc6UqVu
	ab8Yz01zq/h4h6K2CQTIr1qlPhNYGpM+KyWQk/J/aRqnOO45w/hWCUqulCFxPVAGYQXY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qOLtV-002ICL-Bu; Tue, 25 Jul 2023 19:32:21 +0200
Date: Tue, 25 Jul 2023 19:32:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	Jose.Abreu@synopsys.com, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 2/7] net: pcs: xpcs: support to switch mode for
 Wangxun NICs
Message-ID: <d745524b-b306-447e-afbe-8935286301e4@lunn.ch>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com>
 <20230724102341.10401-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724102341.10401-3-jiawenwu@trustnetic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +static void txgbe_pma_config_10gbaser(struct dw_xpcs *xpcs)
> +{
> +	int val;
> +
> +	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL0, 0x21);
> +	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL3, 0);
> +	val = txgbe_read_pma(xpcs, TXGBE_TX_GENCTL1);
> +	val = u16_replace_bits(val, 0x5, TXGBE_TX_GENCTL1_VBOOST_LVL);
> +	txgbe_write_pma(xpcs, TXGBE_TX_GENCTL1, val);
> +	txgbe_write_pma(xpcs, TXGBE_MISC_CTL0, 0xCF00);
> +	txgbe_write_pma(xpcs, TXGBE_VCO_CAL_LD0, 0x549);
> +	txgbe_write_pma(xpcs, TXGBE_VCO_CAL_REF0, 0x29);
> +	txgbe_write_pma(xpcs, TXGBE_TX_RATE_CTL, 0);
> +	txgbe_write_pma(xpcs, TXGBE_RX_RATE_CTL, 0);
> +	txgbe_write_pma(xpcs, TXGBE_TX_GEN_CTL2, 0x300);
> +	txgbe_write_pma(xpcs, TXGBE_RX_GEN_CTL2, 0x300);
> +	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL2, 0x600);
> +
> +	txgbe_write_pma(xpcs, TXGBE_RX_EQ_CTL0, 0x45);
> +	val = txgbe_read_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL);
> +	val &= ~TXGBE_RX_EQ_ATTN_LVL0;
> +	txgbe_write_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL, val);
> +	txgbe_write_pma(xpcs, TXGBE_DFE_TAP_CTL0, 0xBE);

You have a lot of magic numbers above. Please truy to add some
#defines to try to explain what is going on here.

> +	val = txgbe_read_pma(xpcs, TXGBE_AFE_DFE_ENABLE);
> +	val &= ~(TXGBE_DFE_EN_0 | TXGBE_AFE_EN_0);
> +	txgbe_write_pma(xpcs, TXGBE_AFE_DFE_ENABLE, val);
> +	val = txgbe_read_pma(xpcs, TXGBE_RX_EQ_CTL4);
> +	val &= ~TXGBE_RX_EQ_CTL4_CONT_ADAPT0;
> +	txgbe_write_pma(xpcs, TXGBE_RX_EQ_CTL4, val);
> +}
> +
> +static void txgbe_pma_config_1g(struct dw_xpcs *xpcs)
> +{
> +	int val;
> +
> +	val = txgbe_read_pma(xpcs, TXGBE_TX_GENCTL1);
> +	val = u16_replace_bits(val, 0x5, TXGBE_TX_GENCTL1_VBOOST_LVL);
> +	val &= ~TXGBE_TX_GENCTL1_VBOOST_EN0;
> +	txgbe_write_pma(xpcs, TXGBE_TX_GENCTL1, val);
> +	txgbe_write_pma(xpcs, TXGBE_MISC_CTL0, 0xCF00);
> +
> +	txgbe_write_pma(xpcs, TXGBE_RX_EQ_CTL0, 0x7706);
> +	val = txgbe_read_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL);
> +	val &= ~TXGBE_RX_EQ_ATTN_LVL0;
> +	txgbe_write_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL, val);
> +	txgbe_write_pma(xpcs, TXGBE_DFE_TAP_CTL0, 0);
> +	val = txgbe_read_pma(xpcs, TXGBE_RX_GEN_CTL3);
> +	val = u16_replace_bits(val, 0x4, TXGBE_RX_GEN_CTL3_LOS_TRSHLD0);
> +	txgbe_write_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL, val);
> +
> +	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL0, 0x20);
> +	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL3, 0x46);
> +	txgbe_write_pma(xpcs, TXGBE_VCO_CAL_LD0, 0x540);
> +	txgbe_write_pma(xpcs, TXGBE_VCO_CAL_REF0, 0x2A);
> +	txgbe_write_pma(xpcs, TXGBE_AFE_DFE_ENABLE, 0);
> +	txgbe_write_pma(xpcs, TXGBE_RX_EQ_CTL4, 0x10);
> +	txgbe_write_pma(xpcs, TXGBE_TX_RATE_CTL, 0x3);
> +	txgbe_write_pma(xpcs, TXGBE_RX_RATE_CTL, 0x3);
> +	txgbe_write_pma(xpcs, TXGBE_TX_GEN_CTL2, 0x100);
> +	txgbe_write_pma(xpcs, TXGBE_RX_GEN_CTL2, 0x100);
> +	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL2, 0x200);
> +}
> +
> +static int txgbe_pcs_poll_power_up(struct dw_xpcs *xpcs)
> +{
> +	int val, ret;
> +
> +	/* Wait xpcs power-up good */
> +	ret = read_poll_timeout(xpcs_read_vpcs, val,
> +				(val & DW_PSEQ_ST) == DW_PSEQ_ST_GOOD,
> +				10000, 1000000, false,
> +				xpcs, DW_VR_XS_PCS_DIG_STS);
> +	if (ret < 0)
> +		pr_err("%s: xpcs power-up timeout\n", __func__);

dev_err(). xpcs->mdiodev->dev.

You want to know which pcs returned an error. Always use dev_err() in
preference to pr_err()

	Andrew

