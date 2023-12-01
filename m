Return-Path: <netdev+bounces-52962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A695800EE5
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D011C2097C
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 16:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF014BA84;
	Fri,  1 Dec 2023 15:59:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id A59741B2
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 07:59:54 -0800 (PST)
Received: (qmail 290509 invoked by uid 1000); 1 Dec 2023 10:59:53 -0500
Date: Fri, 1 Dec 2023 10:59:53 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Douglas Anderson <dianders@chromium.org>
Cc: linux-usb@vger.kernel.org,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Simon Horman <horms@kernel.org>, Grant Grundler <grundler@chromium.org>,
  Hayes Wang <hayeswang@realtek.com>,
  =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
  Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
  "David S . Miller" <davem@davemloft.net>, Brian Geffon <bgeffon@google.com>,
  Bastien Nocera <hadess@hadess.net>,
  Benjamin Tissoires <benjamin.tissoires@redhat.com>,
  Flavio Suligoi <f.suligoi@asem.it>,
  Heikki Krogerus <heikki.krogerus@linux.intel.com>,
  Ricardo =?iso-8859-1?Q?Ca=F1uelo?= <ricardo.canuelo@collabora.com>,
  Rob Herring <robh@kernel.org>, Roy Luo <royluo@google.com>,
  Stanley Chang <stanley_chang@realtek.com>,
  Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: Save the config when a device is
 deauthorized+authorized
Message-ID: <62b7467f-f142-459d-aa23-8bfd70bbe733@rowland.harvard.edu>
References: <20231130154337.1.Ie00e07f07f87149c9ce0b27ae4e26991d307e14b@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130154337.1.Ie00e07f07f87149c9ce0b27ae4e26991d307e14b@changeid>

On Thu, Nov 30, 2023 at 03:43:47PM -0800, Douglas Anderson wrote:
> Right now, when a USB device is deauthorized (by writing 0 to the
> "authorized" field in sysfs) and then reauthorized (by writing a 1) it
> loses any configuration it might have had. This is because
> usb_deauthorize_device() calls:
>   usb_set_configuration(usb_dev, -1);
> ...and then usb_authorize_device() calls:
>   usb_choose_configuration(udev);
> ...to choose the "best" configuration.
> 
> This generally works OK and it looks like the above design was chosen
> on purpose. In commit 93993a0a3e52 ("usb: introduce
> usb_authorize/deauthorize()") we can see some discussion about keeping
> the old config but it was decided not to bother since we can't save it
> for wireless USB anyway. It can be noted that as of commit
> 1e4c574225cc ("USB: Remove remnants of Wireless USB and UWB") wireless
> USB is removed anyway, so there's really not a good reason not to keep
> the old config.
> 
> Unfortunately, throwing away the old config breaks when something has
> decided to choose a config other than the normal "best" config.
> Specifically, it can be noted that as of commit ec51fbd1b8a2 ("r8152:
> add USB device driver for config selection") that the r8152 driver
> subclasses the generic USB driver and selects a config other than the
> one that would have been selected by usb_choose_configuration(). This
> logic isn't re-run after a deauthorize + authorize and results in the
> r8152 driver not being re-bound.
> 
> Let's change things to save the old config when we deauthorize and
> then restore it when we re-authorize. We'll disable this logic for
> wireless USB where we re-fetch the descriptor after authorization.

Would it be better to make the r8152 driver override 
usb_choose_configuration()?  This is the sort of thing that subclassing 
is intended for.

Alan Stern

