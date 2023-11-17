Return-Path: <netdev+bounces-48687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EACE7EF3E3
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 14:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DA08B20C71
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 13:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837CD30F8F;
	Fri, 17 Nov 2023 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hyaj2Rks"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75A111F;
	Fri, 17 Nov 2023 05:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j3m+Np/U92eIqaQzyqycqq0m1Uvne8h1Ni+QReYmrrY=; b=hyaj2Rks+MC09pJYvhuKyw+KJV
	UGt/9KI63MRdGymnqqEzfvuZF+11Pek+c6Nv46ac94Aegbzg7B850zKeTtpkFa+mMy7QUZePf7MHW
	2hFZorgKFuwFj6b7SemsY/zXxs7QQn8ABTAn49+McHXxTfGRugDpn1igiraOiO93d4NI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r3zI0-000RYV-Do; Fri, 17 Nov 2023 14:53:44 +0100
Date: Fri, 17 Nov 2023 14:53:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alice Ryhl <aliceryhl@google.com>
Cc: fujita.tomonori@gmail.com, benno.lossin@proton.me,
	miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <b69b2ac0-752b-42ea-a729-9efdee503602@lunn.ch>
References: <20231026001050.1720612-2-fujita.tomonori@gmail.com>
 <20231117093906.2514808-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117093906.2514808-1-aliceryhl@google.com>

> I would change this to "it's okay to call phy_drivers_unregister from a
> different thread than the one in which phy_drivers_register was called".

This got me thinking about 'threads'. For register and unregister, we
are talking abut the kernel modules module_init() and module_exit()
function. module_init() can be called before user space is even
started, but it could also be called by insmod. module_exit() could be
called by rmmod, but it could also be the kernel, after user space has
gone away on shutdown. We are always in a context which can block, but
i never really think of this being threads. You can start a kernel
thread, and have some data structure exclusively used by that kernel
thread, but that is pretty unusual.

So i would probably turn this commenting around. Only comment like
this in the special case that a kernel thread exists, and it is
expected to have exclusive access.

	 Andrew

