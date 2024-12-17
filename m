Return-Path: <netdev+bounces-152458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9C19F403B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 02:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D0C16CC88
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 01:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F9743AB9;
	Tue, 17 Dec 2024 01:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="En4rEvuM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C5F2595;
	Tue, 17 Dec 2024 01:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734400355; cv=none; b=Wzjzbp7spCz7gRoMRXDj5A5Dca/fAlbJ22EU5tZupuULOmsW9DNodb9QLWnaAhKPRK4vWFvVCVVbmcmUIfZrXWWM7UZkRrUyO0oPQt8UWbzUQo/Bw26Dtyoefk1l46Hx3vSxSGR+c5dIHF30w6YHudRIGBhwTNOmC0o0SiygI4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734400355; c=relaxed/simple;
	bh=Dc1EjkkP8yZB+Lzy6XaSHxR9gc0cP4smyE+k7epBWYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fp4Z6y7UIkKHAPs4ACtpQ2M2CeaZdm8jcMbup5mmQ4ngjwWBBOYbCJst7waiaE0H8T15ZHAqcpF59ygKHBNt2r0KUryh/l5e7DxGQoHhpdsi8kW/bu2oHZeBjH83T1udL9PJY4YzumNwGNxKsPybvvylHVoV9VlX8PRQq6D6/Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=En4rEvuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EA5C4CED0;
	Tue, 17 Dec 2024 01:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734400354;
	bh=Dc1EjkkP8yZB+Lzy6XaSHxR9gc0cP4smyE+k7epBWYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=En4rEvuMe51nLY5xz/kceMOCExv7+kEZY7cXWN5c/6QiI9HGhnxe5yoedIHFXYcUR
	 N89ctvLxT8zoCZjlDb7K5Hs6Yo5FIRuZK/8IYO8ONCueOSHJmYEA+341hEPZL+BIPu
	 H6dRGYP8a36hMjds0clyaIFwjAMfaWDCz7owtMX606mOEyouucYALd80QYJMr0xdqD
	 b/uGPj2kCb3DvFTpdZhRWECCGcIiS1g8Ogdt7sY+glbdEurDrqBhAkONDdD5zQkbTG
	 6VfGH2Du/6usU6rUnx9yQbErU+C2cL6DYfGRfYNrv6pEEwVR+DaMzJjjkAy+T+JbIM
	 yHH90SE0w/Q+A==
Date: Mon, 16 Dec 2024 17:52:31 -0800
From: Kees Cook <kees@kernel.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH RFC 3/5] rtnetlink: do_setlink: Use sockaddr_storage
Message-ID: <202412161749.84F7671F3@keescook>
References: <20241104221450.work.053-kees@kernel.org>
 <20241104222513.3469025-3-kees@kernel.org>
 <7a2e5da2-5122-4c73-9a94-20e7f21a26f5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a2e5da2-5122-4c73-9a94-20e7f21a26f5@gmail.com>

On Tue, Nov 05, 2024 at 11:59:49AM +0100, Eric Dumazet wrote:
> 
> On 11/4/24 11:25 PM, Kees Cook wrote:
> > Instead of a heap allocation use a stack allocated sockaddr_storage to
> > support arbitrary length addr_len value (but bounds check it against the
> > maximum address length).
> > 
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> >   net/core/rtnetlink.c | 12 ++++--------
> >   1 file changed, 4 insertions(+), 8 deletions(-)
> > 
> > diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> > index f0a520987085..eddd10b74f06 100644
> > --- a/net/core/rtnetlink.c
> > +++ b/net/core/rtnetlink.c
> > @@ -2839,21 +2839,17 @@ static int do_setlink(const struct sk_buff *skb,
> >   	}
> >   	if (tb[IFLA_ADDRESS]) {
> > -		struct sockaddr *sa;
> > -		int len;
> > +		struct sockaddr_storage addr;
> > +		struct sockaddr *sa = (struct sockaddr *)&addr;
> 
> We already use too much stack space.

I'm finally coming back to this. I was over-thinking: this only calls
dev_set_mac_address_user() so it really is a true struct sockaddr.

> Please move addr into struct rtnl_newlink_tbs ?

I couldn't figure out how that was meant to work -- I didn't see a
struct rtnl_newlink_tbs instance near this routine.

Regardless, I can just tweak the length and leave it heap allocated.

-Kees

-- 
Kees Cook

