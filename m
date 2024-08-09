Return-Path: <netdev+bounces-117195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A72A994D0BD
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 15:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C08E1F21693
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019FA1E86F;
	Fri,  9 Aug 2024 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dviP5eN6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4CD17BBF;
	Fri,  9 Aug 2024 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723208441; cv=none; b=RP2vEw2nYF33jx4oy00tU6U/RKacgKbiSRKQThv+ShP2Nn6sHGXLdibaQePnTSa+LGf+woiPCxpTfKfBui37kECNvjSQ1G9Ye5kGf3e563gACS2822nqDVTssf+wsbGUQN3v4UKl2w+sn5hZPgYnLbPdzkd9JNQ6QlMMXIqJm84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723208441; c=relaxed/simple;
	bh=21VXCce4FRAD2HtdIALdsNGQGA+8k5cDrPR7TjMlA94=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GDC4WPEI6J0SKwA0si39RMvMDNJjxf0M5r2kb7Imotj8t7s6TsfvPIr9kFOxhgIxPhPhLxOPLT5/3vgUPDzDU3e04yDPp2+EuPVZtW05t1md5VHy4JOqLpXzWBrakVwDPeIkgPJPiNDLlUahWSweYwTT5cOXFUfvMcqXRlYNAKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dviP5eN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D957C32782;
	Fri,  9 Aug 2024 13:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723208441;
	bh=21VXCce4FRAD2HtdIALdsNGQGA+8k5cDrPR7TjMlA94=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dviP5eN699ugLTjmIE0ZjJ9dyMQchKlK5TW2rxvPnnmW4c/7Yz9RT9paPU9b4KK4u
	 wMq15niT073Zan6buPaTlXKkL9RLE4/p+fzapGKXlOQr93Ht3CKDbWmkGSxGHB01Mi
	 hl+X/WmJCkv4xXXXMQ6PK53e4MNoQK0ZpjF3JcXMYlf9aXAyZqnaJTBYOdQoK+UfDR
	 L1biV78RARx8IdkwHn9gapMpU5O8TsDxa+s1YUHqrXT3r+3aZQnfLM+I1DGRIibe5J
	 r4/cxd8tpJEMhINIJmKCbO2aOhlo7ldB8ODGZONHO3hGlZbKjIP4lrtmcoY/Jjqn8e
	 J/szlDEAssMvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71594382333D;
	Fri,  9 Aug 2024 13:00:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/5] usbnet: ipheth: race between ipheth_close and
 error handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172320844026.3782387.2037318141249570355.git-patchwork-notify@kernel.org>
Date: Fri, 09 Aug 2024 13:00:40 +0000
References: <20240806172809.675044-1-forst@pen.gy>
In-Reply-To: <20240806172809.675044-1-forst@pen.gy>
To: Foster Snowhill <forst@pen.gy>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, gvalkov@gmail.com, oneukum@suse.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  6 Aug 2024 19:28:05 +0200 you wrote:
> From: Oliver Neukum <oneukum@suse.com>
> 
> ipheth_sndbulk_callback() can submit carrier_work
> as a part of its error handling. That means that
> the driver must make sure that the work is cancelled
> after it has made sure that no more URB can terminate
> with an error condition.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] usbnet: ipheth: race between ipheth_close and error handling
    https://git.kernel.org/netdev/net/c/e5876b088ba0
  - [net-next,2/5] usbnet: ipheth: remove extraneous rx URB length check
    https://git.kernel.org/netdev/net/c/655b46d7a39a
  - [net-next,3/5] usbnet: ipheth: drop RX URBs with no payload
    https://git.kernel.org/netdev/net/c/94d7eeb6c0ef
  - [net-next,4/5] usbnet: ipheth: do not stop RX on failing RX callback
    https://git.kernel.org/netdev/net/c/74efed51e0a4
  - [net-next,5/5] usbnet: ipheth: fix carrier detection in modes 1 and 4
    https://git.kernel.org/netdev/net/c/67927a1b255d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



