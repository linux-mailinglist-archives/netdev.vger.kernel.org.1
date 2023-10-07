Return-Path: <netdev+bounces-38782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B11E7BC71E
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 13:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0421C20957
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 11:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6CC18651;
	Sat,  7 Oct 2023 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oGE+9dEj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E75E18629;
	Sat,  7 Oct 2023 11:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982C0C433C7;
	Sat,  7 Oct 2023 11:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696678257;
	bh=AIGMiXDqNs9QpOVtwXFgcyXyIZU52lszBZSZ7GvzYL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGE+9dEj7DDbO+hMv6MWU5vq9wTFzPBnjmS+LRnKSfoj1UUTxqVtzBCMLfakHq0t2
	 3wDEcD39SvamJeGlbG4a7pKDRV86fFSF9I94w0bQMUjWZQhKD9ut2zlMRAEH0svOol
	 caPPTD03GlYxVZgScU/MfGckUoG6+Mc4vmd0Ld8k=
Date: Sat, 7 Oct 2023 13:30:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: tmgross@umich.edu, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 1/3] rust: core abstractions for network PHY drivers
Message-ID: <2023100728-unloving-snowboard-d558@gregkh>
References: <CALNs47sdj2onJS3wFUVoONYL_nEgT+PTLTVuMLcmE6W6JgZAXA@mail.gmail.com>
 <20231007.195857.292080693191739384.fujita.tomonori@gmail.com>
 <2023100757-crewman-mascot-bc1d@gregkh>
 <20231007.202324.2257155764500021886.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007.202324.2257155764500021886.fujita.tomonori@gmail.com>

On Sat, Oct 07, 2023 at 08:23:24PM +0900, FUJITA Tomonori wrote:
> On Sat, 7 Oct 2023 13:17:13 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Sat, Oct 07, 2023 at 07:58:57PM +0900, FUJITA Tomonori wrote:
> >> > Since we're taking user input, it probably doesn't hurt to do some
> >> > sort of sanity check rather than casting. Maybe warn once then return
> >> > the biggest nowrapping value
> >> > 
> >> >     let speed_i32 = i32::try_from(speed).unwrap_or_else(|_| {
> >> >         warn_once!("excessive speed {speed}");
> > 
> > NEVER call WARN() on user input, as you now just rebooted the machine
> > and caused a DoS (and syzbot will start to spam you with reports.)
> 
> Trevor uses `user` as the user of this function, which is a PHY driver.
> 

Ok, same thing in a way, just do a dev_warn() and return an error, no
need to do a full traceback splat at all.

thanks,

greg k-h

