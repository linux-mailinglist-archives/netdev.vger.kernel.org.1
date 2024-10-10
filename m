Return-Path: <netdev+bounces-134012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A63E997AB3
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C591F22E38
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971B117E00B;
	Thu, 10 Oct 2024 02:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldy37X2n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FA6170A14;
	Thu, 10 Oct 2024 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728528628; cv=none; b=tAwPEoKeo/a7miDNLiaxVty9LpvgK5oj3idhQrb//tpQ25q8xm0OrGL2bPSPSsSzh0+5pMKP5zYzkrSCVfsuPh2sOy2ssGXadRqKfSl/2VLR431hLdZOaaGGKLxX5CzZFyOH+QpZcuYo+At1jvzGoyKdl9fHsgG/HMacFUumoJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728528628; c=relaxed/simple;
	bh=jNdxhNigsNuT3EpLL13jdD3S4+hvo/Ai+KX6gJbhB2c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gSX7ERLYYTTxUfel4oxE1yasxvimbYF/KV0JArZznPk+vdPypmFI/4MfcDoxoqJKzd9awbZHa9uODbHLwErp6+wVgKym7gAhBqxbT6Xjwax1qvbcRF+fsp2k6O2FCGgzESyUSBfwetIaKsGxiRMaT4o2bTqCvaJ4SSgUHZ7qodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldy37X2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE965C4CEC3;
	Thu, 10 Oct 2024 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728528625;
	bh=jNdxhNigsNuT3EpLL13jdD3S4+hvo/Ai+KX6gJbhB2c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ldy37X2nVnh7nCD7aPxtagHdqX1/R+2iXFaxyThQhkvWqEtOWJMwO4yXarB+Naubs
	 q73muPKX4kU63/koKKyp4C7AV9G12kWvNDu/c1dV5PsR8JxY9epNOdRq/yKihxL5al
	 AMVUK3Yg3m7MQ74cS2jQEvgMp11qhjJ9cFIGG3zYLT2IthuyyQwAIm8BU/OSk04em0
	 wxnQCbAxnCs2fzTzH3dkX4wxw7WRlFeMONxL7qb3fzhIaf4+8HLMXhYoJIKoiQ6mNW
	 YhC2uOEI/aCIoRjDHCKY3DAOo7SYM0MEdCG976ySJxeEyMJwdV5givSgyJT543Qpve
	 vpz5Hv3Fcw4qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C7A3806644;
	Thu, 10 Oct 2024 02:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fec: don't save PTP state if PTP is unsupported
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852863006.1545809.11109422606707012340.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 02:50:30 +0000
References: <20241008061153.1977930-1-wei.fang@nxp.com>
In-Reply-To: <20241008061153.1977930-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, csokas.bence@prolan.hu,
 shenwei.wang@nxp.com, xiaoning.wang@nxp.com, linux@roeck-us.net,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Oct 2024 14:11:53 +0800 you wrote:
> Some platforms (such as i.MX25 and i.MX27) do not support PTP, so on
> these platforms fec_ptp_init() is not called and the related members
> in fep are not initialized. However, fec_ptp_save_state() is called
> unconditionally, which causes the kernel to panic. Therefore, add a
> condition so that fec_ptp_save_state() is not called if PTP is not
> supported.
> 
> [...]

Here is the summary with links:
  - [net] net: fec: don't save PTP state if PTP is unsupported
    https://git.kernel.org/netdev/net/c/6be063071a45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



