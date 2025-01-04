Return-Path: <netdev+bounces-155184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 879C6A0160A
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 18:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9159F163882
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 17:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224B31CF7C3;
	Sat,  4 Jan 2025 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPXAnm9m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CE11CF5DF
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736010015; cv=none; b=s3A+YDkmY2eTjuixjwKDiaVSBSPkn1FLLW68KV5pJgm9K4ptWZRZjVG8aziQqvR9/JcpjSX+EBw/nlZ4uOz/pSF1jqg0chNadqdabFw6SQM8hF2GbIQqTeob3bTykZjT/7yuUVz8ilz1X8Dv5mGavNaCiL8PKhhDA8d9ODJAbOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736010015; c=relaxed/simple;
	bh=JlOcihMlpWNphUz3fxEXDKxYQDU/djMkUmyT9sCutFw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nJzCOdjcEdJyOucu04k7MqGJ0MsUOCm22XeiUGWweduFYYJxvHMiNJAY1VjMKbRky3QLpIMVX1CVSLEJtQ4HbmdbeBZwy+0MWm/oCpLcpg8nkliJkxR/Zd3WXFipoM+UuJyR0J9w/e4c9sfaaaH2A0LiLlkWH770pody8X1RJNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPXAnm9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75289C4CEDF;
	Sat,  4 Jan 2025 17:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736010014;
	bh=JlOcihMlpWNphUz3fxEXDKxYQDU/djMkUmyT9sCutFw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OPXAnm9m7P/vfA0NNE/n093o4x653fRrX0wY18FMLe4WaFYOpNh8HeLw7k3abMn2d
	 1kcYZPubGoyW9IKbqnccanKObkYTkW/4u1ktE0l+p+Gjk2/wt3HydUfnb3ZRVmRaMd
	 09o0unMq863Hj3H3InyIfap7zE2NKPIkPruAjuZdB9Xq3ZPhiR67Q1s5rL4nxha16J
	 3O1Q5uyBvkv4yoFYG8DkKgfsf6bhpVnilPVCyQ2DTf8GnCyeXqYGwTowxw4ADX3EYh
	 FxxQryr5dcTuCgIofjV0QagD1ko1myfjhkMuDKoWWw/xN31AzDsY9jItiDNIe3B0tc
	 S0EVJ/tM1fVwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D65380A96F;
	Sat,  4 Jan 2025 17:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tcp/dccp: allow a connection when sk_max_ack_backlog is zero
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173601003524.2470506.11417048645260557728.git-patchwork-notify@kernel.org>
Date: Sat, 04 Jan 2025 17:00:35 +0000
References: <20250102171426.915276-1-dzq.aishenghu0@gmail.com>
In-Reply-To: <20250102171426.915276-1-dzq.aishenghu0@gmail.com>
To: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kerneljasonxing@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 kuniyu@amazon.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Jan 2025 17:14:26 +0000 you wrote:
> If the backlog of listen() is set to zero, sk_acceptq_is_full() allows
> one connection to be made, but inet_csk_reqsk_queue_is_full() does not.
> When the net.ipv4.tcp_syncookies is zero, inet_csk_reqsk_queue_is_full()
> will cause an immediate drop before the sk_acceptq_is_full() check in
> tcp_conn_request(), resulting in no connection can be made.
> 
> This patch tries to keep consistent with 64a146513f8f ("[NET]: Revert
> incorrect accept queue backlog changes.").
> 
> [...]

Here is the summary with links:
  - tcp/dccp: allow a connection when sk_max_ack_backlog is zero
    https://git.kernel.org/netdev/net/c/3479c7549fb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



