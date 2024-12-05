Return-Path: <netdev+bounces-149225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4F99E4CAF
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 04:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133F8188150E
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 03:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729F0193070;
	Thu,  5 Dec 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZGNuYwc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78D192D8C
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733369429; cv=none; b=EMxURgr/OlV5Xp5v08CD1EZl1o4NRQntAI5j1SaxVEx0UBDiU/lim6IwwOk8hW72XIA9KS6ZuIUHo3gPI9uyUkNtBNZhsC3ksvJ7iBYhVa0dffySMa6RM2S8RXJncn4T4nDjtM7sNk3KzrZXeco6LeIjTSfkqXbY1mOG7raVaiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733369429; c=relaxed/simple;
	bh=NUPWPljbMM6q2TLnfN8QDB62k4/hdZ/devp692bVk80=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c6Kkn6VdBnEak0ETLB+hbQmLyZs+TtcEJgVQvPOh7eQMzA6lZ0YI/JAUKU4I8la9eLBv6qlHd6HrTWx5wsVsJuazySVl/qWLxMHA/rSp5RPHTGU2neyd+d68wfxFtu1CH0aXsCOWHKXAqfdBA7YpnAlYqj4+OulWtPnFu3yzN7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZGNuYwc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAF2C4CEDD;
	Thu,  5 Dec 2024 03:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733369427;
	bh=NUPWPljbMM6q2TLnfN8QDB62k4/hdZ/devp692bVk80=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LZGNuYwcmjhyFobRfLkHH746SX8tTlcU+8c4p1IVuNw0tflA7fMUkaLb9cOG8ILoT
	 8ZvTikNStSwC0lWpPDu6YaqeLpgbwjkuj95wm09v4zWIuR1bWt/xI2WNI/VHbjczb2
	 RJ+/FzN9LuwY1FevdPk35RSYUus0zTsHpgvDA3jroVcIco8d+o5OJp88XDOuLJxZB9
	 WvFH6cpszP3kUKILVHbJcKCJo8AVBFyItjSC+TT1I3WQFkPrueQfdoPDkMTf+H+aAy
	 7SmKl36lC4BvLj0njqvG4vfr11F7GScOliHNz+Xve7ZM9eWgGzmoRO6vZ87et8dIIX
	 rGj9hrK+BOafw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD6D380A94C;
	Thu,  5 Dec 2024 03:30:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] inet: add indirect call wrapper for getfrag() calls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173336944251.1431012.5221221722890199033.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 03:30:42 +0000
References: <20241203173617.2595451-1-edumazet@google.com>
In-Reply-To: <20241203173617.2595451-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, willemb@google.com,
 brianvv@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Dec 2024 17:36:17 +0000 you wrote:
> UDP send path suffers from one indirect call to ip_generic_getfrag()
> 
> We can use INDIRECT_CALL_1() to avoid it.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Brian Vazquez <brianvv@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] inet: add indirect call wrapper for getfrag() calls
    https://git.kernel.org/netdev/net-next/c/5204ccbfa223

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



