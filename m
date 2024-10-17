Return-Path: <netdev+bounces-136495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6452B9A1EF8
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890B51C21420
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD281D95AA;
	Thu, 17 Oct 2024 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnBQtZcg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CE0199E92
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158622; cv=none; b=ajpI6P961/vwwC4nbNwTKzpRTjMc/EXJIEqal6JaCgH/jQD0CdO62XAiD6jPvxJ12V84ggQR3deR6V+KfEE52QCvEzNsoK6D8pcyPeztZQ4/+yvCVl04Nnhyt937HIo0rlNXmpREBWUouXcwaAWLkH6u/egNpoWb3LpPtY2mjqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158622; c=relaxed/simple;
	bh=qIwg4Qh2gI06PiKb2H8UfD2stUZA8ZRg4Rl2XpmN99Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OGS4m/3XyduAnPkaY7b5g9DFGmtZ426e8sbLjy9oRuOBiWyTA4Ei8HScwo9G5AImMUS0xiKU02ed/sSgVWMuBTqQ6mlrA5UTmKALHdG/jaYaQxct3/uy0IHYjXLC5R0AkTpLLZW9MuFztmCJx/VGuQZqWzTEfL1/WOEgqtg1LSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnBQtZcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6179C4CEC3;
	Thu, 17 Oct 2024 09:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729158621;
	bh=qIwg4Qh2gI06PiKb2H8UfD2stUZA8ZRg4Rl2XpmN99Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TnBQtZcgHe/tIRYyCmU1sIypPJlOwlMjmKr2c+B9KM2wiwvUVv/tKtWuVYuXH1XeP
	 3QfBF0nN8EiFInS7a5t0qfPD9w0mvUT05qCA+/b78UZnem8cqp8Jy27ZgdpCd1Y3yD
	 HkhymY2qGwPVno6o/UQ/ElXZbi1oPu/YzE36mkiDGjIWAUHZWV2MB+nO2Fpa997AFA
	 /WWEW/nmANlqDnjpPSXVvqrIOxcvbCTrbC1okQPOjrTGY58bHBfTH3CVo+WPn9+T9D
	 YNNksdyRsTZJ3AcCUVo+zJu7NGn7+U7lrjXjLgjURm44PfepvUxCAssP0T7AG/9XT4
	 9vfLBh0tw9wFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7162D3822D6A;
	Thu, 17 Oct 2024 09:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vmxnet3: Fix packet corruption in vmxnet3_xdp_xmit_frame
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172915862726.2415799.8391811571662475714.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 09:50:27 +0000
References: <a0888656d7f09028f9984498cc698bb5364d89fc.1728931137.git.daniel@iogearbox.net>
In-Reply-To: <a0888656d7f09028f9984498cc698bb5364d89fc.1728931137.git.daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, netdev@vger.kernel.org, andrew.sauber@isovalent.com,
 nikolay.nikolaev@isovalent.com, aspsk@isovalent.com, witu@nvidia.com,
 ronak.doshi@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 14 Oct 2024 21:03:11 +0200 you wrote:
> Andrew and Nikolay reported connectivity issues with Cilium's service
> load-balancing in case of vmxnet3.
> 
> If a BPF program for native XDP adds an encapsulation header such as
> IPIP and transmits the packet out the same interface, then in case
> of vmxnet3 a corrupted packet is being sent and subsequently dropped
> on the path.
> 
> [...]

Here is the summary with links:
  - [net] vmxnet3: Fix packet corruption in vmxnet3_xdp_xmit_frame
    https://git.kernel.org/netdev/net/c/4678adf94da4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



