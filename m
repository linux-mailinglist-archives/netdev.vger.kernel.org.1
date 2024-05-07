Return-Path: <netdev+bounces-93915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C818BD936
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 04:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948AB1F21CE6
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 02:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F57D441D;
	Tue,  7 May 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDoYnyiP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DED1FA5
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715047232; cv=none; b=OLnxGT8P+ErQoFOIg2gkcJ37V9owH3FU1IsEEmlIwRC1PUxF5XBLPixuv5UADWxRhMzUimgoBojhCl9vhpUeuLakwVmc7KHYszkU6Xwh3AirT0JxjxCI61Yi0hFVXH9CEjIsbJV0R04hM7fFtjTaBfpsfZAxzdmxUdtGJ2khgUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715047232; c=relaxed/simple;
	bh=TQ6O6ghgalslE1P7LHosilAfRO6nndY0Vg9GSPZml7g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uLHu7XncGCifBQyso+u8CrDCBs+Il0OC4xlKz/l0+r7mJFrTTtb5Wneibly5+NJQnLWc1O6qReCDgs1hkZybp8C4M5zdowLBo79UWlCX4H73Q39pV5HiCynTwsdwE8GiSabFqIvSirKKhzmwASKzJlrGSDwQhz+rI5c/yhB6UFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDoYnyiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88DB3C3277B;
	Tue,  7 May 2024 02:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715047231;
	bh=TQ6O6ghgalslE1P7LHosilAfRO6nndY0Vg9GSPZml7g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MDoYnyiPh5Gsm3/SEdok42VvEXRT1azgCjIGoWvFqpkGGnnpMRTtrmn3NagjfAJiK
	 VZHJYARCTYpTIYniuHiiSjS5xnWIFbhQcAC1gVPF2SwghOt2kHIM0xDG2RoZ82qV3e
	 Q/Se5QThy7sFxR3Bnqzm5MIJgHFa70d8Txn4utABwM4lamc0dt290RVn7JxOpQZgfO
	 EPmWLg1aToFWMN+gDajsXJcuWhxZu8JXlxR83dGDJXNesxiGXMVJaMYOo+ddqCFbsU
	 vIUXffOU8GqBLnJ66oInrrU9MdJ4tBFukV6MNYxeEG3T7YwdmRkzYF+rvH5YLvVp/a
	 MLtWqNB2OqmxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7716FC43333;
	Tue,  7 May 2024 02:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] phonet: fix rtm_phonet_notify() skb allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171504723148.13822.6899925292658413370.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 02:00:31 +0000
References: <20240502161700.1804476-1-edumazet@google.com>
In-Reply-To: <20240502161700.1804476-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, courmisch@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 May 2024 16:17:00 +0000 you wrote:
> fill_route() stores three components in the skb:
> 
> - struct rtmsg
> - RTA_DST (u8)
> - RTA_OIF (u32)
> 
> Therefore, rtm_phonet_notify() should use
> 
> [...]

Here is the summary with links:
  - [net] phonet: fix rtm_phonet_notify() skb allocation
    https://git.kernel.org/netdev/net/c/d8cac8568618

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



