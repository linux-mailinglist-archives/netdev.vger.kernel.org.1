Return-Path: <netdev+bounces-155854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7128CA040E6
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3F13A2500
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D030F1F03FB;
	Tue,  7 Jan 2025 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CSir7Tds"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBDD1E50B
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736256805; cv=none; b=srsATbBNOnjvc2YXKymVT9Jr3/q+xwcA16zHUV59OirwYWeiHLsXCUbHP9fWxnHAzB480PPCOBX1macrdp2V6JA8iDEvq9Z9sB9qoAHCbM0f/XDRsvyjON2E+uy8Miz9pxIbn+s5tXkmgfY1MKiYpck28iSPlfCsY8crpMhtRJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736256805; c=relaxed/simple;
	bh=dJ/A/Av9KxO7AOM7CsIZLu2q/yG9EUlQDS8twSyQwEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+LcMPW5QisdkzpdAlNo0TeZn3ijv8QPY5tgdr9vFKtnYE/9IIUGwCSvQhrm69oHUWV1gRTl4kMuA3HXC39qfB6sdf829CXAiOPJfvA6+Sbs3NFLoswtpElHN3ZBo8r02qcjGXbm9K7B6mC7BwZMLm5IM7LjkE+y1jQmSdnA9Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CSir7Tds; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T4ouNsigPKwb6ZlkVJKOSYIrT90WTunIqlva7EBz5nM=; b=CSir7TdsPOWGUI9cV+DgRO7eY4
	xVzQfm4iHQEdr6sD31r3U8/4oyD14nGqKkcO0bcmnvNfP0wPf6L3oruHm8plIi3kYWhjJLGbjvnYo
	qiEcT92ouPXIOmOhEAxc/xnMgmB438K0ZL0VH43Mctx9XqRqSHFsUF/7ZdxpjW3JCaKA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tV9hm-002F0Q-2Z; Tue, 07 Jan 2025 14:33:10 +0100
Date: Tue, 7 Jan 2025 14:33:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
	linux@armlinux.org.uk, horms@kernel.org, jacob.e.keller@intel.com,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 1/4] net: wangxun: Add support for PTP clock
Message-ID: <2212dd13-1a02-4f67-a211-adde1ce58dc7@lunn.ch>
References: <20250102103026.1982137-1-jiawenwu@trustnetic.com>
 <20250102103026.1982137-2-jiawenwu@trustnetic.com>
 <ab140807-2e49-4782-a58c-2b8d60da5556@lunn.ch>
 <032b01db600e$8d845430$a88cfc90$@trustnetic.com>
 <a4576efa-2d20-47e9-b785-66dbfda78633@lunn.ch>
 <035001db60ab$4707cfd0$d5176f70$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <035001db60ab$4707cfd0$d5176f70$@trustnetic.com>

> > > > > +/**
> > > > > + * wx_ptp_tx_hwtstamp_work
> > > > > + * @work: pointer to the work struct
> > > > > + *
> > > > > + * This work item polls TSYNCTXCTL valid bit to determine when a Tx hardware
> > > > > + * timestamp has been taken for the current skb. It is necessary, because the
> > > > > + * descriptor's "done" bit does not correlate with the timestamp event.
> > > > > + */
> > > >
> > > > Are you saying the "done" bit can be set, but the timestamp is not yet
> > > > in place? I've not read the whole patch, but do you start polling once
> > > > "done" is set, or as soon at the skbuff is queues for transmission?
> > >
> > > The descriptor's "done" bit cannot be used as a basis for Tx hardware
> > > timestamp. So we should poll the valid bit in the register.
> > 
> > You did not answer my question. When do you start polling?
> 
> As soon at the skbuff is queues for transmission.
 
I assume polling is not for free? Is it possible to start polling once
'done' is set? Maybe do some benchmarks and see if that saves you some
cycles?

	Andrew
 

