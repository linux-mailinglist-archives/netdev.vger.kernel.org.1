Return-Path: <netdev+bounces-202474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492A8AEE0B9
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5D5163811
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA9028C2AA;
	Mon, 30 Jun 2025 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxL45HdI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5006218FDBE;
	Mon, 30 Jun 2025 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293785; cv=none; b=bo54EqEA2S6SHg0lwBrqveQ2rDt5hwnP+NI448Qt5HcnQyoLAGm7dEAaD3RzXym8b+IVJCy+S6CctwZYpiduEtNTUPfCXkSxejLiHWNTv9chr1q9rGRdLMePsQ7YWeXsgcLnV1gT8WLYvy1MoNoRvXt4k+tRVXAH5WIlEt+dOb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293785; c=relaxed/simple;
	bh=LiBFZaqfXZuYTsBTBH2ULjzAIDtzQXyKkx6tEetHjqc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rY281NL/35GLUt8JF5xKF66WbPDE2wm0akMTaRpE03smRV8HBriMhI5t+WxGo+oGo8J4QJvhrIKBPT3pMLbTbvMInFM6dzPjjGt0/LcjC9blIXiGhssiILaNhIVwu/I3XTP9dvrFR2zycEApM+jikbGBQrADm6OmIxiU5/lPgWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxL45HdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CC9C4CEE3;
	Mon, 30 Jun 2025 14:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751293784;
	bh=LiBFZaqfXZuYTsBTBH2ULjzAIDtzQXyKkx6tEetHjqc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GxL45HdI06gzqzqj9bgi9Fpxw8BzrDahNjX21wsZhgdUDZha7Or1gVTUbnXH3rTGM
	 IdQRIpDaMKoAqyw5XWB9E8mcZSxBh+na9kONK5PLWEPZIbeGdF0zaEDCEdAZ26l04U
	 9b26A8xFFbF9JSUIv020653bGXD/CMzcXAk3FGu/hzh6QBUo91DnZaNxr4MEmGO1sn
	 UEaMw1eAyYRF9/ZiX7l4MloWEM+iHK9+U7TFgwT4QhNDWwrfRr1l6buko8EvC/Ty4+
	 gSfiOSruclMXrYKrl+re/WJ01H6VqmjxDfFXeiMX5DeLjP6Vkaa1a1XGgxIwobSZM8
	 KrGBnnWUjeLTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FA5383BA00;
	Mon, 30 Jun 2025 14:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: HCI: fix disabling of adv instance before
 updating
 params
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175129380974.3403730.2401095205165807740.git-patchwork-notify@kernel.org>
Date: Mon, 30 Jun 2025 14:30:09 +0000
References: <20250630075848.14857-1-ceggers@arri.de>
In-Reply-To: <20250630075848.14857-1-ceggers@arri.de>
To: Christian Eggers <ceggers@arri.de>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 30 Jun 2025 09:58:48 +0200 you wrote:
> struct adv_info::pending doesn't tell whether advertising is currently
> enabled. This is already checked in hci_disable_ext_adv_instance_sync().
> 
> Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
>  net/bluetooth/hci_sync.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - Bluetooth: HCI: fix disabling of adv instance before updating params
    https://git.kernel.org/bluetooth/bluetooth-next/c/2a0ae2f6cd36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



