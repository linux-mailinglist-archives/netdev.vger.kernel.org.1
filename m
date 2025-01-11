Return-Path: <netdev+bounces-157341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B86A0A037
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 03:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E218116AFD0
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 02:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796A9133987;
	Sat, 11 Jan 2025 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFehsCPe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C0612EBE7
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 02:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736561415; cv=none; b=ss9RSSeqUszq1k++tzXuiji4kC1h3MnhBEzwBLRUOab58mEwvu6nmmY72Ky9uvnfgewS5GzqJ+Y7zaESah/8Ex+PSGT9vzzlG00kLwWQoMUksIqf1QWzDOUYpCaOJ2JnH2GCRBlAWtq9ezrxqSvx3OcjxbhFwdYzEul/FGuWacE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736561415; c=relaxed/simple;
	bh=NYvsaEJunVXFgngVtaM67FK+sbt1NwccZOg7vROwOTU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iBry71DfVY9P3jwWzWMVIEoYePJgSPHIbis4kqB95TwAFxGIGHim9e3SH4q9IShSW2/95qOt0Q3JIKAjHuq9uz402hNt1d9qZppp9eKI4HZSPLcsnzLCjFNF0viwoy9lu3dZR5GeYQ9BVyHL7phpSxNx/aJLvCH7KZQxAvkUnLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFehsCPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94A4C4CED6;
	Sat, 11 Jan 2025 02:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736561413;
	bh=NYvsaEJunVXFgngVtaM67FK+sbt1NwccZOg7vROwOTU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lFehsCPetscOlvDLOJ2ZoQOFTTlbaCR91bXUNOynCdl/gQcy/z+1lnRdhswCWvhEQ
	 AEXaM4f3fu+q40YsM7wQ5wbvMGIvtGNf7Elm15YbXX7rIZ2szSakVsIOQ4CivzCDus
	 4qu2D6FF6VXMdPd+8SEmHw2RPOx7PD6cF/zuWX7JH7eunh1Im1H+Eyr9hq87acsu2/
	 p6gB/iQA+qVC4K1fbKcnPctKDJdd67jU4LKFio6OUWHYUVqKZnzCETKirdsXfB+aUY
	 n3GW8L9I5HpQyMGRpWinPIwAmXBj3Pz/Fhd9HYbjTqZbwaHgg+z1GNxUhguDPEOpBb
	 konz8m8+JCMkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBF83380AA57;
	Sat, 11 Jan 2025 02:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: bnxt: always recalculate features after XDP
 clearing, fix null-deref
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173656143576.2267647.18443979361093126097.git-patchwork-notify@kernel.org>
Date: Sat, 11 Jan 2025 02:10:35 +0000
References: <20250109043057.2888953-1-kuba@kernel.org>
In-Reply-To: <20250109043057.2888953-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, andrew.gospodarek@broadcom.com,
 pavan.chebbi@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Jan 2025 20:30:57 -0800 you wrote:
> Recalculate features when XDP is detached.
> 
> Before:
>   # ip li set dev eth0 xdp obj xdp_dummy.bpf.o sec xdp
>   # ip li set dev eth0 xdp off
>   # ethtool -k eth0 | grep gro
>   rx-gro-hw: off [requested on]
> 
> [...]

Here is the summary with links:
  - [net] eth: bnxt: always recalculate features after XDP clearing, fix null-deref
    https://git.kernel.org/netdev/net/c/f0aa6a37a3db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



