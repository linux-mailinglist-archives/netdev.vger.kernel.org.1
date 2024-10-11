Return-Path: <netdev+bounces-134547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD9E99A086
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 11:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5226B25962
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 09:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C20420FAA4;
	Fri, 11 Oct 2024 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8GyoRfR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AE320C497
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640528; cv=none; b=sqDi4dqTBSgA+gIew+R22697NBRK/STViBn3BxCIJeGU6562Lvg3DqSVCAyXsf+iRxNMhcBmF2jokU+QXXycZ0HIPaRSt61Zr0uOaODELfz8lYzaXNvuLbqhErSJl+i9hz+TLoYeQapS6R+TFpR+XCsRJ5t9cqBHhpXj0yDnpUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640528; c=relaxed/simple;
	bh=Hhsc/6vfZZzCx7r2Yk6BPq7a8poQ9ed8Zsq5qiJ1W1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9HGcl4ZYRdfSbkzuUsEnNXzXID11t5BrbHwN4AXDqpGqhqarSP1b6ApH8YhnxiBIZ0ITHIHwiuJFR0hH9Dv6qTb/aZennZMVA0dGhvf6aFZr0fyskYqARBQHPrRtpQ0f4TFUz/v13DFcFvf/B00buAX8QIV/p/M5NfDLnxr/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8GyoRfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE20EC4CEC3;
	Fri, 11 Oct 2024 09:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728640526;
	bh=Hhsc/6vfZZzCx7r2Yk6BPq7a8poQ9ed8Zsq5qiJ1W1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8GyoRfRKaAXNGGjC2w0hd4rY7eSkA/ZS+YYqXfL5dchzajs9QBUXr/MZix2qM8D0
	 l2Icda5peRiqp18Fqoh1N4vwMtORQDhNFzqY647y5dMyrL93adwVrF0Eq3KeoKL9ka
	 TCU4lga3sIkVSZNasrhVw/X7PZ1bCxOVqqyNQ2NSa55S7m3I4YGcK7BYZFbZdqQDl7
	 IpJh7BWaska3Vjy+0bTwczvr17MVg6grqdIwe3DZ6z/nU5WkT2GiFGtYEo5PYZOfnS
	 sU44ROQEK9V43n3KPBp6yxUzTRUxjL12m67EEvoMRXZGfH6mLv3bNyp+nC9Em6ONC9
	 QxoUL2exHKgoA==
Date: Fri, 11 Oct 2024 10:55:22 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2] r8169: use the extended tally counter
 available from RTL8125
Message-ID: <20241011095522.GE66815@kernel.org>
References: <43b100c5-9d53-46eb-bee0-940ab948722a@gmail.com>
 <30edd5d2-13aa-409f-9b12-f0c775c81f02@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30edd5d2-13aa-409f-9b12-f0c775c81f02@gmail.com>

On Thu, Oct 10, 2024 at 10:08:02PM +0200, Heiner Kallweit wrote:
> On 10.10.2024 12:50, Heiner Kallweit wrote:
> > The new hw stat fields partially duplicate existing fields, but with a
> > larger field size now. Use these new fields to reduce the risk of
> > overflows. In addition add support for relevant new fields which are
> > available from RTL8125 only.
> > 
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

...

> > @@ -1873,13 +1888,33 @@ static void rtl8169_get_ethtool_stats(struct net_device *dev,
> >  	data[10] = le32_to_cpu(counters->rx_multicast);
> >  	data[11] = le16_to_cpu(counters->tx_aborted);
> >  	data[12] = le16_to_cpu(counters->tx_underrun);
> > +
> > +	if (rtl_is_8125(tp)) {
> > +		data[5] = le32_to_cpu(counters->align_errors32);
> > +		data[10] = le64_to_cpu(counters->rx_multicast64);
> > +		data[11] = le32_to_cpu(counters->tx_aborted32);
> > +		data[12] = le32_to_cpu(counters->tx_underrun32);
> > +
> > +		data[13] = le64_to_cpu(counters->tx_octets);
> > +		data[14] = le64_to_cpu(counters->rx_octets);
> > +		data[15] = le32_to_cpu(counters->tx_pause_on);
> > +		data[16] = le32_to_cpu(counters->tx_pause_off);
> > +		data[17] = le32_to_cpu(counters->rx_pause_on);
> > +		data[18] = le32_to_cpu(counters->rx_pause_off);
> > +	}
> >  }
> >  
> >  static void rtl8169_get_strings(struct net_device *dev, u32 stringset, u8 *data)
> >  {
> >  	switch(stringset) {
> >  	case ETH_SS_STATS:
> > +		struct rtl8169_private *tp = netdev_priv(dev);
> 
> patchwork lists the following warning for a clang build:
> warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
> 
> gcc 14.2.1 however had no problem with this code, and also checkpatch didn't
> complain. Is this code acceptable or should it be changed?

Yes, I see that too.
My feeling is that it would be best to change it as it
seems likely that this will break compilation somewhere.

