Return-Path: <netdev+bounces-135506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD24F99E286
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E032830B0
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5EA1DF261;
	Tue, 15 Oct 2024 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMfgJGaM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132A81E32CF
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983506; cv=none; b=c390tOIgaZa2V0qAuoIaLgmc2iiJwav6E6oD4HrLklSiRFpbFNiiF9+7TJjvlOiaVyOGEzSPItEv6oHKrgdhAAkiAfWX6a1XiPJdYryxpoArGo1I/eawnY/6sfQcJj+X7NP/KCc5uqjePTShLHj+/tYGvagabMLrLuDHFh3hfkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983506; c=relaxed/simple;
	bh=hzebdBjXmg/LyQIPzZ1kj2lccxTuBm/v0jaCRSELemY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6/6T90bHkl+jIwN6lE1TFh8rLfjou3w07F0xu6SgU79rOp2Z9+D1oOzhUiNdGiR/Vdrm/ABJBBf9+mHH4ZJIAEPntFlwX1t/gdzlSKj90KkfA4fuKWgwqUhk6AKNPp7x8BE8K4vWTwwdFn8aadN8AihTje7MgOmcqiNk3XRjEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LMfgJGaM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728983502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lyxldozdxkCmKgDHt1NxVMWVKztWFVpOxa3mceHgoVc=;
	b=LMfgJGaMEX7t81Kcz5MvAuNPmxvQIeYvbMKhLWDHG8/XWr83QpDIY1QA9dcBhF47eBiRp9
	7dwtalKzgpjCqrfjcJwFpOjk3todb/8IMzygnixvlLO+YYt1IFk3YrqPZJDvdIJbKdRUNd
	96Mp6hRT70a2lAT4NKCZs7foBLQ+Gnw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-tfqqdzrcNSSvEliIsREV4Q-1; Tue, 15 Oct 2024 05:11:40 -0400
X-MC-Unique: tfqqdzrcNSSvEliIsREV4Q-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-539ed93e08aso1822741e87.3
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 02:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728983499; x=1729588299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyxldozdxkCmKgDHt1NxVMWVKztWFVpOxa3mceHgoVc=;
        b=D+JfwIkgd8EXCIYm8AJa0C0vWUzIK0EQKVRVV8gpxyyPk//mEjaV8eCGk2Nqb5UgUW
         1nKSfP+VkXEEeBPEafc/is4TUtKADjXs52sOURbIvewWX3FZqtnZdyvxyxPWWy7dqbtz
         Q90WWvWYWfUnpxBO9d2vx/odo0Z1KowbhgEKI1nOwwfOdTG+MS/GOBlesXqE6VQziU/8
         IV+VFS244AFQmj7tRJEYYaoftc1zWmBqU6zRTPPM2Y3xVdG4rApZtDqFRbrXoypjIAjS
         05cGrQsRE4rVat74CuXSlhpK8Gx0bot6AKVId0JIkF7bfecN+2qjpI7LxNkODTM6kVB0
         EfRQ==
X-Gm-Message-State: AOJu0YwcFU/eGGYakShpc4o3k+ZxZ6AxPZvX/tXRF20ifzJXbj7WHxsa
	+P0ouphNr4KVmq5Qhg9gexIpoRlpZjLr8zjungJ1RLafCJGUPihKHV+rsnxMafrBiYRYYk8DLHa
	GxsWvFMoR7A7FRQTRpB9YBI2rmhINX6Fj2Q1X7hpON4+8GGf08oymHA==
X-Received: by 2002:a05:6512:3a8d:b0:539:d539:db3 with SMTP id 2adb3069b0e04-539da3b41f9mr7669819e87.5.1728983499304;
        Tue, 15 Oct 2024 02:11:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrF4T2xgP9X/y2YCqijhuoJgh3p+++EhzS4qxuHtHufEGPegZZQWpg+4YEw/ykx26wa3i8IA==
X-Received: by 2002:a05:6512:3a8d:b0:539:d539:db3 with SMTP id 2adb3069b0e04-539da3b41f9mr7669784e87.5.1728983498863;
        Tue, 15 Oct 2024 02:11:38 -0700 (PDT)
Received: from debian (2a01cb058d23d60030b5722051bf3d85.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:30b5:7220:51bf:3d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6b31b9sm11561085e9.29.2024.10.15.02.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 02:11:38 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:11:36 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 4/6] xfrm: Convert __xfrm_dst_lookup() to dscp_t.
Message-ID: <fad338689ca44790f613e05cc6064248ef064d5c.1728982714.git.gnault@redhat.com>
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

Pass a dscp_t variable to __xfrm_dst_lookup(), instead of an int, to
prevent accidental setting of ECN bits in ->flowi4_tos.

Callers of ip_mc_validate_source() to consider are:

  * xfrm_dst_lookup() which already has a dscp_t variable to pass as
    parameter. We just need to remove the inet_dscp_to_dsfield()
    conversion.

  * xfrm_dev_state_add() in net/xfrm/xfrm_device.c. This function
    sets the tos parameter to 0, which is already a valid dscp_t value,
    so it doesn't need to be adjusted for the new prototype.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 include/net/xfrm.h     | 3 ++-
 net/xfrm/xfrm_policy.c | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index b6bfdc6416c7..18c0a6077ae9 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -19,6 +19,7 @@
 
 #include <net/sock.h>
 #include <net/dst.h>
+#include <net/inet_dscp.h>
 #include <net/ip.h>
 #include <net/route.h>
 #include <net/ipv6.h>
@@ -1764,7 +1765,7 @@ static inline int xfrm_user_policy(struct sock *sk, int optname,
 }
 #endif
 
-struct dst_entry *__xfrm_dst_lookup(struct net *net, int tos, int oif,
+struct dst_entry *__xfrm_dst_lookup(struct net *net, dscp_t dscp, int oif,
 				    const xfrm_address_t *saddr,
 				    const xfrm_address_t *daddr,
 				    int family, u32 mark);
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6e30b110accf..a1b499cc840c 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -270,7 +270,7 @@ static const struct xfrm_if_cb *xfrm_if_get_cb(void)
 	return rcu_dereference(xfrm_if_cb);
 }
 
-struct dst_entry *__xfrm_dst_lookup(struct net *net, int tos, int oif,
+struct dst_entry *__xfrm_dst_lookup(struct net *net, dscp_t dscp, int oif,
 				    const xfrm_address_t *saddr,
 				    const xfrm_address_t *daddr,
 				    int family, u32 mark)
@@ -282,7 +282,8 @@ struct dst_entry *__xfrm_dst_lookup(struct net *net, int tos, int oif,
 	if (unlikely(afinfo == NULL))
 		return ERR_PTR(-EAFNOSUPPORT);
 
-	dst = afinfo->dst_lookup(net, tos, oif, saddr, daddr, mark);
+	dst = afinfo->dst_lookup(net, inet_dscp_to_dsfield(dscp), oif, saddr,
+				 daddr, mark);
 
 	rcu_read_unlock();
 
@@ -310,8 +311,7 @@ static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
 		daddr = x->coaddr;
 	}
 
-	dst = __xfrm_dst_lookup(net, inet_dscp_to_dsfield(dscp), oif, saddr,
-				daddr, family, mark);
+	dst = __xfrm_dst_lookup(net, dscp, oif, saddr, daddr, family, mark);
 
 	if (!IS_ERR(dst)) {
 		if (prev_saddr != saddr)
-- 
2.39.2


