Return-Path: <netdev+bounces-142464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADB59BF44D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ECC2282EAD
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 17:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06071DF995;
	Wed,  6 Nov 2024 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y453Tv6R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5D4645
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730914229; cv=none; b=iP68p+LdSpze6mt4n1rJRHRepsRXvEu6Y2ggpNfmBEmxliEHBNX/dokzTbeE7gfk8unyFqrgXmeLM2dMi+sE33z6sVidZlnONwwHgEviMRj5TYx8a79IkEF1ZE3rxJD6IFz64pe7A0go6R0CSeCbyWyOYKZm4IWv28KRXNcxmPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730914229; c=relaxed/simple;
	bh=gjWISwyjGmyqM/bx0jAZBoOOj29zgC6nP9V+6DoA5p0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F9UdmUDUh7FzdxTaQiOXI7FDq/jQOTrO+oZBiuwCNExblzVoLndYzQ4GQQmzTbj69BOB+bvb31JB29e7VW6CNW9UEGaDKfy5VXSYtTGIjmM7dXMymRlJlnDIRUZfGIwQDNwmI8tbz4nRO3CXRVxs53pCQc04QrK+N7YPczRZKzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y453Tv6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDC8C4CECC;
	Wed,  6 Nov 2024 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730914225;
	bh=gjWISwyjGmyqM/bx0jAZBoOOj29zgC6nP9V+6DoA5p0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y453Tv6R3FZcUGHBUZP17ASobF07n9PAPc36T5E9J83CERNWAp3uzQ8Lwe6/2MHzO
	 u2O7cIvwva5r6afdhTEIKQB0JcwFFAkTxmGEfp8kbRnmcMNmyB37XfGky4b5x6Rv32
	 FEQIM/EJ78KILnEISD9ziu9KN8OcPMnyitWUksdfVDuDx2DsL91FrT09fW7gONoUPb
	 EL6TkOSwMJK+YBYOM1ExU/1ieb7mAmX9dX+/LixuzVAFg/HCfNlibX5QZPSW8E/y+5
	 nwp7JVko/RU09u6yN6GAbWgU8g9cF6Md+5IZfUSv50kutq2x2qCbD8H1iUiMbgnThA
	 TH3GXWRW3Na3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4733809A80;
	Wed,  6 Nov 2024 17:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [iproute2-next] lib: utils: close file handle on error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173091423475.1355897.16499637098719370026.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 17:30:34 +0000
References: <20241031121411.20556-1-kirjanov@gmail.com>
In-Reply-To: <20241031121411.20556-1-kirjanov@gmail.com>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: stephen@networkplumber.org, dsahern@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu, 31 Oct 2024 15:14:11 +0300 you wrote:
> reap_prop() doesn't close the file descriptor
> on some errors, fix it.
> 
> Signed-off-by: Denis Kirjanov <kirjanov@gmail.com>
> ---
>  lib/utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [iproute2-next] lib: utils: close file handle on error
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=c009c955fdae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



