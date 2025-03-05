Return-Path: <netdev+bounces-172174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE51DA507F0
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 19:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7A4169D00
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 18:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B743C24C07D;
	Wed,  5 Mar 2025 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xxgr9JR3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E53314B075;
	Wed,  5 Mar 2025 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197725; cv=none; b=ebHmx80TVjuaXEyr+5oFww3/TdKBdGES/rGlJJKTuVSMOAcBRrMveKlXgli7ejBaYXrwUkn2ucanpHkJKNWVequrZ48C9qAb3PYH1cPDfuC00cxOhBGv9y/TZvxYF4ShJGNXCtCGzt1bGdRsEmQXyXx1769Ge6qtIobzwLCm+Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197725; c=relaxed/simple;
	bh=H8X/rbddfoXk+B+Ss5wXZbqRMEFAeXjuauUmhgb2EUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/ybL6wSkLDQCPZir1kmffcxXS1tK28fDa2fRkc1GmSebR1O7/y7bkFK6y0RkPAWL3pjoV+yzjdayxU0mvIeW9trRHRqqW7g2Tt0rOUpg9APzYL+TyOuilyN9HqMsWqCaf0kw6LkwLTciCSOM6v+PCGFzJQtRsVMiql0Wen7E74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Xxgr9JR3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=talyWretgQjIWUP+Ebdm16KqFAKvyAHhwVwnzdoNc4Q=; b=Xxgr9JR3sAQSIEBgp+OuOx5sGW
	JJvnu6sq7cByIBbMhkRj3SVUnGmxaXy896PzUEWRJYyeVDYx6N/ht8Lmnd4US0unk7hwUxYDEiDlE
	UDA6vVOFVbIurF7PGOwMyLAE8sSADRYHhGSmaoS1S2E+0KkE4S4hS9Xg6ND7ykTXEHdE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tpt3y-002YQA-Mp; Wed, 05 Mar 2025 19:01:46 +0100
Date: Wed, 5 Mar 2025 19:01:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joseph Huang <joseph.huang.2024@gmail.com>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Verify after ATU Load ops
Message-ID: <d3175821-1d1a-4ca3-b9ba-5e33eac08da2@lunn.ch>
References: <20250304235352.3259613-1-Joseph.Huang@garmin.com>
 <2ea7cde2-2aa1-4ef4-a3ea-9991c1928d68@lunn.ch>
 <669d9f33-e861-482a-8fd1-849fc3d22cd2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <669d9f33-e861-482a-8fd1-849fc3d22cd2@gmail.com>

On Wed, Mar 05, 2025 at 12:44:54PM -0500, Joseph Huang wrote:
> On 3/5/2025 10:14 AM, Andrew Lunn wrote:
> > On Tue, Mar 04, 2025 at 06:53:51PM -0500, Joseph Huang wrote:
> > > ATU Load operations could fail silently if there's not enough space
> > > on the device to hold the new entry.
> > > 
> > > Do a Read-After-Write verification after each fdb/mdb add operation
> > > to make sure that the operation was really successful, and return
> > > -ENOSPC otherwise.
> > 
> > Please could you add a description of what the user sees when the ATU
> > is full. What makes this a bug which needs fixing? I would of thought
> > at least for unicast addresses, the switch has no entry for the
> > destination, so sends the packet to the CPU. The CPU will then
> > software bridge it out the correct port. Reporting ENOSPC will not
> > change that.
> 
> Hi Andrew,
> 
> What the user will see when the ATU table is full depends on the unknown
> flood setting. If a user has unknown multicast flood disabled, what the user
> will see is that multicast packets are dropped when the ATU table is full.
> In other words, IGMP snooping is broken when the ATU Load operation fails
> silently.

Please add this to the commit message. This describes the real problem
being fixed, which is what somebody reading the commit message wants
to know.

   Andrew

