Return-Path: <netdev+bounces-201781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8D4AEB04A
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 09:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2A43AF8B1
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 07:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5638121C9E5;
	Fri, 27 Jun 2025 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o3jMffDz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5AA218E96;
	Fri, 27 Jun 2025 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010063; cv=none; b=UaYGNmm/p0MALpX1TCQi/CxgnoeC8qYFaxtEa60YQxCmXDRsNcFMqicmQEjUJXY6gqFAHKduExVHjHIHjwpHSWIlgHwcbddII5DF7L3uj0UC36GzQF96HdongE+C8ZjyDH4DS9vlw8VdGF99GmnK1dhuz8EAtJXiA3kZ+uFPFEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010063; c=relaxed/simple;
	bh=pQXBetwzjkrqKSNMwjSZQ9hPd/YeJp6iE27QEzNODtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlnXhfg6PO34SbD22XuQus9l0JgWxusXWT8jr1E6b0+ZbRE+iO5NsVwNqpwZKbiCPLO4n94KWFhhK6sOAN1QteXnL6gPHse0YJCt3slhllQclwXkEbqjy2CXQcds2M56Li2GsSCbBwiHdB1J/7P6MNEVxuqqcIz4ldysuUJoYmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=o3jMffDz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Dq9r4/vRJXD7oP+lQlDQUBpcgLwmf+CxKSwpwG8T7s4=; b=o3jMffDzarI7BdX3If3Hm+2wrh
	ZCMg2LLxNZFpBFmAd20Ub9V1X+Z5iD0CfA3N06eji5SQAzRWcX084dnYj54j4kbScfiP1qDZEqXOR
	imA214e/K258h+MbYmUnnq4g9xz4RDnbelf+vBPRp82YyebGsCHtV+PG4h/1/7/uMNFw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uV3hU-00H7Nw-41; Fri, 27 Jun 2025 09:40:44 +0200
Date: Fri, 27 Jun 2025 09:40:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Peter GJ. Park" <gyujoon.park@samsung.com>
Cc: 'Paolo Abeni' <pabeni@redhat.com>, 'Oliver Neukum' <oneukum@suse.com>,
	'Andrew Lunn' <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	'Eric Dumazet' <edumazet@google.com>,
	'Jakub Kicinski' <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: usb: usbnet: fix use-after-free in race on
 workqueue
Message-ID: <03658d2b-04c8-43f8-a486-33572a2e61df@lunn.ch>
References: <CGME20250627061156epcas1p1dfe3323378b314d98b660de33f50e0c2@epcas1p1.samsung.com>
 <00d001dbe72a$62281bc0$26785340$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00d001dbe72a$62281bc0$26785340$@samsung.com>

On Fri, Jun 27, 2025 at 03:11:55PM +0900, Peter GJ. Park wrote:
> >On 6/25/25 11:33 AM, Peter GJ. Park wrote:
> >> When usbnet_disconnect() queued while usbnet_probe() processing, it 
> >> results to free_netdev before kevent gets to run on workqueue, thus 
> >> workqueue does assign_work() with referencing freeed memory address.
> >> 
> >> For graceful disconnect and to prevent use-after-free of netdev 
> >> pointer, the fix adds canceling work and timer those are placed by 
> >> usbnet_probe()
> >> 
> >> Signed-off-by: Peter GJ. Park <gyujoon.park@samsung.com>
> >
> >You should include a suitable fixes tag, and you should have specified the target tree ('net' in this case) in the prefix subjext
> Prefix net added to subject, but for fixes tag, by looking git blame, the last line of usbnet_disconnect()are based on initial commit,
> thus I couldn't put the fixes tag for it. Please let me know how can I handle this.

By initial commit, do you mean:

commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 (tag: v2.6.12-rc2)
Author: Linus Torvalds <torvalds@ppc970.osdl.org>
Date:   Sat Apr 16 15:20:36 2005 -0700

    Linux-2.6.12-rc2
    
    Initial git repository build. I'm not bothering with the full history,
    even though we have it. We can create a separate "historical" git
    archive of that later if we want to, and in the meantime it's about
    3.2GB when imported into git - space that would just make the early
    git days unnecessarily complicated, when we don't have a lot of good
    infrastructure for it.
    
    Let it rip!

Then use that as the Fixes: tag. The Fixes: tag is a guide to
developers who do the backport. Nobody is going to backport this to
2.6.12, but it does make it clear that LTS 5.4.294 could get this
patch.

	Andrew

