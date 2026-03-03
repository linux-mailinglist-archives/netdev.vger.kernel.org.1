Return-Path: <netdev+bounces-263174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLZEG3jRpmnHWgAAu9opvQ
	(envelope-from <netdev+bounces-263174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:18:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC68C1EF356
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 492BD301A7D6
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 12:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCF833F5BF;
	Tue,  3 Mar 2026 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3xXBU6O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26337311940;
	Tue,  3 Mar 2026 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772540057; cv=none; b=tFBnVJjRhVhNSTDorgBB/X91BoCmhnJgWd4NKU/mk86ttMPM3glRC8vUX1/n8gY0k9Bbwc9vUoIoger5gPMTa9MQ5p3C3nTpm/UElqx8A9EXAMB54ofL0XbehlBP2Rc+8i6wUxfO4PpzZCCPIkRol/Y/cPTvpyVhPGconu2EDn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772540057; c=relaxed/simple;
	bh=TRVHfXeminoP9mtqkPjk0BCs7S999ODClst+HhImP/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBXGsyLCQxRhW1Og6MA0a/tZ00RP/j7B8f401/5rKSiaawjzrIc566rRkaZU+gZo7MZWzqjdgqmlPQPT5VF0QkD3VG/5ISDIgkqPN2h7csJv+OUCvQ6WDTHQhT8s36Ax0rDJNH8UV4souEmLA8udZk1BNpWBnNpuzp1931icLAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3xXBU6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DEDC116C6;
	Tue,  3 Mar 2026 12:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772540056;
	bh=TRVHfXeminoP9mtqkPjk0BCs7S999ODClst+HhImP/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K3xXBU6OAaYLt5xTSOhvq6ZV612HcFkLwlUiBQesCDpkFbOz4ykvbkfVXcfW0lHj6
	 eV7p3OExG6XpF+k3mZgUCFKhYsC2sfExIZcam5U8Bq1uOotbWAAanwiT+/pORa0JQ6
	 synMEgeEbxBwAMYDKRcWI24L0Y57k7fpR2qvB7cc+sakxu/cMvqc3M3cfIpxNe3i/X
	 VnqercY8SCYR/IkPbOROLhwHND5mSr9CDfLKAQVhLcDGP2NYSwIRVbsamT+Barp9/r
	 9WmdRYMNKndjZWHozsLch10EYM/h2xaKafY7uUhJq+I9HKZLsr1KGiv3mdAuL06p1r
	 OIsywbCby78vw==
Date: Tue, 3 Mar 2026 12:14:11 +0000
From: Simon Horman <horms@kernel.org>
To: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>, shuah@kernel.org
Subject: Re: [PATCH net-next v3 00/14] net: bridge: reduce multicast checks
 in fast path
Message-ID: <20260303121411.GC71509@kernel.org>
References: <20260302054008.21638-1-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302054008.21638-1-linus.luessing@c0d3.blue>
X-Rspamd-Queue-Id: BC68C1EF356
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
	TAGGED_FROM(0.00)[bounces-263174-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,nvidia.com,lunn.ch,redhat.com,kernel.org,google.com,davemloft.net,fomichev.me,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 06:39:54AM +0100, Linus Lüssing wrote:
> This patchset introduces new state variables to combine and reduce the
> number of checks we would otherwise perform on every multicast packet
> in fast/data path. Instead of checking if our querier is enabled or
> if another querier timer is pending, plus if the initial query
> grace period has elapsed, plus for IPv6 and for our own querier if we
> have an IPv6 address yet - and all this for every multicast packet -
> we can now simply check one boolean state variable per protocol family
> combining all this, the new ip{4,6}_active. Or MCAST_ACTIVE_V4 /
> MCAST_ACTIVE_V6 to netlink/userspace.
>   
> The second reason for introducing these new, internal multicast active
> variables is to later propagate a safety mechanism which was introduced
> in commit b00589af3b04 ("bridge: disable snooping if there is no querier")
> to switchdev/DSA, too. That is to notify switchdev/DSA if multicast
> snooping can safely be applied without potential packet loss.
> 
> An example usage/integration of this with the modified Realtek rtl83xx
> switch driver can be found in a draft pull-request at the OpenWrt
> project: https://github.com/openwrt/openwrt/pull/18780
> This was tested at least on an ZyXEL GS1900-24HP v1 switch.
> 
> iproute2 patch:
> https://patchwork.kernel.org/project/netdevbpf/patch/20260206023704.4839-1-linus.luessing@c0d3.blue/
> 
> Regards, Linus

Hi Linus,

This patch-set appears to break builds with IPV6=n.

Please take a look into that for the next version: each patch
should build when applied one by one.

