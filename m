Return-Path: <netdev+bounces-13123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EDA73A5AB
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AFA22819DE
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 16:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51A4200A5;
	Thu, 22 Jun 2023 16:10:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064CF1F95C
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 16:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8138C433C8;
	Thu, 22 Jun 2023 16:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1687450204;
	bh=xLyXvexgDPhNaQNSn+EFSDO6E/yJrPCxAprammFlvbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BnXgHjpi2MOfptfmTAtE/YPjGIuBTYzlKRUp7fENW/t9oQhN2Xrrt73Twhx75Hn7C
	 gr4CxvjVQBjaREfgJZ5Nef/HZ4D3NIdLzoJf0HgA8jE1lsD3372UNRGhhtBy5ZqDvv
	 A7jW+W2Xlc2fbpFJvEfeBL4UEM8NxIgJSRpd7iGc=
Date: Thu, 22 Jun 2023 18:10:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	leit@meta.com, Arnd Bergmann <arnd@arndb.de>,
	Steve French <stfrench@microsoft.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Simon Ser <contact@emersion.fr>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:IO_URING" <io-uring@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH] io_uring: Add io_uring command support for sockets
Message-ID: <2023062208-animosity-squabble-c1ba@gregkh>
References: <20230621232129.3776944-1-leitao@debian.org>
 <2023062231-tasting-stranger-8882@gregkh>
 <ZJRijTDv5lUsVo+j@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJRijTDv5lUsVo+j@gmail.com>

On Thu, Jun 22, 2023 at 08:02:37AM -0700, Breno Leitao wrote:
> On Thu, Jun 22, 2023 at 07:20:48AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jun 21, 2023 at 04:21:26PM -0700, Breno Leitao wrote:
> > > Enable io_uring commands on network sockets. Create two new
> > > SOCKET_URING_OP commands that will operate on sockets. Since these
> > > commands are similar to ioctl, uses the _IO{R,W} helpers to embedded the
> > > argument size and operation direction. Also allocates a unused ioctl
> > > chunk for uring command usage.
> > > 
> > > In order to call ioctl on sockets, use the file_operations->uring_cmd
> > > callbacks, and map it to a uring socket function, which handles the
> > > SOCKET_URING_OP accordingly, and calls socket ioctls.
> > > 
> > > This patches was tested by creating a new test case in liburing.
> > > Link: https://github.com/leitao/liburing/commit/3340908b742c6a26f662a0679c4ddf9df84ef431
> > > 
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > ---
> > 
> > Isn't this a new version of an older patch?
> 
> Yes, this should have tagged as V2.
> 
> [1] https://lore.kernel.org/lkml/20230406144330.1932798-1-leitao@debian.org/#r

Great, also add what changed below the --- line please.

> > > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > > @@ -361,6 +361,7 @@ Code  Seq#    Include File                                           Comments
> > >  0xCB  00-1F                                                          CBM serial IEC bus in development:
> > >                                                                       <mailto:michael.klein@puffin.lb.shuttle.de>
> > >  0xCC  00-0F  drivers/misc/ibmvmc.h                                   pseries VMC driver
> > > +0xCC  A0-BF  uapi/linux/io_uring.h                                   io_uring cmd subsystem
> > 
> > This change is nice, but not totally related to this specific one,
> > shouldn't it be separate?
> 
> This is related to this patch, since I am using it below, in the
> following part:
> 
> 	+#define SOCKET_URING_OP_SIOCINQ _IOR(0xcc, 0xa0, int)
> 	+#define SOCKET_URING_OP_SIOCOUTQ _IOR(0xcc, 0xa1, int)
> 
> Should I have a different patch, even if they are related?

Yes, as you are not using the 0xa2-0xbf range that you just carved out
here, right?  Where did those numbers come from?

thanks,

greg k-h

