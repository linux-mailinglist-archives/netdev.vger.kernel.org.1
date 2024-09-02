Return-Path: <netdev+bounces-124168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B101E9685C7
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 13:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E202E1C22414
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 11:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9BB185B7D;
	Mon,  2 Sep 2024 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHYVGbsZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC35185924
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275256; cv=none; b=CtUqN1PgzvU8PXEsUqCt57g9XFuddIYHIQxM//pPO48P88Y+0DpI49qKRQtB0DXFVuJOa0fwTEjskRKg1nOvzETDJ4EOzECU6febMZvtCghVvQmRZsqV+IKFEIVKph7iY5SWtaitYhKFsnrkl78mR8hLYgESF+lIGYWNOWLPeUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275256; c=relaxed/simple;
	bh=lgoVdEjkCHtnhQaw2o9mFkAsGRddjRUGy+FMxyaF90Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bewvk25VJdeP1Bp9fi+h3K+P5dXf69mtxpB8CvGmxZlP4eHeTWT1Ot/fZQkfSC71eoR2O/bpzqfsc86upn1/UDpzFSCxUWFjGUBCRRk4Na/VAPkpZchCiGbA4fHm/ERyakvinkhlcFbBB3iDdTIUISUMyh5VO4ipoxrp61UvAvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHYVGbsZ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d8b679d7f2so915560a91.1
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 04:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725275255; x=1725880055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNyvk65/fK+RJp+iqo5RubJr4BWOuyyk9Y5lj4xZrFs=;
        b=lHYVGbsZ2/R/8FlwUD4b+XL9Ctgliy4Lc7/22gyjE3aeBEhutjtwVZqhgoey+U5EKv
         CC8qC6mW+sr3dQp15Jlrm2cVcxNt2uuM/NI8peUY4/Sj4FH0ZlM/hSLuJGaRq23z6z0Y
         4POG3tOMZm2LJs/CLzm6YyQNBzGqSF/YDICkbzPASXSt7uzm2mf77n/+gbchcMDzVaV9
         pQyppmQ5WuN/oKwEv8638jc/hJwDDYexxst7RjrUpb9f+tv5RnVClGAOtq2B5+umj7NY
         lOHQnnpEIgr42azFj1pr5hm6sD3SVIyb9TT7GL9Dw0PMV/KVQjG09HQ3FDcvOWPQDdlo
         78Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725275255; x=1725880055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNyvk65/fK+RJp+iqo5RubJr4BWOuyyk9Y5lj4xZrFs=;
        b=hnBxeu+ouS7RK37n7GUuYphJxmDpTwyMfPMdyxvl9Nvk889EEwJIrjx3HVC5B1ESRe
         pSNajDQrl9IK9j/unCjfSb0gt6NwY5+u4e/Gf7xoH67toi81lYKvAH/BqYH9RZa7WEGI
         fyX6Q5c5kTH4+gCiAqC+wHMteQpHSmxqIJ4vq0uXDrZ284Z/k1ksjxdWhMsQRhwxnr5O
         VtzpxcktwVt+qCOk2ieL+cATDTKcZ8W3B0gOjxUmXpkh6zPvfS1GQC7IDPpizfor2MJE
         i4p+ksFO+QYMsQUVB44rdf86GMrL2KYoar2sJeTBeVOXksEXv+Jk0UlfrhDRZO9XqD4L
         UEtw==
X-Gm-Message-State: AOJu0YwUZOyFRnraaDitJ/KM5ssppWBQtHnskyteutocdDrzd0lGQSnO
	GmsczmZtgZxJQxTUk2fygu6H/wcnmjHnb7t/JAn3d4rB1lFGMPNe0tCidP8h
X-Google-Smtp-Source: AGHT+IGYYDXchIhpZ1b0mFQtN3aATMu+ImJL8kVDXv9WSF8FspNf7PZ8ZA+qFWtGMBQnFwXxXLMt9Q==
X-Received: by 2002:a17:90a:5143:b0:2cc:ff56:5be3 with SMTP id 98e67ed59e1d1-2d8561ce627mr13964079a91.19.1725275254731;
        Mon, 02 Sep 2024 04:07:34 -0700 (PDT)
Received: from localhost.localdomain (syn-104-035-026-140.res.spectrum.com. [104.35.26.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d88edd4f90sm4797144a91.26.2024.09.02.04.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 04:07:34 -0700 (PDT)
From: Eyal Birger <eyal.birger@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	dsahern@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	devel@linux-ipsec.org,
	Eyal Birger <eyal.birger@gmail.com>
Subject: [PATCH ipsec,v2 2/2] xfrm: respect ip protocols rules criteria when performing dst lookups
Date: Mon,  2 Sep 2024 04:07:19 -0700
Message-Id: <20240902110719.502566-3-eyal.birger@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902110719.502566-1-eyal.birger@gmail.com>
References: <20240902110719.502566-1-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series in the "fixes" tag added the ability to consider L4 attributes
in routing rules.

The dst lookup in the xfrm code was not adapted to this change, thus
routing behavior that relies on L4 information is not respected, which
is relevant for UDP encapsulated IPsec traffic.

Pass the ip protocol information when performing dst lookups.

Fixes: a25724b05af0 ("Merge branch 'fib_rules-support-sport-dport-and-proto-match'")
Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
---
 include/net/xfrm.h      |  2 ++
 net/ipv4/xfrm4_policy.c |  2 ++
 net/ipv6/xfrm6_policy.c |  3 +++
 net/xfrm/xfrm_policy.c  | 14 ++++++++++++++
 4 files changed, 21 insertions(+)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 0f49f70dfd14..2a98d14b036f 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -356,6 +356,8 @@ struct xfrm_dst_lookup_params {
 	xfrm_address_t *saddr;
 	xfrm_address_t *daddr;
 	u32 mark;
+	__u8 ipproto;
+	union flowi_uli uli;
 };
 
 struct net_device;
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index ac1a28ef0c56..7e1c2faed1ff 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -30,6 +30,8 @@ static struct dst_entry *__xfrm4_dst_lookup(struct flowi4 *fl4,
 	fl4->flowi4_mark = params->mark;
 	if (params->saddr)
 		fl4->saddr = params->saddr->a4;
+	fl4->flowi4_proto = params->ipproto;
+	fl4->uli = params->uli;
 
 	rt = __ip_route_output_key(params->net, fl4);
 	if (!IS_ERR(rt))
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index fc3f5eec6898..1f19b6f14484 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -37,6 +37,9 @@ static struct dst_entry *xfrm6_dst_lookup(const struct xfrm_dst_lookup_params *p
 	if (params->saddr)
 		memcpy(&fl6.saddr, params->saddr, sizeof(fl6.saddr));
 
+	fl6.flowi4_proto = params->ipproto;
+	fl6.uli = params->uli;
+
 	dst = ip6_route_output(params->net, NULL, &fl6);
 
 	err = dst->error;
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 1025b5b3a1dd..731fd02d787b 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -312,6 +312,20 @@ static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
 	params.tos = tos;
 	params.oif = oif;
 	params.mark = mark;
+	if (x->encap) {
+		switch (x->encap->encap_type) {
+		case UDP_ENCAP_ESPINUDP:
+			params.ipproto = IPPROTO_UDP;
+			params.uli.ports.sport = x->encap->encap_sport;
+			params.uli.ports.dport = x->encap->encap_dport;
+			break;
+		case TCP_ENCAP_ESPINTCP:
+			params.ipproto = IPPROTO_TCP;
+			params.uli.ports.sport = x->encap->encap_sport;
+			params.uli.ports.dport = x->encap->encap_dport;
+			break;
+		}
+	}
 
 	dst = __xfrm_dst_lookup(family, &params);
 
-- 
2.34.1


