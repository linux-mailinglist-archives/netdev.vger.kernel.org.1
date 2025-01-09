Return-Path: <netdev+bounces-156809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA5FA07E1A
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B472161E1D
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5713617C9F1;
	Thu,  9 Jan 2025 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrzBm/zc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7ED139D19;
	Thu,  9 Jan 2025 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736441575; cv=none; b=mJB7Pv95OgpTXTQ97tglFekPGjK6jJlg3TAzKZjngM0/Ewn+S+ZydAPQ1NPW008b6+N9LnM5qNHd2lC2JZFxOXWdRV5gwZUPsikDXV23BeT7okaxUyPkSQ75bTNLpycXGMTKRfpd4TJMVvWvvosZdJTwmCuXExRUAmx2hRyMLcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736441575; c=relaxed/simple;
	bh=D9wPmSGM+XKwwXedjCZUph0IWYMqhMZDIHz6GWv8qw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDg5oH+3jexuivzlY+Q6qNY0t4y5fWDPN3kpBQ2pSO3bRR7J70lQOhZk0/w+8J2/nFS0sZZnlO8JxYE/119p1UzSar1HJraAZ8+4NfMipmi+MocbzavJvawSMJ81XfxIxafSkAscEmpArVrHjnWf3vnNtCZytvo0lfdPOePDqOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrzBm/zc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A816C4CED2;
	Thu,  9 Jan 2025 16:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736441574;
	bh=D9wPmSGM+XKwwXedjCZUph0IWYMqhMZDIHz6GWv8qw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QrzBm/zc/7hrXaE0GlSJpd9qLH3JywU0ZDLwH7UMDR51AsYxxuFS9AgQXBx0/IuJg
	 5mRc9rZ1B89/eSCmX6KwK/uqbG5J9GmrSHSwc+zAP8MQG58GPA3r0uxVqMCdDUovx2
	 JMiUMyd89sA+9B++YJAPaUUpmiojTcTSQSBVJZzbGd6+CZVZtWHCltQRRrkRDSHPdz
	 ayekRYOG8yniRDTk4Q2xatb9MRry0bDXMORkzQp412iUnYg1nYkGm5coDGNvZNrGK+
	 CZX3IjTK/w4+WBjIVhP2o+LT9Bnt28R6Rgv/v7odmVOJW7F56o44ljKvR/YJjPXe0c
	 bYjrl+ZXbUx4w==
Date: Thu, 9 Jan 2025 08:52:50 -0800
From: Kees Cook <kees@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-hardening@vger.kernel.org, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next] net: Silence false field-spanning write warning
 in ip_tunnel_info_opts_set() memcpy
Message-ID: <202501090852.AA32AF8BD@keescook>
References: <20250107165509.3008505-1-gal@nvidia.com>
 <53D1D353-B8F6-4ADC-8F29-8C48A7C9C6F1@kernel.org>
 <35791134-6c58-4cc4-a6ab-2965dce9cd4b@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35791134-6c58-4cc4-a6ab-2965dce9cd4b@nvidia.com>

On Thu, Jan 09, 2025 at 11:00:24AM +0200, Gal Pressman wrote:
> On 08/01/2025 1:28, Kees Cook wrote:
> >> This resolves the following warning:
> >>  memcpy: detected field-spanning write (size 8) of single field "_Generic(info, const struct ip_tunnel_info * : ((const void *)((info) + 1)), struct ip_tunnel_info * : ((void *)((info) + 1)) )" at include/net/ip_tunnels.h:662 (size 0)
> > 
> > Then you can drop this macro and just use: info->options
> > 
> > Looks like you'd need to do it for all the types in struct metadata_dst, but at least you could stop hiding it from the compiler. :)
> 
> Can you please explain the "do it for all the types in struct
> metadata_dst" part?
> AFAICT, struct ip_tunnel_info is the only one that's extendable, I don't
> think others need to be modified.

Ah, sorry. If that's the case, then just ip_tunnel_info is fine. (Is all
of the metadata_dst trailing byte allocation logic just for
ip_tunnel_info?)

-Kees

-- 
Kees Cook

