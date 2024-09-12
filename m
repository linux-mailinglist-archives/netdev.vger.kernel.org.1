Return-Path: <netdev+bounces-127780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEBF9766BF
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 12:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80658B22F04
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 10:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CB119F132;
	Thu, 12 Sep 2024 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="W8R2gx12"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25FB187552
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726137524; cv=none; b=SZaVpX8BVh8zSz5F5n87xoRQNwNGEIfAP6jQcT6SdrqjhI7rRpXuZpTxG+StLhlwx9PYqMyy7DM4o6Lf1VWOcYrxe4BHWnenJsrsnCWtyIQEMzlDIgLqEF0HISpm7FERVOenaidmj15ue7vkg+WNjCdwyGu+2pejjKtMs7WYjoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726137524; c=relaxed/simple;
	bh=hyIJKDKyBGQJ8sBYqdzAAXREso4kqHXOHUWOOvf4Bco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejfSvc9EuAO0lGWNadrwIfgIBY+i4QQsv+4zfWuNlZD5aM2DgByxbFeBN2AxfLmvdeL7xblMC5gutnB3hwMZr8rcJJTh8nbtZA4BP5j2/kj6AD0atdYv3Ij6m88gXALhQvAEr4+eJT6WP2b/MCOs3BAju1F1BdWqn6FfdKdAICI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=W8R2gx12; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso101868266b.3
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 03:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726137521; x=1726742321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moGGULLUEV1Y3cbTy14suA2JI+5i9gExySNmdaD1asM=;
        b=W8R2gx12w11JLo95zguNhh+EG3zcN5GNMkP6gC3ms4qif4mW5qxcUu9MAvTF5+4ojI
         0pGJRnnPSD3PT/rNA0CdwaiVZgCcSqw90H6DuU1E6Cu3tiseDPXm226rLq169cU6+EpD
         1DDuN9SGFFeTVCL6Q9/67Qd7VtgW0Vl+1CA7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726137521; x=1726742321;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=moGGULLUEV1Y3cbTy14suA2JI+5i9gExySNmdaD1asM=;
        b=FwMdksi/27IF5/vGTjJstk5zu8xPaUVzwMCrgPGPEBkWW4TTtOVUmXb1bOQGswLSzq
         kFRkCJjA7aeY0vFA8okih7nIfZo7UwFY6ZmaAW0dZn/7NR8ilQHve1rTc7u5A/0GuUG4
         t5HknCxgrkezOC1P/humvsg+RwIqXJuptHXXiOe582cZTa41+DOSojuZdDaCCLfc3epE
         DDsCQHaYACd2ul0aXzC3NSDjXeMPyML0+AJ/L9etZ4bFvgEEhj/RUSRThuxrKeQ+sQX5
         zY3xfhsqmX2yk2yWXxYXsHXALsYz0ClQI4gdO618GY+4pTW3mFmCDuNicgwYslFp0Gyf
         epHg==
X-Gm-Message-State: AOJu0YyY/Hc1CcjUc8Rben1w1aMXEbfig9br5AWDXWxOhIfFoerNZY94
	2mfvE7H2i4HGVSP3lJypIiaW+ECyIbe0sJkB/tT/xVFMqiCcWTXm8xHLX3/UDRIHD0g+jeyrakH
	mcEqy3awNSSM8jerEnYWAETJ7XAbX+B6YWE9tTrt2qWayFyBGIxUJMoiKureqVSjob6GaOJkkGr
	mnWTxhS9ZqDthqjos5HXb36HplerUUGdeBP1HFu4ak
X-Google-Smtp-Source: AGHT+IFL1gOJsvSHttMZpKvuRPTGnIa2GRXgNK6xpjEjpN3OaswAhWjMaZZsXSr2f6Esrt8faKfOfg==
X-Received: by 2002:a17:906:bc22:b0:a8a:9054:8399 with SMTP id a640c23a62f3a-a902949aca6mr232677766b.27.1726137520104;
        Thu, 12 Sep 2024 03:38:40 -0700 (PDT)
Received: from LQ3V64L9R2.homenet.telecomitalia.it (host-79-23-194-51.retail.telecomitalia.it. [79.23.194.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c6126esm724495566b.120.2024.09.12.03.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 03:38:39 -0700 (PDT)
Date: Thu, 12 Sep 2024 12:38:37 +0200
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca, kuba@kernel.org, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v3 6/9] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <ZuLErUy3j6KpswM-@LQ3V64L9R2.homenet.telecomitalia.it>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, kuba@kernel.org, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240912100738.16567-1-jdamato@fastly.com>
 <20240912100738.16567-7-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912100738.16567-7-jdamato@fastly.com>

On Thu, Sep 12, 2024 at 10:07:14AM +0000, Joe Damato wrote:
> Add support to set per-NAPI defer_hard_irqs and gro_flush_timeout.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  Documentation/netlink/specs/netdev.yaml | 11 ++++++
>  include/uapi/linux/netdev.h             |  1 +
>  net/core/netdev-genl-gen.c              | 14 ++++++++
>  net/core/netdev-genl-gen.h              |  1 +
>  net/core/netdev-genl.c                  | 45 +++++++++++++++++++++++++
>  tools/include/uapi/linux/netdev.h       |  1 +
>  6 files changed, 73 insertions(+)

My apologies; there's a few merge conflicts with this patch against
the latest net-next/main. I pulled recently, but it looks like
Mina's work got merged (which is excellent news) after I pulled and
so my patch won't apply cleanly.

I can wait the 48 hours to resend or simply reply with an updated
patch 6 in the body of my message, as this is only an RFC.

Let me know what works easiest for anyone who wants to actually test
this (vs just review it).

Sorry about that; should have pulled this morning before sending :)

- Joe

