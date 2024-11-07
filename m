Return-Path: <netdev+bounces-142769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 786239C04DD
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA05A1C23A8A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA6921018E;
	Thu,  7 Nov 2024 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1QHwT/x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8DC20F5B7
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980237; cv=none; b=VFGMVMXV8bOMOXMFFEcNCy3V3tFNUQmI7aioJnvu2W7dxv9ZfPLnkWbHSsRmZtfNfelHBTPOUMEsdXGh0I97Z4iy+0VB8e3ud7X9UC58so7jf0+4JYct+/6y3Fx6zT10xIGPbxbIa4vcdqVqHCVG3Bqq0dBMO6xZ4gAKpN17l8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980237; c=relaxed/simple;
	bh=1m5HdAq6sHmragQQ341Wnq6mMbOs5y6f0TYrU3HekcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAltg27Z2nvO7V8Rw4+TTbgvGSvC2UKVdIAWbk+wNMU3YbvDjkR8ZUsq5JUfHbHof/XbYITgqIogAeitM92peKb3JwoATPPe7n7sos/6YNK95oq+GWKj0hXo8eAFyy55STF5bFIsVtbIoYywi3cC9dygIA7LgUnx6jn5OCD0R7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1QHwT/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C23FC4CECE;
	Thu,  7 Nov 2024 11:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730980237;
	bh=1m5HdAq6sHmragQQ341Wnq6mMbOs5y6f0TYrU3HekcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1QHwT/xvXw+JpDdumR7qN/tnlMAyvJHEkcOWybO2S3vzY8D/KNVAPuRzBC3pXY52
	 aP9g2o7tV6+5yR1LsQczEZ460qNvs93PGWiohtwbyj2vOLCy9gKEjGOsLAWjwSa0rR
	 DQI1q20+PVz7Xg7JUiAwU2WmnpU+0yagsp8kdsSmFvIqQ9xuTjge653R7dV/LzPfjy
	 H0cNovd3Up8sbNcxrZ2WRwe4VoUlmf2V9YUTJD94Yja4+4C7o0AI8PHJUBKWA30T5D
	 vCYnNTsBsQ3YRf97wO8pXBgne5cPeHAIedp33t2NzFuD8ugf7VmJrSybU/FtO0eJu7
	 /lwiJsi9k5hPw==
Date: Thu, 7 Nov 2024 13:50:31 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: Feng Wang <wangfe@google.com>, netdev@vger.kernel.org,
	steffen.klassert@secunet.com
Subject: Re: [PATCH 1/2] xfrm: add SA information to the offloaded packet
Message-ID: <20241107115031.GK5006@unreal>
References: <20241104233251.3387719-1-wangfe@google.com>
 <20241105073248.GC311159@unreal>
 <CADsK2K9seSq=OYXsgrqUGHKp+YJy5cDR1vqDCVBmF3-AV3obcg@mail.gmail.com>
 <20241106121724.GB5006@unreal>
 <Zytx9xmqgHQ7eMPa@moon.secunet.de>
 <CADsK2K9mgZ=GSQQaNq_nBWCvGP41GQfwu2F0xUw48KWcCEaPEQ@mail.gmail.com>
 <Zyx/ueeoeBdq/FXj@moon.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyx/ueeoeBdq/FXj@moon.secunet.de>

On Thu, Nov 07, 2024 at 09:52:09AM +0100, Antony Antony wrote:
> On Wed, Nov 06, 2024 at 16:14:36 -0800, Feng Wang wrote:
> > Antony brought out an important function xfrm_lookup_with_ifid(), this
> > function returns the next dst_entry.
> > 
> > The xfrm_lookup_with_ifid() function utilizes xfrm_sk_policy_lookup()
> 
> would the output packet, looked up using xfrm_lookup_with_ifid ,
> match xfrm policy with "offload packet" set?

According to my understanding, no.

> When lookup is in the xfrm device.
> 
> ip xfrm policy .... offload packet dev <if-name>
> 
> 
> > to find a matching policy based on the given if_id. The if_id checking
> > is handled in it.
> > Once the policy is found, xfrm_resolve_and_create_bundle() determines
> > the correct Security Association (SA) and associates it with the
> > destination entry (dst->xfrm).
> 
> If the output packet got this far, dst is set in skb?
> And when the packet reach the driver dst = skb_dst(skb);
> dst->xfrm is the state?
> If this is the case  why add state to skb as your patch proose?
> May be I am missing something in the packet path.
> 
> > This SA information is then passed directly to the driver. Since the
> > kernel has already performed the necessary if_id checks for policy,
> > there's no need for the driver to duplicate this effort.
> 
> Is this how packet offload would work? My guess was in packet offload
> policy look happens in the driver.

You are right, this is not how packet offload works.
The expectation is that HW sees and catches same selectors as SW.
It ensures that if SW finds policy/SA, HW will find the same.

Thanks

