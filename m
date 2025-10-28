Return-Path: <netdev+bounces-233338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8253EC12214
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D508188967A
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 00:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4FF2E54DE;
	Tue, 28 Oct 2025 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWx+ozt2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843601F03D8;
	Tue, 28 Oct 2025 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761609629; cv=none; b=NovwuoALlMpeGi3HBIuMLJiRuJpaVv7xsMCWGwq5fX7HS0nJjrKlP5rNXO34nvnPbo+dZwYmNeBteC87RFFXTn7WfXFWq6wuVC33FvN3BvR669sIxn823d4C0GfK37051t8/fQkecmrarTBnCaO7ObzG9ztRox1YeBZGE5hg6Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761609629; c=relaxed/simple;
	bh=8QEHxqiCiHnv97GZbWVC3DhbUw4ic7IzKq2+yDsrino=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OPPpCx59mn/c1WRFHGcVYxpBON4QdY+ylyakO3yTWkVh9ihFjToPp0KrDeMa7jG+/odtqgjjouAbIm2bodm0fnCkmVBOSEuom43ILnaCv9y12WV0TPkRAJ3ZD54QxqVKk1IVa53Pa64SyTKnoGiI9PcQ5FAaFCrZ+Oj785HzOY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWx+ozt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006A8C113D0;
	Tue, 28 Oct 2025 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761609629;
	bh=8QEHxqiCiHnv97GZbWVC3DhbUw4ic7IzKq2+yDsrino=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fWx+ozt2MueGSOYa52nBiPGm5vhsm0ro9R6kX19Zow/0QfBzOaUGgZE4s50EfUmwb
	 XNzP0VCI47OJ+wdCOP9Pj81U26eFd6u2LXU4n9jSoQQXeiLMn3fJv2PxxAEoIr+efB
	 OumSivXr6zZaM3zoxqDEP+lsZLtmC4DmUSL1Dqvsir4VfrkhwzwKSo0/5Dy/+Hvt2i
	 hu/05pG1LvZHc+nBNKQT3mtGrzyX7LIDNn7Qf/K0BJuLZSEawisA36aH3yeP+UiOgz
	 QU1UMCwnRvNXpIrSjZSbkOX73hD4VkXEEMBtjfYxJrywLcUoAN2U+bgnRqey8hWmvH
	 EGLaKhy6dedjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD1839D0C95;
	Tue, 28 Oct 2025 00:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tools: ynl: fix string attribute length to include
 null
 terminator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176160960676.1627277.6717105101420126529.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 00:00:06 +0000
References: <20251024132438.351290-1-poros@redhat.com>
In-Reply-To: <20251024132438.351290-1-poros@redhat.com>
To: Petr Oros <poros@redhat.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 jacob.e.keller@intel.com, ast@fiberby.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ivecera@redhat.com, mschmidt@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Oct 2025 15:24:38 +0200 you wrote:
> The ynl_attr_put_str() function was not including the null terminator
> in the attribute length calculation. This caused kernel to reject
> CTRL_CMD_GETFAMILY requests with EINVAL:
> "Attribute failed policy validation".
> 
> For a 4-character family name like "dpll":
> - Sent: nla_len=8 (4 byte header + 4 byte string without null)
> - Expected: nla_len=9 (4 byte header + 5 byte string with null)
> 
> [...]

Here is the summary with links:
  - [net] tools: ynl: fix string attribute length to include null terminator
    https://git.kernel.org/netdev/net/c/65f9c4c58889

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



