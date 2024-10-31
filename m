Return-Path: <netdev+bounces-140769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BC39B7F17
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 16:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0FC1C21219
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 15:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5A0136664;
	Thu, 31 Oct 2024 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajR945Qp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682721A265B
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389978; cv=none; b=WnjRb7CZug3cMGbWeUt60j6GlQw6nmxhK68qw9xNNyVGf5gAiCngaoVCLRFk7VoBDFLgFIjoevsgRGHdPHF0383SfwkiQ9MyWvmBWuJxDw2XCiZBzngZs937+nm04IVylEKedagF4I30nG1P4y8jni/g3nIdQoFNdq6q+IYDIaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389978; c=relaxed/simple;
	bh=s0LjKr2O3fNcL650wwfPcZip2r8/NFkj8iTeU93zdwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4X0662AYUuGwxv1pf1K2oJrB385idbcUWO0w72jXCoqOnL/MxBFH3FieLW4aCsdIizGJmp0titwmKvCXg8OL/UZk0i3c6c5NjSI+BJlmZq+HY9NJWjXdtXEBbp67lVhBmBehAHFycuk+tf1HUPTipaoEzAIaxd6Av86epTKQAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajR945Qp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730389975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/mhhX2jWVJfMOCuYXC4ZN+iHkyaB0OlM5THovFV3gFg=;
	b=ajR945QpVbiFT6QeFA/FxTM+x0lHJQ0SbJTtGEsN6ydGbOyH/ajFuDxypS/PoKkKAn7eB9
	pQntfm0fv/GELnj0eR2tbjUpwPf/CLmne3/1vGnZbN0U9pxAmh9Wxm1QIYIA/atqS0vlLV
	xIsML75EFGNhF9ufWw8n8140tvxN5u4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-tWao877sM0aSx5uR0Yku3Q-1; Thu, 31 Oct 2024 11:52:53 -0400
X-MC-Unique: tWao877sM0aSx5uR0Yku3Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4316655b2f1so7960215e9.0
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 08:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730389972; x=1730994772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mhhX2jWVJfMOCuYXC4ZN+iHkyaB0OlM5THovFV3gFg=;
        b=h37+gxFPLINVAt7QIrSBezyaoQk5b1kzbqkSWPEKEGmZ8kKmzPXCXrqiP/myc0LYG0
         YaXwNLDLCJ6VtcX4whnQulCT19mtCwz4QuGkrwI7iqwN57qhOV0BAkJX43HzqELv6RaH
         qNBpbSDb0n3h+cFo4SSKHIPDnJmiBgPQ3+ad5lSYdXYBZtzE1pNbgmPdAcSw0giew+bN
         1Tfdud0eqtTIo9l+oq3y2csH58LetOqsu8hUL5vY3TV0ucBlB0NyrsKOHn9eGRG3wgnT
         zA++xW0ZJeJlkIu9YXjqtNpEtTGoY5Bvr36UF4Rp4esqyraYUr5RWUzeIeLBHo7YYk4o
         cLRQ==
X-Gm-Message-State: AOJu0YxV3g59ma8z2H3KeB5u+wBLLoABaBz7QrcntYDdQVv6bEWBwaTb
	qlN2hgb6SzLXuO5a0Bg7KcaLKoATZRy+SmS5VVzI19ULNRP+PdkGDbijuH+Ls5/l/VJBYzdSbMu
	LdOh7198ThwHsEnwSGbZExhGNO8d1Iv353GImI95mGQn5yi9BkgET8A==
X-Received: by 2002:a05:600c:3514:b0:431:5863:4240 with SMTP id 5b1f17b1804b1-4327b7ea586mr33440075e9.24.1730389972421;
        Thu, 31 Oct 2024 08:52:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy/+hR95kc2lG+hGAyE8tGuv9KLn88Dic4HN0lvCvc5FJtUNU1no8tMoSTxmAqiMz6mv1zMg==
X-Received: by 2002:a05:600c:3514:b0:431:5863:4240 with SMTP id 5b1f17b1804b1-4327b7ea586mr33439875e9.24.1730389972090;
        Thu, 31 Oct 2024 08:52:52 -0700 (PDT)
Received: from debian (2a01cb058918ce002753490a7d66077e.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:2753:490a:7d66:77e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e8466sm61537515e9.2.2024.10.31.08.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:52:51 -0700 (PDT)
Date: Thu, 31 Oct 2024 16:52:49 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Eyal Birger <eyal.birger@gmail.com>
Subject: [PATCH ipsec-next v2 3/4] xfrm: Convert xfrm_dst_lookup() to dscp_t.
Message-ID: <59943ded04c396d73b926ea1544c8e051aebe364.1730387416.git.gnault@redhat.com>
References: <cover.1730387416.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730387416.git.gnault@redhat.com>

Pass a dscp_t variable to xfrm_dst_lookup(), instead of an int, to
prevent accidental setting of ECN bits in ->flowi4_tos.

Only xfrm_bundle_create() actually calls xfrm_dst_lookup(). Since it
already has a dscp_t variable to pass as parameter, we only need to
remove the inet_dscp_to_dsfield() conversion.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/xfrm/xfrm_policy.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 222410fa43e7..9e231c1ece3f 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -289,7 +289,7 @@ struct dst_entry *__xfrm_dst_lookup(int family,
 EXPORT_SYMBOL(__xfrm_dst_lookup);
 
 static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
-						int tos, int oif,
+						dscp_t dscp, int oif,
 						xfrm_address_t *prev_saddr,
 						xfrm_address_t *prev_daddr,
 						int family, u32 mark)
@@ -312,7 +312,7 @@ static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
 	params.net = net;
 	params.saddr = saddr;
 	params.daddr = daddr;
-	params.tos = tos;
+	params.tos = inet_dscp_to_dsfield(dscp);
 	params.oif = oif;
 	params.mark = mark;
 	params.ipproto = x->id.proto;
@@ -2721,9 +2721,8 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 				family = xfrm[i]->props.family;
 
 			oif = fl->flowi_oif ? : fl->flowi_l3mdev;
-			dst = xfrm_dst_lookup(xfrm[i],
-					      inet_dscp_to_dsfield(dscp), oif,
-					      &saddr, &daddr, family, mark);
+			dst = xfrm_dst_lookup(xfrm[i], dscp, oif, &saddr,
+					      &daddr, family, mark);
 			err = PTR_ERR(dst);
 			if (IS_ERR(dst))
 				goto put_states;
-- 
2.39.2


