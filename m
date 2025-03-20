Return-Path: <netdev+bounces-176439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6145A6A53D
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 12:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 031647B2EA7
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 11:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB952222B3;
	Thu, 20 Mar 2025 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJH5kb0s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F2C21CA18;
	Thu, 20 Mar 2025 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471092; cv=none; b=YKpg8KCYVbwc0StSlnflQvF/VlPrQnGgDYP7fAqInnpzF/sc/ecZtPmUrsmDOqg2DF2iAaLqn7LuozGAAUce30x93Yp0HUjngjLB3nATXk4m6BZ0UQOis9L68HcyDektaFcK4tlSOcjThkmtWEn57ytAYkytixYtGLcGjtF1kdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471092; c=relaxed/simple;
	bh=g6YCTbdDFiTFvUzyTjNH/ujKdXOa+VbdnSMLJuhHVNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=br5969zzWv8Pc8NGaHUrqde0yfmuOWsfLs6SI1rg6CNnbhskmojXzpgFPWDfRXkocAVk6o4xfgVWJaolhQd3Zn677WuEmm7DiCEsS0daNIYU0gwLPd0uFqVmUGAYNPaAZjnsVbQ/Ae4WVUHgswkWNz6TYhDOC65a17Vr6Y2JQqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJH5kb0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39568C4CEDD;
	Thu, 20 Mar 2025 11:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742471092;
	bh=g6YCTbdDFiTFvUzyTjNH/ujKdXOa+VbdnSMLJuhHVNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gJH5kb0sziHNRhuFyDAUbRiILIMsZxM+xwZVzNllw3Tasfp+yf5ExCgIA4YAN/G/p
	 Hh045U920JBrpUmK4X1g647TEdycaevAxvxuAFJlr3w1XXo2dJfAKItCE/zlh+zJRI
	 /LOC6oOppkHxOmYDY5ZNg3wauVMyDLaid7UjqnBE0YaBgsMsMUlX+3BXPkEl5wYOyP
	 ttbcrjbHRtWNJ+n23NS3+/kmY8BnpiaEGbvbM0eVIaBbQjoqV8apqwyrYWn2sEUUwr
	 WaMeeVj6x3xI5s410ULTS7KguGmUIWIaQXL9QxYpFP2uS/upUrZGcBvFQNhuq7Yeir
	 Mwd2k0b+0JvYg==
Date: Thu, 20 Mar 2025 11:44:48 +0000
From: Simon Horman <horms@kernel.org>
To: xie.ludan@zte.com.cn
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn
Subject: Re: =?utf-8?B?wqBbUEFUQ0ggbGludXgtbmV4dF0g?= =?utf-8?Q?net=3A_atm?=
 =?utf-8?Q?=3A?= use sysfs_emit()/sysfs_emit_at() instead of scnprintf().
Message-ID: <20250320114448.GK280585@kernel.org>
References: <20250317152933756kWrF1Y_e-2EKtrR_GGegq@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317152933756kWrF1Y_e-2EKtrR_GGegq@zte.com.cn>

On Mon, Mar 17, 2025 at 03:29:33PM +0800, xie.ludan@zte.com.cn wrote:
> From: XieLudan <xie.ludan@zte.com.cn>
> 
> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> Signed-off-by: XieLudan <xie.ludan@zte.com.cn>

Thanks Xie Ludan,

As per or discussion offline,
please coordinate with your colleague
Tang Dongxing who has also posted a patch in this area.

  https://lore.kernel.org/r/20250317155102808MZdMkiovw52X0oY7n47wI@zte.com.cn/

It will be much easier for review if there is a single patch
that addresses these issues for ATM.

Also, please consider reading the following guidance on processes
for the networking subsystem of the Linux kernel. These are similar
but different to other subsystems.

  https://docs.kernel.org/process/maintainer-netdev.html

--
pw-bot: changes-requested

