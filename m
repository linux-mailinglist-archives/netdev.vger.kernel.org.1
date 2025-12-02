Return-Path: <netdev+bounces-243206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90243C9B815
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 13:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A650346005
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 12:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6856E312813;
	Tue,  2 Dec 2025 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcA7L4PX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4055031280D
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764679389; cv=none; b=NHQJ6ADIGbiOysH2xpSacog988wrwfiiyXr1SnCcNXxphFTWNF8U/MnavNGCM+mpdEPk71mNAJIMpBYeFEgg9s7Qhmu2ciTJ4+Ttt5LNVixWJvt1X1hduiw0qL3Hf2hDqSBAdjnI3ioR4ylx1hj6/xBIaPFR3hEp4TGxmB/z0BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764679389; c=relaxed/simple;
	bh=aw3nZTvPz3Ho4XxxGAvYd5yHZRyDxEc2M1vfQsO+02Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n8WVmeFrhdKTfKGjrUfLsKGINh/E/0fuiju0yf6O6JCPgJ+1A0oG42dNMvMqNHBLzsGQ8zKL77z6CJ+qi56MVQTt7l8QMwFKY+l4Cu5m/399Ff+icd2NZHTnIjV9vo2W1KHCCfsZ5TUeDtdgFZ//PV6UQpOhCJ/K72jBomWstuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcA7L4PX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7251C116D0;
	Tue,  2 Dec 2025 12:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764679387;
	bh=aw3nZTvPz3Ho4XxxGAvYd5yHZRyDxEc2M1vfQsO+02Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qcA7L4PX7XAxay0QB6MpvHYcIxhqqUEB8Au1aXD9ibowQEpyv3qGDMk6JcHEbSIFK
	 d4fyzrQbS2ZOd8o0QJg26gJIMTGMMw6fSUiBkuS2XsyFqJs4/5xGz3JVcg90T5x15o
	 ZGa+zkYmSRykAIxvQqEfwsl7nZTZE8e20ZFMmJuXHLsXQx60i+H8+G5CB6O6/OYjF6
	 9LDMiAyDmNOkzE+xidXv1UHJdHcYufD5LO1LM0zYxj5P5x9lNppVNPnLsg9EULBVDG
	 xKgOkXg43y2S4s/lEoqGPwy8i/QGsrsmsyqPfgQmlWwoF4PpS7uEO23kxHhie33fBo
	 UBwI4oL9BjWRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78AA73A54A15;
	Tue,  2 Dec 2025 12:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v8 1/2] net/sched: sch_cake: Fix incorrect qlen
 reduction
 in cake_drop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176467920730.3217664.13875625137012436727.git-patchwork-notify@kernel.org>
Date: Tue, 02 Dec 2025 12:40:07 +0000
References: <20251128001415.377823-1-xmei5@asu.edu>
In-Reply-To: <20251128001415.377823-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, netdev@vger.kernel.org, toke@toke.dk,
 xiyou.wangcong@gmail.com, cake@lists.bufferbloat.net, bestswngs@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 27 Nov 2025 17:14:14 -0700 you wrote:
> In cake_drop(), qdisc_tree_reduce_backlog() is used to update the qlen
> and backlog of the qdisc hierarchy. Its caller, cake_enqueue(), assumes
> that the parent qdisc will enqueue the current packet. However, this
> assumption breaks when cake_enqueue() returns NET_XMIT_CN: the parent
> qdisc stops enqueuing current packet, leaving the tree qlen/backlog
> accounting inconsistent. This mismatch can lead to a NULL dereference
> (e.g., when the parent Qdisc is qfq_qdisc).
> 
> [...]

Here is the summary with links:
  - [net,v8,1/2] net/sched: sch_cake: Fix incorrect qlen reduction in cake_drop
    https://git.kernel.org/netdev/net/c/9fefc78f7f02
  - [net,v8,2/2] selftests/tc-testing: Test CAKE scheduler when enqueue drops packets
    https://git.kernel.org/netdev/net/c/108f9405ce81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



