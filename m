Return-Path: <netdev+bounces-95478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8260E8C25FD
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 15:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55AC281D4C
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E9B12C48A;
	Fri, 10 May 2024 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdWzzwDT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E3B12C47D
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348809; cv=none; b=ilnXjwBop4DJmNyWxFfJLBXoCEv0Kc/qXn4sbP9m754asHuP5422UmTdsreWe1cCjpEwzy5rAuejL/B8o4MYZ04CG1KLRvj+ocNd6b+ObcePLQiMWS38ToDIElsoRVbOaDkFkyWN5MDyqWjunKCwDkMKAa11smIaJhxBd952mac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348809; c=relaxed/simple;
	bh=rMhyTvsntGHE7xEXc213w1XVsY/vxCLYN+8TmVMqBxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGHzMd3HcQCFEBPGJj/2SEpjd3PTgXNWrxY1U9Y8HT4Dbjisjdn/6eZ0XoGAtPEmsJ+je0puYwgur0zvWyds1FTts+nFKZUPsynYr81uCW94AX32bedKJgKwX8fc5zfck3frxPOQ8MZ6Xnn+XnCUfsuXYDp19Q0m9fzSwN74hvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdWzzwDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAAFC113CC;
	Fri, 10 May 2024 13:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715348809;
	bh=rMhyTvsntGHE7xEXc213w1XVsY/vxCLYN+8TmVMqBxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BdWzzwDTexUOtitt034e3yhGNxK++NrIa2I7p63jlsMoCU0upVZxotwBLc8fuJwpi
	 LfUbeKcOnq7gvSp4zz171+Nk0SlCHUqZ2douaTTKsmDTKKV3CJktV5m5ViALs4Z6hU
	 StZyLbPDamqhMzzyPH1G7qnZEO/FRs78YlygmA+jyldbokbRsEyIvX3gmQgyxCdW2C
	 1SewIADzFnyjHH7bVMc2kl175zsZrQY9S1veoerd3IJHsuFEnalHMW65HxWpUX5SRG
	 1Lz/geu3L9pcM/M6W43sxf6aGZXRZdebCJGIj4XQk/nB6PLMCtKVNSp/9+kGhT7y+s
	 OxwLCkLhjgDSg==
Date: Fri, 10 May 2024 14:46:44 +0100
From: Simon Horman <horms@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: cortina: Locking fixes
Message-ID: <20240510134644.GB2347895@kernel.org>
References: <20240509-gemini-ethernet-locking-v1-1-afd00a528b95@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509-gemini-ethernet-locking-v1-1-afd00a528b95@linaro.org>

On Thu, May 09, 2024 at 09:44:54AM +0200, Linus Walleij wrote:
> This fixes a probably long standing problem in the Cortina
> Gemini ethernet driver: there are some paths in the code
> where the IRQ registers are written without taking the proper
> locks.
> 
> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>


