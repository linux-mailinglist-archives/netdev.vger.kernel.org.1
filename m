Return-Path: <netdev+bounces-186860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CEAAA3987
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6655D9A85AC
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 21:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C35925E47D;
	Tue, 29 Apr 2025 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/D7xqgs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AC6215040;
	Tue, 29 Apr 2025 21:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745962505; cv=none; b=tc25cImRy465wUK/K5mv8HSjws539eMkzxPuN33oigS2NATbyfFp5Y9oX6scD245fy0PvablGUiBm51D3VOPavqaP5hWx3BnPXQYRn6xfXmIq1Oxo/QFBMcQ8kDueepBL9tIzbLZgadk/SgRZdZxvYFKKOsG61zBgme7pKyWtrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745962505; c=relaxed/simple;
	bh=ylmvcbjnT+ht/5XeTR8I9zgGEbq526jEQ+kO+wRCvnM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rsKMAkQPg+OodV6TcVVeaONgL1BbdLjOoEVSecPZGMIuwDOw+U3FEcqmBtr5DnuUx5cmoY/j6R/VUn113bu033Tp/CvmAGatoCVdHknNTRhVNHcGrxe5ZhWHFKK7qyR+dHEPPGmTdRM56G86wwOkwuqntaAvuWJpcrluvN6gGIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/D7xqgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5991DC4CEE3;
	Tue, 29 Apr 2025 21:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745962504;
	bh=ylmvcbjnT+ht/5XeTR8I9zgGEbq526jEQ+kO+wRCvnM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m/D7xqgsDKYjqOSMMNM5oFBZZOZr1ow6Mdk/vuhD9yocsF+uPmiei5VmOXgNswD2M
	 KKNipTlVFdHDZucIEsNZp3mXB3NnWy9c35W3tZEpPjruo9rtyHXECvkMM7LSxC1W4/
	 Kfa/WJKJ1NGBhyfAum7p30huypFrGXRjSpWLyJwKzBhjP3tgCyAnYICfJOaSVNwHOV
	 PMDvtQ0YlTk0smcK5xyk1/i4vr5ZgKLy8el4Bk7M1AR1tYZQlJOYHRCkDThC4KqaMq
	 tdu5nDo9LRdyyyOCXWY2g9hX41Hr8nOFEg0QwW/VZWcwI4EfSwVJMnvbU1YCcLE6cA
	 PNnCez5ZJzWdw==
Date: Tue, 29 Apr 2025 14:35:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dlink: add synchronization for stats
 update
Message-ID: <20250429143503.5a44a94f@kernel.org>
In-Reply-To: <20250425231352.102535-2-yyyynoom@gmail.com>
References: <20250425231352.102535-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Apr 2025 08:13:52 +0900 Moon Yeounsu wrote:
> +	spin_lock_irq(&np->stats_lock);
>  	/* Maximum Collisions */
>  	if (tx_status & 0x08)
>  		dev->stats.collisions++;
> +
> +	dev->stats.tx_errors++;
> +	spin_unlock_irq(&np->stats_lock);

I could be wrong but since this code runs in IRQ context I believe 
you need to use spin_lock_irqsave() here. Or just spin_lock() but
not sure, and spin_lock_irqsave() always works..
-- 
pw-bot: cr

