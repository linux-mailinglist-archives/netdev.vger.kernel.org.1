Return-Path: <netdev+bounces-100420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D588FA7FE
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 04:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D155A1C2475A
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 02:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7507E76D;
	Tue,  4 Jun 2024 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzPklpxG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9B91E485
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466433; cv=none; b=J+enLLwdfT41q9Vc1LyTuGgoUQ82U3Gvv1wXqhAHN7ZCU6aN2FEHHcIlyEWStdR40mNshjymnXDzxMsEJD3wUXR6/KYgmjHTf+eq4Sakm6KdaYp7nkzfGRwjDLHtPmpkzrkAZjMGDu4RonblnMD8a9xfTwqCYM1b4Fnoxo41iOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466433; c=relaxed/simple;
	bh=OO0vdciaq+yReLss7vOloqdUcHxMS6b/hoHl6eHXBu0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q8xJzVeMi5OdJxBGJ42VrdGNboBUrxFkQ16aLmAa+5IvDF3JEFKbXxQ0E2Htkk7NODn5MKYBwL7ymadyF7HrJKHrAfUI6q+Q73C2fopQ8IHnu64Bv8F9gIddLe+9d1TPYpQ+dJVVYvvX56oRvlQ4KDCaCw3Rm78bHhyOK2CANs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzPklpxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A05D9C4AF09;
	Tue,  4 Jun 2024 02:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717466432;
	bh=OO0vdciaq+yReLss7vOloqdUcHxMS6b/hoHl6eHXBu0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LzPklpxGj+Plt7Y/Htty2bYG9dAXRxwPAdFuH2tTUQGrc4QUANan7IBtgpvdH0X/w
	 0vD91A1BAdwKQALXnVKwkBZtreJfNCS1BRbHXnkEVM9M6pOs+11WbZl0siKBoFKF60
	 HXKicECMTrDDmyiBDQAivb5o2GRNK23+0fceB3m8tVuaQx7v1rHflogZ+/GKrRlKsP
	 H3gNBOli41+1X6QtmaeerVPkmtGxgNVEMdBtIVHV0WFIpG6O/RYBonhB147RRo3ZAm
	 r+sEXfCv4tY6NK7IGgptzjRLEZGec8B6b36cGgAE9B+rl54GOfeU9kwHpMimxfEEgv
	 cjhC+uWdN7NBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B7C0C32766;
	Tue,  4 Jun 2024 02:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] vmxnet3: disable rx data ring on dma allocation failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171746643256.10384.11378282669711534225.git-patchwork-notify@kernel.org>
Date: Tue, 04 Jun 2024 02:00:32 +0000
References: <20240531103711.101961-1-mstocker@barracuda.com>
In-Reply-To: <20240531103711.101961-1-mstocker@barracuda.com>
To: Matthias Stocker <mstocker@barracuda.com>
Cc: kuba@kernel.org, doshir@vmware.com, pv-drivers@vmware.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 May 2024 12:37:11 +0200 you wrote:
> When vmxnet3_rq_create() fails to allocate memory for rq->data_ring.base,
> the subsequent call to vmxnet3_rq_destroy_all_rxdataring does not reset
> rq->data_ring.desc_size for the data ring that failed, which presumably
> causes the hypervisor to reference it on packet reception.
> 
> To fix this bug, rq->data_ring.desc_size needs to be set to 0 to tell
> the hypervisor to disable this feature.
> 
> [...]

Here is the summary with links:
  - [v2] vmxnet3: disable rx data ring on dma allocation failure
    https://git.kernel.org/netdev/net/c/ffbe335b8d47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



