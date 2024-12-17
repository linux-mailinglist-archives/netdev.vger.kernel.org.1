Return-Path: <netdev+bounces-152620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129519F4E7D
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E35F16F14D
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184E71F8AE7;
	Tue, 17 Dec 2024 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F16nPW5l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFE81F8ADD;
	Tue, 17 Dec 2024 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447093; cv=none; b=X5NGZNdH0jDVBlv+j40Zw3c2yHifDR6e/ZBqTd2jRxAxcHcJiSvRQemN7IYqiDm4A4D8K7gOA7OzuFrmXmbore89p4fVtzdif0zhnzM4yEOnW7eZT6ZaPOcEuMvR5Il5XFOgGk5211NIp7aHHvbKnyVpIKGe/bhHV+CljYo2vME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447093; c=relaxed/simple;
	bh=eFGnliowovdHOsu+bslUKKaWUkcjdc40HYBeZnV12gA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mk7/38oOnJ0TDfB51rSVdwOu6HKjA/Ig30NScp/JIj6r6AkU0U0+Y5vieaNVKBfoKi3l3bujkYlc5aaZQjIkDbBa9gbgu/Barsq4+cmZ4YwYBwiZrMfRrUaQAPfXFDXmQUvSX2qhHuSGAUZBoYIxCDf0+WEtcqLhernvTO2kH+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F16nPW5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3165EC4CEF3;
	Tue, 17 Dec 2024 14:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734447092;
	bh=eFGnliowovdHOsu+bslUKKaWUkcjdc40HYBeZnV12gA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F16nPW5lRJAkNIwKjKEdOkt6XTXleDEtofOg3PhSA9Qx8RcQsLcqy53K1gU/J6eUG
	 MN6v8DFyuQjRIt7IjNmOzZT9xwFnSLGyLDNY8FHbXAug+HBux+iVt4+Ge2IcvkeIBM
	 ruC+ggNWjNa399aGQ4VvNZ9GOyF/ARj08wzWdTcEZyo7xk73triQmSagGJyCZzWeO7
	 vANTALQBdZvkcVa7NQYD9LcCMrxJ6D556QLT9yrXsm/M9kJI2d4nOuSG9Ksao2P5LC
	 DOpn2IARxxpQAau582RZUXRDxW6tpI7xAMrEW4oR5oLO8EeIeq20hl2o9P0VsHLpCO
	 A1R/9IHg+rkgw==
Date: Tue, 17 Dec 2024 06:51:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Li Li <dualli@google.com>
Cc: Carlos Llamas <cmllamas@google.com>, corbet@lwn.net,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, pabeni@redhat.com,
 donald.hunter@gmail.com, Greg KH <gregkh@linuxfoundation.org>, Arve
 =?UTF-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, tkjos@android.com,
 maco@android.com, "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 brauner@kernel.org, Suren Baghdasaryan <surenb@google.com>, arnd@arndb.de,
 masahiroy@kernel.org, bagasdotme@gmail.com, horms@kernel.org, LKML
 <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, Hridya Valsaraju <hridya@google.com>, Steven
 Moreland <smoreland@google.com>, Android Kernel Team
 <kernel-team@android.com>
Subject: Re: [PATCH net-next v10 2/2] binder: report txn errors via generic
 netlink
Message-ID: <20241217065129.10677f69@kernel.org>
In-Reply-To: <CA+xfxX6-cbTyyyTf1UL_A7DzagfrV+y0367MdO21+JdjW870ZA@mail.gmail.com>
References: <20241212224114.888373-1-dualli@chromium.org>
	<20241212224114.888373-3-dualli@chromium.org>
	<Z2BtgqkPUZxE8B83@google.com>
	<CANBPYPhZ-_5=VMRoBxbfVb+AFb_qu49QH_hKOiSjX93E1GQA8A@mail.gmail.com>
	<20241216174111.3fdce872@kernel.org>
	<CA+xfxX6-cbTyyyTf1UL_A7DzagfrV+y0367MdO21+JdjW870ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 19:53:40 -0800 Li Li wrote:
> > > These are automatically generated from the yaml file. So let's just
> > > keep them as is.
> > > But it's a good suggestion to the owner of yaml parser.  
> >
> > I think the unusual naming comes from fact that you call your netlink
> > family binder_netlink. It's sort of like adding the word sysfs to the
> > name of a sysfs file. I mean the user visible name, not code
> > references...
> >
> > s/binder_netlink/binder/ will clean this up..  
> 
> I did consider that but unfortunately that would result in a
> conflicting binder.h in uapi header.

What exactly is conflicting? The name of the header itself?
You can set the uapi header name using the uapi-header property.

