Return-Path: <netdev+bounces-185759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6214DA9BAC4
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 00:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378001BA4C64
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 22:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A49A27C84B;
	Thu, 24 Apr 2025 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+NU60M/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6661D2253EE
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745533600; cv=none; b=jSOeJN5clujYIZqEAskj4Qx/WN6bCfWcM8r1WRdX1NxaB+yJ5mLg860T3ML/qG+kNCMd22rzUevtIwMGXpo1GlIfyPBNOkatUKjWV7UgQKPqMQ3cTlGrPgM5xq4hRdVDV135wRvGnLDBAKY2VRkJnP057qecln0vSltFmtfhp+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745533600; c=relaxed/simple;
	bh=ohbmxWjmPePrskBPQzeWwBLzwGSWIbd5WM6psxso590=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EHh6KAM1AwBe11SPEY1SAT53/W1B2lx8Rgn+c9kAYNLG+StuxhsVGlScmemC2zN8MqLkCKQk5TegqLwU1mgcZoM0SWfw8MD5g9BqwU/Nj7CNwsAg+A1ofz0y7zKmH5iD5TCsiaGbMKPthh/7I+Szp4AnIrIQdr+GiiEeMe40B/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+NU60M/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6024CC4CEE4;
	Thu, 24 Apr 2025 22:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745533599;
	bh=ohbmxWjmPePrskBPQzeWwBLzwGSWIbd5WM6psxso590=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B+NU60M/qTOd/UEpiRZEPzjB+T9saqC3zFsPWr3gx+6b8IuBLE+/UPFpsINjlM3NF
	 dZTvvicyXPnNjFZP/A2yMJav4fKJS2tSu6KZQAH+RmQT6qFZSJLLEMLYThO/7XdvpP
	 C4HGZ1c4+EL5qNr/14gkdXaqHbk8kSB5MomcCmRG7+BBcU1ZXuBAcxJDe5uY5xrvm0
	 IggwJlpzOHoAfk9bK9e34k5fe18UbN5GR5br7I+LxEuAkZfHews162Kcvz3BsJq4oE
	 z0CCiepmVS/+i3Puz55Al7ji4erW+0OIVxyxARbkIDqw2uv7mYuCJxcmzWALn2GgB2
	 8XJ+36zGQPjsw==
Date: Thu, 24 Apr 2025 15:26:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Wojciech Drewek <wojciech.drewek@intel.com>, Kuniyuki Iwashima
 <kuniyu@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org, marcin.szycik@intel.com
Subject: Re: [PATCH v2 net-next 2/3] pfcp: Convert pfcp_net_exit() to
 ->exit_rtnl().
Message-ID: <20250424152638.5915c020@kernel.org>
In-Reply-To: <aAnAxEXgyyhfgHWw@mev-dev.igk.intel.com>
References: <20250418003259.48017-1-kuniyu@amazon.com>
	<20250418003259.48017-3-kuniyu@amazon.com>
	<20250422194757.67ba67d6@kernel.org>
	<aAimsamTlQOq3/aD@mev-dev.igk.intel.com>
	<20250423063350.49025e5e@kernel.org>
	<aAnAxEXgyyhfgHWw@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 06:40:36 +0200 Michal Swiatkowski wrote:
> > > Uh, I remember that we used it to add tc filter. Maybe we can fix it?  
> > 
> > If it really was broken for over a year and nobody noticed -
> > my preference would be to delete it. I don't think you need
> > an actual tunnel dev to add TC filters?  
> 
> Our approach was to follow scheme from exsisting ones.
> For example, vxlan filter:
> tc filter add dev vxlan ingress protocol ip ...
> PFCP filter:
> tc filter add dev pfcp ingress protocol ip ...
> 
> so in this case we need sth to point and pass the information that this
> tunnel is PFCP. If you have an idea how to do it without actual tunnel
> we are willing to implement it. AFAIR simple matching on specific port
> number isn't good solution as tunnel specific fields can't be passed in
> such scenario.

You're right, not sure what I was thinking.. probably about 
the offloaded flow.

Could you please fix this and provide a selftests for offloaded 
and non-offloaded operation? To make sure this code is exercised?

