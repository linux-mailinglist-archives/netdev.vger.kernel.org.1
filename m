Return-Path: <netdev+bounces-103766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206959095B4
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 04:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C70B21F20
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 02:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA528825;
	Sat, 15 Jun 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzUJY9sT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B803CEAF6
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718419231; cv=none; b=JNwabHSlup/BcXS+esDsDdeI4b2UApxfzRRggm1i5S50Ope1rv763dOluSbx9JU8xQFj+CD4tnhEB8K8z8V6USPK6BvPO4bki3srCoPEiHetTpvm7pK5uwRhLgeJNuSjJYd62cmpuz/9MLtiuCOkWgrWQ88gVV1rBHGVp8UJUQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718419231; c=relaxed/simple;
	bh=cYD7uRjFkzA02HPqVe8Ed5KRQLEMuaOT/l6crN0kPUg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TuYnEToKRC91ntI/5mzMnGyxd2lUlp/VXiUpZKAg5VpItwz4YCRtmAMrWWGVRL2mll2YYBZ7xtrdUGYWskVbCeOfSnbMU+WGqyr+VGlicM/mq8xmjaGpXjtaktFy5Pto/spjK2UuWg5FOWOgdVm/6g3FFpOF8/MFo+gD54qDzdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzUJY9sT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57547C4AF1C;
	Sat, 15 Jun 2024 02:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718419231;
	bh=cYD7uRjFkzA02HPqVe8Ed5KRQLEMuaOT/l6crN0kPUg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RzUJY9sTEOPCWYv7OWJZ0L0XjSlicwNiISbbh4/wbulnRwrs524K1nlh6Gq4AzeQK
	 Y+WvBBE/j4sfHt4KH3Tjtq45aXaoGxjJqfRwQJnYoFGyT1Kom3DtCyZiLnPz88I0t/
	 ELpTEtn6S22lvFx2aLCN6bUKd7rKwo70awaf5x18/aMq5eKM5QyzZZ6vW/wfs5Y14o
	 2Y1hCwQ7amo37BHVZtSf5INUuYb+X3JhuRloBU4C+gQ2G+np9VLr+uR1LXFJAxqTUg
	 MJ3pYrCHIvD3s87VsLGgbXC7jdpZ9lRP4VhvZDdubJQStVZWWEtYMODXvHdWsL4Z9z
	 pXvHLOJ+ADKEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 478CDC43619;
	Sat, 15 Jun 2024 02:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: micro-optimize skb_datagram_iter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171841923128.25457.8198640997833011011.git-patchwork-notify@kernel.org>
Date: Sat, 15 Jun 2024 02:40:31 +0000
References: <20240613113504.1079860-1-sagi@grimberg.me>
In-Reply-To: <20240613113504.1079860-1-sagi@grimberg.me>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Jun 2024 14:35:04 +0300 you wrote:
> We only use the mapping in a single context in a short and contained scope,
> so kmap_local_page is sufficient and cheaper. This will also allow
> skb_datagram_iter to be called from softirq context.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  net/core/datagram.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - net: micro-optimize skb_datagram_iter
    https://git.kernel.org/netdev/net-next/c/934c29999b57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



