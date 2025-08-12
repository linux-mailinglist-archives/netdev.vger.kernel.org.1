Return-Path: <netdev+bounces-213101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51052B23A8B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 23:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D566E51F9
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 21:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581DF2D73A7;
	Tue, 12 Aug 2025 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd/tIrio"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1732D73A3;
	Tue, 12 Aug 2025 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755033617; cv=none; b=kY+tWlmIEjvW1puXzXzE5GgkWzAYl7Rq77tU3SCcMzs26YuuQDKeKYhXcfWceYR0GNrkkH8RsL4ErVyIjpKY4bpvRUPNiwU76UJBa5M/Q/SSP1cKLvTaLM01dyH4tVptQnRsFwVJ0cwQrq0rjfDLn6ptkP+QRJsyJmKaOYoyLso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755033617; c=relaxed/simple;
	bh=25WwL4LrJpis9hco0B4caLuaAxQo/y+rJqKFWMzRRmY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I64itHtHe8vbOjSeBQjrUM22/MW07DlsmawekD3Sit1YXhB1Ada8XZ6aSeE91g5uO2HGmnRDBXY+5EsvF34b1UGSlQHCX5ZYL56NCZcN8oensRtrQ9XENsZARfRvy9kuQlCv2FEjdK+ejbLnbT1ZAXWF4MuAlHLJY6+6mzXgiEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd/tIrio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FB0C4CEF5;
	Tue, 12 Aug 2025 21:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755033617;
	bh=25WwL4LrJpis9hco0B4caLuaAxQo/y+rJqKFWMzRRmY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qd/tIrio0yBy/a9usKZYtEIHYbb6LBXAxcZoYQuMIeGQyWQ5uFpS/9Dzq9wBmr2vE
	 Qx/tO0GBATqQRBwdcgxSXtWc2mQ282q2+KkNfESE5tWmQdr6e0/r1/30DHaplfb3vN
	 wavBOArDo49ZDHrLiycMQ8g3bNLrBzYX2w6kmBVHfdUq2q5zD4DV+kIQcV25F4K94+
	 stSuIf6P1kpzP0SPpzwcj+inwysUxorm3y2qVwUV3iMKrL8DsIpJEH4bT+tJuNlnW2
	 4TbxJooE52bEVjn4TbvyenoiXxlIKPPHVsCJ4Qgh97WbGiQHRNPKFKD/GkoBMAMZV+
	 loEyKDOt1GOqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D09383BF51;
	Tue, 12 Aug 2025 21:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] caif: Replace memset(0) + strscpy() with
 strscpy_pad()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175503362874.2827924.7880375273804759284.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 21:20:28 +0000
References: <20250811093442.5075-2-thorsten.blum@linux.dev>
In-Reply-To: <20250811093442.5075-2-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Aug 2025 11:34:40 +0200 you wrote:
> Replace memset(0) followed by strscpy() with strscpy_pad() to improve
> cfctrl_linkup_request(). This avoids zeroing the memory before copying
> the string and ensures the destination buffer is only written to once,
> simplifying the code and improving efficiency.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net-next] caif: Replace memset(0) + strscpy() with strscpy_pad()
    https://git.kernel.org/netdev/net-next/c/63fe077c21d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



