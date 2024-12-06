Return-Path: <netdev+bounces-149712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C689E6E5B
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77DD28618D
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5511FC107;
	Fri,  6 Dec 2024 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="isEtxb2Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFFB1DDA30
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488616; cv=none; b=Vo+8hXQfwqe5txkzwpnFYVDkE1RTWaDJqU6X4TIeSQASVrAXwsV9lzKIaAbeXIEljrVkMJKqKkt0cuAGOL4L7YWyBxch2WeooYQ5bFqTJameT1f4/zPvekeAuZt9/Iu/mz1cp/9dJKZ5c+f/JyenRllV32tPNmWTG3mDKaMFOwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488616; c=relaxed/simple;
	bh=lkxQ6Eazhpr8xO6lcp2uZRHwproW/rMhnSlDpQ8WKOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JR+K6O4bxCRrpDQYPPmnAqL6t9c+T0yLs82484Q6rBMV3urx4gdsgvOIGXvZoNhc33HTtrybyI4o0d/a2HRAoAf+5wJiCUnQYIy4RfheeadNBF38JjV88K9iDoU5WAsMAdg8cEDTPnU1+LDA/1zZHGvLDeJVNXK0KeyljtZVWsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=isEtxb2Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733488613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l2dc7BG0DpCD5cKEyDwwA6ZoeFvZRF+UV5Igh8VET8Y=;
	b=isEtxb2Y+3/CJB7z+1Gqxin6Ag46HVGGTw18zc+I1aKMXpbtFPfuSc2/9vY3qFw6ZMwjK8
	v+lVUVNYB+P/cty5hiJf7B+6FS5wnTooUqMJ3TvOmnNpfRrfSCb86+MgRhElBmOLRKwI//
	bNDaLplREjS/Dt0IcU2S/IdzQ/gqu2o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-1_50OdgiNrqfh-b7kkENNg-1; Fri, 06 Dec 2024 07:36:52 -0500
X-MC-Unique: 1_50OdgiNrqfh-b7kkENNg-1
X-Mimecast-MFC-AGG-ID: 1_50OdgiNrqfh-b7kkENNg
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d8e891a5f7so8400846d6.2
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 04:36:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733488612; x=1734093412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l2dc7BG0DpCD5cKEyDwwA6ZoeFvZRF+UV5Igh8VET8Y=;
        b=MJl8Cx+g15JXcCYYimxLF1em8KxPTLKV762LDdHTALGrSsg8zGo/0jbL/pyzwX/DnF
         4quRwJsM7ZmAVxhVuJATbMkBYIbfzPPw4feVdRZHk9OdpzXAuUJijztDpHo7qOitp6Sx
         1UlE4JcHXmBlV0sZZWFDNyOeWHd1JxyI/ewRZr3KrxWvD+t6xYSWV7YQN0NJTpHroVVX
         9tA2vn/x2UmrmhI/rxZeLykz1cKdJuoiKsnH3UKlcBKLogVaurG+rDvQBVMVhw5HyiCk
         yiLiz4ZUOCqW+tCO7MhIauA+JsRPiz2PmdCnYB6YaT7wJew/j0LRHmlPMqpKPuhga4Fa
         Y9DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ3A1psG7OgmSZVfZv0hZIcPQTWApDGevo9hDLKwDVPynOV6anhchO3GCwPwtpMaC8dbYurqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxELHtFYTRze7pHN4btDJtlWgGG5HA2wb9kvy8weoXFAOSXXip
	WXVBJqc0dtmAET9w+IqiJnpUiaDF5p56Vo2DUmJltdpbkVgqan/b/KDxmrM/5xpT5XlRpiE6vY/
	txjhPUausG3e1SK+Cx2/FIwXFeH9NfvqbfkC/nSbM0y07OwAxz/H/lQ==
X-Gm-Gg: ASbGncuCcdsHsDcQ83R76QQIJf/CdYPu26RbN7LzgWkkJNjuepW0b5TcAy9RS09dfON
	ZPnZ366adnfgRjuobE8GUarhQvafohwZQws3PLvSLKdQ5YcMt0F4XMylkcIa5dLSw2uDNSpU6z7
	cJSa32QgixFxfVvOdndK0DxxuHZlgeXwGC+Mt0IAffdJx9D6zAXFqo4XiY620vBX3X5gwh95XjT
	TQU/K009CCgDC5iwKNOKDVi7U2iQEhy4IS+9dMw6B5qyKRCCWY/8kKzLs/bytuuhj3ej591vam1
X-Received: by 2002:ad4:5967:0:b0:6d8:9bfd:5644 with SMTP id 6a1803df08f44-6d8e71f5f6cmr35470926d6.49.1733488611775;
        Fri, 06 Dec 2024 04:36:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEB8li1XXHvblP7JlpeR2IAOILI103Cl40x5m58+j1VGRHxzM1t+RX71WvSHMua0OO7aNCr8g==
X-Received: by 2002:ad4:5967:0:b0:6d8:9bfd:5644 with SMTP id 6a1803df08f44-6d8e71f5f6cmr35470616d6.49.1733488611385;
        Fri, 06 Dec 2024 04:36:51 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da69591fsm18864256d6.31.2024.12.06.04.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 04:36:50 -0800 (PST)
Message-ID: <e02911ae-3561-48be-af92-c3580091015f@redhat.com>
Date: Fri, 6 Dec 2024 13:36:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] datagram, udp: Set local address and rehash
 socket atomically against lookup
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Mike Manning <mvrmanning@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Holzinger <pholzing@redhat.com>, Philo Lu <lulie@linux.alibaba.com>,
 Cambda Zhu <cambda@linux.alibaba.com>, Fred Chen <fred.cc@alibaba-inc.com>,
 Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
References: <20241204221254.3537932-1-sbrivio@redhat.com>
 <20241204221254.3537932-3-sbrivio@redhat.com>
 <fa941e0d-2359-4d06-8e61-de40b3d570cb@redhat.com>
 <20241205165830.64da6fd7@elisabeth>
 <c1601a03-0643-41ec-a91c-4eac5d26e693@redhat.com>
 <20241206115042.4e98ff8b@elisabeth>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241206115042.4e98ff8b@elisabeth>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/24 11:50, Stefano Brivio wrote:
> On Thu, 5 Dec 2024 17:53:33 +0100 Paolo Abeni <pabeni@redhat.com> wrote:
>> I'm wondering if the issue could be solved (almost) entirely in the
>> rehash callback?!? if the rehash happens on connect and the the socket
>> does not have hash4 yet (it's not a reconnect) do the l4 hashing before
>> everything else.
> 
> So, yes, that's actually the first thing I tried: do the hashing (any
> hash) before setting the address (I guess that's what you mean by
> "everything else").
> 
> If you take this series, and drop the changes in __udp4_lib_lookup(), I
> guess that would match what you suggest.

I mean something slightly different. Just to explain the idea something
alike the following (completely untested):

---
diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
index cc6d0bd7b0a9..e9cc6edbcdc6 100644
--- a/net/ipv4/datagram.c
+++ b/net/ipv4/datagram.c
@@ -61,6 +61,10 @@ int __ip4_datagram_connect(struct sock *sk, struct
sockaddr *uaddr, int addr_len
 		err = -EACCES;
 		goto out;
 	}
+
+	sk->sk_state = TCP_ESTABLISHED;
+	inet->inet_daddr = fl4->daddr;
+	inet->inet_dport = usin->sin_port;
 	if (!inet->inet_saddr)
 		inet->inet_saddr = fl4->saddr;	/* Update source address */
 	if (!inet->inet_rcv_saddr) {
@@ -68,10 +72,7 @@ int __ip4_datagram_connect(struct sock *sk, struct
sockaddr *uaddr, int addr_len
 		if (sk->sk_prot->rehash)
 			sk->sk_prot->rehash(sk);
 	}
-	inet->inet_daddr = fl4->daddr;
-	inet->inet_dport = usin->sin_port;
 	reuseport_has_conns_set(sk);
-	sk->sk_state = TCP_ESTABLISHED;
 	sk_set_txhash(sk);
 	atomic_set(&inet->inet_id, get_random_u16());

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 6a01905d379f..c6c58b0a6b7b 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2194,6 +2194,21 @@ void udp_lib_rehash(struct sock *sk, u16 newhash,
u16 newhash4)
 			if (rcu_access_pointer(sk->sk_reuseport_cb))
 				reuseport_detach_sock(sk);

+			if (sk->sk_state == TCP_ESTABLISHED && !udp_hashed4(sk)) {
+				struct udp_hslot * hslot4 = udp_hashslot4(udptable, newhash4);
+
+				udp_sk(sk)->udp_lrpa_hash = newhash4;
+				spin_lock(&hslot4->lock);
+				hlist_nulls_add_head_rcu(&udp_sk(sk)->udp_lrpa_node,
+							 &hslot4->nulls_head);
+				hslot4->count++;
+				spin_unlock(&hslot4->lock);
+
+				spin_lock(&hslot2->lock);
+				udp_hash4_inc(hslot2);
+				spin_unlock(&hslot2->lock);
+			}
+
 			if (hslot2 != nhslot2) {
 				spin_lock(&hslot2->lock);
 				hlist_del_init_rcu(&udp_sk(sk)->udp_portaddr_node);
---

Basically the idea is to leverage the hash4 - which should be not yet
initialized when rehash is invoked due to connect().

In such a case, before touching hash{,2}, do hash4.

/P


