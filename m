Return-Path: <netdev+bounces-132820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8876699351D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 19:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F971C23A37
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A361DD890;
	Mon,  7 Oct 2024 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Z+BHnXhQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAAA1DD87E;
	Mon,  7 Oct 2024 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322542; cv=none; b=eSygIv4vffS4ce++07plIMiUg0vZQ0qDcyCuxtY37chpXECOsjavzTBEfFxvNGAsFyQf6q4SmpFVOUtuLfCg03iBiHVRxo4terdg2L6w0kE39ei7F0LGlTI2rwOjlUBrQrPj4DsJVBQ+HfTLm+X4TR1dbFFMLA3S7vkNs+NKqOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322542; c=relaxed/simple;
	bh=TCWLKXSMmQLpHRkuXuVAjdohV9ZCCcra1KbpoSv8YUk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=me3GarTPFunlVIWJPUpsCD9GhW3+yPtcebS6HbS7VlTnW9U6ETvzP9z2hsMLLB8cDh2oWN87jV7nweZc2nngUNwL+rlPwddxIKlnJUTkUkpotOijBLiClfi5oggK8ZOqJaTsnOc5DgsW2rLRV+2EXPB8xbnW/Pc2X9kybOHsP0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=Z+BHnXhQ; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=H52L6Hswt7VoY0HC5GsmdTlLRT/trxE3qhmJl0tTzxU=;
  b=Z+BHnXhQONfXO9+HQyYq0jh8gfaPMCmaX44YX1Tkzu7KnWnmeY5RRUAB
   MtNf4eQmyPsohqlnW7sT5Pgcq//xfuvOp0EcS7OfvjB8r43uvxF6pWA6M
   tjk+vGM3CBlVkEtGl5xgBTFxmxxnz4OyPYi/wIkP37keMi6HWlZrkRHtz
   g=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,184,1725314400"; 
   d="scan'208";a="98447216"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 19:35:31 +0200
Date: Mon, 7 Oct 2024 19:35:31 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Simon Horman <horms@kernel.org>
cc: Jakub Kicinski <kuba@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
    Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
    Lennart Franzen <lennart@lfdomain.com>, 
    Alexandru Tachici <alexandru.tachici@analog.com>, 
    linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
    netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: adi: adin1110: Fix some error handling
 path in adin1110_read_fifo()
In-Reply-To: <20241007154600.GH32733@kernel.org>
Message-ID: <78da956-955d-adbf-cf21-6c56d1d7853@inria.fr>
References: <8ff73b40f50d8fa994a454911b66adebce8da266.1727981562.git.christophe.jaillet@wanadoo.fr> <63dbd539-2f94-4b68-ab4e-c49e7b9d2ddd@stanley.mountain> <20241004110952.545402d0@kernel.org> <20241007154600.GH32733@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 7 Oct 2024, Simon Horman wrote:

> On Fri, Oct 04, 2024 at 11:09:52AM -0700, Jakub Kicinski wrote:
> > On Fri, 4 Oct 2024 14:47:22 +0300 Dan Carpenter wrote:
> > > It's a pity that deliberately doing a "return ret;" when ret is zero is so
> > > common.  Someone explained to me that it was "done deliberately to express that
> > > we were propagating the success from frob_whatever()".  No no no!
> >
> > FWIW I pitched to Linus that we should have a err_t of some sort for
> > int variables which must never be returned with value of 0.
> > He wasn't impressed, but I still think it would be useful :)
>
> FWIIW, I think something like that would be quite nice.

Likewise.

julia

