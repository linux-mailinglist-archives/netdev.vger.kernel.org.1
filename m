Return-Path: <netdev+bounces-135503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8FC99E282
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526A41F21C3B
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ECD1E231D;
	Tue, 15 Oct 2024 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6iE1FbT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6DD1D9A45
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983494; cv=none; b=aptBS9BTv4Jm9I4xNlhXWncFjvUK3E4as9M4+f4woxrogD83wCzF3iY7N8kXTgClrZZtHmhbR88KMaiKX7npcfFMISL2IHOUU8OMwtdVfGNIeK36+oI2jCK32bImHBjsG+TJi99ML0s6S+JwdhKWHkYT0K62RCX3F8q9UOH7S60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983494; c=relaxed/simple;
	bh=+ZJbHEUCt8uIFKCFjVE0DwAumbjRnoTg0o6D3a8oao4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaV705hjAemm/NuXY8FkSc/M99WP674xTtZU7zyj31YvWKhjZmDJbnmqhm3UjHbDqEfZbVm9S97AvIwufmRYKjrirTO7Isj78vtptwpVZqcp1u89Qo6ces2zuoTZdpgUJeZ8Z+qpTCBYS3HsqTSiAuOKh5DOSHDZwHtGUE82GAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6iE1FbT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728983490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NXl0UsW78ZnOX79ISir//K4p/RwcrOXNWC8dgMLoFgY=;
	b=X6iE1FbTO/2QoYXwTsmcKUeVl1z5+2y5cJGthFPRDRVGuKOYE1VXAjrFyUmKuozaZNmbuz
	7WxP4sm8r4LTDxBDMCDHsTfIa3K+G17xisVWRDLYGVf1sIhM94LZDxy52LCappXBwH2XsP
	gzkKaZPN3AtbYYdlV7q/+YwzWr6GBKI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-A-SqtMNxPKm3LgL0d9szjQ-1; Tue, 15 Oct 2024 05:11:29 -0400
X-MC-Unique: A-SqtMNxPKm3LgL0d9szjQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4311cf79381so26264465e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 02:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728983488; x=1729588288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXl0UsW78ZnOX79ISir//K4p/RwcrOXNWC8dgMLoFgY=;
        b=H6Rsg0TSZxHrWUc77c+e6aJG0lEnCweFRrlzJYkb+fjsVbHimL2wYQl8Y0cN9jD+K5
         SOzRvNDJ9fMKSiKuO1AMTfJlGuweUokSb+IqvyITC5zmV4GTjP5Ab4uBa/exrRG6G5KI
         rhYRs4mJeKDPvKdr3dgSzX4KXWSGW/D5SgVuHeputXtZgVXZiMBLNYzjFeSg3Y9Hv6jq
         n3X71arhzMZ37O3CgoChAA7tyQNJmHQ4YKt4CSfMYb2pXWPRbYDMRPjpW+Hanb/dY4nP
         5Ye47N1p43dDdbdsFrMkBuaTq9Jr72Jrf62dbSbq8yRGjivLoO5fsw249v4C+T6/o2YY
         LnXw==
X-Gm-Message-State: AOJu0YxY/Ra8TxGGCVFzeWWj95Iq9s6MX41wwENjn4GIBkUCtb1L8N+p
	9AI15sasUMY354U14lIw/0xAUshnNYDm1SkFqmywOi4rdixuEszhef7Xm32dQv5gVfHnrSUstSW
	lo+//jykC+Sw8DX9EeAK+EkU5IB4JHDzjR0odLNlhNisVYRO4WkqVLQ==
X-Received: by 2002:a05:600c:3511:b0:42c:b9a5:ebbc with SMTP id 5b1f17b1804b1-4311deeb82dmr136667205e9.16.1728983488014;
        Tue, 15 Oct 2024 02:11:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMWLhpjdNkRWzbAkJsg+ZTFRJJp6S7hDKu63nfTN9MP8cv01JiU9AIGOVEDntUivXgODbWGA==
X-Received: by 2002:a05:600c:3511:b0:42c:b9a5:ebbc with SMTP id 5b1f17b1804b1-4311deeb82dmr136667005e9.16.1728983487654;
        Tue, 15 Oct 2024 02:11:27 -0700 (PDT)
Received: from debian (2a01cb058d23d60030b5722051bf3d85.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:30b5:7220:51bf:3d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43145a98ed0sm2535425e9.0.2024.10.15.02.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 02:11:27 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:11:25 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 1/6] xfrm: Convert xfrm_get_tos() to dscp_t.
Message-ID: <d30306c0b26e4c24e570c82ea62ab5b1a6b37ceb.1728982714.git.gnault@redhat.com>
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

Return a dscp_t variable to prepare for the future conversion of
xfrm_bundle_create() to dscp_t.

While there, rename the function "xfrm_get_dscp", to align its name
with the new return type.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/xfrm/xfrm_policy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 914bac03b52a..dd472e9df059 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2550,10 +2550,10 @@ xfrm_tmpl_resolve(struct xfrm_policy **pols, int npols, const struct flowi *fl,
 
 }
 
-static int xfrm_get_tos(const struct flowi *fl, int family)
+static dscp_t xfrm_get_dscp(const struct flowi *fl, int family)
 {
 	if (family == AF_INET)
-		return fl->u.ip4.flowi4_tos & INET_DSCP_MASK;
+		return inet_dsfield_to_dscp(fl->u.ip4.flowi4_tos);
 
 	return 0;
 }
@@ -2647,7 +2647,7 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 
 	xfrm_flowi_addr_get(fl, &saddr, &daddr, family);
 
-	tos = xfrm_get_tos(fl, family);
+	tos = inet_dscp_to_dsfield(xfrm_get_dscp(fl, family));
 
 	dst_hold(dst);
 
-- 
2.39.2


