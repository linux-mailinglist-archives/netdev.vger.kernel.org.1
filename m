Return-Path: <netdev+bounces-86430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589D089EC56
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3DA1C20F4E
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 07:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9207C13C911;
	Wed, 10 Apr 2024 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiCulge3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA551C2C
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734828; cv=none; b=W3Z7JdQcFrUWZ9ffm3S9DOl9UPQnVTyECMTjXG0XKUPNStvwzoyw/ypmclKOl1Hg2RMQahCZbQZnM/ATr+yvdXDIX9dUWgMfGpzI89djNS6AYY9W4kkqA0XpkSCPQRA/IOElj00L7Y0syyod9NJ9dEYTw6aJ7wuvFWBO7K52Av8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734828; c=relaxed/simple;
	bh=SBisXyztToOY8YDbi6mUZjZG+y2ZUStAp1yW6FBTFL4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g5ktUDh4SG3DMVPeQHnDQkckQOaUFUBhvqUxr/IEP/qPUTzvG1AVWbH3Rvz1Frawjr7lOolhsgqbVPZn572CmaSnKA5GbRevoMgtw1Me8roFtJFCpdaj18cjuTGED7trhBtvG1RKfjTEKuwlMLdj9SBw2AmwAwhHVPgpb1EEPHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiCulge3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08F1CC433B2;
	Wed, 10 Apr 2024 07:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712734828;
	bh=SBisXyztToOY8YDbi6mUZjZG+y2ZUStAp1yW6FBTFL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kiCulge3y9cseW+DGCXGTLZKhey2pBdBFU22yCCL9v0qJ+4oXzhrJeXMKHJsZ61WJ
	 1RhM3i040R5SX4o2HH2Zaafnvh+THtqtTPkUlWTiEMgsHrp6jZtiaA0yCNPMQiTFZP
	 SLNGn75GXF3DPqcSrhIH3Be18jhKXka+08ykV24Kiat0TQZvS2SDPX0XN76SEVg3Y/
	 lj4BqdY8G79JLuZKgiobFRfTmqZos7Xoj8LPtfVLDNR/S7EEoWNwLRcJWxD01AeDrQ
	 0Y5dfDy5pjysnWgiQ23veJMWDtk0nv29kHu+ZlDA+vnJQ4k9fQCFJbvbsK9BGHbN+p
	 /+18aeZC9iH9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EBDF4D60310;
	Wed, 10 Apr 2024 07:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] pds_core: Fix pdsc_check_pci_health function to use
 work thread
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171273482796.17683.7507623750601074441.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 07:40:27 +0000
References: <20240408163540.15664-1-brett.creeley@amd.com>
In-Reply-To: <20240408163540.15664-1-brett.creeley@amd.com>
To: Brett Creeley <brett.creeley@amd.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, shannon.nelson@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 8 Apr 2024 09:35:40 -0700 you wrote:
> When the driver notices fw_status == 0xff it tries to perform a PCI
> reset on itself via pci_reset_function() in the context of the driver's
> health thread. However, pdsc_reset_prepare calls
> pdsc_stop_health_thread(), which attempts to stop/flush the health
> thread. This results in a deadlock because the stop/flush will never
> complete since the driver called pci_reset_function() from the health
> thread context. Fix by changing the pdsc_check_pci_health_function()
> to queue a newly introduced pdsc_pci_reset_thread() on the pdsc's
> work queue.
> 
> [...]

Here is the summary with links:
  - [v2,net] pds_core: Fix pdsc_check_pci_health function to use work thread
    https://git.kernel.org/netdev/net/c/81665adf25d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



