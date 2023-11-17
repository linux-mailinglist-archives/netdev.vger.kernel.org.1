Return-Path: <netdev+bounces-48782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C57877EF808
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 20:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061D5280E3E
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 19:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7C436B0C;
	Fri, 17 Nov 2023 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GC8XIuXe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7470830FB3;
	Fri, 17 Nov 2023 19:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3444C433C7;
	Fri, 17 Nov 2023 19:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700250647;
	bh=mgr7W1G6L+NdoBOOW46rAU6b2P78V30b9At65AsodXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GC8XIuXeyBKipe0k7QczXuVacJ0SVK4n0a1aRi+AN/RGSDA3CsZB45BGkS7MAr7sq
	 mYxrjanJYLpmm3Nv8vUHaAFd+HKrDRqyynSfdHMLGgHi6ow98dmYjKrWNCB0ApXVfh
	 iEeNKI5Dkqcs5zUS65uUfpNrbsKcsJ5a8cxGQd+A=
Date: Fri, 17 Nov 2023 14:50:45 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alice Ryhl <aliceryhl@google.com>, fujita.tomonori@gmail.com,
	benno.lossin@proton.me, miguel.ojeda.sandonis@gmail.com,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <2023111709-amiable-everybody-befb@gregkh>
References: <20231026001050.1720612-2-fujita.tomonori@gmail.com>
 <20231117093906.2514808-1-aliceryhl@google.com>
 <b69b2ac0-752b-42ea-a729-9efdee503602@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b69b2ac0-752b-42ea-a729-9efdee503602@lunn.ch>

On Fri, Nov 17, 2023 at 02:53:44PM +0100, Andrew Lunn wrote:
> > I would change this to "it's okay to call phy_drivers_unregister from a
> > different thread than the one in which phy_drivers_register was called".
> 
> This got me thinking about 'threads'. For register and unregister, we
> are talking abut the kernel modules module_init() and module_exit()
> function. module_init() can be called before user space is even
> started, but it could also be called by insmod. module_exit() could be
> called by rmmod, but it could also be the kernel, after user space has
> gone away on shutdown.

The kernel will not call module_exit() on shutdown.  Or has something
changed recently?

> We are always in a context which can block, but
> i never really think of this being threads. You can start a kernel
> thread, and have some data structure exclusively used by that kernel
> thread, but that is pretty unusual.
> 
> So i would probably turn this commenting around. Only comment like
> this in the special case that a kernel thread exists, and it is
> expected to have exclusive access.

With the driver model, you can be sure that your probe/release functions
for the bus will never be called at the same time, and module_init/exit
can never be called at the same time, so perhaps this isn't an issue?

thanks,

greg k-h

