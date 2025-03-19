Return-Path: <netdev+bounces-176217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF2CA6961C
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D691178A5F
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBDC1EDA00;
	Wed, 19 Mar 2025 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="V9hZbCuI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2C41F4C8F;
	Wed, 19 Mar 2025 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404417; cv=none; b=AVNrNquRiSevD3OsqEu/nxR23Wnb/XwUjNZeClfxeS6gSwytGC4bEfQpMeiWOYxEuKlmKZRuGj6YteWG5MGRuk+QALQyNulcMAFayph6SqCOhh0mwKw0nO5yxsUl0LObd48YUDoffQI6bdM0MlLQHj1F5RoGNbH5e9tvpiM8xig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404417; c=relaxed/simple;
	bh=30oTOjJkUh8xHQT9ze5OgXmT+0f3Fe1IsJfzjTzic7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KseWjoe4JF4dbDQ0DrZNv+Z8ZvIBcoQX0zNFNR1SHcwf8xFyQIuH5RXbyAe3DbK1j5JrTb1WNvVO6khaqtYHDp7uqQhcRab+7tRn1SYIw4h8L6H+9NieppSaIRRmfZk8WOF+hNGQ0V/qqH4fQgwdaDFiE35R34+ZfqBSSUfn4GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=V9hZbCuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2540C4CEE9;
	Wed, 19 Mar 2025 17:13:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="V9hZbCuI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1742404414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ezPW8Ofll5jcvPOM6XGPTr1u1TQa1b4BIgp62sYV2Oo=;
	b=V9hZbCuIKbNh2yo4Rio59GzMwMrTXLGYBYQenS3/BjJcent7rcxiADyKHRY1TBhfNbN4xD
	lQvl3aDfhRCsnB87O19jWcftG8jD09Nx5fK7wQsxNQth0OO/Jps3aZEpX5VniaiGSr56xl
	BmZM3I+d4zomsVUol/OMthurcaTEUYU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1495fefb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Mar 2025 17:13:33 +0000 (UTC)
Date: Wed, 19 Mar 2025 18:13:29 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Markus Theil <theil.markus@gmail.com>, linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, netdev@vger.kernel.org,
	tytso@mit.edu
Subject: Re: [PATCH v2 1/3] drm/i915/selftests: use prandom in selftest
Message-ID: <Z9r7ORwztMxsNyF4@zx2c4.com>
References: <CAHmME9oqvWp_Nd1Gwgyw52qy8wxztMyCpNsjByH=VnRaXqczww@mail.gmail.com>
 <20250211063332.16542-1-theil.markus@gmail.com>
 <20250211063332.16542-2-theil.markus@gmail.com>
 <Z64pkN7eU6yHPifn@ashyti-mobl2.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z64pkN7eU6yHPifn@ashyti-mobl2.lan>

Hi Andi,

On Thu, Feb 13, 2025 at 06:19:12PM +0100, Andi Shyti wrote:
> Hi Markus,
> 
> On Tue, Feb 11, 2025 at 07:33:30AM +0100, Markus Theil wrote:
> > This is part of a prandom cleanup, which removes
> > next_pseudo_random32 and replaces it with the standard PRNG.
> > 
> > Signed-off-by: Markus Theil <theil.markus@gmail.com>
> 
> I merged just this patch in drm-intel-gt-next.

This is minorly annoying for me... What am I supposed to do with patches
2 and 3? Take them through my tree for 6.16 in like half a year? Can I
just take the v1 into my tree and we can get this done with straight
forwardly? Or do you have a different suggestion for me?

Jason

