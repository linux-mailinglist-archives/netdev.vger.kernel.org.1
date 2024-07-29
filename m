Return-Path: <netdev+bounces-113594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD08D93F3F7
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 13:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AFC2B2229F
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B447D145FF8;
	Mon, 29 Jul 2024 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PP6GAM4D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9091A14535E
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252244; cv=none; b=Hm+Zui3KS10dVBuA8DU2pgH7XNsiiK21M76aop2Qp1VcMpvWaqcrLirA/vp6wTUpwoulk+1XZoJ0qUoKhHC2z5UFUWC6/DeyzvXEsk4OE9wUMdol+Ve/MmaqAS8z5FNb2ccMBpp4RVEsakgQjmunywReQtA/f4XBJbbuIhsrMEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252244; c=relaxed/simple;
	bh=3HZg3NNi9MU6fcFJwNpTFRwnLZ5xwOD2qD8LBquuMTg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I3zVhRDX1Tlf7Nyx2y2uEZsA79A+QXUYewY/1ZkmNDQnHi4eXufAS/71Rka0PJc6iY9j6CMJ+NGNLrkuvYoE1OijFLOQzzeGFhCtMDZ4nT6KieVmFc1L7Snu4eSjnCRoCIXG75B/nJPkDmtTF122rRj1nvDJEscskpZEHYHFhVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PP6GAM4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69F13C4AF07;
	Mon, 29 Jul 2024 11:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722252244;
	bh=3HZg3NNi9MU6fcFJwNpTFRwnLZ5xwOD2qD8LBquuMTg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PP6GAM4DbsaIoY11iolPCY7SRggT4TC93xczzDh032tJrtgAyBEiOOLAE236twqP3
	 WzsdTrXRXYaKyrIq+O+37GRVV9xnjnJ7F9ohMHixRTpdXVRtiwoI1sQskWyMz3x7+V
	 07d9zCDavnJWqpcFQvayUXaF6T9AfqwCZgReiwT9PQnvnvRuhZGw63+itc+pKkZc+Z
	 rFBgtIrPBkNE+Vpuw7QKyes2LoEAAY7e6ngx3V4LDVikZAK1e5/OCkEyTPX0xVgbI8
	 7fir+V1kQKx+4jdek/d83XQaUDJ582Gtm+rNNq2FIiWUWIciY4Fwp3wUiwvxbeInRy
	 bpifOKay/au2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56D5AC43443;
	Mon, 29 Jul 2024 11:24:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tcp: Adjust clamping window for applications
 specifying SO_RCVBUF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172225224435.15294.3818067109385283098.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jul 2024 11:24:04 +0000
References: <20240726204105.1466841-1-quic_subashab@quicinc.com>
In-Reply-To: <20240726204105.1466841-1-quic_subashab@quicinc.com>
To: Subash Abhinov Kasiviswanathan (KS) <quic_subashab@quicinc.com>
Cc: edumazet@google.com, soheil@google.com, ncardwell@google.com,
 yyd@google.com, ycheng@google.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org, dsahern@kernel.org, pabeni@redhat.com,
 quic_stranche@quicinc.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 26 Jul 2024 13:41:05 -0700 you wrote:
> tp->scaling_ratio is not updated based on skb->len/skb->truesize once
> SO_RCVBUF is set leading to the maximum window scaling to be 25% of
> rcvbuf after
> commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> and 50% of rcvbuf after
> commit 697a6c8cec03 ("tcp: increase the default TCP scaling ratio").
> 50% tries to emulate the behavior of older kernels using
> sysctl_tcp_adv_win_scale with default value.
> 
> [...]

Here is the summary with links:
  - [net,v2] tcp: Adjust clamping window for applications specifying SO_RCVBUF
    https://git.kernel.org/netdev/net/c/05f76b2d634e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



