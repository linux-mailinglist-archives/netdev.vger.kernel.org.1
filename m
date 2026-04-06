Return-Path: <netdev+bounces-275507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KYLuAV0a02moeQcAu9opvQ
	(envelope-from <netdev+bounces-275507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 04:28:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5169B3A1240
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 04:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C0CB3006B0C
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 02:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DCC311977;
	Mon,  6 Apr 2026 02:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guEgBTGJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8E42264A8
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 02:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775442519; cv=none; b=nlhNcMRPrqGBYV7gj3bfajwCK1jxNihO0lGNDXh6AndDW/9EcQBlM76xtQ5rZ/Gf8cBuNLurHzQXCzfkSDTZZWogYYAJkFTP65cHTn9hKbs6C0+SDN2ycpGE2VTFT4/57W1xB31HiPk5MbeRUIZ2U6fCVZ2kWV6+195pxeIY/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775442519; c=relaxed/simple;
	bh=gPhK7Alr55S45PmV98K6LP+ammYGOm16NrIMAbQUiA8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ecpcCPnjMV/UwZdxWKXxPR2qpjw4Pf9cXEb0dBlKsvTxfadYYYLep1sQG/IHFJVJsB4k56M2GCG1zYE9+QDclN08pQqRaPtrC+jadp3Fnex0HRCrLGfGKW/0G6Z6xxpHNfTJPmC7QXdnIQEWUT62uzF3gfndYE6+0X4G+ZQd9ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guEgBTGJ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7a4f9cf2b4eso16867927b3.3
        for <netdev@vger.kernel.org>; Sun, 05 Apr 2026 19:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775442517; x=1776047317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5c0HNGgHv3b1xvu0EqDfMupLPT0WGKpfbbK/oIqVuJk=;
        b=guEgBTGJDFeKBdq1LqjV5VDxRFn752dUucGfBs6adA8nhv5IyicPb6grmY7SB3D2Ak
         Xu2soZJRzSf3XP2mBQZEb1WDYinT+AQ0TRTsh5c4VnVPzHtaQGbOWpA/queBR66m+GLD
         ANn+wN7YKLUw1JK82gvJljPTSdAd8TbEBOb0zcO9KcPjDItlcLcK0G4yKCIejpX23X21
         Aq7lF/eUtJ9Ljl5MyTzvAfxTJLCPS/QCGWvHH/vMC9IpWJ7bfEk3KNnhtDLy+ubFONvZ
         5nsWIqSCqJ7N4mlPOOq5ohtdEYCIS1hvo8DH/qazRDKiX3hY57oFm723zngyIwgWe72j
         4GjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775442517; x=1776047317;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5c0HNGgHv3b1xvu0EqDfMupLPT0WGKpfbbK/oIqVuJk=;
        b=VhAoV6g0iy6RaYXtQ/K3j2OxjcDVQZEDb+T94X4cHpuezu8fN+k71XCXop/2pv8AJa
         jVvv+xf8Qn1L0snqMDwuXs6JHRUy+N9hymxEgBOzBf4H07GC1pEdCmatnqI4BLzIJrv/
         teypHyzLbnX7FNZ4x4mGkIMH+aw7XT8Rj5igMPtL16j7d2BkZjtkJk24REbP7ibeCOLA
         Vb5xZiulEMXnFDUh14tBAHATk4/9vulrMipgoc2zfu0UdgbJMF6xEFaMhwtg3O+5DPTV
         iJjGltNMNuyas+SgUmciax5hO/cQzEyGWvq+DimAlozvGW5xnD7Lsz5v1hUCFyIKLJco
         J7fA==
X-Gm-Message-State: AOJu0YwJ+O9Eyz2Gu9Bt/gqlUUf7aSkshbyo9QbQg4iOT1m5VsVO2E72
	/R2NDjvktB5dBR8GPc27ahP/YE8UvbHextGSHkAk/jOdzyGUXgV5ygI/
X-Gm-Gg: AeBDieuaOyZUiaq+HYyqgBNoEsCRHKb808MMp3csBgt5EvqDRBLZbXjoWTI8+V6gHna
	KIan4VSD+EqcGfxlEto8q8cCiTHvLcmYyBOWx6Ym9mgHd+jxyZtTJr30VH4L35hG+A0jr5FLYhH
	sf6pA9aESxnrTjoqhCDOPTYVDoDBxQ4GRS2PmdxXkYzVfOD8Fx2fodp6niKFhHypS2AX3g+uMXI
	NpPstW0wxfrahxa8HFRtgfh4NO20b9tXZSB0mC76BK+zRKHQZVniAXfuR50lNd4YAvw27zPvLLy
	EW1dbri+Nw0I/vl0rxVDK6jJEKkt1T1nzt/eDU6A4TXPTZoXhZLIAWNP9/TqlS2/TSa0QwuSb+j
	oRCAoebmRkjGxBVANas133dBtB1EUYHmSi3MzMaRXowgYSSqEuFRiPvb9HpLvyMjXSPor7aYtf5
	7+EBtqLcYC7oDPleQmOJhX70sr5EY3mDnahKhWQCN8hrxFgJv/ZwCegc1rwOp7YT1Pc4cwnWqTf
	zZ2
X-Received: by 2002:a05:690c:660e:b0:79e:1fe4:80d7 with SMTP id 00721157ae682-7a4d5d5d907mr104832267b3.48.1775442517236;
        Sun, 05 Apr 2026 19:28:37 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370ef4af8sm48861247b3.41.2026.04.05.19.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 19:28:36 -0700 (PDT)
Date: Sun, 05 Apr 2026 22:28:35 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 willemb@google.com, 
 martin.lau@kernel.org
Cc: netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>, 
 Yushan Zhou <katrinzhou@tencent.com>
Message-ID: <willemdebruijn.kernel.2ff565d2f9e7f@gmail.com>
In-Reply-To: <20260404150452.83904-4-kerneljasonxing@gmail.com>
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <20260404150452.83904-4-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v2 3/4] bpf-timestamp: keep track of the skb when
 wait_for_space occurs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275507-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5169B3A1240
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The patch is the 1/2 part of push-level granularity feature.
> 
> Tag the skb in tcp_sendmsg_locked() when wait_for_space occurs even
> though it might not carry the last byte of the sendmsg.
> 
> Prior to the patch, BPF timestamping cannot cover this case:
> The following steps reproduce this:
> 1) skb A is the current last skb before entering wait_for_space process
> 2) tcp_push() pushes A without any tag
> 3) A is transmitted from TCP to driver without putting any skb carrying
>    timestamps in the error queue, like SCHED, DRV/HARDWARE.
> 4) sk_stream_wait_memory() sleeps for a while and then returns with an
>    error code. Note that the socket lock is released.
> 5) skb A finally gets acked and removed from the rtx queue.
> 6) continue with the rest of tcp_sendmsg_locked(): it will jump to(goto)
>    'do_error' label and then 'out' label.
> 7) at this moment, skb A turns out to be the last one in this send
>    syscall, and miss the following tcp_bpf_tx_timestamp() opportunity
>    before the final tcp_push()
> 8) BPF script fails to see any timestamps this time
> 
> Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/ipv4/tcp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index c603b90057f6..7d030a11d004 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1400,9 +1400,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  wait_for_space:
>  		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>  		tcp_remove_empty_skb(sk);
> -		if (copied)
> +		if (copied) {
> +			tcp_bpf_tx_timestamp(sk);
>  			tcp_push(sk, flags & ~MSG_MORE, mss_now,
>  				 TCP_NAGLE_PUSH, size_goal);

Now the number of skbs that will be tracked will be unpredictable,
varying based on memory pressure.

That sounds hard to use to me. Especially if these extra pushes
cannot be identified as such.

Perhaps if all skbs from the same sendmsg call can be identified,
that would help explain pattern in data resulting from these
uncommon extra data points.

> +		}
>  
>  		err = sk_stream_wait_memory(sk, &timeo);
>  		if (err != 0)
> -- 
> 2.41.3
> 



