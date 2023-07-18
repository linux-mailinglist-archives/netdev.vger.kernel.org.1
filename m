Return-Path: <netdev+bounces-18631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0778C758142
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 17:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1DC1C20D52
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 15:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B315710952;
	Tue, 18 Jul 2023 15:47:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7891D518
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 15:47:17 +0000 (UTC)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F33BE42
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 08:47:16 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-440db8e60c8so1907730137.0
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 08:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689695235; x=1692287235;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=co130geh6carjDOQ8KRzxQQvIXL4bEumjdoZgS67TXU=;
        b=YPhxBhntttQ2++OHbEnNwLcur3WuUYZB8ftMidduSy/Yy+K+/IlJVN+SGdXZMfHHGl
         73/V1VHxUX4kxNbw+33S0d8wKpjr6UglQMVg04LmsIf3j4WRUcZ9noTAqJoFBzSkCMbN
         ShMLPICwyZl7vboKthKHvxbhCXaOatw73sKfz8h2bfZtK0ttob3eew9SlI0aYKhpIod4
         EQGDCca2a2fLtT9sfpsZxvia7LQD2u5AQRW5JCyaTITKx1AT5KfzYxCFn0CcQ4X/o7i+
         H2evlFBa3wBQgCujYoYUIOFWzPNlvh/1kgSiXj31c4aLrMk527hJf6lFNczFn5wQbzTW
         wyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689695235; x=1692287235;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=co130geh6carjDOQ8KRzxQQvIXL4bEumjdoZgS67TXU=;
        b=MrnWKE/C5lds1OZ2hROlfWHx9pSAKbnEXP2P9MHt24P6Pf3bl0AI1nYNLwj2Uam/zf
         sCmVcWQhA45wsHRU5am8KIDC4uyx67UP391qveBeGMBn0PQ2MuAeNdM1dUMu+MszpgY8
         4XtNw+ORD1ZSWwnzaNBafBOHtMjn/KeLKgC+1aO78uXwGt7tZImZRYeOkGBekYz9UZ5P
         rn0sQlaBqqTWEdEXfoN8TEUUUn9wtIkD7sgV1NYvc33uC+EOpgPO+mM7JJQ3sTwVCKOr
         Pd3B8ws3biLaTvWItch1dmSedpV3TNnchyX9UejwYU692/GFkHavl8iyf8fS/JVAxtyM
         fb2A==
X-Gm-Message-State: ABy/qLbQdBt7BqAbUslGWBADN40hPj+3rKrVZ05wvVUtqPAbQSLbeDFY
	YcndMIyal1aGXmvAco4ZGmg=
X-Google-Smtp-Source: APBJJlFHl3iGfME4aG1tS2EWhGcqatAoP3FezD9unUw6YrsAelF2DxjYAcYUCAgzngAY9ZlLlsW1Lw==
X-Received: by 2002:a67:ea0b:0:b0:443:4f72:fd35 with SMTP id g11-20020a67ea0b000000b004434f72fd35mr7401446vso.1.1689695235487;
        Tue, 18 Jul 2023 08:47:15 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id x18-20020a0ca892000000b0062ffbf23c22sm803394qva.131.2023.07.18.08.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 08:47:15 -0700 (PDT)
Date: Tue, 18 Jul 2023 11:47:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <64b6b402c1357_223204294d0@willemb.c.googlers.com.notmuch>
In-Reply-To: <d47d53e6f8ee7a11228ca2f025d6243cc04b77f3.1689691004.git.pabeni@redhat.com>
References: <d47d53e6f8ee7a11228ca2f025d6243cc04b77f3.1689691004.git.pabeni@redhat.com>
Subject: RE: [PATCH v2 net-next] udp: use indirect call wrapper for data
 ready()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Paolo Abeni wrote:
> In most cases UDP sockets use the default data ready callback.
> Leverage the indirect call wrapper for such callback to avoid an
> indirect call in fastpath.
> 
> The above gives small but measurable performance gain under UDP flood.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
> v1 -> v2:
>  - do not introduce the specific helper (Willem)

I was just about to Ack v1. Did not mean to request a respin if
no one else spoke up. But thanks for humoring me :)

> ---
>  net/ipv4/udp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 42a96b3547c9..8c3ebd95f5b9 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1553,7 +1553,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
>  	spin_unlock(&list->lock);
>  
>  	if (!sock_flag(sk, SOCK_DEAD))
> -		sk->sk_data_ready(sk);
> +		INDIRECT_CALL_1(sk->sk_data_ready, sock_def_readable, sk);
>  
>  	busylock_release(busy);
>  	return 0;
> -- 
> 2.41.0
> 



