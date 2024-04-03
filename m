Return-Path: <netdev+bounces-84634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C35897A82
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 23:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7ED1F236F4
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 21:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6B7156664;
	Wed,  3 Apr 2024 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R1kTZzlb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7CA2BB02
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 21:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179040; cv=none; b=fSXlzOd+0SjE5NYTSO8204H388EwX2VnFcLyiWkvRT8q0s7T0IJqbJFS8SX7sklEAHpbzmyA8vnewZzUjtRU7ESxZcDT26jBL4fyj9fI/o3Riq+7krWVzgiz4l0z/usDRKTx03zlaeX/f71Lnq81n4Caw9UYtmMPlNwkMhBxak8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179040; c=relaxed/simple;
	bh=13n8Vj2JpXmk8lvMEpfTAnHa7Ppq4qucolVUR1xLFnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAJSoV1CroI3QVZw8I+alWS3TBGau4UVElVALpp22f0k389j+vhEmPMXb6AaMI97iNxWz2M8ckdWV52eDNDNcgoY4572MllM9bjMAlpFP/i8IRuU1gaTp6lr+8xQhp2m9/HBYMHxNfqJft3oF4ThpsdKqF4Z8hClY8hDhR1rFuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R1kTZzlb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=JqbnLhQrjGQoV+XnhRTu7tv0RSgFD0H9E4Cq+hNRKrI=; b=R1
	kTZzlb1WDxrWsqlaPYNo3Jfe9PXwdMdpuCpKOB7CfZWP7ryOI6oEEBsU+qRs8Q3lcQQRGKFqrLRSH
	cES4SoBApWNm4ggHd9+L/fkJUHoqxvzvGbJjjuxu/mOm09Bs2/lxRHEaa7uuAAGc6iLvodTkrU959
	3NGf+aWj0ed8Nsk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rs7yt-00C7Hj-O6; Wed, 03 Apr 2024 23:17:15 +0200
Date: Wed, 3 Apr 2024 23:17:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 02/15] eth: fbnic: add scaffolding for Meta's
 NIC driver
Message-ID: <19c2a4be-428f-4fc6-b344-704f314aee95@lunn.ch>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217491384.1598374.15535514527169847181.stgit@ahduyck-xeon-server.home.arpa>
 <7b4e73da-6dd7-4240-9e87-157832986dc0@lunn.ch>
 <CAKgT0UeBva+gCVHbqS2DL-0dUMSmq883cE6C1JqnehgCUUDBTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UeBva+gCVHbqS2DL-0dUMSmq883cE6C1JqnehgCUUDBTQ@mail.gmail.com>

On Wed, Apr 03, 2024 at 01:47:18PM -0700, Alexander Duyck wrote:
> On Wed, Apr 3, 2024 at 1:33 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > + * fbnic_init_module - Driver Registration Routine
> > > + *
> > > + * The first routine called when the driver is loaded.  All it does is
> > > + * register with the PCI subsystem.
> > > + **/
> > > +static int __init fbnic_init_module(void)
> > > +{
> > > +     int err;
> > > +
> > > +     pr_info(DRV_SUMMARY " (%s)", fbnic_driver.name);
> >
> > Please don't spam the kernel log like this. Drivers should only report
> > when something goes wrong.
> >
> >      Andrew
> 
> Really?

I think if you look around, GregKH has said this.

lsmod | wc
    167     585    6814

Do i really want my kernel log spammed with 167 'Hello world'
messages?

> I have always used something like this to determine that the
> driver isn't there when a user complains that the driver didn't load
> on a given device. It isn't as though it would be super spammy as this
> is something that is normally only run once when the module is loaded
> during early boot, and there isn't a good way to say the module isn't
> loaded if the driver itself isn't there.

lsmod

	Andrew

