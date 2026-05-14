Return-Path: <netdev+bounces-287927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KiEAPOpBWrtZQIAu9opvQ
	(envelope-from <netdev+bounces-287927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:54:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15024540A5B
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7633B3090A49
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75F93B7B71;
	Thu, 14 May 2026 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGJ4ecdu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B2C3B7751;
	Thu, 14 May 2026 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755875; cv=none; b=MuHbnl75ttKxf3Er2ypRafnVzrUomOXv6C4fBAsYls7sZS6xqNM+yvQVRtFNjTBZBS7MsCNa/v+1zZ9mhDj2qxkkbrt9+CF2sOZu5rPXqR13maxIO1yT4jsApybe6uKFEGCoXTDzbjRjujBt7e3ZOYuzlDL27O4UVn5oMjJ0Sio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755875; c=relaxed/simple;
	bh=+x1FRlnUcjwLyuK/yNOv8UDz22Nry8z9aIdJLqVZYo0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BOQtynBR18jCa2D9ESWfQDp+c9PGdBrh8PhXZUQh76RwF5EgEeMo3yh+7B0JaJPqH8oUpg3WcJQmkLbv9rGEEson8ZTZOE925BK0eaJz4OOelJH8Zhtf0kNDf/b6kbPczSJbmYB7EeEkDYJWvH+yAxUImUIW3423mkGLBpbVAy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGJ4ecdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C91C2BCB3;
	Thu, 14 May 2026 10:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778755875;
	bh=+x1FRlnUcjwLyuK/yNOv8UDz22Nry8z9aIdJLqVZYo0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kGJ4ecduY8vJjzxH6LkR7RPATN4q0A6GnZF+02NGBB5bL0Ualu1XTcVDkZ0wntwPZ
	 rkN/JF+QsL56ZzcR6terJ8XARzTH/04af5LPSAuTI4sQKekDKLqQUsmnjZ7aH5K8Tx
	 NGF0AIIP65XGB9ZFZYI0dZ16DilY0aI5/1RNR9DeEMzHn0vqEUPfEtlkKSqD1N2pRk
	 jeTXbMpYIzoVc4U+JSfYSVc6bju6B6MgMp5d7OvlgjRZYJ0fIcNgnNocqsk/cFpcZ7
	 RIf9TOZEjYPaH22bY6kj7GtoHatq2BOJgVTRtg0AtDPqzqdfBkVeP/bF6v9X/XXFJH
	 xitRUwyVu9Xtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDB23931095;
	Thu, 14 May 2026 10:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] bridge: Add selective forwarding of
 gratuitous neighbor announcements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177875582014.4067480.7391428922035544724.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 10:50:20 +0000
References: <20260511065936.4173106-1-danieller@nvidia.com>
In-Reply-To: <20260511065936.4173106-1-danieller@nvidia.com>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, razor@blackwall.org, idosch@nvidia.com,
 andrew+netdev@lunn.ch, shuah@kernel.org, ast@fiberby.net,
 liuhangbin@gmail.com, daniel@iogearbox.net, aroulin@nvidia.com,
 fmaurer@redhat.com, sdf.kernel@gmail.com, sd@queasysnail.net,
 kees@kernel.org, nickgarlis@gmail.com, amorenoz@redhat.com,
 alasdair@mcwilliam.dev, johannes.wiesboeck@aisec.fraunhofer.de,
 petrm@nvidia.com, linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org
X-Rspamd-Queue-Id: 15024540A5B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287927-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,blackwall.org,nvidia.com,lunn.ch,fiberby.net,iogearbox.net,queasysnail.net,mcwilliam.dev,aisec.fraunhofer.de,lists.linux.dev];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 11 May 2026 09:59:30 +0300 you wrote:
> The existing neighbor suppression unconditionally suppresses gratuitous
> ARPs and unsolicited Neighbor Advertisements, which prevents fast
> mobility of hosts between VTEPs.
> 
> This series adds a new neigh_forward_grat option that provides
> independent control of gratuitous ARP and unsolicited NA forwarding.
> When neigh_suppress is enabled but neigh_forward_grat is enabled,
> regular neighbor discovery is suppressed while gratuitous announcements
> are forwarded.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] bridge: uapi: Add neigh_forward_grat netlink attributes
    https://git.kernel.org/netdev/net-next/c/0c32db0761fe
  - [net-next,v2,2/6] bridge: Add internal flags for neigh_forward_grat
    https://git.kernel.org/netdev/net-next/c/3a28ccb9dd47
  - [net-next,v2,3/6] bridge: Add selective forwarding of gratuitous neighbor announcements
    https://git.kernel.org/netdev/net-next/c/27c082c600b1
  - [net-next,v2,4/6] bridge: Add port-level netlink handling for neigh_forward_grat
    https://git.kernel.org/netdev/net-next/c/2c75c438b9d9
  - [net-next,v2,5/6] bridge: Add per-VLAN netlink handling for neigh_forward_grat
    https://git.kernel.org/netdev/net-next/c/e65cf8815932
  - [net-next,v2,6/6] selftests: net: Add tests for neigh_forward_grat option
    https://git.kernel.org/netdev/net-next/c/4620aa6527d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



