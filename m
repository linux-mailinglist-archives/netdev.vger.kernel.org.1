Return-Path: <netdev+bounces-203762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189A0AF714A
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534B23A707E
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8522E498A;
	Thu,  3 Jul 2025 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNYbsUuo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E36F2E2F01;
	Thu,  3 Jul 2025 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751540384; cv=none; b=kXNjXARhkba4aOzvHReSnn7Azyq8evO7C8T4HHYX6RQbjQg5/kY8vaawpIEaRGf7mOS8+LsxJ5Y+GUznEgzI4nVmwjGMR6nEzyGvrCM1jhpAb3+dssawzfqKCr7NxOboDcGhubPuqNScSJpcrU9az+9zQiONl07zq7myyJhUFPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751540384; c=relaxed/simple;
	bh=viAFFh5apKZBGT0/pWg8v+occ9w7sD9MxZCsAtmyb/o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=usmyeLzPvRlKi1UpaFNgmcK3CtzMglzqPEPNd6sY08WjNtiKec39pMXo350cLAVoBjAaD4yadsI7mv5OqQBthKq9Dn4PpwzdeiNqk4UzaUkkp86qLt0PB8DWNp73jLGbf37oUuO2QGaJbrnyu/zaRMl3Y1ipl9AZPEpkh9NsCMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNYbsUuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFAAC4CEE3;
	Thu,  3 Jul 2025 10:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751540383;
	bh=viAFFh5apKZBGT0/pWg8v+occ9w7sD9MxZCsAtmyb/o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vNYbsUuoP4bm1+3pJAI17lzGLzQgufUiJH/Z1EdTCpkA6CBDwIUfJJWyUB6HEgKv3
	 2VmNda8KhIEWktdx++fMX8lEoFMBHux+UOsrtDoF3X1uGrZTp41jBLLsvzFEpRhIr6
	 pIr0OKJ48GhZox7kZdE8RLPDfpAsimNgEbjPBButAnO1JfsQJZiULVDvdUYdb4ZGEp
	 udqKiLZQGUUvSnsCVxpJLvComyJDw5+qQDQoAFj1Ksl8K2m4pfo1drPVgOn1K4IH4O
	 nRn3e6HpLjUUtDK16IbRiicjkhZCVUNx3xGVNrY2eBQYblLjqYG/ZtcN+gTJIE3IEM
	 bvIaPXamNzNqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E26383B273;
	Thu,  3 Jul 2025 11:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock/vmci: Clear the vmci transport packet properly
 when
 initializing it
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175154040774.1407041.3810230339956588724.git-patchwork-notify@kernel.org>
Date: Thu, 03 Jul 2025 11:00:07 +0000
References: <20250701122254.2397440-1-gregkh@linuxfoundation.org>
In-Reply-To: <20250701122254.2397440-1-gregkh@linuxfoundation.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 harshavardhana.sa@broadcom.com, bryan-bt.tan@broadcom.com,
 vishnu.dasa@broadcom.com, sgarzare@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 virtualization@lists.linux.dev, stable@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  1 Jul 2025 14:22:54 +0200 you wrote:
> From: HarshaVardhana S A <harshavardhana.sa@broadcom.com>
> 
> In vmci_transport_packet_init memset the vmci_transport_packet before
> populating the fields to avoid any uninitialised data being left in the
> structure.
> 
> Cc: Bryan Tan <bryan-bt.tan@broadcom.com>
> Cc: Vishnu Dasa <vishnu.dasa@broadcom.com>
> Cc: Broadcom internal kernel review list
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: virtualization@lists.linux.dev
> Cc: netdev@vger.kernel.org
> Cc: stable <stable@kernel.org>
> Signed-off-by: HarshaVardhana S A <harshavardhana.sa@broadcom.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> [...]

Here is the summary with links:
  - [net] vsock/vmci: Clear the vmci transport packet properly when initializing it
    https://git.kernel.org/netdev/net/c/223e2288f4b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



