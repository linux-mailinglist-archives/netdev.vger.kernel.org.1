Return-Path: <netdev+bounces-104193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606B290B7C5
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 19:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6631A1C21643
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BC616D330;
	Mon, 17 Jun 2024 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1ixXQIM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DE816D320
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718644846; cv=none; b=LGr994Z3lJgs1VCiZPms1PYI60cfmakW6mjyFuzemYAr31YrmCbA+nrWMq4cnCfL2p7oMaPJaB+JREscRqcf3iSD9qE9DdzMJmUB4TcXr8bW8DCeHGta1KtNEvsEP7fDOCFgENGgLj4NF/yhioSQDL3xlISRahY5ZuFHxj2dF+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718644846; c=relaxed/simple;
	bh=Cg1LhvnE8vUoibLr3PoKJJzIy4aLnb92iWdTpcP88Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Te2RKxB9pr0DiazDFLan+OCLlgHJ3ieO/PR1DEyyAOERCgDY0vd3oEGEvdE8aCO+hrGI7nTwObtis7HwOv8bsJrwHUdGEfoHObbtMulfZmMGEViNzYoHvJugYGua4TFrFG0vcabxwLiVhPc4SIJg7TI8r0lKgLKh4ePVPoVeVwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1ixXQIM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718644844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L2V3iDyIIY5aUHvjMeczLBuQ9xcN8mYWjWFi4+9wu0E=;
	b=R1ixXQIMqC8Z69J0jHgXgnPHweoGeDqdpTmxGwgygOmUx1fFZXouh4u3ThEVZlMdynnHCv
	Z1W94aI2N285R4KpQJ9Lmjk6vD9AXv9ZKBdRj5mX9BrPtHX48HNHpCMXd1CilqdqIesb2o
	wd10c4lhfbonkQVWl5E989l8ek3oSbY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-vlVZYPqWNxCNRKJIIX4QYA-1; Mon, 17 Jun 2024 13:20:42 -0400
X-MC-Unique: vlVZYPqWNxCNRKJIIX4QYA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b08b3c1c9dso56196256d6.3
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 10:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718644842; x=1719249642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2V3iDyIIY5aUHvjMeczLBuQ9xcN8mYWjWFi4+9wu0E=;
        b=V9ux2qI1vcpv9K6DNk4gJgJz46Y9RzGAEGpY7Zp0L2znNbPSwS9b+k4jgO+eQDO3GO
         iR+bwd0Gk3QHLqg298Rpq6Wo4hJtCl4HnaJy4+7RyLc8hI8YgElIdibiehvXwvh7sfxb
         pQJiqaO9d7d5w9xGWTfzr9jTZy19qv9n3vGbJDl3HMUSEzY81/mqvXz62WEBwUmoM/7z
         lHhbzJ9vPGDB1orNJCFQ4RxaDAMUI2aePPU60Ta0K7NWJ4N3nB9XCyuj/MMz7FhINDaT
         uN46jO0JXn9ygIhGRy4fDphF11/ygyKkG6k806jxydLCPjbtNf9ngtRezwVEfETmFZ58
         TLkA==
X-Forwarded-Encrypted: i=1; AJvYcCVPFBgNThAA8PolBocaZOXIySqBferwGM380ZGXwt7d1WxF+DBpD6MXZIKltCZVKj9Uwqd0EeW2/Z9s4Nvt1IvP1PV+aNZn
X-Gm-Message-State: AOJu0YxOW1glW5jx08lbRVprvJgrKiAUVW4Gs/U9OZzCzManmgHyK81I
	XUSqJgCT8C4XRIfeK17uKBYYnErpAAqu71GEdip6Hc7Za90U5GWKs7v29O7Wdcb/h0uu/zF8yY3
	NVtK3zanZOW4nCfZCOyuAE/sTnUqOEF0bjko0Y/GVO5qtd2UOCqvm1A==
X-Received: by 2002:a0c:f003:0:b0:6b0:7b34:21c0 with SMTP id 6a1803df08f44-6b2afcd1d62mr110366916d6.34.1718644842189;
        Mon, 17 Jun 2024 10:20:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAuxhCqbvaPMuU8DzDikHsftFKdgJ58O2fcf0zAz2FIlNNC8fvFplZMGE63UKZ7vaiKhSfGw==
X-Received: by 2002:a0c:f003:0:b0:6b0:7b34:21c0 with SMTP id 6a1803df08f44-6b2afcd1d62mr110366376d6.34.1718644841295;
        Mon, 17 Jun 2024 10:20:41 -0700 (PDT)
Received: from fedora-x1 ([70.51.82.231])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2fcc404sm48142521cf.66.2024.06.17.10.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 10:20:40 -0700 (PDT)
Date: Mon, 17 Jun 2024 13:20:25 -0400
From: Kamal Heib <kheib@redhat.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net/mlx4_en: Use ethtool_puts/sprintf to
 fill stats strings
Message-ID: <ZnBwWS-j3ZyGkXht@fedora-x1>
References: <20240613184333.1126275-1-kheib@redhat.com>
 <20240613184333.1126275-2-kheib@redhat.com>
 <20240613184333.1126275-3-kheib@redhat.com>
 <20240613184333.1126275-4-kheib@redhat.com>
 <20240614183752.707c4162@kernel.org>
 <0de75730-5591-42db-911a-abcc24473345@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0de75730-5591-42db-911a-abcc24473345@gmail.com>

On Mon, Jun 17, 2024 at 08:06:40AM +0300, Tariq Toukan wrote:
> 
> 
> On 15/06/2024 4:37, Jakub Kicinski wrote:
> > On Thu, 13 Jun 2024 14:43:33 -0400 Kamal Heib wrote:
> > > Use the ethtool_puts/ethtool_sprintf helper to print the stats strings
> > > into the ethtool strings interface.
> > > 
> > > Signed-off-by: Kamal Heib <kheib@redhat.com>
> > 
> > minor build issue with this one:
> > 
> > drivers/net/ethernet/mellanox/mlx4/en_ethtool.c:453:6: warning: unused variable 'index' [-Wunused-variable]
> >    453 |         int index = 0;
> >        |             ^~~~~
> > 
> > otherwise LGTM!
> 
> Hi Kamal, thanks for your series.
> Please fix and respin.
>

Hello, 

Sorry about that.
I'll fix it and post v2 shortly.

Thanks,
Kamal 


