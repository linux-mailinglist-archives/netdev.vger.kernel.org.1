Return-Path: <netdev+bounces-136838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 076599A3307
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07CF285475
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EEC156C6C;
	Fri, 18 Oct 2024 02:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1CusC679"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87AD2BAEF
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729219968; cv=none; b=rlI+mjaviPeipG63Why55GzDiKbjLXm3N1zNvcSEAjmbTuLQ/mpzo/VSfENpqloF8uJ6h/aJjjTWB08wUlFqwe52xbNSUGgmI/ELsXsUPmn6qH8EGOEy+C91HHNjFBtibLWtdcS3SHACrlWP3alUxzhJ7rIaZxicjQpKRqYW3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729219968; c=relaxed/simple;
	bh=S1+TsVk+b3t1bozZiO6CzPnhv4m9zxOXlunXPVyEudc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUjPDKjrn8YdVP3cmrTRUpcz5bkJipaTghVE/EDc3qo7narZ5PlfYQ/+vSvtu8jHLmTPr+o2rE2oEHuOq+ib69lNHpXyNzlddF05sZkgAd9Uh7GMQqJaHI63s1tTpp7I++HXP0wtXd5+jlIhzcWJhbMbKSadGIfHgu64SHy/I1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1CusC679; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VEtcBZk8ngH3D9Ymuqwt5gJajBCC5VghBSP0Y7iVUeU=; b=1CusC679B24dj/qu2lSaVeh7ST
	dlhYP8zbViBiZr7T+9VVorBApBK5Fj+k5MAxIlSvE+qp4yIoAsiVjOB5rTA/NsGoOJZyOXzl4zuEu
	4z7ZmZmUsYPg0Daftu/fQqK0gQ8ZurgYZGbMZaim4SAscA47wPLxHOl1pAUdOT/cqzow=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t1d6Q-00AJf8-Pb; Fri, 18 Oct 2024 04:52:34 +0200
Date: Fri, 18 Oct 2024 04:52:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Pengyu Ma <mapengyu@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] r8169: avoid unsolicited interrupts
Message-ID: <83fc1742-5cd6-4e67-a96d-62d5ec88dfb7@lunn.ch>
References: <b8e7df14-d95e-4aab-b0e3-3b90ae0d3c21@gmail.com>
 <e34dad2c-7920-4024-9497-f4f9aea4a93f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e34dad2c-7920-4024-9497-f4f9aea4a93f@gmail.com>

On Thu, Oct 17, 2024 at 11:22:20PM +0200, Heiner Kallweit wrote:
> On 17.10.2024 08:05, Heiner Kallweit wrote:
> > It was reported that after resume from suspend a PCI error is logged
> > and connectivity is broken. Error message is:
> > PCI error (cmd = 0x0407, status_errs = 0x0000)
> > The message seems to be a red herring as none of the error bits is set,
> > and the PCI command register value also is normal. Exception handling
> > for a PCI error includes a chip reset what apparently brakes connectivity
> > here. The interrupt status bit triggering the PCI error handling isn't
> > actually used on PCIe chip versions, so it's not clear why this bit is
> > set by the chip.
> > Fix this by ignoring interrupt status bits which aren't part of the
> > interrupt mask.
> > Note that RxFIFOOver needs a special handling on certain chip versions,
> > it's handling isn't changed with this patch.
> > 
> > Fixes: 0e4851502f84 ("r8169: merge with version 8.001.00 of Realtek's r8168 driver")
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219388
> > Tested-by: Pengyu Ma <mapengyu@gmail.com>
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > ---
> 
> When doing some unrelated performance tests I found that this patch breaks
> connectivity under heavy load. Please drop it.
> I'll investigate and come up with an alternative way to fix the reported issue.

You should be able to mark your own patches are change request etc.

    Andrew

---
pw-bot: cr

