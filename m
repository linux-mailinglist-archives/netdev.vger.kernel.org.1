Return-Path: <netdev+bounces-270837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJwoAlHtwWkgYAQAu9opvQ
	(envelope-from <netdev+bounces-270837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 02:48:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BE5300AE5
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 02:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9473C3036072
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1039B371056;
	Tue, 24 Mar 2026 01:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UN11lDSp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A63156677
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316586; cv=none; b=UITaA9olTTZGhLURnTqyT1hBV7n5GQI3xHN4cZlrf6jFBjJOvhlUFa6Nf15LNqLqGXBmsORfZdtcovO/252qsO6MPYVHigk8MxHpcg4nNQ6LC37Tf1LxUY0AX8F1ij51lV2sjF9L8ax4AQqN8TwcAn8/dODD0WKE5UYYgILvrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316586; c=relaxed/simple;
	bh=hdhj6n9UIjivrtbaEqR3S/mdSjSW6bpoLdEvkagjb+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skDkRwkD7OwH3gUdGV1Sakpt1lUabj9tnkP3wyDJaT9Qdo8I/QCVmxRn8lM9/F0m7q2M1kObyl+INICmX5b/1h7Px5BHoUFhZ/kzZeB1axBbIPR+1T3U247GFmkhCVU0qU+ldBfC+Jk6GvXxGguzfo/72sb4mrDLPejnZ0UDALk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UN11lDSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022A8C4CEF7;
	Tue, 24 Mar 2026 01:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774316585;
	bh=hdhj6n9UIjivrtbaEqR3S/mdSjSW6bpoLdEvkagjb+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UN11lDSpO4YTkS/KbxDVZM4q3GwkncydcFzWrliO+JXVacwKRaPLMiPZctRGBTutX
	 3VmBDO6VIoFmAEq9YF+NvFwVHz1/U4vdEQhTIgkzGQJEo2yg57keJ+Lz4W/uc1aLNh
	 wja4YRFnWDSX9BF2qiq1V4uuo9ozitqpz7dwLLVD9D5JDL87SqactKrjtwNQNgU5YT
	 WyFLnFRqar4IDhQ3KCquZlHD8rjb1Mf5nSiD4VMW/1hkDNVNyCiWB8N+rZoKENeb9R
	 MjXqbxfCDSVAOhW22C9ibk5XNkasBiCKzvgviinIBadzrYnh8Xni/EEU1sLQt9MPyq
	 nd79JA3WQ+xLg==
Date: Mon, 23 Mar 2026 18:43:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>, Sabrina Dubroca
 <sd@queasysnail.net>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH net 1/1] ovpn: fix race between deleting interface and
 adding new peer
Message-ID: <20260323184304.42c3930f@kernel.org>
In-Reply-To: <20260320100351.2283994-2-antonio@openvpn.net>
References: <20260320100351.2283994-1-antonio@openvpn.net>
	<20260320100351.2283994-2-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,queasysnail.net,redhat.com,lunn.ch,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-270837-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81BE5300AE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 11:03:51 +0100 Antonio Quartulli wrote:
> While deleting an existing ovpn interface, there is a very
> narrow window where adding a new peer via netlink may cause
> the netdevice to hang and prevent its unregistration.
> 
> It may happen during ovpn_dellink(), when all existing peers are
> freed and the device is queued for deregistration, but a
> CMD_PEER_NEW message comes in adding a new peer that takes again
> a reference to the netdev.
> 
> At this point there is no way to release the device because we are
> under the assumption that all peers were already released.
> 
> Fix the race condition by releasing all peers in ndo_uninit(),
> when the netdevice has already been removed from the netdev
> list and thus an incoming CMD_PEER_NEW cannot have any effect
> anymore.
> 
> At this point ovpn_dellink() becomes empty and can just be
> removed.

This looks like a step in the right direction but AI points out that
it's not enough:

Does this completely resolve the race condition?
If a CMD_PEER_NEW netlink message executes concurrently, could the
following sequence occur since ovpn_nl_family uses parallel_ops:
1. In ovpn_nl_pre_doit(), the netlink thread looks up the device via
   dev_get_by_index_rcu(), increments its reference count via netdev_hold(),
   and drops the RCU lock.
2. Concurrently, device unregistration unlists the device and calls
   synchronize_net(). Since the RCU lock in ovpn_nl_pre_doit() was dropped,
   unregistration proceeds without waiting for the netlink command.
3. Unregistration executes ndo_uninit() (ovpn_net_uninit()), which calls
   cancel_delayed_work_sync() and ovpn_peers_free(), emptying the interface.
4. The preempted CMD_PEER_NEW thread resumes and adds the new peer via
   ovpn_peer_add(). Because the device registration state isn't verified
   (e.g., checking if dev->reg_state == NETREG_REGISTERED), the peer is
   added to the cleared hash tables.
If this sequence happens, wouldn't it cause a permanent hang for UDP sockets?
ovpn_socket_new() acquires a permanent netdev reference. Since
ovpn_peers_free() already ran, this peer is never removed, causing
netdev_wait_allrefs() to hang the kernel indefinitely.
Additionally, for TCP sockets, the keepalive timer would be re-armed
after being canceled here, leading to a use-after-free when the timer
eventually fires on the freed device memory.

