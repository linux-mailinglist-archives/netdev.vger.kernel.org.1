Return-Path: <netdev+bounces-152337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D049F376E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB751882B32
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FDC2063FF;
	Mon, 16 Dec 2024 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLQOMkb8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F4F206270
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369713; cv=none; b=o9ePkZb4C0ZLguNJ3EepKjGByjwDj/AvWwJ3oOzUj2lTusm4SRXeWBLvWT3ngJBasj9GoziM3AVxJJH9Vp5Xp6I4CzEEG8lojxomS3uVOMC/cCr59O4BXh6FuJwXNHdaxP1WtYaEuvXPmUiS8cpfUmGlmSYM05yJHKaJUIKsUwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369713; c=relaxed/simple;
	bh=0T3m7DWtj2xPvjHBKs0WgTrAxHby7T18hSfCHbMu3Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0fbsbcGV/uprFQCRwFTW9N7eQ7w9bbrZf3UmB+xxZlO07rPudcwjaKK2aq9SJJVqtnb8AcR6Zd+DB1rIQCsSxjVT26SQgWjPZdKJecS2jIxkXRruqiGKvx8EWYdjjrMLWap+yiUwU7x8I44W02ZGiavHmrkfdIqe1j2FXUbalk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HLQOMkb8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734369711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MSVrmH0+RECg5FGtjBvpruW9G5NzkpNGEwyNMXfXPww=;
	b=HLQOMkb85Czlr5cYGM2YOqjnbN4VVLoKdJJ/hV7ODgIoPKVMQDc41UnlJ0jsdd7UBIZo+k
	qRT5lrehP/yGYoIu7QxDF6ApRhcNH0TKEX77nAapopRPSPOv+vfvsX5J7v+86G6K7ztWkI
	VZwpX5aDeGJYD9HxGfhyDC2kU74LdYw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-NFL8K8rBMWWIkGxrlW--iQ-1; Mon, 16 Dec 2024 12:21:50 -0500
X-MC-Unique: NFL8K8rBMWWIkGxrlW--iQ-1
X-Mimecast-MFC-AGG-ID: NFL8K8rBMWWIkGxrlW--iQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e2579507so1872727f8f.1
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 09:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734369709; x=1734974509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSVrmH0+RECg5FGtjBvpruW9G5NzkpNGEwyNMXfXPww=;
        b=tTqi2SnDvr1ZuN7QcIFvU9+eUmHxwPOCiLdmAw1A/qcr7Fcj3xt6hskPWNo1jRrxNB
         SdIgr7cQz9uAcGutDLThV322nWQG4r6s+G8e3QBW4MBXMRniUlAz2SF2TjF0PCZBkTv3
         fdie4n3BH94NXEcxpojt0ielxukFK2HCjv325Vnk3VgHqw6ELVjQVzxkmpcQ4KGM11UF
         KV6bBF0Q1z5r3UNirhiJFH9kDlm/Uh7TO5S/Vm9bY6SriMf2hKxXWaadmfSJN0kYEbQp
         8fstqYdMQ8OkDqASGQAeLfrXbbDVpUK/0+sOw7L7w1oO5Me9z+ZRXQ2Z970fhZj6Mzqt
         +zFg==
X-Gm-Message-State: AOJu0YwUeDJ+EiR2W92Z99ghyRIKEDfgABbNH+XQFqQ1Tig9649TZlLD
	oytMnN1Gy5UalxWi3kx5SftJWkFHAm/cMWi8CEKAZvINJL0eGFVkyYe4Q3nWI3H28X/efcG9FDr
	fC6hmypi6XFCtz9YRv6FqybfC44+CzsbDwiEGjB5ruHucgrua35wIVA==
X-Gm-Gg: ASbGnculGzbtGkF2EHueeXWcf2GRYGfvbyZpbOHh9t4nv3LfstnnUP+0tLRkRen22iX
	9X9ap6yul+sJDC1DUGL5QvW3Z1Oy6nw8uy7xBmyi2BZ7k+Lo6Q4X7q0e4aeKgYdXfYrDJuFMytk
	qiMKzBIHW6hl1/gmtkIDH8Pd6lQnL5dmqp6wQ04MrI/eQtwhVIOdt7Q/dnBvknoABL/rtS8edpW
	QBSQml36Zll24fkTF7ImNzcXrKbwLpqGfnpreJOKCD4zfP1xvlA4BtRjHBjKOyufOtQfeOUCOsh
	rNAc16DO3o8YHZs80KNUrqnTBMQB4E6EsFCX
X-Received: by 2002:a05:6000:2a3:b0:385:f1f2:13ee with SMTP id ffacd0b85a97d-3888e0b8b9fmr12230044f8f.46.1734369708919;
        Mon, 16 Dec 2024 09:21:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzTz63J/CTegK/9PB6VbZ0qf4PcDor8ZwlrYNwxZIwwMD5hacbGegNHaBIEbBz/84mEzh5+g==
X-Received: by 2002:a05:6000:2a3:b0:385:f1f2:13ee with SMTP id ffacd0b85a97d-3888e0b8b9fmr12230023f8f.46.1734369708558;
        Mon, 16 Dec 2024 09:21:48 -0800 (PST)
Received: from debian (2a01cb058d23d600c2f0ae4aed6d33eb.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:c2f0:ae4a:ed6d:33eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c806115asm8618604f8f.107.2024.12.16.09.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 09:21:48 -0800 (PST)
Date: Mon, 16 Dec 2024 18:21:46 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next 2/5] ipv4: Use inet_sk_init_flowi4() in
 ip4_datagram_release_cb().
Message-ID: <9c326b8d9e919478f7952b21473d31da07eba2dd.1734357769.git.gnault@redhat.com>
References: <cover.1734357769.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1734357769.git.gnault@redhat.com>

Use inet_sk_init_flowi4() to automatically initialise the flowi4
structure in ip4_datagram_release_cb() instead of passing parameters
manually to ip_route_output_ports().

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/datagram.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
index 4aca1f05edd3..4b5bc6eb52e7 100644
--- a/net/ipv4/datagram.c
+++ b/net/ipv4/datagram.c
@@ -102,8 +102,6 @@ EXPORT_SYMBOL(ip4_datagram_connect);
 void ip4_datagram_release_cb(struct sock *sk)
 {
 	const struct inet_sock *inet = inet_sk(sk);
-	const struct ip_options_rcu *inet_opt;
-	__be32 daddr = inet->inet_daddr;
 	struct dst_entry *dst;
 	struct flowi4 fl4;
 	struct rtable *rt;
@@ -115,14 +113,9 @@ void ip4_datagram_release_cb(struct sock *sk)
 		rcu_read_unlock();
 		return;
 	}
-	inet_opt = rcu_dereference(inet->inet_opt);
-	if (inet_opt && inet_opt->opt.srr)
-		daddr = inet_opt->opt.faddr;
-	rt = ip_route_output_ports(sock_net(sk), &fl4, sk, daddr,
-				   inet->inet_saddr, inet->inet_dport,
-				   inet->inet_sport, sk->sk_protocol,
-				   ip_sock_rt_tos(sk), sk->sk_bound_dev_if);
 
+	inet_sk_init_flowi4(inet, &fl4);
+	rt = ip_route_output_flow(sock_net(sk), &fl4, sk);
 	dst = !IS_ERR(rt) ? &rt->dst : NULL;
 	sk_dst_set(sk, dst);
 
-- 
2.39.2


