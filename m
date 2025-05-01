Return-Path: <netdev+bounces-187259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA52AA5FA9
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 16:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A98757B3D69
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 14:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F301E3DE5;
	Thu,  1 May 2025 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ujoo5b8e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9DC1DE8A3;
	Thu,  1 May 2025 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746108595; cv=none; b=kPYlihI/MRTt7C3naPEq45YzJL7b4oA0yPHdhz6801/Yvr311Jw+u6UJ9yxgdaYhB116Fy1TWMm0PlRGkjUeZI7Ef0Ag6dkf/snzV5DbG8sVRfypDbZZpnyDPc/9fgXoP5O8X7qNj/TVjjKNzFdBOG8oEl33G6u5GcCgRAO8tQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746108595; c=relaxed/simple;
	bh=w6CIXgt7nx6Z0oqg6zEu5gS7IZY4p89aV0ZH5/vmAxw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oBWAnFV1i2woKtFZWViyRTCSmYXuSm1YG00otuqXBntwoBBCY2fEmGaW5yRFtKpBI6N9FplIWvO6+VPXZ5XVxUyWA3icGnoOr0FPg03YYQud34Uxnr8U7dkPawc8e6SrmrC4OZ3IMccBcHEb8NKNdHcbC238jOsqxZzmBRBRt5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ujoo5b8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0987C4CEEE;
	Thu,  1 May 2025 14:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746108594;
	bh=w6CIXgt7nx6Z0oqg6zEu5gS7IZY4p89aV0ZH5/vmAxw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ujoo5b8evjzKvboC3q0CyiEUlH4nqHxTgA/OU4fKY6ms8rBAyd1CI2Nakbx55u+i4
	 Ueke15w2D31AYYC3+sPAEvWODGJZX/1uJ3mRi0M/0zDgIDU5yuSVXpfUJH89gXpefk
	 I4WE58wio8HUpjhH2QIHl8HCv+EoHsJqY2gpjvvDykqz8MU2qhtVRw+sFAUdWGA/Sm
	 l9pH2LlJ0oPlgfnnpiB4t9ybFBrNrbKrxFs0zWz06n+cqtROq9GslQg8zKrrwaRZI7
	 4jREUMvzYaiWEGdxKTsNWfX3axnGtiv/dWTDGI9oe6dx91Gxl5/zmTnHe26JbqwfwN
	 Dzy6i7/UMJI7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFD13822D59;
	Thu,  1 May 2025 14:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: use sock_gen_put() when sk_state is TCP_TIME_WAIT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174610863349.2990404.8599127748454819839.git-patchwork-notify@kernel.org>
Date: Thu, 01 May 2025 14:10:33 +0000
References: <20250429020412.14163-1-shiming.cheng@mediatek.com>
In-Reply-To: <20250429020412.14163-1-shiming.cheng@mediatek.com>
To: Shiming Cheng <shiming.cheng@mediatek.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, lena.wang@mediatek.com,
 jibin.zhang@mediatek.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Apr 2025 09:59:48 +0800 you wrote:
> From: Jibin Zhang <jibin.zhang@mediatek.com>
> 
> It is possible for a pointer of type struct inet_timewait_sock to be
> returned from the functions __inet_lookup_established() and
> __inet6_lookup_established(). This can cause a crash when the
> returned pointer is of type struct inet_timewait_sock and
> sock_put() is called on it. The following is a crash call stack that
> shows sk->sk_wmem_alloc being accessed in sk_free() during the call to
> sock_put() on a struct inet_timewait_sock pointer. To avoid this issue,
> use sock_gen_put() instead of sock_put() when sk->sk_state
> is TCP_TIME_WAIT.
> 
> [...]

Here is the summary with links:
  - [v3] net: use sock_gen_put() when sk_state is TCP_TIME_WAIT
    https://git.kernel.org/netdev/net/c/f920436a4429

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



