Return-Path: <netdev+bounces-141588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CBC9BBA29
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 17:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ECD6B22451
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11401C4A0A;
	Mon,  4 Nov 2024 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yd/WUUTD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B481C3306;
	Mon,  4 Nov 2024 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737170; cv=none; b=djc+IyiZxwHKm8dTqmsN5HDkc9C3SLZgjrTeq3tyqrE2/JLYEAybOT5IyM6fS15Mgn5LKdvNW/3l+4FG4p7/WLT21/SsXtcKrr8rlaoc/wUxVCY3hxVhIqAtuRCt5QtIYcX33JzI3NVn9/LhaOIjSsSqqRBn3dNELWVgMBdsxho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737170; c=relaxed/simple;
	bh=Ker+jU5B5xJ8qmLEeFWhwdk8dS9RSWc1QCh5i90moJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZVlTygo2dGti7CRd1YFJE2A1CLWM1pXKNJdmZrLGqfrCd7g7en6NLIUUu0yQnKGvXebAH4EvW97OhsvWWwfymLUa9scYKMNg12KEN3c/9RALuJf/5PzZmS0YKc8LavuNRQTwJ4g23JSkA+ombosULvqs/AU3c1/yVwljN8gTAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yd/WUUTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B897C4CED1;
	Mon,  4 Nov 2024 16:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730737170;
	bh=Ker+jU5B5xJ8qmLEeFWhwdk8dS9RSWc1QCh5i90moJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yd/WUUTDpVlQs9pQnCxdO9eOg6GXaO+GxpAA4/xWSM/zUHCTb4IH+lu73vE7pCCO4
	 9O9B/iLRR2PKOm1nut/JxCYuVO+XK7UcT8CtgCW0WdgnYxV/eLEZCB3WPuJWvmNrRJ
	 Z24ogMpLNNWW4oxuRBWv/0cHEIjzvN6jQjuAGPmMOkmqFAsC1ZPSlHcQc9GZwRFNhs
	 Qhtr/SakeyXE3LzwS+Tn8h8iT+mck1R2qEMu3hRA4WGATM5vek59m1HwXaL4Mewtot
	 ihFhnl9tmu4ns8LTs54s8M/uyVJ8HniuKq65b5Qsey02RMYIVGH9oVLXql+L+lz39y
	 m0vcmyPX3Vt6A==
Date: Mon, 4 Nov 2024 08:19:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, donald.hunter@gmail.com,
 gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
 maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
 cmllamas@google.com, surenb@google.com, arnd@arndb.de,
 masahiroy@kernel.org, bagasdotme@gmail.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, hridya@google.com, smoreland@google.com,
 kernel-team@android.com
Subject: Re: [PATCH net-next v7 2/2] binder: report txn errors via generic
 netlink
Message-ID: <20241104081928.7e383c93@kernel.org>
In-Reply-To: <CANBPYPj4VCYuhOTxPSHBGNtpRyG5wRzuMxRB49eSDXXjrxb7TA@mail.gmail.com>
References: <20241031092504.840708-1-dualli@chromium.org>
	<20241031092504.840708-3-dualli@chromium.org>
	<20241103151554.5fc79ce1@kernel.org>
	<CANBPYPj4VCYuhOTxPSHBGNtpRyG5wRzuMxRB49eSDXXjrxb7TA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 3 Nov 2024 22:25:44 -0800 Li Li wrote:
> > You're trying to register multiple families with different names?
> > The family defines the language / protocol. If you have multiple
> > entities to multiplex you should do that based on attributes inside
> > the messages.
> 
> My initial plan was to use a single "binder" family, which was more
> straightforward and cleaner. As Android uses multiple binder contexts
> to isolate system framework and vendor domains[1], Grek KH suggested
> the netlink messages from different binder contexts should also be
> isolated for security reason[2]. Personally I'm fine with either
> approach. Please kindly advice which implementation is better.
> 
> And I'll fix other issues you mentioned above.

Greg is obviously right, but using different family names will not help
you in any way. There is no action of "opening" a socket for a generic
netlink family, one generic netlink socket can talk to all families.
The only built in checking netlink provides is that you can declare 
an operation as requiring admin privileges, or network capability
(namespaced or global).

Unless those are good enough for you - I think you should do all 
the security isolation within your code, manually.

