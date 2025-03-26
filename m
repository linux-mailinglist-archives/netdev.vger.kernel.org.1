Return-Path: <netdev+bounces-177715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DC7A715F0
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 12:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27623B635D
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA991DDC0D;
	Wed, 26 Mar 2025 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bS8lXcnj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488181DDA3E
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742989148; cv=none; b=oNhRU3rZlC2j/xNlUmkAPMXqbSnO5OZoEcEezlughP6egKUh8m0DSM/gdtKeBx9LKbguqdExK+5wqgEf73LU8oVYKq+JVXRZ8y4ivp6Kr3YcHg2kKwYUcT4IoAFffV8x2eeBwsKrCgSGW2F2bGmwi/43P/m9zMMCTZqliPsytT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742989148; c=relaxed/simple;
	bh=6VobI5ImsegYcGK115583MVGFlEBeW/Xgorsn1Of/8I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDp3Ie6DprqFTntmAJ5AT0nTufELQgK7XRKEnQPiJpeZXDd+s4kQE0XKIBG7yiVdM81V+uruZle4KYNAhM5q8GqH4vPg2kAH2FlQeNDBiPXjT21Hd8jwGR1QetRUyMi3/6v5CD0X6Dqi5yFnQnc1XqaFMqdev/D2wnV8g4QNJgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS8lXcnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F636C4CEEE;
	Wed, 26 Mar 2025 11:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742989147;
	bh=6VobI5ImsegYcGK115583MVGFlEBeW/Xgorsn1Of/8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bS8lXcnj96MO+clCn+655oUqjKD/5SzmkT4sW3uKqI4Ia7sQ4pOrCLwAKeYcw/meO
	 6Ki/5dmZ32fpmeVwhoO/kUZm00FWeYmK/n6Y01bLgUPX9giONQZXspfWXqt6a4vC/l
	 KERjEQ2Yh99t0Ny7FbPPlvxjgA0fKyg0+CGwkOQcZDvXVCl8f7sfZl1OSZtw4DavP5
	 t5sDtIWq1wng3Lv3O4iQegynBGRXmXg02BYebQK7bmwQP5/dW/sF2cCd5FvG8Xgzss
	 9BpVp1I1Tt100V7HczvlWQspSbdUCjSjYB3xiZuq4aGVoMAS6UhSEk3FlKAaEaEDXp
	 v+y506Ma97+hA==
Date: Wed, 26 Mar 2025 04:39:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>
Cc: Jonathan Lennox <jonathan.lennox42@gmail.com>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Lennox <jonathan.lennox@8x8.com>, David Ahern
 <dsahern@kernel.org>, netdev@vger.kernel.org, Stephen Hemminger
 <stephen@networkplumber.org>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri
 Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next] tc-tests: Update tc police action tests for tc
 buffer size rounding fixes.
Message-ID: <20250326043906.2ab47b20@kernel.org>
In-Reply-To: <CAM0EoMnmWXRWWEwanzTOZ_dLBoeCr7UM4DYwFkDmLfS93ijM2g@mail.gmail.com>
References: <2d8adcbe-c379-45c3-9ca9-4f50dbe6a6da@mojatatu.com>
	<20250304193813.3225343-1-jonathan.lennox@8x8.com>
	<952d6b81-6ca9-428c-8d43-1eb28dc04d59@redhat.com>
	<20250311104948.7481a995@kernel.org>
	<CAM0EoMnmWXRWWEwanzTOZ_dLBoeCr7UM4DYwFkDmLfS93ijM2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Mar 2025 07:15:26 -0400 Jamal Hadi Salim wrote:
> > On Tue, 11 Mar 2025 10:16:14 +0100 Paolo Abeni wrote:  
> > > AFAICS this fix will break the tests when running all version of
> > > iproute2 except the upcoming one. I think this is not good enough; you
> > > should detect the tc tool version and update expected output accordingly.
> > >
> > > If that is not possible, I think it would be better to simply revert the
> > > TC commit.  
> >
> > Alternatively since it's a regex match, maybe we could accept both?
> >
> > -        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst 1024Kb mtu 2Kb action reclassify",
> > +        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst (1Mb|1024Kb) mtu 2Kb action reclassify",
> >
> > ? Not sure which option is most "correct" from TDC's perspective..  
> 
> It should work. Paolo's suggestion is also reasonable.

Sorry for the ping but where are we with this? TDC has been "red" for
the last 3 weeks, would be really neat to get a clear run before we
ship the net-next tree to Linus :(

