Return-Path: <netdev+bounces-119299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8231C95519D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11131C21C1F
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B471BDA8C;
	Fri, 16 Aug 2024 19:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sv+EH4aM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597D476F17;
	Fri, 16 Aug 2024 19:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723837621; cv=none; b=uTsgsZlrJnqeWoJa1VhQe+m7YvUVdj4QqOAM+GJxYBiFkTlIDitJ80dHBYVpSzQ4s4jKiQxmWeNbGemwQwv7I89pK5Bw4emLVNX/iC691+/iJX4OgoLGqxOInjx6mwCiIjvpJ8k/skNjlKPWQe2L69YEn/7omxn3mXTG16jKqyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723837621; c=relaxed/simple;
	bh=H8Y81IQWzbYq2YBb+mZ8tpO2qPzX+woWH5fF4c1cPd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyZp3DnxuWddB8ssay1Srk1Mnn6Xw9O3EvdvjTkD/HN0vtmiHgbu+XyTz50wqM4sw3/O3n28gOkYStxtSr4sSgwP+eanT7CWlKvUbsPSy/egeCdnv6kk/Ty25ohZR+vO94RAgrO0cz3Vkpl0jYmRR9Hzp1n8MFXy865BTaneaS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sv+EH4aM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9411C32782;
	Fri, 16 Aug 2024 19:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723837620;
	bh=H8Y81IQWzbYq2YBb+mZ8tpO2qPzX+woWH5fF4c1cPd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sv+EH4aMx1LGLQqLz+vizNIef7ewswCmP3Ts0SYX1Qx8t33g1MU05giqvdaOHWedX
	 cn1qFtJjUl/IyEHuu0FdYcDtCCMWDRUriPXUkJLoORPTxaXeLfSyzNhnl8zICzNPSw
	 T9CB69puz/Qcq936Oqg9IzAhv7rdxoT2mMie74T+OtCcagiCJX0mco3QZsXPLMFq8K
	 X42hiKkhwP6cMdhNZSFjabZQdVmKtZE6DpPxPoy2qfXj39vYVuv9hu+3zFIUB/YIup
	 xYBGuCEqOgqBq9LKp9E1Su9qvRM/LQa/b7WxW49wDvk3wfwniHeOU2zLC+MfFovOmA
	 pSEszsCbvopgA==
Date: Fri, 16 Aug 2024 12:47:00 -0700
From: Kees Cook <kees@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Breno Leitao <leitao@debian.org>, Justin Stitt <justinstitt@google.com>,
	elver@google.com, andreyknvl@gmail.com, ryabinin.a.a@gmail.com,
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org,
	asml.silence@gmail.com, netdev@vger.kernel.org
Subject: Re: UBSAN: annotation to skip sanitization in variable that will wrap
Message-ID: <202408151400.614790C62@keescook>
References: <Zrzk8hilADAj+QTg@gmail.com>
 <CAFhGd8oowe7TwS88SU1ETJ1qvBP++MOL1iz3GrqNs+CDUhKbzg@mail.gmail.com>
 <Zr5B4Du+GTUVTFV9@gmail.com>
 <1019eec3-3b1c-42b4-9649-65f58284bfec@kernel.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1019eec3-3b1c-42b4-9649-65f58284bfec@kernel.dk>

On Thu, Aug 15, 2024 at 12:40:12PM -0600, Jens Axboe wrote:
> On 8/15/24 11:58 AM, Breno Leitao wrote:
> >> 1) There exists some new-ish macros in overflow.h that perform
> >> wrapping arithmetic without triggering sanitizer splats -- check out
> >> the wrapping_* suite of macros.
> > 
> > do they work for atomic? I suppose we also need to have them added to
> > this_cpu_add(), this_cpu_sub() helpers.
> 
> I don't think so, it's the bias added specifically to the atomic_long_t
> that's the issue with the percpu refs.

Yeah, the future annotations will be variable attributes, so it should
be much nicer to apply.

-- 
Kees Cook

