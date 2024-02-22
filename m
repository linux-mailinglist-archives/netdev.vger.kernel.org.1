Return-Path: <netdev+bounces-74004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E68F85F9AB
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2F31C244B1
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36141132C1B;
	Thu, 22 Feb 2024 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2ccXG1RL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DA8131E5C
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608273; cv=none; b=XBauwkMyLkhfKpqMb6B01p4gECov6MTZcljs47Dwr5Kn4OPIF5o/HiygUGK4jVhuzYp4s0WRYESXCsELyPNi7otBdFCM3UTPLBmyWmd8IGo1kl3FwfIweFxlbrdYsKWP7T2LrvP/QWIkrU0PPmeX/XRZ29FPVuiVdmGe6xS3xwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608273; c=relaxed/simple;
	bh=0IHfQCsPSzb8pnRPoBnWK6s2twIJXraeaF4xwtfCJ1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBadBuZVQBdUYQy88I755bnXQCwCkWLzq+3/v9oM7rzy41K6RPdUQ4gUJj0Qp/X1P+QkqhDxcxB6FPGeckn/7GpaWTyi6O7voN18id7rj/TFfwYpstikGG5CjWd8XvUIkjYrP5vF+VtP8ryqYJBTby/Djf15HTTXtaSYO/pKdMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=2ccXG1RL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41272d42207so17422765e9.2
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 05:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708608269; x=1709213069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DbxUMRAGDF1HChv8QBv0mMPpjYAbLCrOUtOWPuhncuw=;
        b=2ccXG1RLhxVJ0Zb/uXHQIcOS9xtDy8cLt3Dd6v50blKIhIHHqg6gOhWLyWjo7YWz2w
         /kPnk657vWJxmkicjnOUVA5TEqLO2Rg1on1dMnEVvHS2j+VCJW334Qbzc+I9PDgSVI0X
         ctkHHf1tQLYB5k+OwCEx1WsVkV/PH2VL5IMx0GRNhaVHq8y6x5cOpYU5P+KZ0gJDQL5a
         uYwH22DFmYdZgM6RL+knjVw3sZdaJWr2W+HRJ13q/XBbeKaebxDu2ZViEZjlcC+CT38H
         Q9OBlunfyOwfWp0UEJrq1m/rP8paafdrCKUmm1O5+gELYsXxkqBUB9s1w15zsVAdtQTC
         efnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708608269; x=1709213069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbxUMRAGDF1HChv8QBv0mMPpjYAbLCrOUtOWPuhncuw=;
        b=s85xPQXMV31AIXOr5H1NV0t/upnCtfPO1m2pTQPPoXoPKu1o+VQ8bdSZcFEZY2PG/e
         M2Cyw4qCn4jgy3pvURk1B7kp16zC2ToP8n3jEGdJululX9Y/btoeGxGNuY9VCdcAEPBF
         necao9Ign1NYcQQJuwHQh2dM7PyuVfKQ6bIhiPMnmLDm9RlXVYNISGMFClfn3/Bf2cJX
         yWnIfq6HeXr5pLyB/+YQB53i4hNZVb1RG5TXUqFELx4Ih7hY+RZv26hiaUa9LSOtinAs
         egtX1F66KoZqf2Sa1+oq6SOoZgUK2khNUQLizsH73BVz3vEKfBNBd8bl6zK/IdgoozpT
         Z6ug==
X-Forwarded-Encrypted: i=1; AJvYcCWaS4bmKjiCRgtfLyJ8NIH4N/0xRbQ28hspTX7oqdmUz6Pd8dly2I834zfJz+Zd5T1wAvcLbxTWrrNHeeLNFb+amdNQ5Wxm
X-Gm-Message-State: AOJu0YzUkMOjUb0SXalHVLNsgU0AP1uNiDCdfoGQcKsoURrBsz4dPcHP
	B6SZf1+tzgIGeQxj+bT2H4LtQUOEhn1Kx/jDcamg3TN5EI14/5cQDP5OW7q2xNY=
X-Google-Smtp-Source: AGHT+IFu4xid5HojxVhW+0/O82323fmGQj4/MxZKPTHYrb4Lf+CaWCzFoRc/hh6Sa58zcrg70bXmgw==
X-Received: by 2002:a05:600c:4f47:b0:412:8f5c:cd34 with SMTP id m7-20020a05600c4f4700b004128f5ccd34mr10013wmq.27.1708608269542;
        Thu, 22 Feb 2024 05:24:29 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id e25-20020a05600c219900b0041061f094a2sm1884631wme.11.2024.02.22.05.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:24:29 -0800 (PST)
Date: Thu, 22 Feb 2024 14:24:25 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: John Garry <john.g.garry@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, gregkh@linuxfoundation.org,
	netdev@vger.kernel.org, linux-staging@lists.linux.dev,
	masahiroy@kernel.org
Subject: Re: [PATCH net-next 0/3] net/staging: Don't bother filling in
 ethtool driver version
Message-ID: <ZddLCZ8D-qe2nOP_@nanopsycho>
References: <20240222090042.12609-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222090042.12609-1-john.g.garry@oracle.com>

Thu, Feb 22, 2024 at 10:00:39AM CET, john.g.garry@oracle.com wrote:
>The drivers included in this series set the ethtool driver version to the
>same as the default, UTS_RELEASE, so don't both doing this.
>
>As noted by Masahiro in [0], with CONFIG_MODVERSIONS=y, some drivers could
>be built as modules against a different kernel tree with differing
>UTS_RELEASE. As such, these changes could lead to a change in behaviour.
>However, defaulting to the core kernel UTS_RELEASE would be expected
>behaviour.
>
>These patches are for netdev and staging trees, and I hope that the
>respective maintainers can pick up the patches separately.
>
>[0] https://lore.kernel.org/all/CAK7LNASfTW+OMk1cJJWb4E6P+=k0FEsm_=6FDfDF_mTrxJCSMQ@mail.gmail.com/
>
>John Garry (3):
>  rocker: Don't bother filling in ethtool driver version
>  net: team: Don't bother filling in ethtool driver version
>  staging: octeon: Don't bother filling in ethtool driver version
>
> drivers/net/ethernet/rocker/rocker_main.c | 2 --
> drivers/net/team/team.c                   | 2 --
> drivers/staging/octeon/ethernet-mdio.c    | 2 --
> 3 files changed, 6 deletions(-)

The set looks fine to me.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

