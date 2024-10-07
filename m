Return-Path: <netdev+bounces-132830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A979799361B
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 20:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A413286BE3
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159C41DE2A1;
	Mon,  7 Oct 2024 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bo+M0yNq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2441D7E52
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325484; cv=none; b=ATzRm7jxBGx6QGBJDiMLJcPXoBWsAynYhR8lfcC/jJN9Sq9FqtEY2Fivh/opwlnZUmaab7etbrjo5uju6GEk2VjGaLIciYhjwU+SmQCm4IoBjCl09zbEuBSCO1oeUHdpApgQGNu9of8Z4UtruTma2t+taYjwJQIzFEJtaKZ1N9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325484; c=relaxed/simple;
	bh=Go6IxA9ztG9bsIlqQNMgcGvtJIwTR4FSC0rvv0Lujf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZzIvo6c3Z5bQ6Q9VJSsR73Wjgslfgn7jdzIqoCFc6acSKUu+YpXinmy54B6SdZoMOfIEB1bzRZiRdSPfzy4jATivl+x1zfvcS5dAgiiWv9V8WJz0Q/ngtp0Y41OE7NIZ1IXkmEZdzKo3ITJD9IJudDB70GOLhCfVtT2XNeTBDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bo+M0yNq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728325481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tCGNwV/45QRE+MWLFZXBq2JLf0R1zmlXkrIjIPHZQRg=;
	b=bo+M0yNq7jTtUVlSaExq+ZskJjSKFUfJuS/HZg3d6HoCAbctuXbkpfALRZtQsb2FKi6SqP
	Hn2QZ1PevJzOT749zICNVI7CMog6OpLXVfpDs9Djx5zoQyaiZY2MWU1ObNGUWo+dZX+cQf
	MpGhocSg+IpI3H0NkQLZOiKIXFcPYE8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-_t9cy_saNBaZdUJ57bCHWg-1; Mon, 07 Oct 2024 14:24:39 -0400
X-MC-Unique: _t9cy_saNBaZdUJ57bCHWg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37cd26ac362so1847447f8f.2
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 11:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728325478; x=1728930278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCGNwV/45QRE+MWLFZXBq2JLf0R1zmlXkrIjIPHZQRg=;
        b=nvzpF18NjaigS+Wzxwc2rXEQjZeATbaG9pw4r1jECLUwn6cB3C1WYdTKiFtUZ5etRu
         a6x9x6vcwoRG1habKyq6/Wm5+959+2+DoD/0dLjRwij8F5KUXLXx4rvzP16IEjhKDmCh
         M7kl+D4VbSkrcZ6d7WzX8739738829Pni8y8WBjqy+/JCS3sJcWTQJBCgaV+1nlWEdd+
         aqr01BDFfasFFdN//OqRomu9vWk443RorERyiAhc+1EK6qxUj+mtJe2Ca4dtQfQS2AHa
         igKFIRplcJXgMS+cKFi+1Z2CvcSq388IoPZSsYfcK84OqiBan99CXeraOdSAn1UDtNyK
         7IQg==
X-Gm-Message-State: AOJu0YwSltHFLa9Fz08ms3OcSR21dXa2mf1ltiPNIzyOmuPnDRbqjEtA
	H7DvAPEMNuWwhH6foLNebGQ/TYEk2ySpNNbpv7sGWLS2o6+lwMKWJSUNdYTPSmmHD9UriIzds7T
	C1c1If2o1JJCznv2OJk3BjZTMcpQgnuVRaEezDgjRHAoo7dWu3iqsbrx4Zv9g/Q==
X-Received: by 2002:a05:6000:c52:b0:371:9360:c4a8 with SMTP id ffacd0b85a97d-37d0e6f22fdmr6614764f8f.6.1728325478471;
        Mon, 07 Oct 2024 11:24:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF+lVll5FyoVnJb8wOd7+6n4anfXVzyVhPcS/qA+bXtwC4eBtn5pVdk00ZNVS3pIRMLJxKLw==
X-Received: by 2002:a05:6000:c52:b0:371:9360:c4a8 with SMTP id ffacd0b85a97d-37d0e6f22fdmr6614749f8f.6.1728325478003;
        Mon, 07 Oct 2024 11:24:38 -0700 (PDT)
Received: from debian (2a01cb058d23d6007679fbc6b291198c.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:7679:fbc6:b291:198c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1698fcacsm6215051f8f.116.2024.10.07.11.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 11:24:37 -0700 (PDT)
Date: Mon, 7 Oct 2024 20:24:35 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next 2/7] ipv4: Convert ip_mkroute_input() to dscp_t.
Message-ID: <6aa71e28f9ff681cbd70847080e1ab6b526f94f1.1728302212.git.gnault@redhat.com>
References: <cover.1728302212.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728302212.git.gnault@redhat.com>

Pass a dscp_t variable to ip_mkroute_input(), instead of a plain u8, to
prevent accidental setting of ECN bits in ->flowi4_tos.

Only ip_route_input_slow() actually calls ip_mkroute_input(). Since it
already has a dscp_t variable to pass as parameter, we only need to
remove the inet_dscp_to_dsfield() conversion.

While there, reorganise the function parameters to fill up horizontal
space.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/route.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index ac03916cfcde..38bb38dbe490 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2112,11 +2112,9 @@ int fib_multipath_hash(const struct net *net, const struct flowi4 *fl4,
 }
 #endif /* CONFIG_IP_ROUTE_MULTIPATH */
 
-static int ip_mkroute_input(struct sk_buff *skb,
-			    struct fib_result *res,
-			    struct in_device *in_dev,
-			    __be32 daddr, __be32 saddr, u32 tos,
-			    struct flow_keys *hkeys)
+static int ip_mkroute_input(struct sk_buff *skb, struct fib_result *res,
+			    struct in_device *in_dev, __be32 daddr,
+			    __be32 saddr, dscp_t dscp, struct flow_keys *hkeys)
 {
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 	if (res->fi && fib_info_num_path(res->fi) > 1) {
@@ -2128,7 +2126,8 @@ static int ip_mkroute_input(struct sk_buff *skb,
 #endif
 
 	/* create a routing cache entry */
-	return __mkroute_input(skb, res, in_dev, daddr, saddr, tos);
+	return __mkroute_input(skb, res, in_dev, daddr, saddr,
+			       inet_dscp_to_dsfield(dscp));
 }
 
 /* Implements all the saddr-related checks as ip_route_input_slow(),
@@ -2315,8 +2314,7 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		goto martian_destination;
 
 make_route:
-	err = ip_mkroute_input(skb, res, in_dev, daddr, saddr,
-			       inet_dscp_to_dsfield(dscp), flkeys);
+	err = ip_mkroute_input(skb, res, in_dev, daddr, saddr, dscp, flkeys);
 out:	return err;
 
 brd_input:
-- 
2.39.2


