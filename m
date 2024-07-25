Return-Path: <netdev+bounces-112967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B52893C09A
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 13:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1130B20CFA
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 11:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A0C1991BA;
	Thu, 25 Jul 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dReHLAA2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A6113C907;
	Thu, 25 Jul 2024 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721905832; cv=none; b=CxX5RAcaeR4Pgl+M4wXlF0eEzkYPnMvirTacrssj8LsYARSI/Axisig5VImP78h0BS58A4FhXMm0W5ql/7x/mEwCxIoj9UYktiCXbwanVsyXfcw+CnM9P5PTmMOJk0jIVRzJIDH18F4Ukfpcwoj7fOGlG53QJH5xs4XnyotOl6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721905832; c=relaxed/simple;
	bh=7GZLHlGu0lfk5E1/84zZotDHhx4rpplG5uA+AcN/49o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C1p+iHZSGFY5GZNZEuC3r1XgvyoNq1XaAgCH5KmZtewCEI08yienuhz/m0m7L5R0acvi5+vPE588j8abPh5vJADtBhMqdQy1KXEk9dX9VeT+aKqOMySsXqwrio+UrUHTSnRT8uG9YR9TUQTFHt9S2mX83npUyzAaY6FsNLt+hX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dReHLAA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBC6CC4AF0A;
	Thu, 25 Jul 2024 11:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721905831;
	bh=7GZLHlGu0lfk5E1/84zZotDHhx4rpplG5uA+AcN/49o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dReHLAA2oc1e1bdW/WoiDCwA6Z96+qHicdKVadzEDQ6TiUcxpdb1LbC4uBGgS3PEg
	 HQnDO9ME3iCrn12heHd314tAFA8PjORcBogbYp9EvyhhGLFtFbhwh2fboFs9SGeevg
	 E7dlfIePlphyMwt1BzV9nouNnm3isd5+IlPZdqdh+8imS5PfeIcasK4q1C0v7UzdwL
	 uwp6e96TbbiTJ8bt7kFDUvZ25lF8sOsLBvLtOHVlexgA5qYRfSxjrUpEh4oL+6NdPv
	 H5QH2UUByY/+TzdFakQ6gxCn8k/8IdR3r3v82hpiGmYA/YFfULl7cOvdya/bK8j9hB
	 Pbz8asp2fXOlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA53DC43638;
	Thu, 25 Jul 2024 11:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] tcp: process the 3rd ACK with sk_socket for
 TFO/MPTCP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172190583169.25674.14447045356080630577.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 11:10:31 +0000
References: <20240724-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v3-1-d48339764ce9@kernel.org>
In-Reply-To: <20240724-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v3-1-d48339764ce9@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, kuniyu@amazon.com, ncardwell@google.com,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 24 Jul 2024 12:25:16 +0200 you wrote:
> The 'Fixes' commit recently changed the behaviour of TCP by skipping the
> processing of the 3rd ACK when a sk->sk_socket is set. The goal was to
> skip tcp_ack_snd_check() in tcp_rcv_state_process() not to send an
> unnecessary ACK in case of simultaneous connect(). Unfortunately, that
> had an impact on TFO and MPTCP.
> 
> I started to look at the impact on MPTCP, because the MPTCP CI found
> some issues with the MPTCP Packetdrill tests [1]. Then Paolo Abeni
> suggested me to look at the impact on TFO with "plain" TCP.
> 
> [...]

Here is the summary with links:
  - [net,v3] tcp: process the 3rd ACK with sk_socket for TFO/MPTCP
    https://git.kernel.org/netdev/net/c/c1668292689a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



