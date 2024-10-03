Return-Path: <netdev+bounces-131428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB3F98E7D8
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094431C228B3
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 00:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A0C1BC3C;
	Thu,  3 Oct 2024 00:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhhO6Hbd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5CA1BC20;
	Thu,  3 Oct 2024 00:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727916039; cv=none; b=r/YCom15JqJpRKLvoVpJ268TIAWVsBhcsU6autgUjU6S6L0oHcap3/Wx4LOgosaXvTDloxKw4/ZxBrcyg0G8NcdSEektOGq46G43k7GhnDyi7TFFD/YqlSzwqDACAwHpdPeNNFVBPzwvndru0LBoOZyxKfTfVuP+d+LNCGw791I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727916039; c=relaxed/simple;
	bh=ubg2yzOpxd3KbR42Fu2Dz5a5+IIwMbOTk1Uo9RExvh4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BdArlfrgZ/kJ4SB3isO6I4XOZzNXP7H7zvKzsJK9b1W17SeNqaRIBNbSUUQLsdLZJ9zMEyL37DXqRPUni4tdTFfy8S+QVXaQQg59Hodp6JQsIbYjjm73qr2ZQaMcenaIrd10SBKoZV9JWga2Rlwts98ARWfSwiVPwqeCtew2saU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhhO6Hbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C8AC4CEC2;
	Thu,  3 Oct 2024 00:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727916039;
	bh=ubg2yzOpxd3KbR42Fu2Dz5a5+IIwMbOTk1Uo9RExvh4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bhhO6HbdYNICD4NL9SIRiKDXs/lTl3IAlHrPK1KaF4PBsKfphVhPKgF0FkA77Axjr
	 SMdrhc9z9KwTdy39Xz1eCcwhhl6IXSNx9a67XVt6QX3zTIFvtRneuaP2/lB9LoGRGz
	 6W5pOznGwOVCcy6mIcP1B0ASTkU/uVSzsVYHM95xc8JCdFBkczYVPjmgvQQ4ax7FtD
	 ufX4NMuQ8AhTe8OsNnQ9PlBw6EPjQul9YZL8sJ1dm8zursRnFDWxGdcEJOPgXHWREC
	 JX95Z4tLABxOkyYFrg8jAe8Hk/oBnRRslCm66bx8cKhwiEgE63/hypc6334IJ2qtwY
	 s4yq27v5KNBnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF08380DBD1;
	Thu,  3 Oct 2024 00:40:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: ethernet: ti: am65-cpsw: Fix forever loop in
 cleanup code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172791604250.1387504.10478445061671408891.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 00:40:42 +0000
References: <8e7960cc-415d-48d7-99ce-f623022ec7b5@stanley.mountain>
In-Reply-To: <8e7960cc-415d-48d7-99ce-f623022ec7b5@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: rogerq@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jpanis@baylibre.com,
 alexander.sverdlin@siemens.com, grygorii.strashko@ti.com, c-vankar@ti.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 28 Sep 2024 13:04:01 +0300 you wrote:
> This error handling has a typo.  It should i++ instead of i--.  In the
> original code the error handling will loop until it crashes.
> 
> Fixes: da70d184a8c3 ("net: ethernet: ti: am65-cpsw: Introduce multi queue Rx")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> 
> [...]

Here is the summary with links:
  - [v2,net] net: ethernet: ti: am65-cpsw: Fix forever loop in cleanup code
    https://git.kernel.org/netdev/net/c/3c97fe4f9fbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



