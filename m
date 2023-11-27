Return-Path: <netdev+bounces-51488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5E77FADD9
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 23:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6ED1C20A67
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 22:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED29246522;
	Mon, 27 Nov 2023 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6GnLcRJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11292DF91
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 22:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE27C433C8;
	Mon, 27 Nov 2023 22:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701125986;
	bh=oh7Ro2xnOl0HaKcyTyv8bgEiewhMU0QWH63hRtNfhVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D6GnLcRJguk8zm1dA7UE/AuTloaAfgtzCa1sFp8YkxWz2uDzNxiwKHLNBpVTpDoOR
	 QtRnqgO06rjw2AooG6jtLhMnJozl8nwZxSsCI8YupXz7/UfcVN2P4uGfVyp3mJSg+p
	 NYrrnJdtG6pX25jwp1tMuizKszmzubMNrjdvZ3bQZONK6HuzKk5icqdtFw6RpJrJXP
	 aKanlJcW9nJtY0ZZKB1QQfR4omSdeH9aW0XrgMOaem+KbrDszPp4p3R2mOuPmKM+Ey
	 Ce1CwGvKp8yu+qHO8Tv8J1U+eb4LJI3LkSpFTP70AkCqaxt/p7DaovJWBXVF5Ja7y/
	 JvVhzv2TTNEpw==
Date: Mon, 27 Nov 2023 14:59:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Igor Russkikh <irusskikh@marvell.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Netdev
 <netdev@vger.kernel.org>
Subject: Re: [EXT] Aquantia ethernet driver suspend/resume issues
Message-ID: <20231127145945.0d8120fb@kernel.org>
In-Reply-To: <cf6e78b6-e4e2-faab-f8c6-19dc462b1d74@marvell.com>
References: <CAHk-=wiZZi7FcvqVSUirHBjx0bBUZ4dFrMDVLc3+3HCrtq0rBA@mail.gmail.com>
	<cf6e78b6-e4e2-faab-f8c6-19dc462b1d74@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 18:29:19 +0100 Igor Russkikh wrote:
> > Anyway, I suspect a fix for the fatal error might be something like
> > the attached, but I think the *root* of the problem is how the
> > aquantia driver tried to allocate a humongous buff_ring with kmalloc,
> > which really doesn't work.  You can see that "order:6", ie we're
> > talking an allocation > 100kB, and in low-memory situations that kind
> > of kmalloc space simply isn't available. It *will* fail.  
> 
> Correct.
> It seems after some series of pm-related changes the driver logic was changed to always
> reinit full sw structures during suspend/resume, which is obviously an overkill.

Another option you can consider is lowering the default ring size.
If I'm looking right you default to 4k descriptors for Tx.
Is it based on real life experience?

Longer term hopefully the queue management API will help drivers
avoid freeing memory at suspend. We'll be able to disarm and
unconfigure queues without freeing the memory.

