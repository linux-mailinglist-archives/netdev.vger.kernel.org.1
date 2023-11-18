Return-Path: <netdev+bounces-48917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 052F87F004A
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 16:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2566F280D9D
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 15:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4665210793;
	Sat, 18 Nov 2023 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qxRcmJ25"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7928812B;
	Sat, 18 Nov 2023 07:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Btj9P+VH/CDxOXVVE6NwhbHHPfYUrQJoy/uGXNS0XgM=; b=qxRcmJ25ib7soqFiNZ+wrXmyYG
	7yDxZZ3gvg1mulRSCbVmQi/n5zRVi5GROj3apoGg3CdWS4/vET0/zPdZy5d2eizQMhpDQ1eT3bEXM
	F3m4HBEdMZgO/JjMPosV4cNQT09SvMVqGABwo9RJ2+OBTS0JKPnsPc3eRPlS2OCnW3eU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r4NJ4-000Vp0-2X; Sat, 18 Nov 2023 16:32:26 +0100
Date: Sat, 18 Nov 2023 16:32:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Alice Ryhl <aliceryhl@google.com>,
	fujita.tomonori@gmail.com, benno.lossin@proton.me,
	miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <e7d0226a-9a38-4ce9-a9b5-7bb80a19bff6@lunn.ch>
References: <20231026001050.1720612-2-fujita.tomonori@gmail.com>
 <20231117093906.2514808-1-aliceryhl@google.com>
 <b69b2ac0-752b-42ea-a729-9efdee503602@lunn.ch>
 <2023111709-amiable-everybody-befb@gregkh>
 <ZVf3LvoZ7npy3WxI@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVf3LvoZ7npy3WxI@boqun-archlinux>

> One example of not `Send` type (or `!Send`) is spinlock guard:
> 
> 	let guard: Guard<..> = some_lock.lock();
> 
> creating a Guard means "spin_lock()" and dropping a Guard means
> "spin_unlock()", since we cannot acquire a spinlock in one context and
> release it in another context in kernel, so `Guard<..>` is `!Send`.

Thanks for the explanation. Kernel people might have a different
meaning for context, especially in this example. We have process
context and atomic context. Process context you are allowed to sleep,
atomic context you cannot sleep. If you are in process context and
take a spinlock, you change into atomic context. And when you release
the spinlock you go back to process context. So with this meaning of
context, you do acquire the spinlock in one context, and release it in
another.

So we are going to have to think about the context the word context is
used in, and expect kernel and Rust people to maybe think of it
differently.

	Andrew

