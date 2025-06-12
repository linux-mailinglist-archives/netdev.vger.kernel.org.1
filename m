Return-Path: <netdev+bounces-196996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B6EAD73EF
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB69168C3D
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D75244677;
	Thu, 12 Jun 2025 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olXm7drt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DD542048;
	Thu, 12 Jun 2025 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738776; cv=none; b=KQsTLVurdm8k5J/IWcI7c+WKc+rblOfWXLG5A9KGsfaZOi6NYlza+rk0k6FX7e7ubR2CsEalZxWJkEscoMhJmmBMq2XemJkNhSci4/cDNl/tYT/uDaEus3KNlay4jo5XHqlmNIuNUn+kn/KxlSJdLrpe+KduvmfYdKZ0olL+De4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738776; c=relaxed/simple;
	bh=ykuK4PZn6JC8fkbCn1pDwof03d+gXaUQMc4rE5V5sEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7Q+w1zflGU7vkdlG3u1IR9NK6ykO0pMvt2SgU9QSQYHNPWpw+h9SdtxKkdMp2BGnxylTvHP981ve/kZ+c6J94GexHSw0JskQee+1pK7VhqxizAzRl1cNM6mUd0iekrHEMnZWbrybouvZlycLpzISapwRikWT+0iMhjImkonHGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olXm7drt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51B8C4CEEA;
	Thu, 12 Jun 2025 14:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749738775;
	bh=ykuK4PZn6JC8fkbCn1pDwof03d+gXaUQMc4rE5V5sEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=olXm7drtGOHT6kG+IeSM3x8PC60y2AP+HWYqhnZ8rknInCVwIj+IydBBT6bfDyWhh
	 BrfWJexTjJoa1Sx+gIzXZaPskSIKtEP+p9J4HnwVAGsbfM2Dsx/DMo2tgqjF1cIC1n
	 b0MBaOviA0eSt4j9+2piJRGX/VbdiFRVAh5kpqthg13kyFyogcYo2im9tgvUH7fM7n
	 W9Gxi5vJyfr+74MhryiQ9RbT0wlxKNmQ8yf+fhph8zGuyQOXV6i8HUy7HYyC19WYBb
	 uyGrlhJfev/v22ye7hMxyyE608TggHShuHcMEmBjBSc+knj/torCC4KVNnjwyt03QB
	 HWWuvUihqEJdA==
Date: Thu, 12 Jun 2025 07:32:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jijie Shao <shaojijie@huawei.com>, Arnd Bergmann <arnd@kernel.org>, Jian
 Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, Hao Lan <lanhao@huawei.com>, Guangwei Zhang
 <zhangwangwei6@huawei.com>, Netdev <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
Subject: Re: [PATCH] hns3: work around stack size warning
Message-ID: <20250612073253.2abdd54e@kernel.org>
In-Reply-To: <34d9d8f7-384e-4447-90e2-7c6694ecbb05@huawei.com>
References: <20250610092113.2639248-1-arnd@kernel.org>
	<41f14b66-f301-45cb-bdfd-0192afe588ec@huawei.com>
	<a029763b-6a5c-48ed-b135-daf1d359ac24@app.fastmail.com>
	<34d9d8f7-384e-4447-90e2-7c6694ecbb05@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 21:09:40 +0800 Jijie Shao wrote:
> >> Would you please help test whether the following changes have solved
> >> your problem,
> >> And I'm not sure if this patch should be sent to net or net-next...  
> > Your patch arrived with whitespace corruption here, so I could not
> > try it, but I'm sure it would help avoid the warning.
> >
> > However, this is not what meant with my suggestion: you already
> > allocate a temporary buffer in hns3_dbg_open() and I would
> > expect it to be possible to read into that buffer directly
> > without a second temporary buffer (on stack or kmalloc).
> >
> > The normal way of doing this would be to use the infrastructure
> > from seq_file and then seq_printf() and not have any extra buffers
> > on top of that.
> 
> seq_file is good. But the change is quite big.
> I need to discuss it internally, and it may not be completed so quickly.
> I will also need consider the maintainer's suggestion.

Arnd, do you mind waiting? We can apply your patch as is if the warning
is a nuisance.

