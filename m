Return-Path: <netdev+bounces-117476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FB494E146
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 14:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2FF1C20986
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 12:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7993D219FC;
	Sun, 11 Aug 2024 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViVaN3KJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AC1441F
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723380660; cv=none; b=mbipKhj7ScSEBxvfj2L6DgEPpJUKKhsFfsiXHwlJsNblLaXbvOUi4GMfdazZyvFDiNhyd+tlmNnTHheWHmIdf3IwMpSXjVs8V8dx/aWnHdCqNOYALXa8IFKPPlGCfRP/a9z+8N4XhKf/GcBaN2lpgHkeuUA3x6qicWMoJSLdwVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723380660; c=relaxed/simple;
	bh=TYa1yNrZX7BCNfF0OEhpmp++P/zIIrgWOb4cm1dr9Gw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p9WS95k8MlKo5BOSNIHHTotMpe8d/mENx1Cjw8KEAY1Ro7F3ussxMN6KT+sWpDPT2/quKCdFLJrZWiukdCKeqxyev+ThaFeZgwcLClxMU9qd/AB0FZncc1gD10BgjqVzBRZORQtQI5GSdoelOyX4/d3S3YexnRJK6x0gTD1Nj1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViVaN3KJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD968C32786;
	Sun, 11 Aug 2024 12:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723380659;
	bh=TYa1yNrZX7BCNfF0OEhpmp++P/zIIrgWOb4cm1dr9Gw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ViVaN3KJdLYZEeHiCFVmpFtlyjvnKfNN7PkcqNCBB4/6pw0lMQvY5cYBjQX8Gw3fC
	 OeIcFy0HW0z2efyWX+6KRK8wNKMjt5uOPX8nlJK3w7yelcgWpLapwuPSK6E+XraYih
	 PUBfTYkHhWeuBGLFHzzrmsdUElvJC39vpK2zF81w8Cs7Syy880NoDdWnljePr8kQi8
	 TxP9J59e5m6oH4WMLI6aqFTeQwj6+4E/gBOL5tWzYX8jD2cpx4HusigbAy5wXg12N6
	 Ezh/QKz2hKlc2bxjnZn0GgQosOp2aUJ9yxwIJpafiz1WoPxHjU1vt0h64yLxarDypC
	 qlmE/zCVFiAyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0053823358;
	Sun, 11 Aug 2024 12:50:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/6] fix bnxt_en queue reset when queue is active
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172338065877.190808.4655047140584915796.git-patchwork-notify@kernel.org>
Date: Sun, 11 Aug 2024 12:50:58 +0000
References: <20240808051518.3580248-1-dw@davidwei.uk>
In-Reply-To: <20240808051518.3580248-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, michael.chan@broadcom.com,
 somnath.kotur@broadcom.com, wojciech.drewek@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  7 Aug 2024 22:15:12 -0700 you wrote:
> The current bnxt_en queue API implementation is buggy when resetting a
> queue that has active traffic. The problem is that there is no FW
> involved to stop the flow of packets and relying on napi_disable() isn't
> enough.
> 
> To fix this, call bnxt_hwrm_vnic_update() with MRU set to 0 for both the
> default and the ntuple vnic to stop the flow of packets. This works for
> any Rx queue and not only those that have ntuple rules since every Rx
> queue is either in the default or the ntuple vnic.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/6] bnxt_en: Update firmware interface to 1.10.3.68
    https://git.kernel.org/netdev/net-next/c/fbda8ee64b74
  - [net-next,v3,2/6] bnxt_en: Add support to call FW to update a VNIC
    https://git.kernel.org/netdev/net-next/c/f2878cdeb754
  - [net-next,v3,3/6] bnxt_en: Check the FW's VNIC flush capability
    https://git.kernel.org/netdev/net-next/c/6e360862c087
  - [net-next,v3,4/6] bnxt_en: set vnic->mru in bnxt_hwrm_vnic_cfg()
    https://git.kernel.org/netdev/net-next/c/d41575f76a6d
  - [net-next,v3,5/6] bnxt_en: stop packet flow during bnxt_queue_stop/start
    https://git.kernel.org/netdev/net-next/c/b9d2956e869c
  - [net-next,v3,6/6] bnxt_en: only set dev->queue_mgmt_ops if supported by FW
    https://git.kernel.org/netdev/net-next/c/97cbf3d0accc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



