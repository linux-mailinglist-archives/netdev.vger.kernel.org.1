Return-Path: <netdev+bounces-169868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22926A46107
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 14:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC8F189B65C
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 13:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1993318B492;
	Wed, 26 Feb 2025 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvX0hNjk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C152153C5;
	Wed, 26 Feb 2025 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577091; cv=none; b=Uj0yvox86ikrHdrybnyNp8GqF8fA74PfAwG5Kvy+769+XgXEywwXxh4B6tGK1yebYZ1/Bm2m8vP/YZ7m5LfWtnxn2X4SPAUOvG3lTxLiwsvN6j/A9VS3tepwSdodfvxnrlUYw0Vg+gsi3CjecDYeiZCvZ88Kp+/nXsgL78Z10ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577091; c=relaxed/simple;
	bh=Gc/QJn44eJJBvjOF0aRaRt1WC1pvNCLBm5b+Gn2qFuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQ7YNK6PjVOuW5aRi09uiJauPF2T7lvE8H2vQx8gEsTYkeF4cPzQlAszXxusuL5uxhUTc2C9AdjTHHXZUBRxrXDp8PlzaCiokWzK2AyzAtRS4rAQL/GNCkeN26NkoqDVkEtmqBTMdcyv+vLBZn4gFZaqSMgmjw/LHJzT+Q6kSBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvX0hNjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB54C4CED6;
	Wed, 26 Feb 2025 13:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740577090;
	bh=Gc/QJn44eJJBvjOF0aRaRt1WC1pvNCLBm5b+Gn2qFuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BvX0hNjkB0u6rZgM0hzJN93mEnXBTCwIaGUlpgcFtdAYHuPYahsAVO0Lw54LfN2ns
	 WCddzFFspE2mKDC8JrZ+D04bN9IMDRDnwYaPqzQmTK5cTL+7E8F9GWonrY4m2z3vr/
	 BFkRb0HIj67oOGZ8GjYpG9rRw61la1iOFUEyDuPOR67Tw3NaEK5PdPufiAtGA85rmT
	 /8/W5UoPWfSmcQMystU/S/mUwVMh4N4XaUBvkX2wk3fMFSx4L84N5slRzYgU2r5XkX
	 PYQan9w6qqlnIBo+n82SX9nUTgXR1hVK5ifVmq6KRpUhjbH1xtEQPDAhge2acgnAgx
	 YxYUqEihcQDKg==
Date: Wed, 26 Feb 2025 14:38:07 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Joe Damato <jdamato@fastly.com>
Subject: Re: [PATCH net v2] net: Handle napi_schedule() calls from
 non-interrupt
Message-ID: <Z78ZPyYrzK5l6P6e@localhost.localdomain>
References: <20250223221708.27130-1-frederic@kernel.org>
 <CANn89iLgyPFY_u_CHozzk69dF3RQLrUVdLrf0NHj5+peXo2Yuw@mail.gmail.com>
 <Z78VaPGU3dzKdvl1@localhost.localdomain>
 <CANn89i+3+y1br8V4BP5Gq58_1Z-guYQotOKAr9N1k519PLE7rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+3+y1br8V4BP5Gq58_1Z-guYQotOKAr9N1k519PLE7rA@mail.gmail.com>

Le Wed, Feb 26, 2025 at 02:34:39PM +0100, Eric Dumazet a écrit :
> On Wed, Feb 26, 2025 at 2:21 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> 
> > That looks good and looks like what I did initially:
> >
> > https://lore.kernel.org/lkml/20250212174329.53793-2-frederic@kernel.org/
> >
> > Do you prefer me doing it over DEBUG_NET_WARN_ON_ONCE() or with lockdep
> > like in the link?
> 
> To be clear, I have not tried this thing yet.
> 
> Perhaps let your patch as is (for stable backports), and put the debug
> stuff only after some tests, in net-next.

Ok.

> 
> It is very possible that napi_schedule() in the problematic cases were
> not on a fast path anyway.

That was my assumption but I must confess I don't know well this realm.

> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!

