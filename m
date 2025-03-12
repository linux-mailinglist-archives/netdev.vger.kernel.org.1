Return-Path: <netdev+bounces-174307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657B2A5E3AA
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 19:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A910F1769F7
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 18:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4BC1D5143;
	Wed, 12 Mar 2025 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bP5CN1K6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBC51386DA
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804198; cv=none; b=kOKBlidk1A5LgWxmfOMIq13u3ktMseK4Esty2p2BrK4kwiaYf2nUDXmuP9cUYJesIKsDSeFfNJXuBnevDUbpaitylnb3hTruIB1O/UIAFPs5K+Wg8TskIg5MlOY4Cz3KkNJ63uWFp6iTg6YWe5zh/FV/WzE1XJFc1YGvoR8vNI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804198; c=relaxed/simple;
	bh=uBRcUn+6XZvUrFDb6tSSoWkTZiy6+JE1P9dcmLw76c0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LdFtfIS4v0clVrlABZ3msQuae838iH9QBHHWRj02JeMIOu/WzeOtVOhm68If+bfx3vo9ZCEWY4/NKuKR4zaq6DCiaI4r5u29QSHLUC4E5OzTPe5yn7fwTpY8RSrvK9lLaBehQr6WumKBlUWEk+8QREGFVBVS/SCQdFiEkJ1TnoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bP5CN1K6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2BAC4CEDD;
	Wed, 12 Mar 2025 18:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741804198;
	bh=uBRcUn+6XZvUrFDb6tSSoWkTZiy6+JE1P9dcmLw76c0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bP5CN1K6KcY32o/naSVuHAsU9YzLyh/lRT6CdElHE/Ci6vRcArbafBZGrPLd7gmiY
	 hq3V3spkV3vaY6p6pl2I9ZkrUWUPOork18RiUCrFTWaYucFkVKu6DkkjA/2I+pt3zA
	 E1eavT6nzkvU0m+GMBJqp/lKjAkyZTnNL2UncRGG9qXaT5g03zRykrHpramt3mI64p
	 aI7BNkIYJzNQwvW5+fzzfId2R6LIRCh0R0wcfEunZap6xZ+3d+n6Rl2eztzhCQUwR5
	 kFOi/uP+WFfZxbgCZP4G4xNAe0DK4OkWlJxPpgCYGcDYJtJczgONTs4SjAjVvpCJnZ
	 xKbpPB1kqs4hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD3A380DBDF;
	Wed, 12 Mar 2025 18:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] tc: nat: Fix mask calculation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174180423251.890466.11023139141419811729.git-patchwork-notify@kernel.org>
Date: Wed, 12 Mar 2025 18:30:32 +0000
References: <20250306112520.188728-1-torben.nielsen@prevas.dk>
In-Reply-To: <20250306112520.188728-1-torben.nielsen@prevas.dk>
To: Torben Nielsen <t8927095@gmail.com>
Cc: netdev@vger.kernel.org, torben.nielsen@prevas.dk

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu,  6 Mar 2025 12:25:19 +0100 you wrote:
> In parse_nat_args the network mask is calculated as
> 
>         sel->mask = htonl(~0u << (32 - addr.bitlen));
> 
> According to  ISO/IEC 9899:TC3 6.5.7 Bitwise shift operators:
> The integer promotions are performed on each of the operands.
> The type of the result is that of the promoted left operand.
> If the value of the right operand is negative or is greater
> than or equal to the width of the promoted left operand,
> the behavior is undefined
> 
> [...]

Here is the summary with links:
  - [iproute2-next] tc: nat: Fix mask calculation
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=667817b4c349

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



