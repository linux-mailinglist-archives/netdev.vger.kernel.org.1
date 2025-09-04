Return-Path: <netdev+bounces-220085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E35B44647
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 159537BA9B2
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 19:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ABF26B2A5;
	Thu,  4 Sep 2025 19:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GTF0aUK0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E6E33997;
	Thu,  4 Sep 2025 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757013512; cv=none; b=JZFR1OKtkxapvDhUEdfqR08AmAJxYsTKtmlpnKwr6a+dh4c2+l//xCdKrVaF7eV38wUr+XF6icEf16i1vq7JrvjhjVht1qrgTmOqV/uq6hAepvzCcK1UgugaHKJMoLRuNXXAZzozgbci89xiBE7vLH+fAOxkykQfcZXMoO1Zmu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757013512; c=relaxed/simple;
	bh=E6qkdjA0Y+1D5PC07L7AvfjLrlIwmg0gVautHyMx4io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSvOMxMYYTkcuX6uSPyXNphj2xxTWOKVYuM7y4wy7+zwEU/Oj2qAf2xitBUpqFwwIMw/qNaf0aVPB4y4OadMgRAZ4NrG4cm90+9lXZhT4w8MUYQ+FLs29OiZu/vux/NtxJNpT8U2NCQHrH9xM/atMUMeGWTxIn/U0i2Oa2z7kgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GTF0aUK0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BJSx1g8Qr7Wz2LzAGWRRSblVeUqjF70Pxr0Xq74vkrs=; b=GTF0aUK0j94E9fK21JLE7tIF7g
	32qAQ22driPh/XOnMOOEAEqa4Ak4/EDqXZ/jl1NvfZ6lA5FhoimjXPq+0//Jojvkx7hNsIOTEuEds
	n0tkp7hV/hrafSI824g5rzgdLg2G1tRYjUp8AsQ9ClGr1g6qdivICrKOK76IRaat9eFs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uuFTU-007GEZ-SO; Thu, 04 Sep 2025 21:18:24 +0200
Date: Thu, 4 Sep 2025 21:18:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sebastian Basierski <sebastian.basierski@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Konrad Leszczynski <konrad.leszczynski@intel.com>,
	davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, cezary.rojewski@intel.com
Subject: Re: [PATCH net 1/3] net: stmmac: replace memcpy with strscpy in
 ethtool
Message-ID: <f6cac0bd-3a07-40c3-b07b-f1c7f3b27f45@lunn.ch>
References: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
 <20250828100237.4076570-2-konrad.leszczynski@intel.com>
 <20250901125943.243efb74@kernel.org>
 <b7a23bef-71d1-47e6-ab20-d8a86fa3e431@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7a23bef-71d1-47e6-ab20-d8a86fa3e431@intel.com>

On Thu, Sep 04, 2025 at 08:53:03PM +0200, Sebastian Basierski wrote:
> 
> On 9/1/2025 9:59 PM, Jakub Kicinski wrote:
> > On Thu, 28 Aug 2025 12:02:35 +0200 Konrad Leszczynski wrote:
> > > Fix kernel exception by replacing memcpy with strscpy when used with
> > > safety feature strings in ethtool logic.
> > > 
> > > [  +0.000023] BUG: KASAN: global-out-of-bounds in stmmac_get_strings+0x17d/0x520 [stmmac]
> > > [  +0.000115] Read of size 32 at addr ffffffffc0cfab20 by task ethtool/2571
> > If you hit this with upstream code please mention which string
> > is not padded. If this can't happen with upstream platforms --
> > there is no upstream bug. BTW ethtool_puts() is a better choice.
> Hi Jakub,
> Sorry for late answer to your review.
> I double checked and made sure this bug reproduces on upstream platform.
> Bug seems to appear on first string - i will add this information to commit
> message.

By first string, do you mean "Application Transmit Interface Parity
Check Error"?

I think it also would be better to change dwmac5_error_desc, so that
it uses char stat_string[ETH_GSTRING_LEN] __nonstring; like
stmmac_stats.

     Andrew

