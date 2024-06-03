Return-Path: <netdev+bounces-100082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6A88D7C9E
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480C31F2119B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 07:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586F6481A7;
	Mon,  3 Jun 2024 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXfBP6n5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B347A4C;
	Mon,  3 Jun 2024 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717400427; cv=none; b=aKOBQLUZNbExBGutYADJuDK8GAUJEu5e87lUkHSWw1iFo9Wg3OjR4nDHJExNO05nJBcQ5+HyyabH137B4U0YXy9CL2Q0fhvgFXU+tWl5GLqUyEczQ1F3o0iehXyP8VwNkfXufK/lgdY7edI2lJeci3bAJQTjU1XJdVsA3z4wuIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717400427; c=relaxed/simple;
	bh=9rBCxnNOqL19PhtN8Ev8Pt2LG9neDHVmcXIvCefgzec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIQCJGspaGmERF6neT83kJFfPTuCsnPQy0EkeP+KRF0wYkCJ8ukopmOO2CTNr/yTOPENbfG3/raLH6dOeNWUOYimRbT+JM6Xj+5LalwvxWFepnUdgu7kRqa142vBlVrkTZOd8I5fUrcrbcSfqJR5ni/EF9tV5mLnPHbJPZWH9l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXfBP6n5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C910BC2BD10;
	Mon,  3 Jun 2024 07:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717400426;
	bh=9rBCxnNOqL19PhtN8Ev8Pt2LG9neDHVmcXIvCefgzec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UXfBP6n5YKpnpIqXq39RpLHYgCW8Niq2bWdBki6s5CTiKVZD1bPk6+fey8Yt4aMHQ
	 lZDmH78vbZcqpbais3P2jbWcihAnjRHR4eaqY29qdxyOP15U9NDtRRz98zhjKRQiaU
	 SNDgP44uoxEtngXnnT88fTiJECnUTJewvTc8Y/sYlSUhu0FCXUlDHXCTCWuO34DfFQ
	 p8nZctkihrFLHTOtXdYd7w7FGAyRoaq7DnkNL32j53mTpFemI45EsUtRgMPWa+5RCM
	 HGeeTJSaKewpr+NfxU+Q7Zxo9t/hN0keqQVn9+Ue6N4pE4lwufaiX5mrf5c/eNGlQo
	 xeVDNkLrn6fNQ==
Date: Mon, 3 Jun 2024 08:40:21 +0100
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Tristram.Ha@microchip.com, Woojung.Huh@microchip.com, andrew@lunn.ch,
	vivien.didelot@gmail.com, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: fix initial port flush problem
Message-ID: <20240603074021.GV491852@kernel.org>
References: <1716932145-3486-1-git-send-email-Tristram.Ha@microchip.com>
 <20240531190234.GT491852@kernel.org>
 <BYAPR11MB35583B3BA16BFB2F78615DBBECFC2@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20240601120545.GG491852@kernel.org>
 <20240602140118.nnlvydm4dp6wr4c3@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602140118.nnlvydm4dp6wr4c3@skbuf>

On Sun, Jun 02, 2024 at 05:01:18PM +0300, Vladimir Oltean wrote:
> On Sat, Jun 01, 2024 at 01:05:45PM +0100, Simon Horman wrote:
> > On Fri, May 31, 2024 at 07:19:54PM +0000, Tristram.Ha@microchip.com wrote:
> > > > Subject: Re: [PATCH net] net: dsa: microchip: fix initial port flush problem
> > > > 
> > > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content
> > > > is safe
> > > > 
> > > > On Tue, May 28, 2024 at 02:35:45PM -0700, Tristram.Ha@microchip.com wrote:
> > > > > From: Tristram Ha <tristram.ha@microchip.com>
> > > > >
> > > > > The very first flush in any port will flush all learned addresses in all
> > > > > ports.  This can be observed by unplugging a cable from one port while
> > > > > additional ports are connected and dumping the fdb entries.
> > > > >
> > > > > This problem is caused by the initially wrong value programmed to the
> > > > > register.  After the first flush the value is reset back to the normal so
> > > > > the next port flush will not cause such problem again.
> > > > 
> > > > Hi Tristram,
> > > > 
> > > > I think it would be worth spelling out why it is correct to:
> > > > 1. Not set SW_FLUSH_STP_TABLE or SW_FLUSH_MSTP_TABLE; and
> > > > 2. Preserve the value of the other bits of REG_SW_LUE_CTRL_1
> > > 
> > > Setting SW_FLUSH_STP_TABLE and SW_FLUSH_MSTP_TABLE bits are wrong as they
> > > are action bits.  The bit should be set only when doing an action like
> > > flushing.
> > 
> > Understood, thanks. And I guess that only bits that are being configured
> > should be changed, thus the values other bits are preserved with this
> > change.
> > 
> > FWIIW, I do think it would be worth adding something about this to the
> > patch description.
> 
> I agree the description is confusing and I had to look it up in the
> datasheet to understand.
> 
> I would suggest something along the lines of:
> 
> Setting the SW_FLUSH_STP_TABLE | SW_FLUSH_MSTP_TABLE bits of
> REG_SW_LUE_CTRL_1 does not do anything right away. They are
> just one-shot modifiers of the upcoming flush action executed by
> ksz9477_flush_dyn_mac_table().
> 
> It is wrong to set these bits at ksz9477_reset_switch() time, because
> it makes ksz9477_flush_dyn_mac_table() have an unexpected and incorrect
> behavior during its first run. When DSA calls ksz_port_fast_age() on a
> single port for the first time, due to this modifier being set, the
> entire FDB will be flushed of dynamically learned entries, across all
> ports.
> 
> Additionally, there is another mistake in the original code, which is
> that the value read from the REG_SW_LUE_CTRL_1 is immediately discarded,
> rather than preserved. The relevant bit which is set by default in this
> register (but we are mistakenly clearing) is:
> 
> Bit 3: Multicast Source Address Filtering
> 1 = Forward packets with a multicast source address
> 0 = Drop packets with a multicast source address

Thanks, that makes things a lot clearer to me.

> Tristram, now a question to you: why would we want to forward packets
> with a multicast source address? It looks like clearing that field is
> one of those things which were accidentally correct.
> 
> The cleanest way to not make a functional change where none is intended
> is to simply delete the read.

FWIIW, I thought about that too. But I was concerned that perhaps the read
has a side effect, because I don't know the hw well enough to say otherwise.

