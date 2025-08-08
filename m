Return-Path: <netdev+bounces-212289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C60B1EF48
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 22:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C185A23C2
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 20:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD4522A804;
	Fri,  8 Aug 2025 20:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVQVq70i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493CC2222D0
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754683798; cv=none; b=rkDYg2H6EzzTB0Pkwp9nv4N2akIcnF7qeGhsrucwZgE4fBD3D3VEU3iqN7Dk8bidHT5gVpK8Q6/DS7YgOwgU534iDSs5GfpFZlDZDojmg7hnJ+tEPjfcwcKgy88/KqWQ2iGmno0h+3h8K0n0Qeu8JmIKlUidoby10Ge6EJ879NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754683798; c=relaxed/simple;
	bh=onyolYFwLatj3lTSOsfB9Ppk3r71ACZrMUtCEUpY7lI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aJqHMmPPKtTzhBC/wIDKyV3HnMWEo5Vqfj3IMVzjQZpjotvC6YvpQC7OEMJy2xAXGyBPaywjUr+ohgTOuqc/aSsMSnlKAfZy/FXkNvVroRcCwqgzFnitnsMz+UZ03v9dVI3pwMG0CX43POq7E9dVRNWjSmr6b8WtCV2LnvWuvZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVQVq70i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA70C4CEED;
	Fri,  8 Aug 2025 20:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754683797;
	bh=onyolYFwLatj3lTSOsfB9Ppk3r71ACZrMUtCEUpY7lI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MVQVq70i5EhnOHN8byTmw2VUlHooNW9rutuoG8w9tKwHwljT4EWIcMGQC9fgB26ui
	 nSNk9XE3pYle58ZKoSY/4U3AhPlgPiuqKSQjmFgG8ZQau8pjv9goJm2I4ebAGVmiSk
	 /XjVzQsx3httvR+ASQkxf9itOc5Oi/zSP3KxcfEFJoo7aR3BIsjCVCTYGP1TNT5isg
	 7AE3Xhz/jhyGppnapS2FFRZJtNrWasdg2iynHbBK/C2aygQTmSPYFGMBGzOxcj6pSK
	 eLTFEy4L84ZusGcNlcBntElxyMOeYJOVYFlT0b9Gfv/xdeTMugYEdouptKPhB3qjO4
	 eb0S3L8e0WmXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DF6383BF5A;
	Fri,  8 Aug 2025 20:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock: Do not allow binding to VMADDR_PORT_ANY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175468381074.252401.9572290260298434498.git-patchwork-notify@kernel.org>
Date: Fri, 08 Aug 2025 20:10:10 +0000
References: <20250807041811.678-1-markovicbudimir@gmail.com>
In-Reply-To: <20250807041811.678-1-markovicbudimir@gmail.com>
To: Budimir Markovic <markovicbudimir@gmail.com>
Cc: netdev@vger.kernel.org, sgarzare@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Aug 2025 04:18:11 +0000 you wrote:
> It is possible for a vsock to autobind to VMADDR_PORT_ANY. This can
> cause a use-after-free when a connection is made to the bound socket.
> The socket returned by accept() also has port VMADDR_PORT_ANY but is not
> on the list of unbound sockets. Binding it will result in an extra
> refcount decrement similar to the one fixed in fcdd2242c023 (vsock: Keep
> the binding until socket destruction).
> 
> [...]

Here is the summary with links:
  - [net] vsock: Do not allow binding to VMADDR_PORT_ANY
    https://git.kernel.org/netdev/net/c/aba0c94f61ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



