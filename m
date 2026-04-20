Return-Path: <netdev+bounces-279930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOmhM0ii5mkrzAEAu9opvQ
	(envelope-from <netdev+bounces-279930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 00:01:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F754346CF
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 00:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18229302974C
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 22:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A6A3CFF47;
	Mon, 20 Apr 2026 22:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCYRRlwm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1045F3A1E70
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 22:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776722419; cv=none; b=EIt+0G5lYZe76oMjaqiFpzkUfn3ayPINAKftZ1IMeJAZA9pTgbpX//EOlAA1yL9ZjvUkgQjYWwmhhz/cBHNc5ANBQwztF7fehFK2mk7eHtIpp6BEYib8BF6IWRG+IgdnLFFFJTgilfgIb9XZQlZ9iS0dLAMy+KLc+MmT0ZuOsQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776722419; c=relaxed/simple;
	bh=sxZHk+4euPY5rGYiNQbDPx2ntwIC/3CPCspQSU8TyUQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mPz2KBs1Rt+Jw50evlmo+Fx/BYx2skn9H6S1cx2BzFLy28o0Xz/FYWu/w2bBfmiMTNMXZYtJXXnj5G8R7DFf38nP43ZE9qRGuvEKtAaauld1cxuNOahCVgUzGSvhi6sLXa4FXivkOg/IdRN8zl18MXnkcDaOvf4BdA5xvIZmtu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCYRRlwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B320AC19425;
	Mon, 20 Apr 2026 22:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776722418;
	bh=sxZHk+4euPY5rGYiNQbDPx2ntwIC/3CPCspQSU8TyUQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JCYRRlwmVfCY5wQtv/X/+B4mSJUyUpqWDu5XaT7w6IgkXAwplIC7NreeKiGhXnkU/
	 dI452jC9olKaHbHGXvgohnJEXx4JgP+kOViB4nOTIg89gkywWmDNjqNPb8gHc0YjjI
	 I1CTSvnca8RiYdML/LhAj+QU6W7IVSudOmeMVchDv8ecQfIJxtlDq5J3TK6N15Ty3W
	 oF+IO57N2y7XQND8QPDOnQve29wK00b28cuIq2/WBFt5J59/0bk+Zx5hR+NJ6Ls+Md
	 sukfuyCJKCRaIjf00gct/SLi3FghKI0B1/0xrKGHyA+IkAwcdvSlp/FgU+UChzToqP
	 Yj9j+4Mpg5izQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 402133930022;
	Mon, 20 Apr 2026 21:59:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] openvswitch: cap upcall PID array size and
 pre-size
 vport replies
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177672238280.1802062.5735689554242119522.git-patchwork-notify@kernel.org>
Date: Mon, 20 Apr 2026 21:59:42 +0000
References: <20260416024653.153456-2-bestswngs@gmail.com>
In-Reply-To: <20260416024653.153456-2-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, pshelar@nicira.com, tgraf@redhat.com, alexw@nicira.com,
 netdev@vger.kernel.org, dev@openvswitch.org, xmei5@asu.edu
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279930-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
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
X-Rspamd-Queue-Id: 25F754346CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Apr 2026 19:46:54 -0700 you wrote:
> The vport netlink reply helpers allocate a fixed-size skb with
> nlmsg_new(NLMSG_DEFAULT_SIZE, ...) but serialize the full upcall PID
> array via ovs_vport_get_upcall_portids().  Since
> ovs_vport_set_upcall_portids() accepts any non-zero multiple of
> sizeof(u32) with no upper bound, a CAP_NET_ADMIN user can install a PID
> array large enough to overflow the reply buffer, causing nla_put() to
> fail with -EMSGSIZE and hitting BUG_ON(err < 0).  On systems with
> unprivileged user namespaces enabled (e.g., Ubuntu default), this is
> reachable via unshare -Urn since OVS vport mutation operations use
> GENL_UNS_ADMIN_PERM.
> 
> [...]

Here is the summary with links:
  - [net,v5] openvswitch: cap upcall PID array size and pre-size vport replies
    https://git.kernel.org/netdev/net/c/2091c6aa0df6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



