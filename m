Return-Path: <netdev+bounces-187475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3AEAA74CC
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 16:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DBBB4A749C
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 14:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9998254B02;
	Fri,  2 May 2025 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pqVPbcIe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078EE143748
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746195729; cv=none; b=LxW1nxdGXYdlOCjikZFUdC6j8JSInvePXAq2p4HrVrYB1wBmfLKNW5fya2rbrJs70ce2YHh1zrfpBUhdntWlIoG7fHORCcp2mCiJaEToBpDl8oSWSm9qj3Vqs5a3FxOvnbTNbOtNJOrelAvM44RsNZXXHzcPcnYeK1PonY17TE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746195729; c=relaxed/simple;
	bh=EAHm9t6HjjLg8iFoggH95dH5t7ttjmO+8b+hXVHfi1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kngYWIMYiiLGzrLbILo6Vr7wEtee/j3yKgn8TTzDROafbK7EaWMBdX5kIjZ+a/vWL3geX5ij2rS56sNKxJpq3nNcqB0XRsbRMex9W9+JJfadJbzIQI+3odhQWQ5fmG1wPi60LD89FJEQ2feA9UO+xMttkwTi10jX7puUKwVI23s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pqVPbcIe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DrOKSNb903gtJ6eRZ393p9uIVav58eaxgb6olet9+DE=; b=pqVPbcIePC7h1toyBujFV4JZvn
	seCXBKYiYwmFssa0MLgMDu5A+kxNMUYTDFaN/lO6ccR5KecjI7tcEQ9xYHw3Sjc0abFHWvm9vN49I
	sfnNcAucibL9sx7Bu/6fr3UNMg5aMZkcTy/RI3EADR5EvRw8vE4SpvsiOpLkSRUC77HA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uArH1-00BQUY-AH; Fri, 02 May 2025 16:21:55 +0200
Date: Fri, 2 May 2025 16:21:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Howells <dhowells@redhat.com>
Cc: David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, willy@infradead.org,
	netdev@vger.kernel.org, linux-mm@kvack.org
Subject: Re: MSG_ZEROCOPY and the O_DIRECT vs fork() race
Message-ID: <165f5d5b-34f2-40de-b0ec-8c1ca36babe8@lunn.ch>
References: <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch>
 <1015189.1746187621@warthog.procyon.org.uk>
 <1021352.1746193306@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1021352.1746193306@warthog.procyon.org.uk>

On Fri, May 02, 2025 at 02:41:46PM +0100, David Howells wrote:
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > > I'm looking into making the sendmsg() code properly handle the 'DIO vs
> > > fork' issue (where pages need pinning rather than refs taken) and also
> > > getting rid of the taking of refs entirely as the page refcount is going
> > > to go away in the relatively near future.
> > 
> > Sorry, new to this conversation, and i don't know what you mean by DIO
> > vs fork.
> 
> As I understand it, there's a race between O_DIRECT I/O and fork whereby if
> you, say, start a DIO read operation on a page and then fork, the target page
> gets attached to child and a copy made for the parent (because the refcount is
> elevated by the I/O) - and so only the child sees the result.  This is made
> more interesting by such as AIO where the parent gets the completion
> notification, but not the data.
> 
> Further, a DIO write is then alterable by the child if the DMA has not yet
> happened.
> 
> One of the things mm/gup.c does is to work around this issue...  However, I
> don't think that MSG_ZEROCOPY handles this - and so zerocopy sendmsg is, I
> think, subject to the same race.

For zerocopy, you probably should be talking to Eric Dumazet, David Wei.

I don't know too much about this, but from the Ethernet drivers
perspective, i _think_ it has no idea about zero copy. It is just
passed a skbuf containing data, nothing special about it. Once the
interface says it is on the wire, the driver tells the netdev core it
has finished with the skbuf.

So, i guess your question about CRC is to do with CoW? If the driver
does not touch the data, just DMA it out, the page could be shared
between the processes. If it needs to modify it, put CRCs into the
packet, that write means the page cannot be shared? If you have
scatter/gather you can place the headers in kernel memory and do
writes to set the CRCs without touching the userspace data. I don't
know, but i suspect this is how it is done. There is also an skbuf
operation to linearize a packet, which will allocate a new skbuf big
enough to contain the whole packet in a single segment, and do a
memcpy of the fragments. Not what you want for zerocopy, but if your
interface does not have the needed support, there is not much choice.

	Andrew

