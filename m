Return-Path: <netdev+bounces-213859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF523B272AD
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8C65E4510
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 22:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C2A27D784;
	Thu, 14 Aug 2025 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2Rmmwu7X"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7201327A906
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 22:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212125; cv=none; b=qX9U8aYStOfRG1qpl8OrLFkMcRH9QyN9imcIuqFhlxj3ErBZV+i/nrXkogADDvtwsLy/dgBj0wXgrtn5K02Upl21S1VCy7+W9mjXaFGtwANAkChnk2etdhHl91Bz4yVf/867V9zqFx14Bou5vdNogIWMmVk+yt5aAPEL8++ubyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212125; c=relaxed/simple;
	bh=GisTV7ehkAa9jgteQLA7zEpNHE68tAPBqqW6bx7ZhZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SebxaXJmjirZqv6r3JYF1D2awAvxAX4iWz9L8vhF/NOkWfyW5mUW9IovE/0VOdVxoSmfF62BImuS97KUF/0EabpSmISbsZ/eiGFwgGcYFhuidlbDzwgGPb4l/yC29Ujp39vs6dIfXaBrhD2+BhEv7GPMTJlK//zl5q3HdsM7eU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2Rmmwu7X; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WC5NbM10I9h+hCAYNWMRushta1NSR5tCIeyjdNAIyGU=; b=2Rmmwu7XflouKZToA6cATzWyQn
	DPdMME9yMaTiC0LP3GLCEbTCOEHGuYGyQiGI7TyhTBiNRIOyGjbzOtsOUpPmYYXqqqBDUyo+Mdmds
	26UuM5aeKZDw3qmqJ4u9/D3MVWwgEBtEbfmkpX0VI4AwkUW1na0HfH8RuBqBOluiAVNY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umgqq-004kwQ-Qf; Fri, 15 Aug 2025 00:55:16 +0200
Date: Fri, 15 Aug 2025 00:55:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Woojung.Huh@microchip.com, kuba@kernel.org, lukma@denx.de,
	netdev@vger.kernel.org, Tristram.Ha@microchip.com
Subject: Re: KSZ9477 HSR Offloading
Message-ID: <0501b135-8a25-4461-ad3c-9f322cdccb38@lunn.ch>
References: <42a2f96f-34cd-4d95-99d5-3b4c4af226af@kontron.de>
 <BL0PR11MB2913C7E1AE86A3A0EB12D0D7E7EE2@BL0PR11MB2913.namprd11.prod.outlook.com>
 <1400a748-0de7-4093-a549-f07617e6ac51@kontron.de>
 <BL0PR11MB29130BB177996C437F792106E7E92@BL0PR11MB2913.namprd11.prod.outlook.com>
 <20250203103113.27e3060a@wsk>
 <1edbe1e4-9491-4344-828d-4c3b73954e8a@kontron.de>
 <BL0PR11MB2913B949D05B9BB73108A5FFE7F52@BL0PR11MB2913.namprd11.prod.outlook.com>
 <20250203150418.7f244827@kernel.org>
 <BL0PR11MB2913ECAA6F0C97E342F7DE22E7F42@BL0PR11MB2913.namprd11.prod.outlook.com>
 <8e761c31-728c-4ff7-925a-5e16a9ef1310@kontron.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e761c31-728c-4ff7-925a-5e16a9ef1310@kontron.de>

On Wed, Aug 13, 2025 at 03:43:14PM +0200, Frieder Schrempf wrote:
> Am 04.02.25 um 15:55 schrieb Woojung.Huh@microchip.com:
> > Hi Jakub,
> > 
> >> -----Original Message-----
> >> From: Jakub Kicinski <kuba@kernel.org>
> >> Sent: Monday, February 3, 2025 6:04 PM
> >> To: Woojung Huh - C21699 <Woojung.Huh@microchip.com>
> >> Cc: frieder.schrempf@kontron.de; lukma@denx.de; andrew@lunn.ch;
> >> netdev@vger.kernel.org; Tristram Ha - C24268 <Tristram.Ha@microchip.com>
> >> Subject: Re: KSZ9477 HSR Offloading
> >>
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know the
> >> content is safe
> >>
> >> On Mon, 3 Feb 2025 14:58:12 +0000 Woojung.Huh@microchip.com wrote:
> >>> Hi Lukasz & Frieder,
> >>>
> >>> Oops! My bad. I confused that Lukasz was filed a case originally. Monday
> >> brain-freeze. :(
> >>>
> >>> Yes, it is not a public link and per-user case. So, only Frieder can see
> >> it.
> >>> It may be able for you when Frieder adds you as a team. (Not tested
> >> personally though)
> >>
> >> Woojung Huh, please make sure the mailing list is informed about
> >> the outcomes. Taking discussion off list to a closed ticketing
> >> system is against community rules. See below, thanks.
> >>
> >> Quoting documentation:
> >>
> >>   Open development
> >>   ----------------
> >>
> >>   Discussions about user reported issues, and development of new code
> >>   should be conducted in a manner typical for the larger subsystem.
> >>   It is common for development within a single company to be conducted
> >>   behind closed doors. However, development and discussions initiated
> >>   by community members must not be redirected from public to closed forums
> >>   or to private email conversations. Reasonable exceptions to this guidance
> >>   include discussions about security related issues.
> >>
> >> See: https://www.kernel.org/doc/html/next/maintainer/feature-and-driver-maintainers.html#open-development
> > 
> > Learn new thing today. Didn't know this. Definitely I will share it
> > when this work is done. My intention was for easier work for request than
> The HW forwarding between HSR ports is configured in ksz9477_hsr_join()
> at the time of creating the HSR interface by calling
> ksz9477_cfg_port_member().
> 
> In my case I enabled the ports **after** that which caused the
> forwarding to be disabled again as ksz9477_cfg_port_member() gets called
> with the default configuration.
> 
> If I reorder my commands everything seems to work fine even with
> NETIF_F_HW_HSR_FWD enabled.
> 
> I wonder if the kernel should handle this case and prevent the
> forwarding configuration to be disabled if HSR is configured? I'll have
> a look if I can come up with a patch for this.

If you don't offload it, but do it in software, does the order matter?

As a user, i should not need to care if offload is used or not. It
should be transparent. Which means any order that works with pure
software should also work with offloading. At least, it should not
break. If it fails to offload, and uses software, that is fine. Not
optimal, but O.K.

	Andrew


