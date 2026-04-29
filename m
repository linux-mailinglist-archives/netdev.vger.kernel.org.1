Return-Path: <netdev+bounces-282178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF+XLc1f8WmogQEAu9opvQ
	(envelope-from <netdev+bounces-282178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:33:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1717E48DFD7
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF523301FA51
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D1925333F;
	Wed, 29 Apr 2026 01:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8P/FciG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E1224E4B4
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 01:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777426277; cv=none; b=uy/cdgF7+jZ3kXFUFQkNhOB03q5Bra8UeGODBZ6xBocg0YxzwOVn4E4zSspHL/wWDTbAoviI0QnJn77LPNUNsoo46bKpoIhN1ApTiHXu9pqar7CJkc0n7qRMEUyHnvsPIzV8gHsKoPTpX3FVTac299XPFrbksrNqSY3UMZx/Gfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777426277; c=relaxed/simple;
	bh=6R5W918RVRLznmgj/4DRE1i93gvUnH0OOdu76dV7ZW4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L0lhe1PHjJnsPtq8FAL+yEOvFmBRUgL4vWVruzrHBi9vMEPMI/Uvl3OyJCwYQ7iGZib1dRAD7qSMXE4u3IPzjHqv7ZjhHWvWQ77wU9zEjTsUHam9uk2JI9xdnu/P16LElfLH1MmNF6EROhSTMPsCWKJIhqF9Te65v0bW4Y925Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8P/FciG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0900FC2BCB7;
	Wed, 29 Apr 2026 01:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777426277;
	bh=6R5W918RVRLznmgj/4DRE1i93gvUnH0OOdu76dV7ZW4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b8P/FciGcTIj09oBRMlfd3uXydxJ0MiivEsPvimGbacswRbBgocKM6SpLwk0CaJnT
	 qYyjAofiH17loTY3oEwkf9l+wNRjVIkxmTrGiRkKXmD7+KN0xZgtV4pynXOjwoHM4y
	 KLE0tJqYlGVtK9Id/CScGRSwSfPzF+8NN1hYrcZJGScxfAZ5VCxB/SYyP30B2ifpp9
	 nHhYaLARp553xMgwgrKx4o2jXprEyzEwb9M7MyvwSTob0T7mWhNwN19kjYzRRiJOnM
	 sqH0yAW7r4LJBDADCJvMFTq2MEmtQu5aXI8LFXpV+/pIN9Yw6rG0oQcxrEIz5EAEPy
	 kcJcKPd+VzJIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1FA39302C2;
	Wed, 29 Apr 2026 01:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bareudp: fix NULL pointer dereference in
 bareudp_fill_metadata_dst()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177742623307.1288483.17880637779173288953.git-patchwork-notify@kernel.org>
Date: Wed, 29 Apr 2026 01:30:33 +0000
References: <20260426165350.1663137-2-bestswngs@gmail.com>
In-Reply-To: <20260426165350.1663137-2-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
 martin.varghese@nokia.com, netdev@vger.kernel.org, xmei5@asu.edu
X-Rspamd-Queue-Id: 1717E48DFD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282178-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 26 Apr 2026 09:53:51 -0700 you wrote:
> bareudp_fill_metadata_dst() passes bareudp->sock to
> udp_tunnel6_dst_lookup() in the IPv6 path without a NULL check.
> The socket is only created in bareudp_open() and NULLed in
> bareudp_stop(), so calling this function while the device is down
> triggers a NULL dereference via sock->sk.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000018
>  RIP: 0010:udp_tunnel6_dst_lookup (net/ipv6/ip6_udp_tunnel.c:160)
>  Call Trace:
>   <TASK>
>   bareudp_fill_metadata_dst (drivers/net/bareudp.c:532)
>   do_execute_actions (net/openvswitch/actions.c:901)
>   ovs_execute_actions (net/openvswitch/actions.c:1589)
>   ovs_packet_cmd_execute (net/openvswitch/datapath.c:700)
>   genl_family_rcv_msg_doit (net/netlink/genetlink.c:1114)
>   genl_rcv_msg (net/netlink/genetlink.c:1209)
>   netlink_rcv_skb (net/netlink/af_netlink.c:2550)
>   </TASK>
> 
> [...]

Here is the summary with links:
  - [net] bareudp: fix NULL pointer dereference in bareudp_fill_metadata_dst()
    https://git.kernel.org/netdev/net/c/aa6c6d9ee064

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



