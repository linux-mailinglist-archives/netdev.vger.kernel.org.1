Return-Path: <netdev+bounces-119080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E444953F7F
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA7E1C21024
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB78E3A1B0;
	Fri, 16 Aug 2024 02:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zte0afA0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274DE46BF;
	Fri, 16 Aug 2024 02:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723775151; cv=none; b=ngrjer0zAcM0cO0VGzBbR1Bs70Bc/X0mwrVo4HK5eICXMeX2H/9upuRMNFVUFpSt3BcxDvgZhS9kjhY3PcGRVCxq/yhJ5AP1u4lcuMKbS84pXHkxLJZb2N3urGqAuWqTrXOrOTJetMZzR8DbK2Xuc6g6AYS8fbRN/Pq4hPHoTMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723775151; c=relaxed/simple;
	bh=P1q9UmMSPCsJGuJgfVnYe7tRhAKHplezoADX9uQvZw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCAtKDS9nZdB0EZPlOj7uUxSYCMGj6LiFB6oCBxx1xp7VhBOT4IukL/SeqLRqcAhI3wumoOmawuK4IIYcqh7FqiikD4XJnyDQ9Q7AO2GG/menHXeEpSZWiHfJJviFAbfI+79srKlCGqh/txBP304yhkL/tvkoqYE2XNKFCNPrmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zte0afA0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yFFM4clhArtjOmMiVfF3lMvOsNQtCbAiTavA3XrtCIQ=; b=zte0afA0nW6k0iXOTgym3m9XQ0
	2vmg6d4RaTnK1sxhIY2v+e1C7UOA98aKCzWzKH4VzUwh/9ihhcSchKF/NdD/gyAAFx7aolP/E0JFX
	ud6xu4f5QsTkX0RHSPGEKZ6YNlGxqggeqbWQMc1rWqatAgxLyBZRv0wK+Cx2PnheFmRQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1semep-004tOO-Ca; Fri, 16 Aug 2024 04:25:39 +0200
Date: Fri, 16 Aug 2024 04:25:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com, jdamato@fastly.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 net-next 03/11] net: hibmcge: Add mdio and
 hardware configuration supported in this module
Message-ID: <79122634-093b-44a3-bbcd-479d6692affc@lunn.ch>
References: <20240813135640.1694993-1-shaojijie@huawei.com>
 <20240813135640.1694993-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813135640.1694993-4-shaojijie@huawei.com>

> +static int hbg_mdio_cmd_send(struct hbg_mac *mac, u32 prt_addr, u32 dev_addr,
> +			     u32 type, u32 op_code)
> +{
> +	struct hbg_mdio_command mdio_cmd;
> +
> +	hbg_mdio_get_command(mac, &mdio_cmd);
> +	mdio_cmd.mdio_st = type;
> +	/* if auto scan enabled, this value need fix to 0 */
> +	mdio_cmd.mdio_start = 0x1;
> +	mdio_cmd.mdio_op = op_code;
> +	mdio_cmd.mdio_prtad = prt_addr;
> +	mdio_cmd.mdio_devad = dev_addr;
> +	hbg_mdio_set_command(mac, &mdio_cmd);
> +
> +	/* wait operation complete and check the result */
> +	return hbg_mdio_check_send_result(mac);

> +struct hbg_mdio_command {
> +	union {
> +		struct {
> +			u32 mdio_devad : 5;
> +			u32 mdio_prtad :5;
> +			u32 mdio_op : 2;
> +			u32 mdio_st : 2;
> +			u32 mdio_start : 1;
> +			u32 mdio_clk_sel : 1;
> +			u32 mdio_auto_scan : 1;
> +			u32 mdio_clk_sel_exp : 1;
> +			u32 rev : 14;
> +		};
> +		u32 bits;
> +	};
> +};

This is generally not the way to do this. Please look at the macros in
include/linux/bitfield.h. FIELD_PREP, GENMASK, BIT, FIELD_GET
etc. These are guaranteed to work for both big and little endian, and
you avoid issues where the compiler decides to add padding in your
bitfields.

	Andrew

