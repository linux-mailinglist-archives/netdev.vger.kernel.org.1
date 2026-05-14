Return-Path: <netdev+bounces-287767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMrTHE4hBWpySwIAu9opvQ
	(envelope-from <netdev+bounces-287767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:11:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D167B53C946
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4636A30520B9
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA8B30B51F;
	Thu, 14 May 2026 01:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xenu8UJE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC6E78F4A;
	Thu, 14 May 2026 01:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778721069; cv=none; b=dwp+XL8M6H/M47bI2yoAnC8IDpqTrQo5EFfh6HfeWX4bUBfCkvOoqimJSZzxdePxcISdn2mEyutp4hJ+CaK820AUU8nTQA/RRK9wbZxX4bZmjKse9GgeXY4tx1yex39o6fsVqAyxrwAZOYN432ATEHffaXgBviKZyQ09KiQGuEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778721069; c=relaxed/simple;
	bh=TkXBrjLNEz+G2+1/UuRVVA48NujTKdPmLKe32nzpxYU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KZ4jZJpJq9JfDZyPwvz+S/yE6tLVYOvj2xQWmezEtSq0FS0F8ATgFl+MU+og6ZaU/47L9yVg1fXnsTfjj/wG7FoSi7GahSTZfA2CLl6gR/gU8QQNUhBda2C9xj2lxwfKrgBaYFflxx4jUdSGQ6wWubGFVS3Ui2DNGgYpVtAf+00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xenu8UJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911A0C2BCB3;
	Thu, 14 May 2026 01:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778721069;
	bh=TkXBrjLNEz+G2+1/UuRVVA48NujTKdPmLKe32nzpxYU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xenu8UJE+ogvudjUemt8CHsuNEO86FJUWSo2KyqT03CxcrmdCZd9xqIqTjEOMaNuY
	 QPW6muhaq8pghrYJqHlYxGhwzPnjLaLd+cL9pL4eq4O1u8EO4ovkKJkgI6xsPFgZbM
	 NBF/d36BTk7mMUuMmuEFkskKytFm/BGJiHfg0LwkgsQrLeXw5hQ8JDHyv3s2IQ4Zk6
	 r0m5fdwnsnZ4iVVhSeoqva+ce1c+wmi31gcGYWR6vgoSlLYu1E2hU0RbZwSvfkVwEn
	 v5qzO3TlShfyApmZpQis3LsqWb9jT/89KHUr/hnIEYCL+DPyeR7QLlnroQeJAN43d8
	 9ihWUEnTbK1CA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C99393088E;
	Thu, 14 May 2026 01:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v12 0/4] tun/tap & vhost-net: apply qdisc
 backpressure on full ptr_ring to reduce TX drops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177872101453.3905490.6501726705670016323.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 01:10:14 +0000
References: <20260510151529.43895-1-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260510151529.43895-1-simon.schippers@tu-dortmund.de>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mst@redhat.com, eperezma@redhat.com,
 leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
 tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev
X-Rspamd-Queue-Id: D167B53C946
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287767-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 10 May 2026 17:15:25 +0200 you wrote:
> This patch series deals with tun/tap & vhost-net which drop incoming
> SKBs whenever their internal ptr_ring buffer is full. Instead, with this
> patch series, the associated netdev queue is stopped - but only when a
> qdisc is attached. If no qdisc is present the existing behavior is
> preserved. The XDP transmit path is not affected. This patch series
> touches tun/tap and vhost-net, as they share common logic and must be
> updated together. Modifying only one of them would break the other.
> 
> [...]

Here is the summary with links:
  - [net-next,v12,1/4] tun/tap: add ptr_ring consume helper with netdev queue wakeup
    https://git.kernel.org/netdev/net-next/c/d4c22d70d725
  - [net-next,v12,2/4] vhost-net: wake queue of tun/tap after ptr_ring consume
    https://git.kernel.org/netdev/net-next/c/baf808fe4fcd
  - [net-next,v12,3/4] ptr_ring: move free-space check into separate helper
    https://git.kernel.org/netdev/net-next/c/fba362c17d9d
  - [net-next,v12,4/4] tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present
    https://git.kernel.org/netdev/net-next/c/1d6e569b7d0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



