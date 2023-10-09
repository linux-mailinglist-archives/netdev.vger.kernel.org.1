Return-Path: <netdev+bounces-39174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7AA7BE43F
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0491C20BAF
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D9E36AE4;
	Mon,  9 Oct 2023 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BM1W6Df9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69A737151;
	Mon,  9 Oct 2023 15:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105ABC433CA;
	Mon,  9 Oct 2023 15:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696864459;
	bh=4rdIhdsejVNb8ZKMss+WiZZRfIt8DvPE82Y1gqQEaWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BM1W6Df9YODKz59EtphEFNNw3EjvEXbdaQqpjZsTzxixuXxEqlbRTbcExAvbYkCXC
	 0/ZqbEclsUazFvYyvuaZn9V8FCGSmeGpEwEocfDYNDFlxRl7H64+Kj+M4Oa2DyQ7Xw
	 jTtWJNrbrtz3FOqb8QzO9j6ZDOSFg/t4bANhB7zU=
Date: Mon, 9 Oct 2023 17:14:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	Andrea Righi <andrea.righi@canonical.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH net-next v3 0/3] Rust abstractions for network PHY drivers
Message-ID: <2023100926-polygon-robin-8327@gregkh>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <5334dc69-1604-4408-9cce-3c89bc5d7688@lunn.ch>
 <CANiq72n6DMeXQrgOzS_+3VdgNYAmpcnneAHJnZERUQhMExg+0A@mail.gmail.com>
 <2023100916-crushing-sprawl-30a4@gregkh>
 <CANiq72nfN2e8oWtFDQ1ey0CJaTZ+W=g10k5YKukaWqckxH7Rmg@mail.gmail.com>
 <2023100907-liable-uplifted-568d@gregkh>
 <CANiq72=A_HMc3nwxk-EGzuDGRBSCfdzKGj=M-snbd8cidQLfuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=A_HMc3nwxk-EGzuDGRBSCfdzKGj=M-snbd8cidQLfuQ@mail.gmail.com>

On Mon, Oct 09, 2023 at 05:06:45PM +0200, Miguel Ojeda wrote:
> On Mon, Oct 9, 2023 at 4:52 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Then the main CONFIG_HAVE_RUST should have that dependency, don't force
> > it on each individual driver.
> 
> Yes, that is what I meant (well, `CONFIG_RUST` is where we have the
> other restrictions).

Oops, yes, add it there please.

> > But note, that is probably not a good marketing statement as you are
> > forced to make your system more insecure in order to use the "secure"
> > language :(
> 
> Indeed, but until we catch up on that, it is what it is; i.e. it is
> not something that we want to keep there, it has to go away to make it
> viable.

Is anyone working on the needed compiler changes for this to work
properly on x86?

> The other option we discussed back then was to print a big banner or
> something at runtime, but that is also not great (and people would
> still see warnings at build time -- for good reason).

No, please don't do that, you would be making systems insecure and the
mix of a kernel image with, and without, RET statements in it is going
to be a huge mess.  Just disable CONFIG_RUST for now until proper
retbleed support is added to the compiler.

thanks,

greg k-h

