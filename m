Return-Path: <netdev+bounces-242478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3240C909E2
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7156B3A8BF7
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BAD280A5C;
	Fri, 28 Nov 2025 02:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG+FJrsi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E91272805
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 02:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764296605; cv=none; b=N1+MLcujg6fyUAWRLcA3KBoLziw7Dd1f+PafRfx5Ws86fpLWVQAFNR0q3XmgzuIat8LR6B/21mnqGDUAqbnAJxuBMPRmFIeGQ8sWsP48wTAfeiKgn4kBR9x/v36KqawtrTKh7BwoGL5AUGYmCH2IItkm0lo8+fZ+50EsA9r1Uqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764296605; c=relaxed/simple;
	bh=0jahEoqTiVxaocelS8W9ZB1XnN7wluvEG4XbP4i5ZY8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d6TNTkUXuH6BIskjxZ4asXJklnbfSwImK+4I7Siec5uGYk9qPR98rgZi5HC+0UT7arKaPK7aXkGGGgRpTgQ8PKVj08hCq4uY4J008v3asGMTvlJ8RohtOuLJx0busgjs9HgqX9QyI4x2ACp+P8YDfnmOJptEWPtWhD3EjK4saxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG+FJrsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8DBC4CEF8;
	Fri, 28 Nov 2025 02:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764296604;
	bh=0jahEoqTiVxaocelS8W9ZB1XnN7wluvEG4XbP4i5ZY8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jG+FJrsi04nER/+JTSKhlDCjileMreZX/k6ytwNGNuF2xdX2RlSdBVUofRC5yZ8It
	 c+lexBY9gCpJP+QYoYPMM+Qcgn1mKRx4YVGh4eNU0/ET1CKT6qQXA/Se00t+gj8MAk
	 sbGi8g+UnA9JMKIwejB6iSGpR4GdzqvbAQO7AePf847EvYNZTZHnJZk28xpjYJa9tV
	 cSm2IfuFNSpOJZSDI8ktr9m1dHMp0vM70v1JhAOieztpncUGowp234RTSqenmexYbi
	 ZeIO6hBZykU39q4oxZz939To3N6voeFh4Z9sqYcR9FTP4lHndZ5r2EbBumImdwLfpD
	 YJ9CxNcJ/dwjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2AE43808204;
	Fri, 28 Nov 2025 02:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: bnxt: make use of napi_consume_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176429642677.114872.11579169770565204258.git-patchwork-notify@kernel.org>
Date: Fri, 28 Nov 2025 02:20:26 +0000
References: <20251126034819.1705444-1-kuba@kernel.org>
In-Reply-To: <20251126034819.1705444-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Nov 2025 19:48:19 -0800 you wrote:
> As those following recent changes from Eric know very well
> using NAPI skb cache is crucial to achieve good perf, at
> least on recent AMD platforms. Make sure bnxt feeds the skb
> cache with Tx skbs.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] eth: bnxt: make use of napi_consume_skb()
    https://git.kernel.org/netdev/net-next/c/362a161b2582

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



