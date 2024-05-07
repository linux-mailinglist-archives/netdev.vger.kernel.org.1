Return-Path: <netdev+bounces-94094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20BF8BE1BA
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30151C2205F
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101D9156F29;
	Tue,  7 May 2024 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="40n4po0E"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1464152526;
	Tue,  7 May 2024 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715083845; cv=none; b=PDYpE6vu7CpNpa42U9q31ANsQAb2FOFTuOqNrKE1Ev2vDKBU/cP7grbstv3UT6UGN6JZxVZyeElaSbrLdVAhiwnYOGhB1uZ8peWReH9FGqLWtU9weISQnsyAh4UudqRmj3Fl1Sxn6SRCPD9PeWYNTvUkuqG80tjQFG0Ragcm+kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715083845; c=relaxed/simple;
	bh=tublsAzoZaaFYx04mUfEDLIKGmGslI/8CMgIfUHP7yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnFkGNyl9GfEgTWZx08tWhV3G+QBy04wET8H+iiTXquYA0PAihk/9g+sRKtva9nSeG1m5olf3uJHHZpe3eW5fhueeDC4Ny7H5+9xbr/gfosRIZCFq+9JVMwRjNTa0xa1Hes3j/nrWqBR4ueZRJ5uceJLJLH0sq3YYvEvvBLtwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=40n4po0E; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h3Y7Sox6qKI0Ql5CybfO/mRydkNB4HCT/gEUdZDGA7U=; b=40n4po0EwrBVuqnjs4CXcD2ksD
	bZMt21lN+nkQVwytBhW77WkseWqZm91klqL7HdQXGNlCHZ6KWlLX/M7Q5zA264agdt5Yf5Je27IuH
	d4SWfsrYl1n99WISFXI1h1u69W5G1Vx48LNqfvmjDkt0AxlFJfYgM38qCOhbolJO07H8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s4JeN-00Eqkc-L8; Tue, 07 May 2024 14:10:27 +0200
Date: Tue, 7 May 2024 14:10:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: En-Wei WU <en-wei.wu@canonical.com>
Cc: jesse.brandeburg@intel.co, anthony.l.nguyen@intel.com,
	intel-wired-lan@lists.osuosl.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	rickywu0421@gmail.com
Subject: Re: [PATCH] e1000e: fix link fluctuations problem
Message-ID: <aad721c1-93c4-48bd-9f05-00c4f6301dce@lunn.ch>
References: <20240502091215.13068-1-en-wei.wu@canonical.com>
 <f47e0bb6-fb3f-4d0e-923a-cdb5469b6cbe@lunn.ch>
 <CAMqyJG0kMFShx8Kir17mNZ1rD7SaBt2f_Wpv4ir+5-92v3bNaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMqyJG0kMFShx8Kir17mNZ1rD7SaBt2f_Wpv4ir+5-92v3bNaA@mail.gmail.com>

On Tue, May 07, 2024 at 11:24:05AM +0200, En-Wei WU wrote:
> > Why PHY is this?
> It's the Intel I219-LM, and I haven't found any other device having
> the same issue.

There is no Linux PHY driver for this device, only the code buried in
the e1000e MAC driver. Sometimes Intel use Marvell PHYs, and there are
a couple of work arounds in the Marvell PHY driver, which might of
given you a clue. But not in this case...

      Andrew

