Return-Path: <netdev+bounces-152455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA5C9F401E
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 02:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5E118861C2
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 01:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B904F42AAB;
	Tue, 17 Dec 2024 01:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvtYlZ6F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD642AA5;
	Tue, 17 Dec 2024 01:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734399674; cv=none; b=nLx6Z6bV3J/BBHg/lV7E4PCGEIno2+H8m8abV3q1gDMbkxGV9VBj/ZffT862Zb7GyP2oa7DeTT1Yl/LIxFg6A2y6wdNTqT3/f5UJIWRzWXPg9Edo6PTIdlo/M6f91tjs+vS+efFrTsewEDrG62yHtFUVU7V0XJcfxMdgxeOn6IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734399674; c=relaxed/simple;
	bh=Yi5zbiIgkETA3XJDjNczB+71CpdRuklQaY7FOSxagIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7MnLaZwVbvgrS1/5LPxxPad7NWU9IIaQuTg7OR291UAJdJM4vhu+XnuU0ndpAo0f7ok7qLJyUGk17X9ueIx1rRe5q/cvW6F6VQWUmRbK6tz6hfQvf8HHQzEODKaSiE48pvyIiImacnlobisBuHfqpLXYeXAV3BUhsP963vRe+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvtYlZ6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D2FC4CED0;
	Tue, 17 Dec 2024 01:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734399672;
	bh=Yi5zbiIgkETA3XJDjNczB+71CpdRuklQaY7FOSxagIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fvtYlZ6FZFWFWuMVK8ijDSxnXwZqx6RPgYpMYKIlFtIG7u6ds3fbhPvYiFUobXZFP
	 uljedpsiGONDh3FbqcR1jBW+aQRGsyO3MDDBdLxHrZ5wbRxnz58iKPvJIUtDA3O63q
	 fJpgzT4rjINF4XRvaabbUGZfJF7g9Yb0hHgRAges6W0OD+NDF+2JiZ5qdCiuUIe5kW
	 TEzpuUHoYcDwLy9FlydivNdRUdhtWukHaSipoKVNtn7ubHOiqa/gWWOuqH91t/V7Jo
	 +Nxn+2dnMlgn1nwZ37TakKiDdAYnSVY/1xKRD0+GKCgl9BC5nvoI80ylZHhfFPDWxr
	 xh3iCGSCGa1Pw==
Date: Mon, 16 Dec 2024 17:41:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Li Li <dualli@chromium.org>
Cc: Carlos Llamas <cmllamas@google.com>, dualli@google.com, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com,
 tkjos@android.com, maco@android.com, joel@joelfernandes.org,
 brauner@kernel.org, surenb@google.com, arnd@arndb.de, masahiroy@kernel.org,
 bagasdotme@gmail.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org, hridya@google.com,
 smoreland@google.com, kernel-team@android.com
Subject: Re: [PATCH net-next v10 2/2] binder: report txn errors via generic
 netlink
Message-ID: <20241216174111.3fdce872@kernel.org>
In-Reply-To: <CANBPYPhZ-_5=VMRoBxbfVb+AFb_qu49QH_hKOiSjX93E1GQA8A@mail.gmail.com>
References: <20241212224114.888373-1-dualli@chromium.org>
	<20241212224114.888373-3-dualli@chromium.org>
	<Z2BtgqkPUZxE8B83@google.com>
	<CANBPYPhZ-_5=VMRoBxbfVb+AFb_qu49QH_hKOiSjX93E1GQA8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 10:58:10 -0800 Li Li wrote:
> > not: There are several places where you have "netlink_nl" which seems
> > kind of redundant to me. wdyt? IMO you should drop the "nl" in all of
> > these cases.
> >  
> 
> These are automatically generated from the yaml file. So let's just
> keep them as is.
> But it's a good suggestion to the owner of yaml parser.

I think the unusual naming comes from fact that you call your netlink
family binder_netlink. It's sort of like adding the word sysfs to the
name of a sysfs file. I mean the user visible name, not code
references...

s/binder_netlink/binder/ will clean this up..

