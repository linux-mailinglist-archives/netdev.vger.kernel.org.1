Return-Path: <netdev+bounces-187441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6F6AA7304
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 15:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12ACF1C02EE3
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 13:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD583254AFB;
	Fri,  2 May 2025 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RdcwfBJw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC77252905
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746191365; cv=none; b=EeJ6/ZHunB3nFCdJnvSmjcQib5xdlUw9WpUbo/vtiJJwxnTMWpGY7Ejb+3CSfJcH7QUDgkmlnwAn+CW3NkENZcD6JbUT/PW29xg0tREXvnXUSSIeT85ySq0oHI0o8CIkERPu/RJqXxfYeWevourrnZ5tmJKU2sd/cgnosC507ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746191365; c=relaxed/simple;
	bh=FtvWMs++DlFXGee3W9dOqTUMQx/XKVER7bb4clEx2go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fm+CaJbUxCVHfTZP/R+81MqWY4DmPADPFLlb9faOp9U7ALmX2oi7d3nYDbn/IbMII35xyvnredr8HiWKEQuDukCmXMhHMsGK884WXqIi0h0lH7soxqL83ymYSes6JjXDvUwFywHCaVoRWQ2jaJG5dvx/omwuV085+nuFbBwdlr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RdcwfBJw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h5PLf2nU/ruymIeHrghqqxoHbc5YNgJE5NdaGuJkyoE=; b=RdcwfBJwUJdETPv+x7DPMC++Dy
	fyskl4Av/4KvaWEEUtSPo9BORDJe1ppSRn8Dwv3PaApOda20G5SWDdpWNw1vrlWAZ4bNip3dvUEVN
	K/wpmLwDm/CQaKQmGo8PW/tGNSvRkip3HhNK3w825GIMN8fMetvWvwfLvH0W+PdCiauo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uAq8S-00BQ1b-Ao; Fri, 02 May 2025 15:09:00 +0200
Date: Fri, 2 May 2025 15:09:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Howells <dhowells@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, willy@infradead.org,
	netdev@vger.kernel.org
Subject: Re: How much is checksumming done in the kernel vs on the NIC?
Message-ID: <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch>
References: <1015189.1746187621@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1015189.1746187621@warthog.procyon.org.uk>

On Fri, May 02, 2025 at 01:07:01PM +0100, David Howells wrote:
> Hi Dave, Jakub,
> 
> I'm looking into making the sendmsg() code properly handle the 'DIO vs fork'
> issue (where pages need pinning rather than refs taken) and also getting rid
> of the taking of refs entirely as the page refcount is going to go away in the
> relatively near future.

Sorry, new to this conversation, and i don't know what you mean by DIO
vs fork. Could you point me at a discussion.

> I'm wondering quite how to do the approach, and I was wondering if you have
> any idea about the following:
> 
>  (1) How much do we need to do packet checksumming in the kernel these days
>      rather than offloading it to the NIC?
> 
>  (2) How often do modern kernels encounter NICs that can only take a single
>      {pointer,len} extent for any particular packet rather than a list of
>      such?

You might need to narrow this down to classes for NICs.

Some 'NICs' embedded in SOCs don't have scatter gather. Some
automotive NICs transfer data via SPI, which in theory could make a
linked list of SPI transfer requests per {pointer,len}, and hand it
over to the SPI core as a single operation, but in practice the MAC
driver tends to do this scatter/gather by hand.

There are some NICs which get confused when you add extra headers near
the beginning of the packet, so cannot perform checksumming deeper
than the FCS. IP, UDP checksum has to be done in software, etc.

Modern kernels still support NICs from the 90s, original Donald Becker
drivers, so you cannot assume too much from the hardware.

	Andrew


