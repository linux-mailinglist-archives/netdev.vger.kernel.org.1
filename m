Return-Path: <netdev+bounces-259605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKGuMPOVl2nO1QIAu9opvQ
	(envelope-from <netdev+bounces-259605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:00:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEA2163703
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6FFD3019F2B
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 22:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B1B32F748;
	Thu, 19 Feb 2026 22:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/Uv1Dgy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1FD32ED4C;
	Thu, 19 Feb 2026 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771541997; cv=none; b=Z7LAgr5VcfNJRcfyFV0I2dcSGc1kJdTqXWHpouZWoLve8oaOYoPL8EzbdhbqiXzpcCKdmq9DJ2h6JCD6Spkr6yuxj0PRRm/urSOAtu7sr+XQhAlVjSM4GNYB46GLZqwtKlTM5qk1GKx6zV01aVUAxU/DuEcLvN5iU8jQAbTH+Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771541997; c=relaxed/simple;
	bh=21P4lQoosmeqD57PbfY+n1gGE4GdvTCMHoeeb+nIk3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AQU/+ZrarC2gsiSbFlLM3vZPiJhXgwsa+25rrh5LEQtFpMmjj00eRD5XmkZwksIA4zuaI9M+XVMQ9n2nC/N3QUdpD5rw7vApfPSkH14w9n6uI8wNxjSMb8/tTyNvr1U00Ts6MZvOoEmnMPoTuhlUVFFHx5qLQZh2xYAiBtGGekQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/Uv1Dgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837B1C4CEF7;
	Thu, 19 Feb 2026 22:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771541996;
	bh=21P4lQoosmeqD57PbfY+n1gGE4GdvTCMHoeeb+nIk3c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N/Uv1DgymzT8HhbsuQqxEbazuNahNqFv+Fr1fgtZYrRfsWqBfr3DX/UkiXxraZrj8
	 qk9y5sMUxxE8rNKs7bOjhvA32UmPDRsFFNL9mkXHpsmZJX9BJj8T32Vct/xJI9mNVg
	 ASP9/OQtknH/AYOu6HuJpYBfkQsj5F9jQSy7Jl39WA92p2jYCAzXLr1QJxirqCf0ve
	 AigJrgvzrlAwwSdRvVxNdJ70xmLokg0UdtA9+3YZODwCqopkGdCHlY8iCzArMBIg5z
	 5WdvrzlT+kV/RPwSmytYirVwNV3NZxzRh/0Sk8OrU1qj48KcvssqcKn1OT4DIdHb3H
	 4cKHOGRgKkOqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEDE3809A88;
	Thu, 19 Feb 2026 23:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: dsa: sja1105: protect link replay helpers
 against
 NULL phylink instance
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177154200505.124841.17439229755719074518.git-patchwork-notify@kernel.org>
Date: Thu, 19 Feb 2026 23:00:05 +0000
References: <20260218160551.194782-1-vladimir.oltean@nxp.com>
In-Reply-To: <20260218160551.194782-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259605-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BEA2163703
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Feb 2026 18:05:51 +0200 you wrote:
> There is a crash when unbinding the sja1105 driver under special
> circumstances:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
> Call trace:
> phylink_run_resolve_and_disable+0x10/0x90
> sja1105_static_config_reload+0xc0/0x410
> sja1105_vlan_filtering+0x100/0x140
> dsa_port_vlan_filtering+0x13c/0x368
> dsa_port_reset_vlan_filtering.isra.0+0xe8/0x198
> dsa_port_bridge_leave+0x130/0x248
> dsa_user_changeupper.part.0+0x74/0x158
> dsa_user_netdevice_event+0x50c/0xa50
> notifier_call_chain+0x78/0x148
> raw_notifier_call_chain+0x20/0x38
> call_netdevice_notifiers_info+0x58/0xa8
> __netdev_upper_dev_unlink+0xac/0x220
> netdev_upper_dev_unlink+0x38/0x70
> del_nbp+0x1a4/0x320
> br_del_if+0x3c/0xd8
> br_device_event+0xf8/0x2d8
> notifier_call_chain+0x78/0x148
> raw_notifier_call_chain+0x20/0x38
> call_netdevice_notifiers_info+0x58/0xa8
> unregister_netdevice_many_notify+0x314/0x848
> unregister_netdevice_queue+0xe8/0xf8
> dsa_user_destroy+0x50/0xa8
> dsa_port_teardown+0x80/0x98
> dsa_switch_teardown_ports+0x4c/0xb8
> dsa_switch_deinit+0x94/0xb8
> dsa_switch_put_tree+0x2c/0xc0
> dsa_unregister_switch+0x38/0x60
> sja1105_remove+0x24/0x40
> spi_remove+0x38/0x60
> device_remove+0x54/0x90
> device_release_driver_internal+0x1d4/0x230
> device_driver_detach+0x20/0x38
> unbind_store+0xbc/0xc8
> 
> [...]

Here is the summary with links:
  - [v2,net] net: dsa: sja1105: protect link replay helpers against NULL phylink instance
    https://git.kernel.org/netdev/net/c/bfd264fbbbca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



