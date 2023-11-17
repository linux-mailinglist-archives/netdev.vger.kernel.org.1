Return-Path: <netdev+bounces-48733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C1D7EF5CB
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A51B20A7D
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE85374CE;
	Fri, 17 Nov 2023 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 07E9CC4
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 08:02:52 -0800 (PST)
Received: (qmail 1359927 invoked by uid 1000); 17 Nov 2023 11:02:52 -0500
Date: Fri, 17 Nov 2023 11:02:52 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>, Hayes Wang <hayeswang@realtek.com>,
  =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, linux-usb@vger.kernel.org,
  netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: r8152 logs error `can't resubmit intr, status -1`
Message-ID: <bd518d0a-5c95-4798-a200-ed774d130b53@rowland.harvard.edu>
References: <b67fc6f3-2463-4064-b7f6-5afa531742bb@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b67fc6f3-2463-4064-b7f6-5afa531742bb@molgen.mpg.de>

On Thu, Nov 16, 2023 at 03:59:31PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On the Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022, with a USB-C Dell
> DA300 adapter attached to the only USB-C port on the left, Linux 6.5.10
> logged the message below:
> 
>      r8152 4-1.2:1.0 enx18dbf22dccf3: can't resubmit intr, status -1
> 
> As this is error log level, how can I fix it?
> 
> Trying to understand the code, does `-1` mean `NOPERM`?
> 
>     $ git grep EPERM include/uapi/asm-generic/errno-base.h
>     #define	EPERM		 1	/* Operation not permitted */
> 
> Skimming the code this is returned by `usb_submit_urb()`, which in turn
> returns the return value of `usb_hcd_submit_urb()`.

That's right.  This error code is returned by usb_hcd_link_urb_to_ep()
when a driver tries to resubmit an URB that is being killed and
therefore is not currently available for reuse.

I have no idea why the r8152 driver tries to resubmit an interrupt URB
that has been killed.  It may be something innocuous, and the error
message in the log may be unnecessary.  You'll have to speak about
this with the driver's maintainer.

>  Do you have some
> debugging hints how to for example print the call trace for this case or
> enable more debug messages to understand the issue?

You can add a "dump_stack();" call to the section of
usb_hcd_link_urb_to_ep() that returns the -EPERM error code.  However
it may not give you any information you couldn't already get by
reading the source code for the r8152 driver.

Alan Stern

