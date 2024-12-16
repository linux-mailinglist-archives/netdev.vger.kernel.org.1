Return-Path: <netdev+bounces-152339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC9A9F3770
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA2D1884766
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF7B207667;
	Mon, 16 Dec 2024 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6ZUcFRU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BE82066DB
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369719; cv=none; b=h2c7eCv0fZ1BeF1m2NxvZ4VoUTuL+uWZXaL3t62WFx813jzWe5WizYkMAN7UD3RKUkLhusE9LpcFt/qaxkYFtB99az/tr1WPnBVF7SLeqIRdW6rFbApBOdML6cD1lRuCaQZiWWAdT2nMYlT2U6en3YFRfmsCOq4tyMjP4A9UJ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369719; c=relaxed/simple;
	bh=R2spen+iGC3vfSQMtgj4oTZLwFwgxCKaBg/gCbssdrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O56vwL0V4/wOU439Yle4f/t04B1ZheJLQH5V2b9D25vw8E5QN4P3uaw1yaUfuDEj+t6jdTzCctkIANDOc4s4+i+Q1QL6apqqcXEI28GqDl76sXGGXaD1CKH4wmGRMgUB9hfAhrnTMLsAIyLW7L2z2JkNzGYjVWcaxBtbToMzwsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6ZUcFRU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734369716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k67C8teWCVR8gnbKmWvcLA6Fxm1e2FNSeXMozgh6UQg=;
	b=B6ZUcFRUpE6saqw9WA+tuxjc61+VmvVeZF8yq+gSnOjUFselxJttDmfOwkwOs2Ign5qKFK
	aAW4C4Umsby6JuXHha/AMYK/OuiDdkjIRQ7RXHViHiO6CAr9CnzRxu2ytt1JTqqZP1xxIa
	RVv7hRDcO3tC+zRgsNBo1NfRIcdMgZQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-cLJ4MRcjOVSrum8pCm3QmQ-1; Mon, 16 Dec 2024 12:21:55 -0500
X-MC-Unique: cLJ4MRcjOVSrum8pCm3QmQ-1
X-Mimecast-MFC-AGG-ID: cLJ4MRcjOVSrum8pCm3QmQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e27c5949so2664698f8f.3
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 09:21:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734369714; x=1734974514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k67C8teWCVR8gnbKmWvcLA6Fxm1e2FNSeXMozgh6UQg=;
        b=P+j0GDz0rYVAuU0GJhYnvN3ohOCH/QWjsOuecASmqh1+bnpvhWMsP9PuiFGMCIhNVl
         1VQykBn5NNDAU1c6H4VvQz3tlBwKJI1pbVt2zT7cIPFijpbBfTEsMFKJCE7Oy8PTrwLW
         hXd8iyYIyUqJw7lrtX3vI2v4vQsd/DSNCuVC3525Dv+BB7ncLslc8+hKWbAwfq5Q6Boz
         +gRggFid0t6mkUuC98k1VSLzdViEYkvRodliURrFGloj0DyTZUbeWrT7LNDugk0hdMvC
         83Qete84CXX9zs7R7Nh1EqyxxcWz4HA/c4ikF4nbdyLgaDT7kdSv9LiW5moSk/ppi4El
         UuhA==
X-Gm-Message-State: AOJu0Yx+IzJAzRa9b8N50YksN1QjliighR2pnPgc8N7mbwQGVTJNT9g5
	TNp0+zRN+tp2F0KjHuOZ7mfUY5j7YF4qUGRg9wGDha7+GjmvNElRC6i59xRRPW4NPMvVV1cSJS7
	MGCQV6V1To4wb1QK50fFqfPQKrUldL4ok77bHw8Gmxr64olN2xDf0YQ==
X-Gm-Gg: ASbGncu2y8OrinNrCEQAN2ZZ8R2fCu8lrXffbMQbRJjqkS3NUffVEZcDdjx7drmSfWZ
	lJtsqpEAM+JCKdcYNu8yUdlEXJXi1cOhfC8s3jToYg8j/sW/K0nARzg6Whjwj8tUg3JNw7nS9Qv
	dTsYdKzLUh/rkX0cQ1NG+HKMQwaDsFmenmOjz7wgf0C3UfBpJ6WKB8NGDz7AP0cbX2dR9kp/vI0
	D4tY3QEksLvNlBbwg9R5TOfMP7y9FIt1qSsnOqC9MppQ1JI1IAX4m5oncw79dDQdVcNU1Eqak5w
	yhWHRRlTJAL+XWAspUnVdJvmNgvuI+grUg9j
X-Received: by 2002:a05:6000:4711:b0:386:2d40:a192 with SMTP id ffacd0b85a97d-3888e0bc2c8mr9352554f8f.34.1734369714035;
        Mon, 16 Dec 2024 09:21:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVFRO2dZZXsUxoaGTNCXW+ZDpU0UFQkfPrntK3b55WAGSYVzKubarCRoKaOOULAbag+4/SfA==
X-Received: by 2002:a05:6000:4711:b0:386:2d40:a192 with SMTP id ffacd0b85a97d-3888e0bc2c8mr9352534f8f.34.1734369713649;
        Mon, 16 Dec 2024 09:21:53 -0800 (PST)
Received: from debian (2a01cb058d23d600c2f0ae4aed6d33eb.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:c2f0:ae4a:ed6d:33eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8012029sm8659729f8f.12.2024.12.16.09.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 09:21:53 -0800 (PST)
Date: Mon, 16 Dec 2024 18:21:51 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next 4/5] ipv4: Use inet_sk_init_flowi4() in
 __ip_queue_xmit().
Message-ID: <37e64ffbd9adac187b14aa9097b095f5c86e85be.1734357769.git.gnault@redhat.com>
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
structure in __ip_queue_xmit() instead of passing parameters manually
to ip_route_output_ports().

Override ->flowi4_tos with the value passed as parameter since that's
required by SCTP.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/ip_output.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index a59204a8d850..ce3b65d75bae 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -478,24 +478,16 @@ int __ip_queue_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl,
 	/* Make sure we can route this packet. */
 	rt = dst_rtable(__sk_dst_check(sk, 0));
 	if (!rt) {
-		__be32 daddr;
+		inet_sk_init_flowi4(inet, fl4);
 
-		/* Use correct destination address if we have options. */
-		daddr = inet->inet_daddr;
-		if (inet_opt && inet_opt->opt.srr)
-			daddr = inet_opt->opt.faddr;
+		/* sctp_v4_xmit() uses its own DSCP value */
+		fl4->flowi4_tos = tos & INET_DSCP_MASK;
 
 		/* If this fails, retransmit mechanism of transport layer will
 		 * keep trying until route appears or the connection times
 		 * itself out.
 		 */
-		rt = ip_route_output_ports(net, fl4, sk,
-					   daddr, inet->inet_saddr,
-					   inet->inet_dport,
-					   inet->inet_sport,
-					   sk->sk_protocol,
-					   tos & INET_DSCP_MASK,
-					   sk->sk_bound_dev_if);
+		rt = ip_route_output_flow(net, fl4, sk);
 		if (IS_ERR(rt))
 			goto no_route;
 		sk_setup_caps(sk, &rt->dst);
-- 
2.39.2


