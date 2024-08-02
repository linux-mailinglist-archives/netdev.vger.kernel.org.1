Return-Path: <netdev+bounces-115323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383D9945D4E
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8AC1C21503
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5AF1DE86B;
	Fri,  2 Aug 2024 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="xTrP7X6s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D66914D458
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722598538; cv=none; b=Jyy4kqvkI7gSQRsU+VOxodD/aBCp/5uI7xztK231U6nU4qAe0gIDkDkQCKR2PT8jM3WUIIiVEAQvhv+z510ePQrYXTn2Hi1xZs9z0XAFkP5nfQiA5p036orCnNTEt4hoByz8+ipxtKXn1BcwOYRMXOg9po0Cz7+Hr/VAjgcB81w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722598538; c=relaxed/simple;
	bh=3vB3nk/xLdJT3qD3MLhBav36yWQazQB+37w8ZcMKD14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGpCXCV62nj0uSDy2Kxyvp8SKaGAekpmptFZMeZdOFB23YsCWdwAHqvX+1d7H62UVBlIN2YPD1vCfngV2znL1vBO3GBFm/iZ7aJAEtmB+f5CDqKuqLBfDlj0DFa1lbIiyqaHYECLNfkwmHcy7YpAmzxP9uSKbGNLmC1fmTjdDHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=xTrP7X6s; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428119da952so51632345e9.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 04:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722598535; x=1723203335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ko6FolWkHKGVjcxwwTg4TR4rujnnljCEeh/jWY51qUU=;
        b=xTrP7X6snANlq6Pdo5/5FprL1ggpcguSUSFgWkKOnSXBccIB4ne2C664jxblvJ27xr
         3AIomYEfVKhlrMx/JVvyBqseJXArW9/ddn4Su2KrmDfeNlZVO1ihF7SEzk8mPUIhtrOJ
         NHbyMlFp5jYV9Gr7jIuRVE88kawbgL5d46flw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722598535; x=1723203335;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ko6FolWkHKGVjcxwwTg4TR4rujnnljCEeh/jWY51qUU=;
        b=wxsuer7iNqdfIRTYXwM/Bxrov3LOPvtdgfBJCownFJ5JIgDncQdpjqVCyNnC2wPL8I
         wXFFwvfA47cvXI4vwNAcWlx501FU8C3dvnv1cZuns5DFvFTiIuRVqvkt7mBYw9ufJMXD
         WotPcuku8cYKu8ryLJH6LpMf4SnGgO88NeqGdy9wnU0Pnba7P8WSHip/ulFdm3YrRmAh
         rHNU4MYd8Pjiay5majAlnI5CqweAoW/oBycF10qkc3cFVB+fTF5EQ+kGXbUpihcVjyaD
         /CTFV3j2Yt0cuQZOlOtqh4CFIsu+5TYm7OyMkyiRqg8lpOOjNtyuTmilxK5VYq0xXmU6
         va3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWc1VG8xeugt12KXkHt0LISFQn2tnan1EdKOY8zPL5Wf6F2Amvg5uFwBZCDcTm7ZLuNSx1zeE7vNx1ZXpAdfNLMM03Yh2ng
X-Gm-Message-State: AOJu0YwOI3CY8ZQRuTnX3L0Dwe6CVk6YzgfSrr2SUPIsGep8tQZ9oBKB
	iNbLrmO3wU/tc3GHKKbv7FRYW3thVrlrw62HUqOD1b24pKLUvMvJ8jk1n/Vac+w=
X-Google-Smtp-Source: AGHT+IHR9bpZK7s72w51g7W9U27+zl8KwCzJg0ymhtqQlDsokMFDemnm7GhPddoArWZSrq5vDioAvw==
X-Received: by 2002:a05:600c:3585:b0:426:6945:75b8 with SMTP id 5b1f17b1804b1-428e6b93fcbmr20275425e9.31.1722598534553;
        Fri, 02 Aug 2024 04:35:34 -0700 (PDT)
Received: from LQ3V64L9R2 ([62.30.8.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e7d57asm29680325e9.33.2024.08.02.04.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 04:35:34 -0700 (PDT)
Date: Fri, 2 Aug 2024 12:35:32 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, dxu@dxuuu.xyz, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
	gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 04/12] ethtool: make
 ethtool_ops::cap_rss_ctx_supported optional
Message-ID: <ZqzEhKU0VcIb37bJ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	dxu@dxuuu.xyz, ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com, gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
References: <20240802001801.565176-1-kuba@kernel.org>
 <20240802001801.565176-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802001801.565176-5-kuba@kernel.org>

On Thu, Aug 01, 2024 at 05:17:53PM -0700, Jakub Kicinski wrote:
> cap_rss_ctx_supported was created because the API for creating
> and configuring additional contexts is mux'ed with the normal
> RSS API. Presence of ops does not imply driver can actually
> support rss_context != 0 (in fact drivers mostly ignore that
> field). cap_rss_ctx_supported lets core check that the driver
> is context-aware before calling it.
> 
> Now that we have .create_rxfh_context, there is no such
> ambiguity. We can depend on presence of the op.
> Make setting the bit optional.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/linux/ethtool.h | 3 ++-
>  net/ethtool/ioctl.c     | 6 ++++--
>  net/ethtool/rss.c       | 3 ++-
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 303fda54ef17..55c9f613ab64 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -727,7 +727,8 @@ struct kernel_ethtool_ts_info {
>   * @cap_link_lanes_supported: indicates if the driver supports lanes
>   *	parameter.
>   * @cap_rss_ctx_supported: indicates if the driver supports RSS
> - *	contexts.
> + *	contexts via legacy API, drivers implementing @create_rxfh_context
> + *	do not have to set this bit.
>   * @cap_rss_sym_xor_supported: indicates if the driver supports symmetric-xor
>   *	RSS.
>   * @rxfh_indir_space: max size of RSS indirection tables, if indirection table
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 8ca13208d240..52dfb07393a6 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1227,7 +1227,8 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
>  	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd32)
>  		return -EINVAL;
>  	/* Most drivers don't handle rss_context, check it's 0 as well */
> -	if (rxfh.rss_context && !ops->cap_rss_ctx_supported)
> +	if (rxfh.rss_context && !(ops->cap_rss_ctx_supported ||
> +				  ops->create_rxfh_context))
>  		return -EOPNOTSUPP;
>  
>  	rxfh.indir_size = rxfh_dev.indir_size;
> @@ -1357,7 +1358,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd32)
>  		return -EINVAL;
>  	/* Most drivers don't handle rss_context, check it's 0 as well */
> -	if (rxfh.rss_context && !ops->cap_rss_ctx_supported)
> +	if (rxfh.rss_context && !(ops->cap_rss_ctx_supported ||
> +				  ops->create_rxfh_context))
>  		return -EOPNOTSUPP;
>  	/* Check input data transformation capabilities */
>  	if (rxfh.input_xfrm && rxfh.input_xfrm != RXH_XFRM_SYM_XOR &&
> diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
> index 5c4c4505ab9a..a06bdac8b8a2 100644
> --- a/net/ethtool/rss.c
> +++ b/net/ethtool/rss.c
> @@ -60,7 +60,8 @@ rss_prepare_data(const struct ethnl_req_info *req_base,
>  		return -EOPNOTSUPP;
>  
>  	/* Some drivers don't handle rss_context */
> -	if (request->rss_context && !ops->cap_rss_ctx_supported)
> +	if (request->rss_context && !(ops->cap_rss_ctx_supported ||
> +				      ops->create_rxfh_context))
>  		return -EOPNOTSUPP;
>  
>  	ret = ethnl_ops_begin(dev);
> -- 
> 2.45.2

Reviewed-by: Joe Damato <jdamato@fastly.com>

