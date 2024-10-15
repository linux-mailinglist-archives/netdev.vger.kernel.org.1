Return-Path: <netdev+bounces-135504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C36E99E283
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B5FDB22A62
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50CA1E2847;
	Tue, 15 Oct 2024 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CINK5LLN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525531E2825
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983496; cv=none; b=FgIkvN/iwLPOXIUUct8rb6dC8x+dnQtGJe/1lmK/PcsnW2OTVmO40w35kvIHgHSfn7vW+T31f5TL5eWfdvPsdN+vdo0Pe7m2wTPBOLhtV7xTni96UcfZ2av1MzKMGkVbRkoHAYsEYaAqvNZGmLP7QUmjfIkUGmnvqEJztS8wAtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983496; c=relaxed/simple;
	bh=ci6SYSv24/2m6zH5eR0zepGnoDfgz892dKFFJC7LoQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVvTgyVAM505EOHgSuFLCzaT9P0U7Y+YTg6xE4QGlVs1Fp7PxDVDE+wft3WVBgh9wy6LqVcjCs8Qw7QDGyDlzjSOoZCaE2far6qipOBBWfFM3LBduWaT5KIDU6vjynZXbbhj7AD3j9uZcMPUFoPCZ1DXnG+k4IWpepzA+ipBxVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CINK5LLN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728983494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJoTE8zVpQ7BdycHoKDA0BPiIQr42d4xFhr1RoFPvsM=;
	b=CINK5LLNgkVJo+Z7L2g5Dd87Xp9wFr6VPakcQJ+RCuUSlYHt8RRv+t8EOt8mwvNF0W2lcn
	Y+FooUhPGAMmxI84CVKi2DSyrxqWJRnql2eX/+8vjP85SsaX9+B0wpWVbMPVzR1naPt4s7
	AWMeShsYBw+fKaM5NmS/2uCTcBt7Ep4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-3I4b0FWiPPWVb9nzRs7Nlg-1; Tue, 15 Oct 2024 05:11:33 -0400
X-MC-Unique: 3I4b0FWiPPWVb9nzRs7Nlg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-539f067414fso1623626e87.2
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 02:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728983491; x=1729588291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJoTE8zVpQ7BdycHoKDA0BPiIQr42d4xFhr1RoFPvsM=;
        b=RqnKyH52welV5iaI9goI8f5Gz396bZd/5DBba4h2YfyssjHLadydaVfbhiETgY/kLZ
         ABOpgR+Cj0twhrn6e1n+JKcJXBFAYfMInA+5iW0qo9bMrVLBlneK2o14SRYbEZEnt5M3
         PkSm91FyzJNu/ts5u/0KaM3ApXorcXLk1UxtT8kxamn9oP5Z1SOz8/zWO6fHfoiEProW
         g5m2ZpQSsK7KVj+R27l91QgEsx5TQidVBVrjhtaU7Utyf48JSzMyNEfG/8ajtVWv0fvh
         KT4PdbcjmpiHLdmOfccSS8WT0tlrM4/S/yC+ivAsk3dcNhrp5m2yM9rfsZoLUJwpztS7
         t4pA==
X-Gm-Message-State: AOJu0YzStESwr7MTuE12ZuPN/QMHXRcBk29tt1tpkMjE+etU2xZbrbdj
	WN538IlqmE2nPxWU6brRSXa06sFJvyk+px6YeDg7M425WEHb/v715SnMtSV+hTUWq8YOkSTboqh
	1YtzS4D8A4cggT6GMGqL7jXFfyBHlZEOuFbFgcLVwi2W+bpmtbhDu5Q==
X-Received: by 2002:a05:6512:110e:b0:539:fc75:99ae with SMTP id 2adb3069b0e04-539fc759ab3mr2650481e87.31.1728983491471;
        Tue, 15 Oct 2024 02:11:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELc49DSy1nmoHloMfBd3oO+f8GzPHILsMYgroEHw5gpdoXv19MwT+DwubKifjOA6ul0KfB0Q==
X-Received: by 2002:a05:6512:110e:b0:539:fc75:99ae with SMTP id 2adb3069b0e04-539fc759ab3mr2650467e87.31.1728983491048;
        Tue, 15 Oct 2024 02:11:31 -0700 (PDT)
Received: from debian (2a01cb058d23d60030b5722051bf3d85.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:30b5:7220:51bf:3d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431487c194asm695955e9.21.2024.10.15.02.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 02:11:30 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:11:28 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 2/6] xfrm: Convert xfrm_bundle_create() to dscp_t.
Message-ID: <bbdb73161122ac0f87aa215255c733f44bfe411f.1728982714.git.gnault@redhat.com>
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

Use a dscp_t variable to store the result of xfrm_get_dscp().
This prepares for the future conversion of xfrm_dst_lookup().

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/xfrm/xfrm_policy.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index dd472e9df059..c6ea3ca69e95 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2641,13 +2641,13 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 	int header_len = 0;
 	int nfheader_len = 0;
 	int trailer_len = 0;
-	int tos;
+	dscp_t dscp;
 	int family = policy->selector.family;
 	xfrm_address_t saddr, daddr;
 
 	xfrm_flowi_addr_get(fl, &saddr, &daddr, family);
 
-	tos = inet_dscp_to_dsfield(xfrm_get_dscp(fl, family));
+	dscp = xfrm_get_dscp(fl, family);
 
 	dst_hold(dst);
 
@@ -2695,7 +2695,8 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
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


