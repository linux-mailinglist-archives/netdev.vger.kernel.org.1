Return-Path: <netdev+bounces-52176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D207FDBB1
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066AA2827C6
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 15:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EE238F87;
	Wed, 29 Nov 2023 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 276A51B4
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 07:40:44 -0800 (PST)
Received: (qmail 206768 invoked by uid 1000); 29 Nov 2023 10:40:43 -0500
Date: Wed, 29 Nov 2023 10:40:43 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.com>
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, davem@davemloft.net,
  edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
  linux-usb@vger.kernel.org, netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: ax88179_178a: avoid failed operations when
 device is disconnected
Message-ID: <51cb747a-21fe-4b3b-9567-01b9cc9d8873@rowland.harvard.edu>
References: <20231129151618.455618-1-jtornosm@redhat.com>
 <f684feac-2941-4407-846b-2d984daca733@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f684feac-2941-4407-846b-2d984daca733@suse.com>

On Wed, Nov 29, 2023 at 04:33:58PM +0100, Oliver Neukum wrote:
> On 29.11.23 16:16, Jose Ignacio Tornos Martinez wrote:
> 
> Hi,
> 
> > The reason is that although the device is detached, normal stop and
> > unbind operations are commanded. Avoid these unnecessary operations
> > when the device is detached (state is USB_STATE_NOTATTACHED) so as
> > not to get the error messages.
> 
> I am sorry, but this is a layering violation. You are looking
> at an internal state of the USB layer to surpress logging
> -ENODEV. If you think these messages should go away, filter
> for ENODEV where they are generated.

Indeed.

In addition, you should be more careful about the distinction between 
"unbound" and "disconnected".  It's possible for the driver to be 
unbound from the device even while the device is still plugged in.  In 
this situation, submitting URBs will fail with an error even though the 
device state isn't USB_STATE_NOTATTACHED.

Alan Stern

