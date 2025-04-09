Return-Path: <netdev+bounces-180883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D753AA82CD1
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 18:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8251B62237
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F9526FA7E;
	Wed,  9 Apr 2025 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQ2noW3B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE861DFFD
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744217397; cv=none; b=P/XBRpPNUje/fH8DJ4yrKleNP4di3PGr3MVLX4rGlhkQ2dThlgE6BeHtk/Pfw8aDREPBlPCd5fEDaYsJVfz+NPYw0TrCPYu1WTLb8AVyvbAa2YVZkAPhii6dOxwlfr+GkhXxKBTg5UGVfT+bIHUQKJKvv7OUdL7EDc8GFj1ahI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744217397; c=relaxed/simple;
	bh=BXWZYwQePfs1IW/QGuARdCGkTgrkL9I8E/ercchq6Gw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DmKFJmHPYz7emY62D4oEu1lsHVOOR3tKkNe/KN7Y8gvfp2kughJAnKQnvsgDglsbetMxa+QgFInEfE0iYmkZytFqCSiyy770ggaFA9iuUz+hnNUi07Xdw72GmECPfXqOIOnu7VGCYKh/zwpa0EcrhETxZpiIBQVrSPeBh79K6z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQ2noW3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80807C4CEE2;
	Wed,  9 Apr 2025 16:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744217396;
	bh=BXWZYwQePfs1IW/QGuARdCGkTgrkL9I8E/ercchq6Gw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iQ2noW3B22JS30Gpi8TWArPty5t8pQvzPEkjcvq9lfAKRyxdYJEO0XkmG1wX5jmwh
	 yUFPA/hA5jUHN8/hWFgWzZVWR+6aeoz16AbR+ZANeB/djzryJu/2IUF9xiYLfFUt+8
	 9WP47HTyGjs8N6+My2SDo/AEa1AW9wxjCIUSOSt4OIh0xyUOmvvSNQ7K8LKtTt0opS
	 vESHLorkHv1oPVBLtc7l88Kjz0d+fSVhMBbVz77p3WEUtL4zsAslpDKT4rJlofMAm+
	 Y1bpybNcHn3ScVelJDD/QQ5Ns/i/2KNmHjSTid58le2RhP/KsO30CAYkf8S6yi8nnX
	 XpeYQHyo73foQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340E138111DC;
	Wed,  9 Apr 2025 16:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] nstat: NULL Dereference when no entries specified
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174421743402.2899666.7680810154216692309.git-patchwork-notify@kernel.org>
Date: Wed, 09 Apr 2025 16:50:34 +0000
References: <20250409150330.1238768-1-23110240084@m.fudan.edu.cn>
In-Reply-To: <20250409150330.1238768-1-23110240084@m.fudan.edu.cn>
To: ZiAo Li <23110240084@m.fudan.edu.cn>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed,  9 Apr 2025 23:03:30 +0800 you wrote:
> The NULL Pointer Dereference vulnerability happens in load_ugly_table(), misc/nstat.c, in the latest version of iproute2.
> The vulnerability can be triggered by:
> 1. db is set to NULL at struct nstat_ent *db = NULL;
> 2. n is set to NULL at n = db;
> 3. NULL dereference of variable n happens at sscanf(p+1, "%llu", &n->val) != 1
> 
> Signed-off-by: ZiAo Li <23110240084@m.fudan.edu.cn>
> 
> [...]

Here is the summary with links:
  - [iproute2] nstat: NULL Dereference when no entries specified
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=866e1d107b7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



