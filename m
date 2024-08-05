Return-Path: <netdev+bounces-115604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883E5947232
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 02:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAACB1C20AE3
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 00:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A07E182B9;
	Mon,  5 Aug 2024 00:40:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cooldavid.org (125-229-167-49.hinet-ip.hinet.net [125.229.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E7617721;
	Mon,  5 Aug 2024 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.229.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722818402; cv=none; b=UFQ6MZ/Iuc382SCf1+7/HM8eq7M3SJigG5O21+EFm2Ovz6hUT32kHmHhjhslQVlKWap1BD8QS3Dfv2cg2h9/WgJWOApq1caJ3XFiM/XPBl+17eeKUl8AAf0ei1MjCMk4Kk2zZNCgfcMyBY09Xn4iMcr+70uIxw4KfYc6YzgxHyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722818402; c=relaxed/simple;
	bh=tCr0E9F5GoCJIxAXzFtJs90hKzSNPF8lHoLfe/+JuuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDCmQn5MKLBYJcu+Tha1y15a6ltE2OxP0fFj+0lUTYc9KfxsjpwY9LvVwOjE+JzxDIDG8A6Hl/019KTKH/KxlyYoWIGRJHpNoRWNfh/3KF+v7ARe+jeaX8FFwlrflpA8st5ArfBt9n9QyYu2UVGUvZocwe8HgtgUEeUssxYFQi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cooldavid.org; spf=pass smtp.mailfrom=cooldavid.org; arc=none smtp.client-ip=125.229.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cooldavid.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cooldavid.org
Received: by cooldavid.org (Postfix, from userid 999)
	id 9BA6129A1025; Mon,  5 Aug 2024 08:32:23 +0800 (CST)
X-Spam-Level: 
Received: from cooldavid.org (localhost [127.0.0.1])
	by cooldavid.org (Postfix) with ESMTP id 2197729A100C;
	Mon,  5 Aug 2024 08:32:23 +0800 (CST)
From: "Guo-Fu Tseng" <cooldavid@cooldavid.org>
To: Simon Horman <horms@kernel.org>,Moon Yeounsu <yyyynoom@gmail.com>
Cc: davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,netdev@vger.kernel.org,linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: use ip_hdrlen() instead of bit shift
Date: Mon, 5 Aug 2024 08:32:23 +0800
Message-Id: <20240805003139.M94125@cooldavid.org>
In-Reply-To: <20240804101858.GI2504122@kernel.org>
References: <20240802054421.5428-1-yyyynoom@gmail.com> <20240802141534.GA2504122@kernel.org> <CAAjsZQwKbp-3QgBj9KEUoqLvaE5pLX8wsLq01TDC8HdVp=8pLg@mail.gmail.com> <20240804101858.GI2504122@kernel.org>
X-Mailer: OpenWebMail 2.53 
X-OriginatingIP: 111.243.142.21 (cooldavid)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=utf-8

On Sun, 4 Aug 2024 11:18:58 +0100, Simon Horman wrote
> On Sat, Aug 03, 2024 at 10:47:35AM +0900, Moon Yeounsu wrote:
> > On Fri, Aug 2, 2024 at 11:15 PM Simon Horman <horms@kernel.org> wrote:
> > >
> > > On Fri, Aug 02, 2024 at 02:44:21PM +0900, Moon Yeounsu wrote:
> > > > `ip_hdr(skb)->ihl << 2` are the same as `ip_hdrlen(skb)`
> > > > Therefore, we should use a well-defined function not a bit shift
> > > > to find the header length.
> > > >
> > > > It also compress two lines at a single line.
> > > >
> > > > Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
> > >
> > > Firstly, I think this clean-up is both correct and safe.  Safe because
> > > ip_hdrlen() only relies on ip_hdr(), which is already used in the same code
> > > path. And correct because ip_hdrlen multiplies ihl by 4, which is clearly
> > > equivalent to a left shift of 2 bits.
> > Firstly, Thank you for reviewing my patch!
> > >
> > > However, I do wonder about the value of clean-ups for what appears to be a
> > > very old driver, which hasn't received a new feature for quite sometime
> > Oh, I don't know that...
> > >
> > > And further, I wonder if we should update this driver from "Maintained" to
> > > "Odd Fixes" as the maintainer, "Guo-Fu Tseng" <cooldavid@cooldavid.org>,
> > > doesn't seem to have been seen by lore since early 2020.

The device has been EOLed for a lone time.
Since there is no new related chip and no new updates from the chip maker, I do agreed to make the status as "Odd
Fixes".

> > >
> > > https://lore.kernel.org/netdev/20200219034801.M31679@cooldavid.org/
> > Then, how about deleting the file from the kernel if the driver isn't
> > maintained?
> 
> That is a bit more severe than marking it as being unmaintained
> in MAINTAINERS. But I do agree that it should be considered.
> 
> > Many people think like that (At least I think so)
> > There are files, and if there are issues, then have to fix them.
> > Who can think unmanaged files remain in the kernel?
> 
> And yet, they do exist. ☯


Guo-Fu Tseng


