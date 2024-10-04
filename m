Return-Path: <netdev+bounces-131856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5651B98FBA6
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 02:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203A0282A5A
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23061D5AC9;
	Fri,  4 Oct 2024 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHVdF0MY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE711748D
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728002432; cv=none; b=etf78aji99+KK5mrs0KFZqjd0oxDf8F1eI6zJEQXjy9OOTdhw+lITI1TLwBNWxtEr9TKP/Oc9WxsgPQKXE3WYimEth2SbDPTa6+va18tui3UTRLguGvQvXMrKOwvfRTGsNxoxUnrl1MmqHY3O3P5jptmvCp61oRqFEq/0XMIoZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728002432; c=relaxed/simple;
	bh=E6jPJVue1SnkDZ+LMvjW0uI5pWsm0zsOhY3/NK23Grc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AHxvTThSebs3bZGc8jgiHDjNDd2n52nlNFyVkZIrp/1iA/cyY/aGzhK+ey+LFfZq8+aYRC4dXP72RCfOdpPdGXydsbEnQdpZRYOSG3ZJFDWurDeJLPV/GEZKVCGaocIPpHH6ibtSm7mrv3fgvpnDl3CjcSSiyVLjJUjIGdIJI4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHVdF0MY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6E8C4CEC5;
	Fri,  4 Oct 2024 00:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728002432;
	bh=E6jPJVue1SnkDZ+LMvjW0uI5pWsm0zsOhY3/NK23Grc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CHVdF0MYrT+utZjH1RFXLslIYI3FAfrhj60urf+4TTJpUuRaB42bB+uF5CRDI+oOw
	 G1aTjDfWAI3QXyjZ33XA3+Nzkj/5jkPgIqkJTP6A0CzoEOlGgflwPt79dWc8hIKvPA
	 l4wDCjGJKkGMEmNE52GtzxtXKPsI9TlmpUKpm4LBFRSE/Uk1opW7tR78ZyocnO6edb
	 JS/c+GpcxDD4WfjAnxYAIN4j3tyb1q5U0FtHFFqD2pRLCZo8MjZ4PL+6o/CUeGxFt1
	 5ZaUaia+mgjIsnBH9Kc3Xly7iOIjZifglZPJuU+CIppCHyuy/6yujd58nN/VuvbjbI
	 814X+x2k4sY8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBDB73803263;
	Fri,  4 Oct 2024 00:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] ibmvnic: Add stat for tx direct vs tx batched
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172800243574.2046214.4717626173748399581.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 00:40:35 +0000
References: <20241001163531.1803152-1-nnac123@linux.ibm.com>
In-Reply-To: <20241001163531.1803152-1-nnac123@linux.ibm.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, haren@linux.ibm.com,
 ricklind@us.ibm.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Oct 2024 11:35:31 -0500 you wrote:
> Allow tracking of packets sent with send_subcrq direct vs
> indirect. `ethtool -S <dev>` will now provide a counter
> of the number of uses of each xmit method. This metric will
> be useful in performance debugging.
> 
> Signed-off-by: Nick Child <nnac123@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] ibmvnic: Add stat for tx direct vs tx batched
    https://git.kernel.org/netdev/net-next/c/2ee73c54a615

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



