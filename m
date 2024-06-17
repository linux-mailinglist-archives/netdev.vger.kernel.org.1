Return-Path: <netdev+bounces-104233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A88690BA88
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 21:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C9EEB21A2F
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 19:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD4A198843;
	Mon, 17 Jun 2024 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WApkWx4t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A60134A9;
	Mon, 17 Jun 2024 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718651049; cv=none; b=XAlsCbkL36oKSpG4Rj5R6+MLTc5dJJfih20ukEcKxfxUqqm4RzM1PJKMJBCu2D4sNJssxmeWD01nqtLENZpF/uIDz+6dKRUBX5jD+lver9j7mMlGKwoMGN8w0UA4OLDmeHNnoxhbI43nriAlEqVUedZyT0aTHgr9TgjKnWAfG7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718651049; c=relaxed/simple;
	bh=qfyso2qMLybGpX61RQ+fiugcmyG5+ZY0OPKYZo3IQ9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5Kk/1qbVbl390/zjsFILtc06upFJ4V8lXJfYe2uXuyMU8M9OBvLgwHbPJHhMai1P/XE5RRjQhirkNCA2V1uGzo/OfnkDAR7UvL9Kh5c1k4ZrsLFxV0/U/44cxsbrPmK/zwDc++yog5nDgMEkUyP8BTK+ibbggAwlQooiznknv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WApkWx4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819EFC2BD10;
	Mon, 17 Jun 2024 19:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718651048;
	bh=qfyso2qMLybGpX61RQ+fiugcmyG5+ZY0OPKYZo3IQ9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WApkWx4txrab+zq2C/BuIEtSPTivz+0RK+P5RujtU3kVXXD3t6kFum+m+jy8HP9/w
	 s3qMMurypPbijMf/uTOCuVVZAgi/z/741/W/vNt01AS7M1a+WLSfXAOIfgfXOX1wXh
	 TGRB1x6E+Re7m2sI1p6AFczzloFBy7fEE7/lIHZGNCbxC2EeA7BKXIzJZwmW0bzPSg
	 YKyPj+CPGcx66uyy2WdriIKLDuH6lK5mIhPmJ21T9bwXRAubD/qsE4e1Z+Lc1/VBij
	 XAN42v0bX0RplsVUGoLQhBfNV0ZrHnR2ToDUmbj4Qwu1xdtDvQTj4sNUMo2u/h/aPm
	 GxT2bN9f+/t0w==
Date: Mon, 17 Jun 2024 20:04:03 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org,
	ivecera@redhat.com, przemyslaw.kitszel@intel.com,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Konrad Knitter <konrad.knitter@intel.com>,
	Marcin Domagala <marcinx.domagala@intel.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] ice: use proper macro for testing bit
Message-ID: <20240617190403.GZ8447@kernel.org>
References: <20240614094338.467052-1-poros@redhat.com>
 <20240615151641.GG8447@kernel.org>
 <da984106-43eb-42cc-a8c0-be859c6e84e9@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da984106-43eb-42cc-a8c0-be859c6e84e9@intel.com>

On Mon, Jun 17, 2024 at 02:58:59PM +0200, Alexander Lobakin wrote:
> From: Simon Horman <horms@kernel.org>
> Date: Sat, 15 Jun 2024 16:16:41 +0100
> 
> > On Fri, Jun 14, 2024 at 11:43:38AM +0200, Petr Oros wrote:
> >> Do not use _test_bit() macro for testing bit. The proper macro for this
> >> is one without underline.
> > 
> > Hi Petr,
> > 
> > it might be nice to include a brief explanation as to
> > why test_bit() is correct.
> 
> Let me explain this as the author of all those bitops wrappers :D
> Petr is free to include either this or his own brief into v2.
> 
> _test_bit() is what test_bit() was prior to my const-optimization. It
> directly calls arch_test_bit(), i.e. the arch-specific implementation
> (or the generic one). It's strictly _internal_ and shouldn't be used
> anywhere outside the actual test_bit() macro.
> 
> test_bit() is a wrapper which checks whether the bitmap and the bit
> number are compile-time constants and if so, it calls the optimized
> function which evaluates this call to a compile-time constant as well.
> If either of them is not a compile-time constant, it just calls _test_bit().
> test_bit() is the actual function to use anywhere in the kernel.
> 
> IOW, calling _test_bit() avoids potential compile-time optimizations.
> 
> >From what I see in the code, &sensors is not a compile-time constant,
> thus most probably there are no object code changes before and after
> the patch. But anyway, we shouldn't call internal wrappers instead of
> the actual API, so this fix is correct.

Thanks for this very comprehensive description, now I know :)

> >> Fixes: 4da71a77fc3b ("ice: read internal temperature sensor")
> >> Signed-off-by: Petr Oros <poros@redhat.com>
> >> Acked-by: Ivan Vecera <ivecera@redhat.com>
> 
> To be added to v2:
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Thanks,
> Olek
> 

