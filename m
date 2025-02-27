Return-Path: <netdev+bounces-170082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E6AA47395
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FBE18930C0
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 03:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C278C1CAA96;
	Thu, 27 Feb 2025 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdZ03tWV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9751C7004;
	Thu, 27 Feb 2025 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740627002; cv=none; b=N0Ftu3qTwmSrfTpG0jHMoNHHOAT0s0lMY+dk5cYsaYbfDradG+gfSqcghNphQhy3kwq3be0CkwWgD2i3os5/mG55RR2BXSsSIAoxQ+PFqojBFbQ8L8Ty7LNDK9fg5AxSTmo0neJqjufJk68SoRoFsZgbgEI+xhaRBndkLJ2s8KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740627002; c=relaxed/simple;
	bh=RSCGfiEgwWzogZKM4a3GbWkmCpiIb2WIyaJwqS2J1ys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nho2uhzP0YFFUo5KYBP0gx/isi4VXrMkCT7cRe+Fn+Az8rM53UeCngIW6df+Q8QH+CYtcbgHTPLfIGfFMX2xHutzAOjPgfxnZYh/p0Ba2vr5GUu4B/Ui8ZxfC6tGFiMedDIu7w6G4CeKKf+NxKiVoqd6k5UuNZgpwEpRJi9VELE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdZ03tWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1513CC4CEE6;
	Thu, 27 Feb 2025 03:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740627002;
	bh=RSCGfiEgwWzogZKM4a3GbWkmCpiIb2WIyaJwqS2J1ys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AdZ03tWVsIA15vmLrjpKAT7JOeEUde4OWWshAel8ccFQNRfAuaEvwD1YRelYfWTf2
	 P6zLwn/A7RItZz9klLSJcP6qY8Ao41H9ao260iDW8Q27EfOFoRqEg8i8OPryzcZ+Qk
	 kdhqmIOyVVmH6qtsMIjP6rcL5iH1B6xInErkchhb2HU1YGLr+lXasf9qHn0wv/IvYx
	 tpv/uTXM7Duxg4EkoLa0ImvdZ40z1EI1pFn3vdArdp0fooMsPRF2DtipphtX34g9hO
	 M66EMybMsKpq/U9k9LvkgcDE5i1rtuMtTS+eUhzUq2HesTDY52Heo0Vqj75JMQtZSw
	 q9a2j0PUmHF5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F18380CFE6;
	Thu, 27 Feb 2025 03:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: Handle napi_schedule() calls from non-interrupt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174062703399.955127.10228053973546865389.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 03:30:33 +0000
References: <20250223221708.27130-1-frederic@kernel.org>
In-Reply-To: <20250223221708.27130-1-frederic@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, leitao@debian.org,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 romieu@fr.zoreil.com, pmenzel@molgen.mpg.de, jdamato@fastly.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 23 Feb 2025 23:17:08 +0100 you wrote:
> napi_schedule() is expected to be called either:
> 
> * From an interrupt, where raised softirqs are handled on IRQ exit
> 
> * From a softirq disabled section, where raised softirqs are handled on
>   the next call to local_bh_enable().
> 
> [...]

Here is the summary with links:
  - [net,v2] net: Handle napi_schedule() calls from non-interrupt
    https://git.kernel.org/netdev/net/c/77e45145e303

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



