Return-Path: <netdev+bounces-116249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66910949910
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 22:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038CA1F21261
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 20:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C3116F8EB;
	Tue,  6 Aug 2024 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/Nza7/+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D80158DDF;
	Tue,  6 Aug 2024 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976087; cv=none; b=iexfwKvKWfqyjBclffDn9UdId2lbIyfLIubJ0wr79hYBTX1h5Pv4JjN62ZyKDDW8Z/qButWySuBLlsQeeSvcPnEBU4jGCUdUVkh8RN63M7YQ47detK0jHBjyJ7nCw+SY0u8OnODTjeJTpsoKDGmc6Z0xQREAqtzaKDSbc5R2aZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976087; c=relaxed/simple;
	bh=UaND5S5bwiFcSdjyXg3oXyV9jhUNoq8C93n1XABl+k4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rUtqi+bLFmNexZbCsJwhPF3hrXmgo/sCO3s0ydDCeDo7Or0U2Hfcz2iLQB/UW5TdzrweTegeWcgyHRkq0aDds3njYjpt69ku/EPg3Xb+wNeEq5Ccqc6B9iMeBiGCYTwGhD3/pniaIOU4d1CstLkGk7I+x2NOCtLwqMDl54Z/Q/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/Nza7/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369FCC4AF14;
	Tue,  6 Aug 2024 20:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722976087;
	bh=UaND5S5bwiFcSdjyXg3oXyV9jhUNoq8C93n1XABl+k4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W/Nza7/+HIACT0cGoRdnSgOMxG4QJAwut/yYi1nw+v4w/6H6OB8MQcHxGC2GADlp6
	 6kxeVUcPEWuaRgNFV0pTY+Qh43XOuXkICW5UU+8QgGgdR6VHRouuhjTFSa6Iw4ViVj
	 U+stheoDEK2OPfeK9ZVp6BgH/+EVEwkRgfAoJqAhLexOEdURFFbXuo6tfv/9ZXwhVT
	 0hfSWRBhirnqBiVs3rTXJmNHQamFhCIE27aFGePbERthaZeXV5FSNCULp+VCwoR4l6
	 JTDxBnwFyMgBvXKZeS6KVv000r6b2YK7ljVXmQi0g1IawnuVGmV/VeuJeiVlqW+Hla
	 Xl8ZrAjiTphGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340B83824F34;
	Tue,  6 Aug 2024 20:28:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] tcp: Use clamp() in htcp_alpha_update()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172297608575.1692635.542797158588181224.git-patchwork-notify@kernel.org>
Date: Tue, 06 Aug 2024 20:28:05 +0000
References: <561bb4974499a328ac39aff31858465d9bd12b1c.1722752370.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <561bb4974499a328ac39aff31858465d9bd12b1c.1722752370.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  4 Aug 2024 08:20:17 +0200 you wrote:
> Using clamp instead of min(max()) is easier to read and it matches even
> better the comment just above it.
> 
> It also reduces the size of the preprocessed files by ~ 2.5 ko.
> (see [1] for a discussion about it)
> 
> $ ls -l net/ipv4/tcp_htcp*.i
>  5576024 27 juil. 10:19 net/ipv4/tcp_htcp.old.i
>  5573550 27 juil. 10:21 net/ipv4/tcp_htcp.new.i
> 
> [...]

Here is the summary with links:
  - [net-next,v2] tcp: Use clamp() in htcp_alpha_update()
    https://git.kernel.org/netdev/net-next/c/871cdea0f82e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



