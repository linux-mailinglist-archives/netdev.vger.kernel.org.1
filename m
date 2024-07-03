Return-Path: <netdev+bounces-108652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A42B2924D36
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 03:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDEE1F2358A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 01:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194A4184E;
	Wed,  3 Jul 2024 01:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhhrWUFD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6246B5;
	Wed,  3 Jul 2024 01:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719970942; cv=none; b=dROPK6UR4bPTWGVnouTgZixHlR4JnOE2q8J1tdg+0/xqU7qIHxDmaqf/E3L+JM9vGA1FYU4xoKwdFNf145+TrNjFUANtrrwdOjWiCHVidokmq2rpEBC7vbv7/U/VLWs3IphCbaXF/rX6gMjn21bbr16kkH1eGd0wyxZegsosXUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719970942; c=relaxed/simple;
	bh=UcxzuPrchx18jeTGp7Ek1IscH56sS0Ld5+/uuF2cChc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpp7oe1TjDi9iV9BTcpHd/D0IabTvtmEytbwrZt+hmXHa8hPeAScOKKVBTJOGzVlY0/Gy8Dw1nSFD0yyVXtzL+TEBdbU9DSrCmMMSWafOmVfVJM6oFnTvQrpEHEfVM1uFXMUvRcP3NSWraetm8bzVeYdpr67hJTquRp0VkPnjDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhhrWUFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D78CC116B1;
	Wed,  3 Jul 2024 01:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719970941;
	bh=UcxzuPrchx18jeTGp7Ek1IscH56sS0Ld5+/uuF2cChc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JhhrWUFDJAiIWRuEaTA+4eLHvJ9hIR7xIA+Hn7VxvLUy+4JqrI1B9EtoC/HUz6Kuy
	 aCN6tE7o+rlRVHjLUxmxRcdSny6b72N4CrgwQ968PjDidqk4XRz6XtXdAobzXf7UXJ
	 GL9eqi13dizn3hER88Sm4Z2ZJ4oQASs01Ctp2JggXuzhYZu14wfDx0wF5kWk4UiN9o
	 MFff5KMzavS7KVqbZUJif/Fscr4OV9t0KwZArPo0bCYCDl1O8XeQ3FLNQi7pZeeOP4
	 cYf0ZSoTaiAdlDZU9t8Sqq36hTJn/PBlGQTj8QQPst5yN3axPDOnqitHiMdkItWGWy
	 lHwR4gkQAr2rg==
Date: Tue, 2 Jul 2024 18:42:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH-next v1] r8152: Convert tasklet API to new bottom half
 workqueue mechanism
Message-ID: <20240702184220.306d8085@kernel.org>
In-Reply-To: <20240701100329.93531-1-linux.amoon@gmail.com>
References: <20240701100329.93531-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Jul 2024 15:33:27 +0530 Anand Moon wrote:
> Migrate tasklet APIs to the new bottom half workqueue mechanism. It
> replaces all occurrences of tasklet usage with the appropriate workqueue
> APIs throughout the alteon driver. This transition ensures compatibility
> with the latest design and enhances performance

alteon ?

> -		tasklet_enable(&tp->tx_tl);
> +		enable_and_queue_work(system_bh_wq, &tp->tx_work);

This is not obviously correct. Please explain why in the commit message
if you're sure this is right.
-- 
pw-bot: cr

