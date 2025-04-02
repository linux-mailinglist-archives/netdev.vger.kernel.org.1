Return-Path: <netdev+bounces-178730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58978A788B7
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 09:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066B61885CB4
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 07:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316C623371D;
	Wed,  2 Apr 2025 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CWiw9UnX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09215233711;
	Wed,  2 Apr 2025 07:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577960; cv=none; b=ogEZU2krQaWhob48iVgVRAbNDhzPQIEg85PlnxQrsFaaDgNSmi/wwLo2Srb/T7kXZPZ92ZqfJJsqpIBndVeDQf4BLK25NQJMjvqj6T2ShqxCal01GIeecgEEt57y/GL4qmRGc27vrfYnu3WP/ThSfWSbC/yPcOcYZZMDF39AHUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577960; c=relaxed/simple;
	bh=ulzw0kQs6uq2V1aE+OF19U5en4XOwkfkgpmIo07Dp2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/rJAUUTXeN3SU0D4jQjgNXc7np/vo/SINi7kMgXHxLz63sbxAdCrIJHcYfc3LsfDv4ivqUbeZl6PAPaqwyHEtLyrSsT7/2IMdxsX4AMTtqXoCC6oyTWxr0691Gcfq40rS9ghOP/EiQ8aNcgk2W1WjN+FA3QLwbKSGZz8pYFJiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CWiw9UnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C242C4CEDD;
	Wed,  2 Apr 2025 07:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743577959;
	bh=ulzw0kQs6uq2V1aE+OF19U5en4XOwkfkgpmIo07Dp2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CWiw9UnXmX4DEHvbf8gKgXL9jNzszfm2+oLt9UmWrMIRjgrx/OOKDAdTMYScdCqkQ
	 B+t+rL3Og36GB4OBQQYgM/i6iB04DV5cCgE//sZF7/VAJHd1uKYpUL2SIC/ofQlILB
	 QaLR1kZyBGDZPhd+0eQka429+SEyCECHehHs7Q6E=
Date: Wed, 2 Apr 2025 08:11:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ying Lu <luying526@gmail.com>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, luying1 <luying1@xiaomi.com>
Subject: Re: [PATCH v1 1/1] usbnet:fix NPE during rx_complete
Message-ID: <2025040228-mobile-busybody-e5c4@gregkh>
References: <cover.1743497376.git.luying1@xiaomi.com>
 <e3646459ea67f10135ab821f90f66d8b6e74456c.1743497376.git.luying1@xiaomi.com>
 <2025040110-unknowing-siding-c7d2@gregkh>
 <CAGo_G-f_8w9E388GOunNJ329W8UqOQ0y2amx_gMvbbstw4=H2A@mail.gmail.com>
 <2025040121-compactor-lumpiness-e615@gregkh>
 <CAGo_G-fiR5webo04uoVKTFh3UZaVTzkUgF2OcD8+fY-HzWCO6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGo_G-fiR5webo04uoVKTFh3UZaVTzkUgF2OcD8+fY-HzWCO6g@mail.gmail.com>

On Wed, Apr 02, 2025 at 08:12:06AM +0800, Ying Lu wrote:
> On Tue, Apr 1, 2025 at 9:48 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Apr 01, 2025 at 08:48:01PM +0800, Ying Lu wrote:
> > > On Tue, Apr 1, 2025 at 6:31 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Apr 01, 2025 at 06:18:01PM +0800, Ying Lu wrote:
> > > > > From: luying1 <luying1@xiaomi.com>
> > > > >
> > > > > Missing usbnet_going_away Check in Critical Path.
> > > > > The usb_submit_urb function lacks a usbnet_going_away
> > > > > validation, whereas __usbnet_queue_skb includes this check.
> > > > >
> > > > > This inconsistency creates a race condition where:
> > > > > A URB request may succeed, but the corresponding SKB data
> > > > > fails to be queued.
> > > > >
> > > > > Subsequent processes:
> > > > > (e.g., rx_complete → defer_bh → __skb_unlink(skb, list))
> > > > > attempt to access skb->next, triggering a NULL pointer
> > > > > dereference (Kernel Panic).
> > > > >
> > > > > Signed-off-by: luying1 <luying1@xiaomi.com>
> > > >
> > > > Please use your name, not an email alias.
> > > >
> > > OK, I have updated. please check the Patch v2
> > >
> > > > Also, what commit id does this fix?  Should it be applied to stable
> > > > kernels?
> > > The commit  id is 04e906839a053f092ef53f4fb2d610983412b904
> > > (usbnet: fix cyclical race on disconnect with work queue)
> > > Should it be applied to stable kernels?  -- Yes
> >
> > Please mark the commit with that information, you seem to have not done
> > so for the v2 version :(
> Thank you for your response. Could you please confirm if I understand correctly:
> Should we include in our commit message which commit id we're fixing?

No, use the correct "Fixes:" tag format as described in the
documentation.

thanks,

greg k-h

