Return-Path: <netdev+bounces-266427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEruImfWsGnLngIAu9opvQ
	(envelope-from <netdev+bounces-266427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:41:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F17DB25B0E4
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E3BB3059AD6
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 02:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB40371861;
	Wed, 11 Mar 2026 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM+QNiKu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BEA36D512;
	Wed, 11 Mar 2026 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773196829; cv=none; b=kzTRswd+SDNw17rC9UfsOJU3eASX7nXsByfiJRnxiBMlWHRo43oan6PGwzC+TcFrBjIoZLnnOXJ5H3VepfsdRx7Rteisci/BiWXwQ8tMZlAls+9zIbH11eGZ6IQ8WK9s0+yJmPrveMH0nb+kabxPmWLhO/0FtSbz0KkcOmdChoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773196829; c=relaxed/simple;
	bh=pfSrSo0DsLNTG03+tBUhx7H36IVMP9zoocdqJ4kONIA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XD9W7/LPGW32yiZ0HCDZ3NYgS/up3OcmlhO80m9i0g4HTPli5MIkXGr4dLw4a2Mf8QnSXtenVuDqb7Gsi1iK4+NXUMjvBj8B3G7yIRc0Mqx4CdjsPY3xR2bCyM0sx8wtK5DH0HADyuHpuGWaJ0ouYITkhB8E+R1GVqUGPqfMN7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM+QNiKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B12DC2BC9E;
	Wed, 11 Mar 2026 02:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773196829;
	bh=pfSrSo0DsLNTG03+tBUhx7H36IVMP9zoocdqJ4kONIA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GM+QNiKuF9+WY9KFlYGuRfaG/soOQxtREUlSIv+1yTcwQSBFZV1Napi7WzC+E+dsD
	 rDJQI5yYG2Vz7JuM7a9xBd/hBjz3IdloQi5DZnkOQ2SAfKR+eCF7EX8NQvJ66oVH2R
	 AtaqDXTgER0/0Zg48XtmAan+Oon0eM1W5YCotRP6sTupjrCJrnCNtvEpJEazAw6iGy
	 n/WkN9RMlK0/3cSfux0yC1GndC8ariwSizzNNEbqD3rURLnGsFTUov5N5PV23GLr/p
	 mP2pIdadbTvhqbdw1hNQbNqkMAUMWHTaxY+rtodR87doPW0wQBJqxWjJ5/4azD4wDU
	 uqFbgjiWtuUeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D7B3808200;
	Wed, 11 Mar 2026 02:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: rss: Add retries to
 test_rss_key_indir to reduce flakes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177319682554.3014711.9553555271793224929.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 02:40:25 +0000
References: <20260309204215.2110486-1-dimitri.daskalakis1@gmail.com>
In-Reply-To: <20260309204215.2110486-1-dimitri.daskalakis1@gmail.com>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 noren@nvidia.com, gal@nvidia.com, pavan.chebbi@broadcom.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Rspamd-Queue-Id: F17DB25B0E4
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
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-266427-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Mar 2026 13:42:15 -0700 you wrote:
> The test generates 16 flows, and verifies that traffic is distributed
> across two queues via the NICs RSS indirection table. The likelihood of the
> flows skewing to a single queue is high, so we retry sending traffic up to
> 3 times.
> 
> Alternatively, we could increase the number of generated flows. But
> debug kernels may struggle to ramp this many flows.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: rss: Add retries to test_rss_key_indir to reduce flakes
    https://git.kernel.org/netdev/net-next/c/690043b95c18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



