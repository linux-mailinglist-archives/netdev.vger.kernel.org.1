Return-Path: <netdev+bounces-191086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB72ABA053
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 17:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A0D7AC7D6
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 15:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8F51B87C0;
	Fri, 16 May 2025 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrBTGjCa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9B686359;
	Fri, 16 May 2025 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410903; cv=none; b=gDKFkCcAC8vdwP9bUyJKhpETM8QS1SstCNR60jDrR4IXHkSaB6g5H49B/f1dEqNlvbl/7BeEf8phKJPKvCSUT423sujFfWOSCV3s3tN3+ZWQZQk4+hQDr0Ze+336rQSppPCLOJ2m39KEBozRJKxsMlKB83t58hCkMB2ComWhnuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410903; c=relaxed/simple;
	bh=jCR+XOlu938UmhLRf+cXPylXtwXh3iTH9ibsnuXVZ4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uw1BFaR13oXL4SWH+yx9nZDOYX4QgstFjfkDBGeXuETyEMkzxKYFHmf9XRVLGRBnjFdnFuDlYeU9cNashfP65g82PnuAQlF8paFe5aPyedgvLnpcrPHNJ1HqoLIxlggUOTFIw1xjyYce+4VAqwjBqdoQLksIanZlWDDPj2z+S5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrBTGjCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D3EC4CEED;
	Fri, 16 May 2025 15:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747410902;
	bh=jCR+XOlu938UmhLRf+cXPylXtwXh3iTH9ibsnuXVZ4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SrBTGjCamKGSVwpYT7KZv3j/7qTb7mdF3j5Fmjo570QbAqat85zxD6xYPYDPuE+p2
	 mzjFLkOIUyvracu0bS6Sy+9UT61QLbUg+HQ45vkZjf+r1juPmtE1lXkKTGR1k7xdsk
	 5PegGz6m5MtcNdcmf1fzFJ/wPNLH8L23HnnM4XJJbE4bXMwzsh6SyRvwb96WeSGtJy
	 Iq97Qza7awoKLYYtJOjKRXhBiMj27z61j4UNmsadoebYwVj6zMH8alv9PjDnTtWzMJ
	 vztTZlqQGt/3CR2tMTpFrSDE3KR/ZJOwxPtED+t3VPbJgaQ6l0GgEzqY6JvRG7RmE7
	 ZGSYdEb6B2Emw==
Date: Fri, 16 May 2025 08:55:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Davis
 <afd@ti.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Heiner
 Kallweit <hkallweit1@gmail.com>, kernel test robot <lkp@intel.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Holland
 <samuel@sholland.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mux: mmio: Fix missing CONFIG_REGMAP_MMIO
Message-ID: <20250516085501.648794e4@kernel.org>
In-Reply-To: <3172aba1-77f8-46a7-a967-14fae37f66ea@linaro.org>
References: <20250515140555.325601-2-krzysztof.kozlowski@linaro.org>
	<174738338644.6332.8007717408731919554.b4-ty@linaro.org>
	<bfe991fa-f54c-4d58-b2e0-34c4e4eb48f4@linaro.org>
	<3172aba1-77f8-46a7-a967-14fae37f66ea@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 10:58:38 +0200 Krzysztof Kozlowski wrote:
> My branch fails with above error because I do not have Heiner's commit
> a3e1c0ad8357 ("net: phy: factor out provider part from mdio_bus.c").
> Will it reach current RC (rc7) at some point? 

No :( We merged it to net-next, so it will have to wait until the merge
window. Worst case you can double apply that change? Maybe git will be
clever enough to auto-resolve. Obviously only if absolutely necessary..
We could also try to sequence our PRs to Linus so that your changes
are rebased after net-next merge. We send our PR in the first day or
two of the MW.

