Return-Path: <netdev+bounces-81286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6471B886E19
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 15:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2051B2890FC
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C0347796;
	Fri, 22 Mar 2024 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vq6yU9ni"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4991145C04;
	Fri, 22 Mar 2024 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116632; cv=none; b=Nd5b1/qs0E1zHFmp0ak5sNQvNkymQquFC58uZahjTghFDSZq7mIjio6ZIEIcjk7jtnfXCnkObT6ZcsxVckLs62cjcDtoT6EPaVHI1CimgOQLZC8s3D9V9V2zvxRofbYVQYF3ntVqxCmvx3P/TbmlZmmZ8TbrwtqIq0SMMnWyODA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116632; c=relaxed/simple;
	bh=UJSkPQdmSuwbvpvn1MU1yW2g8eospL/A3cdPfFC03MQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MouwkqO7mTYHwxif7VqD5WLg8lqOkHr53eUN/nggQfSCiVSuMdsyXE/WzusQkZ7gMOB2uPXrvmjFiycFY36K4vrH/yPkKhCW9cX0AX8f0STtIw05wz/NnobonqHMWykdntjVJzoVHiyJNMISSo3w1C4CPfd7O+YLGOL5tV2ZRWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vq6yU9ni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B49DC433A6;
	Fri, 22 Mar 2024 14:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711116632;
	bh=UJSkPQdmSuwbvpvn1MU1yW2g8eospL/A3cdPfFC03MQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vq6yU9nia5+1BSyvvXsiSlK0Eydp56iKGulVIJ/a/AH1LnxpTNz/SVYXva8jJbArc
	 HzIceziOEvEM0wxYR8fk4km7zqp/ry0A1v/jpQQguu4dHTNneE56W7o6TcgrQKuRgh
	 QlDbc5ETmUwx9c8byqSU2rpHCiiRwZL2CisC+oJgRJgMwm81WnQiMEuPnxECDOV6ss
	 1hhy3FiwTqDIrqd13+K1xbJPOveGAy+ROd1PzDwAJcsCjzCAZDh2v08PtUC+WTzrzX
	 kfwXWj0AvtoVUUsB482AFiZQrxiqyeNdljCRMGCbIV21bgmVg/hzOcOq/yldprEEck
	 WneJTTrXA4nlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05566D95056;
	Fri, 22 Mar 2024 14:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bpf: Don't redirect too small packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171111663201.19374.16295682760005551863.git-patchwork-notify@kernel.org>
Date: Fri, 22 Mar 2024 14:10:32 +0000
References: <20240322122407.1329861-1-edumazet@google.com>
In-Reply-To: <20240322122407.1329861-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 daniel@iogearbox.net, ast@kernel.org, martin.lau@linux.dev,
 andrii@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+9e27778c0edc62cb97d8@syzkaller.appspotmail.com, sdf@google.com,
 willemb@google.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 22 Mar 2024 12:24:07 +0000 you wrote:
> Some drivers ndo_start_xmit() expect a minimal size, as shown
> by various syzbot reports [1].
> 
> Willem added in commit 217e6fa24ce2 ("net: introduce device min_header_len")
> the missing attribute that can be used by upper layers.
> 
> We need to use it in __bpf_redirect_common().
> 
> [...]

Here is the summary with links:
  - [net] bpf: Don't redirect too small packets
    https://git.kernel.org/bpf/bpf/c/96b0e83341e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



