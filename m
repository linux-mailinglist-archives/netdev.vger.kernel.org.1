Return-Path: <netdev+bounces-52858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E9E800731
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 10:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003481C20A2E
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 09:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CE11D559;
	Fri,  1 Dec 2023 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cSeUCA/R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B411BDC4
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 09:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66580C433C8;
	Fri,  1 Dec 2023 09:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701423351;
	bh=FKotAnza0tly67UmPlofVU8CiHXX9+4Iyqn2eJQvCKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cSeUCA/RynQRQSRnmsTjL6hI+iC8O/YmJ+Ay/akt2VksnjTQAgd3RhO6EoIYpqptn
	 MFPTNppbwRx9EZxZLW+0hnuhxITFShAbn2bVDGrXY5uO51mFZEx0Ak2sHQklYZmbQL
	 rha7U/s5OOBslktuYi3PEaNtBmFuHQlDh6z6sMSg=
Date: Fri, 1 Dec 2023 09:35:49 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org,
	"The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] net/packet: move reference count in packet_sock to
 64 bits
Message-ID: <2023120122-online-herself-01cd@gregkh>
References: <2023113042-unfazed-dioxide-f854@gregkh>
 <37d84da7-12d2-7646-d4fb-240d1023fe7a@iogearbox.net>
 <6568a72eab745_f2ed0294ad@willemb.c.googlers.com.notmuch>
 <be8c4d7a-e27c-7bde-280a-ff2444657b7b@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be8c4d7a-e27c-7bde-280a-ff2444657b7b@iogearbox.net>

On Fri, Dec 01, 2023 at 10:19:35AM +0100, Daniel Borkmann wrote:
> On 11/30/23 4:15 PM, Willem de Bruijn wrote:
> > Daniel Borkmann wrote:
> > > On 11/30/23 3:20 PM, Greg Kroah-Hartman wrote:
> > > > In some potential instances the reference count on struct packet_sock
> > > > could be saturated and cause overflows which gets the kernel a bit
> > > > confused.  To prevent this, move to a 64bit atomic reference count to
> > > > prevent the possibility of this type of overflow.
> > > > 
> > > > Because we can not handle saturation, using refcount_t is not possible
> > > > in this place.  Maybe someday in the future if it changes could it be
> > > > used.
> > > > 
> > > > Original version from Daniel after I did it wrong, I've provided a
> > > > changelog.
> > > > 
> > > > Reported-by: "The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>
> > > > Cc: stable <stable@kernel.org>
> > > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > > Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > Thanks!
> > > 
> > > Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> > 
> > Acked-by: Willem de Bruijn <willemb@google.com>
> 
> There was feedback from Linus that switching to atomic_long_t is better
> choice so that it doesn't penalize 32-bit architectures. Will post a v2
> today.

Thanks, makes sense to do it that way.

greg k-h

