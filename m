Return-Path: <netdev+bounces-85363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1920589A6BD
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 23:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C561C2142D
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 21:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE6C178CFD;
	Fri,  5 Apr 2024 21:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E3KKnycv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFF01791F1
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 21:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353910; cv=none; b=afvVujhLpDoUQOoCL645LItzITxOIRPw0edB9/zWPxucYHSecvrozQxGD+GBycgog+94nOOQqErAfvhx9r5yrF/IH51psUNNSmeP3ebmjaBeiHo54AeEfveHXUAQHWt1ypOqsUnOXuXTeJ4saF01b4bnug38HS4vQXG5PX8EKqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353910; c=relaxed/simple;
	bh=Yg2sDjRUvrWz06cX4cnmQbTralx8eSPasqEwfIND8A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nz4tSTuHAbD7N2rHBxBIscRCTOHcf7jtBDpc6EWeDT82Q47hm1M6j/6LQcf4VfSbbR3/iGh1u/mWRqxrhEQmR3fQEUSUc0e5AmBbMPdg+250baG7L9BjgWA0gNd6OnMVZAJ3xUJZEFRy5I4WVIJVb6QJeSgMHdSZen6l3XjhUJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=E3KKnycv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7WKZJqZJYBvNKWiAHVAdj3lxIKfu98oxQMlSdToNKuw=; b=E3KKnycvD2J8Osn99KZINzsT/F
	ivudIDThfZgWfwRpf25M9lWxwMQeD7wmHPGJSd47P0Ps4uF+SXkkhdR9zQY0QD1MYGi8ZG9XmBFEg
	gvusUctnM8O4BOzD0UC9HCaBWhUzaPVtaQs+x7I2HpahPdxpckZKMt5qHscvcC3sGD84=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rsrTK-00CLA9-OE; Fri, 05 Apr 2024 23:51:42 +0200
Date: Fri, 5 Apr 2024 23:51:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 11/15] eth: fbnic: Enable Ethernet link setup
Message-ID: <cb2519c4-0514-4237-94f8-6707263806a1@lunn.ch>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217495098.1598374.12824051034972793514.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171217495098.1598374.12824051034972793514.stgit@ahduyck-xeon-server.home.arpa>

> +#define FBNIC_CSR_START_PCS		0x10000 /* CSR section delimiter */
> +#define FBNIC_PCS_CONTROL1_0		0x10000		/* 0x40000 */
> +#define FBNIC_PCS_CONTROL1_RESET		CSR_BIT(15)
> +#define FBNIC_PCS_CONTROL1_LOOPBACK		CSR_BIT(14)
> +#define FBNIC_PCS_CONTROL1_SPEED_SELECT_ALWAYS	CSR_BIT(13)
> +#define FBNIC_PCS_CONTROL1_SPEED_ALWAYS		CSR_BIT(6)

This appears to be PCS control register 1, define in 45.2.3.1. Since
this is a standard register, please add it to mdio.h.

> +#define FBNIC_PCS_VENDOR_VL_INTVL_0	0x10202		/* 0x40808 */

Could you explain how these registers map to 802.3 clause 45? Would
that be 3.1002? That would however put it in the reserved range 3.812
through 3.1799. The vendor range is 3.32768 through 3.65535. 

> +#define FBNIC_PCS_VL0_0_CHAN_0		0x10208		/* 0x40820 */
> +#define FBNIC_PCS_VL0_1_CHAN_0		0x10209		/* 0x40824 */
> +#define FBNIC_PCS_VL1_0_CHAN_0		0x1020a		/* 0x40828 */
> +#define FBNIC_PCS_VL1_1_CHAN_0		0x1020b		/* 0x4082c */
> +#define FBNIC_PCS_VL2_0_CHAN_0		0x1020c		/* 0x40830 */
> +#define FBNIC_PCS_VL2_1_CHAN_0		0x1020d		/* 0x40834 */
> +#define FBNIC_PCS_VL3_0_CHAN_0		0x1020e		/* 0x40838 */
> +#define FBNIC_PCS_VL3_1_CHAN_0		0x1020f		/* 0x4083c */
> +#define FBNIC_PCS_MODE_VL_CHAN_0	0x10210		/* 0x40840 */
> +#define FBNIC_PCS_MODE_HI_BER25			CSR_BIT(2)
> +#define FBNIC_PCS_MODE_DISABLE_MLD		CSR_BIT(1)
> +#define FBNIC_PCS_MODE_ENA_CLAUSE49		CSR_BIT(0)
> +#define FBNIC_PCS_CONTROL1_1		0x10400		/* 0x41000 */
> +#define FBNIC_PCS_VENDOR_VL_INTVL_1	0x10602		/* 0x41808 */
> +#define FBNIC_PCS_VL0_0_CHAN_1		0x10608		/* 0x41820 */
> +#define FBNIC_PCS_VL0_1_CHAN_1		0x10609		/* 0x41824 */
> +#define FBNIC_PCS_VL1_0_CHAN_1		0x1060a		/* 0x41828 */
> +#define FBNIC_PCS_VL1_1_CHAN_1		0x1060b		/* 0x4182c */
> +#define FBNIC_PCS_VL2_0_CHAN_1		0x1060c		/* 0x41830 */
> +#define FBNIC_PCS_VL2_1_CHAN_1		0x1060d		/* 0x41834 */
> +#define FBNIC_PCS_VL3_0_CHAN_1		0x1060e		/* 0x41838 */
> +#define FBNIC_PCS_VL3_1_CHAN_1		0x1060f		/* 0x4183c */
> +#define FBNIC_PCS_MODE_VL_CHAN_1	0x10610		/* 0x41840 */
> +#define FBNIC_CSR_END_PCS		0x10668 /* CSR section delimiter */
> +
> +#define FBNIC_CSR_START_RSFEC		0x10800 /* CSR section delimiter */
> +#define FBNIC_RSFEC_CONTROL(n)\
> +				(0x10800 + 8 * (n))	/* 0x42000 + 32*n */
> +#define FBNIC_RSFEC_CONTROL_AM16_COPY_DIS	CSR_BIT(3)
> +#define FBNIC_RSFEC_CONTROL_KP_ENABLE		CSR_BIT(8)
> +#define FBNIC_RSFEC_CONTROL_TC_PAD_ALTER	CSR_BIT(10)
> +#define FBNIC_RSFEC_MAX_LANES			4
> +#define FBNIC_RSFEC_CCW_LO(n) \
> +				(0x10802 + 8 * (n))	/* 0x42008 + 32*n */
> +#define FBNIC_RSFEC_CCW_HI(n) \
> +				(0x10803 + 8 * (n))	/* 0x4200c + 32*n */

Is this Corrected Code Words Lower/Upper? 1.202 and 1.203?

> +#define FBNIC_RSFEC_NCCW_LO(n) \
> +				(0x10804 + 8 * (n))	/* 0x42010 + 32*n */
> +#define FBNIC_RSFEC_NCCW_HI(n) \
> +				(0x10805 + 8 * (n))	/* 0x42014 + 32*n */

Which suggests this is Uncorrected code Words? 1.204, 1.205? I guess
the N is for Not?

> +#define FBNIC_RSFEC_SYMBLERR_LO(n) \
> +				(0x10880 + 8 * (n))	/* 0x42200 + 32*n */
> +#define FBNIC_RSFEC_SYMBLERR_HI(n) \
> +				(0x10881 + 8 * (n))	/* 0x42204 + 32*n */

And these are symbol count errors, 1.210 and 1.211?

If there are other registers which follow 802.3 it would be good to
add them to mdio.h, so others can share them.

    Andrew

