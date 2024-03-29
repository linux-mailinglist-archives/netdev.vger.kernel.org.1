Return-Path: <netdev+bounces-83145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB67891089
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 02:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235531F22A12
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 01:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2857517999;
	Fri, 29 Mar 2024 01:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8ygBb6H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A998820
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 01:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677000; cv=none; b=KF+I37HwhVAMGfhcGlC0A2x2cBJ5U431svOAQfAtH55Sg8FX6gz19YbfVV9zP1hx70YFUzMGuO+cI3wY1SNSBL7Q26m5AF76t7G6I7Y2QVDGoJH/FwfD13NLHwJfv9x3xEXjHZyrDnF1vhUw63lZvr3hWapeBHicYbGEpWvfY4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677000; c=relaxed/simple;
	bh=EW0qdte+pvWo7EStyNqltxnkl18LVi77cfIxajjVvAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HvKHVBXbipY4OIaliLEsmN+EorUQUC9uU6J/EIZ/hVSulAb2RSkBX0Ewt/OjbR42YraAxW7+sve3+M7jkfKOd3K+2IMChQyUilcmCDHHd5TKNoVtDP9LQh24pyxdk1FamhNJhPJ4iNRq4y7sVB2rXpgt6fADjdnTA3L1IeDjkkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8ygBb6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30540C433C7;
	Fri, 29 Mar 2024 01:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711676999;
	bh=EW0qdte+pvWo7EStyNqltxnkl18LVi77cfIxajjVvAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S8ygBb6HV5Iu0+aD/YX78SGGofNO+tzOmUgQAcgeDEQGcM0Wvdmq+xvYN3EXGHhQe
	 qWLbDB74DeHniNtLcEjeTzBw/yxKNr9ABiO5131y4f3RisaCE01DjQyWnYBqz9xdE2
	 4uipYttliNY41Gye2wBWH1dJfSyi687EFLI94kShoJXuKFToYpDSRsn2BM/icPI2TM
	 lj8aWQl5kYVDgAFmr64WH+rjH+gsUdexpZUh6BzxNNlPilwVN224xgabvVVZuIAT+d
	 eK23X5x36l0W2UjTcRYEvekU6JuH3c5ylevsJ19gXYutqXPbwIAbfkJA1s8E36XypQ
	 Wipm7bGH0HiUw==
Date: Thu, 28 Mar 2024 18:49:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jian Wen <wenjianhn@gmail.com>, <jiri@mellanox.com>,
 <edumazet@google.com>, <davem@davemloft.net>, "Jian Wen"
 <wenjian1@xiaomi.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2] devlink: use kvzalloc() to allocate devlink
 instance resources
Message-ID: <20240328184958.3638e5a0@kernel.org>
In-Reply-To: <40b3371a-5966-4140-922e-7c62a1c73e6c@intel.com>
References: <20240327082128.942818-1-wenjian1@xiaomi.com>
	<40b3371a-5966-4140-922e-7c62a1c73e6c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 11:15:08 +0100 Alexander Lobakin wrote:
> > Changes since v1:
> > - Use struct_size(devlink, priv, priv_size) as suggested by Alexander Lobakin

The change log should go under ---
and would be great to include a link to the previous version (from lore)

> > Signed-off-by: Jian Wen <wenjian1@xiaomi.com>  
> 
> Since it actually fixes a bug splat, you may want to send it with prefix
> "net" instead of "net-next" and add a "Fixes:" tag here blaming the
> first commit which added Devlink instance allocation. Let's see what
> others think.

That's my initial reaction as well. We often treat memory
pressure improvements as fixes. But thinking more we would
need to check if any of the drivers puts a DMA buffer in its priv.
Some FW mailbox, maybe? It's possible.

