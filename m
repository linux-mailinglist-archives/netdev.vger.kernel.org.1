Return-Path: <netdev+bounces-95476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC388C25E9
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 15:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAF01F25EC2
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4907D127E0D;
	Fri, 10 May 2024 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGZV0HDu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224F412C530
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348325; cv=none; b=Ig+LICam5BradV+WIcc8gVWMGHdYfSVaoj8p3neLy/Xqp3iJOzXOPN3xVTLpWlR3+GUdHHwFMGwo7kHSyJpwZrB0JorbZspIq88bnkvkH2OX0vB8KZGIhHCpfolSYtT63oQGNAavG2lKdE9kqeDNUdhZY18+DffINA2MLFXj8XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348325; c=relaxed/simple;
	bh=rMhyTvsntGHE7xEXc213w1XVsY/vxCLYN+8TmVMqBxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbRAqg0yziTnfA2r7bqqMnphUxDaXr7aHGlwUHnxuLoJGqQxQfKEtNj7npM06SZZ2GIvAi6Ywk0UqST7cNYjANPG/2gKK6Bb3l7K2cYFSi95vRZ0w9IuC0ijWKELEZgu+xXYzbVagijCax+pplDaPcg0KpFqRSggXq/SoBVrg2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGZV0HDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACBAC113CC;
	Fri, 10 May 2024 13:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715348324;
	bh=rMhyTvsntGHE7xEXc213w1XVsY/vxCLYN+8TmVMqBxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mGZV0HDuaDIap94kK4V8SGqVrKn9MvzHN5G33W8yh4ZJwAL+yp3Zei+Kaqz+fAvh5
	 9lA1bT5kzfA5JszbFszRcPoiOFgaCxFA0S0dE9oGv4XqLsHfVVcx54OGzSqpDOrbKw
	 qWD1sIgzTUuCFNbP5eWr8oK5jyvOLuoQAm0LtfHiaQNfpA4yVmBCxB7RjZU08u6eKb
	 RmuLu/IHIeCwQpbAdEdo2kFC34GdnNdBOTcqpmvkyWsuUioHp43rfnNGAcyJvPvRBj
	 tUuK1A8DXGl4hnjN0farEm2h1dnUU2Wrlik7wcRNQ+SXErYmKKoLbc0C8ZC8x4hnEg
	 em9rYxl6/xHng==
Date: Fri, 10 May 2024 14:38:38 +0100
From: Simon Horman <horms@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: cortina: Locking fixes
Message-ID: <20240510133838.GA2347895@kernel.org>
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


