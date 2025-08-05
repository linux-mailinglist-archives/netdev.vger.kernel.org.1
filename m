Return-Path: <netdev+bounces-211837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD784B1BD96
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 01:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6869C3B4E0A
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 23:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC0F23C8AA;
	Tue,  5 Aug 2025 23:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svnOlu0z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A69E524F;
	Tue,  5 Aug 2025 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754437948; cv=none; b=cELJvMEfHsrLaRjs4rIjTijXmWrZVwP/8dLVgV1iCbWbu0x/ZbClz6mc1uZxwbeiIVth4lCbl/TH3A4oEzY8pn94O42dYZwCR1/te1G4oH5LVdq18nNnbBSphKeLF8kldg4spJSX4+kLXJOSfJF6rIY2ZVW90XZpD7Hjaz/oJH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754437948; c=relaxed/simple;
	bh=5wavID5SgygKJxkFM1G23hW3NF+9pXSnkSpRBS/F6so=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRmo+t9kMc8iQNuPnFx6M8VfNLwH8ERsyTbJgUowTLIdI3378ftPn1idyIu36DBxjy1GkHuj7/zMH59ajL2BVn/8ToWH1oxUOMfy2Y3nwRSRAWsN6XVhU6Dwa/6PTg+2SWyg4K/qEPrFEpIJdDXHWh/kUo+ULh6V1dwCiWhYq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svnOlu0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21025C4CEF0;
	Tue,  5 Aug 2025 23:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754437947;
	bh=5wavID5SgygKJxkFM1G23hW3NF+9pXSnkSpRBS/F6so=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=svnOlu0zFg4o4SUroMqabzFjHOZ7aAcQOayqdYK6IDdAVfyQFZkwuGXQ4uqaD/+IT
	 k88dV+UX8pCZPAXKkqEuacQP85L7Y9I4XBkHu7em8l/N5kGyEqTWBHNTKhymxBPRLs
	 skkTjzPyySD6PzYWSNQdxY0URpNu+Mkx2c6f0Qn+5dNoVe8YgrEeHmIsuVvU3WPOhB
	 dbj9J/GFgyW4Q3d7MDFM9IuacQqsIrCbuM1PtMqr8awst6GJttuSEYl04eKqbJOEYp
	 3t7X9/AsbJTLw9PszjlTHaNHvso+jTWQcH3zBBJLZC/0GjAWJkSkCq3RS3VxJazixL
	 vtmsR5GlGj2hQ==
Date: Tue, 5 Aug 2025 16:52:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: tglx@linutronix.de
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Jeongjun Park
 <aha310510@gmail.com>, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 yangbo.lu@nxp.com, anna-maria@linutronix.de, frederic@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com
Subject: Re: [PATCH net v4] ptp: prevent possible ABBA deadlock in
 ptp_clock_freerun()
Message-ID: <20250805165226.5e52e8a9@kernel.org>
In-Reply-To: <20250729154811.a7lg26iuszzoo2sp@skbuf>
References: <20250728062649.469882-1-aha310510@gmail.com>
	<20250728062649.469882-1-aha310510@gmail.com>
	<20250729154811.a7lg26iuszzoo2sp@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Jul 2025 18:48:11 +0300 Vladimir Oltean wrote:
> > +static void ptp_vclock_set_subclass(struct ptp_clock *ptp)
> > +{
> > +	lockdep_set_subclass(&ptp->clock.rwsem, PTP_LOCK_VIRTUAL);  
> 
> Just not sure whether the PTP clock should be exposing this API, or the
> POSIX clock, who actually owns the rwsem.

Hi Thomas, how do you feel about PTP setting lockdep class on the clock
rwsem? Link: https://lore.kernel.org/20250728062649.469882-1-aha310510@gmail.com

