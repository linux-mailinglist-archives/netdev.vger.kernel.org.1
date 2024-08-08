Return-Path: <netdev+bounces-116875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D5A94BEA8
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFF70B20E45
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AE418DF7A;
	Thu,  8 Aug 2024 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="je0hpw8h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B56A18A958
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723124476; cv=none; b=Xfe+n/7qd0rnlRXIPFtF20mkoZwEOehpY/C97h9zclOJX6MUCGdpPpEE9++RPnwzXlcaxTHvyiSubxTtDMVqoTEJvsmcqR7sm/hxUVzkjy6S/P1EYQsRt4cqxLw4Pq6zQsXwXQr6gaZn2BFpAeEKow9guZyxbQMJKSMykKrjW1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723124476; c=relaxed/simple;
	bh=jjchqss2SFXhlE4HCQsuC/0jD1qlA7c5B0iranSCJqg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sk4A41XvMa3xWMDzoOVsg5cTLaz6NF7SpC8f2GdqYYDPhhjIWs7Y100N2BgMWGreVpPfmmo1Z2FZ8HfdkclnPPdFKGfh5U9QkmOY+Dn97KryIZ0nZ7wXPUYA4OvSKFaC2s65v247K6vSwhGoQ0xJbAqQA2DM8YxS7IQDTIIZFHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=je0hpw8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30767C32782;
	Thu,  8 Aug 2024 13:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723124476;
	bh=jjchqss2SFXhlE4HCQsuC/0jD1qlA7c5B0iranSCJqg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=je0hpw8hKmNSf1k/N1LmYyOejkkZz3czC7R6b44y6hhNMpBtSDqym/xenzQDw+50L
	 SotXCgpkmxTf0C5N1IDeW10vULb8H74YNBn5iQhFeessIV3Sjwv+9I42Ng+X+j00In
	 KPUtd9qPLYXkDOn79JMzzWX+wxdcqqhpxYslj29fHMwjAukNdnT8VsfyF4ULeUzBUb
	 aHmyN+9y8zA0taouS4oVLn2uXe+AjabhovwdqIKOEYlkJ5lkS3J2/UUtYHtkV05lY2
	 sH6hjAY/5x5FJaQhQ2o81TPY5qH3HnOr6wGczZZNWs/e8fKaYy34gTxn6jm0FGw2hD
	 63UpuZy0ro1+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34BD8382336A;
	Thu,  8 Aug 2024 13:41:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 ethtool] qsfp: Better handling of Page 03h netlink read
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172312447466.3185699.11856007398398183094.git-patchwork-notify@kernel.org>
Date: Thu, 08 Aug 2024 13:41:14 +0000
References: <0d2504d1-e150-40bf-8e30-bf6414d42b60@ans.pl>
In-Reply-To: <0d2504d1-e150-40bf-8e30-bf6414d42b60@ans.pl>
To: =?utf-8?q?Krzysztof_Ol=C4=99dzki_=3Cole=40ans=2Epl=3E?=@codeaurora.org
Cc: idosch@nvidia.com, andrew@lunn.ch, mkubecek@suse.cz, moshe@nvidia.com,
 netdev@vger.kernel.org, tariqt@nvidia.com, git@dan.merillat.org

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Tue, 30 Jul 2024 17:49:33 -0700 you wrote:
> When dumping the EEPROM contents of a QSFP transceiver module, ethtool
> will only ask the kernel to retrieve Upper Page 03h if the module
> advertised it as supported.
> 
> However, some kernel drivers like mlx4 are currently unable to provide
> the page, resulting in the kernel returning an error. Since Upper Page
> 03h is optional, do not treat the error as fatal. Instead, print an
> error message and allow ethtool to continue and parse / print the
> contents of the other pages.
> 
> [...]

Here is the summary with links:
  - [v2,ethtool] qsfp: Better handling of Page 03h netlink read failure
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=e1a65d47551f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



