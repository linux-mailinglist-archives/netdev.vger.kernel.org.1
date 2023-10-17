Return-Path: <netdev+bounces-41988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F987CC890
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 18:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2681C20A41
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 16:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6389945F62;
	Tue, 17 Oct 2023 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0JuOmF/O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925844498;
	Tue, 17 Oct 2023 16:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED93AC433C7;
	Tue, 17 Oct 2023 16:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697559367;
	bh=++5rVi+ySPKnY3Zse4S0U6+ylTHGyB3WPeAoWkJ/y9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0JuOmF/O97uodM8GMATlFfPdhBkDgpX25ilRq6Kd7CwO5pFWiERm8bZQLGPGgxD6M
	 Ku71F7f6NplDx7xQnD+TwPp/ujKGg5vPeS6+dAkJ9DSmEQP0LED41cz73IO4dcdEy5
	 Gsvo5PLnH7scXTY4KmSPtdDyZowf5DPPxjTXLLYk=
Date: Tue, 17 Oct 2023 18:15:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Andrew Lunn <andrew@lunn.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	boqun.feng@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <2023101758-scone-supernova-e9a1@gregkh>
References: <3469de1c-0e6f-4fe5-9d93-2542f87ffd0d@proton.me>
 <20231015.011502.276144165010584249.fujita.tomonori@gmail.com>
 <9d70de37-c5ed-4776-a00f-76888e1230aa@proton.me>
 <20231015.073929.156461103776360133.fujita.tomonori@gmail.com>
 <98471d44-c267-4c80-ba54-82ab2563e465@proton.me>
 <1454c3e6-82d1-4f60-b07d-bc3b47b23662@lunn.ch>
 <f26a3e1a-7eb8-464e-9cbe-ebb8bdf69b20@proton.me>
 <2023101756-procedure-uninvited-f6c9@gregkh>
 <0f839f73-400f-47d5-9708-0fa40ed0d4e9@proton.me>
 <CANiq72nbhdyPDWebXFphKjwvYT2VdQq-ksDmbOTNezV9OarPpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nbhdyPDWebXFphKjwvYT2VdQq-ksDmbOTNezV9OarPpQ@mail.gmail.com>

On Tue, Oct 17, 2023 at 05:17:40PM +0200, Miguel Ojeda wrote:
> On Tue, Oct 17, 2023 at 4:32 PM Benno Lossin <benno.lossin@proton.me> wrote:
> >
> > This is not allowed in Rust, it is UB and will lead to bad things.
> 
> Yeah, and to be clear, data races are also UB in C.

And to be clear, something we totally ignore in many places in the
kernel because it flat out does not matter at all.

Think about userspace writing 2 different values to the same sysfs file
at the same time, which the kernel driver will then attempt to save into
the same location at the "same" time.  Which one wins?  Who cares?
Userspace did something foolish and it doesn't matter, and writes are
pretty much "atomic" in that they do not split across memory locations
so it's not a real issue.

Same here with your "speed" value, it just doesn't matter, right?  One
will "win" and the other one will not, so what is the problem?  Same
thing would happen if you put a lock here, but a lock would be
pointless.

So yes, I agree, mark things in rust as "mut" if you are going to change
them, that's good, but attempting to prevent multiple writes at the same
time without a lock, that's not going to matter, if it did, you would
have used a lock :)

thanks,

greg k-h

