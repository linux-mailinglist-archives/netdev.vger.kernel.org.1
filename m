Return-Path: <netdev+bounces-199486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D2EAE07C2
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DAD31BC1E9F
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 13:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C3A253939;
	Thu, 19 Jun 2025 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scosJUry"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75EF246760
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750340979; cv=none; b=IIIm/eV8e5b4hdrKinyrSiPHeHeyzpzl6zywTcBLkBFDVwBlc5KTnG/exiVcHalWzVZhxfTjiLMJymeXrXfgTM9m1aW0J6T2H58Tjg4A/8ahFXQ8iniJjQCDeTSPdEPnpMUX4wgtfweZAMpM7bWXIwiEDaD/iGdkpvtWRFhecek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750340979; c=relaxed/simple;
	bh=dlz4DjfEQFbvvBfoZaeTTe3ZHtjsPWB8QMdF5h8IrSI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ry4ZMLFnk96bL1ar+RxbTnvNqHFxvraFwyoXa19U5BklobOVemLfvY/X8PMyZnQzo9bdCiqetBvy4JwxR0DeJ4MDW2ZVemaGePrl4aiDjqkT12SCxClcwmn9gg/fAsUDbRClrnmDRs2NaceJ2hTBku5BkS9N4eQ03R9sQXvauxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scosJUry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B90DC4CEEA;
	Thu, 19 Jun 2025 13:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750340978;
	bh=dlz4DjfEQFbvvBfoZaeTTe3ZHtjsPWB8QMdF5h8IrSI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=scosJUryVMFim9ZMKqSl3ofzgURge2oWoKDxOKzvAPsEKVOxqlCT8w3z60sJVY6/Y
	 d/O9EXzQhqaSctvOKRPQt4ykq+6+FFcUI/iLJ0PrNLc1YBsBGVjMYiHqkN2a/ijnz7
	 +ZNX3uNcMkb/gM6VUsd4TboUwF67tCSv77ma1d1cztU0YBc/tEQ5XG4MHizbe+k+GI
	 08UR4YzYzHxInJxdBiItYbvZQgJVMr7os8uDxKiCi+5K2iK2m2Tzv5j1h1D5/+cjce
	 XgCEcnd5Q3aOpYFv/gS5I3YArXX3s4UhPadLGZimpBprmly4aHziI3zraoL7ChsYfK
	 xbal8RrlXyeZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCDE3806649;
	Thu, 19 Jun 2025 13:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: lan743x: fix potential out-of-bounds
 write
 in lan743x_ptp_io_event_clock_get()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175034100651.871721.7772490906730492689.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 13:50:06 +0000
References: <20250616113743.36284-1-aleksei.kodanev@bell-sw.com>
In-Reply-To: <20250616113743.36284-1-aleksei.kodanev@bell-sw.com>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Cc: netdev@vger.kernel.org, Rengarajan.S@microchip.com,
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 Raju.Lakkaraju@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 16 Jun 2025 11:37:43 +0000 you wrote:
> Before calling lan743x_ptp_io_event_clock_get(), the 'channel' value
> is checked against the maximum value of PCI11X1X_PTP_IO_MAX_CHANNELS(8).
> This seems correct and aligns with the PTP interrupt status register
> (PTP_INT_STS) specifications.
> 
> However, lan743x_ptp_io_event_clock_get() writes to ptp->extts[] with
> only LAN743X_PTP_N_EXTTS(4) elements, using channel as an index:
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: lan743x: fix potential out-of-bounds write in lan743x_ptp_io_event_clock_get()
    https://git.kernel.org/netdev/net/c/e353b0854d3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



