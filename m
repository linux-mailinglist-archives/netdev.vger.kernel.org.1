Return-Path: <netdev+bounces-135508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E72FA99E289
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49E328169A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3732C1E379C;
	Tue, 15 Oct 2024 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRDjIy2y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906F61D9A4E
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983514; cv=none; b=cEc2hTAY/1T5GFnQsim/zGfEgOkRuYmLn2vFgSYmDS6WGblakEhTNuO/b8ssryMALk+UNvLJKI8K5Wiexbi5Qcv6IXVsmHE4ZF0zPEpgtbnx1ngbOwASonqGJR1pfX8ud/lrFgSPRq2QRqKwyyNegpKdu3nzp4/7t5dvgiUszRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983514; c=relaxed/simple;
	bh=6NV9yB75n52RBtc0P7s1FtMJM7j+shpju7c7gvxERKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvqhFlWqtz7GT/tVZG8eMwTxFIYcmTbAaO28fts8oMFKHD/wDUPM9mci+Z0cc/2m613cXKS1UdQY98mLCkUCYX8V7iKLe2uH0nQK2K8yFAzSRh4ltRMPFsa8PaKNhukDznkqF/BGx9rZK2hFUJiEj85sSjPWutyRSXPQFpnCsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LRDjIy2y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728983511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwY5lZ54UTFvIQn7Uakl8QJT3XuWTsJfS5e17G7IBQg=;
	b=LRDjIy2y0JJB0j9hQgLzunwcMGg5F3H9eKNT0C3aSzvGjMtRcUT+ykzQVkh7ZmleQgQwar
	7Y47DZQlkKVrYQo1gpx+nTiKJXj2dtJgOrARC2kM9nYJXLiVwbKSyAm0Ei3m6D9Rzh1Juq
	6IVNBv5r/p83ypAWAP/yrxJsJwdSlWE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-gZaWjv0xOWWNNPqkLLUCOg-1; Tue, 15 Oct 2024 05:11:50 -0400
X-MC-Unique: gZaWjv0xOWWNNPqkLLUCOg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d47127e69so1993214f8f.1
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 02:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728983509; x=1729588309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwY5lZ54UTFvIQn7Uakl8QJT3XuWTsJfS5e17G7IBQg=;
        b=G/wj+CvD4nT9mm84AzL6PvmHS1/AHDKsI3Nt6QK1LCH+6q0BaZ6j1S0FgGbWCtvmG0
         JyEzIFfB3aap8os4gYSC0UILEi6JGM1SIC7RTkpNpPiSMXhfOfV8W1v4sVvCMX0blEk/
         2ltrIhN5qSrgEkbG1qQ3mAElGiTGQQ8tn32IkTjfCz6PMY+3arcrDLahaqm19YFCJzsR
         ZGUey+q1XEwSffaCccJ2Si1Ff26kCB7b/0ToSxobyeTpOmlfvThY9qL9FoE3kZKZRzHG
         axlbgnL6mToLVSQkYyA1E8Cb4b03G1OIwX8vjs6agfyDbFCVyI9KDy4GWCgc74mbHsCl
         fbzg==
X-Gm-Message-State: AOJu0YwLz7EJh6+2qGPc+AGYoGJuBgHLlwctUUgk5SZ6qunJ/lrIVDo8
	LpHafzmkbIA7QiUPhZR9yLg2LRa6SDyvfLTQbdOh8130Oa+POivP7+SheJizdgqEu4mMm2Q5ToJ
	RskgNDC6spVHNKBvhaaAoe0/EJ28AKuWp8mUswhLiiQFWDic0ZouaxQ==
X-Received: by 2002:adf:ea85:0:b0:374:c640:8596 with SMTP id ffacd0b85a97d-37d551fb5demr8532852f8f.32.1728983509414;
        Tue, 15 Oct 2024 02:11:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGUf42D4DTW2UkP4WlaqdUzdJkIJrsJHbObiPi26jODF5Mz42s7Ly+1vckzSpoN3T7BPFQ7g==
X-Received: by 2002:adf:ea85:0:b0:374:c640:8596 with SMTP id ffacd0b85a97d-37d551fb5demr8532836f8f.32.1728983508989;
        Tue, 15 Oct 2024 02:11:48 -0700 (PDT)
Received: from debian (2a01cb058d23d60030b5722051bf3d85.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:30b5:7220:51bf:3d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa87c70sm1042223f8f.30.2024.10.15.02.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 02:11:48 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:11:46 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 6/6] xfrm: Convert __xfrm4_dst_lookup() to dscp_t.
Message-ID: <6069820d4452ed34b153c03da3a6ea52c279bda7.1728982714.git.gnault@redhat.com>
References: <cover.1728982714.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728982714.git.gnault@redhat.com>

Pass a dscp_t variable to __xfrm4_dst_lookup(), instead of an int, to
prevent accidental setting of ECN bits in ->flowi4_tos.

Callers of __xfrm4_dst_lookup() to consider are:

  * xfrm4_dst_lookup(), which already has a dscp_t variable to pass as
    parameter. We just need to remove the inet_dscp_to_dsfield()
    conversion.

  * xfrm4_get_saddr(). This function sets the tos parameter to 0, which
    is already a valid dscp_t value, so it doesn't need to be adjusted
    for the new prototype.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/xfrm4_policy.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 342a0158da91..b1968ae756c9 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -18,8 +18,9 @@
 #include <net/ip.h>
 #include <net/l3mdev.h>
 
-static struct dst_entry *__xfrm4_dst_lookup(struct net *net, struct flowi4 *fl4,
-					    int tos, int oif,
+static struct dst_entry *__xfrm4_dst_lookup(struct net *net,
+					    struct flowi4 *fl4, dscp_t dscp,
+					    int oif,
 					    const xfrm_address_t *saddr,
 					    const xfrm_address_t *daddr,
 					    u32 mark)
@@ -28,7 +29,7 @@ static struct dst_entry *__xfrm4_dst_lookup(struct net *net, struct flowi4 *fl4,
 
 	memset(fl4, 0, sizeof(*fl4));
 	fl4->daddr = daddr->a4;
-	fl4->flowi4_tos = tos;
+	fl4->flowi4_tos = inet_dscp_to_dsfield(dscp);
 	fl4->flowi4_l3mdev = l3mdev_master_ifindex_by_index(net, oif);
 	fl4->flowi4_mark = mark;
 	if (saddr)
@@ -48,8 +49,7 @@ static struct dst_entry *xfrm4_dst_lookup(struct net *net, dscp_t dscp,
 {
 	struct flowi4 fl4;
 
-	return __xfrm4_dst_lookup(net, &fl4, inet_dscp_to_dsfield(dscp), oif,
-				  saddr, daddr, mark);
+	return __xfrm4_dst_lookup(net, &fl4, dscp, oif, saddr, daddr, mark);
 }
 
 static int xfrm4_get_saddr(struct net *net, int oif,
-- 
2.39.2


