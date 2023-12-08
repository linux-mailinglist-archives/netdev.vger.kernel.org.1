Return-Path: <netdev+bounces-55446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC68280AE3C
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 21:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6631C1F2116B
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770DB3B78A;
	Fri,  8 Dec 2023 20:48:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 2B5271706
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 12:48:00 -0800 (PST)
Received: (qmail 55366 invoked by uid 1000); 8 Dec 2023 15:47:59 -0500
Date: Fri, 8 Dec 2023 15:47:59 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Douglas Anderson <dianders@chromium.org>
Cc: linux-usb@vger.kernel.org,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
  =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
  Eric Dumazet <edumazet@google.com>, Grant Grundler <grundler@chromium.org>,
  Brian Geffon <bgeffon@google.com>, "David S . Miller" <davem@davemloft.net>,
  Hayes Wang <hayeswang@realtek.com>, Simon Horman <horms@kernel.org>,
  netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: Fix crash w/ usb_choose_configuration() if no
 driver
Message-ID: <90fb5279-c1da-4d8c-8f89-b1f54175eee3@rowland.harvard.edu>
References: <20231208123119.1.If27eb3bf7812f91ab83810f232292f032f4203e0@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208123119.1.If27eb3bf7812f91ab83810f232292f032f4203e0@changeid>

On Fri, Dec 08, 2023 at 12:31:24PM -0800, Douglas Anderson wrote:
> It's possible that usb_choose_configuration() can get called when a
> USB device has no driver. In this case the recent commit a87b8e3be926
> ("usb: core: Allow subclassed USB drivers to override
> usb_choose_configuration()") can cause a crash since it dereferenced
> the driver structure without checking for NULL. Let's add a check.
> 
> This was seen in the real world when usbguard got ahold of a r8152
> device at the wrong time. It can also be simulated via this on a
> computer with one r8152-based USB Ethernet adapter:
>   cd /sys/bus/usb/drivers/r8152-cfgselector
>   to_unbind="$(ls -d *-*)"
>   real_dir="$(readlink -f "${to_unbind}")"
>   echo "${to_unbind}" > unbind
>   cd "${real_dir}"
>   echo 0 > authorized
>   echo 1 > authorized
> 
> Fixes: a87b8e3be926 ("usb: core: Allow subclassed USB drivers to override usb_choose_configuration()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

I'm not sure this is the best solution.  A USB device with no driver is 
an anomaly; in all likelihood we shouldn't be calling 
usb_choose_configuration() for such a device in the first place.

So I think a better solution would be to put this check in 
usb_authorize_device() before it does the autoresume, or else to make 
usb_choose_configuration() return immediately, right at the start, if 
there is no driver.

Alan Stern

