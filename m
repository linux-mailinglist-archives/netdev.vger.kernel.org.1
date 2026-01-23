Return-Path: <netdev+bounces-252920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GORgL7S6c2kmyQAAu9opvQ
	(envelope-from <netdev+bounces-252920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:15:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C9479716
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 453C03072217
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C464827B32B;
	Fri, 23 Jan 2026 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjJ79uyN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12F21E32D6;
	Fri, 23 Jan 2026 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192007; cv=none; b=YiXvzUKQBZhsSIplHZuG7UuTFTOlDNTxs1xTDwERedcn3afiFKabBRwL1WYxZl3lPU+ZCTt/norUyDBIglM/GLAGMiC9Ajn6AyQsV+rLzgP01toHW+wTQFkmepssuhPOzMkugyLYWEn4uPrvjDh3SesZ0R6dqFCYEEjFGgKR0Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192007; c=relaxed/simple;
	bh=Qb5pTYY+wxtVDMa7PSXSD//NAirJ94OSIyTPWOsADUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oz1g3gwzPoTNK04Y61cCUVYrRQs1ByXOdtzMG9Uw9gf09VOkTw0Rn3d+50WC956vIJ/hBrQHuNJ7HFlREUNeslMhuS0MkGrWlej8DTsaGQ+4/vMWxK3qA+dw8dAaps0cqljZ23BuXPu9H7n64qgjKLsumObS0RYhLJ3kSNoKDVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjJ79uyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2730C4CEF1;
	Fri, 23 Jan 2026 18:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769192007;
	bh=Qb5pTYY+wxtVDMa7PSXSD//NAirJ94OSIyTPWOsADUo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kjJ79uyNlvI+yCXJpawWv9gN2PuvejKtyUYh5x95jZPuq5IBqyy3OFYGaSgDWgdl5
	 n1D0gPaBeZCFH+bZFt2Xt7gPNBLaTywwUOwF+QaLr5lNrfGMJTWnDAu9w6imGAvRuq
	 P82sWgh8X+NFzHu0FOKpEaKfJXddvy1RmAtletviU1S6AfmjoJZLZys7KyYyNq36Yh
	 tjkdt1x9wL8MT6+mHevE/XKgFvepxpWH4wNuOukYjxlCpTjmadw1I4Xyco9htqe39l
	 +dHAac9lTmRwaEgHtHCowSIlNwM7dNwDt+mAFCCJ6X5tZjc4q0jSOIeA9elas5WCjl
	 vn4swgIKg6JbA==
Message-ID: <a918d777-36e7-4904-beaf-954455a29e92@kernel.org>
Date: Fri, 23 Jan 2026 11:13:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 net-next v3] ipv6: use the right ifindex when replying
 to icmpv6 from localhost
Content-Language: en-US
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 haleyb.dev@gmail.com
References: <20260121194409.6749-1-fmancera@suse.de>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260121194409.6749-1-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-252920-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 37C9479716
X-Rspamd-Action: no action

On 1/21/26 12:44 PM, Fernando Fernandez Mancera wrote:
> When replying to a ICMPv6 echo request that comes from localhost address
> the right output ifindex is 1 (lo) and not rt6i_idev dev index. Use the
> skb device ifindex instead. This fixes pinging to a local address from
> localhost source address.
> 
> $ ping6 -I ::1 2001:1:1::2 -c 3
> PING 2001:1:1::2 (2001:1:1::2) from ::1 : 56 data bytes
> 64 bytes from 2001:1:1::2: icmp_seq=1 ttl=64 time=0.037 ms
> 64 bytes from 2001:1:1::2: icmp_seq=2 ttl=64 time=0.069 ms
> 64 bytes from 2001:1:1::2: icmp_seq=3 ttl=64 time=0.122 ms
> 
> 2001:1:1::2 ping statistics
> 3 packets transmitted, 3 received, 0% packet loss, time 2032ms
> rtt min/avg/max/mdev = 0.037/0.076/0.122/0.035 ms
> 
> Fixes: 1b70d792cf67 ("ipv6: Use rt6i_idev index for echo replies to a local address")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> v2: no changes
> v3: use ipv6_addr_loopback() as it is more efficient
> ---
>  net/ipv6/icmp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>


