Return-Path: <netdev+bounces-236949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C10BBC4258F
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 04:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CA718922B1
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 03:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E0E2D2382;
	Sat,  8 Nov 2025 03:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/MZx50c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CE42D0C7B
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 03:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762571445; cv=none; b=obctj2n5EErzCnf7MJvxc2aD9kyellF3roxCZ90uyVmy0tLe/TvhCoptmMMwSPFhOrPDm3Iy+bpBlCrNdCJ2YVoLwX+juV9UXxuMwaWdI+9WJIexIve/BH1tXvLbmjZzHoyhWmwWodN6ZpWgGb2RIBlCmj3J69SbCtUaqcEwDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762571445; c=relaxed/simple;
	bh=KWbTU1whcfwTgt+bxTCv5194xgMJIni1XYXNgFa0NcE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C4D2IgFVSTtwioAs/UHRApWF0KJomDgFOi+twPMPH7jdFotDcLRnYUA4AAzKdaELYNvRY71zcFt8BVIynOi4lpfYq3t7+SIidsJcnOogJR3UkQChIi5/4MZMXeQCrh1eS4ElMeLf8HERlvc3tiky5nPH+ip2tiH4ob8T3jlXR0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/MZx50c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D38C116B1;
	Sat,  8 Nov 2025 03:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762571445;
	bh=KWbTU1whcfwTgt+bxTCv5194xgMJIni1XYXNgFa0NcE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q/MZx50c70COjz+F0t0/80/NVjT05uOk8Qo5j0EBmYq7tEZUyzgRqOPyQSaw6Vqq+
	 M8/mTVyklzJ1S3m0Eod12g+E8A9M4bwyqWPOSZid2wCeHvcD+YpsqYTaKUWph85LZq
	 e2CyQrdHTWwYktZtCgS4qYnJfaYNSllcx5n6pPrgVVg5Mubj8UdCW/tx2i+SCXhs8+
	 wmt5KusatS0uygEFKJMiqCV5RlJg5fza4heb8jnBqpsTAeHWPPvHTOqMsTTFAr3vnc
	 fMYd6g7WbeF+YB8dt7hocOqfkI5TW26Cs/Npo7MdvGbtzFpFfQhJMBTFvOOU7q2SES
	 FDx6KKVPeUXkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BDD3A40FCA;
	Sat,  8 Nov 2025 03:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: add prefetch() in skb_defer_free_flush()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176257141699.1234263.4526493629944891765.git-patchwork-notify@kernel.org>
Date: Sat, 08 Nov 2025 03:10:16 +0000
References: <20251106085500.2438951-1-edumazet@google.com>
In-Reply-To: <20251106085500.2438951-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Nov 2025 08:55:00 +0000 you wrote:
> skb_defer_free_flush() is becoming more important these days.
> 
> Add a prefetch operation to reduce latency a bit on some
> platforms like AMD EPYC 7B12.
> 
> On more recent cpus, a stall happens when reading skb_shinfo().
> Avoiding it will require a more elaborate strategy.
> 
> [...]

Here is the summary with links:
  - [net-next] net: add prefetch() in skb_defer_free_flush()
    https://git.kernel.org/netdev/net-next/c/fd9557c3606b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



