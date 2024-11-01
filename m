Return-Path: <netdev+bounces-141087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5311F9B9701
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 19:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11351F21EF2
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 18:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113A21CDFC0;
	Fri,  1 Nov 2024 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EfLy5/pw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E04E70827
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484074; cv=none; b=FdAIVVz+NEsfX5i4mC6fl0h51mVIXzCuxAvN7GNULuP2xfaoWV9R/aua8nr9ffoznmy+jbbw6XkE6J8O3WFAJWJ8Tn1DsIgFekemZXmnhS60La3KRa/0V/Wu8XQh0zWXKxg//7cmnEwkE92vhxAn1wHKLOqtcNGnNUjynueTgpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484074; c=relaxed/simple;
	bh=qqnTKZRqAxCyB8ZFlKqQj0C1hW529zLtRSkN1NNProI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBy8Sry8D+54r/KqPUwm1V0bWFBkhOAhhVsPQi5qeh+wi2VU4bWjAbLnU7va+AHMCKwV1hvwfejRdI++MHb3fAFdugf9XvCIpu+xnUjCz370UwzUboWGzw9HAzZLz/7A35gjTps6cojzaLqWNrGTMrC5NYmXTOqccHn3sB5rimc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EfLy5/pw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=RISPNTOFerIjtkAjX8mpanbl+WNN/SF3I42jVFplOnc=; b=Ef
	Ly5/pwFj1myY4Hy91SpRfXT7c72PcEscoRltXd3tkPN65Yh3vL9eMrMmNXO/dIuYTkGF6DmBSqogD
	+duezLO7PPT5eZ16YHBIftsMq+nEVzcw4cCbw+xRgwPBRKDdAP1XMPapIPtSviJwQaAdPNktouhY7
	yc+qbkmFrTxaP20=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t6vxN-00BuPO-RP; Fri, 01 Nov 2024 19:01:09 +0100
Date: Fri, 1 Nov 2024 19:01:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 01/12] net: homa: define user-visible API for
 Homa
Message-ID: <fc86b958-3e31-42f6-a174-3ea7c7fc3377@lunn.ch>
References: <20241028213541.1529-1-ouster@cs.stanford.edu>
 <20241028213541.1529-2-ouster@cs.stanford.edu>
 <6a2ef1b2-b4d4-41c5-9a70-42f9b0e4e29a@lunn.ch>
 <CAGXJAmwSCeuwy6HXpzZgp8m+5v=NPCOTgKc-8LBjUuY079+h0w@mail.gmail.com>
 <ce06867d-2311-466e-924f-ffa6fa6d49c9@lunn.ch>
 <CAGXJAmzuKXyfiercDz-Hxf6J1xoNV=5Bv9cz1Y4HSrBY5vPviQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXJAmzuKXyfiercDz-Hxf6J1xoNV=5Bv9cz1Y4HSrBY5vPviQ@mail.gmail.com>

On Fri, Nov 01, 2024 at 10:47:20AM -0700, John Ousterhout wrote:
> On Wed, Oct 30, 2024 at 5:41 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > > Did you build for 32 bit systems?
> > >
> > > Sadly no: my development system doesn't currently have any
> > > cross-compiling versions of gcc :-(
> >
> > I'm not sure in this case it is actually a cross compile. Your default
> > amd64 tool chain should also be able to compile for i386.
> >
> > export ARCH=i386
> > unset CROSS_COMPILE
> > make defconfig
> > make
> 
> Thanks for this additional information. I have now compiled Homa
> (along with the rest of the kernel) for ARCH=i386; in the process I
> learned about uintptr_t and do_div.
> 

> Question: is the distinction between the types u64 and __u64
> significant? If so, is there someplace where it is explained when I
> should use each? So far I have been using __u64 (almost) everywhere.

/include/uapi/asm-generic/int-ll64.h says:

/*
 * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
 * header files exported to user space
 */

So for files you export to userspace, anything in include/uapi, you
should be using __u64. In the kernel, i think it does not matter, and
i did find:

typedef __u64 u64;

so they probably end up identical. u64 seems more popular in net/ than
__u64, probably because it is shorter.

	Andrew

