Return-Path: <netdev+bounces-305246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EwZqEaRATGpgiQEAu9opvQ
	(envelope-from <netdev+bounces-305246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 01:56:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E683716623
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 01:56:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=WxudDf7m;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305246-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305246-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D4143009F9B
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 23:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFEE3E7BCC;
	Mon,  6 Jul 2026 23:56:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191113E51F7
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 23:56:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783382177; cv=none; b=gHanpb9Q5j/Ir+ouQLTdvGEPD3Ps/yiO46busbIx7nRfKkjHn+w/qDlGDTxMMm9sJipnVgVciTdqLFG4ECO08qbBhR44oHR4TC0Dc1CnWiR+rJIu7LGwGa89ajcRVu4hdfH161dpFnOvr+SIykEJlNre/VMyPiQmKVW6SX26OKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783382177; c=relaxed/simple;
	bh=fjhjUrbg0dbl3QNBKXGFSr6GLHpnEjxhkTkfxY3c7do=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pIMFCz02s+hbaB+Y5u/ODC2FWcG0KfmVnDLu8Vi3zmgKy3QKXrvQYdwHiYPA8CWUOeXDoNtgBvVZEdtYyrLQDuBNRQnDhxqHvGGOg3454byipi+69srkVBWT3y53yldDThhED2RPiwk6OFyJ9HiaS8sXhbrhZZAxWixI33Lp8I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WxudDf7m; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8479c6c6cbeso3328993b3a.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 16:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783382175; x=1783986975; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MBkL2yG861bGhxRBLJpA3iWreE5MvCSJqjthPcg/0Cs=;
        b=WxudDf7m3pnhD2iFHriqBzn4+x/sptIOLb/xiyZSA8BxsGwasnMSjsUdk2ootvAx8C
         4R4hdLzKokz2gymG3JhmorZ+SHtA9h8WbOaWSS+ydJ5XQ7zPoll3fDdbMfFiZx6ostPL
         QZxN8XEPCJWNXtwElWmR8LSuQgRXvoDCevRcwgotj13XTnzhVp76Mz271XX+XCd4dtQa
         EXLPDzuvIqpHk3stkYtUbJwAtw275fDYWCY2V0/7PKea7A0sZEraMN9HFRQ+LOQrTAQl
         Krbbytx1pl7WAz2xtC/4bgR36R9z9iegnBtnDATTYy/fPx1zk0+sstSjb/J+yYFaA1ej
         ZE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783382175; x=1783986975;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MBkL2yG861bGhxRBLJpA3iWreE5MvCSJqjthPcg/0Cs=;
        b=qPKSQZFBRIVEMJyS7lBR8/etv34NJCA/9/ilwpqPTLadmGPy0A7461941A4lyKsqN/
         Q4g3oCOI7Ieq3oag148rI//Pq3wUPx/OtJA9hJi1L7FDYJIwvlCJwrc3pjylgFeHkPuW
         pRGkAKuAh0R36AEOQIECLuZ5QHTfE57m1uZY2bOD8me16pEQnCK3QYbiT5YproBZJEga
         pNqyuSIR0ZfNZYw4uVBElBaubPRtw50wdpHuR22qM+CXWHfAtNrDvt6DJMyzEVtj63cf
         GBsWOsYd7H1vNzA4VXREiDbd6ClhsJ0lcJVy4cHmKaEqoCUH1wQH0DdTvZSrRNUtWTsK
         VYpg==
X-Forwarded-Encrypted: i=1; AHgh+RpQ8veldshArtWSOsIngMY8+FuLfxhjDOo9glLpfU3OBmsBMdhP/fZ21YMz3x5LUoOO9PQi6xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRZVivrMWD5/iE3OxBm6G7qrSkWS+WjjhfdzZEIAbUWmuZTGQV
	cm+IgQxZSmqtBhi0F8DT7OpEuD6vphgYpsLX2yLEbrcqWF9byiF7gUSqfvOadq1vafGuVGQjUmp
	9b2I4WQ==
X-Received: from pfbdf10.prod.google.com ([2002:a05:6a00:470a:b0:847:a3bd:93cf])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:997:b0:846:a26:8e0b
 with SMTP id d2e1a72fcca58-84826c97623mr2539278b3a.18.1783382175138; Mon, 06
 Jul 2026 16:56:15 -0700 (PDT)
Date: Mon,  6 Jul 2026 23:56:01 +0000
In-Reply-To: <20260706233344.3334648-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260706233344.3334648-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260706235614.1726605-1-kuniyu@google.com>
Subject: Re: [PATCH net] vxlan: add missing NULL check for vxlan_sock in GRO path
From: Kuniyuki Iwashima <kuniyu@google.com>
To: xmei5@asu.edu
Cc: AutonomousCodeSecurity@microsoft.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, kys@microsoft.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	tgopinath@linux.microsoft.com, tom@herbertland.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305246-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:AutonomousCodeSecurity@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:kys@microsoft.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:tgopinath@linux.microsoft.com,m:tom@herbertland.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E683716623

From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
Date: Mon,  6 Jul 2026 23:33:44 +0000
> vxlan_gro_prepare_receive() reads vs->flags from the vxlan_sock returned
> by rcu_dereference_sk_user_data(sk) without a NULL check, unlike the rest
> of the driver (e.g. vxlan_rcv() does "if (!vs) goto drop;").
> 
> udp_tunnel_sock_release() clears sk_user_data to NULL and waits an RCU
> grace period before the socket leaves the hash, so any callback running on
> the tunnel socket during teardown must tolerate a NULL sk_user_data. If a
> VXLAN device is torn down while GRO runs on its UDP tunnel socket,
> sk_user_data can be NULL when a packet carrying VXLAN_HF_RCO arrives,
> faulting in NAPI/softirq context.
> 
> The GRO path was the only sk_user_data reader on the socket missing this
> guard (vxlan_rcv and vxlan_err_lookup already have it; the gro_complete
> callbacks do not touch sk_user_data). Add the same NULL check so GRO
> flushes instead of dereferencing a NULL socket pointer.
> 
>   Oops: general protection fault ... SMP KASAN NOPTI
>   KASAN: probably user-memory-access in range [0x2018-0x201f]
>   RIP: 0010:vxlan_gro_prepare_receive (drivers/net/vxlan/vxlan_core.c:678)
>    vxlan_gro_receive (drivers/net/vxlan/vxlan_core.c:713)
>    udp_gro_receive (net/ipv4/udp_offload.c:841)
>    ...
>    dev_gro_receive (net/core/gro.c:522)
>    gro_receive_skb (net/core/gro.c:640)
>    tun_napi_poll (drivers/net/tun.c:259)
>    ...
>   Kernel panic - not syncing: Fatal exception in interrupt
> 
> Fixes: 5602c48cf875 ("vxlan: change vxlan to use UDP socket GRO")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> ---
>  drivers/net/vxlan/vxlan_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index b5b1253ac08b..f2235bae9bfe 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -663,6 +663,9 @@ static struct vxlanhdr *vxlan_gro_prepare_receive(struct sock *sk,
>  	struct vxlan_sock *vs = rcu_dereference_sk_user_data(sk);
>  	__be32 flags;
>  
> +	if (!vs)
> +		return NULL;

Please work on the latest tree, it's fixed 2 months ago.

commit 30a45c0bffdd62350261e2f2689fdba426a33578
Author: Kuniyuki Iwashima <kuniyu@google.com>
Date:   Sat May 2 03:12:59 2026

    vxlan: Fix potential null-ptr-deref in vxlan_gro_prepare_receive().

