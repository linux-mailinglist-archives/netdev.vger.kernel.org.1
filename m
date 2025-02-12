Return-Path: <netdev+bounces-165647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAE5A32EED
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 19:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A8917A2B01
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4243425D537;
	Wed, 12 Feb 2025 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoKsyRcc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E61C1F76A5
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739386389; cv=none; b=aOan6f+EPjhMSJCvGt5yxusYGJLxWz4oDuLMvrldNJmjPiAeWn1O4iCw+Y6KEFWi6GSBUudq51Y9Mprh6nwPw81/dt4KOFrEqN+qB3KuWS/fb8TXJ5BkZSuP/74XWMvHUpAx/DVoGP0SsYi7kYULixSxCp9/V0NmV0UKpsDHtKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739386389; c=relaxed/simple;
	bh=XHPvE2VD8ZDMXkauLTZLqtnSYzE4s/+B5mvuhx9tAOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nki8mjVACpWliROAlojwn3nFGG62vIVpQF7nIpIZ2PYsuZe0mnFxbvKuhmw6a+SYbJWaTMnDBN9pU5Tvm6ElfNs5pJl75jPI6M1wu3ZCve6xSgwH9FxTV0emUQyx9gNu0dvxWN7dKXEwZ97Om5yESJdjo/r4+uMD1nU6BCLOo14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoKsyRcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0051C4CEDF;
	Wed, 12 Feb 2025 18:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739386389;
	bh=XHPvE2VD8ZDMXkauLTZLqtnSYzE4s/+B5mvuhx9tAOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LoKsyRcc9XhsR4dLAHU8RQ5zxW+RyAM1SwV5S8jReWDb5DVyS/VU30Pz80xGrDqLe
	 awE81idml1XWVqVA4zDTbaHp1aNZ4LeMaZGaE/DZ4kZ6YanzIT4kVDgY+YGQtWWkSR
	 Ibnf/gMm2p0s3ybgIZQ0Teyw/7OKEfRcwB07Fa7+e8g9bF8oKVPCREywUboBSclMt6
	 NTm7it+YT17gmu/yiNI0VpEmO3fZb/n0C3QwqpAmqV2OEV6Dx6rrmyW19AQ+3Yw+ki
	 B0XMCuEMlnEae3FTGu3HNNayXUrxz2wvff0e+IOMrg3QdOD8316wMlX0zS90cnU+sW
	 Oc9Vpb1c9+8uw==
Date: Wed, 12 Feb 2025 10:53:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1] page_pool: avoid infinite loop to schedule
 delayed worker
Message-ID: <20250212105307.400ea229@kernel.org>
In-Reply-To: <CAL+tcoATHuHxpZ+4ofEkg7cba=OZxnHJSbqNHxMC5s+ZMQNR9A@mail.gmail.com>
References: <20250210130953.26831-1-kerneljasonxing@gmail.com>
	<CAHS8izMznEB7TWkc4zxBhFF+8JVmstFoRfqfsRLOOMbcuUoRRA@mail.gmail.com>
	<20250211184619.7d69c99d@kernel.org>
	<CAL+tcoA3uqfu2=va_Giub7jxLzDLCnvYhB51Q2UQ2ECcE5R86w@mail.gmail.com>
	<20250211194326.63ac6be7@kernel.org>
	<CAL+tcoATHuHxpZ+4ofEkg7cba=OZxnHJSbqNHxMC5s+ZMQNR9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 12:38:28 +0800 Jason Xing wrote:
> > Initializing a work isn't much cost, is it?  
> 
> Not that much, but it's pointless to start a kworker under this
> circumstance, right? And it will flood the dmesg.

There's a seriously buggy driver potentially corrupting memory, 
who cares if we start a kworker. Please don't complicate the
code for extremely rare scenarios.

> > Just to state the obvious the current patch will not catch the
> > situation when there is traffic outstanding (inflight is positive)
> > at the time of detach from the driver. But then the inflight goes
> > negative before the work / time kicks in.  
> 
> Right, only mitigating the side effect. I will add this statement as
> well while keeping the code itself as-is.

What do you mean by that?! We're telling you your code is wrong.

