Return-Path: <netdev+bounces-152338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F919F3772
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF1D16C7AE
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCFF20766F;
	Mon, 16 Dec 2024 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8ycj1vY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8DF207667
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369716; cv=none; b=Tw/TAFgRI91pDrOANejAfaYVFMJx8OAeBTB1DSWR/4ArxwP03nd+BkJZwyAYaBW4pGvgOwwBrHQ3uEQOq2qG7xMgb0sO5wQGnKF5XG2KTuXRsjfoQ/y6ShzI7GgtCyJIOIK0TtInD2Fz+B1Fg4/6VvuK51RTpcpqcmzLb3B5yiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369716; c=relaxed/simple;
	bh=GhsKH1lism3koNZhDFr7+JzBW+W5F30SqsWHWUbO9tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSxPy41ro/zG1RJEhp91NPeYdU/e3XyzU4Q648Bm+EaRmOmyafmghjQAa7tNYISo7IGzGovAtv79y2gfl8lOShDPwaKvo5zX0FDKb5IdpFPKgz+qCaT3IYDPmMSVX/J/0Avs5eEO3lU4PFyNyRc2J0Q/qZaud17e3G44qdG6OFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8ycj1vY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734369714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HbhLu1AxpDq3DtGf4C1YXvVtju21BTD9BNimj8/xtAE=;
	b=e8ycj1vYUddZS5DKi4IkFUzWG0LpDbe0NA/5Pfs1TaNCSDwsbMaqIfFu3JWYT/yOOaZJe6
	At6BiM/JwwfuiQXGDZJAvGKKGbJHwoUKbJGEcAHva5TEnzt6FiQVJtiWosfbKw0SFpaIxa
	YkAcBvaQorXnr6YILiCwhhOLHk1qYJU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-F2LYWsYPNjqPYXTT7yMzmQ-1; Mon, 16 Dec 2024 12:21:53 -0500
X-MC-Unique: F2LYWsYPNjqPYXTT7yMzmQ-1
X-Mimecast-MFC-AGG-ID: F2LYWsYPNjqPYXTT7yMzmQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43631d8d9c7so16318265e9.1
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 09:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734369711; x=1734974511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbhLu1AxpDq3DtGf4C1YXvVtju21BTD9BNimj8/xtAE=;
        b=ZnYXZRlJcg5o86ieMnLG5cr93l2Ucj9wSIw14M2u3Rg2Ufufu1k1vxQbKaxeBtPqLD
         tlEnawnNWT/Tgs7qV5Yee6pE4M3q3gS5uH/iRm1RnzGb1ITkqRVpw1se59y/rxTMAZys
         TF1w0SH1sUUhPEAQLgONEiCCmMPsmb4xKi8Xq6NVeJBEwqbuNfRwKOflLlMwcSYVZ6jU
         TIM+ZR5buVh+iyufeSlIm+zmORpHNbYFKGSuk2yjxhr5IVG9gLn/Y2kUi/MqEPv1BI2L
         9lm48WOLS3mISATYohH5vvYqs5hd9gdAON9xSeWUDAQehBhZ/N1LIL9sv5aL77rLPqtB
         O3mg==
X-Gm-Message-State: AOJu0YwdDQW8GS//goOtxtkViyY+NTOliS4BCcR+RZNPSgqf1eb0a2FF
	zI4Cm+YVoOVbFO7ZE45bAUS6dTr5zzKRUOrZk5ogjLkYpiS5bapsgDY2Ari1cjLXxLr22dv/pRh
	hsR8tYQrSbXJd7fb+lREAl0tpIifJ98GIcXEpkzQGLH8613e4DETAmEQyzZYtFA==
X-Gm-Gg: ASbGncuticJXwpVse3rx4vrSdc/0455ikaRx53hqmG60z6owE6l+8jR2PV40zJTunda
	520yY1P6hv9Mnp2wNmvsdnqh0lt6u/g1IDx48WPqA+IRBlEG5gNudVONmgV4J+X6V25uK5Bcuzm
	Nw3H6kpblC+WBZR9qqiYtVWumH9QQlF6DqC7Hpr4Fef/QsV3sx6nMYyZa/+ZykPdBokikYIyOSf
	8DaSrtlhQJbDecNrWVghtaHUyqP+lMH4nC+3JJrTb0ojr171dCbnT6BBjavBaqMzsooxDQ7U1AN
	/uTszHnWYAMTsIS2ZlMJ5HOlJnh1LRNPMR/c
X-Received: by 2002:a05:600c:3c82:b0:42c:b8c9:16c8 with SMTP id 5b1f17b1804b1-4364817be68mr1254395e9.10.1734369711504;
        Mon, 16 Dec 2024 09:21:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEY243qtVuKB/yoZ4aeiqUHkfPxokTsjrRcmk6PVSbj+8NggExIj/qcilEU8d1BrIZNEDDuLw==
X-Received: by 2002:a05:600c:3c82:b0:42c:b8c9:16c8 with SMTP id 5b1f17b1804b1-4364817be68mr1254145e9.10.1734369711170;
        Mon, 16 Dec 2024 09:21:51 -0800 (PST)
Received: from debian (2a01cb058d23d600c2f0ae4aed6d33eb.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:c2f0:ae4a:ed6d:33eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801a8b0sm8619473f8f.53.2024.12.16.09.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 09:21:50 -0800 (PST)
Date: Mon, 16 Dec 2024 18:21:48 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next 3/5] ipv4: Use inet_sk_init_flowi4() in
 inet_csk_rebuild_route().
Message-ID: <b270931636effa1095508e0f0a3e8c3a0e6d357f.1734357769.git.gnault@redhat.com>
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
structure in inet_csk_rebuild_route() instead of passing parameters
manually to ip_route_output_ports().

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/inet_connection_sock.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6872b5aff73e..e4decfb270fa 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1561,20 +1561,13 @@ EXPORT_SYMBOL_GPL(inet_csk_addr2sockaddr);
 static struct dst_entry *inet_csk_rebuild_route(struct sock *sk, struct flowi *fl)
 {
 	const struct inet_sock *inet = inet_sk(sk);
-	const struct ip_options_rcu *inet_opt;
-	__be32 daddr = inet->inet_daddr;
 	struct flowi4 *fl4;
 	struct rtable *rt;
 
 	rcu_read_lock();
-	inet_opt = rcu_dereference(inet->inet_opt);
-	if (inet_opt && inet_opt->opt.srr)
-		daddr = inet_opt->opt.faddr;
 	fl4 = &fl->u.ip4;
-	rt = ip_route_output_ports(sock_net(sk), fl4, sk, daddr,
-				   inet->inet_saddr, inet->inet_dport,
-				   inet->inet_sport, sk->sk_protocol,
-				   ip_sock_rt_tos(sk), sk->sk_bound_dev_if);
+	inet_sk_init_flowi4(inet, fl4);
+	rt = ip_route_output_flow(sock_net(sk), fl4, sk);
 	if (IS_ERR(rt))
 		rt = NULL;
 	if (rt)
-- 
2.39.2


