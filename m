Return-Path: <netdev+bounces-33421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDF379DE15
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 04:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95FF281F21
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 02:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC48394;
	Wed, 13 Sep 2023 02:11:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508EA384
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 02:11:46 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B100170A;
	Tue, 12 Sep 2023 19:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=avV8r0nWUil3JyzNjobwvIx5+PrmCt2ojoqlM6AoX1U=; b=x7FdjNYPEkJKo97s/bmhx0P/GH
	X0xqTp+5vEv5bd0Zq1b7VH5bC2IXyH3YioVH778LQM0yglXHxKNSYff7xjM2LuqxiD4DpAtEN/DTF
	gRJ3bBkvUoGKzhzbIbSTkAnz59JZClEAEvirHmIngpp2J+h1Bxv88iccQmV9V7+cIEL4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qgFLr-006Gxb-Ah; Wed, 13 Sep 2023 04:11:35 +0200
Date: Wed, 13 Sep 2023 04:11:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, steen.hegelund@microchip.com, rdunlap@infradead.org,
	horms@kernel.org, casper.casan@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, horatiu.vultur@microchip.com,
	Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com
Subject: Re: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Message-ID: <f23997c1-7507-41c6-8bb3-47d6a353beb8@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>

> +static bool oa_tc6_get_parity(u32 p)
> +{
> +	bool parity = true;
> +
> +	/* This function returns an odd parity bit */
> +	while (p) {
> +		parity = !parity;
> +		p = p & (p - 1);
> +	}
> +	return parity;

Please take a look around and see if you can find another
implementation in the kernel which can be used. If not, you could copy/paste:

https://elixir.bootlin.com/linux/latest/source/lib/bch.c#L348

which is probably more efficient.

> +static void oa_tc6_prepare_ctrl_buf(struct oa_tc6 *tc6, u32 addr, u32 val[],
> +				    u8 len, bool wnr, u8 *buf, bool ctrl_prot)
> +{
> +	u32 hdr;
> +
> +	/* Prepare the control header with the required details */
> +	hdr = FIELD_PREP(CTRL_HDR_DNC, 0) |
> +	      FIELD_PREP(CTRL_HDR_WNR, wnr) |
> +	      FIELD_PREP(CTRL_HDR_AID, 0) |
> +	      FIELD_PREP(CTRL_HDR_MMS, addr >> 16) |
> +	      FIELD_PREP(CTRL_HDR_ADDR, addr) |
> +	      FIELD_PREP(CTRL_HDR_LEN, len - 1);
> +	hdr |= FIELD_PREP(CTRL_HDR_P, oa_tc6_get_parity(hdr));
> +	*(u32 *)buf = cpu_to_be32(hdr);
> +
> +	if (wnr) {

What does wnr mean? Maybe give it a more meaningful name, unless it is
actually something in the standard. Kerneldoc would also help.

> +static int oa_tc6_check_control(struct oa_tc6 *tc6, u8 *ptx, u8 *prx, u8 len,
> +				bool wnr, bool ctrl_prot)
> +{
> +	/* 1st 4 bytes of rx chunk data can be discarded */
> +	u32 rx_hdr = *(u32 *)&prx[TC6_HDR_SIZE];
> +	u32 tx_hdr = *(u32 *)ptx;
> +	u32 rx_data_complement;
> +	u32 tx_data;
> +	u32 rx_data;
> +	u16 pos1;
> +	u16 pos2;
> +
> +	/* If tx hdr and echoed hdr are not equal then there might be an issue
> +	 * with the connection between SPI host and MAC-PHY. Here this case is
> +	 * considered as MAC-PHY is not connected.

I could understand ENODEV on the first transaction during probe. But
after that -EIO seems more appropriate. I've also seen USB use -EPROTO
to indicate a protocol error, which a corrupt message would be.

> +int oa_tc6_perform_ctrl(struct oa_tc6 *tc6, u32 addr, u32 val[], u8 len,
> +			bool wnr, bool ctrl_prot)
> +{
> +	u8 *tx_buf;
> +	u8 *rx_buf;
> +	u16 size;
> +	u16 pos;
> +	int ret;
> +
> +	if (ctrl_prot)
> +		size = (TC6_HDR_SIZE * 2) + (len * (TC6_HDR_SIZE * 2));
> +	else
> +		size = (TC6_HDR_SIZE * 2) + (len * TC6_HDR_SIZE);

Do you have an idea how big the biggest control message is? Rather
than allocate these buffers for every transaction, maybe allocate
maximum size buffers one at startup and keep them in tc6? That will
reduce overhead and simplify the code.

> +struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
> +{
> +	struct oa_tc6 *tc6;
> +
> +	if (!spi)
> +		return NULL;

This is defensive programming which is generally not liked. You cannot
do anything without an SPI device, so just assume it is passed, and if
not, let is explode later and the driver write will quickly fix there
broken code.

> +
> +	tc6 = kzalloc(sizeof(*tc6), GFP_KERNEL);
> +	if (!tc6)
> +		return NULL;
> +
> +	tc6->spi = spi;
> +
> +	return tc6;
> +}
> +EXPORT_SYMBOL_GPL(oa_tc6_init);
> +
> +void oa_tc6_deinit(struct oa_tc6 *tc6)
> +{
> +	kfree(tc6);
> +}
> +EXPORT_SYMBOL_GPL(oa_tc6_deinit);

Maybe consider a devm_ API to make the MAC driver simpler.

      Andrew

