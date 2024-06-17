Return-Path: <netdev+bounces-104101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CD190B381
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A1D1C23AC6
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1B615380B;
	Mon, 17 Jun 2024 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nuplD/4v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FB414EC72
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634279; cv=none; b=ko8TeBVbdWCmpG6VaUfWUqwzZhn5DF9KDlT1mg4c2PHQ2gDLCyiaAVGDxxUPXt3C/s7YOuB2KUIOcucTcWvFhvVPykBdv84/+lgJHxfSbRwoxynX8rQpIMad1vUY20h9VxKHNb9hbqBsYqO42/e7GljGsEqqjzGzbBV1WtXtfKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634279; c=relaxed/simple;
	bh=LA3Im2Ykn31l+Y3VFVXq9sQnK+qHfCnvBvYNSeGUED4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/JOdXK5Y2br/sQ09HAMu/Ew7C9oWyjBGE6SvZ2wMKgPdQy5/XfjG4Ko5qw49+cCeGAHSR8STuVCXS97QLcjkZWA3B/EYYte2KrDns+JRZ8URg5Kl99b14NT7DUN4+plfioXmN8Sy9Gm5fYa4MeTM1226JFMUEnKY+DNUk+0Hd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nuplD/4v; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b07937b84fso23167266d6.1
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 07:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718634277; x=1719239077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LWYcrrgGgJVkVkEzV+uKwxvFuw/0IQaRf2tlU6tnp7Q=;
        b=nuplD/4vFO+x2DcxEKETcpBZxmL9xrWd77PHeK1W7fqMemECckOFqAIHF7RUyVaF8a
         oZH+pxjOpy5/pdCeL+v0IcmpJMpUylZCYVX7RyiZhQSqeTGiH6zz/B3qaI7IIvAqKD34
         78zWtwXNU4+7aey5MeQhWlxVIW3JF4yLPV6zqNzJ1mN/rxPhMZWZjoC2oaj0pUgn40sj
         9VJk9wxOcv9+9OSa+/MhmzgzgVT0GihgybAOrAbEQQ1Ff7mhv1Rvpskw2OBSwrLqdnFC
         6i5ze6RtBh3Dx6kpKgG6hWtVOML2Gz+LDtiYPaA/x+ZVLP493IOyeC6EmGwmgqwdSnmh
         4fCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718634277; x=1719239077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWYcrrgGgJVkVkEzV+uKwxvFuw/0IQaRf2tlU6tnp7Q=;
        b=nVD+TY5u78FbTaQnywmuwrkHpGtdM06LSlXMqQ8RI+2RSHahNYP93uEMnyBymUBk6m
         mkKt6hE2xOMzPZ5+C02AbtWnqoeTahJddfJiP81HeE2PrxJnP9+kSQC3TKLJAx2vyKBh
         BZ28xEXd+CXZNwus0r3lEbhJgorWa9pgeT2878AocRLd70fXVEPmSHPN2qnpLQVrALS/
         nnVL8p19yM7x8FfIKgD5TJVG3lHAjavjj6XBzjiXKoJOS/IAqcczQ461Rtj39tbLYRyK
         dQVjck0cPaKAlYdlCTCR2ZvHDyTc0F0gFYTUPE+BpIQg6kfPfM9FDnCPBa+AqmvyPWfi
         0P0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCryaXR1Y81cQ34Cbv40+2HUy+RiotRrYPKQ20wwT0uqGi+npy0IR/SeDVUoge4PemSZ4u5VhqOsPVnXJGUbFddzLTEXE0
X-Gm-Message-State: AOJu0YwLux6CZl/nNZECthV+iVLEKjJfnN4dsJB7r3n5bHD07pH9Q7GC
	p7tX/1SvprhJlyYapHLXPJ18yKaWUYUhQDA4l8Lw0rM2BUGpfAZIeyOiMKJ3/Z8=
X-Google-Smtp-Source: AGHT+IGfwbJ60ZqrA114aMN45gK9s3vc2EDlXOzq6R5c002K1UZGeCA+L/WH+cwaawoW6d029bShcw==
X-Received: by 2002:a0c:e846:0:b0:6b0:806e:4015 with SMTP id 6a1803df08f44-6b2afc9e207mr99899936d6.25.1718634277045;
        Mon, 17 Jun 2024 07:24:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2d58f622dsm15818006d6.49.2024.06.17.07.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:24:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJDHf-008g9j-Rv;
	Mon, 17 Jun 2024 11:24:35 -0300
Date: Mon, 17 Jun 2024 11:24:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH rdma-next 2/3] IB/mlx5: Create UMR QP just before first
 reg_mr occurs
Message-ID: <20240617142435.GC791043@ziepe.ca>
References: <cover.1717409369.git.leon@kernel.org>
 <55d3c4f8a542fd974d8a4c5816eccfb318a59b38.1717409369.git.leon@kernel.org>
 <20240607173003.GN19897@nvidia.com>
 <20240613180600.GG4966@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613180600.GG4966@unreal>

On Thu, Jun 13, 2024 at 09:06:00PM +0300, Leon Romanovsky wrote:
> On Fri, Jun 07, 2024 at 02:30:03PM -0300, Jason Gunthorpe wrote:
> > On Mon, Jun 03, 2024 at 01:26:38PM +0300, Leon Romanovsky wrote:
> > > From: Jianbo Liu <jianbol@nvidia.com>
> > > 
> > > UMR QP is not used in some cases, so move QP and its CQ creations from
> > > driver load flow to the time first reg_mr occurs, that is when MR
> > > interfaces are first called.
> > 
> > We use UMR for kernel MRs too, don't we?
> 
> Strange, I know that I answered to this email, but I don't see it in the ML.
> 
> As far as I checked, we are not. Did I miss something?

Maybe not, but maybe we should be using UMR there..

Jason

