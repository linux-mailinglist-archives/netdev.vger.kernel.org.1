Return-Path: <netdev+bounces-70958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C53A851375
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 13:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5CC284A10
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 12:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3195839FE8;
	Mon, 12 Feb 2024 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ri0HhneJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFB339FE4
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740427; cv=none; b=TF2bTN3fZq0OgCUxiCfeUJw094hY55Qm6omI3RyNXT/kQ1+e5DldjUnkPbDns3qzKAl8HmSv4LglEJhNbRd1d76z25lfKnzzpkG9sDXeNu4Hu2r3ZKAswXpikkLTByAJvvxpqq+PdtLh5z7Gz3yet7cTz0hCaEjxt2VkeHR4spY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740427; c=relaxed/simple;
	bh=eWGc5VyZtymkZvSJmzqlkvhVxCihmiF/u9V3UoRSFVE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H7q7kEoiThZ280060S7EpV+zE3BMjOAM9NYUGc7NYx118C0peejZek57qX1vsL3Tb7ARD3H71QEV/1vE9K1aPezHm9NwR4QXPXPP0ZBZAHirlu17G0Q9pctXo/gBFSjcm8X6WQhLFc01oV/xZ3f9Cobp1CMOHFa46E64JKs5mtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ri0HhneJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E3CCC43399;
	Mon, 12 Feb 2024 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707740426;
	bh=eWGc5VyZtymkZvSJmzqlkvhVxCihmiF/u9V3UoRSFVE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ri0HhneJerzyITGaD0dAhOzoJblJ2XYAKwtNSWISwDhb8feDZvjbkt5sGjQVH3yJ+
	 xk/oSc12cXEYFWA57tqs5S1z81Km3n1B/cig+hvM2ZlcAqN4mx0atxK4QQYPc619Av
	 GxE16r12I/EJfL8VJs7E9U4hJ0bKxPMr78cs4Fc/VoNoIe5W4YhM86J0vSEQSJz5NW
	 /+ELK6NA6VTiIHfFsWIcuESSi2kGhGuzxyTPMKtfnAMjU/T0VbyT/k/2JjkeLkItx3
	 0+nDdoc8Asbino/nqi81LHlGrSNXunt+AxD/quDf+DJp3ofbf+fRMANJSNrX19aXpH
	 ijV3uJXsr2ocw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B948D84BCF;
	Mon, 12 Feb 2024 12:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] net: avoid slow rcu synchronizations in
 cleanup_net()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170774042630.14948.14659988438736910273.git-patchwork-notify@kernel.org>
Date: Mon, 12 Feb 2024 12:20:26 +0000
References: <20240209153101.3824155-1-edumazet@google.com>
In-Reply-To: <20240209153101.3824155-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, pablo@netfilter.org, fw@strlen.de,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  9 Feb 2024 15:30:55 +0000 you wrote:
> RTNL is a contended mutex, we prefer to expedite rcu synchronizations
> in contexts we hold RTNL.
> 
> Similarly, cleanup_net() is a single threaded critical component and
> should also use synchronize_rcu_expedited() even when not holding RTNL.
> 
> First patch removes a barrier with no clear purpose in ipv6_mc_down()
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] ipv6: mcast: remove one synchronize_net() barrier in ipv6_mc_down()
    https://git.kernel.org/netdev/net-next/c/17ef8efc00b3
  - [net-next,2/6] net: use synchronize_net() in dev_change_name()
    https://git.kernel.org/netdev/net-next/c/4cd582ffa5a9
  - [net-next,3/6] bridge: vlan: use synchronize_net() when holding RTNL
    https://git.kernel.org/netdev/net-next/c/48ebf6ebbc91
  - [net-next,4/6] ipv4/fib: use synchronize_net() when holding RTNL
    https://git.kernel.org/netdev/net-next/c/2cd0c51e3baf
  - [net-next,5/6] net: use synchronize_rcu_expedited in cleanup_net()
    https://git.kernel.org/netdev/net-next/c/78c3253f27e5
  - [net-next,6/6] netfilter: conntrack: expedite rcu in nf_conntrack_cleanup_net_list
    https://git.kernel.org/netdev/net-next/c/1ebb85f9c03d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



