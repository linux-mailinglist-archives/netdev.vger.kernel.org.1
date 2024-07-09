Return-Path: <netdev+bounces-110217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FFB92B589
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41630281DCA
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99215156F45;
	Tue,  9 Jul 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0poHWM2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F58156F32
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521630; cv=none; b=CUwp3nfXHkZcQySVGYKM28e3mcqr8mv49Vu90capEaYBSczZed9C+cYs0eh/gMBx8jN3FpVESyMPAFi8BcR3oU6A24HwT2NIJiOnviY6d943DDX742hmpuMdWkQZNqt7Y/e9LDk8oh1BL1B7aCma0t3NaaaJ6xb8wbBDpxF2SUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521630; c=relaxed/simple;
	bh=ig2YQjTqPmMUJszt77HAN9bL/YyN8vLPXRNgM9WT76o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BsoGq3wXRQZMoEuctTc6WmYh5JWpiaEbKnhAfEYj3ZzBXtfEfzIfHUTXvMwFlltVw79YR4ou8BZcPnGFqVlbQT6RthEUp/OoatuAbMoA+L/c6oVZJK+sMm8xMLrP2qLpqFG1NBXeet4zPPgkg5rWd3llUnJJ9Dlc5YrXO0j2Uec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0poHWM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16CF9C32786;
	Tue,  9 Jul 2024 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720521630;
	bh=ig2YQjTqPmMUJszt77HAN9bL/YyN8vLPXRNgM9WT76o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a0poHWM2UvuESYhmGcIj22T2pZdKMW1/rzlfsMKxQfCkEqykan2rTx8qAlU5YiHPq
	 zTkKUZgznG6GnpI0O9vwelGraXLzi3dFlyyfKhsac6i5KEzh4WVhwTYxJsmbE2Oxw2
	 zC34lMx0OKpSMqVbu1e2qAryhOKNtys4IJaxF8YDW+N1L00kGO2VhKPF0hnJV+tVew
	 GTC/AwoBrd7SaB/3mdvo07knH/a9eMSw4BJwe7jKM5cGYl0xpFUpSatm4WdTYeCiSM
	 stK3X2WXzNEN56jMPFPdYJ2iPh5x2+I4NV3mqTDR2A48VLAh8Y+9qdTBjn6mXGwcYW
	 qp+GkxbcXiO3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0537ADF370E;
	Tue,  9 Jul 2024 10:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnxt: fix crashes when reducing ring count with active
 RSS contexts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172052163001.16453.3406210447148764220.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 10:40:30 +0000
References: <20240705020005.681746-1-kuba@kernel.org>
In-Reply-To: <20240705020005.681746-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 kalesh-anakkur.purayil@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  4 Jul 2024 19:00:05 -0700 you wrote:
> bnxt doesn't check if a ring is used by RSS contexts when reducing
> ring count. Core performs a similar check for the drivers for
> the main context, but core doesn't know about additional contexts,
> so it can't validate them. bnxt_fill_hw_rss_tbl_p5() uses ring
> id to index bp->rx_ring[], which without the check may end up
> being out of bounds.
> 
> [...]

Here is the summary with links:
  - [net] bnxt: fix crashes when reducing ring count with active RSS contexts
    https://git.kernel.org/netdev/net/c/0d1b7d6c9274

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



