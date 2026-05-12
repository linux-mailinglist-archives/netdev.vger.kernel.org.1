Return-Path: <netdev+bounces-287080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KsjNNIFA2r1zgEAu9opvQ
	(envelope-from <netdev+bounces-287080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:49:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 415BF51EDAA
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A62713024142
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D983A38398B;
	Tue, 12 May 2026 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccAFGbMN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0709349CC0;
	Tue, 12 May 2026 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582811; cv=none; b=EhTSCVJdeBmwR1FO7922xrzJ/ppPCKJzXBp99D/Ftk7/U5ot8hCdVOpOqMCvRlgQ7O59d2Kq+EDo+0jShGCYaI3ks85PshYFOIydoljYBwtcXIbr+bPnxI96sxUdgWXEVqslA5ZAlM7j+NQV0NjjbzH+fGSTt+OfpvUSxlmaDiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582811; c=relaxed/simple;
	bh=CfTnm+NwfcKBfFp0bUW7Erh6C3aJPfKER4/xwdSZ/Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZT5UY/gFjEAmsFFZkrVC2i95wauxKWj9APFVq4gwMPeZeF02qlXXA7An31xe613uC8mqaSPIQq0hO8izPSCPpFi5L7lSUE8JQQXx7gOymSyHbxhn42ep5lVTHdsGgKw9u2X2ygI6ZHfvjTlhs2qU4uMopbFlg56/tLksTRbf2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccAFGbMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717DCC2BCB0;
	Tue, 12 May 2026 10:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778582811;
	bh=CfTnm+NwfcKBfFp0bUW7Erh6C3aJPfKER4/xwdSZ/Vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ccAFGbMNgzMK1PkjeUwVGBFpwMe+/f+2yMbP6VFLPkzL6VFb7QsHQBbRea1DFeJ7r
	 BeMhzOWkUiomhq1oHzCMcChcLel2sGfTZ1zLBZ/uqEbI/MNQ7H5ZmJMnTDYbP71ZAl
	 Xf6XU4gRMKWe6JYDz/NXvcJ5PDX6s+e4IPVAZIqLTu5qriTNPlBwyvOzq2jtzSfFyk
	 pE1fyrfhtuopNYya+4lPoODtW9YwZrL8cCbCekO21CxHO+90tRIT6Go+j0bRQWjzQj
	 KdfofwewjUXXDki54UNz1tOnWqGA+sphbv5kpu/Qnf8xSH7GBNUMl9JXumRzKkl+4U
	 Pu1okX7RSn93w==
Date: Tue, 12 May 2026 11:46:47 +0100
From: Simon Horman <horms@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, fmaurer@redhat.com, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
	linux-kernel@vger.kernel.org, bestswngs@gmail.com
Subject: Re: [PATCH net] net: hsr: fix NULL deref in hsr_get_node_data
Message-ID: <20260512104647.GK27589@horms.kernel.org>
References: <20260511071517.3013445-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511071517.3013445-1-xmei5@asu.edu>
X-Rspamd-Queue-Id: 415BF51EDAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,kernel.org,google.com,davemloft.net,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-287080-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.723];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid,asu.edu:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 12:15:17AM -0700, Xiang Mei wrote:
> hsr_get_node_data() looks up a node's address-B port and dereferences
> port->dev->ifindex without checking the return value of
> hsr_port_get_hsr(), which returns NULL when no port of the requested
> type is currently attached.
> 
> node->addr_B_port is set by hsr_handle_sup_frame() on every supervision
> frame but is never cleared when the corresponding slave is removed.
> If one slave of an HSR master is unregistered while the master stays
> alive (the other slave keeps it up), node_db entries retain a stale
> addr_B_port. An unprivileged HSR_C_GET_NODE_STATUS query (genl op has
> .flags = 0) then crashes the kernel:
> 
>   Oops: general protection fault, probably for non-canonical address
>   0xdffffc0000000002: 0000 [#1] SMP KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
>   RIP: 0010:hsr_get_node_data (net/hsr/hsr_framereg.c:892)
>   Call Trace:
>    hsr_get_node_status (net/hsr/hsr_netlink.c:366)
>    genl_family_rcv_msg_doit (net/netlink/genetlink.c:1114)
>    genl_rcv_msg (net/netlink/genetlink.c:1209)
>    netlink_rcv_skb (net/netlink/af_netlink.c:2550)
>    netlink_unicast (net/netlink/af_netlink.c:1344)
>    netlink_sendmsg (net/netlink/af_netlink.c:1894)
>    __sys_sendto (net/socket.c:2265)
> 
> Default *addr_b_ifindex to -1 and only overwrite it when the port
> lookup succeeds. The caller hsr_get_node_status() already treats
> addr_b_ifindex == -1 as "no address-B port" when emitting the
> HSR_A_NODE_ADDR_B / HSR_A_ADDR_B_IFINDEX attributes, so behavior is
> unchanged for valid setups.
> 
> Fixes: c5a759117210 ("net/hsr: Use list_head (and rcu) instead of array for slave devices.")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Hi,

Thanks for your patch.  It appears to address the same issue as the
following commit which was recently added to net.

Here is the summary with links:
  - [net] net: hsr: fix NULL pointer dereference in hsr_get_node_data()
    https://git.kernel.org/netdev/net/c/911f54771ca9

Although that code-changes there differ from this patch,
I believe the overall logic is the same.

Please consider an incremental patch if you think the commit above
is insufficient for some reason.

-- 
pw-bot: changes-requested

