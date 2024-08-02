Return-Path: <netdev+bounces-115337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A32C6945E7A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50EEC1F21E68
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EF6383AB;
	Fri,  2 Aug 2024 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KZQAwj+A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60E9481AA
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722604550; cv=none; b=uvN5inA2Z6xCcw+Koik5/i+n9k0CoJhKhbshs4waas5i3Q1+EcQrcjT5k1FFLvwSk/3pjk81AQ+Jtao5uORyO83g5dlRnP8WpOmv2grlk1o/ykCBukYnsfM4Xtzn50O4nS6eySIUJ9CUSGe+zNfPHnSSvO+KwX6SC7EfubUEhuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722604550; c=relaxed/simple;
	bh=Q3wv+mfHQFHxGdS55u3JpRAz0qUezc4Z3qCUkuG/bwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXgqYQbE1rwARsqN1FaVRtyTiFAceyPBPXua+LicU5c+q/entVIqs+qwwzRHFZWI93oNDKecURwIefyUvLxtpSSlp/L5f8KZhLBiXNFFice2PysCB4UsqLFl252ZPX0CxajB1/ABm3hjVVmXsbFesAK1SySHPkInkcQpjXqjme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KZQAwj+A; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so19259665e9.1
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 06:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722604547; x=1723209347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2MKG1n4OxUJtknoX623DTVqnyIscseKASo2jS8ySgI=;
        b=KZQAwj+A4texnVwsI5pNwHnFlP++pAnTx3OePAryT/+VmH9cGJ3EOL0FveDx1aVeQz
         ku5KlnzQf3+8hK1u/EPu1YKSlWnNzHcT6lnqKKXZDrFEIZtNZNKOKoZBceciIlDdOkWw
         TKQYQaXU13m0ggKI+ikt9mjXbjz0e7P4Pgxtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722604547; x=1723209347;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2MKG1n4OxUJtknoX623DTVqnyIscseKASo2jS8ySgI=;
        b=h9LlX1Qspf3DDvZI22aCQS16VN3QOIcJm/A5CEP3z53MOgTkReSOvvhRAo3jguNROQ
         fOPhi1HMLBiKRVlPK26OsCBL6CbljiD9WLxRrFc2v5VMaVzBgFw1yeH2XHCbRUgag1+/
         Yo346ry5yImMFH4NLT7MJ/6A1eHmADeqXI4GC52gsi6ZYF6XcSi6yA9Rho0yqVX/2FTq
         8NdTa9c5F8iGRpAcn8dE/EuM8bGlFZO3wbVp5FfoBya//x/ipGg3r0mL9xjau3PRl//n
         3i9tZ7B2/hA7/FxqOorTHqriItbhMmvQTqUURnjpFaWnD/ivH4tpfVyLeM+usdILpXwe
         qbkg==
X-Forwarded-Encrypted: i=1; AJvYcCVNqy/QmIjXqVUiswoqQZoMg7sRmg2sW75Xn2ObV/Kuh/C09ukfQoP0wVuaKZHgzPbRR7hW25DtFaIcOidOgxSC7qvXo6TP
X-Gm-Message-State: AOJu0YzEE5zcbX7suFRw6CGDQcV0cJHOn68wtPtb5c6+Z9moKK/itq4i
	qTzS1xTneFup0Di4IKJGpq5b+ziHfj+GMg/WD1zLI297yEudI33UxDT6Cfp21YI=
X-Google-Smtp-Source: AGHT+IGlXu54zmwgHcjl4dUamoGrm6MsIjA684g5kWdvAnLN7bYHnGTvN0LJDKvi1SjiFtxkvSbXHA==
X-Received: by 2002:a05:600c:5110:b0:426:5cc7:82f with SMTP id 5b1f17b1804b1-428e6f8667cmr26133205e9.13.1722604546866;
        Fri, 02 Aug 2024 06:15:46 -0700 (PDT)
Received: from LQ3V64L9R2 ([62.30.8.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e9c9fdsm32905585e9.41.2024.08.02.06.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 06:15:46 -0700 (PDT)
Date: Fri, 2 Aug 2024 14:15:44 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, dxu@dxuuu.xyz, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
	gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 07/12] ethtool: rss: move the device op
 invocation out of rss_prepare_data()
Message-ID: <ZqzcALgIrKAhfs5q@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	dxu@dxuuu.xyz, ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com, gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
References: <20240802001801.565176-1-kuba@kernel.org>
 <20240802001801.565176-8-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802001801.565176-8-kuba@kernel.org>

On Thu, Aug 01, 2024 at 05:17:56PM -0700, Jakub Kicinski wrote:
> Factor calling device ops out of rss_prepare_data().
> Next patch will add alternative path using xarray.
> No functional changes.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/ethtool/rss.c | 43 +++++++++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
> index cd8100d81919..5c477cc36251 100644
> --- a/net/ethtool/rss.c
> +++ b/net/ethtool/rss.c
> @@ -43,13 +43,9 @@ rss_parse_request(struct ethnl_req_info *req_info, struct nlattr **tb,
>  }
>  
>  static int
> -rss_prepare_data(const struct ethnl_req_info *req_base,
> -		 struct ethnl_reply_data *reply_base,
> -		 const struct genl_info *info)
> +rss_prepare_get(const struct rss_req_info *request, struct net_device *dev,
> +		struct rss_reply_data *data, const struct genl_info *info)
>  {
> -	struct rss_reply_data *data = RSS_REPDATA(reply_base);
> -	struct rss_req_info *request = RSS_REQINFO(req_base);
> -	struct net_device *dev = reply_base->dev;
>  	struct ethtool_rxfh_param rxfh = {};
>  	const struct ethtool_ops *ops;
>  	u32 total_size, indir_bytes;
> @@ -57,16 +53,6 @@ rss_prepare_data(const struct ethnl_req_info *req_base,
>  	int ret;
>  
>  	ops = dev->ethtool_ops;
> -	if (!ops->get_rxfh)
> -		return -EOPNOTSUPP;
> -
> -	/* Some drivers don't handle rss_context */
> -	if (request->rss_context) {
> -		if (!ops->cap_rss_ctx_supported && !ops->create_rxfh_context)
> -			return -EOPNOTSUPP;
> -
> -		data->no_key_fields = !ops->rxfh_per_ctx_key;
> -	}
>  
>  	ret = ethnl_ops_begin(dev);
>  	if (ret < 0)
> @@ -109,6 +95,31 @@ rss_prepare_data(const struct ethnl_req_info *req_base,
>  	return ret;
>  }
>  
> +static int
> +rss_prepare_data(const struct ethnl_req_info *req_base,
> +		 struct ethnl_reply_data *reply_base,
> +		 const struct genl_info *info)
> +{
> +	struct rss_reply_data *data = RSS_REPDATA(reply_base);
> +	struct rss_req_info *request = RSS_REQINFO(req_base);
> +	struct net_device *dev = reply_base->dev;
> +	const struct ethtool_ops *ops;
> +
> +	ops = dev->ethtool_ops;
> +	if (!ops->get_rxfh)
> +		return -EOPNOTSUPP;
> +
> +	/* Some drivers don't handle rss_context */
> +	if (request->rss_context) {
> +		if (!ops->cap_rss_ctx_supported && !ops->create_rxfh_context)
> +			return -EOPNOTSUPP;
> +
> +		data->no_key_fields = !ops->rxfh_per_ctx_key;
> +	}
> +
> +	return rss_prepare_get(request, dev, data, info);
> +}
> +
>  static int
>  rss_reply_size(const struct ethnl_req_info *req_base,
>  	       const struct ethnl_reply_data *reply_base)
> -- 
> 2.45.2
> 
> 

Reviewed-by: Joe Damato <jdamato@fastly.com>

