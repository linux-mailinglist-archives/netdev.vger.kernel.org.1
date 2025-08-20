Return-Path: <netdev+bounces-215364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C911DB2E424
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 19:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20D834E5656
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 17:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330D724A063;
	Wed, 20 Aug 2025 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="YMzxhnjN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5041124DD0E
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711725; cv=none; b=rylJpxeGa4j0qpr0Mbfp/f0i3heu+WsE2LIPkK+6x05SKDDG9c+qpNsQW3WK0Un+388IGFoeAuRlT8wMBHd3+4qMxahmiQ/JXxQ5w0LNjiS4g1VelKUax8JdgdDelK4+xjERRs7EGaPwNlk0/zTHASq6Jwcy1q45sT4K2QQb7sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711725; c=relaxed/simple;
	bh=DkKU5FP5vCq391ejsMIE9BrqoApiOU1f9w6MNiv0UhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPASuBJB+njZwN98xM7rXvfw/0A/bui/0QqwmIei1Z3Cj+eeU4FSHlRstGCmIH3HG+lSLr8063aCBVlBOk6/mjh5ie2fm6HO+6PDg1QXbESpNmWHHOq3y7dTBERhn1TyMm9y0Myq5R4is2xeNeKHwYqBQIeOwdIW9IDc7aCu3Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=YMzxhnjN; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b47173749dbso48887a12.1
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 10:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755711723; x=1756316523; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NzSUbaH+VOCVOUqJqJIjK5ALNlf0wJhYr4X2y+q08mw=;
        b=YMzxhnjNVj2RkpSCxterj+LTotgfd5ssBZeztOho/kkNiSsZdAEX5R5xdI/26JJhvx
         SF+ojZLlDmUyCYu7AdkL1vmZhfNX+cS/l8P3CA7n78eRoCJKHsTAYFocVIVRNHX5tdSY
         J/JBzFK1PJW1zGcR8rGQjGEpneBpf6Ohf/5SBVK0r9KhkflDZCkh1dbMa21dpBl6Kt3N
         kyUqbGdOv5c6AEagPagADREcnFdxmoE6PDbjkTC2jh0RVajtNAmTKyecioGx8ZGLB6ji
         gQR4obByCjeJWXBGaPk0XsBIYeoZ5ihTvFMB6J5NDBN+EbkqdZKZYtUZJBjTJoxTGiZJ
         aHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755711723; x=1756316523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NzSUbaH+VOCVOUqJqJIjK5ALNlf0wJhYr4X2y+q08mw=;
        b=uUxJOheXUVJ0Byk8Ni82VyQCut0q7GRiQyWh10o1Y1UepnjuvJm5CJaF1n0cF0ZOVT
         AwxcRusDbMqqsNim0eqLvlZ22GHkD7sqbm8yJSz4LqDiMhMAzn/0jSNQkF7hIpWcwxGo
         r4Cib3esGVTcUz7MVCcqjxzLX7KiWt74g4cD31jjC4lfsgpYQLItK3oh+4p5HMF/dpBc
         D9FX+W9gij5OGH5P7KSM3xt8UnjERUYMqq3Sz0n9+afccUKcI96DKWLoozlM+0L2mNwW
         uba63N3PRSti58YeyLeKNV1fp2Z55AfL/NchGmg8rFb+boIaCrRlmSrp0I9lZUHnw94O
         69EQ==
X-Gm-Message-State: AOJu0YwsfRacdWJbc59SMZJoCWSCPrr+55MAJS6Pe18HbzOdjunxyX6W
	6x86gRQvM8ynvcR9l1ccnE5mOyZvbc40zzyqjORqVOfC+JLEuMNGcHiM2SGK+9cQ4Dw=
X-Gm-Gg: ASbGncsdtM/6EV2B1pGVLd1yibGI8s591EOHGSznNejnZwdAI9LTwpmBEGXUjcur4Wy
	iw/Y84bpMxnkEWex2K0jNE3lOvfjxAiPy9sGt4aEVNPPEed9s+PrPnJ61aHhjSqAd/eRvKz3+ss
	jK/vqHT9Kq4ajKpZvxIgy6VqfHv2v0gXIE9Pr8Z3sYTsmmmRBdmjl+Pt2Nfcau9pvAx8sGTSciE
	DS4nHJErBUOMRZu15qdsYtIRSkErwbzk4uMHFCCvT+hMO03SaoCF11O8BVpkOLdw7xEbvZxSeul
	uTnT2Hi+on3RFoQrQ/TssfgCHiWb1TADwDzZr1BQlIBDsYGZXNzk/X91n5Gb/ZCC0SoFYC6xFQ9
	tPOveivIuW1Eq4x6WrjbVSd2M
X-Google-Smtp-Source: AGHT+IH4K4sRE7Fqgoy2HD4viykgQc0Xtxey922nomAwSvR23t0KFZi18mrd09Tt1Z+vQ9Ddj3lPkQ==
X-Received: by 2002:a17:903:2ac5:b0:240:1bdc:afc3 with SMTP id d9443c01a7336-245ef2520ecmr42859755ad.44.1755711722603;
        Wed, 20 Aug 2025 10:42:02 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed339fa8sm32386365ad.20.2025.08.20.10.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 10:42:02 -0700 (PDT)
Date: Wed, 20 Aug 2025 10:41:59 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Ivan Vecera <ivecera@redhat.com>, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] i40e: Prevent unwanted interface name changes
Message-ID: <aKYI5wXcEqSjunfk@mozart.vkv.me>
References: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
 <CADEbmW100menFu3KACm4p72yPSjbnQwnYumDCGRw+GxpgXeMJA@mail.gmail.com>
 <aKXqVqj_bUefe1Nj@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKXqVqj_bUefe1Nj@mozart.vkv.me>

On Wednesday 08/20 at 08:31 -0700, Calvin Owens wrote:
> On Wednesday 08/20 at 08:42 +0200, Michal Schmidt wrote:
> > On Wed, Aug 20, 2025 at 6:30 AM Calvin Owens <calvin@wbinvd.org> wrote:
> > > The same naming regression which was reported in ixgbe and fixed in
> > > commit e67a0bc3ed4f ("ixgbe: prevent from unwanted interface name
> > > changes") still exists in i40e.
> > >
> > > Fix i40e by setting the same flag, added in commit c5ec7f49b480
> > > ("devlink: let driver opt out of automatic phys_port_name generation").
> > >
> > > Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
> > 
> > But this one's almost two years old. By now, there may be more users
> > relying on the new name than on the old one.
> > Michal
> 
> Well, I was relying on the new ixgbe names, and I had to revert them
> all in a bunch of configs yesterday after e67a0bc3ed4f :)

And, even if it is e67a0bc3ed4f that introduced it, v6.7 was the first
release with it. I strongly suspect most servers with i40e NICs running
in the wild are running older kernels than that, and have not yet
encountered the naming regression. But you probably have much better
data about that than I do :)

