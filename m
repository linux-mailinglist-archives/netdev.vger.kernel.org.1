Return-Path: <netdev+bounces-147130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7451E9D79A0
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 02:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38DEB281DA1
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 01:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E44B81732;
	Mon, 25 Nov 2024 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMG9Gbwg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7EA762E0;
	Mon, 25 Nov 2024 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732496422; cv=none; b=i2Jpo6USND5B43hnOnlO/HvcAHKI4+Hr/MiUwGZteQYjuA8EM9RJmyHJkmdEwztMqZe5+d4DUqnJGxCGFNZhU7WFHZjv+Eff3w0acjH1ZNHyZjZANLa9vXEFOlK1QRkDEMZEB6LyoRJuLLLeTE/l1KZTD8Q9KErO0DyfUg5a62g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732496422; c=relaxed/simple;
	bh=xJtyI+DnX8Inf25/pfeNNPqn4+XYVC765q5L3z9rMxs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aMtqYfqEnibgHK7fu8pAF/Pmb/SxlJ0gQrXwIrc6K35x/X2abvwcO7RbFDWvo+HTxuJEcWRi0BxVhS4gkFv4cJg7uJlWHJNODNxYWTezDVjNI64M6VaFJZxv+JB8RRdDqRUl7JuZKD8FiuqofDl3SaSZ6cSK1HD7jd3Abd26rVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMG9Gbwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C234C4CED8;
	Mon, 25 Nov 2024 01:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732496420;
	bh=xJtyI+DnX8Inf25/pfeNNPqn4+XYVC765q5L3z9rMxs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fMG9GbwghN5LOxCrxZg4qLund6+0NFnJID+yAW1bwLixJ+NfeoNuyDJ+m7CbflV15
	 LOa6lGpOw3d2dDqLAJ0K7LnF0d74ivdqxhPB7S6xyRgmNyVaIVkxqsVF7/53EyatF8
	 ab/VsTNlw/j8BpMp6GgLDmNKYDoEVb5V/kz0djHvdEOfONVChFjDkrh3KNz8C19V40
	 JNyFQWQynXyRl+CQkceHYi0x3jsSgFeslZWhdSKd8I0XulENIZyLGvaevn/SDmSzrL
	 PCW3fZ/DTy4oCKg4Pre9jj/LzboSi60uMa1NxLqv7+dTvZGMjz7/c5MNV40cguvljw
	 7HcSPjL1Wa5og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD973809A00;
	Mon, 25 Nov 2024 01:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 1/1] net: usb: lan78xx: Fix refcounting and autosuspend
 on invalid WoL configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173249643252.3410476.17299621375719038969.git-patchwork-notify@kernel.org>
Date: Mon, 25 Nov 2024 01:00:32 +0000
References: <20241118140351.2398166-1-o.rempel@pengutronix.de>
In-Reply-To: <20241118140351.2398166-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, woojung.huh@microchip.com, andrew+netdev@lunn.ch,
 f.fainelli@gmail.com, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com, phil@raspberrypi.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 Nov 2024 15:03:51 +0100 you wrote:
> Validate Wake-on-LAN (WoL) options in `lan78xx_set_wol` before calling
> `usb_autopm_get_interface`. This prevents USB autopm refcounting issues
> and ensures the adapter can properly enter autosuspend when invalid WoL
> options are provided.
> 
> Fixes: eb9ad088f966 ("lan78xx: Check for supported Wake-on-LAN modes")
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net,v1,1/1] net: usb: lan78xx: Fix refcounting and autosuspend on invalid WoL configuration
    https://git.kernel.org/netdev/net/c/e863ff806f72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



