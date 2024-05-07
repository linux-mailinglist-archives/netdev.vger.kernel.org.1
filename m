Return-Path: <netdev+bounces-94269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CD88BEE7A
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 22:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ACFF1F260F8
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 20:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F7C58AB8;
	Tue,  7 May 2024 20:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8n08C8V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B493754BDE
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 20:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715115530; cv=none; b=Km1Jo7EQrTnDpt3W91tLl5dbdc1MbZEkai3Vd3P9h+PNHSrDASGAvURBRDM6H8rnzCupM8NC3wODv67MO1Xz/kX2IGni3PkiMTaSoSc0EyvijQenw7mHpOgM1ajNk2rc1P5yr+VCcnBywg8RmZZwV7pmpOFI3H1+WUGs6ea+wN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715115530; c=relaxed/simple;
	bh=KzEUZd3EIMjbtwdetN3LWBzaE4zcd+kg/9d5EPEoH58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZhbPgLn4oEGE7DEZ3ANNucxeNLw4JPYqEoa7lxuKPWtkqgZfW4F6LCjv8L7kpTcSpILO1za+IodVdiRXhCef44pnMjfSgiek/wOcn5KEJlY/2C+ZsdBC5brhohRh2j7ScLRShbqGjOzU+cDMOGory9PhKEB/cT4GY2jgdVlPY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8n08C8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DAFC3277B;
	Tue,  7 May 2024 20:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715115530;
	bh=KzEUZd3EIMjbtwdetN3LWBzaE4zcd+kg/9d5EPEoH58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S8n08C8VnADOTv1HSHQim1dLPY68xDd3MH/A9YJDuoJdW4z/dABV7KDpyJtV5WuAk
	 VaKtExr3vYl33jneoSpEw33Fy4JVT6lTcAZzYERS12gUDB8TAxQ/b4MLa6Gl4c6Pk5
	 U17wagJCicKI8m6Y1H1vmjR6mu8sEfIjGK6O3aC6Up48IZhNV1q+VeKxgPJjsLZxXS
	 YdTVEUSSVnxmt2hrxZB9pyce90rXZc32zNToaq/W5WBnur1yckCooR3SEApWR6wbcw
	 RxeT5+9BNynWZvODEFyAIj6jUdU8Lc6jBaDxyrS/isdiSzs9K6aKZnsRbOMDMEPzYa
	 o7taK6Q1FeMzg==
Date: Tue, 7 May 2024 13:58:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: David Ahern <dsahern@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq
 Toukan <tariqt@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Andrew
 Gospodarek <andrew.gospodarek@broadcom.com>, "michael.chan@broadcom.com"
 <michael.chan@broadcom.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>, Alexander Duyck
 <alexander.duyck@gmail.com>, Willem de Bruijn <willemb@google.com>, Pavel
 Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Shailend
 Chand <shailend@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>
Subject: Re: Driver and H/W APIs Workshop at netdevconf
Message-ID: <20240507135848.7abcce23@kernel.org>
In-Reply-To: <CAHS8izPUZC+66cRfiakQrVD5qrjd7S+=FLJSwCF4_esmYpf6mA@mail.gmail.com>
References: <c4ae5f08-11f2-48f7-9c2a-496173f3373e@kernel.org>
	<20240506180632.2bfdc996@kernel.org>
	<CAHS8izPu9nJu-ogEZ9pJw8RzH7sxsMT9pC25widSoEQVK_d9qw@mail.gmail.com>
	<20240507122148.1aba2359@kernel.org>
	<CAHS8izPUZC+66cRfiakQrVD5qrjd7S+=FLJSwCF4_esmYpf6mA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 May 2024 13:40:08 -0700 Mina Almasry wrote:
> > Otherwise it makes sense to cover as part of your session.
> > Or - if you're submitting a new session, pop my name on the list
> > as well, if you don't mind.  
> 
> I'm not thinking of submitting a new session tbh, but I could if you
> insist.

Not at all.

> Tbh I'm worried we have too little content for the devmem TCP
> + io_uring talk as-is. Could we dedicate 10/15 mins of that 30 min
> talk to queue-API and add you to it? AFAICT I'm allowed to edit the
> list of presenters and resubmit the talk.

SGTM!

