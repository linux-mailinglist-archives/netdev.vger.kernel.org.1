Return-Path: <netdev+bounces-289000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGyhHI7yCmpv+AQAu9opvQ
	(envelope-from <netdev+bounces-289000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:05:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB5656B363
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2CF53027315
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED113EEAD2;
	Mon, 18 May 2026 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rV0Wl3IZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765BE3EEAC8;
	Mon, 18 May 2026 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102248; cv=none; b=OQgsiayhvdiqrnNSPy/vn8w7mn3cgdFj2mPFr6UOUqn2kdSEVZ0kFEaqdAFQr0L6nfhJtRWpaHKqWyI0xeT+2CGnt0UBxozvodgufZM8EnL+eKXhY5juBm29yDExZYUVZvYYn/gtZCWOB8N2I26NY6uIn8NMsy4/GuArR2MvhdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102248; c=relaxed/simple;
	bh=juE+V3ORpgCuEqh5KlQKobjNDQy2f+8eekBvvYfnF/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACTF+/oHWGumOT8B7DgfxOdU6cfQY7f8oIf6xoKusg1J6uHGJ8enuLicD9lv5xD0e5tEeK7G3jvuXGt0wubDWuePvwqJidFoXweq40ypgkQtQaulNyQe+9PVoknZTKzWVuwkUCE4CKgtA+vkQmEou+U4SLNjRKGfYotGDHePJig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rV0Wl3IZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E0CC2BCC6;
	Mon, 18 May 2026 11:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779102248;
	bh=juE+V3ORpgCuEqh5KlQKobjNDQy2f+8eekBvvYfnF/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rV0Wl3IZQ/cRKjkYBqvcmZPoKs1O9Bdbhc2q7+uCRzvph7RnjhLxz0pi3kGigFbGJ
	 EqT4a7FMEJMAGbjGi6SjfHNytBVK18m7wNpdW6GEfeSpBk0D708MLd1YcsgnFolhha
	 UZgEk2gF/+q6/GUXKPCIp0/tqDFThjt5H+5EV+/o/x9RMkOWxPH9F998E9OfxFkiAz
	 0Vv68fg4idojKgWaiFyWIe6H8J2OSETSFjcFj29DqcBlYJXm9Xh/q/dG824qUJt5Gx
	 LZ7C90p+mZmdHp7LN3qVMGLmZ75ziH6OFZRQ2AH3EpN27ZaB8ZIqA9keEoHUtdiA4x
	 uEgLb7isKzbjA==
From: Simon Horman <horms@kernel.org>
To: rrobaina@redhat.com
Cc: 'Simon Horman' <horms@kernel.org>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	eparis@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sgrubb@redhat.com
Subject: Re: [PATCH v2] netlink, audit: prevent false ENOBUFS on timeout expiry
Date: Mon, 18 May 2026 12:03:45 +0100
Message-ID: <20260518110345.497489-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513172443.1128496-1-rrobaina@redhat.com>
References: <20260513172443.1128496-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DEB5656B363
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289000-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
netlink, audit: prevent false ENOBUFS on timeout expiry

This commit modifies netlink_unicast() to return -EAGAIN when a blocking
sender's timeout expires. This bypasses the netlink_overrun() call to
allow the audit subsystem to gracefully enqueue the pending event into its
internal backlog without falsely returning ENOBUFS to user-space.

> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1351,8 +1351,18 @@ int netlink_unicast(struct sock *ssk, struct sk_buff *skb,
>  	}
>  
>  	err = netlink_attachskb(sk, skb, &timeo, ssk);
> -	if (err == 1)
> +	if (err == 1) {
> +		/* timeo may have been zeroed by schedule_timeout inside
> +		 * netlink_attachskb. If the caller is a timed-blocking sender
> +		 * (not genuinely nonblocking), don't re-enter with timeo=0 as
> +		 * that would misfire netlink_overrun on the next iteration.
> +		 */
> +		if (timeo == 0 && !nonblock) {
> +			kfree_skb(skb);
> +			return -EAGAIN;

Could this regression cause silent packet drops in non-audit subsystems?

While this change prevents false ENOBUFS for the audit subsystem, other
subsystems like InfiniBand's IWPM use rdma_nl_unicast_wait(), which sets
nonblock=0 and operates on a kernel socket with a timeout.

If the timeout expires because the receiving user-space daemon is
bottlenecked, this new path will free the skb and return -EAGAIN without
ever invoking netlink_overrun().

Without netlink_overrun(), the receiver's socket error is never set to
ENOBUFS. Would this prevent user-space from being notified of the dropped
message, leading to permanent state desynchronization between the kernel
and user-space?

> +		}
>  		goto retry;
> +	}
>  	if (err)
>  		return err;

