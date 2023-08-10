Return-Path: <netdev+bounces-26504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B1D777F95
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 19:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A371C2131D
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D6B2150C;
	Thu, 10 Aug 2023 17:50:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062CB21509
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 17:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D1E8C433C9;
	Thu, 10 Aug 2023 17:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691689824;
	bh=g4u8uge+dPninFJar8bRaD64DraSJdhn1Nxe9Vil0vg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uIW+bbajdHCLqw0ZRjjGN5tRYz0cctn+lYfT+og4xZ92SdN9AKxy2ERXLEj4FYuOn
	 iI2FYP9IScFUFEAopMaXi2YAp3kjLyK9Y2bR4rWJgRcgKVrS38NJMUa7jcTwtYEX2E
	 bJtusiJB0xJbFC2OJANaV3MU2rXG+kmvqAqcuMCaxET3D24phGytVZazdwHA+vcaOT
	 57Z+oWGsliDMIQ5+7dQjdJWC59D6kGUFIDXWYaZsfrrtfSC2XyhGTt4OPWPrHtEZdL
	 gRdrHkWBywyjku4nZQKVp7GQVb/Ze/rBuvEuFVzL1b7qLge2Q+ecTfRElmzpPaBL9E
	 W4DsdPmgRdIAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 666B3C39562;
	Thu, 10 Aug 2023 17:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/5] ibmvnic: Enforce stronger sanity checks on login
 response
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169168982441.6158.1052882645470833839.git-patchwork-notify@kernel.org>
Date: Thu, 10 Aug 2023 17:50:24 +0000
References: <20230809221038.51296-1-nnac123@linux.ibm.com>
In-Reply-To: <20230809221038.51296-1-nnac123@linux.ibm.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com,
 danymadden@us.ibm.com, tlfalcon@linux.ibm.com, bjking1@linux.ibm.com,
 horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Aug 2023 17:10:34 -0500 you wrote:
> Ensure that all offsets in a login response buffer are within the size
> of the allocated response buffer. Any offsets or lengths that surpass
> the allocation are likely the result of an incomplete response buffer.
> In these cases, a full reset is necessary.
> 
> When attempting to login, the ibmvnic device will allocate a response
> buffer and pass a reference to the VIOS. The VIOS will then send the
> ibmvnic device a LOGIN_RSP CRQ to signal that the buffer has been filled
> with data. If the ibmvnic device does not get a response in 20 seconds,
> the old buffer is freed and a new login request is sent. With 2
> outstanding requests, any LOGIN_RSP CRQ's could be for the older
> login request. If this is the case then the login response buffer (which
> is for the newer login request) could be incomplete and contain invalid
> data. Therefore, we must enforce strict sanity checks on the response
> buffer values.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/5] ibmvnic: Enforce stronger sanity checks on login response
    https://git.kernel.org/netdev/net/c/db17ba719bce
  - [net,v2,2/5] ibmvnic: Unmap DMA login rsp buffer on send login fail
    https://git.kernel.org/netdev/net/c/411c565b4bc6
  - [net,v2,3/5] ibmvnic: Handle DMA unmapping of login buffs in release functions
    https://git.kernel.org/netdev/net/c/d78a671eb899
  - [net,v2,4/5] ibmvnic: Do partial reset on login failure
    https://git.kernel.org/netdev/net/c/23cc5f667453
  - [net,v2,5/5] ibmvnic: Ensure login failure recovery is safe from other resets
    https://git.kernel.org/netdev/net/c/6db541ae279b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



