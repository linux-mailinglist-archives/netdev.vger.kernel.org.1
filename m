Return-Path: <netdev+bounces-124685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B713496A707
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723C91F21187
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEC11CC171;
	Tue,  3 Sep 2024 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZOB+/JH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40C31CB32B;
	Tue,  3 Sep 2024 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390035; cv=none; b=BR7OgIK9IJC5CShzHg/c3PkmSk8hIFFwEffbxl4Cwzspp2qA84GeKdQ8rLzhk4BfCdGOfoVTD5/Eoz1bc6jPt5xIjYqyTmuZr0j2zUh1VoAUvP3mZ1sD7GK2AXySHcW5xZG9m35Qr8S1SLYded1O28SrHo9P8+GxMXJKCSx590w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390035; c=relaxed/simple;
	bh=Q1RdqpN3Tc27MyISCsO34+f3XN4/sJ+Ghr8fecAwtTo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TutyI77XaMec7hTbTJm9nKNkKpYwvPYGUO0xIDYob5xXPHBuWT1pJ9OaIti1fKyE/34O0twAllxudc3YuqE/vNRTFGjhwp/bFT8vRau/9H5q+1L802+z09QvF/5YLRU+MhmGVtgLjE4M8IEXbMYdQgoqRyVX/S+yOruFo0FPQm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZOB+/JH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39094C4CECA;
	Tue,  3 Sep 2024 19:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725390035;
	bh=Q1RdqpN3Tc27MyISCsO34+f3XN4/sJ+Ghr8fecAwtTo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pZOB+/JHCss/qmgM1gcacIr6pT6j8w78oDPnWhAmDB/6+c3rXC8lrQ6vPfMijKpG7
	 Jc6MoanbqWGnJFPcBXuzDdoiRr9c+9SYVp1dYjeLsXcYOFRZumpmkCNvLkoRVRRvTC
	 a1kFR7NoNDtOhcPz3N1VcdaMVV7AdRTN8JcFG2AL7oNdoNdm0HVsi6mp9akz0/lbeT
	 SGv0+/yiipkN9L3T1tTjqr4rTji2y/gBWWMTAv1fJ7+0enTgGiRYULhFve9wGvjoW7
	 LF8Fwrf9IRC82BRQvRz0lKbzPWj4O2KVnVTPg/h7VbVSPj++t8dnKgr4vjwb8k6HFU
	 LlVkUJWYyo5iA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CD43822D69;
	Tue,  3 Sep 2024 19:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ioam6: improve checks on user data 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172539003573.406759.4090904687816815901.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 19:00:35 +0000
References: <20240830191919.51439-1-justin.iurman@uliege.be>
In-Reply-To: <20240830191919.51439-1-justin.iurman@uliege.be>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Aug 2024 21:19:19 +0200 you wrote:
> This patch improves two checks on user data.
> 
> The first one prevents bit 23 from being set, as specified by RFC 9197
> (Sec 4.4.1):
> 
>   Bit 23    Reserved; MUST be set to zero upon transmission and be
>             ignored upon receipt.  This bit is reserved to allow for
>             future extensions of the IOAM Trace-Type bit field.
> 
> [...]

Here is the summary with links:
  - [net-next] ioam6: improve checks on user data
    https://git.kernel.org/netdev/net-next/c/1a5c486300e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



