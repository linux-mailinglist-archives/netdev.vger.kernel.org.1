Return-Path: <netdev+bounces-140767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DAE9B7F15
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 16:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001891C21347
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 15:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6FC13664E;
	Thu, 31 Oct 2024 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ec3j+rXg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A5C6A019
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389965; cv=none; b=uMP5Kpc3sPIn27tc71LC898i2Z+NiNk3oAaA0HzqUWl3NfROT3ZW8a0awk/4kGkPNZc5LC625LtWBBy7Lk97P1rR1o03bXS1Ag/F1a0iLkO45sbWaEPtNcVeIwr4O989Jz2BnFlXDG9ox+15/XiTvM95bDNRLqXE9uUUtVr/gkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389965; c=relaxed/simple;
	bh=SH51NSo6hLlWLgHXnY5JBfRRWL4fJg1cmITcWVgxGYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YO5vAb1h5oR/QXuavoti+y2TY3BPoOAqP4lfvzOMV2ZojlSdzFZuutSXLWgp6mJwWSdqE4RN3X50lbuIiQcI3iMrb9+sJSiIvN3PFuNvhX1PNMb33oh4E0TLD7RBsYVS2PyJ58BB7MxisLOme0miQA2ynrhHTCdFH0IrrwpyyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ec3j+rXg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730389961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ejv1aLUSOfwGysIA9jTHFTpJtib9X7E8Le2y4iBvoQ=;
	b=Ec3j+rXg1DDOtVtQYuEaWlRb5sITGJyIt1uMf5a35MGbaUkZvYOcLVhjaSXRNJKWv+JqSk
	dN1vALOtYp0TEmEvdTQ/FJiL/MVyG9mocQWzxwL5PP1p6tK0MJvYtJJuezDVK2XvE7REY2
	1b78YbS97oqCmWVfvEw8pU5P5fLGD5w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-1raB9HH1PJaBcQdFp2qznA-1; Thu, 31 Oct 2024 11:52:40 -0400
X-MC-Unique: 1raB9HH1PJaBcQdFp2qznA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4316e2dde9eso9022615e9.2
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 08:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730389959; x=1730994759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ejv1aLUSOfwGysIA9jTHFTpJtib9X7E8Le2y4iBvoQ=;
        b=hQV3UGMaGHqxwlSodZo94269HzRj1+7rvi6ST6F5cVUo8jh25SMwAoYxbI03qCuFTd
         toWLwluoa/2Oj+M4cyom2HhxXVgC8dtjY8viwNUljdieRqeQsQ5t6TxqxnAGJN1AJwaC
         Jukzgc3PTLoPbJ1K8vAvG5QNWyUz8bPGHyXKPc/TyntLuES6AuxrxKWFNYUq97EfabMu
         Bru13tVDH0ci0SRd4+UyN+fVCOu7P5UeywXksE8Ob2YTjzPMrJebyaol8sH505xFa6VP
         uRrXuQK6WQjCHEhZMcQC7owD9TlR7jHuv4ht5bPvnavaw7yzeovYiqcmadTpg8GD47+e
         EwPw==
X-Gm-Message-State: AOJu0Yw/hyOw1XWnuwd+MhuVEtgPrInaUGxcJ2wZepfKQFCNo22guewm
	uwBS0eDyPUfzVEuRPEd18wlVPc+JRfnLqP6Z/dF8cpy/UXZPDCWoGZyXdSHvOsKGVO2O1Pd2uAf
	z3zN92u+MN5K0lSZXi3gEADDBmizX73WA7c2/ijG++/jWtA87b+vzMw==
X-Received: by 2002:a05:6000:1867:b0:37d:5318:bf0a with SMTP id ffacd0b85a97d-381c7a46489mr456023f8f.1.1730389959246;
        Thu, 31 Oct 2024 08:52:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfGuerBc/ibv45+h3FVd1AJ5wWrpfNGR6Xm8sSUWtQe9Xc1VVsatB/cY4VRLU0ZB6DBComCA==
X-Received: by 2002:a05:6000:1867:b0:37d:5318:bf0a with SMTP id ffacd0b85a97d-381c7a46489mr456005f8f.1.1730389958909;
        Thu, 31 Oct 2024 08:52:38 -0700 (PDT)
Received: from debian (2a01cb058918ce002753490a7d66077e.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:2753:490a:7d66:77e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d698405sm32393315e9.41.2024.10.31.08.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:52:38 -0700 (PDT)
Date: Thu, 31 Oct 2024 16:52:36 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Eyal Birger <eyal.birger@gmail.com>
Subject: [PATCH ipsec-next v2 1/4] xfrm: Convert xfrm_get_tos() to dscp_t.
Message-ID: <5b34d13b962afc226c4ad1246ef57e502c047fab.1730387416.git.gnault@redhat.com>
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

Return a dscp_t variable to prepare for the future conversion of
xfrm_bundle_create() to dscp_t.

While there, rename the function "xfrm_get_dscp", to align its name
with the new return type.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/xfrm/xfrm_policy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index a2ea9dbac90b..077e1c9b2025 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2576,10 +2576,10 @@ xfrm_tmpl_resolve(struct xfrm_policy **pols, int npols, const struct flowi *fl,
 
 }
 
-static int xfrm_get_tos(const struct flowi *fl, int family)
+static dscp_t xfrm_get_dscp(const struct flowi *fl, int family)
 {
 	if (family == AF_INET)
-		return fl->u.ip4.flowi4_tos & INET_DSCP_MASK;
+		return inet_dsfield_to_dscp(fl->u.ip4.flowi4_tos);
 
 	return 0;
 }
@@ -2673,7 +2673,7 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 
 	xfrm_flowi_addr_get(fl, &saddr, &daddr, family);
 
-	tos = xfrm_get_tos(fl, family);
+	tos = inet_dscp_to_dsfield(xfrm_get_dscp(fl, family));
 
 	dst_hold(dst);
 
-- 
2.39.2


