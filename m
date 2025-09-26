Return-Path: <netdev+bounces-226817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6C5BA55B1
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 00:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64FC38416B
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 22:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D48D2BE048;
	Fri, 26 Sep 2025 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL251epk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15DC2BE020;
	Fri, 26 Sep 2025 22:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926418; cv=none; b=CgckkxPK8MxfOHiZc6JNVZtrZB0eLvc3BA2475Dmb208gKNN46meTwDcLMGnz+Sqp4BydCSdvIrY0/2ShGPK3gSX5f+cCVvC7aaxBOvlcb1eqnzfAiAsZgyFF8mS046kBiO0CwRBLXXqtqe507Zi6EaBLB2KjO2mvCRhZaqIw0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926418; c=relaxed/simple;
	bh=nwyPuUt5g5WjvIkRMJrnAzdGhpP04k7ZC/H0qRKgz9I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BtJ8nNrB98yORF0xX52d4IlNflAmRPDndR67hIzqLBnP0BEXiKCv29+V1832dOIvc/GpxUU4YwHDeYDj0C0SYwQ9txbEChkCfiSwkjE1TeElTSVRDLshF4D2xLZxnzRW7IuopLB1QVVZlYqvSO8jGPosOp+RysKen7n8Y4lxpaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL251epk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D4DC4CEF4;
	Fri, 26 Sep 2025 22:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758926418;
	bh=nwyPuUt5g5WjvIkRMJrnAzdGhpP04k7ZC/H0qRKgz9I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eL251epkjnJmOikRKSPjGI7dNazqVDaDvR3XwXYHovH+IvXLUK5VsU/QCrxIC8hif
	 3v1RK/dmk9LII7ymQk2LMWPQQacCBEoDSdKP53deOGseb2LcELCG2KhnO7/PxXwpz6
	 YQ1aXgTKb4NSMmqQftkzZz/1LsCIj6tDJcG/n/sBK53UTQ34deWWHMS53nOozpcwgR
	 7SrKpIHgYHTr4Mm0Qqtcn+PNi70Z05pet4E3FWBP9d+mIKhmI1mYb0efpoxpL9Z7vY
	 sH6svXgElMcJ110bgl0PYl3pLFEEQO8XQns3KyMuaN2oXrGhCzGuE6V/kb5ojpfDt6
	 KHPSzU0WhXZSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB20239D0C3F;
	Fri, 26 Sep 2025 22:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] dpll: zl3073x: Fix double free in
 zl3073x_devlink_flash_update()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175892641374.83117.12589904543957170406.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 22:40:13 +0000
References: <aNVDbcIQq4RmU_fl@stanley.mountain>
In-Reply-To: <aNVDbcIQq4RmU_fl@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: ivecera@redhat.com, Prathosh.Satish@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 przemyslaw.kitszel@intel.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Sep 2025 16:28:13 +0300 you wrote:
> The zl3073x_devlink_flash_prepare() function calls zl3073x_fw_free() and
> the caller, zl3073x_devlink_flash_update(), also calls that same free
> function so it leads to a double free.  Delete the extra free.
> 
> Fixes: a1e891fe4ae8 ("dpll: zl3073x: Implement devlink flash callback")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Ivan Vecera <ivecera@redhat.com>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] dpll: zl3073x: Fix double free in zl3073x_devlink_flash_update()
    https://git.kernel.org/netdev/net-next/c/347afa390427

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



