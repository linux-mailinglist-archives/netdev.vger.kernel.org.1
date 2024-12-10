Return-Path: <netdev+bounces-150713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7D99EB39C
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDFC1188250E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4A91AAA20;
	Tue, 10 Dec 2024 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXpEeDNe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B5F1A2C0B
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841614; cv=none; b=S/DkgcPa+Q2rFfJbgmIKNqS2csYWZrVfmwaDn3oivcCeGfAcC56ob6H8o5L1qwA91TESN5RpnH0SpCzII93MMHvOtAflve6ae6M2MgRxoddOB4uCgP7CJMwpA9i4rrvzv2Oc1gqMd4wK8jxagtJvgavn+sUrQN+48vZYJR/ivw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841614; c=relaxed/simple;
	bh=0ffRYXIVUSExUCCLZHV5yItlaolVn8Wn6/4CkQ03Oxg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uZBDkv2Y13Ov0MlraOH5FlxlB52+Jqded6CJ7DtOG+cfGvMcVWt+jaZFSaCXM0CW79a3lvoZd7uJl6uHodLHX2/OKfL38aKjEAA8zCErBwkFRSJA3O3uGndWhnfEu5vCA/h+pmdlaJlqwA5TgdubKRbhreBYj1qYPqpB4XFyRWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXpEeDNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D5AC4CED6;
	Tue, 10 Dec 2024 14:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733841614;
	bh=0ffRYXIVUSExUCCLZHV5yItlaolVn8Wn6/4CkQ03Oxg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cXpEeDNeXniBplCn0sfV5QYTGpFTc8K8d1nmuPeDzp5Y+Xje3GuWwFic/uZjHc/sB
	 yVjaZffeb15zZMvRSev76gj/YWerzBNqDvGHsNOPs0pXIZuoz6IIO9KR5K0lxcq+B4
	 ItBaUqtSXXMAbiQC5YhLQfxVqfo4a7zPUhWc3bIYb8QY/fjaBTn3su0B6q5Kj7MrXO
	 jMK/HWTL4pj2+OOASSuVRjdM4FTeLPBwl1wehYtYKVJmSwmd8ezy/wsOQNe6QFxNlh
	 6vkZ12vr8K0tnQkVD6fr0GtRI85E0B1LDT/PkraRWooBsr1joVcCtOXSRCSaMDdPaB
	 05/cW/0f4TRQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3442C380A954;
	Tue, 10 Dec 2024 14:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] udp: fix l4 hash after reconnect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173384162989.835489.4988486681580985293.git-patchwork-notify@kernel.org>
Date: Tue, 10 Dec 2024 14:40:29 +0000
References: <4761e466ab9f7542c68cdc95f248987d127044d2.1733499715.git.pabeni@redhat.com>
In-Reply-To: <4761e466ab9f7542c68cdc95f248987d127044d2.1733499715.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 fred.cc@alibaba-inc.com, cambda@linux.alibaba.com, willemb@google.com,
 lulie@linux.alibaba.com, sbrivio@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Dec 2024 16:49:14 +0100 you wrote:
> After the blamed commit below, udp_rehash() is supposed to be called
> with both local and remote addresses set.
> 
> Currently that is already the case for IPv6 sockets, but for IPv4 the
> destination address is updated after rehashing.
> 
> Address the issue moving the destination address and port initialization
> before rehashing.
> 
> [...]

Here is the summary with links:
  - [net] udp: fix l4 hash after reconnect
    https://git.kernel.org/netdev/net/c/51a00be6a099

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



