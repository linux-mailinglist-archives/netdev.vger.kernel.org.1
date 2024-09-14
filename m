Return-Path: <netdev+bounces-128355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2162B9791C8
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 17:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4181F22578
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 15:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018E11CFED3;
	Sat, 14 Sep 2024 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uw9Co81K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1591FB4;
	Sat, 14 Sep 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726327404; cv=none; b=Dsle9El6/Ikv61NZISDbejwFVs1Aquke3EXWUn8IcJXDNqDn7/pddmDJtEyAEtsygzuJl8marXODHqF3R/EK43GwR0s5C48Ju33Nj/v11R8wkD8HiDRzR1oqFXSCd3myGqqteieCDY1hyaSVbbuK1cEusR4W1lgoZ4X8rBxhlko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726327404; c=relaxed/simple;
	bh=S3g2qFu+Tw39TPX2ZuDZ+NSMZfRiC87HxdyEsbWt7m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1vE1YloJot5RZmNWcbtdA8qeE5gqEJgY7TUk3mzCsa04AnOm3AR4bTxUiN1BamMuXEwFP6Vx4ekIiia9cFAEFkQ5hN3BDylqH3zba3Mdg5gJhNXrVtHgjtzx46wIisbLxVVCnA1sptb0MvTkJb5rTjw6vx7LSHNjv2rF/MZ4Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uw9Co81K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551B1C4CEC0;
	Sat, 14 Sep 2024 15:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726327404;
	bh=S3g2qFu+Tw39TPX2ZuDZ+NSMZfRiC87HxdyEsbWt7m4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uw9Co81KaNKxpj509CLQc1u43M3vuDDWThw8X5UDRJBsX9iA5Q553rIL5DF8F/skf
	 uD+z2P5JQvVLwbLA1osqXLLoxERAP3awUiWJSAVQyzCnXprKqdfDqLJfdgXqSD37M9
	 eYZP64aCzzLSxdA1zZNYU/bP2o1G+XIfAaa3hGh8tCklB5jgQxAoz12GfUkKCiXhDs
	 2Nb5Rk+7MLgbLBQhuRB7FOUB0NfkLak5bSJLAgggCx4M3emRNUa+tomoD4Wvkcaawe
	 odrzIiww0m3xVJX3NLks20c6v7qRcLiEuvxyOGVMsl6TEiMu6xhFvx93kbxVZCMuIL
	 fQGL/viW1wBwg==
Date: Sat, 14 Sep 2024 16:23:18 +0100
From: Simon Horman <horms@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: bryan.whitehead@microchip.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de, richardcochran@gmail.com,
	UNGLinuxDriver@microchip.com, mbenes@suse.cz, jstultz@google.com,
	andrew@lunn.ch, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v4 1/2] posix-clock: Check timespec64 before call
 clock_settime()
Message-ID: <20240914152318.GC11774@kernel.org>
References: <20240914100625.414013-1-ruanjinjie@huawei.com>
 <20240914100625.414013-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914100625.414013-2-ruanjinjie@huawei.com>

On Sat, Sep 14, 2024 at 06:06:24PM +0800, Jinjie Ruan wrote:
> As Andrew pointed out, it will make sense that the PTP core
> checked timespec64 struct's tv_sec and tv_nsec range before calling
> ptp->info->settime64().
> 
> As the man mannul of clock_settime() said, if tp.tv_sec is negative or
> tp.tv_nsec is outside the range [0..999,999,999], it shuld return EINVAL,

nit: should

Flagged by checkpatch.pl --codespell

...

