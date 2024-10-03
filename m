Return-Path: <netdev+bounces-131424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B9F98E7D2
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 428DEB233E0
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 00:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65A916415;
	Thu,  3 Oct 2024 00:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9lFcgBM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E711401C
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 00:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727916033; cv=none; b=UJlICbejHL97CbMkR68Ey8VIs+c1BG3sUxWn6RHjvPHN6kyz4Hu10r5VeMyprMoyyHEFZrczaHPbE/xK7y17k9pLkwsiUuz0388OeyAkW/x8h+yB5BDJcJcVGB875VoHUY91LIaQqllAOnVUMR58fTtWWhgaGYY0mfliCsErGwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727916033; c=relaxed/simple;
	bh=UlqCJ2cFWHVc6UiXj0KvmF8iR3wM+OiM13oNzFf1VSc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e0VY+GebrmqyD0L3VHvvUq2whuB8hU2U8E4W18TbOCCVly6z7TKpEwO0SIZ5bp0oApAgqKdZIOhpZmlq+COQ9pDwgvtogn0zmTWV0yxi1oG6sRrNkgo6B7zSlCilhJPV9QxzTjl7Z/YXXLLXiF4pnKLzdiBQJze5jXG6SZ+czGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9lFcgBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A856C4CEC2;
	Thu,  3 Oct 2024 00:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727916033;
	bh=UlqCJ2cFWHVc6UiXj0KvmF8iR3wM+OiM13oNzFf1VSc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I9lFcgBMxTMLY2E+lxZB9e8jjx3GovAckBLEbS3oMEjrXaFjmT2lJQTZtJkdEtV73
	 1STWaljdMJW4jtXrnDhaPW7KhCfCejvgdg9moJILRPggKa+iQz6TVExAWdDUzlRoT8
	 gmiH3c9XdDO9x7FqUY5sr5nb4bPYgTCxaIjBtoejU25ADhD74AVEg3DLb6pej2h330
	 aIzjabyRvT3z44MPDI7+bckgmVj770xYNNu15Ku1oc/lZIdcEGxooT85sy5PjKS1QV
	 vOKTc/rxu7PrcCOQnDhoVTBkL2PQs/glHAiTSsIMiifyl6ol6Z9LoVRMdgMj1u6GHd
	 oeYF9EraToG+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF16380DBD1;
	Thu,  3 Oct 2024 00:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: gso: fix tcp fraglist segmentation after pull from
 frag_list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172791603649.1387504.1768251659357246802.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 00:40:36 +0000
References: <20240926085315.51524-1-nbd@nbd.name>
In-Reply-To: <20240926085315.51524-1-nbd@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Sep 2024 10:53:14 +0200 you wrote:
> Detect tcp gso fraglist skbs with corrupted geometry (see below) and
> pass these to skb_segment instead of skb_segment_list, as the first
> can segment them correctly.
> 
> Valid SKB_GSO_FRAGLIST skbs
> - consist of two or more segments
> - the head_skb holds the protocol headers plus first gso_size
> - one or more frag_list skbs hold exactly one segment
> - all but the last must be gso_size
> 
> [...]

Here is the summary with links:
  - [net] net: gso: fix tcp fraglist segmentation after pull from frag_list
    https://git.kernel.org/netdev/net/c/17bd3bd82f9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



