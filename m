Return-Path: <netdev+bounces-167417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B938A3A2DE
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC4E1616D4
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 16:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2B426E64D;
	Tue, 18 Feb 2025 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNas68Un"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CB526E64C
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896287; cv=none; b=PsoYL8HVh6vHszJb43a6rqQboUHlyvxJhgYpXzTUpqYGfhKKpVRTHDs7s6pemEwiuoJVbhheuqrzuubIlXFc27NWGCmLQs0HN9qSiInalrKcsEpGTFUko/4zMqwJYiAQ7rzR7ZK1sWCUM+PUhsA2pZau2x1s6Yc5Kq57nbYFzh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896287; c=relaxed/simple;
	bh=mYUtiepNz9uCSii7hCfDznFwXbDbWxVFOYLTpzNykkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifF/74rGoa2s942LmebwC+itKwJnxKb6sE3WpYRSYX6t7R0wy/EOWM9XWUI9sKkdvcKt2r0perjeCf7AbPSogXnkts232vPSJ/xyCnqK2wj288VjH7lxxVrn+Y6/BgWRBrlsXGj3bwTaotlMKk16T0XBK6918AgSUKSb5tLyTpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNas68Un; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B9DC4CEE7;
	Tue, 18 Feb 2025 16:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739896287;
	bh=mYUtiepNz9uCSii7hCfDznFwXbDbWxVFOYLTpzNykkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mNas68Unrc3FaJeQ03gBMFJJqStdjS/AUSnqCt4wy0V6BYuvhVvDSr0qvCO2Il4Rf
	 PRhW7dE4f0ciyNsk7MsEs9CS4ul5yVASOMUknKoOz+vU9PcmkCUkBQyd+8odVPBl42
	 /Cf84KU8ox71aOySGwPVNBF91tyDufFBi4bOLpOdP1ZVvuoVUyKxH2+3xj+3sw+xpU
	 EG+xcvAZPZOGznLUjLjoCd+J+Wf1p4Wez5zjiZL+usBucdLX4KMowA54PBtKTWi+WW
	 0UPEFd8OGamBM2sGi8bN1t2fwjNSSUhY+85Mn5zPVwM1tcycMqJplThy6Ct2kkjLmw
	 GeCJOldurwHaw==
Date: Tue, 18 Feb 2025 16:31:22 +0000
From: Simon Horman <horms@kernel.org>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, leon@kernel.org, andrew+netdev@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com,
	wanry@yunsilicon.com, parthiban.veerasooran@microchip.com,
	masahiroy@kernel.org
Subject: Re: [PATCH v4 04/14] net-next/yunsilicon: Add qp and cq management
Message-ID: <20250218163122.GA1615191@kernel.org>
References: <20250213091402.2067626-1-tianx@yunsilicon.com>
 <20250213091410.2067626-5-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213091410.2067626-5-tianx@yunsilicon.com>

On Thu, Feb 13, 2025 at 05:14:11PM +0800, Xin Tian wrote:
> Add qp(queue pair) and cq(completion queue) resource management APIs
> 
> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Xin Tian <tianx@yunsilicon.com>

Some general remark regarding this patchset:

1. "xsc" is probably a more appropriate prefix than "net-next/yunsilicon"
   in the patch subjects: it seems to be the name of the driver, and
   conveniently is nice and short.

2. Please provide more descriptive patch descriptions, ideally
   explaining why changes are being made. As this is a new driver
   I think it is appropriate for the "why" to to describe how
   the patches fill-out the driver, leading to something users
   can use.

...

> diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> index 4c8b26660..4e19b0989 100644
> --- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> +++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> @@ -29,6 +29,14 @@
>  
>  #define XSC_REG_ADDR(dev, offset)	\
>  	(((dev)->bar) + ((offset) - 0xA0000000))
> +#define XSC_SET_FIELD(value, field)	\
> +	(((value) << field ## _SHIFT) & field ## _MASK)
> +#define XSC_GET_FIELD(word, field)	\
> +	(((word)  & field ## _MASK) >> field ## _SHIFT)

I did not try, but I expect that if you express XSC_SET_FIELD() and
XSC_GET_FIELD() in terms of FIELD_PREP() and FIELD_GET() then the _SHIFT
part disappears. And, ideally, the corresponding _SHIFT defines don't need
to be defined.

> +
> +enum {
> +	XSC_MAX_EQ_NAME	= 20
> +};
>  
>  enum {
>  	XSC_MAX_PORTS	= 2,
> @@ -44,6 +52,147 @@ enum {
>  	XSC_MAX_UUARS		= XSC_MAX_UAR_PAGES * XSC_BF_REGS_PER_PAGE,
>  };
>  
> +// alloc
> +struct xsc_buf_list {
> +	void		       *buf;
> +	dma_addr_t		map;
> +};
> +
> +struct xsc_buf {
> +	struct xsc_buf_list	direct;
> +	struct xsc_buf_list	*page_list;
> +	int			nbufs;
> +	int			npages;
> +	int			page_shift;
> +	int			size;

Looking over the way the fields are used in this patchset
I think that unsigned long would be slightly better types
for nbufs, npages, and size.

And more generally, I think it would be nice to use unsigned
types throughout this patchset for, in structure members, function
parameters, and local variables, to hold unsigned values.

And likewise to use unsigned long (instead of unsigned int) as
appropriate, e.g. the size parameter of xsc_buf_alloc() which
is passed to get_order() in a subsequent patch in this series.

> +};
> +
> +struct xsc_frag_buf {
> +	struct xsc_buf_list	*frags;
> +	int			npages;
> +	int			size;
> +	u8			page_shift;
> +};
> +
> +struct xsc_frag_buf_ctrl {
> +	struct xsc_buf_list	*frags;
> +	u32			sz_m1;
> +	u16			frag_sz_m1;
> +	u16			strides_offset;
> +	u8			log_sz;
> +	u8			log_stride;
> +	u8			log_frag_strides;
> +};

...

