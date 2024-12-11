Return-Path: <netdev+bounces-150945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7059EC25A
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6EF168A05
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E95C1FCFF4;
	Wed, 11 Dec 2024 02:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s02pOBuC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8711FCFE7
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 02:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733884819; cv=none; b=SuwlwiRHlSLwuo5ZyDIWKUZv1Zz89+WUH1xBboTJQI8mff7xzU1f97yBmsq1ZK7MLb9MbMgVprJVCQO6dMD02RVIicBDq5USfy28EwKgeEu+/E+Elp1kZNu5iyeekWYZFTdYx2vzBOtUJYrkhnDlDVR5FdtAcTK/jEq3NlGBFvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733884819; c=relaxed/simple;
	bh=GQzRnyFMS/HTE6N87s+OyYGlEVdBvj8MPqwWwN+DIOY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BNUf31tE2LwOzxw7gr0RKrZJ2Q1WaHbBKofrKADaaJ2Sbb07inRJAcs00Z2d4FO1x/NCpFZV79FOJ70y63P/VceoFL+ac0+FllYJjVs5tnacodoyccfBI09b7GgyNJag3juBVzOyiIdztTCUI7kZAGbSJ8v2RsfZtCi5KG4Os0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s02pOBuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8D9C4CEDD;
	Wed, 11 Dec 2024 02:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733884817;
	bh=GQzRnyFMS/HTE6N87s+OyYGlEVdBvj8MPqwWwN+DIOY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s02pOBuC0R76rQuk3ycGbUJAENKsshJr6ngn7P6G27YXzIiEZdaxBFs2Qkuv8vggn
	 V6heVGiEwv1X47JxmB8FKIldbCyAxPMpl61x93Wok7Rg9/b3rK1Nvqav+z8B6OBD2J
	 I+v+q771yNUBUhF8mDCVpSnYE4a9ji+If6Up1ZyaaA+leSlwbjxrxxPiZorKsmT3Jv
	 l80DgZKlHVxZP7H6GEk8OczwNoOHsG1TUMQX3+7NV/UTk+V0+hNCWhtkWBTd5wGXE6
	 Lq/aI6FCAKN2qyo9DFJg6/+1rhy2iInNayfQPuR7wW1ZS78qPscHe3DnD5bY/3MsbM
	 m0r8psuSMby/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEAD4380A954;
	Wed, 11 Dec 2024 02:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnxt_en: Fix aggregation ID mask to prevent oops on 5760X
 chips
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173388483328.1093253.13542458074533723016.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 02:40:33 +0000
References: <20241209015448.1937766-1-michael.chan@broadcom.com>
In-Reply-To: <20241209015448.1937766-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
 damodharam.ammepalli@broadcom.com, kalesh-anakkur.purayil@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  8 Dec 2024 17:54:48 -0800 you wrote:
> The 5760X (P7) chip's HW GRO/LRO interface is very similar to that of
> the previous generation (5750X or P5).  However, the aggregation ID
> fields in the completion structures on P7 have been redefined from
> 16 bits to 12 bits.  The freed up 4 bits are redefined for part of the
> metadata such as the VLAN ID.  The aggregation ID mask was not modified
> when adding support for P7 chips.  Including the extra 4 bits for the
> aggregation ID can potentially cause the driver to store or fetch the
> packet header of GRO/LRO packets in the wrong TPA buffer.  It may hit
> the BUG() condition in __skb_pull() because the SKB contains no valid
> packet header:
> 
> [...]

Here is the summary with links:
  - [net] bnxt_en: Fix aggregation ID mask to prevent oops on 5760X chips
    https://git.kernel.org/netdev/net/c/24c6843b7393

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



