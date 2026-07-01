Return-Path: <netdev+bounces-303899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FDHQFQykRWoJDQsAu9opvQ
	(envelope-from <netdev+bounces-303899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 01:34:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E02396F2537
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 01:34:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="n82azX/u";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303899-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303899-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54CD23022CED
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 23:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C544A3B5DED;
	Wed,  1 Jul 2026 23:34:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B2C3672A1
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 23:34:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948872; cv=none; b=Dsfsle8dNmAe2ip3pit2qPkxQuA97PLHRXkAhU4Yh2L8f1uCsSnXStnJWm30O/6bNDnShHOoBk2EvWnWwQsdULR2jHFF147VuOZOfT1OPeda/2CoPDUUFdx51RIwk2D7F/UiNz3fgBqnSQE56zy/DSAOb52uEZAcQqw39j1YA60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948872; c=relaxed/simple;
	bh=3A+v9PlEkCgIXnYBDbMOKHJCOj9Z9Q5u2bTbTOVWFsw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hZy/HQB2TAAnrIbQLDUxN080C93K8yRoBw3gGpi+FdSXgmaFFtebd/EaukANabuhvLshH3L0Wpe3gXWBbAqUNoYsXhTXjksie/CZWa7OhE2wi+C/QRZNzV7TWeb0FKQTiOOtqGJp7HE4mDacgnK3Cmx8gTSxyuNriEVvCFQH+aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n82azX/u; arc=none smtp.client-ip=74.125.224.47
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6647bc8f900so1272647d50.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 16:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782948870; x=1783553670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtqAbtIhtZzSOXRV6LwdlmrekejbfF+DR/khqYtRIKw=;
        b=n82azX/uRpsmjTzSrIQJa8DxIaqj+E8iMQBaKCh5w2+cKInzP6iZSmVmXdqv5xeKwF
         mySTCQSbniEJw5/BjIncAqWIGLWacu2/9xYV0rlXUErh2ovLGXkYMShFs3FeFG1DyeFi
         SCdR0IIrCPVK2HqYwD7B/jN1csJBYVb52XVxstQtbf33rzaa6/R3IjdcsxmoYJngzCsL
         u+TqTwrzHaSINHhbxBe5SfGx2zyXpTlJhdrc4nnOHvpXIvAQjbqdBfFbfs4QYIBB/Kk0
         QtQb5ZvJuxT8kHmUIdTk6SLffyKYsnicVz8wbzDVx+M1E+iAhSpM+0LQmdPU/Ga9yr8X
         KwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782948870; x=1783553670;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LtqAbtIhtZzSOXRV6LwdlmrekejbfF+DR/khqYtRIKw=;
        b=bqiJr+CgMtE622Gqn4rl95tZAaOX+s5KPXpAlL8YXR9ePeTXRXXSCQ2BYnomsjsEXx
         Ar30fmB7SWKUh/si2JXFiKOxC0DPPBUAknNJbQG4k61kgi7bi7xl2D5zIfJ316ZLEiRS
         pDjc3vzlRf2WdFGbnVtpSuoEg6j22EqOklVQegjtZAdhzqcIrceVDJG2Ku/+2i2VsbR3
         jyOsDzLqqhNk7ku87JqQriio5PkoZN4/lywd3ByN3wrotcT5LESZ+9yJTdJkkMBhdE6y
         ZYC7+rOzUgDveuMjjFdPYzUidD5FGbgTxtARE6cVaj+nH3R2pi8lHx6x9m6CD6deTVaU
         imUw==
X-Forwarded-Encrypted: i=1; AHgh+Ro8rAUMRFsaf7l6CSiWvrpQGixq2KlCIBhWilzXbeJFEuqIEqKi+bNtaicUj4OZh2VtoCajq8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkCJOQT8ZuZ8WvuipgmoKMjgXXH9yl/COYeG6Ub6QuI3bJBplb
	vRfnSy+IB/HTIp91AZinOmgtF7xqFbry3fYjIwADZAt2avnECwYfp2tI
X-Gm-Gg: AfdE7ckVxZ0uyQ2wLqGk3Bnud+syY7NpB6uAgUIykjO7X+fGT5sAGeV9HoYr9HmK8CQ
	hRdRbMBUMo3D97R7y7d7r6JBlI71sxQZ3goAFFkMRFZXq+++GlUSFeesD1Sl5vz0D8qRbUS9r5c
	FxkFjkbbf75fJIP9jl/SIXfQA3U+Iu1szWFkbmeP8YMYALSKF8myGTkIT/KMbIOYSTcNF1A9gg/
	9OvVU8ncxrL5lfL2ZpUQE1MmF+jgu2WxPUJDhJ/Q79NHli0KuFQZXgHOVYurBtVRNJn5WHfpwJ6
	nP/p8opbckHmh7/A0XfrrJ7CxjppwuHjKL+7dRVG9c7Z5mmHnbDneOG1fqZzrRQ/P8meDJc90uo
	wmw9duNeV+X5jhIUowl7pK6DX91WG3ETxR3Nj2CH7Umlv7rwCI3lDnmg88x8LRMje4xeTt7jlT3
	8j5OAYKiRdyNqDIVtddbHRv6i9T/rv/eMI7C/labtt+qbUwK7HyWQTXVgQVTvdGjYKgw==
X-Received: by 2002:a05:690e:1510:b0:664:c1e1:2ea6 with SMTP id 956f58d0204a3-66521cea326mr3747064d50.68.1782948870405;
        Wed, 01 Jul 2026 16:34:30 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66624021a75sm360425d50.11.2026.07.01.16.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 16:34:29 -0700 (PDT)
Date: Wed, 01 Jul 2026 19:34:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: David Lee <david.lee@trailofbits.com>, 
 david.lee@trailofbits.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1cfea9a8313a4@gmail.com>
In-Reply-To: <20260701113947.23180-1-david.lee@trailofbits.com>
References: <20260701113947.23180-1-david.lee@trailofbits.com>
Subject: Re: [PATCH net] net/packet: avoid fanout hook re-registration after
 unregister
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303899-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david.lee@trailofbits.com,m:willemdebruijn.kernel@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dominik.czarnota@trailofbits.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[trailofbits.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E02396F2537

David Lee wrote:
> packet_set_ring() temporarily detaches a socket from packet delivery while
> reconfiguring its ring. It records the previous running state, clears
> po->num, unregisters the protocol hook when needed, drops po->bind_lock,
> and later restores po->num and re-registers the hook from the saved
> was_running value.
> 
> That unlocked window can race with NETDEV_UNREGISTER. The notifier can
> observe the socket as not running, skip __unregister_prot_hook(), and
> invalidate the per-socket binding by setting po->ifindex to -1 and clearing
> po->prot_hook.dev. A one-member fanout group can still retain its shared
> fanout hook device pointer. When packet_set_ring() resumes, re-registering
> solely from the stale was_running state can re-add the fanout hook after
> the device has been unregistered.

Thanks for the report with fix.

> Treat po->ifindex == -1 as an invalidated binding after reacquiring
> po->bind_lock. Restore po->num as before, but do not re-register the hook
> if device unregister already detached the socket.

I guess key here is that po->ifindex == -1 is not the normal device
unbound state. That would be po->ifindex 0, and those sockets do need
to be restored.

So this LGTM.

The bug here is having a stale fanout->prot_hook->dev.
If this is the only socket in a fanout group then
__unregister_prot_hook calls __fanout_unlink calls
__dev_remove_pack(&f->prot_hook).

Then later __register_prot_hook calls __fanout_link and
dev_add_pack(&f->prot_hook), rather than checking po->prot_hook.dev,
which packet_notifier modified.

An alternative would be for __fanout_link to check

@@ -1518,7 +1518,8 @@ static void __fanout_link(struct sock *sk, struct packet_sock *po)
        rcu_assign_pointer(f->arr[f->num_members], sk);
        smp_wmb();
        f->num_members++;
-       if (f->num_members == 1)
+       if (f->num_members == 1 &&
+           f->prot_hook.dev == po->prot_hook.dev)
                dev_add_pack(&f->prot_hook);
        spin_unlock(&f->lock);
 }

This condition is true when the group is created and checked on every
socket joining the group.

Or even simpler

+       if (f->num_members == 1 && READ_ONCE(po->ifindex) != -1)

But as said the patch as shared should work too.

Patches to net need a Fixes tag:

Fixes: dc99f600698d ("packet: Add fanout support.")
 
> Signed-off-by: Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>

I'm not entirely sure what the policy on nicknames is. But at best it
is uncommon. Consider dropping.

> Assisted-by: Codex:gpt-5
> ---
> Bug found and triaged by David Lee from Trail of Bits.

Instead, a Reported-by tag?

> Trail of Bits has a PoC that achieves local privilege escalation using this
> bug on a custom kernel config with CONFIG_LIST_HARDENED disabled, which can
> be shared further if needed.
> 
>  net/packet/af_packet.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 8e6f3a734ba0..000000000000 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -4561,7 +4561,11 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
>  
>  	spin_lock(&po->bind_lock);
>  	WRITE_ONCE(po->num, num);
> -	if (was_running)
> +	/*
> +	 * NETDEV_UNREGISTER may have invalidated the binding while bind_lock
> +	 * was dropped above.  Do not re-add a fanout hook to a dead device.
> +	 */
> +	if (was_running && READ_ONCE(po->ifindex) != -1)
>  		register_prot_hook(sk);
>  
>  	spin_unlock(&po->bind_lock);
> -- 
> 2.43.0
x


