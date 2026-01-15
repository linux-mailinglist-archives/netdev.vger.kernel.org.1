Return-Path: <netdev+bounces-250064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B830D2382E
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2138F310799A
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F233358CA;
	Thu, 15 Jan 2026 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLM1TZbV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3473194C96;
	Thu, 15 Jan 2026 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469015; cv=none; b=qV50Z7O0ZrJoSDTK/22/3oaUZ+EubL3kL9r9roxK7ICNtw1iRZiQ0opPcUs3p8mMrmhCYmuA/BQKOn/Xe9ef1mD7vZpRhPW1egnxSD+B+hqHtEo52hoflMA62/vetlR51XPC3k9DIK88GSwSzceGv6yMhMYCY0KsQqCSzAoTlBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469015; c=relaxed/simple;
	bh=miltPV5ioscPhzK8fYXxRBZ8d9NkdZfloQ+E3Ux4pEE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l9YaykZph6SSpVLvZ9Bo8krE97oN7j6Yp3TspsGaGopkTn0qzn0lKqJNIu0LHYKllkSb+mAjLbY0/rXVlh9fJhXHJD7PTHS1NgrrxrVvqbfraCxOz/DOkNmfPh3Hcxl4RNxwErmk02pIaWoy3iIAvGraqTWh2SW7nVSeUSEWkrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLM1TZbV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D3EC116D0;
	Thu, 15 Jan 2026 09:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768469015;
	bh=miltPV5ioscPhzK8fYXxRBZ8d9NkdZfloQ+E3Ux4pEE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rLM1TZbVSio0vaB22gnHH9qmbRho1mD5hjCP2ZSiL1h6HpH4tc1xOtEOHf6OoNrUW
	 lIcFSrAgZc9kQjfVJ1bKE3WwkBd3cfc+8gB/W8UITZ2lhG6SwOOvt4wpYH8OPGazVB
	 23pzCCqF7SFAfIBFtVZLwXBBi076uak6dD6VTVoJsl2LTPXXeX/vPlVYSvgdh8KpF9
	 OVeSfuANgWu72doNvRBIsZtlIcXcSy8NhsmwZTCtoolfHDezNVGqSZ22k+OL2HQlqh
	 0TLdXTMKWABsN2lT5yUkkPsbYBFHnho1fXtrBBbkpkSnw089DasQh83+A+u4ztxDj8
	 cH67C40HkTnOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B9EA380A957;
	Thu, 15 Jan 2026 09:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2][next] virtio_net: Fix misalignment bug in struct
 virtnet_info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176846880805.3904091.8567285524155232438.git-patchwork-notify@kernel.org>
Date: Thu, 15 Jan 2026 09:20:08 +0000
References: <aWIItWq5dV9XTTCJ@kspp>
In-Reply-To: <aWIItWq5dV9XTTCJ@kspp>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 akihiko.odaki@daynix.com, horms@kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, kees@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 10 Jan 2026 17:07:17 +0900 you wrote:
> Use the new TRAILING_OVERLAP() helper to fix a misalignment bug
> along with the following warning:
> 
> drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> This helper creates a union between a flexible-array member (FAM)
> and a set of members that would otherwise follow it (in this case
> `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
> overlays the trailing members (rss_hash_key_data) onto the FAM
> (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
> The static_assert() ensures this alignment remains.
> 
> [...]

Here is the summary with links:
  - [v2,next] virtio_net: Fix misalignment bug in struct virtnet_info
    https://git.kernel.org/netdev/net/c/4156c3745f06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



