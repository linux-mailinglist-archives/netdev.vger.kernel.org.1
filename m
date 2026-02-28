Return-Path: <netdev+bounces-262155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AACNJ9oLo2nY9AQAu9opvQ
	(envelope-from <netdev+bounces-262155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 16:38:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B831C404D
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 16:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC16330C16D6
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252E947B413;
	Sat, 28 Feb 2026 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrD5ERAU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3E4657F2;
	Sat, 28 Feb 2026 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292930; cv=none; b=HiCl4fJc6jMf9SmO4AOno0nDUPAGYbHiHh9+5D1oEIYRAwBTobwQNe5Xvu9hch2anaYSCU6iRYpVGXfa4sIhFBxh70L0j3gbN9w6LQo8ImZxV9XV3gYyQ0vhnGOTn3zREYVEVfsxSmJauujZEF1D4vdg6XzezlXJAkja/oLJ/Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292930; c=relaxed/simple;
	bh=zvZy3Px9p33IPr0eJ5otl8cAQIfEfXRvV36zcwUHZW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCleDZgkb0J0OU8//ImhhxYhDds/QnU4gBgzgWQ6TkbpOMgpuJO1pzMhmI8DGdOcr5mYQ4RCh/qdqfndeHMnUC9E/c2eOsXQU7ZcRn3gCGG6Ixvw457OdxrrPpdz1N2ebZYx2b9Qv/v02nmCuT7MV4P55diX85TQEKAOREac8Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrD5ERAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598D2C116D0;
	Sat, 28 Feb 2026 15:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772292929;
	bh=zvZy3Px9p33IPr0eJ5otl8cAQIfEfXRvV36zcwUHZW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OrD5ERAUR1a+decV2HSptDosENl4ePOeTtQKpVFU7MAvYbAbduymDstW4o2B5tI7J
	 0kJmgPXiVdmrWb9PnsJ9hKEiko4yEaTykl97USWWaXOCuHH+ZkCZL9YlAcBfvZBpMA
	 HVf1MSyoOIwgoyGL9S6AQCLcp2nW6zvZTOCc8P3xzVEJq31asYUaL6dE08oRmZKXBX
	 UHL6Xwp141fSUaud6uiyo15mz5+lqCx2UtvmlzTfdugRsTVzRQ1hoj7FRz/Oqe9/vU
	 eC/do57DOAy42AHHE9zD1POlsy+vC43PTkU4LKq2vb82pMHrnDo8iKjp213Ob/GLwh
	 x1PNzxtMM3/eA==
Date: Sat, 28 Feb 2026 07:35:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Bauer <mail@david-bauer.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] l2tp: account for IP version in SKB
 headroom
Message-ID: <20260228073528.6e445fb8@kernel.org>
In-Reply-To: <20260227220740.11928-1-mail@david-bauer.net>
References: <20260227220740.11928-1-mail@david-bauer.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-262155-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,l2tp.sh:url]
X-Rspamd-Queue-Id: 16B831C404D
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 23:07:37 +0100 David Bauer wrote:
> Account for the IP version of the tunnel when accounting skb headroom on
> xmit. This avoids having to potentially copy the skb a second time down
> the stack due to allocating not enough space for IPv6 headers in case
> the tunnel uses IPv6.

This appears to crash immediately in the net/l2tp.sh selftest:

# selftests: net: l2tp.sh
# 0.27 [+0.27] ./l2tp.sh: line 138: 22310 Killed                     ip -netns $host_1 l2tp add session name l2tp4 tunnel_id 1041 session_id 1041 peer_session_id 1042
not ok 1 selftests: net: l2tp.sh # exit=137

[ 1585.224860] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[ 1585.224891] RIP: 0010:l2tp_eth_create+0xf2/0x300 [l2tp_eth]
[ 1585.225362]  <TASK>
[ 1585.225377]  l2tp_nl_cmd_session_create+0x204/0x470 [l2tp_netlink]
-- 
pw-bot: cr

