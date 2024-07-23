Return-Path: <netdev+bounces-112542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5818F939D45
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 11:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013541F22839
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 09:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970E814BF85;
	Tue, 23 Jul 2024 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibw833MX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717BD14B965
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721725832; cv=none; b=EtAaIMOfwpYjqN0Xfk5FFbnplfrECKuGOwLlDAAu917Dv4X6XaCxT1eJ8e63+L4YgekC0sNdWtc/iGhgSVr62E9r/4m9ZK1oGzFBZoia/nxS9AuGOPSAq00mC1KFaOxq3KCT/uHXu70RKtFVx+1s4HGdIBVjLSdhCroudFWkXhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721725832; c=relaxed/simple;
	bh=jKuXc+KYwhcgEedEeLdlT70XF+7xANwiOKeTAqURRdw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lFUeq1Wx/BjHriCk9f6YAMksFX6pmC12WNSxyR/+C8IYFQBzLXgaJC00oLMaQ+8zcx6oiDhilmWnFrUPIU9gezNl9R2ggmr8K2sQ5bTDmxZeNd7F8emNs0OSsvLq/xt4yBnONRGagZqvPtp4jsyYJvVealvR9t/4tjeDzHob1vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibw833MX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB756C4AF0F;
	Tue, 23 Jul 2024 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721725831;
	bh=jKuXc+KYwhcgEedEeLdlT70XF+7xANwiOKeTAqURRdw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ibw833MXduX34eZAgPITflqq8toqS0LcL2bUsCflumcgd05d3VvXBKOyek6CAIrJa
	 GHRJQ1RQ10GCasoGC5wGCPAI3QnbYEcZC/MTPtpZUSB1l/yBtWdqM6nG4vHb6LhQPW
	 47lsUnKfWBKBL77eQ9I3AKyA48Eh7JBfMI1JNpuAW9l9IajvjVa4GjuriWPTS4uVKo
	 cO4VTX3PGV13BKSnxGPNW6KSqy/82gtMP8iPg77sHBeC/NXtIWmM+PMR/YIP+c05lJ
	 zwhhy+Ci34qrBnXfClO6MuMrBdN9IWeRRDk06fjwEqrz+jtEfTTmYCiM94T5YN9ALT
	 gWezAw7RIMrUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE046C43638;
	Tue, 23 Jul 2024 09:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv4: Fix incorrect source address in Record Route option
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172172583084.17339.14532873737217557138.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jul 2024 09:10:30 +0000
References: <20240718123407.434778-1-idosch@nvidia.com>
In-Reply-To: <20240718123407.434778-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, gnault@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 18 Jul 2024 15:34:07 +0300 you wrote:
> The Record Route IP option records the addresses of the routers that
> routed the packet. In the case of forwarded packets, the kernel performs
> a route lookup via fib_lookup() and fills in the preferred source
> address of the matched route.
> 
> The lookup is performed with the DS field of the forwarded packet, but
> using the RT_TOS() macro which only masks one of the two ECN bits. If
> the packet is ECT(0) or CE, the matched route might be different than
> the route via which the packet was forwarded as the input path masks
> both of the ECN bits, resulting in the wrong address being filled in the
> Record Route option.
> 
> [...]

Here is the summary with links:
  - [net] ipv4: Fix incorrect source address in Record Route option
    https://git.kernel.org/netdev/net/c/cc73bbab4b1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



