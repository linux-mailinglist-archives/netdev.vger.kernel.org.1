Return-Path: <netdev+bounces-156399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF98DA06476
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 19:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980EE167061
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 18:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5D51FFC67;
	Wed,  8 Jan 2025 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="veW61YbS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E9719AD8C
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361140; cv=none; b=bXvCCfu6r75Xc3xiJcEFzJ3sNsxW+jUM1+V7nkTdWkiNOskY6Hpb07ewl/wIHWPkz/9aLmlzlLaHuTuYaohyxR4wobtAJ8wUmR1ZmNGglslgHjpKGTmL1elovN7dau9V5/FqLNXiBIn15OVFgg54rwSNy2Yt6jkYjULph6fbaT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361140; c=relaxed/simple;
	bh=fAdtzuzm52ZFXxSPoDnJF2WXzkkqx7PPzpNmp6rpGLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcGhOzmgHomuzWuSyMkRvMS2XGmMBzmtx0BZ1rT8aH6BFoQKF6pArzzemon2mDkrvH27j4qHGuetxN3uNTduFwLRMk7dbKj3mVBWxyXeW3o/TxejqrL2dMt0oJMnCgRhdqxLA2UfvLmgH5a113XT/HfVsXPO36L9OilUuBbe7Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=veW61YbS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5TwTwhXXQn6xITvKBL5qsooOQoVilGX7IxFigvfDwM4=; b=veW61YbSYkI94Zr4kwPaXnyz+K
	GGGqH0PZgj8iS89bfvZXPdaKK87Ydfr8H25P558lJwAm/K/Dufpr4Su9acCeVWrgdfaA9Aq7B01uD
	FMPXm3sOFD85ExWm16zcK8ByRTVcI+s7436zLnXueZsx4LDkOGaEmzRzdALC3RO4Wc2k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVaqX-002eeR-AC; Wed, 08 Jan 2025 19:32:01 +0100
Date: Wed, 8 Jan 2025 19:32:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: "'Keller, Jacob E'" <jacob.e.keller@intel.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
	horms@kernel.org, netdev@vger.kernel.org, mengyuanlou@net-swift.com,
	'linglingzhang' <linglingzhang@net-swift.com>
Subject: Re: [PATCH net-next 1/4] net: wangxun: Add support for PTP clock
Message-ID: <70504065-9d1e-4305-b798-992d608dd449@lunn.ch>
References: <20250102103026.1982137-1-jiawenwu@trustnetic.com>
 <20250102103026.1982137-2-jiawenwu@trustnetic.com>
 <ab140807-2e49-4782-a58c-2b8d60da5556@lunn.ch>
 <032b01db600e$8d845430$a88cfc90$@trustnetic.com>
 <a4576efa-2d20-47e9-b785-66dbfda78633@lunn.ch>
 <035001db60ab$4707cfd0$d5176f70$@trustnetic.com>
 <2212dd13-1a02-4f67-a211-adde1ce58dc7@lunn.ch>
 <CO1PR11MB50894A28220E758BACAADDFBD6122@CO1PR11MB5089.namprd11.prod.outlook.com>
 <03e101db619e$9d11d440$d7357cc0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03e101db619e$9d11d440$d7357cc0$@trustnetic.com>

On Wed, Jan 08, 2025 at 03:26:20PM +0800, Jiawen Wu wrote:
> > > > > > > > +/**
> > > > > > > > + * wx_ptp_tx_hwtstamp_work
> > > > > > > > + * @work: pointer to the work struct
> > > > > > > > + *
> > > > > > > > + * This work item polls TSYNCTXCTL valid bit to determine when a Tx
> > > hardware
> > > > > > > > + * timestamp has been taken for the current skb. It is necessary,
> > > because the
> > > > > > > > + * descriptor's "done" bit does not correlate with the timestamp event.
> > > > > > > > + */
> > > > > > >
> > > > > > > Are you saying the "done" bit can be set, but the timestamp is not yet
> > > > > > > in place? I've not read the whole patch, but do you start polling once
> > > > > > > "done" is set, or as soon at the skbuff is queues for transmission?
> > > > > >
> > > > > > The descriptor's "done" bit cannot be used as a basis for Tx hardware
> > > > > > timestamp. So we should poll the valid bit in the register.
> > > > >
> > > > > You did not answer my question. When do you start polling?
> > > >
> > > > As soon at the skbuff is queues for transmission.
> > >
> > > I assume polling is not for free? Is it possible to start polling once
> > > 'done' is set? Maybe do some benchmarks and see if that saves you some
> > > cycles?
> > >
> > > 	Andrew
> > >
> > 
> > Agreed, I would try to benchmark that. Timestamps need to be returned
> > relatively quickly, which means the polling rate needs to be high. This costs a lot
> > of CPU, and so any mechanism that lets you start later will help the CPU cost.
> 
> May not. We should notify the stack as soon as we get Tx hardware timestamp.
> But descriptor's "done" bit may hasn't been set yet.

Lets see if i understand this correctly....

"done" means the full packet is on the wire, and so the descriptor
status bits have their final meaning, so the host can read them, and
then reuse the descriptor?

The TX timestamp is however added earlier to the descriptor? Maybe
after the Ethernet header is on the wire? So it could be ~1400 bytes
at line speed before 'done' is set? So 'done' is too late?

But then i have to wounder how many descriptors you have? If you only
have one descriptor, then 1400 bytes could be significant. If there
are 100 packets in the queue waiting to be sent, 1400 bytes is
insignificant. For real world traffic, does polling make a difference?

	Andrew

