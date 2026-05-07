Return-Path: <netdev+bounces-285380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNz7BWus/GkNSgAAu9opvQ
	(envelope-from <netdev+bounces-285380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:14:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 994FE4EADD0
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 673F23008E20
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522324014A0;
	Thu,  7 May 2026 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmoDDOHS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2CD43D501
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778166887; cv=none; b=tHnV6y3YnCjM9hNrLVGmClI40L0w7WJXAk/5f5ERt40hp4pJIDVXM1wD03uy90TW75yl4BAdX4A1ZKsDnqMm6U2hq5N0onm1pp4NpEvD5awBfNUgKWzTUxeASc+9cMUyL2oggl2NrEarmJ4mg1V+PmJdslboe5uF9GuKYsXUajU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778166887; c=relaxed/simple;
	bh=oySXrSYtbFOtahaO6ajCsXz2ZpbBeZvkAh1wEowghhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C487+yUkziF7hntRo+YSmDUcPaPpehQ8hXX9MxrHjXHGJGZtJL/5GSHXq/btLVEdxpGqAxQw2gKg/7Jq+Y4rDCdX3lRKj2KOLLlp4y57lD3jsijtzcq1bjcX299ier0wVAoosCJmReP8SoMUQEZCY7hJGt07z4T7q3XkQYSeGSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmoDDOHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D93CC2BCB8;
	Thu,  7 May 2026 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778166886;
	bh=oySXrSYtbFOtahaO6ajCsXz2ZpbBeZvkAh1wEowghhg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CmoDDOHSAj/qntFkc1bHKd/kSiodEvVGFlOE9DUaN9FxJEgRubtkzwBQ/UzaSgkb5
	 b91+RiF/BL20g2SGYf8mTj1J1ClctYgO+5iT9b+kvUwJvT2At5nEi5LwqJ/xi7fYSM
	 fIqHdQdjdgHD2tHlSmgGZCZFsabzAs9XT2NenEvVzlmfXHaqKYgIyEzEy1qI929UUn
	 AYpkZJ/dUaRHsuRiuyivxNaGLfLb4mYVLrkx83XqIGYGSqteN4x3Z0YhZBOA/OID2f
	 pk0FdipimQ2YsnHogvdfCPSzVrPvQKmCmE0dZAFgqMA8+5sQ/ks3I08n9AeXgr3YGl
	 T+f5iJT1zEckA==
Message-ID: <92000819-e8c1-41ff-aef8-aeb587cb4dae@kernel.org>
Date: Thu, 7 May 2026 09:14:46 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] ipv6: use SKB_DROP_REASON_IP_OUTNOROUTES in
 inet6_csk_xmit()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260507084305.2506115-1-edumazet@google.com>
 <20260507084305.2506115-4-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260507084305.2506115-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 994FE4EADD0
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
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-285380-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/26 2:43 AM, Eric Dumazet wrote:
> Replace a bare kfree_skb() with a modern sk_skb_reason_drop() call,
> and provide IP_OUTNOROUTES drop reason.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/inet6_connection_sock.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



