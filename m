Return-Path: <netdev+bounces-240020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFFBC6F554
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5754B3A5E29
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EB62F260E;
	Wed, 19 Nov 2025 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="c1kV0AOG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0F9275B16;
	Wed, 19 Nov 2025 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562415; cv=none; b=XR9zMdCyh9MdYlNxrhsG07pwBDbePRdGNz8Qd7E+8VPf2i8bw3Bsyz181nyj9jd0UJcriI76SopEqIczH72+N01TCZ+0lEYprlQjeYsxOXOM61QUh2B8QJLPKz4kZYeLJ8sBZm37eYsgypBLP/reFvu+Dz3d1E37SidIiuWw/f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562415; c=relaxed/simple;
	bh=bhcI06CIbQU0+aoz15+EQstZSQQXogZM7y1ufCmJ4ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1TZ58cf4ACGvrSc+/+cK+kf8p5h2VLeVwIHNSY4Hhfvu01MdIbPnxnZVFOO1gpY2agEBxR4eRuvdxKZudwfsW1yeBb23s95KGvaaiFlv37fl7QRtjNpitV/HTKQWXu4w60kI5qLOrMvn41aKhJoZNJvMJJ34mM4HgxnAPQ1G9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=c1kV0AOG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KGT/XOcVu7Pb6bU5dSoi4/F4rfNvcMt5cvbYh0kgDx8=; b=c1kV0AOGKO9IPEzlVPukttntTb
	rXN3oWyPys+RKgAeTDeQFqKHK4zzkKffxesdEpCo/rK+vfLLd6xHNpsLRG1KqMU9c0X5OYAGOAQNs
	6oJIeab3eRRfM1T7Ar8H+cEGcQ7/1G6pt7tbG0SSP3zQn+akG4ob5WYqzqN+R2HEEhXQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vLj8r-00EVLg-7C; Wed, 19 Nov 2025 15:26:41 +0100
Date: Wed, 19 Nov 2025 15:26:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: lan966x: Fix the initialization of taprio
Message-ID: <4f8b0e67-1cc4-4387-bad3-0c5ae2092f52@lunn.ch>
References: <20251117144309.114489-1-horatiu.vultur@microchip.com>
 <11ca041a-3f5b-4342-8d50-a5798827bfa7@lunn.ch>
 <20251119082646.y3afgrypbknp2t2g@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119082646.y3afgrypbknp2t2g@DEN-DL-M31836.microchip.com>

On Wed, Nov 19, 2025 at 09:26:46AM +0100, Horatiu Vultur wrote:
> The 11/18/2025 20:20, Andrew Lunn wrote:
> 
> Hi Andrew,
> 
> > 
> > On Mon, Nov 17, 2025 at 03:43:09PM +0100, Horatiu Vultur wrote:
> > > To initialize the taprio block in lan966x, it is required to configure
> > > the register REVISIT_DLY. The purpose of this register is to set the
> > > delay before revisit the next gate and the value of this register depends
> > > on the system clock. The problem is that the we calculated wrong the value
> > > of the system clock period in picoseconds. The actual system clock is
> > > ~165.617754MHZ and this correspond to a period of 6038 pico seconds and
> > > not 15125 as currently set.
> > 
> > Is the system clock available as a linux clock? Can you do a
> > clk_get_rate() on it?
> 
> Unfortunetly, I can not do clk_get_rate because in the device tree for the
> switch node I don't have any clocks property. And maybe that is the
> problem because I have the system clock (sys_clk) in the lan966x.dtsi
> file. But if I go this way then I need add a bigger changeset and add
> it to multiple kernel trees which complicate the things.
> So maybe I should not change this patch and then create another one
> targeting net-next where I can start using clk_get_rate()

This is fine as is. But maybe rather than use the magic number, add a
#defines for the system clock rate, and convert to pico seconds in the
code, and let the compiler do it at compile time. The code then
documents what is going on.

	Andrew

