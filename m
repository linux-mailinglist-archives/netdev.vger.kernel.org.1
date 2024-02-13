Return-Path: <netdev+bounces-71336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C030685302A
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C99028B12C
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2C238DD5;
	Tue, 13 Feb 2024 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NA68nSvv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF973D968
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 12:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825922; cv=none; b=dfwgtS57XfbLKXROmiaBzDjJZsFXUq0XYMOTIl7bSkN5OYZGCnEXulX/Sv/k8vdxqtoszFPianS1gRYWMLfduR2LneX3A0AojdZBOm/n3xL7O/x3ZXbExDea5Gy2mXiMuz3rQCUcIXfc0m9KVsrMoAsVYeBG02+pOGOlr5pVIXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825922; c=relaxed/simple;
	bh=vxOXIvtPM7t9fv6ZFqJPHdQX0Z8/uP4BPIkLK048QMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkZEeovv37EhdAFStdkZtY0RlyVe6T+XXziinXGCQr2zJdGCq1osvJN2OQksD/jAJYABINadZMGU/oNuF+RvZ/cwP8ksofuGWuUid82ZQTZdWkj903b3/uepArqzMYHKP/HOau00nt4Rte1m+OrCtxiycRG+HZJ8vvyoK7pfLNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NA68nSvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BC6C433C7;
	Tue, 13 Feb 2024 12:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707825922;
	bh=vxOXIvtPM7t9fv6ZFqJPHdQX0Z8/uP4BPIkLK048QMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NA68nSvvvzpbUoBp7MR7s3+y67Afj/cbdAj4nMv994LAmHlc6Ask00nkJwwP56xg8
	 AYc2Vis4lOshq+Ob09NGjaaIjgVG35/nzC78eHQjbJKbyeuMCOjlkcCPtwFqp5ijkV
	 bIXNcdak2rdhkA9fsMiMPEuFXoZ2i8N7pey9ObLE=
Date: Tue, 13 Feb 2024 13:05:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Max Schulze <max.schulze@online.de>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	tdeseyn@redhat.com
Subject: Re: [PATCH v2 net] tcp: allow again tcp_disconnect() when threads
 are waiting
Message-ID: <2024021349-presume-prance-d230@gregkh>
References: <f3b95e47e3dbed840960548aebaa8d954372db41.1697008693.git.pabeni@redhat.com>
 <169724162482.10042.15716452478916528903.git-patchwork-notify@kernel.org>
 <71ec8c74-270e-41f6-b336-0198b16dd697@online.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71ec8c74-270e-41f6-b336-0198b16dd697@online.de>

On Tue, Feb 13, 2024 at 12:54:03PM +0100, Max Schulze wrote:
> 
> 
> Am 14.10.23 um 02:00 schrieb patchwork-bot+netdevbpf@kernel.org:
> > Hello:
> >
> > This patch was applied to netdev/net.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
> >
> > On Wed, 11 Oct 2023 09:20:55 +0200 you wrote:
> >> As reported by Tom, .NET and applications build on top of it rely
> >> on connect(AF_UNSPEC) to async cancel pending I/O operations on TCP
> >> socket.
> >>
> >> The blamed commit below caused a regression, as such cancellation
> >> can now fail.
> >>
> >> [...]
> 
> 
> Hello authors, Gregkh,
> 
> it looks to me like the breaking commit
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/net/ipv4/tcp.c?h=linux-4.19.y&id=0377416ce1744c03584df3e9461d4b881356d608
> 
> 
> was applied to stable, but not the fix?
> 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/net/ipv4/tcp.c?id=419ce133ab928ab5efd7b50b2ef36ddfd4eadbd2
> 
> Could you consider applying the fix for 4.19 also?

I would love to, but the commit does not apply.  Can you please provide
us with working backports for 4.19.y, 5.4.y, 5.10.y and 5.15.y and I
will be glad to queue them up.

thanks,

greg k-h

