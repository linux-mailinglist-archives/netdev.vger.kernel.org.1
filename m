Return-Path: <netdev+bounces-147694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C709DB3C9
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 09:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18061B21DA8
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 08:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9B71863F;
	Thu, 28 Nov 2024 08:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faLI2SAi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FD114D444;
	Thu, 28 Nov 2024 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732782625; cv=none; b=sml8uasC1Vj3m49S+H6HIwtcpG/pMh8Xm1fBveAPwFeS1knESTGpiKTgIwxEBksy1wJmJxa1zDnNuhAQ2SP3rMEn5K05WyuJXosZ5aT6E/2ruJ8YjuWBpPlv5H2lDqeNLJpw35rULJmftR6kb8NgQgrL79fz0JXPDDdwfUkW0Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732782625; c=relaxed/simple;
	bh=lYHIOOwiF7f3M5lLVCg/Eezwmpgxe/E2SKHfTvuyCms=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gIuYtKslySGdrg3XwUwdG5I1B4ysijVo4sXHZLK86lYWYol/+iCOEFpfD9LtC6Kq129xIump+A90twfd824bo53Q6znh/v38hSPmpf4hiACTiEbAAvGADDkAXnez9vx76kOScSdic0vZetkuHJl/slZ54GDu/EEhw/EFi459ihk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faLI2SAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4DDC4CECE;
	Thu, 28 Nov 2024 08:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732782624;
	bh=lYHIOOwiF7f3M5lLVCg/Eezwmpgxe/E2SKHfTvuyCms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=faLI2SAi0L2b3mJLg1///IH1kqKMOs2SN79bIdNhxSFBomcnj/xh03/NlsFoqYPyO
	 80CQPYKffaOvEx5hDYGjJ+u01bDS6s4tb0ZTtK2SrANrKW3Vfp+ycRvs7Z5Ty9fEz8
	 Nx/nSzf/ox4k4PSI96L07cCFWGUDz0BeB28LiqRRRENc6hT+nEI7zMt+PmvRmXLh+K
	 ckDZxgh9eX6LY+AKYm4KxdoP8xSld3FXsMdncPHNGIZdk5PDsPJREwpifrQH+nMTpU
	 aVGjySarwDxfx4YhT8PK5x4NKWQV3WZVGqzXXcLzXZTcke/N1F/pnt6RIEn7klou26
	 xCySHHQYAHXzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE18380A944;
	Thu, 28 Nov 2024 08:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/4] net: Fix some callers of copy_from_sockptr()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173278263749.1659134.13660124936844391608.git-patchwork-notify@kernel.org>
Date: Thu, 28 Nov 2024 08:30:37 +0000
References: <20241119-sockptr-copy-fixes-v3-0-d752cac4be8e@rbox.co>
In-Reply-To: <20241119-sockptr-copy-fixes-v3-0-d752cac4be8e@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, dhowells@redhat.com, marc.dionne@auristor.com,
 luiz.von.dentz@intel.com, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-afs@lists.infradead.org, kuba@kernel.org,
 dw@davidwei.uk

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 19 Nov 2024 14:31:39 +0100 you wrote:
> Some callers misinterpret copy_from_sockptr()'s return value. The function
> follows copy_from_user(), i.e. returns 0 for success, or the number of
> bytes not copied on error. Simply returning the result in a non-zero case
> isn't usually what was intended.
> 
> Compile tested with CONFIG_LLC, CONFIG_AF_RXRPC, CONFIG_BT enabled.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/4] Bluetooth: Improve setsockopt() handling of malformed user input
    (no matching commit)
  - [net,v3,2/4] llc: Improve setsockopt() handling of malformed user input
    https://git.kernel.org/netdev/net/c/1465036b10be
  - [net,v3,3/4] rxrpc: Improve setsockopt() handling of malformed user input
    https://git.kernel.org/netdev/net/c/020200566470
  - [net,v3,4/4] net: Comment copy_from_sockptr() explaining its behaviour
    https://git.kernel.org/netdev/net/c/49b2b973325a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



