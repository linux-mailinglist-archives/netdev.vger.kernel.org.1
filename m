Return-Path: <netdev+bounces-217849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A6BB3A259
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873F21BA7662
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C843164A0;
	Thu, 28 Aug 2025 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="P3cOTUCL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B98C31577E;
	Thu, 28 Aug 2025 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392040; cv=none; b=H80V3fMx9+gQ+qEOTDsd1edM194NO/tTNLvRzPjLNg9zTUuBTb5dcud9tO30MG583+WqCcHKz19jwHCbSPGOPOhQ4sLmxyqB8REOfOo2vtZ2hLyA6wZG2dRdX32XBYnnNdzoEgagfADErihUqKMDrpl+znaUJfJN2jpq+s8aL+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392040; c=relaxed/simple;
	bh=OLobiXBTOeSXIdDGmigux9oQ+nOXSn75Hgan6goFKRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQSK2XoGJNyQOtqVQy1rEjXiRNe4LIj5Rvu5XGWjS1lv4M5Uqd4pbbMP0mAdV3WHcRB+GhF32KgTrB5hWiRSNRkgcPyb5T6v8uVD5QHUX4h8fgIUV/tgG0sMcJ0G0+RXm6uXkr5yLwED/1QzBb5aK8IMI12qHFKxKQNGRy5Unv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=P3cOTUCL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OkJSjBQkpzvCE2tbQ1dm8RXzSWK1JHhxP8rGruwDo50=; b=P3cOTUCLwGmfxup/pDv21l773w
	lyxcKpVxxLZJp2gMgneNphDByhNmixMjqyqiVQqerjglanSVPfaxvMgFGPNVdvPan3HrqiGpaOlj5
	zWI4YZUy9Az4fEidW1c2oQcHlj81o90dXj+snxXwcSzMMq2zFbpx7bw80JC9elg/RPIE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1urdna-006MJS-V7; Thu, 28 Aug 2025 16:40:22 +0200
Date: Thu, 28 Aug 2025 16:40:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Konrad Leszczynski <konrad.leszczynski@intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, davem@davemloft.net,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, cezary.rojewski@intel.com,
	sebastian.basierski@intel.com
Subject: Re: [PATCH net-next 0/7] net: stmmac: fixes and new features
Message-ID: <b91f62a3-e34e-4881-bf7f-4e5cd299e77c@lunn.ch>
References: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
 <e4cb25cb-2016-4bab-9cc2-333ea9ae9d3a@linux.dev>
 <9e86a642-629d-42e9-9b70-33ea5e04343a@intel.com>
 <f77cb80c-d4b2-4742-96cb-db01fbd96e0e@lunn.ch>
 <240b5f17-30cd-42f4-9dcd-4d5b60aa7bec@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <240b5f17-30cd-42f4-9dcd-4d5b60aa7bec@intel.com>

On Thu, Aug 28, 2025 at 02:51:51PM +0200, Konrad Leszczynski wrote:
> 
> On 28-Aug-25 14:25, Andrew Lunn wrote:
> > On Thu, Aug 28, 2025 at 08:47:02AM +0200, Konrad Leszczynski wrote:
> > > On 26-Aug-25 19:29, Vadim Fedorenko wrote:
> > > > On 26/08/2025 12:32, Konrad Leszczynski wrote:
> > > > > This series starts with three fixes addressing KASAN panic on ethtool
> > > > > usage, Enhanced Descriptor printing and flow stop on TC block setup when
> > > > > interface down.
> > > > > Everything that follows adds new features such as ARP Offload support,
> > > > > VLAN protocol detection and TC flower filter support.
> > > > Well, mixing fixes and features in one patchset is not a great idea.
> > > > Fixes patches should have Fixes: tags and go to -net tree while features
> > > > should go to net-next. It's better to split series into 2 and provide
> > > > proper tags for the "fixes" part
> > > Hi Vadim,
> > > 
> > > Thanks for the review. I've specifically placed the fixes first and the
> > > features afterwards to not intertwine the patches. I can split them into two
> > > patchsets if you think that's the best way to go.
> > https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> > 
> > You probably need to wait a week between the fixes and new features in
> > order that net and net-next are synced.
> > 
> >      Andrew
> > 
> > ---
> > pw-bot: cr
> > 	
> 
> Hi Andrew. Thanks for the heads-up. Fixes are new features are independent
> from each other. Should I still wait a week to send out the patchset
> containing the new features?

What you want to avoid is causing the netdev Maintainers to resolve
merge conflicts when net-next and net are merged. By waiting a week,
you get to resolve such conflicts.

    Andrew

