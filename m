Return-Path: <netdev+bounces-102096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF15890165F
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 16:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8881C209B0
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 14:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B1C4436A;
	Sun,  9 Jun 2024 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="h6kIxiZW"
X-Original-To: netdev@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE863C7;
	Sun,  9 Jun 2024 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717943783; cv=none; b=egaU1ZXlMT7hy2P9WKQZIAm7IZiSo6AwZGeEYK+uceQ4+FwnXHmFrQmN0iMwnweps/jkhFrY8oICMwbqqwPiVnJ3lbRmd+CwgtAIi1vA5m7LI5MUNj8f5CceF+qjP9lubiA4vZ4HW7NdJ1AtikWNHcel9v4Txr8rqgln8jtsbYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717943783; c=relaxed/simple;
	bh=qCa9AGh+fq/1VReLn9hghMXIAlqi9wewi4dObNvl2UE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VNeP4OtvwLc+QxLV6VSpON8NEpZf43q5ESi32gC8R54aCZDoMWcx16uTIm0I9Nljz7kWC11NC/MvpsMKquDpMJ9fqi3FRpF16smAjpBxGlvPTihtvzc3uTDCq6g5iwk0j2yhOph3tjeDc0nY4GtuS8A9857LHMkye1HtoPeYFBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=h6kIxiZW; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qCa9AGh+fq/1VReLn9hghMXIAlqi9wewi4dObNvl2UE=;
  b=h6kIxiZW/dd5uSxCiMQ/CALnhPG8doWfxvHov7Bfnq8f9kW3czxcYGrS
   mEPMuHLltMD3xw+m4HWBjt3QCCDle7/X0SuZWD3hD1jy/dg91fiWfINpK
   jqi1Ts2BPOeiqQUZONpCbJQGgZrL+vyhNq+VNaR8jMW4r5Xi9iJrgXLJY
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.08,225,1712613600"; 
   d="scan'208";a="169717092"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 16:36:16 +0200
Date: Sun, 9 Jun 2024 16:36:15 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
cc: Julia Lawall <Julia.Lawall@inria.fr>, kernel-janitors@vger.kernel.org, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, wireguard@lists.zx2c4.com, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
    "Paul E . McKenney" <paulmck@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 01/14] wireguard: allowedips: replace call_rcu by kfree_rcu
 for simple kmem_cache_free callback
In-Reply-To: <ZmW85kuO2Eje6gE9@zx2c4.com>
Message-ID: <alpine.DEB.2.22.394.2406091636010.3474@hadrien>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr> <20240609082726.32742-2-Julia.Lawall@inria.fr> <ZmW85kuO2Eje6gE9@zx2c4.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sun, 9 Jun 2024, Jason A. Donenfeld wrote:

> Hi Julia & Vlastimil,
>
> On Sun, Jun 09, 2024 at 10:27:13AM +0200, Julia Lawall wrote:
> > Since SLOB was removed, it is not necessary to use call_rcu
> > when the callback only performs kmem_cache_free. Use
> > kfree_rcu() directly.
>
> Thanks, I applied this to the wireguard tree, and I'll send this out as
> a fix for 6.10. Let me know if this is unfavorable to you and if you'd
> like to take this somewhere yourself, in which case I'll give you my
> ack.

Please push it onward.

julia

>
> Just a question, though, for Vlastimil -- I know that with the SLOB
> removal, kfree() is now allowed on kmemcache'd objects. Do you plan to
> do a blanket s/kmem_cache_free/kfree/g at some point, and then remove
> kmem_cache_free all together?
>
> Jason
>

