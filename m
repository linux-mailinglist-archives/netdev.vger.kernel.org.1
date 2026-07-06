Return-Path: <netdev+bounces-305177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q6MzI9r0S2q5dgEAu9opvQ
	(envelope-from <netdev+bounces-305177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:32:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D70E87148B8
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:32:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fEQ2pZpX;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305177-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305177-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 256D8362F87F
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 17:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AF73A380F;
	Mon,  6 Jul 2026 17:35:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33543B2FD6
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 17:35:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359327; cv=none; b=L19rnpKkk4+Pr/Gt7kT+6B8NY/+XLObFgiO865LmqcMqyRfyAAM6Ab+MaIN0BAfDbpvrJel0H4mIncummLUE5LQLI33R4/L9aGAuDEYrvsguW4TOwy7L7tLpAR6kfEXiSnJinyp+LFcuWQPggE0s7ScHW/xFczizuUqJdyp/Akc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359327; c=relaxed/simple;
	bh=XyJ6/jCk0lvpWQQi1qBmAqNhDAOjnyk1oXshJsoZz0Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=a0BviSSvoQIh51fX4T88NS3RJ6BxQLGAlud8btfPKWO6+JdOXGoXDRvWPyNWczfzeUF5Yk/fRdet2q8tFhmznq1Rd5UekO5XA2e40NE6uZrtcLXY3UGosI7+n45l4p/ZFLt22arSMnhsZZBjTkWBBfC/R0+m/hNwA7Eqj5WwbII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEQ2pZpX; arc=none smtp.client-ip=209.85.128.172
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7dbcb505578so27550277b3.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 10:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783359325; x=1783964125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9PYIrjiLcLJRMsJz3MN9nJHHGWlJH+U5Otv0B9TwQZQ=;
        b=fEQ2pZpXIdC93SrHgHXDogxfxhKgqG/cmqzIgJhpUq1TjxF9C/SabN0AvV76Yxsj65
         MySJtqHULhCUozAUCxQf3eSywksLKLjSOBvivOKNuFslS0eMyBKaDZ2ejRtNce1zW9fU
         +vpNvIcazHfHaHj/OMohzbNhiWZV4jIkQ3KRNd2nUVXSNp5LqTkKma4NtFIa2bY7T7ui
         1i8hWeDRDq8RH8wicPlEKpftFisZe07CPwP21MU7B7oLkIreV9cheH/+yfpcqLL7i+NI
         b0gBNmGkZ+0BNIP3PQuA+uWM95CdsjuuCvDIAlwLpZCzx7v0Ocx4w5qL/PqvFkw+JPmV
         lj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783359325; x=1783964125;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9PYIrjiLcLJRMsJz3MN9nJHHGWlJH+U5Otv0B9TwQZQ=;
        b=MhdEt0CugUg27gqmlnF8sQ5rC+PbmEgUziChlMTsbz+PVAGGg2HNcjnCulCtwe/jiQ
         Dk7Z8Bu9erwHvAc4qHWQ6MEHEA+pKi/pwBnesgthTY/D+8xU3gjy14BJaXNrFmiGJjNF
         4rz/TqnzIfh4JgTI8wyaF6PhRSgNZDVB0DjLAkUZEVkkyeYxAKTBkn/bceJXIG3ikkgX
         sZKTNTSk9goMc6/lXM8P54FGeC1wUyOjdMcwxqzP/KOB4HRD70GF6RXHRIxZj0pS8O5o
         e7xkrsEkEvC0cdaqGRWUa52p6f0RzHE9sOqyedq7kAxG5f8uc+Ex7boRDwqbEE6W2D+3
         r2Rw==
X-Forwarded-Encrypted: i=1; AHgh+RpjM0lEh2FpZwI9AJ5Nnt+xomTARHAYSJ1PrBGF0JFOHwNQGtVel5s3fAimoewx5FNqzTIyiiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhHYTQAlz/mXexlxH3ektEIa120Ub+mpYKlQKVwvMaU0/BDjlj
	56jKB4DzI5/AZsThLjfQoa1u0XSgwR2juyS0mvvFe2dct1nTbbljjVMU
X-Gm-Gg: AfdE7ckVgLiVfEnOGxjr5yaEs/hGJYZiD+BvhqWAIXqKiZySBrc/SYrTKK/jW4O2vzD
	sL6HtnOsbNJESaBwRhY+1a4omEYeoPN6u+l81wLv4xd7q5mnXg9tXJvyTamLQAXGVAuWWhZy9s9
	9NcAkU1W70HAR6pAFlU9E689gtEJt4Mk3U5c+M3hYd2UY1Adyppks1M3BJc1LisuJ7WwAYXfDUm
	aqYpvGJmnKBqBZNONk9H9W0nt1RCYU871o5M+14m7ORACn3shOkbvA6N2OlbWpXfn9TNuUMhpiO
	1X7/hcmFaj6gA9rZzeMNQJiC4iJgXyXl/nXnHz8VzKsgyvwsbumooVsPRm6RWpfIm1Rg+WGNoAu
	6osLx2M9WzVpIoR73XUjJy2KMCdKsfFyq97QT/FZjSK8VjdSloARnthav1oOLDt3IXXm/wKfIKh
	+oycvPWfEVbTxUxcVUwLYkmiwkI1it9+ZKLLB8Wm08ZsSNgxfV3dOiwsRIPGjSYq2MuQ==
X-Received: by 2002:a05:690c:62c8:b0:7dd:3f36:59f1 with SMTP id 00721157ae682-81be319d964mr10253497b3.45.1783359324738;
        Mon, 06 Jul 2026 10:35:24 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144783cc7fsm60947197b3.5.2026.07.06.10.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:35:24 -0700 (PDT)
Date: Mon, 06 Jul 2026 13:35:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: David Lee <david.lee@trailofbits.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: David Lee <david.lee@trailofbits.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.31a7e80dcad9d@gmail.com>
In-Reply-To: <20260706111226.309506-1-david.lee@trailofbits.com>
References: <20260706111226.309506-1-david.lee@trailofbits.com>
Subject: Re: [PATCH net v2] packet: avoid re-registering fanout hook after
 device unregister
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305177-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david.lee@trailofbits.com,m:willemdebruijn.kernel@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dominik.czarnota@trailofbits.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D70E87148B8

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
> 
> Treat po->ifindex == -1 as an invalidated binding after reacquiring
> po->bind_lock. Restore po->num as before, but do not re-register the hook
> if device unregister already detached the socket.
> 
> Fixes: dc99f600698d ("packet: Add fanout support.")
> Reported-by: David Lee <david.lee@trailofbits.com>
> Signed-off-by: David Lee <david.lee@trailofbits.com>

My suggestion of a Reported-by was becaused the Signed-off-by was from
a different author. Both tags from the same author is generally
discouraged.

Perhaps also add a Link to the discussion in the first patch, which
adds some more rationale. The crux to me is that ifindex -1 is not
just the default for detached sockets, it is a special invalidated
condition.

Link: https://lore.kernel.org/netdev/20260701113947.23180-1-david.lee@trailofbits.com/

With those asides

Reviewed-by: Willem de Bruijn <willemb@google.com>


> Assisted-by: Codex:gpt-5
> ---
> Changes in v2:
> - Add Fixes and Reported-by tags.
> - Fix the incorrect Signed-off-by tag from v1.
> 
> Trail of Bits has a PoC that achieves local privilege escalation using this
> bug on a custom kernel config with CONFIG_LIST_HARDENED disabled, which can
> be shared further if needed.
> 
>  net/packet/af_packet.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
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



