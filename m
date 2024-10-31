Return-Path: <netdev+bounces-140768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2639B7F16
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 16:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5782B20801
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 15:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A872B13664E;
	Thu, 31 Oct 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqmRsM4K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF2E136664
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389972; cv=none; b=QBtpF9PacHWih3VVxy7VFaNOd9UzC6guL8iLo+stP9JXKbSFltf9LBNWh6lhw9ztcnJSuUXIdoR/VIKv2xhbWAix4/+kFiX91zATiJs4NxJOdtdzmI+Kh774CE0GXgiIbkAp1X4QaEmqviFHS1kLD8ZhvrZeCknjLd0Nu3ZkRmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389972; c=relaxed/simple;
	bh=qSPrZ62DOpVQYFN4aRLbKmpOKm8H4jBLjkAX/sZjt88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7hSA793FHP70aBwtnQpjmF1/kh7M+qMPRfDTzTmlJEmVVijgWX1D0MNjTAjMhkQJk94q6XxDW5jCPFpyt82AfsM74AfTasoHYECD8f8H2iNuiCQjxr1Ko4N9Mlc72K0ExAYU50mW2eCi9QXPATPkLPzFsDOVs5y0txqMHgPClE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GqmRsM4K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730389969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7bEllOruw+nJ2hlVrPx0euQnj0LrVJdNE3PIAWDIu40=;
	b=GqmRsM4KT0DLGBHpq/PLUcUnOA4qfYh7+X50Wp77CJCoaCAQsC92XjlOW5he03A5iwTKB+
	6GMycVMV/0VR3bVIVNtM6ZlyVOyyp67z4MBbeWkFqKZjqmoEF1p6PweDgq8TxBHRGje2Ga
	HRq9Os3BW3ToHvGYNxqKQYxmfJ52mw4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-M9IKoLneMyiyGfhPTssyhA-1; Thu, 31 Oct 2024 11:52:48 -0400
X-MC-Unique: M9IKoLneMyiyGfhPTssyhA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d3e8dccc9so587506f8f.1
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 08:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730389966; x=1730994766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bEllOruw+nJ2hlVrPx0euQnj0LrVJdNE3PIAWDIu40=;
        b=bndxK5BsYg3jPNL3LHmsomzVNMPYOPkZUYSZ4zDvze7CvNbGwPiwMRFJYtXuY3lmmE
         RSZAoFzAbnd5mlHlqI8vOPyb31dPs3JJRtncUon5Bhj6dq5LiEnvnz7Sez4cY5X/ms01
         58xYheJkKnutwgHG8uEmIcTcgiDaobc84HqHVu3G/KIdAPjxIIwNFCxMnCZFJJizl3nY
         rMCC4SbWhAosjE3skHTIKi0yF5WspKgunWQkk/hHksMA9lMTUnR8wxfkwROp8M6ZVoLm
         RGSxN+appn1IA7/unQEYm0lZBN5crnASg3YNG/vbynN0tgdvwXSxIZzL3dKsqIOX4Kz8
         o2qg==
X-Gm-Message-State: AOJu0Yw8xa9fSF3+884oBzvE408s0/gw1e1kTKjJzdGRIcvWnY40SOpS
	RPmQAT3YXB6IenFCUao+Bg+S0WoQLD+dJHiA70qr9NZTEm5jQp6TeXHeZ+/tbHy3T0hQ6eHQzuB
	UONKkvl3YEKcoQw86D1rAxVy471l88zuYE3MSa3/trnoKHS9ORgnEO94cS8MVlw==
X-Received: by 2002:a05:6000:1884:b0:37d:4dd5:220f with SMTP id ffacd0b85a97d-381be7d62ecmr2997937f8f.26.1730389966003;
        Thu, 31 Oct 2024 08:52:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUNCtDR9N2ADj3ZRsLkYxbo0wr+iTi58OMILgkstz5vR9tBaVrOit3fN8D3iT3YynhC0u85g==
X-Received: by 2002:a05:6000:1884:b0:37d:4dd5:220f with SMTP id ffacd0b85a97d-381be7d62ecmr2997917f8f.26.1730389965560;
        Thu, 31 Oct 2024 08:52:45 -0700 (PDT)
Received: from debian (2a01cb058918ce002753490a7d66077e.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:2753:490a:7d66:77e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7bf7sm2567556f8f.9.2024.10.31.08.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:52:45 -0700 (PDT)
Date: Thu, 31 Oct 2024 16:52:43 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Eyal Birger <eyal.birger@gmail.com>
Subject: [PATCH ipsec-next v2 2/4] xfrm: Convert xfrm_bundle_create() to
 dscp_t.
Message-ID: <4d3f3d32274bb4a652bd718f50f489aceb0c0405.1730387416.git.gnault@redhat.com>
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

Use a dscp_t variable to store the result of xfrm_get_dscp().
This prepares for the future conversion of xfrm_dst_lookup().

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/xfrm/xfrm_policy.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 077e1c9b2025..222410fa43e7 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2667,13 +2667,13 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 	int header_len = 0;
 	int nfheader_len = 0;
 	int trailer_len = 0;
-	int tos;
 	int family = policy->selector.family;
 	xfrm_address_t saddr, daddr;
+	dscp_t dscp;
 
 	xfrm_flowi_addr_get(fl, &saddr, &daddr, family);
 
-	tos = inet_dscp_to_dsfield(xfrm_get_dscp(fl, family));
+	dscp = xfrm_get_dscp(fl, family);
 
 	dst_hold(dst);
 
@@ -2721,7 +2721,8 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 				family = xfrm[i]->props.family;
 
 			oif = fl->flowi_oif ? : fl->flowi_l3mdev;
-			dst = xfrm_dst_lookup(xfrm[i], tos, oif,
+			dst = xfrm_dst_lookup(xfrm[i],
+					      inet_dscp_to_dsfield(dscp), oif,
 					      &saddr, &daddr, family, mark);
 			err = PTR_ERR(dst);
 			if (IS_ERR(dst))
-- 
2.39.2


