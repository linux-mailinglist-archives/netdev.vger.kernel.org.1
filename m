Return-Path: <netdev+bounces-116016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0901D948C9C
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 12:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3559E1C223D1
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 10:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37331BE22F;
	Tue,  6 Aug 2024 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="r3M817kq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DF91BDAB9
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722938974; cv=none; b=nNy0EP/nfdJx2f84zS6/LYyUdLf/trD8YCDNIr4dTvlp9eR4Y+hleTcyqSEDDnp5eNEui905Z2D+iKZI1mHCIbCE4kS5TAeJUARQhDnNFEmSdV4HbBdSFz5kHSIZ+wikAljj3AEq6wBPyXHBOb1IXY1pOzciJDF7of46DEnBIhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722938974; c=relaxed/simple;
	bh=NNVqekhksHIFyingNLsCyWirDE7OXVrw5s/4rQWlfBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pkpc+mt4GBGCUNcTU3BvZmTSJNRVqkpJ2x6zjtu3Oj78BgT8guUzdUqvayXR94hW8rZKf+gLF1U5S+4Gbo/28k/yntNVJFZtvLYE9TlhQXj0fsOHH7vc1Xr4OOFQ1hUTncZMpgC3XYve2gqKHx5YxBzgpl53hoVwOg3BkyADCWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=r3M817kq; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-368313809a4so3769355f8f.0
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 03:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722938971; x=1723543771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPmv+UtoaFxUR6KHcBAgf4txeNozDfhLAPq/8XXH/6M=;
        b=r3M817kqWcehTIgGZz9E8IYviZ53XXnFPdcLdMlyRiOgivREIxYtYM2roKgViD4ncU
         Takw2acA2vYlbg0b7nEHd0iljXhQMT1lVzz5dEjM5hu6YEATRNdOvJxozX96CAxZdpeB
         UOfyB96MUZzoMUYpDNSVCOGyX+MUUW5FO3yXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722938971; x=1723543771;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oPmv+UtoaFxUR6KHcBAgf4txeNozDfhLAPq/8XXH/6M=;
        b=f8DqfrYSxb3LXaM7Kq4tNYZAfPBCfWpPI7yrMZjoSqZnVzRjBXCDof2X0ExObdMOcy
         o33lnGp4P5SnanDhKuLr9wfCiqVyrtRbwtICxFuyFaIyrv/N6Iwt8XxVW95smTgQcifA
         YI97DB63ndnB+nE7Cqx51LnXJUKaqI+wD4bFD1VHw5z+RpyV/5UCB9Q2GYNvHTe0bgki
         FXrxXth0yl+oOpS+f+CnE31AKvwxFK17q5JZy0WLfBXtZinCf7VehwfvLaIaKVZwWT4h
         bGSKwNQvndqf2ECgSj+lGhVhEW3mIEsP5An2Plm0eWon1NWm32Emi5IT7mLL4HkUsdxU
         Vrqg==
X-Forwarded-Encrypted: i=1; AJvYcCU4OBAV76Zufb3WYD5phlSMwjUMyD1JpY8JMskngFys57qtBOirVIP6ST1E5J056sIuSHFupMfMkBVox6+sr9n+D9FcxD/n
X-Gm-Message-State: AOJu0YzIeOrPvW185XwHqGG8/SDvNaM84joLDm3YW7pYDwrCkh/ge+ZO
	YosB+4PQdHiAUoBAeB0nGpwYNYefpnndOa4aCBb25jfFaGMJ/bGWk5abYj4Dskc=
X-Google-Smtp-Source: AGHT+IFLUKnbjZUaig+nsjJoNwSXw3spy99rW9QLigG9jiDJiQ63O36N6NVYLESiybDlvgyTITjT0g==
X-Received: by 2002:adf:e3c1:0:b0:367:89ae:c204 with SMTP id ffacd0b85a97d-36bb35aa98bmr11475548f8f.12.1722938971101;
        Tue, 06 Aug 2024 03:09:31 -0700 (PDT)
Received: from LQ3V64L9R2.home ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e0357asm176363235e9.12.2024.08.06.03.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 03:09:30 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:09:28 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, dxu@dxuuu.xyz, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
	gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v2 09/12] ethtool: rss: support dumping RSS
 contexts
Message-ID: <ZrH2WFeyZeFfk3K9@LQ3V64L9R2.home>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	dxu@dxuuu.xyz, ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com, gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
References: <20240803042624.970352-1-kuba@kernel.org>
 <20240803042624.970352-10-kuba@kernel.org>
 <Zq5y0DvXQpBdOEeA@LQ3V64L9R2>
 <20240805145933.3ac6ae7a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805145933.3ac6ae7a@kernel.org>

On Mon, Aug 05, 2024 at 02:59:33PM -0700, Jakub Kicinski wrote:
> On Sat, 3 Aug 2024 19:11:28 +0100 Joe Damato wrote:
> > > +struct rss_nl_dump_ctx {
> > > +	unsigned long		ifindex;
> > > +	unsigned long		ctx_idx;
> > > +
> > > +	unsigned int		one_ifindex;  
> > 
> > My apologies: I'm probably just not familiar enough with the code,
> > but I'm having a hard time understanding what the purpose of
> > one_ifindex is.
> > 
> > I read both ethnl_rss_dump_start and ethnl_rss_dumpit, but I'm still
> > not following what this is used for; it'll probably be obvious in
> > retrospect once you explain it, but I suppose my feedback is that a
> > comment or something would be really helpful :)
> 
> Better name would probably help, but can't think of any.
> 
> User can (optionally) pass an ifindex/ifname to the dump, to dump
> contexts only for the specified ifindex. If they do we "preset"
> the ifindex and one_ifindex:
 
> +	if (req_info.dev) {
> +		ctx->one_ifindex = req_info.dev->ifindex;
> +		ctx->ifindex = ctx->one_ifindex;
> +		ethnl_parse_header_dev_put(&req_info);
> +		req_info.dev = NULL;
> +	}
> 
> and then the iteration is stopped after first full pass:
> 
> +	rtnl_lock();
> +	for_each_netdev_dump(net, dev, ctx->ifindex) {
> +		if (ctx->one_ifindex && ctx->one_ifindex != ctx->ifindex)
> +			break;

Ah, OK; that all makes sense. Thanks for the explanation.

> Unfortunately we don't have any best practice for handling filtering 
> in dumps. I find this cleaner than approaches I previously tried, but
> we'll see if it stands the test of time.
> 
> I'll add the following comment:
> 
> 	/* User wants to dump contexts for one ifindex only */

Sounds good. If you like, you can also add:

Reviewed-by: Joe Damato <jdamato@fastly.com>

