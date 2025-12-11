Return-Path: <netdev+bounces-244355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 098FDCB5650
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 10:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7F973014A34
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 09:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C731B2FB602;
	Thu, 11 Dec 2025 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvGQMGID"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D57A2F998D;
	Thu, 11 Dec 2025 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765446202; cv=none; b=bk3Epr/aEyFtBsrpMEE8rxx8tBI0dYG1XEVOLFsaNZXNeSxQKCPTmsQjOm3p0xpySkwu4b9FxHoUnvWaIcn22MCqTbuDLM3wrlJ+Np5t1oWvTv1hGL+3ZWTMhCcDufYmodB2LZBx0DmJqSVplDFCXfeCcC6SQed4k3Hc22xgKIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765446202; c=relaxed/simple;
	bh=QoXUSLb6pF12kg5hciMRtHaloEECSFceLd048LFulQM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PyiQHz7aUPzIcEx6IOM+DG3fafbnwQfQ936YMrxItRCv80FSVWC6A4cy6gZJ/Ut+9RH3hIY9cE3EkUOgieJU+eIxarcEJCp7udX1Ou6KPt5nWxO3aQEda7wonmXxNKrCmnlmWicOzU4yoICrse6VFAsIq0MkhfbuHWcU8aXA6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvGQMGID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB074C4CEF7;
	Thu, 11 Dec 2025 09:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765446201;
	bh=QoXUSLb6pF12kg5hciMRtHaloEECSFceLd048LFulQM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kvGQMGIDtcuZd9G+/xzRI8ijlR/uGiSUN/c2J27EdwuRAe3VB8he+V7UQEX5/aFfI
	 t1LXxvpWfOCqvZIRujWtl3npakUo2R9b6/2FuyCSzBLWGC5j3vdck0OHpwf0oYIXUo
	 97oylUkaZPL7EPnRXxmS2pXflmzYlW3WRXWusWsiBVkspG+ov1a3VxKeOE/FIlrfnf
	 KJ58aKY5LsLv8zBdkPNOZCTq7uaLOvYjkRQF4m4rrgjZr0KdGEKjoVF3fyJQJ7SbuQ
	 BpjekZrp8f2p41ex1TZy/FoeP0sThBjvTU+GaoES7ZlKUhLtgxKv3DyhDLb94SIZKh
	 CkHy8bMbfNtcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B9213809A35;
	Thu, 11 Dec 2025 09:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] nfc: pn533: Fix error code in
 pn533_acr122_poweron_rdr()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176544601478.1308621.1840268156177987089.git-patchwork-notify@kernel.org>
Date: Thu, 11 Dec 2025 09:40:14 +0000
References: <aTfIJ9tZPmeUF4W1@stanley.mountain>
In-Reply-To: <aTfIJ9tZPmeUF4W1@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, krzk@kernel.org, johan@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 9 Dec 2025 09:56:39 +0300 you wrote:
> Set the error code if "transferred != sizeof(cmd)" instead of
> returning success.
> 
> Fixes: dbafc28955fa ("NFC: pn533: don't send USB data off of the stack")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/nfc/pn533/usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net] nfc: pn533: Fix error code in pn533_acr122_poweron_rdr()
    https://git.kernel.org/netdev/net/c/885bebac9909

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



