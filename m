Return-Path: <netdev+bounces-279897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDASAPd05mkNwwEAu9opvQ
	(envelope-from <netdev+bounces-279897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:48:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8445943312A
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 046C130DC08D
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDA83B0AE1;
	Mon, 20 Apr 2026 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7PZxMdI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8977A3AF645
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776710028; cv=none; b=Sn2frsFjxaax37bZ87XYrf/W9sfKFO5DyQXMSoZtLe6gNGMVT81Vlm5aHZjnGPlfWtsc4Vs8/LgWbWrImg/8QLF7LzOpLhb0Qm+/BxtZFbm9VuS+MCz/x30OUDUq9w8M3yxBo5uRICD8QpORwNHZwjraMYAt73sbZU7T1d6jR/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776710028; c=relaxed/simple;
	bh=77uB7WNs51mNTBXQHw8Cas/zaR5buWpS4r3pa9meRYw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drPjpi5Y+g7Ia+l2ueXTL9dSV0QMQtwuApjT+FhWak9m6NbTxRnYUpQBwWELnEfA6rw01c66pByeg0JUVV/2Xlr8576F2jZABHi52a9aJ3iMUDNeyhlyS+YukaJRvBqQOleYCZivVxZojEUxtuVkkx6Iz6vrhFVMRTZW9b3YNWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7PZxMdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A996AC19425;
	Mon, 20 Apr 2026 18:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776710028;
	bh=77uB7WNs51mNTBXQHw8Cas/zaR5buWpS4r3pa9meRYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C7PZxMdIgBa5L/6ZIftRVdQ0pc8zuG9tMXaHOLHeSXdAIYHteKyaMD+sFw44w+bYn
	 ccaZE3YkkUziKwrqnsv+ZuDtf+hAxUTb6wz7CuALE1uqemJuJnZ8Q6VnDUaUDKbMJw
	 oSBIj8lhqnZ8Yy+2wR14IVWMmPfPD/WdP9sHwmA60oPfGarXdz3O9tJ+Dcy6Fam9KL
	 tO/l22vKKVlmGqmJaJiZ1c/8zV4f8BACOAiO3xFz3e8qvNzvwMDZ+9fMUXXe3DEKZ2
	 hyXkDsK5rDwCVR04A3t83P/qYUgHWAiEPRS/QwTlEHUTfOR6MddNc9mHAj3Nr1P0kg
	 Ux/X85tpi9hgQ==
Date: Mon, 20 Apr 2026 11:33:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>
Cc: Altan Hacigumus <ahacigu.linux@gmail.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, Enke Chen
 <enchen@paloaltonetworks.com>
Subject: Re: [PATCH net] tcp: make probe0 timer handle expired user timeout
Message-ID: <20260420113346.34735a1e@kernel.org>
In-Reply-To: <20260414013634.43997-1-ahacigu.linux@gmail.com>
References: <20260414013634.43997-1-ahacigu.linux@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,paloaltonetworks.com];
	TAGGED_FROM(0.00)[bounces-279897-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8445943312A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 18:36:34 -0700 Altan Hacigumus wrote:
> tcp_clamp_probe0_to_user_timeout() computes remaining time in jiffies
> using subtraction with an unsigned lvalue.  If elapsed probing time
> already exceeds the configured TCP_USER_TIMEOUT, the subtraction
> underflows and yields a large value.
> 
> Handle this expiration case similarly to tcp_clamp_rto_to_user_timeout().
> 
> Fixes: 344db93ae3ee ("tcp: make TCP_USER_TIMEOUT accurate for zero window probes")
> Signed-off-by: Altan Hacigumus <ahacigu.linux@gmail.com>

Hi Eric, Neal, does this makes sense?

> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 5a14a53a3c9e..4a43356a4e06 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -50,7 +50,8 @@ static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
>  u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when)
>  {
>  	const struct inet_connection_sock *icsk = inet_csk(sk);
> -	u32 remaining, user_timeout;
> +	u32 user_timeout;
> +	s32 remaining;
>  	s32 elapsed;
>  
>  	user_timeout = READ_ONCE(icsk->icsk_user_timeout);
> @@ -61,6 +62,8 @@ u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when)
>  	if (unlikely(elapsed < 0))
>  		elapsed = 0;
>  	remaining = msecs_to_jiffies(user_timeout) - elapsed;
> +	if (remaining <= 0)
> +		return 1;
>  	remaining = max_t(u32, remaining, TCP_TIMEOUT_MIN);
>  
>  	return min_t(u32, remaining, when);


