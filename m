Return-Path: <netdev+bounces-282860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKWeDklZ82lfzwEAu9opvQ
	(envelope-from <netdev+bounces-282860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:29:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7684A3741
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA393301DBA8
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164BA426685;
	Thu, 30 Apr 2026 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Qpzcb/p0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5389A221721
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777555686; cv=none; b=rpueilsPDOG6haNh5uZfKg3oQIeziuYzjZrlZebAu1DN1Bp9y5AkQXROo0G0VTVyipR2ex3YLzMP6zRdTgdl7NR7YXsBys2Y6nyxMA2U26MKhDql9ggrpJPO1e87KaJqidSAO88nYU81M+2cYNE1f4JmOD14snecoDeukYHIoLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777555686; c=relaxed/simple;
	bh=BNjL3KCDv3Vt3Xb9vPDyOemAe6pw/wown2fn6apfdvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z3Bx/nrIerBdqLmX/jBu6rA7AJiDS5YdHbctIPNhvKEj6+lf20Gh5VtI4VszzU8gIcHm/j+OTanNh/tQzvhLxcrGfZUbJvvOFchuB7+S7ziYoukjsT9ufIxE3hySMw4TOFkxMaqQVcI/2yZHgo169r4dYMvQsKxbltV0Y5nvgtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Qpzcb/p0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso8709775e9.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 06:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1777555682; x=1778160482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G8A7kgcf3kl0J9IDlld32ryeTm5EVypaG3YrBJJ62LE=;
        b=Qpzcb/p0nyY2UnsrbfkT+MLGrSVuXkHXY8KMpOO27wpcFiMBgopXqDtXOmFMtRsFiB
         ABlhlWcVAuvwaNsRVQJJEpFJ/AaFmVc5Mege6GpSvTCtAzjdzfWXhZ1f+hM+LOo8dCSn
         by2ER3aExy7uKf6EdmlIswlPzcSB5pAQ1B5/NFgxicgHFU3kRRIra/57WcRhHsrHm+CQ
         C853StaSRGcPYZYmrRvmc/e8DWnmDZnYWkKF6lhjKzKCUeeoo44+p16vIHLTVbDpi+Vp
         2A8G3EqzN0Vlq0kO6HeeB4dhhOPrEZtjsNRtfMOkN6sjobg0GUXgTN7V5zYduaOD/QUF
         TABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777555682; x=1778160482;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8A7kgcf3kl0J9IDlld32ryeTm5EVypaG3YrBJJ62LE=;
        b=NX3iSpcWZ/rxbnmvFFbvuUkJRNflDVLFnP7Ag5AlIoYxA9Op3mw8TTy4ZT9E3cIAvA
         kIMsb9BiorpiWgmxZBh9RciI5zBDeZtNpcnL2haSKF67sDpAJAL0s7Dsc4fX8cJ1QSiC
         N8MpphAFndbNlZGfXrg2TnhSOHllIR8/J6yHBTPQtBR+2I7dkQy04XbEnw+KyKrPEBqJ
         ZTnMhuWdMiTy8WW7d/jWuD1AGsvfiLlzPJDfxiRPiITPNaxU7B3Q7+vWgwg0NVxoZcBt
         UdAosh7B1PeRxhmhLI+dxjxZIeUMze+JtXA3iYAcdUz+89U0CokPmcevDNUlbEhgFn5m
         i19Q==
X-Gm-Message-State: AOJu0YwRzWqcCQ/rjjzy4Mv6cA70545yx5pr2d9uLwjsvd9HRSovIF0O
	hhpy/4AjdIiP/ojLqgFpZ7VCdT4l8TMr8T2awQERCkFvr2cmque11FRSovznRsBNWmpmicqHxH4
	UXjsNUesjQizOsvu+cqpnzZw/laRzRSqQ8F8xvZliIKA+DsoPxGG22iDkwktHvHVf/EU=
X-Gm-Gg: AeBDies9/ASINakl5ijTKoPTTXr+6S5Igrnf4G/3x72vM//rUppILzZ0gEuGhKf9r7I
	PCns/z85UJRrC0upGA5skpCGvDked6KtXAkNuUf97slakmFRrVvfqCNcpJHvBL8Chkbeog26o3X
	V3rxxErH6JeSRb7F5W8qHhqXLZ5Krt2j50G39sUs2iYDoUyVrAFUu4ZhLzxinc3nDQiwavQwPpl
	RBE2722KUmnk7PNtZpzMxqtDS+kpNNsFrQ05S4fBjCQUehBvQK31p5YT1gsQ9yv1anKNYnHDDoD
	sGpUXXBpaVngq25DzXC7bpaRBteavMTR8+IbGa6havnCC22PQNd/rN2VxB91yw4Js17VXW4baA0
	jn+8jtSwOkoAaw4xtXxso9e2DQ0txg0DdTKkw9oSBiXKyJY1q/Lqa12FlBM7m4vxOElrRXH2FFI
	Zv/i99t9RBucqUzu6uiVhMj8Qu72HWbmcQ0G6faoPDrJE8/2EGWg4cSTPbuvLqeIy5yTIfUZpa
X-Received: by 2002:a05:600c:1f8e:b0:488:a824:fe04 with SMTP id 5b1f17b1804b1-48a8447f466mr45690915e9.26.1777555682188;
        Thu, 30 Apr 2026 06:28:02 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:2493:6197:23ff:7e65? ([2001:67c:2fbc:1:2493:6197:23ff:7e65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-449f11318afsm1247884f8f.20.2026.04.30.06.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 06:28:01 -0700 (PDT)
Message-ID: <5b281966-c278-46d5-ade0-9dc24175de6e@openvpn.net>
Date: Thu, 30 Apr 2026 15:28:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] ovpn: ensure gro_cells_receive() is invoked with
 BH disabled
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: ralf@mandelbit.com, Sabrina Dubroca <sd@queasysnail.net>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20260429120120.514491-1-antonio@openvpn.net>
 <20260429120120.514491-3-antonio@openvpn.net>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20260429120120.514491-3-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AC7684A3741
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-282860-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvpn.net:dkim,openvpn.net:mid]

Hi Jakub,

sashiko came back with an interesting review of the per-cpu stats update 
in the surrounding code.

As far as I can tell its explanation makes sense, but I am no per-cpu 
expert.

IIUC it basically says that if gro_cells_receive() is invoked with 
bottom halves disabled, the following dev_dstats_rx_add() should be too 
to avoid deadlocks and corruptions.

See below:

On 29/04/2026 14:01, Antonio Quartulli wrote:
> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index d92bb87be2b2..c0fdb9504241 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -91,7 +91,13 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
>   
>   	/* cause packet to be "received" by the interface */
>   	pkt_len = skb->len;
> +	/* we may get here in process context in case of TCP connections,
> +	 * therefore we have to disable BHs to ensure gro_cells_receive()
> +	 * doesn't enter deadlock
> +	 */
> +	local_bh_disable();
>   	ret = gro_cells_receive(&peer->ovpn->gro_cells, skb);
> +	local_bh_enable();
>   	if (likely(ret == NET_RX_SUCCESS)) {
>   		/* update RX stats with the size of decrypted packet */
>   		ovpn_peer_stats_increment_rx(&peer->vpn_stats, pkt_len);
 >>		dev_dstats_rx_add(peer->ovpn->dev...) << not visible in the diff, 
but it's here

from sashiko:

Can this lead to seqcount deadlocks and stat corruption since
dev_dstats_rx_add() is executed with preemption and bottom-halves enabled?
dev_dstats_rx_add() operates on per-CPU statistics and protects 64-bit
updates with a sequence counter (u64_stats_update_begin()). When called
from process context with BH enabled, on 64-bit systems, this_cpu_ptr()
is evaluated with preemption enabled. If the task is migrated mid-update,
it risks cross-CPU stat corruption.
On 32-bit systems, u64_stats_update_begin() disables preemption but not
bottom-halves. If a softirq (e.g., a concurrent UDP packet reception)
interrupts the process context and calls dev_dstats_rx_add() for the same
interface, it will re-enter the seqcount writer lock on the exact same CPU.
This corrupts the sequence counter, causing readers to see an unlocked
sequence during active writes, leading to torn reads and corrupted stats.
Should local_bh_enable() be moved after the statistics updates to ensure
the entire per-CPU update is atomic with respect to softirqs?


Do you have an opinion?

Thanks a lot.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


