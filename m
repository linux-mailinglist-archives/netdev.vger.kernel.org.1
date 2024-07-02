Return-Path: <netdev+bounces-108323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7166891ED6B
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 05:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C34E282B92
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 03:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A348171BA;
	Tue,  2 Jul 2024 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlA0vBA0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5553314293
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719890428; cv=none; b=Ni6n45EDTfa7omVGSrAQVw0gadQrBQTovEjBkoRmr0ZUXBsIvnn5eJHZmLBUUvuodacxWb2l4pSkUPU7lx+0ShrWoNecqXcIKHG0rlKbhSbBJuSF1eCoGWG/uIRwT54b7g6prOcb6HDri2L3QtauExSaGjPeBqGco5fv/kz06kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719890428; c=relaxed/simple;
	bh=PwFN3Xi2xlb1F2YUzRX49HzB2Yg824z/FU665suewxA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EL95wRuRg43DUMBQ6X4RlPOjAUSQ2iRPEVKoyLe8uV1tdfykIVFKFTHzFhVzlw1u5Rsqhkt2medoK3XQusCtbt9ABsjExUjMZQ1PRKg9qLWfOnjL3PqIDEr/TunB99spkIII0oRKNj4RN4TF9Rtw3nexhpFO8XKk52OtbXyBb2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlA0vBA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF482C4AF0A;
	Tue,  2 Jul 2024 03:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719890428;
	bh=PwFN3Xi2xlb1F2YUzRX49HzB2Yg824z/FU665suewxA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VlA0vBA0UEiG+zX1bu1eGkibbwJiA1yPGXswXz/O9iyNnJyXpHH8j8ERQGJgoQah9
	 vRAbrja2RrUsYCa+7eOIvQg1mAzy1Rhoug95bAflwNNooxjWEXNCR17nL/jMVdQS4q
	 27F5TUoooXFhUNGwg54uJalU5qcAhSppL+CM49kxEmASdVBDI7oNFJgBc0+A0U8ZOZ
	 B6nVsHK95WbYu/rsnfqiRTLDv2HiHDicvBYEBDWT6vrPjQInHk0ZgzLmfFa94Mcd9a
	 8Jo9MSTpZWS6s7yqUt5EJ91vnhSoYFqDKVsBPkya5N3TxMNZELSvGrtisrmxTmuOe8
	 yKg7YDCDRzThQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF59CC43468;
	Tue,  2 Jul 2024 03:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] e1000e: Fix S0ix residency on corporate systems
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171989042791.2079.3009648083879967425.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jul 2024 03:20:27 +0000
References: <20240628201754.2744221-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240628201754.2744221-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, dima.ruinskiy@intel.com,
 sasha.neftin@intel.com, vitaly.lifshits@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Jun 2024 13:17:53 -0700 you wrote:
> From: Dima Ruinskiy <dima.ruinskiy@intel.com>
> 
> On vPro systems, the configuration of the I219-LM to achieve power
> gating and S0ix residency is split between the driver and the CSME FW.
> It was discovered that in some scenarios, where the network cable is
> connected and then disconnected, S0ix residency is not always reached.
> This was root-caused to a subset of I219-LM register writes that are not
> performed by the CSME FW. Therefore, the driver should perform these
> register writes on corporate setups, regardless of the CSME FW state.
> 
> [...]

Here is the summary with links:
  - [net] e1000e: Fix S0ix residency on corporate systems
    https://git.kernel.org/netdev/net/c/c93a6f62cb1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



