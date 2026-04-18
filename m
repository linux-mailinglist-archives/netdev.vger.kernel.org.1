Return-Path: <netdev+bounces-279498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +TiHD4t742nZHQEAu9opvQ
	(envelope-from <netdev+bounces-279498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 14:39:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93175421199
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 14:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA03C30234D5
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 12:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF0A238159;
	Sat, 18 Apr 2026 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LehHcPxr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1428287E
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776515974; cv=none; b=U2sM/giH9WZJ9H4yoIuna2LqYvwOiMAYWy1P5RpPpcvhlHle5l0FsbqN/7BnnEIhAmoR7CoICAmLHoC/3PjACVv/pxSejg9iLVkBZUn6ypdfWG4x+lk44d8D7sTpMGxFbdqnyPZIW59JtdNk/MFqf+EzOas/Bd7SDknjRFURxvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776515974; c=relaxed/simple;
	bh=vaBEHmgiv0roE1fBm/FD8JymZwQofYCgDCtgvXtVtS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1m0NYqvbzNKHXCKvQJEGs2tYxadkuMfG2Cx2bgVFk9sVI4oBa0teAPIEX4SkUVjFn0OU/5xPn0jxZPtbxmjuOnNW6kcj/KfAxJRXsQO565vr8v7L3HHoyPSXPrDA7l7x+x1anxVl4Ep0RByUIVKF2sXO16XquGcTKW+6z1MRxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LehHcPxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D09C19424;
	Sat, 18 Apr 2026 12:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776515974;
	bh=vaBEHmgiv0roE1fBm/FD8JymZwQofYCgDCtgvXtVtS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LehHcPxrJgr5FLvBbbm5fctMMICTs1E5yqmPdyoh54+kG5u8ScHqRb8z0Cv6df35W
	 pexl1du9ZYongxWVJ8tOv5bg3jftpdnrtIUDMNP7w2imk/vRrwabbLdmih2FA2kS3R
	 nfBp/FkLh0s8xjofHD3Equ6z+TFci9BNhl7He6tVbTa9tUvmeRDrV0vUB79yw1Z7ov
	 hqa1YsRj6JqVq48s5B7ZeOAsVsOVPtuOJcoMnwWlownGwmGd1bCzNypYCAPOlVFwk6
	 rowt5ICDz92hDUAN2SFsLKFrFMmiSl6RNQEUIcdTQu/5aNbgBDanWBZv8uPEM7Qx+D
	 CMdZQpqOwVvzg==
Date: Sat, 18 Apr 2026 13:39:29 +0100
From: Simon Horman <horms@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2] slip: reject VJ receive packets on instances with
 no rstate array
Message-ID: <20260418123929.GE280379@horms.kernel.org>
References: <20260415204130.258866-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415204130.258866-2-bestswngs@gmail.com>
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279498-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_SPAM(0.00)[0.083];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 93175421199
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 04:41:31AM +0800, Weiming Shi wrote:
> slhc_init() accepts rslots == 0 as a valid configuration, with the
> documented meaning of 'no receive compression'. In that case the
> allocation loop in slhc_init() is skipped, so comp->rstate stays
> NULL and comp->rslot_limit stays 0 (from the kzalloc of struct
> slcompress).
> 
> The receive helpers do not defend against that configuration.
> slhc_uncompress() dereferences comp->rstate[x] when the VJ header
> carries an explicit connection ID, and slhc_remember() later assigns
> cs = &comp->rstate[...] after only comparing the packet's slot number
> to comp->rslot_limit. Because rslot_limit is 0, slot 0 passes the
> range check, and the code dereferences a NULL rstate.
> 
> The configuration is reachable in-tree through PPP. PPPIOCSMAXCID
> stores its argument in a signed int, and (val >> 16) uses arithmetic
> shift. Passing 0xffff0000 therefore sign-extends to -1, so val2 + 1
> is 0 and ppp_generic.c ends up calling slhc_init(0, 1). Because
> /dev/ppp open is gated by ns_capable(CAP_NET_ADMIN), the whole path
> is reachable from an unprivileged user namespace. Once the malformed
> VJ state is installed, any inbound VJ-compressed or VJ-uncompressed
> frame that selects slot 0 crashes the kernel in softirq context:
> 
>  Oops: general protection fault, probably for non-canonical
>        address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
>  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>  RIP: 0010:slhc_uncompress (drivers/net/slip/slhc.c:519)
>  Call Trace:
>   <TASK>
>   ppp_receive_nonmp_frame (drivers/net/ppp/ppp_generic.c:2466)
>   ppp_input (drivers/net/ppp/ppp_generic.c:2359)
>   ppp_async_process (drivers/net/ppp/ppp_async.c:492)
>   tasklet_action_common (kernel/softirq.c:926)
>   handle_softirqs (kernel/softirq.c:623)
>   run_ksoftirqd (kernel/softirq.c:1055)
>   smpboot_thread_fn (kernel/smpboot.c:160)
>   kthread (kernel/kthread.c:436)
>   ret_from_fork (arch/x86/kernel/process.c:164)
>   </TASK>
> 
> Reject the receive side on such instances instead of touching rstate.
> slhc_uncompress() falls through to its existing 'bad' label, which
> bumps sls_i_error and enters the toss state. slhc_remember() mirrors
> that with an explicit sls_i_error increment followed by slhc_toss();
> the sls_i_runt counter is not used here because a missing rstate is
> an internal configuration state, not a runt packet.
> 
> The transmit path is unaffected: the only in-tree caller that picks
> rslots from userspace (ppp_generic.c) still supplies tslots >= 1, and
> slip.c always calls slhc_init(16, 16), so comp->tstate remains valid
> and slhc_compress() continues to work.
> 
> Fixes: b5451d783ade ("slip: Move the SLIP drivers")

AI review points out that the cited commit moves code but doesn't
add this bug.

It seems to me that this bug has existed since the beginning of git
history. If so, the Fixes tag should be:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> v2:
> - slhc_remember(): use sls_i_error instead of sls_i_runt for the
>   missing-rstate case; it is a configuration error, not a runt packet
>   (Simon).
> - slhc_uncompress(): goto bad instead of returning 0, so the instance
>   also enters SLF_TOSS on the first rejected frame.

Otherwise this looks good to me:

Reviewed-by: Simon Horman <horms@kernel.org>


I do note that Sashiko flags some other problems in this code.
I do not think that needs to delay progress of this patch.
But you may wish to look into them as follow-up work.

