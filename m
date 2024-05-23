Return-Path: <netdev+bounces-97856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E575D8CD861
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 18:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C0A1C20A84
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5B3179AD;
	Thu, 23 May 2024 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qzhot9WN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C21D304;
	Thu, 23 May 2024 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716481620; cv=none; b=EZ3ywkHZglFrjBeXaqQr4HxBLrIKkn9qm7xml8WZai5ryuiAlnzRdgAj/icbD3uz6lTepJZi0cvkZL8WEMxeFwbgexJNpJmQm0GF5lEL8Mxs7HTYVaqxbs663Bo6zxknFWcOHAgayVzGjACdgKvDBus6h/skxeBdt+D0ccKEL4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716481620; c=relaxed/simple;
	bh=ySaFSvei7+pERUmsSe6G8jJ7vZ83vP4RNHlEGL3+E8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+gaq3SHW7U9xkn3sAc8lzLtfnzULfM+0zQ/umJRfAR/864eCQPwBtL2fCHZ7GAKl9+AGDSZhVP8i1jlAyAQfQrMyhvsY1I4Lvqj2LUqTcw1BAmv8hAgD14uhPjTfgaTAEYhTC+DpANdguaLT44b5DjPhn44fmC/pN8WpwO4TAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qzhot9WN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A62C2BD10;
	Thu, 23 May 2024 16:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716481620;
	bh=ySaFSvei7+pERUmsSe6G8jJ7vZ83vP4RNHlEGL3+E8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qzhot9WN3Tu+Jw8kwi1ZqfmBj19LU9GMpO5Hy9xGeUTty3cq2ldWWnXEFyY8necnB
	 VnoRoxukJp1zEwDJwSZ7W+lqRIp/mZMjjXjdmoaQoPMAjAeId+uj7PIdZkuFGmRDUK
	 8vch2M/A8+nhOPtxHEsm6pmlTgY1xEPmd9Yplooc=
Date: Thu, 23 May 2024 18:26:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] ptp: ocp: adjust serial port symlink creation
Message-ID: <2024052349-tapestry-astronaut-0de1@gregkh>
References: <20240510110405.15115-1-vadim.fedorenko@linux.dev>
 <20240523083943.6ecb60d9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523083943.6ecb60d9@kernel.org>

On Thu, May 23, 2024 at 08:39:43AM -0700, Jakub Kicinski wrote:
> On Fri, 10 May 2024 11:04:05 +0000 Vadim Fedorenko wrote:
> > The commit b286f4e87e32 ("serial: core: Move tty and serdev to be children
> > of serial core port device") changed the hierarchy of serial port devices
> > and device_find_child_by_name cannot find ttyS* devices because they are
> > no longer directly attached. Add some logic to restore symlinks creation
> > to the driver for OCP TimeCard.
> > 
> > Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
> > Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > ---
> > v2:
> >  add serial/8250 maintainers
> > ---
> >  drivers/ptp/ptp_ocp.c | 30 +++++++++++++++++++++---------
> >  1 file changed, 21 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> > index ee2ced88ab34..50b7cb9db3be 100644
> > --- a/drivers/ptp/ptp_ocp.c
> > +++ b/drivers/ptp/ptp_ocp.c
> > @@ -25,6 +25,8 @@
> >  #include <linux/crc16.h>
> >  #include <linux/dpll.h>
> >  
> > +#include "../tty/serial/8250/8250.h"
> 
> Hi Greg, Jiri, does this look reasonable to you?
> The cross tree include raises an obvious red flag.

Yeah, that looks wrong.

> Should serial / u8250 provide a more official API?

If it needs to, but why is this driver poking around in here at all?

> Can we use device_for_each_child() to deal with the extra
> layer in the hierarchy?

Or a real function where needed?

> 
> >  #define PCI_VENDOR_ID_FACEBOOK			0x1d9b
> >  #define PCI_DEVICE_ID_FACEBOOK_TIMECARD		0x0400
> >  
> > @@ -4330,11 +4332,9 @@ ptp_ocp_symlink(struct ptp_ocp *bp, struct device *child, const char *link)
> >  }
> >  
> >  static void
> > -ptp_ocp_link_child(struct ptp_ocp *bp, const char *name, const char *link)
> > +ptp_ocp_link_child(struct ptp_ocp *bp, struct device *dev, const char *name, const char *link)
> >  {
> > -	struct device *dev, *child;
> > -
> > -	dev = &bp->pdev->dev;
> > +	struct device *child;
> >  
> >  	child = device_find_child_by_name(dev, name);
> >  	if (!child) {
> > @@ -4349,27 +4349,39 @@ ptp_ocp_link_child(struct ptp_ocp *bp, const char *name, const char *link)
> >  static int
> >  ptp_ocp_complete(struct ptp_ocp *bp)
> >  {
> > +	struct device *dev, *port_dev;
> > +	struct uart_8250_port *port;
> >  	struct pps_device *pps;
> >  	char buf[32];
> >  
> > +	dev = &bp->pdev->dev;
> > +
> >  	if (bp->gnss_port.line != -1) {
> > +		port = serial8250_get_port(bp->gnss_port.line);
> > +		port_dev = (struct device *)port->port.port_dev;

That cast is not going to go well.  How do you know this is always
true?

What was the original code attempting to do?  It feels like that was
wrong to start with if merely moving things around the device tree
caused anything to break here.  That is not how the driver core is
supposed to be used at all.

thanks,

greg k-h

