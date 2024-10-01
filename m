Return-Path: <netdev+bounces-130785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA5598B85B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A291C215C8
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0691119D896;
	Tue,  1 Oct 2024 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLPSDzss"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF7A2B9B0;
	Tue,  1 Oct 2024 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775026; cv=none; b=k9eHPRXXb4jchwZKOeWCWC6rich52exTrHsMZI9FiyHF4rMgvP7XQnxJU9xm/x6VPYl+YM3rz0dnnmBFID7HYm3tLJFczcEJ8xgnA3by1a42tzg7rt56ReIYOgnJTmWtpuqglTc4ctMtqFFZLiTicMzswEvMLgfP/ZfC/uT92ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775026; c=relaxed/simple;
	bh=tWNfICn0W1DUK/esXrV9AsDDWg0FRW3WWkcRM1XG9S4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F0kZW471JWv3VOh03LKxAOzxghpDsD/ZJpBjQqnMgMslIYjAWC4yuCV5CuarBX9FVxrigjnh69i/J59uKD4SZle7WAV7bQ/okGY9igFEVHRC6N5EQ6DT1g9aax+X0Dyn4zfRJGzxbIeYlHgoEbciYlSYT+SAQrhVur+3VYVB3cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLPSDzss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632BCC4CEC6;
	Tue,  1 Oct 2024 09:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727775026;
	bh=tWNfICn0W1DUK/esXrV9AsDDWg0FRW3WWkcRM1XG9S4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rLPSDzssJfRviz+ONpJi0GcrwI58Dc6pD8AcYXsnjTmZLIto7eMaW5Gk07G1R8IA+
	 7vQk1qmBQXVwkvxV4ndzncn/ttJ9aTkOKqaZbM3aBgzrmEc7FacerQWdV7ikZ8GWJz
	 dbbiy8z3xfIMLXEadXYeqpUwuvCQxZVcjDDeyts5uRVsn1uwDMqZxfjadGBNsfteBq
	 ss3DYP5NsYIgGFlL/XnwZySmUp7+XcVurW3cwEuQ51KNQ2S7WnIXxO/Q9sLbT81KJL
	 kIPFMJ5HdTdthf5/Bq9Zmp3B28zR9ipHeHtkFYUHax90Fs8bqp338FjNHeTCJFisV7
	 jvBCMiDLvPT8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDB0380DBF7;
	Tue,  1 Oct 2024 09:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net: fec: Restart PPS after link state change
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172777502951.282084.1532796568092277354.git-patchwork-notify@kernel.org>
Date: Tue, 01 Oct 2024 09:30:29 +0000
References: <20240924093705.2897329-1-csokas.bence@prolan.hu>
In-Reply-To: <20240924093705.2897329-1-csokas.bence@prolan.hu>
To: =?utf-8?b?Q3PDs2vDoXMgQmVuY2UgPGNzb2thcy5iZW5jZUBwcm9sYW4uaHU+?=@codeaurora.org
Cc: Frank.Li@freescale.com, davem@davemloft.net, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, wei.fang@nxp.com,
 shenwei.wang@nxp.com, xiaoning.wang@nxp.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 24 Sep 2024 11:37:04 +0200 you wrote:
> On link state change, the controller gets reset,
> causing PPS to drop out. Re-enable PPS if it was
> enabled before the controller reset.
> 
> Fixes: 6605b730c061 ("FEC: Add time stamping code and a PTP hardware clock")
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: fec: Restart PPS after link state change
    https://git.kernel.org/netdev/net/c/a1477dc87dc4
  - [net,2/2] net: fec: Reload PTP registers after link-state change
    https://git.kernel.org/netdev/net/c/d9335d0232d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



