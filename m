Return-Path: <netdev+bounces-236131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D23C1C38BCF
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 02:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA65D18863F3
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 01:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACB8223DED;
	Thu,  6 Nov 2025 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoMw2mMS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC9D2236EE;
	Thu,  6 Nov 2025 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762393838; cv=none; b=nvJYAL94NSR0kkZx/elgxV7HCiZzv06ykI1XPSfnXOHWIw96Z75zVq4SPorSosDbBWEVkytg88P4jtlK30LtQbAeJ+6iBkq62yC3mqUJLhNQ8A3EQyq7uAOJlMw1ythWbn6UAujkg8WNCO+HF8ALhg9f2Wt9krVi+y5bDtma7mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762393838; c=relaxed/simple;
	bh=BP0m4QT7uBxgp23Hd8HfW6T0p/+/D9QhWT5H1eH1MCo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jPIhMMBE0jMWTKA8z7LxqEAfyiJoR51JMJsEDn9YayqX0KMzRnkKez1OlvIRYLclkPKm4aywjvr3gNdwzgQPhF0zQrF95+A25isM6J7zMpLjuofWetm/1l8eVGahaciTAhk6js7qr5QbubM69vr6KiyDZj0aO/nZuIIxMBpGpRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoMw2mMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3783BC4CEF5;
	Thu,  6 Nov 2025 01:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762393838;
	bh=BP0m4QT7uBxgp23Hd8HfW6T0p/+/D9QhWT5H1eH1MCo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eoMw2mMSFnz9CspW94Hkc+LLRqCXN8E4+5FAZfA9tzngIS0kWbicLWs1joYyxP1ow
	 ooeNoQ7p2/dKVDIJaVNGcdBWQ83gkPb8e1tGvH7lvwA4Nly9VMUetsMLBmbNauH+EP
	 tobGJ8sfMhIzvQ6VsdVcJq0aDKgI8wSI9Fz9FqxQgwkFgNgYd0w3VjoIkzriVw0slC
	 WAUmkRZTTypwIBDAGSouuLeG6z+19cY06xEBfINsXMt5lVEZ/BEx0wlwt/aU1kHVD6
	 FBVMPaFo2Qy2bUqroFlUYB5KUo2YKJFEWm+VQU24XFvhKBzdIjl+c7T12D/gGTpuGp
	 476AWTTPSeGbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCA8380AAF5;
	Thu,  6 Nov 2025 01:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: gro_cells: Reduce lock scope in gro_cell_poll
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176239381124.3828781.17654602737481608189.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 01:50:11 +0000
References: <20251104153435.ty88xDQt@linutronix.de>
In-Reply-To: <20251104153435.ty88xDQt@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
 gal@nvidia.com, linux-rt-devel@lists.linux.dev, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, clrkwllms@kernel.org,
 rostedt@goodmis.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 4 Nov 2025 16:34:35 +0100 you wrote:
> One GRO-cell device's NAPI callback can nest into the GRO-cell of
> another device if the underlying device is also using GRO-cell.
> This is the case for IPsec over vxlan.
> These two GRO-cells are separate devices. From lockdep's point of view
> it is the same because each device is sharing the same lock class and so
> it reports a possible deadlock assuming one device is nesting into
> itself.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: gro_cells: Reduce lock scope in gro_cell_poll
    https://git.kernel.org/netdev/net/c/d917c217b612

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



