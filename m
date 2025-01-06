Return-Path: <netdev+bounces-155489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25431A027F5
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 15:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 875B17A056D
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E511DE4D6;
	Mon,  6 Jan 2025 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oR2vR8qP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E996E1DE3AB
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736173631; cv=none; b=Ew+ljpwMtsBl3WnQi11L8Xu3WHxkQ4TSCO+cGUcMsTxI9fzOzTBFigoAFNF30nAPZ2SnZoef4SeQVfkc3JYbuxAQ0O/t+uLdfZXPP/gYbPlAh/sWiE/eA/Rv0SA6by8qXF0Om3TiBEp92G6NQNj97EaqljRNbCBUjXIcJnN+Q+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736173631; c=relaxed/simple;
	bh=bcOA4q6oTHILzcadakk6Y3TFI0CLTSqk4B4zs/oHkhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeL1Ue1DJpGYfppB5MwgfHNixcseLLPM/LT+nG4J3Xl0mvvogYgigokciivSPR4/VW5vhaiwg1k0a2ldehp5c+cQ6jcDuoxqCVagCOoh6bJyFf55U0N+7QHqH31c9yO3b6qSsWtna7uJoCK+lv+5hSbGA0rdfJVO0Fs4gfictBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oR2vR8qP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SVJPOasPEHYdMgHvjtl/MCKDVna4dXKt4mK8KlvSjPY=; b=oR2vR8qPKF+bn6xYiOU0WCafqt
	SqOzhnbCPrTRZ4iJz2clw/j/Ve4FUfsYXiUQriN8YuBwFjNfc+TtjYbPMkDTC7IfZBeITHixyMk/J
	gx8OE8KMEBc3bnc3n4SSixJ/o32uMMRTNNvIfm9qm/GCs4D54R6Ymy/9snbmiUvP0I+Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUo4F-001to5-1w; Mon, 06 Jan 2025 15:26:55 +0100
Date: Mon, 6 Jan 2025 15:26:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
	linux@armlinux.org.uk, horms@kernel.org, jacob.e.keller@intel.com,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 1/4] net: wangxun: Add support for PTP clock
Message-ID: <a4576efa-2d20-47e9-b785-66dbfda78633@lunn.ch>
References: <20250102103026.1982137-1-jiawenwu@trustnetic.com>
 <20250102103026.1982137-2-jiawenwu@trustnetic.com>
 <ab140807-2e49-4782-a58c-2b8d60da5556@lunn.ch>
 <032b01db600e$8d845430$a88cfc90$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <032b01db600e$8d845430$a88cfc90$@trustnetic.com>

> > > +	smp_mb(); /* Force any pending update before accessing. */
> > > +	incval = READ_ONCE(wx->base_incval);
> > > +	incval = adjust_by_scaled_ppm(incval, ppb);
> > > +
> > > +	mask = (wx->mac.type == wx_mac_em) ? 0x7FFFFFF : 0xFFFFFF;
> > > +	if (incval > mask)
> > > +		dev_warn(&wx->pdev->dev,
> > > +			 "PTP ppb adjusted SYSTIME rate overflowed!\n");
> > 
> > There is no return here, you just keep going. What happens if there is
> > an overflow?
> 
> If there is an overflow, the calibration value of this second will be
> inaccurate. But it does not affect the calibration value of the next
> second. And this rarely happens.

If this is a onetime event you don't really care about, is a
dev_warn() justified? Do you want to be handling the user questions
about what it means, when all you are going to say is, ignore it, it
does not really matter?

> > > +/**
> > > + * wx_ptp_tx_hwtstamp_work
> > > + * @work: pointer to the work struct
> > > + *
> > > + * This work item polls TSYNCTXCTL valid bit to determine when a Tx hardware
> > > + * timestamp has been taken for the current skb. It is necessary, because the
> > > + * descriptor's "done" bit does not correlate with the timestamp event.
> > > + */
> > 
> > Are you saying the "done" bit can be set, but the timestamp is not yet
> > in place? I've not read the whole patch, but do you start polling once
> > "done" is set, or as soon at the skbuff is queues for transmission?
> 
> The descriptor's "done" bit cannot be used as a basis for Tx hardware
> timestamp. So we should poll the valid bit in the register.

You did not answer my question. When do you start polling?

	Andrew

