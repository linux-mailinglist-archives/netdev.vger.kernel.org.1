Return-Path: <netdev+bounces-144985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F279C8F8B
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 17:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0162BB386CE
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511D013CA8D;
	Thu, 14 Nov 2024 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAK9fHz1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937CA133987
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600211; cv=none; b=u3Wq9CYPKkQqWgA6SV+oedwZyasDS6lE9lBmyEXQQaVTotPJJsTgbEWTbAfpBzObaX8zSjtEbbdTf+mzWIFtixOf4xzFfS084rnnQ4d/Ho04h8feiFmHpLJts9KWLfVrzWHhTmXBPd2hFzBQkqt/8U/fPMqmq9tyDdbMQrrn9to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600211; c=relaxed/simple;
	bh=jcb9INSeS+o4efk8lCAVbHCe4vqWALUQyWP3Atueu9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S50o5DSf2fCSOCnmZiAu+xWMZ/ScE/tNEaKt3cKnJhGFlNsYo4/oD8tVLRpsVaOxDLbPQcRknBEdMk4anStGYjr6wJ5rHh0ASskXPEQTi6Mu19aQ7KuZlf/ao2+Pps2obpAI6r1VclTqBFhhvNiRvceDw6UoZMTPnqESs01xMW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SAK9fHz1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731600208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PAq1VgZl8277b2O0WHyEF4cn1whtIrQG1NG+aLkeoAA=;
	b=SAK9fHz1Uhkt5Fa8Mmsnr9abs8aa8jiTC8vKerH1w0IG7i70tXAaEUwKWUV8FpSOKjttiv
	2jHEX+tCdecEFoE8gkxB1sryTLIzNrXx/aKJXceiaZyKzMu52KywfWRboR8sPtOf9cKjXb
	ya94qOcW/gtPgNMOwme9DfXiZC1zhEI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-3lLaw1ZJNCuMUKDDMbLqag-1; Thu, 14 Nov 2024 11:03:26 -0500
X-MC-Unique: 3lLaw1ZJNCuMUKDDMbLqag-1
X-Mimecast-MFC-AGG-ID: 3lLaw1ZJNCuMUKDDMbLqag
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-53da09b1ca1so671448e87.3
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 08:03:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731600205; x=1732205005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAq1VgZl8277b2O0WHyEF4cn1whtIrQG1NG+aLkeoAA=;
        b=wzlT95fVQgqJ3gDQ20FJJAtbqs1u3nQh5qyHKXUKmLn1a3DSe4GhK+P5syfDUmX3nx
         NO7PXo87o5vT58gKy8k32M+wRLAvhExtwkTw1sf7VMjDFTuAzUveJIk59R/PfHnv9neH
         /Jsf2TeMWsFl9mwPbQZoXEbTlGBO7VvYAny7wUo2PijMKQzlDPKtk/2yGBn14Yq4bBsw
         44xpSUkZ+OgyPATWTiBiKynp+VXGbs+4Mgp4bUIXUX8MYTUttOsGz/UAHIO1VHBNcLPN
         laN9qRLdvllOqVBxtiwlAKfumm0/7+azZ9mr3GINJ4Q5iuXs3xHd205uMZEG2UNaAJGy
         xI+g==
X-Forwarded-Encrypted: i=1; AJvYcCXzjrXK6fh+jafvkvaJhAnTfnVVPy7c8XHK3xRMWtFAPUqpPCbaafj+oIRKwRKOYuH5IBKSEhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfi+9LDVzcKOrec17yBLDQE9Mr3kdb2eDhXO2iMPAaOYwIOoKZ
	z+1KVCANReh7z0UYLAa1v0knFcR8GNu+dTAhqIVsmoWlGJhiXE0jD/lAdgZenefQAUQSw255O8E
	EgsAjwZ8gMipZxyqQzdAePbW1+/QGZO1d1A/fbdK8lnZNaLE11iPYPQ==
X-Received: by 2002:ac2:4c4f:0:b0:53a:16b:f14f with SMTP id 2adb3069b0e04-53d862c5a61mr12562605e87.19.1731600204442;
        Thu, 14 Nov 2024 08:03:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvbxPIAEHdn1mPbERhtCD7kSP6yeYuHglo67Z1qmJWvSZ/FPH+ZbCoGPmAtUoM379TrofBvw==
X-Received: by 2002:ac2:4c4f:0:b0:53a:16b:f14f with SMTP id 2adb3069b0e04-53d862c5a61mr12562551e87.19.1731600203888;
        Thu, 14 Nov 2024 08:03:23 -0800 (PST)
Received: from debian (2a01cb058d23d600b637ad91a758ba3f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b637:ad91:a758:ba3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265f28sm28577095e9.17.2024.11.14.08.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:03:23 -0800 (PST)
Date: Thu, 14 Nov 2024 17:03:21 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, coreteam@netfilter.org,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH nf-next 1/5] netfilter: ipv4: Convert ip_route_me_harder() to
 dscp_t.
Message-ID: <799ab09e1cbd8b2070f8891518647352c82c3b02.1731599482.git.gnault@redhat.com>
References: <cover.1731599482.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731599482.git.gnault@redhat.com>

Use ip4h_dscp()instead of reading iph->tos directly.

ip4h_dscp() returns a dscp_t value which is temporarily converted back
to __u8 with inet_dscp_to_dsfield(). When converting ->flowi4_tos to
dscp_t in the future, we'll only have to remove that
inet_dscp_to_dsfield() call.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/netfilter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/netfilter.c b/net/ipv4/netfilter.c
index e0aab66cd925..08bc3f2c0078 100644
--- a/net/ipv4/netfilter.c
+++ b/net/ipv4/netfilter.c
@@ -44,7 +44,7 @@ int ip_route_me_harder(struct net *net, struct sock *sk, struct sk_buff *skb, un
 	 */
 	fl4.daddr = iph->daddr;
 	fl4.saddr = saddr;
-	fl4.flowi4_tos = iph->tos & INET_DSCP_MASK;
+	fl4.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(iph));
 	fl4.flowi4_oif = sk ? sk->sk_bound_dev_if : 0;
 	fl4.flowi4_l3mdev = l3mdev_master_ifindex(dev);
 	fl4.flowi4_mark = skb->mark;
-- 
2.39.2


