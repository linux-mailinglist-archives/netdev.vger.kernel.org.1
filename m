Return-Path: <netdev+bounces-137818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259C29A9F15
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5B928218F
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBFD186E43;
	Tue, 22 Oct 2024 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIOxCpRW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07081991C2
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590488; cv=none; b=MfGkBPp7f0gIidFYU7hnpsNKtA1o0HXzCq+ORpISEzFNkC6xka/tqtNL7qE+t6FVqcSE/rVvJwQKfjstEf7VCjVUufKfN1CCZ8kSB8zG6W55jStDvKSWTbVIjtzfBBIMVoaHoIKq8olbTqYiTbXXI9nRE0fuIFAC80L9Sqs7BSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590488; c=relaxed/simple;
	bh=KIdaqy7A+65IXdgQaR5pZnmBq+Y7L8FUNjZYIuvlgUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGfULExVEnnnNVtUeR8hhjrRJ82OZBuQVFwqegi9j6jcH1oJ2BZrrgDpKMPCtwnSJi1UrXIwFeJsb0XoBzcnAn37Xn0P0Jkoac7B+ny68MwUqpxpfcbEppEc6pW5LFr0CPThfkZaHhrhKVRG+euVxGeBoefCNThPZJCdsp9KTNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IIOxCpRW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729590485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NiSEn8UX8xukg46jYZnpsEwLTmkrKGxpQ5FVs2rq4vY=;
	b=IIOxCpRWxgPDNIzVyx5ygLdX/K3k7OnD8ebgay5xS+OED38DGZXwIXucChtaAZg2sedKpT
	ZgcAgeZ40cKu5KE017dPNFCkOQSX6E9B5XDbo/fIiLhQMXMZLnQUQ3ED3w+pgcOid266U/
	SScIEk5uOgZtMn/5Fv8MJWlL8OyJEyo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-hsvfLZrQNm-tgE9ABWWy1w-1; Tue, 22 Oct 2024 05:48:04 -0400
X-MC-Unique: hsvfLZrQNm-tgE9ABWWy1w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d4922d8c7so2856819f8f.1
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 02:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729590483; x=1730195283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiSEn8UX8xukg46jYZnpsEwLTmkrKGxpQ5FVs2rq4vY=;
        b=sJk+h0Y0EskgydEonbCko3sD4DQz99j7ENiuzpv5JZThuq/1P0FcO/efgDGQgqerVS
         lvTWUA0Rtn9Gh/HUE2XV0vH7GRNP2PycsJhkvwtLZP+KG+UMUifuN7jMydqXueAct1I8
         MWU21sPn+hgnR3ecjIOpU90OWJU16qnoHXuQgaDXOWalQvbyXzy+JdhdAWO2FMGlmyip
         +hFC8biFYi+faNQhexhG8egBH4f+ja6ww4tFiZlolnezfGa0ka7ylbxTb+zaStxcsHCt
         joPP1xQDWrIuP0+U4ozxc3FVI7W0jiGyg+BgjIns9ZONaxYqZmFIWb1lkZ772NxE2tjy
         K7+g==
X-Gm-Message-State: AOJu0YxOhhnE6hh/ulOr0lCGLJff0np78Dpa08vGv75OcFBf1maTvljl
	u2WQEKO+N/+osdGPaboSNhJ3AC495WARPhkPzukGgplI0CHml3/o53CbBu+n1zsW9UL9KpO2Kpk
	faB/HzqLoXRjYyS94J09oS9kJSTasU4gi5oljDSrR/K+uMRxjzvhlsQ==
X-Received: by 2002:a05:6000:5:b0:37d:3985:8871 with SMTP id ffacd0b85a97d-37eab4ed358mr9903937f8f.39.1729590483254;
        Tue, 22 Oct 2024 02:48:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn0RENmZXzBsysNBFuMBEMMi7RPw1Ub+yXzC6Ni0Eu9BLea3/Cm0XL4ffehfy3IVT+UVoKxw==
X-Received: by 2002:a05:6000:5:b0:37d:3985:8871 with SMTP id ffacd0b85a97d-37eab4ed358mr9903921f8f.39.1729590482886;
        Tue, 22 Oct 2024 02:48:02 -0700 (PDT)
Received: from debian (2a01cb058918ce00b54b8c7a11d7112d.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:b54b:8c7a:11d7:112d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94346sm6257931f8f.86.2024.10.22.02.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:48:02 -0700 (PDT)
Date: Tue, 22 Oct 2024 11:48:00 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 1/4] ipv4: Prepare fib_compute_spec_dst() to future
 .flowi4_tos conversion.
Message-ID: <a0eba69cce94f747e4c7516184a85ffd0abbe3f0.1729530028.git.gnault@redhat.com>
References: <cover.1729530028.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729530028.git.gnault@redhat.com>

Use ip4h_dscp() to get the DSCP from the IPv4 header, then convert the
dscp_t value to __u8 with inet_dscp_to_dsfield().

Then, when we'll convert .flowi4_tos to dscp_t, we'll just have to drop
the inet_dscp_to_dsfield() call.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/fib_frontend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 53bd26315df5..0c9ce934b490 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -293,7 +293,7 @@ __be32 fib_compute_spec_dst(struct sk_buff *skb)
 			.flowi4_iif = LOOPBACK_IFINDEX,
 			.flowi4_l3mdev = l3mdev_master_ifindex_rcu(dev),
 			.daddr = ip_hdr(skb)->saddr,
-			.flowi4_tos = ip_hdr(skb)->tos & INET_DSCP_MASK,
+			.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(ip_hdr(skb))),
 			.flowi4_scope = scope,
 			.flowi4_mark = vmark ? skb->mark : 0,
 		};
-- 
2.39.2


