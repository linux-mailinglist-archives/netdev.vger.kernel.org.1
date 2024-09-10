Return-Path: <netdev+bounces-127014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4CE973A1B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D94DDB22455
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D93194C88;
	Tue, 10 Sep 2024 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gV5P60fL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1471F193096;
	Tue, 10 Sep 2024 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979198; cv=none; b=TZh7RHp9sV9ttoiAfjEd1U+jlcxF9HM/xrqF6VQ6J8jvsOyabK2xRjb2DBo+sdqU7M+jU6B0zpkCDjNTQfTzFkLS2L0tDXfgY87tGbRdyO7HNPHrd7w3Oq4nDAINvDvGEz5Q8pphi7OmfQ0kAQ32MDgLaGii5Lgn0Nghie7a1qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979198; c=relaxed/simple;
	bh=t18TnYBLL1+l4katEmWAhTGQvY0YNQUsSAjgHtvdg+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aR6HKAJixzL2QEdGagO6yz0YCJuWTvzVhsMVN3+nwDiPE5PZVkfgNmDxMkpBrW6+K9VysXGg1Joy8rg4i7MgxS7p6gRl4Xb2pGp8D1w4RAEGk11+aYJTf/e7vdJYTZOza5AgazmxvhhbTHCg6prPCbk8kU4cjUC41fx9YrX8sYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gV5P60fL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AD2C4CEC3;
	Tue, 10 Sep 2024 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725979197;
	bh=t18TnYBLL1+l4katEmWAhTGQvY0YNQUsSAjgHtvdg+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gV5P60fLDueL+Cg/li3w1huRpA96e9WlfpkID0g4dppLq1NnQErcfGFd6nWTQMuDh
	 GQWv/1kXn+nmH5CTtX9fWNSC4q15oxBs/lGPwjgOhlF9+tOuBI980tR0dD2+TrjG9k
	 MaiWXEdEvicJ/2aD6lT3NOr1Kj8ZaaY4yjElFRG6p2S3+mQiJISr87hrVRYjFK35II
	 kMUxLr+vRkCZwWhfpmedapOETaTF/XHGsbaHN5kfbnLndAuBppOnaUCN0cB60V55ua
	 kO6iEMGJ0QGSqzUNl1ZyaxHJ2LjFZYkbfEbZBhfV+2NXigsMwuabFiapCZxkIzJCQm
	 w+ZD9mzqDep3A==
Date: Tue, 10 Sep 2024 07:39:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Michal Simek
 <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Andy Chiu <andy.chiu@sifive.com>, Daniel
 Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net v2] net: xilinx: axienet: Fix packet counting
Message-ID: <20240910073956.53278ffe@kernel.org>
In-Reply-To: <318a13f6-da2d-4ba4-a51c-2f8444444bbf@linux.dev>
References: <20240906164227.505984-1-sean.anderson@linux.dev>
	<20240909180013.4e064fd5@kernel.org>
	<318a13f6-da2d-4ba4-a51c-2f8444444bbf@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 10:24:36 -0400 Sean Anderson wrote:
> > why are you doing this? To make sure drivers doesn't complete more 
> > than "budget" Tx skbs? The budget is really for Rx, for Tx you can
> > use a reasonable fixed value, independent of what budget core
> > passes in, e.g. 128. See:
> > https://www.kernel.org/doc/html/next/networking/napi.html#datapath-api  
> 
> I read this but it was unclear to me because it seems oriented towards
> "combined" NAPI instances, while we have separate instances for RX and
> TX. So even for TX-only instances, we can ignore budget?

Yes, combined or dedicated it should still reap completions regardless
of budget.

> > Moving this chunk into axienet_free_tx_chain() is a noop, right?
> > Please avoid code cleanups in fixes.  
> 
> The relevant variable (number of descriptors handled) is no longer
> returned to axienet_tx_poll, so it can't update the current descriptor
> properly.

Got it, worth mentioning in the commit msg.

