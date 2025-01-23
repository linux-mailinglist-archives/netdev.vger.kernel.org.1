Return-Path: <netdev+bounces-160530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22488A1A12B
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 10:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6347B3AC2C2
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 09:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397FB20D4EF;
	Thu, 23 Jan 2025 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b="IkG0eniu"
X-Original-To: netdev@vger.kernel.org
Received: from lan.nucleusys.com (lan.nucleusys.com [92.247.61.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CDA20D4F6;
	Thu, 23 Jan 2025 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.247.61.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737625804; cv=none; b=jfaXnZ0nkfAvUGf5VSwP/CcLSzTYCHGHxNHRM9ElhiaKSwyWvbC+n9HxDsNfHQ+gT5nS2r98upmrH/XzcHQYnf2qRtb/CmQer76bYOJMi76JdY9ORXLeOueYx0WG6wixZNpRRDy/oGqtcAPlJ/NMVGWf/SmlXsSJcda1iCEih68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737625804; c=relaxed/simple;
	bh=Bbz0HQLEUv0H65DYzIZMwaLns+nw+QgTm9WO+iTQm5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j26nwRuUyhXEEyHeX+2VvsLFll+8096mVOXwaI+wR1E9QJ/k2gG+Od/gPqUGxbZ56wbMtljqyKJuDIXYeiHo0nmkP9zJMeSpGMSZ48wD3ClR9FqrKZPc6jnaCUbIyoTWIfpbfXbsMuJIJJAHUdKTElMTF4TQF/49HuE4Xqfurdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nucleusys.com; spf=pass smtp.mailfrom=nucleusys.com; dkim=pass (1024-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b=IkG0eniu; arc=none smtp.client-ip=92.247.61.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nucleusys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nucleusys.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=nucleusys.com; s=xyz; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+2lqGpaf1hkITIxyqiO+GCWkT51go5Y5OtXzi3ZW6UM=; b=IkG0eniuKRNGFi/c98lwnTHnW0
	qkWLnknHtFnw0L9bsO0g2Obt8xrKSUis5qrjJzM79AAxxDGw/hQ9LlzP1jF0zytMk3ccyAZEaozTQ
	FNoGNy3wcOaaj/PlnFCM3/t9QU4rey2A+Te7oCsbpyci8nKG8FkMsK94/qcaSvzISw18=;
Received: from [192.168.234.1] (helo=bender.k.g)
	by lan.nucleusys.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <petkan@nucleusys.com>)
	id 1tatq7-000Gmm-0D;
	Thu, 23 Jan 2025 11:49:31 +0200
Date: Thu, 23 Jan 2025 11:49:30 +0200
From: Petko Manolov <petkan@nucleusys.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	syzbot+d7e968426f644b567e31@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net] net: usb: rtl8150: enable basic endpoint checking
Message-ID: <20250123094930.GG4145@bender.k.g>
References: <20250122104246.29172-1-n.zhandarovich@fintech.ru>
 <20250122124359.GA9183@bender.k.g>
 <f199387d-393b-4cb4-a215-7fd073ac32b8@fintech.ru>
 <f099be8f-0ae0-49c7-b0bc-02770d9c1210@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f099be8f-0ae0-49c7-b0bc-02770d9c1210@rowland.harvard.edu>
X-Spam_score: -1.0
X-Spam_bar: -

On 25-01-22 10:59:33, Alan Stern wrote:
> On Wed, Jan 22, 2025 at 05:20:12AM -0800, Nikita Zhandarovich wrote:
> > Hi,
> > 
> > On 1/22/25 04:43, Petko Manolov wrote:
> > > On 25-01-22 02:42:46, Nikita Zhandarovich wrote:
> > >> Syzkaller reports [1] encountering a common issue of utilizing a wrong usb
> > >> endpoint type during URB submitting stage. This, in turn, triggers a warning
> > >> shown below.
> > > 
> > > If these endpoints were of the wrong type the driver simply wouldn't work.
> 
> Better not to bind at all than to bind in a non-working way.  Especially when
> we can tell by a simple check that the device isn't what the driver expects.
> 
> > > The proposed change in the patch doesn't do much in terms of fixing the
> > > issue (pipe 3 != type 1) and if usb_check_bulk_endpoints() fails, the
> > > driver will just not probe successfully.  I don't see how this is an
> > > improvement to the current situation.
> 
> It fixes the issue by preventing the driver from submitting an interrupt URB
> to a bulk endpoint or vice versa.

I always thought that once DID/VID is verified, there's no much room for that to
happen.

> > > We should either spend some time fixing the "BOGUS urb xfer, pipe 3 !=
> > > type 1" for real or not touch anything.
> > > 
> > > 
> > > 		Petko
> > > 
> > > 
> > 
> > Thank you for your answer, I had a couple thoughts though.
> > 
> > If I understand correctly (which may not be the case, of course), since the
> > driver currently does not have any sanity checks for endpoints and URBs'
> > pipes are initialized essentially by fixed constants (as is often the case),
> > once again without any testing, then a virtual, weirdly constructed device,
> > like the one made up by Syzkaller, could provide endpoints with contents
> > that may cause that exact warning.
> > 
> > Real-life devices (with appropriate eps) would still work well and are in no
> > danger, with or without the patch. And even if that warning is triggered, I
> > am not certain the consequences are that severe, maybe on kernels with
> > 'panic_on_warn' set, and that's another conversation. However, it seems that
> > the change won't hurt either. Failing probe() in such situations looks to be
> > the standard.
> > 
> > If my approach is flawed, I'd really appreciate some hints on how you would
> > address that issue and I'd like to tackle it. I'd also ask if other
> > recipients could provide some of their views on the issue, even if just to
> > prove me wrong.
> 
> I agree with this approach; it seems like the best way to address this issue.

Alright then.  I'd recommend following Fedor Pchelkin's advise about moving
those declarations to the beginning of probe(), though.


		Petko

