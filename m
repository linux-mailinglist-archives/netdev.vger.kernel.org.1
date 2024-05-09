Return-Path: <netdev+bounces-94939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F7D8C109B
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E2E281050
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512F915AAD7;
	Thu,  9 May 2024 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="P76YhQQO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6484D14BF90;
	Thu,  9 May 2024 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262410; cv=none; b=j+9ub/l4SriSkFhIhB+b2RyUqXbSl5HuZJ7dzAh0dzLSKrg3PEhm1DTa2+fHiC4PjwkuvCCMxt9URWt6FY6Y/losOqA2JEzx6WleIlE5uBBc3LKkM9NqQ5kHA0z9aWEcEU1FTPHehl/rcTARqjcWwms7awxUWGAVZvET5urvEZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262410; c=relaxed/simple;
	bh=xy8kcljUAkFYDCfCaS3YEVtTX/bOxT7/iskKt8E9/2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIQd5Nlgjtb6uFuQyAyQcdu5aymKnJ3Av6z0FhpOgOLXZw3DsEwqPAKdP9W2U2dWbsy/SZ+A7GjgrPkZb8/Mc4ZBoRNL6+ApzRQxxIn4duvd+Q/kJE4tEWDI1En5TNfeH5En1hwerPn3KRqAY6PB3182ftg+YmzGhPrPuEuLk58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=P76YhQQO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Q0tElm7XwG+N39f631ELOtsvWEr/mDeKYXIa4/jl3ww=; b=P7
	6YhQQOBsBpy/f8ypdPm5r5D2m+pnFqFVx3gYeC38JAaGlYmD/lJuiwk3+JepsXqSHvc5WUVnlRW4U
	Sm6lUp0Ncysy0jNEdrkUDDUPXcFlW2zNkbApAfTmMKpfTgrvssJ4A5WM+IHDrUhVU1+SlSqr+rlP2
	/XvjQgIc/NfGydQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s546c-00F35j-B4; Thu, 09 May 2024 15:46:42 +0200
Date: Thu, 9 May 2024 15:46:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
Cc: Sasha Neftin <sasha.neftin@intel.com>,
	Ricky Wu <en-wei.wu@canonical.com>, netdev@vger.kernel.org,
	rickywu0421@gmail.com, linux-kernel@vger.kernel.org,
	edumazet@google.com, intel-wired-lan@lists.osuosl.org,
	kuba@kernel.org, anthony.l.nguyen@intel.com, pabeni@redhat.com,
	davem@davemloft.net, "Lifshits, Vitaly" <vitaly.lifshits@intel.com>,
	"naamax.meir" <naamax.meir@linux.intel.com>,
	"Avivi, Amir" <amir.avivi@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH v2 2/2] e1000e: fix link fluctuations
 problem
Message-ID: <cc58ecfc-53f1-4154-bc38-e73964a59e16@lunn.ch>
References: <20240503101836.32755-1-en-wei.wu@canonical.com>
 <83a2c15e-12ef-4a33-a1f1-8801acb78724@lunn.ch>
 <514e990b-50c6-419b-96f2-09c3d04a2fda@intel.com>
 <334396b5-0acc-43f7-b046-30bcdab1b6fb@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <334396b5-0acc-43f7-b046-30bcdab1b6fb@intel.com>

On Thu, May 09, 2024 at 12:13:27PM +0300, Ruinskiy, Dima wrote:
> On 08/05/2024 8:05, Sasha Neftin wrote:
> > On 07/05/2024 15:31, Andrew Lunn wrote:
> > > On Fri, May 03, 2024 at 06:18:36PM +0800, Ricky Wu wrote:
> > > > As described in https://bugzilla.kernel.org/show_bug.cgi?id=218642,
> > > > Intel I219-LM reports link up -> link down -> link up after hot-plugging
> > > > the Ethernet cable.
> > > 
> > > Please could you quote some parts of 802.3 which state this is a
> > > problem. How is this breaking the standard.
> > > 
> > >     Andrew
> > 
> > In I219-* parts used LSI PHY. This PHY is compliant with the 802.3 IEEE
> > standard if I recall correctly. Auto-negotiation and link establishment
> > are processed following the IEEE standard and could vary from platform
> > to platform but are not violent to the IEEE standard.
> > 
> > En-Wei, My recommendation is not to accept these patches. If you think
> > there is a HW/PHY problem - open a ticket on Intel PAE.
> > 
> > Sasha
> 
> I concur. I am wary of changing the behavior of some driver fundamentals, to
> satisfy a particular validation/certification flow, if there is no real
> functionality problem. It can open a big Pandora box.
> 
> Checking the Bugzilla report again, I am not sure we understand the issue
> fully:
> 
> [  143.141006] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 1000 Mbps Half
> Duplex, Flow Control: None
> [  143.144878] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Down
> [  146.838980] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 1000 Mbps Full
> Duplex, Flow Control: None
> 
> This looks like a very quick link "flap", following by proper link
> establishment ~3.7 seconds later. These ~3.7 seconds are in line of what
> link auto-negotiation would take (auto-negotiation is the default mode for
> this driver).

That actually seems slow. It is normally a little over 1 second. I
forget the exact number. But is the PHY being polled once a second,
rather than being interrupt driven?

> The first print (1000 Mbps Half Duplex) actually makes no
> sense - it cannot be real link status since 1000/Half is not a supported
> speed.

It would be interesting to see what the link partner sees. What does
it think the I219-LM is advertising? Is it advertising 1000BaseT_Half?
But why would auto-neg resolve to that if 1000BaseT_Full is available?

> So it seems to me that actually the first "link up" is an
> incorrect/incomplete/premature reading, not the "link down".

Agreed. Root cause this, which looks like a real problem, rather than
apply a band-aid for a test system.

      Andrew

