Return-Path: <netdev+bounces-169295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB56A433A2
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 04:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC128172B48
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 03:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DCA126C10;
	Tue, 25 Feb 2025 03:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Lz5WZOWZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D05367
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 03:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740454487; cv=none; b=mcekyNqfbwXn6KIDfc5gLs76VzWZTt94IfYaQASLmnTfjNgw82536uOkd4Mm2J1JBMVt1qWw+Dk+GmF7+xl1ciB6v7klfT6yqSX+UYi1DgXrIhYyofs+dJ6gwKjlLlhAvsv6H/6h5sADr1uDKDHhtVoWc0DB8w3ZW9Ije6tofZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740454487; c=relaxed/simple;
	bh=n0MPU9u76WNuFC1lbMNQO5d/2rQxWm8o0Yxwgpl063c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LU1dUxYIzhIOJ5gZBs/kpgPjBiiiGUdftfn8n780cwKr8nc3egoIxL1oZ0Zg5INk7nJldw1w+LUJyzAq7NNT5Zu9RJvbgCfov2arpy17jc45TJd+8R7ikd0D+NffOZoZ9sgj8MtLoq8p2iZtgZoRJhsQ6CI6ZupeZCNF36sx4Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Lz5WZOWZ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c0a3d6a6e4so483674285a.1
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 19:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740454485; x=1741059285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjFBxuOiXJIQ9GfmIov4LXWy04rxAtfY7qOfc8aFDww=;
        b=Lz5WZOWZHkRT4qRZ6RJrbdPKIvNJep8GJu4WiYFeNxTy3In0uAnT8KzmH5usNM3/M/
         Ew3ehJLTX5mooCyP9AB2kyGrKkml6tdBHGbh4CmsEQTVVrrrM75SWEwC+rica2DOCnUf
         sOBCGGfBSdvgKr5Irv8DqyGx0GRu+WAeTjfvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740454485; x=1741059285;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EjFBxuOiXJIQ9GfmIov4LXWy04rxAtfY7qOfc8aFDww=;
        b=jHtvIDfaZKNNFjaXDKMYqor8x0u1cT2e4QR1tzg1HQ7SWx/QbPZpgqOMU18q0rydeH
         8Iw4Dg6iq1NFwJc0magzpxPSeYtm5C2qKbWfmAiLvkTtJaZ2EWNLxiXp+hVdYFuiZjxm
         lmgulM5RLxENesAh/rBTXwzJLUU2AsNlRmtNnghl9OQ8llKSK1mngy7PKG2TW3YYQboA
         +wjq2s2WOhuE/HIuAImXyYkeRtbKvmseTZ51AFd+soIA0EBnI/wmmMNUbWCqUKa8OEQ0
         IApo0WN/AjuqrByPb4cJZjJeHW4SXheha/Tq+LSNOE1Z/OH+I/9sGi10Ue3dyMUFHXD6
         SzVg==
X-Gm-Message-State: AOJu0Yzf0mbN5plsX70pqmlrcELfx3au14W8Hx7FuAwPvV5oXgWUzaHK
	gD7RxM+uuLK6frAyyYXeL9FNd1P/VQTck2IXmfWKgeYTCfV3XpElHHQZKjbXaSE=
X-Gm-Gg: ASbGnctBQFBOoGXwayLn56NanqGdSN99oGDa+unLLYCTO70KyPOiEagYP2k47Z8V1OL
	FkIleehgHbolzVmf9j6AVNvV67PkDQ3Otr5bZCBZWcwQHFiGNX2qb3PYiJpX7sjYHOhkzS6KmsK
	6RkiLgd6oWmIT8M6sOBeM+1avWuNZ1eBDrxInTLu/XvVOjxlfXHlzG5lT1tgIzgAsIO6u/QlnxN
	I8cRb/+VcFrBceCvU77jna3YUBq1eavsE0+3Jt15uhKpVl4YaeCKckS5ryUROdW/XQTNbDEHEI8
	GsGl8DpR0OkXpzB+LGa7JsOktEoEJPLl0Gw8jL+ZcXI+dlrxDljj8g6bVQBfwnxy
X-Google-Smtp-Source: AGHT+IFHkbzVnBuItC7VfdXYx1LXxjkLcMBO/fE0/E/a/exzAcVXGwtfB/3cvjO68IYZQw/2sqjkKQ==
X-Received: by 2002:a05:620a:2a0f:b0:7c0:ae97:7fa0 with SMTP id af79cd13be357-7c0cef460c8mr2223585085a.45.1740454485042;
        Mon, 24 Feb 2025 19:34:45 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c329b8esm57045285a.86.2025.02.24.19.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:34:44 -0800 (PST)
Date: Mon, 24 Feb 2025 22:34:40 -0500
From: Joe Damato <jdamato@fastly.com>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, leon@kernel.org, andrew+netdev@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com,
	wanry@yunsilicon.com, horms@kernel.org,
	parthiban.veerasooran@microchip.com, masahiroy@kernel.org
Subject: Re: [PATCH net-next v5 13/14] xsc: Add eth reception data path
Message-ID: <Z706ULnEoemYWdvQ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Xin Tian <tianx@yunsilicon.com>, netdev@vger.kernel.org,
	leon@kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
	jeff.johnson@oss.qualcomm.com, przemyslaw.kitszel@intel.com,
	weihg@yunsilicon.com, wanry@yunsilicon.com, horms@kernel.org,
	parthiban.veerasooran@microchip.com, masahiroy@kernel.org
References: <20250224172416.2455751-1-tianx@yunsilicon.com>
 <20250224172443.2455751-14-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224172443.2455751-14-tianx@yunsilicon.com>

On Tue, Feb 25, 2025 at 01:24:44AM +0800, Xin Tian wrote:
> rx data path:

[...]

> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
> index 72f33bb53..b87105c26 100644
> --- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
> +++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
> @@ -5,44 +5,594 @@

[...]

>  struct sk_buff *xsc_skb_from_cqe_linear(struct xsc_rq *rq,
>  					struct xsc_wqe_frag_info *wi,
>  					u32 cqe_bcnt, u8 has_pph)
>  {
> -	// TBD
> -	return NULL;
> +	int pph_len = has_pph ? XSC_PPH_HEAD_LEN : 0;
> +	u16 rx_headroom = rq->buff.headroom;
> +	struct xsc_dma_info *di = wi->di;
> +	struct sk_buff *skb;
> +	void *va, *data;
> +	u32 frag_size;
> +
> +	va = page_address(di->page) + wi->offset;
> +	data = va + rx_headroom + pph_len;
> +	frag_size = XSC_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
> +
> +	dma_sync_single_range_for_cpu(rq->cq.xdev->device, di->addr, wi->offset,
> +				      frag_size, DMA_FROM_DEVICE);
> +	prefetchw(va); /* xdp_frame data area */
> +	prefetch(data);

net_prefetchw and net_prefetch, possibly?

[...]

>  struct sk_buff *xsc_skb_from_cqe_nonlinear(struct xsc_rq *rq,
>  					   struct xsc_wqe_frag_info *wi,
>  					   u32 cqe_bcnt, u8 has_pph)
>  {
> -	// TBD
> -	return NULL;
> +	struct xsc_rq_frag_info *frag_info = &rq->wqe.info.arr[0];
> +	u16 headlen  = min_t(u32, XSC_RX_MAX_HEAD, cqe_bcnt);
> +	struct xsc_wqe_frag_info *head_wi = wi;
> +	struct xsc_wqe_frag_info *rx_wi = wi;
> +	u16 head_offset = head_wi->offset;
> +	u16 byte_cnt = cqe_bcnt - headlen;
> +	u16 frag_consumed_bytes = 0;
> +	u16 frag_headlen = headlen;
> +	struct net_device *netdev;
> +	struct xsc_channel *c;
> +	struct sk_buff *skb;
> +	struct device *dev;
> +	u8 fragcnt = 0;
> +	int i = 0;
> +
> +	c = rq->cq.channel;
> +	dev = c->adapter->dev;
> +	netdev = c->adapter->netdev;
> +
> +	skb = napi_alloc_skb(rq->cq.napi, ALIGN(XSC_RX_MAX_HEAD, sizeof(long)));
> +	if (unlikely(!skb))
> +		return NULL;
> +
> +	prefetchw(skb->data);

Same as above: net_prefetchw ?

