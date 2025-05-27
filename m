Return-Path: <netdev+bounces-193736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FB9AC5A66
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 21:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5D11BC1FAD
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 19:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9091027FD6B;
	Tue, 27 May 2025 19:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="klIkLsPn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3703156CA
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748372914; cv=none; b=myPkjbMqIQy0jzGOoLsuouVNXNvkrvVWyar8EQgW/Y+axTANcAoVJUj2W53WVmADzfB5GeXxtyoa6Eg0t4+cxy4+4HnO+pwN531WT1/oEnDJ1gTyn2KZO3Bil7kBCdKm9B6eLVGyPe68bwDVOTkiGeWJ7cH4MRTvVqcqnI1kICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748372914; c=relaxed/simple;
	bh=Q1NtiwnXc4dXs3n8cucbFyPA9v3/qOLJ5K2prsvpsVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxIHXuHkKe7VMtQquqcglK7LklmVQ+k5Laffk5p19u6ljo279Lfl3biu2BLH2OAlTWa1foxVIPGGes5SX+i/eLVkoddOng8rmoLY/GIQEb+IAWcXXi+Mu5PXYLNhH55EOUQ1NFiOtc52C5vix/mCZl1dB1La/44XaNqK6tVnhH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=klIkLsPn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fiJgyd5gBqHjmm6dknwmFEGQpP38lpC+iDh6Ag/SGI0=; b=klIkLsPnTOKE54NetAw/5zKWIo
	IsX5pqZkt6lA5Nt80+Q4DQ6ljRo4H0E8tVDyTWOoig46MEo+KLwqyU5kXWtcrbOVgIo4RaDtjeTfE
	l9ZMRO43eemnoUoO7S2I707zPoItlyWjc86s3/eKfQHfTiF3aHDLFywCcRUah8Pxk1qQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uJzev-00E6MJ-Uc; Tue, 27 May 2025 21:08:21 +0200
Date: Tue, 27 May 2025 21:08:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ricard Bejarano <ricard@bejarano.io>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	netdev@vger.kernel.org, michael.jamet@intel.com,
	YehezkelShB@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: Poor thunderbolt-net interface performance when bridged
Message-ID: <09f73d4d-efa3-479d-96b5-fd51d8687a21@lunn.ch>
References: <20250526092220.GO88033@black.fi.intel.com>
 <4930C763-C75F-430A-B26C-60451E629B09@bejarano.io>
 <f2ca37ef-e5d0-4f3e-9299-0f1fc541fd03@lunn.ch>
 <29E840A2-D4DB-4A49-88FE-F97303952638@bejarano.io>
 <9a5f7f4c-268f-4c7c-b033-d25afc76f81c@lunn.ch>
 <63FE081D-44C9-47EC-BEDF-2965C023C43E@bejarano.io>
 <0b6cf76d-e64d-4a35-b006-20946e67da6e@lunn.ch>
 <8672A9A1-6B32-4F81-8DFA-4122A057C9BE@bejarano.io>
 <c1ac6822-a890-45cd-b710-38f9c7114272@lunn.ch>
 <38B49EF9-4A56-4004-91CF-5A2D591E202D@bejarano.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38B49EF9-4A56-4004-91CF-5A2D591E202D@bejarano.io>

> Then set up iperf3 and tcpdump, but kernel panics:
> 
> May 27 18:30:32 blue kernel: skbuff: skb_over_panic: text:ffffffffc0c1b9e7 len:1545195755 put:1545195755 head:ffff9c9dcc652000 data:ffff9c9dcc65200c tail:0x5c19d0f7 end:0x1ec0 dev:<NULL>

O.K. It could be the description does not actually contain any data,
just the flag indicating bad things happened.

So, another idea, just to see if skb with frags are an
issue. Somewhere need the beginning of tbnet_start_xmit() add:

	if (skb_is_nonlinear(skb))
       		skb = skb_linearize(skb);

That should convert an skb with fragments to a skb without
fragments. It will be bad for performance, so if it does work it is
not a fix, but it will confirm we are in the right area.

    Andrew

