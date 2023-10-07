Return-Path: <netdev+bounces-38780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 464D27BC70A
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 13:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF65D281FA3
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 11:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCEB18648;
	Sat,  7 Oct 2023 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tZ0LmHDy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B64F9F4;
	Sat,  7 Oct 2023 11:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205E8C433C8;
	Sat,  7 Oct 2023 11:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696677436;
	bh=22jpTUkf6G55ASdEUvDJBwor+3wS5Qg7AyhhiJB2dt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tZ0LmHDybmtbJ8YqWHUxeePpYtbrRUz3DYaKI7sIVBF/veO44k5N6+5xRy3yUcXC3
	 B6vTCLCbUIF5/y65xXxvoY4RWtd5gdZ3lj6CXXiCYJxwfu9doRMwMEucchsvOOxYjf
	 BPxNgAWfAMLrfux07+myvHV3KQrsSNmQXIyg+qGM=
Date: Sat, 7 Oct 2023 13:17:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: tmgross@umich.edu, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 1/3] rust: core abstractions for network PHY drivers
Message-ID: <2023100757-crewman-mascot-bc1d@gregkh>
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
 <20231006094911.3305152-2-fujita.tomonori@gmail.com>
 <CALNs47sdj2onJS3wFUVoONYL_nEgT+PTLTVuMLcmE6W6JgZAXA@mail.gmail.com>
 <20231007.195857.292080693191739384.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007.195857.292080693191739384.fujita.tomonori@gmail.com>

On Sat, Oct 07, 2023 at 07:58:57PM +0900, FUJITA Tomonori wrote:
> > Since we're taking user input, it probably doesn't hurt to do some
> > sort of sanity check rather than casting. Maybe warn once then return
> > the biggest nowrapping value
> > 
> >     let speed_i32 = i32::try_from(speed).unwrap_or_else(|_| {
> >         warn_once!("excessive speed {speed}");

NEVER call WARN() on user input, as you now just rebooted the machine
and caused a DoS (and syzbot will start to spam you with reports.)

Remember, the majority of Linux systems in the world run with
panic-on-warn enabled, so any user path that can cause this, will be
used to cause problems.

thanks,

greg k-h

