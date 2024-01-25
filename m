Return-Path: <netdev+bounces-65938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264CC83C8F4
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 17:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B337D1F25420
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 16:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1920130E32;
	Thu, 25 Jan 2024 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A8NYRUI3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBF512FF96
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201287; cv=none; b=ElOa30O5xB6rV99Ylix+P3MboGyNoueFvsRhTIv8Uyu265PbXnkLhVTPM9P/2vv5XKP6PE7cW3NUPBCpfVSgJ26s+ojZkZJ/G9xf9WVucxkJ24vtYJzem2FTNskPlDdD8VeZwfR8HiBCPTW7H8wmqffnITSS/Z8mosymrY/Hd0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201287; c=relaxed/simple;
	bh=Bb1fQdiBUqnIlqU/X+L06PwyDumib+a2nLsmzK/Mog0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/g7s0iuAZlv7gNWYCCwqdTCJ3nbAJkyHgXweydjAgSpC+Co4H7FwmSNYRX+WYcH01QbhngAwIBYSF7EQDJ0Vyc0dPVW+sE3lTZw8oy6D6qs4oRgc1d5V2XlcIzt4b7LUXBrpkb75VLtw45izwlrOvB+FeMW6LSbfaX3CARBbkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A8NYRUI3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Brtm+X/hPzncxyQIojg0OUi8pFhxYzTJe+3ddjp2XmE=; b=A8NYRUI39YdzMH9pdsr99ygVSB
	oaAkxDkTi3L+nmIf1a6Nqq+vwIzBBCPFxwwD3MdLzM1Tpzxspyq9qUAEH/o3Kq2oSbqZPQE5JQciO
	B9HzL2plMrw0L1J6ZeB2aeACdKmIjhM5ChJa3F5euEtFW4uNiQUpPCYhJCIGCBsnm+bA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rT2tM-0066OD-LT; Thu, 25 Jan 2024 17:47:52 +0100
Date: Thu, 25 Jan 2024 17:47:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v1 iwl-next] igc: Add support for LEDs on i225/i226
Message-ID: <2caec578-a268-4e82-95df-9573a52d6b7b@lunn.ch>
References: <20240124082408.49138-1-kurt@linutronix.de>
 <de659af0-807f-4176-a7c2-d8013d445f9e@lunn.ch>
 <87ede5eumt.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ede5eumt.fsf@kurt.kurt.home>

On Thu, Jan 25, 2024 at 08:31:54AM +0100, Kurt Kanzenbach wrote:
> On Wed Jan 24 2024, Andrew Lunn wrote:
> > On Wed, Jan 24, 2024 at 09:24:08AM +0100, Kurt Kanzenbach wrote:
> >> Add support for LEDs on i225/i226. The LEDs can be controlled via sysfs
> >> from user space using the netdev trigger. The LEDs are named as
> >> igc-<bus><device>-<led> to be easily identified.
> >> 
> >> Offloading activity and link speed is supported. Tested on Intel i225.
> >
> > Nice to see something not driver by phylib/DSA making use of LEDs.
> >
> > Is there no plain on/off support? Ideally we want that for software
> > blinking for when a mode is not supported.
> 
> Plain on and off is supported is supported, too. Should be possible to
> implement brightness_set().

Great.

Its actually better to first implement brightness_set(). That gives
you full support for everything the netdev trigger has. Then add
offload, which is optional, and will fall back to software for modes
which cannot be offloaded.

      Andrew

