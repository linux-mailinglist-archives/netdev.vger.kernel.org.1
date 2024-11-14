Return-Path: <netdev+bounces-144987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0589C9073
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 18:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 232DDB31AB3
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40A815FA7B;
	Thu, 14 Nov 2024 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CiBN7u9n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1E415DBB3
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600224; cv=none; b=gMUYj3eJubGNZhFaf+rMpzVCNzgTfThsaJZYyjFYX3Dwyc0XBsf6/PUrwWa+3vg2zGBxmfQnOZW6af3klLY4UVFVZJ0sIponiq64MqU8ztGIcWYb7YlRvASOHGMvnPnDg4f1ctO2t7bYLe8p/37RsSoBD+LCXkJKY4rXNiMVlAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600224; c=relaxed/simple;
	bh=5RknSn7bVZ9Sp8G0NfIi7txZbEwVmyyLhHOcziJAz7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8JfWwPGlTjCRtPW+lG2ThebbFW0VjZq0MiaOJ4al96OJ8y6DDSojgkJyljd+de19PuLrnr9mZPLPOeyKp+nOjXd3v8FgjyJW5aXXaX5Than0e6nQaif0gEvP7JUy9cSUlPCsWIlBiJhVg/+NseeGlzHYLUpMvz9lX7ey1ovBJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CiBN7u9n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731600222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jFJBfZsuRNKlRmGlsq7skNCrEogTFO/7vDcCzJF9P+M=;
	b=CiBN7u9nWM1MmEM9knVa7AEkJVoDYOmYi/8QhQ7RFrL4iXNOegHNUe8g0DZfgLrxJOPt1l
	r53YBTqvtrTZNeNAQQbBUC0IEk+1qpVY9jqduBjjL4SBW31jKEH9RqZwUnUQRLf7JNsNc9
	sapm4PGKOrcB5G5eGFlBuYrFAFQ+2XU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553--5LtHiQzPG-QFpXPJdgHBw-1; Thu, 14 Nov 2024 11:03:41 -0500
X-MC-Unique: -5LtHiQzPG-QFpXPJdgHBw-1
X-Mimecast-MFC-AGG-ID: -5LtHiQzPG-QFpXPJdgHBw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43157e3521dso5826325e9.1
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 08:03:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731600217; x=1732205017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFJBfZsuRNKlRmGlsq7skNCrEogTFO/7vDcCzJF9P+M=;
        b=U7pRhoiuxAjFNFBV7BvM+HcrJCtbw+IFMrFWHwBa4mXxVgjm38TnHKbBH29p6yemSh
         dt1seDsxX7phMVrk+WAen+tVHoqQZfm9Yimp6imQwsDd9WG1YNgioCfDFvVICNfZ9V9C
         dY/A+FBH/nGFOLH069prQDJEHcWEKy79QStQXh7IHxUDDa9+/baeGhJNUjF3rItYMklV
         TtDacI5+ZsiPgAgV7ZQgNLI+HsvLsQm3TAE0zXLWS4Fh6tWTFf7aFsVInTmcPlX+euc8
         YQ91GXu8V5vROVwM7yhiPA95uXRTq3jjMtrKr9TvNU3KU4aUvTHhiei8AHea80B8WS9z
         eIFg==
X-Forwarded-Encrypted: i=1; AJvYcCXba1KqEZ4WKsxvkBz7owYspn5eFgyCiqLeDiHfdinHgwqYdtrfG6lsz2auxSu3W7tbkKrbN5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHuXAGmmq5bUe77lQietej4psPhkivtcJPOM5oFvu7rs17mIZH
	omV+kGkSlCLcloqPkIb+eicVsK4H9J8yJkmoAHfDBaSioCDtWgZPYKWqYR6RIuNsujphaa8AiuM
	efxtjP95yrHtRtqNrXPeJQxhv6ckser+IH58WxT4+/ruDJ+/e2vlq8A==
X-Received: by 2002:a05:600c:468d:b0:425:80d5:b8b2 with SMTP id 5b1f17b1804b1-432da790aa3mr28802695e9.16.1731600215799;
        Thu, 14 Nov 2024 08:03:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPYCo/VbNnJPfZ9jCSUk1Uk+WXO2Lu9MT54UrcQ1GHUqbnEPX5xx7mMsc6HvBXUQYcJYRBSA==
X-Received: by 2002:a05:600c:468d:b0:425:80d5:b8b2 with SMTP id 5b1f17b1804b1-432da790aa3mr28800225e9.16.1731600213753;
        Thu, 14 Nov 2024 08:03:33 -0800 (PST)
Received: from debian (2a01cb058d23d600b637ad91a758ba3f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b637:ad91:a758:ba3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada3199sm1826311f8f.22.2024.11.14.08.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:03:33 -0800 (PST)
Date: Thu, 14 Nov 2024 17:03:31 +0100
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
Subject: [PATCH nf-next 2/5] netfilter: flow_offload: Convert
 nft_flow_route() to dscp_t.
Message-ID: <36ab64916593c2cd88cbc17b8369ee4bbe97182d.1731599482.git.gnault@redhat.com>
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

Use ip4h_dscp()instead of reading ip_hdr()->tos directly.

ip4h_dscp() returns a dscp_t value which is temporarily converted back
to __u8 with inet_dscp_to_dsfield(). When converting ->flowi4_tos to
dscp_t in the future, we'll only have to remove that
inet_dscp_to_dsfield() call.

Also, remove the comment about the net/ip.h include file, since it's
now required for the ip4h_dscp() helper too.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/netfilter/nft_flow_offload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 65199c23c75c..3b474d235663 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -8,7 +8,7 @@
 #include <linux/spinlock.h>
 #include <linux/netfilter/nf_conntrack_common.h>
 #include <linux/netfilter/nf_tables.h>
-#include <net/ip.h> /* for ipv4 options. */
+#include <net/ip.h>
 #include <net/inet_dscp.h>
 #include <net/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables_core.h>
@@ -236,7 +236,7 @@ static int nft_flow_route(const struct nft_pktinfo *pkt,
 		fl.u.ip4.saddr = ct->tuplehash[!dir].tuple.src.u3.ip;
 		fl.u.ip4.flowi4_oif = nft_in(pkt)->ifindex;
 		fl.u.ip4.flowi4_iif = this_dst->dev->ifindex;
-		fl.u.ip4.flowi4_tos = ip_hdr(pkt->skb)->tos & INET_DSCP_MASK;
+		fl.u.ip4.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(ip_hdr(pkt->skb)));
 		fl.u.ip4.flowi4_mark = pkt->skb->mark;
 		fl.u.ip4.flowi4_flags = FLOWI_FLAG_ANYSRC;
 		break;
-- 
2.39.2


