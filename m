Return-Path: <netdev+bounces-100424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB618FA805
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 04:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D76BDB26E1D
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 02:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEACA13D8AA;
	Tue,  4 Jun 2024 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEukuLmd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1F613D886;
	Tue,  4 Jun 2024 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466433; cv=none; b=sKPPCHx+UYCsDjB08acYSvyJjASzC0fZo1Lm1s80hdNzBqvI/KIFAIG8wnWQJ0vnWszf/2U64toFRV1+WC/t5NhKdkqhIYO9DL4m9F9lVRSFHCfxRraeDlRk9P/iWGseYlmO6OlqACfNzaLVJ2a0PNma0yoOJ+4tJnKxIT8Jgg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466433; c=relaxed/simple;
	bh=peZoWtJxBvXrmJEeU1LFZ5RhLnmSlkfe+2kEaZj3RCE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lcVPRxBk4brXfcv2z9LL/1VswjC4RMJZUEtY7+8qUK0i6UxM9ccP+c9vInj+PvhzfQ4emameufT/EJS0PEzlAL0DhmIMAxDAYFIErv2bqN2Ycsun3nx84H7105occhjCZyWbNxTTwgeU9oXmZUWtZf0PirUv9pLyBqVWfARRCcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEukuLmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 452BAC4AF08;
	Tue,  4 Jun 2024 02:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717466433;
	bh=peZoWtJxBvXrmJEeU1LFZ5RhLnmSlkfe+2kEaZj3RCE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KEukuLmdrGqfmN3Iq2OK4Or5Jcu14VoFNYgeM7CvY300IAQsV9con8EUlcQc0MFXS
	 9Gx64MCtoQkIpAGXLLtL/Li73WC8HmpdE7oMrtXDlSgZzECAXSSr2+abZu7nBB83g8
	 MOGQr+3J1sqlt+RvHoKZFMqTks5Am0G4nRN9b7KPBbcGkQKQh33rM2IVH29FLBFuRL
	 bHqRMVNXh5LvA15qEkPp5In/tkLKf/YpK1Pcn0+qh4ZTBn6IfF/qpE76dmOH1sRZPm
	 r+7gnsUwlKnxpZp+FhGqG6EzBcbDKRUSbiplXh8bFJfeesPs3cxBhTPFpvjp1t00EG
	 yugY2Q/NwNFnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36158C4361C;
	Tue,  4 Jun 2024 02:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH REPOST net-next 1/2] r8152: If inaccessible at resume time,
 issue a reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171746643321.10384.14422859264596064414.git-patchwork-notify@kernel.org>
Date: Tue, 04 Jun 2024 02:00:33 +0000
References: <66590f22.170a0220.8b5ad.1750@mx.google.com>
In-Reply-To: <66590f22.170a0220.8b5ad.1750@mx.google.com>
To: Doug Anderson <dianders@chromium.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, hayeswang@realtek.com, danielgeorgem@google.com,
 andrew@lunn.ch, grundler@chromium.org, hkallweit1@gmail.com,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 May 2024 16:43:08 -0700 you wrote:
> If we happened to get a USB transfer error during the transition to
> suspend then the usb_queue_reset_device() that r8152_control_msg()
> calls will get dropped on the floor. This is because
> usb_lock_device_for_reset() (which usb_queue_reset_device() uses)
> silently fails if it's called when a device is suspended or if too
> much time passes.
> 
> [...]

Here is the summary with links:
  - [REPOST,net-next,1/2] r8152: If inaccessible at resume time, issue a reset
    https://git.kernel.org/netdev/net-next/c/4933b066fefb
  - [REPOST,net-next,2/2] r8152: Wake up the system if the we need a reset
    https://git.kernel.org/netdev/net-next/c/8c1d92a740c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



