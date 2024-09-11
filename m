Return-Path: <netdev+bounces-127473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DF9975863
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1163CB2B2D1
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CF51AE86E;
	Wed, 11 Sep 2024 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hjtVOQv+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60A41AC440
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071927; cv=none; b=Q2+w2yqIzLXbghdH8dz3bce7g/z0hmrZXUhL3dXWrHVxM49wAu6Zx8ViR0GAksbHm7j7HN7jtcaNfdhvE1hVMEoK8Wdalfek6z/qnb+wvO/iGDPLDA0NBOjRvwROT9Nf4T7QSM8PNMKowxPEERhB/LutItrDHwA0IhYP/Z8lIY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071927; c=relaxed/simple;
	bh=ED39QgUo07vQv1Zc2jpIcvmXn1vPCfIGqfcC+N2zvDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVWTu/PSXAGFDZ4Cjurkuk5OX75D37QZuYKQ61Nrkry+cretOsWQUi/Vy5pBLQwvMpG2vaJY6DmXEH97sGy4WW4CMBh+GDce46zolQnpe5qGDY8ah5Wl38UWb9uNjpEB8cfCyiDpohI6sX6ezGoXQ/PocDxcpXwvY1SiS2FAueI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hjtVOQv+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Lb2TkYLVjnRkWLLVzGs5OFfOtLMr1WZEP7Rvo/ME51M=; b=hjtVOQv+U7UTcEMSroT5kZ6Nn3
	yadrshEw+C9qkfzs875m8rrehIxcbrOTfoOhbeCwrpdeWvDXDUkznz7SWZxKkUHM7CNIUGCb4ha1S
	DgrB7+RBZLpb3CGHi7hO7CtjX+nLmBq75ugMeklhwldejTabz0fuoRrWMet3vHp0dNFQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1soQ9X-007EPC-EO; Wed, 11 Sep 2024 18:25:11 +0200
Date: Wed, 11 Sep 2024 18:25:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexander Duyck <alexanderduyck@fb.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] eth: fbnic: add initial PHC support
Message-ID: <006042c0-e1d5-4fbc-aa7f-94a74cfbef0e@lunn.ch>
References: <20240911124513.2691688-1-vadfed@meta.com>
 <20240911124513.2691688-3-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911124513.2691688-3-vadfed@meta.com>

It appears that Richard has not been Cc:ed.

> +/* Precision Time Protocol Registers */
> +#define FBNIC_CSR_START_PTP		0x04800 /* CSR section delimiter */
> +#define FBNIC_PTP_REG_BASE		0x04800		/* 0x12000 */
> +
> +#define FBNIC_PTP_CTRL			0x04800		/* 0x12000 */
> +#define FBNIC_PTP_CTRL_EN			CSR_BIT(0)
> +#define FBNIC_PTP_CTRL_MONO_EN			CSR_BIT(4)
> +#define FBNIC_PTP_CTRL_TQS_OUT_EN		CSR_BIT(8)
> +#define FBNIC_PTP_CTRL_MAC_OUT_IVAL		CSR_GENMASK(16, 12)
> +#define FBNIC_PTP_CTRL_TICK_IVAL		CSR_GENMASK(23, 20)
> +
> +#define FBNIC_PTP_ADJUST		0x04801		/* 0x12004 */
> +#define FBNIC_PTP_ADJUST_INIT			CSR_BIT(0)
> +#define FBNIC_PTP_ADJUST_SUB_NUDGE		CSR_BIT(8)
> +#define FBNIC_PTP_ADJUST_ADD_NUDGE		CSR_BIT(16)
> +#define FBNIC_PTP_ADJUST_ADDEND_SET		CSR_BIT(24)
> +
> +#define FBNIC_PTP_INIT_HI		0x04802		/* 0x12008 */
> +#define FBNIC_PTP_INIT_LO		0x04803		/* 0x1200c */
> +
> +#define FBNIC_PTP_NUDGE_NS		0x04804		/* 0x12010 */
> +#define FBNIC_PTP_NUDGE_SUBNS		0x04805		/* 0x12014 */
> +
> +#define FBNIC_PTP_ADD_VAL_NS		0x04806		/* 0x12018 */
> +#define FBNIC_PTP_ADD_VAL_NS_MASK		CSR_GENMASK(15, 0)
> +#define FBNIC_PTP_ADD_VAL_SUBNS		0x04807	/* 0x1201c */
> +
> +#define FBNIC_PTP_CTR_VAL_HI		0x04808		/* 0x12020 */
> +#define FBNIC_PTP_CTR_VAL_LO		0x04809		/* 0x12024 */
> +
> +#define FBNIC_PTP_MONO_PTP_CTR_HI	0x0480a		/* 0x12028 */
> +#define FBNIC_PTP_MONO_PTP_CTR_LO	0x0480b		/* 0x1202c */
> +
> +#define FBNIC_PTP_CDC_FIFO_STATUS	0x0480c		/* 0x12030 */
> +#define FBNIC_PTP_SPARE			0x0480d		/* 0x12034 */
> +#define FBNIC_CSR_END_PTP		0x0480d /* CSR section delimiter */

We know the PCS is a licensed block. Is this also licensed? Should it
be placed in driver/ptp so others who licence the same block can
re-uses it?

> +/* FBNIC timing & PTP implementation
> + * Datapath uses truncated 40b timestamps for scheduling and event reporting.
> + * We need to promote those to full 64b, hence we periodically cache the top
> + * 32bit of the HW time counter. Since this makes our time reporting non-atomic
> + * we leave the HW clock free running and adjust time offsets in SW as needed.
> + * Time offset is 64bit - we need a seq counter for 32bit machines.
> + * Time offset and the cache of top bits are independent so we don't need
> + * a coherent snapshot of both - READ_ONCE()/WRITE_ONCE() + writer side lock
> + * are enough.
> + *
> + * TBD: alias u64_stats_sync & co. with some more appropriate names upstream.

This is upstream, so maybe now is a good time to decide?

	Andrew

