Return-Path: <netdev+bounces-285379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMuJDAqt/GkNSgAAu9opvQ
	(envelope-from <netdev+bounces-285379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:17:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC1D4EAE0F
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA8B33010533
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2DA436373;
	Thu,  7 May 2026 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pN9ss4it"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED1F3BED55
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778166876; cv=none; b=WQvl5612hzxndPj7Yxon3n01P0t6y6zm35s9fTIferihThiDebD8wxuHo/FB+Ls/hxvAE1s3rmdgINJWuxyr3XRY/NqRpS9FQGKfMRj+qcdxPMaunj2uPhlCVIY1hRj9WgihgXDrSfS016VC8t/6Vfi55FyRj74zQcHhaGrolfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778166876; c=relaxed/simple;
	bh=f80M2eJbQJzvup1oanbfrr4PZIZvV3WLjabvFi6dl0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJHdV9C0ZOjwFjEv4Qsg2YDgSBb/z5sTLxN6JQZk9nXD/HG4xcDa7two0teAzJoZ64GZI56jj43NK9XB6ryPWAZVmOx9BM98TUQc0SAlmVz7Hmkk1hfOSV1CXPnKt2S22ki3eIL+w3bMU7/hpClZfraEW6IAILyr3HNbxi0W2+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pN9ss4it; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63F3C2BCC4;
	Thu,  7 May 2026 15:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778166876;
	bh=f80M2eJbQJzvup1oanbfrr4PZIZvV3WLjabvFi6dl0A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pN9ss4itybrXYR5v1+l7RCeercza4GjsL0jy4hKEF0/N5AN7jKPmkuQmr/7A0+4WF
	 p7qeGVxfxD+03WIEprI8LwNq1We/1DE4VnIZyhQOJvj4f5qlGXmkAhikOPYZSvRZ4K
	 ULq975Jjvi7l/TWqMyLO8dXVryc0I/r/pfPQuRrCeSC25tNK7YCMXa/kSvAmJK1erS
	 NZkjxOfCJqWG6uCjlw2VmdcjHEeG3sHLFnq3DVsgJgsnEX9ssV3nlT/KaO3JPgtMCf
	 1L4FbaBXQziGKpzgMIkBDz6S3ybXcsWVo4xFfOwzNRKz0csPbH+h8xVTlulOrvgWDG
	 nN7gpI8B5xU+A==
Message-ID: <0f84ce78-f791-4dda-a9e4-07e2495a8757@kernel.org>
Date: Thu, 7 May 2026 09:14:35 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] tcp: use SKB_DROP_REASON_IP_OUTNOROUTES in
 tcp_v6_send_response()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260507084305.2506115-1-edumazet@google.com>
 <20260507084305.2506115-3-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260507084305.2506115-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BFC1D4EAE0F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-285379-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/26 2:43 AM, Eric Dumazet wrote:
> Replace a bare kfree_skb() with a modern sk_skb_reason_drop() call,
> and provide IP_OUTNOROUTES drop reason.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/tcp_ipv6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>



