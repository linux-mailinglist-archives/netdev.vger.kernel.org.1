Return-Path: <netdev+bounces-215394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A183AB2E64F
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 22:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F1B77BDEF6
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 20:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDB728BA83;
	Wed, 20 Aug 2025 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AT3RgR2/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963152882CA;
	Wed, 20 Aug 2025 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755720994; cv=none; b=DBnIuILDm/Nd4fF8IcFXi5jSsRipOtrpDuPsXdvIO3y4ANqoiZfTKLcgK4A9ltQxPd+2taRatem4XcD7LSUXYBgYpXxTmHBszQ+6a2o6fmL1HLc5ILgIl876A0Ss42A6jt87ccpctCeM1aRzjGQR13Dx2jD1qTMqtD64/nVHeX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755720994; c=relaxed/simple;
	bh=7zth8kAbFMEoz32wrEURI30p5Z6zJG+YFWP7RtjpKHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFY36FsVuEYKlc71V/O2fZossZ51zoNzosM4SrN8+ox/BIJJ1h3R+iyn5z7l4xwXWOMgLkN2guSWavOcnn4rWY4Z6eLMYDz2ZTqGLncjiu+V7eOGI1iOpQNDJZvE+dLd48GhNSf4hQzF1L2U8gg/1dmqlcd+GtIZxgzvNTbRU7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AT3RgR2/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=//kxUFFjvIMW5R+oAjBGXzOVw087AEN8mIOrAdnq0jg=; b=AT3RgR2/xemypZGxr0R2XyU6CS
	KNxVzu+1+O6zck64qsBMn4wU4tVuKQl1p8plmcDd/UUXptsMcRFT0GsOzy8l0wCMT/JOPPXAW6TKt
	4bu3pc6CFEc0Jm+Yj61SXp1CqdLoNmStu8+pvc1tsNmo2kq/e1/p33HTlxTIq2+QaVZk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uopE0-005MYO-P1; Wed, 20 Aug 2025 22:16:00 +0200
Date: Wed, 20 Aug 2025 22:16:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] net: rnpgbe: Add n500/n210 chip support
Message-ID: <3e5e73f7-bbf5-490c-9cff-24f34d550d24@lunn.ch>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-3-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818112856.1446278-3-dong100@mucse.com>

> +const struct rnpgbe_info rnpgbe_n500_info = {
> +	.total_queue_pair_cnts = RNPGBE_MAX_QUEUES,
> +	.hw_type = rnpgbe_hw_n500,
> +	.init = &rnpgbe_init_n500,
> +};
> +
> +const struct rnpgbe_info rnpgbe_n210_info = {
> +	.total_queue_pair_cnts = RNPGBE_MAX_QUEUES,
> +	.hw_type = rnpgbe_hw_n210,
> +	.init = &rnpgbe_init_n210,
> +};
> +
> +const struct rnpgbe_info rnpgbe_n210L_info = {
> +	.total_queue_pair_cnts = RNPGBE_MAX_QUEUES,
> +	.hw_type = rnpgbe_hw_n210L,
> +	.init = &rnpgbe_init_n210,
> +};

total_queue_pair_cnts is the same for all three. So it probably does
not need to be in the structure. You can just use RNPGBE_MAX_QUEUES.

    Andrew

---
pw-bot: cr

