Return-Path: <netdev+bounces-228079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729E5BC0F26
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 12:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315F83B02DD
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5031D2D3727;
	Tue,  7 Oct 2025 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMO+ErHE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272EE2580D7;
	Tue,  7 Oct 2025 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759831218; cv=none; b=H6dgzoB74yeMogApz5apqXBM9CqerhpMY4eas35cimriXEKGLxpwhASkkZK+EJOllrvg05Xy1qB8pAM47P1zCG8oVuMoae1PGADXvjILI93TO0lfd9yCKG3B9265rYiZkvRt67btuPPPM7PcB0GNizamN5cBWXgn7ett88qa/uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759831218; c=relaxed/simple;
	bh=26b/KkPYJCt6d8MrfpnwaQ7x221GWUL75dA2hP3alhE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A2mKez/VDceCj0CMKEQ9zlYOLMeAcj917paZEFOGCllbHqNv1eyUct3jC2jszidYbICDn2DtJNfaqXn+mB4BOzCQPOmsWHlrGN1VrI6yIRofXIb3Wd4Qe5c3hpoUOIllx6wXgqtm5UIkKrpgjXn9b5cAARJRjjBCwpmwsY4hvNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMO+ErHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9ACCC4CEF1;
	Tue,  7 Oct 2025 10:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759831217;
	bh=26b/KkPYJCt6d8MrfpnwaQ7x221GWUL75dA2hP3alhE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IMO+ErHEr9iZwPsXmadTwtt/i9torSmuWIEjGHKQhdOHtaPrHhgOqaT0qcQQ4jlVL
	 RLtHucK7Q2ee+rgfs44Y73I2V+oNlX7g/t09LpQq4DJ2M5jszZIBXoYLZ5ZJauXI+1
	 q7RYVHPYm/Xh7LQMkkGGjQfyUuGdZXy5nnMMSpJo5/V/8urMqVXR9KpJyBAX+Rkd7q
	 /M/vO0+Te5IdIds6R/ifn4yRFez2VfN6BG/ZH8E8RH2WM9cmdX59IqEKathBX1Yudf
	 UtMBn9+Pg++wjfWWXarrY2U4XKsuioSph5r1SlgBe3sNxFXMtOWqqRRvJsj/tIRrBn
	 sAu4so41KIOxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EE339EFA5B;
	Tue,  7 Oct 2025 10:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sparx5/lan969x: fix flooding configuration on
 bridge join/leave
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175983120701.1833525.11091874014123062686.git-patchwork-notify@kernel.org>
Date: Tue, 07 Oct 2025 10:00:07 +0000
References: <20251003-fix-flood-fwd-v1-1-48eb478b2904@microchip.com>
In-Reply-To: <20251003-fix-flood-fwd-v1-1-48eb478b2904@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, UNGLinuxDriver@microchip.com,
 steen.hegelund@microchip.com, jacob.e.keller@intel.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 3 Oct 2025 14:35:59 +0200 you wrote:
> The sparx5 driver programs UC/MC/BC flooding in sparx5_update_fwd() by
> unconditionally applying bridge_fwd_mask to all flood PGIDs. Any bridge
> topology change that triggers sparx5_update_fwd() (for example enslaving
> another port) therefore reinstalls flooding in hardware for already
> bridged ports, regardless of their per-port flood flags.
> 
> This results in clobbering of the flood masks, and desynchronization
> between software and hardware: the bridge still reports “flood off” for
> the port, but hardware has flooding enabled due to unconditional PGID
> reprogramming.
> 
> [...]

Here is the summary with links:
  - [net] net: sparx5/lan969x: fix flooding configuration on bridge join/leave
    https://git.kernel.org/netdev/net/c/c9d1b0b54258

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



