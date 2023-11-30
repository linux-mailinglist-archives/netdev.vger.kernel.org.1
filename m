Return-Path: <netdev+bounces-52577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8787FF3F3
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DD5CB212BB
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAB853801;
	Thu, 30 Nov 2023 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 8543810FA
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:50:09 -0800 (PST)
Received: (qmail 250227 invoked by uid 1000); 30 Nov 2023 10:50:08 -0500
Date: Thu, 30 Nov 2023 10:50:08 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: oneukum@suse.com, davem@davemloft.net, edumazet@google.com,
  kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
  netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH] net: usb: ax88179_178a: avoid failed operations when
 device is disconnected
Message-ID: <e2faf901-84de-41ad-804d-6c86bc304ef1@rowland.harvard.edu>
References: <51cb747a-21fe-4b3b-9567-01b9cc9d8873@rowland.harvard.edu>
 <20231130084136.172052-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130084136.172052-1-jtornosm@redhat.com>

On Thu, Nov 30, 2023 at 09:41:36AM +0100, Jose Ignacio Tornos Martinez wrote:
> Hi Oliver,
> 
> > I am sorry, but this is a layering violation. You are looking
> > at an internal state of the USB layer to surpress logging
> > -ENODEV. If you think these messages should go away, filter
> > for ENODEV where they are generated.
> Thank you for your comments and suggestion.
> My intention was also to avoid unnecessary and failed operations 
> if disconnection was detected.

What are these unnecessary operations?

> Ok, let me research more and do better.
> 
> Hi Alan,
> 
> > In addition, you should be more careful about the distinction between 
> > "unbound" and "disconnected".  It's possible for the driver to be 
> > unbound from the device even while the device is still plugged in.  In 
> > this situation, submitting URBs will fail with an error even though the 
> > device state isn't USB_STATE_NOTATTACHED.
> Thank you for you comments.
> I also tested "unbound" and stop and unbind operations were correctly 
> executed. I just wanted to avoid the issues during disconnection, if other 
> operations are commanded later I think it is better to warn.

In general, drivers should treat "unbind" the same as "disconnect" (in 
both cases, the ->disconnect() routine is called).  If a driver tries to 
send commands to the device while the disconnect routine is running, it 
should expect that they might fail and not generate an error message if 
they do.

(Also, note that the USB core will allow a driver to send commands to 
the device during unbind only if the .soft_unbind flag is set in the 
usb_driver structure.)

And in any case, a driver should _never_ try to communicate with the 
device after the disconnect routine has returned.

Alan Stern

