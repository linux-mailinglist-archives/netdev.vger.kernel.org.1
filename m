Return-Path: <netdev+bounces-102503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118FB90363A
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 10:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215451C24753
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 08:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A4917333C;
	Tue, 11 Jun 2024 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="et2xVbPX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEE6152178
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094342; cv=none; b=VqBE3rzDZGzDlSnfH/qlYN08wvoonbr7I3FbqBptY+7RXU7SVXoaeVqnteLFVyLbbj10ybkmZNKf1k6DIvAhbYtY4/i4JOBs4DoAdnGf/Nx3Qfn31zhgDnR4TMZPhJNTUUaN54h/ERL3AQD3MMc8c+T4mcveG14EBFOYv37rVo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094342; c=relaxed/simple;
	bh=DyfZMNqfbelowjKg7Fg2Zw3jpBlT2GRYPwzy3WhZrVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aheiwcax0JEYeR07xRRqBXnP/w8cdCsL6Nfmv4ZR2P4UdBIAzd845Bw+OKJAKWxPT/W2dcyCC/w07jITPDKDVltylvM9l98VsSpLBYlpdO/2C8Qb6WcC/mrxJuB/BPnbkHHkdoPU8cUnXis1YK0Tuz/7d4jKeyRO7aomBGEFYVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=et2xVbPX; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vz1mH1BnxzmBh;
	Tue, 11 Jun 2024 10:19:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1718093951;
	bh=7HhB4sE7NSHxAQDCrk3KUOzkf7diWu3HyUqm9CqHvEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=et2xVbPXxCumQmIsI+DjulepJsWh1kePvzlLTh4VmveVuXji/VJMRwDKZ3SrExvKX
	 gB5KaN1tbWKEs1gfnEsT9+mhjcY6BXpSapxm/IjeqIl+fslwsbZvLtl1qjnOZWtbhT
	 dU9ltWH1xnmMN0+1OKYI+k090IpP/lU8XYhZ66o4=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Vz1mF6P1kzqRS;
	Tue, 11 Jun 2024 10:19:09 +0200 (CEST)
Date: Tue, 11 Jun 2024 10:19:06 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jann Horn <jannh@google.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, outreachy@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v3] landlock: Add abstract unix socket connect restriction
Message-ID: <20240611.Eed0Oochaht4@digikod.net>
References: <ZmJJ7lZdQuQop7e5@tahera-OptiPlex-5000>
 <ZmLEoBfHyUR3nKAV@google.com>
 <ZmNic8S1KtyLcp7i@tahera-OptiPlex-5000>
 <20240610.Aifee5ingugh@digikod.net>
 <CAG48ez3MBGi6i9Xcj29+pD9Lo1_hKkEtWYn-jNqvOZ_WWQZjYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3MBGi6i9Xcj29+pD9Lo1_hKkEtWYn-jNqvOZ_WWQZjYA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Jun 10, 2024 at 11:49:21PM +0200, Jann Horn wrote:
> On Mon, Jun 10, 2024 at 6:36 PM Mickaël Salaün <mic@digikod.net> wrote:
> > On Fri, Jun 07, 2024 at 01:41:39PM -0600, Tahera Fahimi wrote:
> > > On Fri, Jun 07, 2024 at 10:28:35AM +0200, Günther Noack wrote:
> > > > Is it intentional that you are both restricting the connection and the sending
> > > > with the same flag (security_unix_may_send)?  If an existing Unix Domain Socket
> > > > gets passed in to a program from the outside (e.g. as stdout), shouldn't it
> > > > still be possible that the program enables a Landlock policy and then still
> > > > writes to it?  (Does that work?  Am I mis-reading the patch?)
> >
> > If a passed socket is already connected, then a write/send should work.
> 
> If I'm reading unix_dgram_sendmsg() correctly, we'll always hit
> security_unix_may_send() for any UNIX socket type other than
> SOCK_SEQPACKET (meaning SOCK_STREAM and SOCK_DGRAM), even if the
> socket is already connected, and then we'll do the landlock check.
> That's probably not the intended behavior for Landlock, unless I'm
> misreading the code?
> 
> Maybe to get nice semantics it's necessary to add a parameter to
> security_unix_may_send() that says whether the destination address
> came from the caller or from the socket?

I think it would make sense to ignore connected sockets with
security_unix_may_send() because it should already be controlled by
security_unix_stream_connect().  This would still allow passed/inherited
connected sockets to be used, which is an important feature and would
be consistent with read/write on other passed FDs.  This would not work
with dgram sockets though.

We need tests for this case and with different socket modes (inspired by
the net_test.c:protocol variants).

