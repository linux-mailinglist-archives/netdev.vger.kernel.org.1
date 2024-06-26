Return-Path: <netdev+bounces-107012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21259187BD
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 18:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23971C20F79
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B853618F2FB;
	Wed, 26 Jun 2024 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFH8hC+6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9462C18F2F7
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420256; cv=none; b=YvPGYLtN/UXxAejlNK3dIr42d2YIdh63zzhkM5JbuMtFiml4DmOcVWLungiUlVVrb1Bw2PdfesKQAsRFMAgu+YkOpg0fhGQnsnG6WrNC6T8fVyc5U0hwZZPp6cCISa79GC9kGGu1ico5Pe39S0DPTqkdDxgXnqSkjjy4p+oTn+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420256; c=relaxed/simple;
	bh=Z4avBptB/zQdI6ziacvKRIeJmsT91+gmnbtbdz7HIZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKrIA0v3CzqAxoCP3M9IN6Fm5kZkPOpA7jo7jEX6UaJ31UI27kcl5buQ6bqvcBj1ZmNukHhSUo4PXqBQlXa9V5Vg7KSMYrtU9jA8G+7HzHfnUMuop0OZomulgOpfbFcyMYCpI2R7/6zGTd/qnar/cU3YxgoG1Ahl5becPHJEg8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFH8hC+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96B7C116B1;
	Wed, 26 Jun 2024 16:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719420256;
	bh=Z4avBptB/zQdI6ziacvKRIeJmsT91+gmnbtbdz7HIZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AFH8hC+6tgrLM74Kp1FG4xV9BNaA/9o8OF5TRzG+XsxaQXifMoBztqwU7ab2PpLbK
	 7NNzptrU2FPO0+6GkOwZooush09EGQWHjyXnLyOD0L+ytavTCgnXcP9B6QmlIQ7TAi
	 y2lljM1gB6IVocm8WNoOte+ni7dfgSPz51wWTMxwOpkeXd5LlrJge4S//klB0nMtLp
	 JpyFI3/VDhDIwVo3hVcdq/6e9r/D+4Y+KfPlImuiaHlI1ZVVDWOuELl6bBWisG0zBM
	 b3xKdww35uOUzd69Jm3nHHFMOnIpE/ylHlUCH7m8HoM7crfSp1WeLTkdxVE2pucq3v
	 dYToJxF0HxwCw==
Date: Wed, 26 Jun 2024 09:44:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
 <willemdebruijn.kernel@gmail.com>, <leitao@debian.org>,
 <davem@davemloft.net>
Subject: Re: [RFC net-next 1/2] selftests: drv-net: add ability to schedule
 cleanup with defer()
Message-ID: <20240626094415.7ae5afe8@kernel.org>
In-Reply-To: <87tthg9hvv.fsf@nvidia.com>
References: <20240626013611.2330979-1-kuba@kernel.org>
	<20240626013611.2330979-2-kuba@kernel.org>
	<d7a8b57d-0dea-4160-8aa3-24e18cf2490e@intel.com>
	<87tthg9hvv.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 11:19:08 +0200 Petr Machata wrote:
> >> There is a global action queue, flushed by ksft_run(). We could support
> >> function level defers too, I guess, but there's no immediate need..  
> >
> > That would be a must have for general solution, would it require some
> > boilerplate code at function level?  
> 
> Presumably you'd need a per-function defer pool.
> 
> Which would be naturally modeled as a context manager, but I promised
> myself I'd shut up about that.

No preference on the internal mechanism :)

The part I was unsure about was whether in this case test writer will
want to mix the contexts:

	fq = FuncDeferQueue()
	fq.defer(...) # this one is called when function exits
	defer(...)    # this one is global

or not:

	defer_func_context()
	# any defer after this is assumed to be func-level
	defer(...)

so probably best to wait until we have some real examples.

