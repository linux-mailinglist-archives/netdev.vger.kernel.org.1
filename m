Return-Path: <netdev+bounces-215458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90585B2EB4E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1AD1C840B7
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD69248F69;
	Thu, 21 Aug 2025 02:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQmXLvN1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735862472B5;
	Thu, 21 Aug 2025 02:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744002; cv=none; b=ROiWi60AfsAi1YMBVJlRbPDgFJOF5n2SNpsnRRQ9BD0VSJWIH79Es+GcTxzxo3Mj4YZZUOgQl8XpAynZN89hwpsjJdQSBcw/Ingouvl8jgiTop1yaKhJpMCdXTxwF7eg25ijgyUemgCrfH1zyIPfiUHsadJswbMHLvkUJl8IAVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744002; c=relaxed/simple;
	bh=jtFF41xAXOmsDRLxg99x7y8vSjMZRDwD2+YbN9LmkT0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T/C+vewxiUumGhWhC2IZ2wDTU3gv/4rxbAXyw3MF3J9gmWV1iNG0AEJDsqM38RBzzTCGYrf1dtkoUm9tz7H69/s0xb963fC9GEw28V6LqzRmb2MztaN//E2f+cXvDR/k9gz3lkKoyT5XPKxe69Cf4uPqViHCj6AVWGr8tEkwuPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQmXLvN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8FCC4CEE7;
	Thu, 21 Aug 2025 02:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755744002;
	bh=jtFF41xAXOmsDRLxg99x7y8vSjMZRDwD2+YbN9LmkT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OQmXLvN1Tf7BmnUKIVH3YwqyZynV6otnUEyxEpQJO9hdiDd1+Y79hGa7zAVoyF7qc
	 9ipvFi86G5Ujmid+zmxi8av1/MpTFlcsl3UwmuVIatKcDvftP3hjmLfcZwkNDVr6L/
	 goEElkP+x63WxB0YXGJ4yUn1M8OvmhaTWqHhWUtKpQAox8Os9myYel2IH6eyI0/PFw
	 Djp1ZZA0YYYibHrmaJVIlhy8ZeikRHJnoIL7ChZIfHny5xRt0wFgLemZ1n4hL6EPEC
	 rstxA6oVs+Z00rTyT5ckUXuseM90ftuXvtmtwmubXrlQj8CIYBfV/qqTAwgITLTddV
	 0/QkgGxUrYD+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFD0383BF4E;
	Thu, 21 Aug 2025 02:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net, hsr: reject HSR frame if skb can't hold tag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175574401150.482952.15665339291483545385.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 02:40:11 +0000
References: <20250819082842.94378-1-acsjakub@amazon.de>
In-Reply-To: <20250819082842.94378-1-acsjakub@amazon.de>
To: Jakub Acs <acsjakub@amazon.de>
Cc: netdev@vger.kernel.org, aws-security@amazon.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, security@kernel.org, stable@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 Aug 2025 08:28:42 +0000 you wrote:
> Receiving HSR frame with insufficient space to hold HSR tag in the skb
> can result in a crash (kernel BUG):
> 
> [   45.390915] skbuff: skb_under_panic: text:ffffffff86f32cac len:26 put:14 head:ffff888042418000 data:ffff888042417ff4 tail:0xe end:0x180 dev:bridge_slave_1
> [   45.392559] ------------[ cut here ]------------
> [   45.392912] kernel BUG at net/core/skbuff.c:211!
> [   45.393276] Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> [   45.393809] CPU: 1 UID: 0 PID: 2496 Comm: reproducer Not tainted 6.15.0 #12 PREEMPT(undef)
> [   45.394433] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   45.395273] RIP: 0010:skb_panic+0x15b/0x1d0
> 
> [...]

Here is the summary with links:
  - net, hsr: reject HSR frame if skb can't hold tag
    https://git.kernel.org/netdev/net/c/7af76e9d18a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



