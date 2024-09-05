Return-Path: <netdev+bounces-125320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD9996CBB5
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 02:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 892D2B22934
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1817FD;
	Thu,  5 Sep 2024 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J50iUNCx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610C5184;
	Thu,  5 Sep 2024 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725495629; cv=none; b=C9xU/wPfLDpr/+dmfVrIpkk0b582F3AcjdxNzbwB/uMriiHqPPR3Jp/Vk8XdRl9XKqjmEMP0uSVPxJVQnUheEmE17TfzhVqA5uwq2KH3yvrC+WtwngfcggQ6c22xGF7psAzIrbEKX7XENfI6Y2xLxeA2wlS5vYGlC8vFOFooiuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725495629; c=relaxed/simple;
	bh=BhPxPusIchmaxWsSUetl+q/0fS/XhTFEWH9Q9mNyWKQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YPDsqBxKCv10QIa6anScPVpchEH3dijO7TiqzpkzrL4oifWIihGTGlwOuHbkalPufUjGOJBLdWWKB8qUXvO5oILjcdeCsMz5n+tZSgwwHQ4JPw+L07H4cF9+FUkWAH+ohVzMhImOist++5EEeqYL+aH08UvMMIVmAyzDkrP266Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J50iUNCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C47C4CEC2;
	Thu,  5 Sep 2024 00:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725495628;
	bh=BhPxPusIchmaxWsSUetl+q/0fS/XhTFEWH9Q9mNyWKQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J50iUNCxRzEtOB+/Kh4w6HRWjVO0dCYHeW2g4mejRC8l4hZg5Wl98EcYX+ciq4Mn4
	 jwOSqMI3+gz2LkL9PkLkAWVHk/iwpGvVONzenASe4vcybNxwpjHXyksIoGPGRDulMc
	 u6iBERtF6kkYBC9f8aAxfSWcejPahwAs5foGDdbsfI0aE+rPzqDEy1y58N2CXH3U2f
	 3hKBLpOSFrHSimGxbk4i5bmBmyRQaWv9uAZMNu0zD5lFHOYKsfFHVCisiRySQ1qe6d
	 bZINDj6aAGNOcHOIHbKrSP4vpvgvtU2ovY8emm97cw6HNqmPzto5CMqrjeEMztgwee
	 qvPbzJOJeL6nA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2373822D30;
	Thu,  5 Sep 2024 00:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: xilinx: axienet: Fix race in axienet_stop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172549562978.1208771.14261588078199879784.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 00:20:29 +0000
References: <20240903175141.4132898-1-sean.anderson@linux.dev>
In-Reply-To: <20240903175141.4132898-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: radhey.shyam.pandey@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com,
 linux-arm-kernel@lists.infradead.org, daniel@iogearbox.net,
 andy.chiu@sifive.com, ariane.keller@tik.ee.ethz.ch

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Sep 2024 13:51:41 -0400 you wrote:
> axienet_dma_err_handler can race with axienet_stop in the following
> manner:
> 
> CPU 1                       CPU 2
> ======================      ==================
> axienet_stop()
>     napi_disable()
>     axienet_dma_stop()
>                             axienet_dma_err_handler()
>                                 napi_disable()
>                                 axienet_dma_stop()
>                                 axienet_dma_start()
>                                 napi_enable()
>     cancel_work_sync()
>     free_irq()
> 
> [...]

Here is the summary with links:
  - [net] net: xilinx: axienet: Fix race in axienet_stop
    https://git.kernel.org/netdev/net/c/858430db28a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



