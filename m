Return-Path: <netdev+bounces-109252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8F1927943
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17391C20A87
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9614E1AE87F;
	Thu,  4 Jul 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEdhPRwF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718CC1A3BDA
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104629; cv=none; b=Xj9jq+Ubdl9ZstnObuIAwbvcSND8FHpCSkBCYGcNKqS0pHZtYO+VenXZFcUxLQmpp5OPNsj5Int36MVkJIaZTI+X2l42KqTIPfSkH1nDvoEnZO1cNmfbY5GsjoZjtrPZ90M6KTiv/hz6X6APwNRQcNRDVlo2KBKtlH2FH21Bups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104629; c=relaxed/simple;
	bh=n16kSNcmuFZbiWOBZ3ewCDDRfotuY+O4zFL7CyDuv80=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AsoTiFNYHyTFkzKEJF+oeqAcvd8vS9IlgzBL9qF40zYD7QkOM0SuMZu1tt13VNr6l7wEz/reGH2Ko4oNlOPauW7AIPepziSu9kK6aNNcaVw/Ap/filyEyB3hP2peOD3MQfzWm18PC7kTvk99hjlbVvHZofb3YheDVyScJn2ENWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEdhPRwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBDA5C32781;
	Thu,  4 Jul 2024 14:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720104629;
	bh=n16kSNcmuFZbiWOBZ3ewCDDRfotuY+O4zFL7CyDuv80=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eEdhPRwFDwGPiw0bTs/rwmzzx/xbdA0OOTDD7FOPCtS6lnnhHReU0OQ+quySwWZi3
	 CCdlmpYFeoNSqLDKz59u0o1nSQfHNDOxeg/kNA5XD4L/WbutPXvNUoiuOTp+cgqjEt
	 9Q+Vzy8JzBddXmALV580S8m1E5RvPafwOqXwdSgzOFwWFc8mR/g65uv0LF7YH3VTPd
	 xuNW86XUcTc5PDzitGnahUSq8eECqgbNMcptlrpesT20tdswakKNePffphzs0sH+rg
	 WFi7FlyHYTt4++7sp2l/oA0uEutZbcHhkoSC5TuvTRLLV2NXE9P1sz0Uqu3/qTzLnu
	 3f+ba0QsrKo6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DAEF2C43446;
	Thu,  4 Jul 2024 14:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnxt_en: Fix the resource check condition for RSS
 contexts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172010462889.15534.10045966069300718867.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jul 2024 14:50:28 +0000
References: <20240703180112.78590-1-michael.chan@broadcom.com>
In-Reply-To: <20240703180112.78590-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jul 2024 11:01:12 -0700 you wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> While creating a new RSS context, bnxt_rfs_capable() currently
> makes a strict check to see if the required VNICs are already
> available.  If the current VNICs are not what is required,
> either too many or not enough, it will call the firmware to
> reserve the exact number required.
> 
> [...]

Here is the summary with links:
  - [net] bnxt_en: Fix the resource check condition for RSS contexts
    https://git.kernel.org/netdev/net/c/5d350dc3429b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



