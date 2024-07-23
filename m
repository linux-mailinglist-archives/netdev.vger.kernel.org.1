Return-Path: <netdev+bounces-112545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36171939DDA
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 11:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3CDDB242A3
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 09:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAAA14C5A4;
	Tue, 23 Jul 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/9cr+Sf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C3514A636
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727033; cv=none; b=N7sRWQnc9qdYibnCuI8r+JTLsYf4T8Bucf5W7tCmOvBQeizTzw2CpO+zDl7YXoPBX49rBVRw8g7Y0Q9fb252Lx7sqYur3OVYAI+PKsc9ge24GPsQyECCkNQFX83VJsCMVCpaM4LIW3GMcS5xRHjwuW/3tvq7aLB4k3mca/wcCGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727033; c=relaxed/simple;
	bh=k5dvMn1ecwVdSIRAlRrVghmpU/9mE3p59NkEBFoQ3Og=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WGtBQQIz5C1Brm/Y8dsp8u4QkgIIr90yA9jrrd75zpQAldmTGdzgRU08CJdicOji0mASwoT6HaiJCsweX86rlLFJXwAw+g0NFo4Zsbu9p+IyUH/lu73YHIj+zbVhGa9M2377rStU9I3jVToaeUx0hNn/FrwjfhDuRKp4Lvc2Uxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/9cr+Sf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBCF1C4AF10;
	Tue, 23 Jul 2024 09:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721727031;
	bh=k5dvMn1ecwVdSIRAlRrVghmpU/9mE3p59NkEBFoQ3Og=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i/9cr+Sf8YJ5cMYKTWZm5/9vxKetxeFITPv5E6AspxFh34mhRpn9KP/iZ+3zO9Qc0
	 s0qjo2D0jvbIPJLWS87BIAIQkDNSxSSrpdf+cBkqmE/h5XvcGgvFBze0TKFz9pi0Wc
	 TfM+MFOpd8toM/G3P2IeRADpHNqA/6sQuaDLZlreIP1W3NIEWCN7iZ5px1hs7Qh5QR
	 mNuWi7UJAcy9lUXDgWtp1Vi5Sn1eIzuURwAYTsO5799yWOsaVEKWxjE9iKp8tTkcA+
	 e/5sH8FPLQOcfGJfpMeqSYAMjR9t/7K95OkBh7lg5oQ+Lr/uGA7iwQ39DQA3hT6Vgb
	 qml6uupujsXUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3B97C43638;
	Tue, 23 Jul 2024 09:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] l2tp: make session IDR and tunnel session list coherent
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172172703179.29019.16936082654523907056.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jul 2024 09:30:31 +0000
References: <20240718134348.289865-1-jchapman@katalix.com>
In-Reply-To: <20240718134348.289865-1-jchapman@katalix.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, tparkin@katalix.com,
 samuel.thibault@ens-lyon.org, thorsten.blum@toblux.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 18 Jul 2024 14:43:48 +0100 you wrote:
> Modify l2tp_session_register and l2tp_session_unhash so that the
> session IDR and tunnel session lists remain coherent. To do so, hold
> the session IDR lock and the tunnel's session list lock when making
> any changes to either list.
> 
> Without this change, a rare race condition could hit the WARN_ON_ONCE
> in l2tp_session_unhash if a thread replaced the IDR entry while
> another thread was registering the same ID.
> 
> [...]

Here is the summary with links:
  - [net] l2tp: make session IDR and tunnel session list coherent
    https://git.kernel.org/netdev/net/c/d587d825424b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



