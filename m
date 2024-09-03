Return-Path: <netdev+bounces-124332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 069D4969093
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 02:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA6228403C
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 00:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA96F29A1;
	Tue,  3 Sep 2024 00:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkfQESet"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7677836C
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 00:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725322044; cv=none; b=NfTQrqmuQPWgQiZKyQF+BDS2c3XR8pJSOt8JCH9RIyolAEIZoWHUM+bT1n6bHghekc0OcsorbWHq3e/fsq3kILtt5uB+D08TTYCXMJPWQjzdxhLq1t+2JoOHRuwEiV2JregHeIwbEzrOlT3bCB/zCB72nEIma6Cza1+MxJJKs08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725322044; c=relaxed/simple;
	bh=VeG7q8Az9jkvnJraj9JKaYM7abMh6Fi0f67TCHD0AVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kiYj75f4jugCCQPkcO9jrLw7hxzmCe3TC460phH6xsIhQHaj9tjYE5kZiIuN4pUEhgyGh9FVGsEqUJX8gtBpXlxpjMDI8AcxqmUI4xjzAh0QNHJygpYddJgcssW7kO6IioEdAJHqV/e9/kM+x6riFAzOTTzsJEoSHCU9kOhvLOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkfQESet; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7c3d8f260easo2393370a12.1
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 17:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725322043; x=1725926843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eytnSzJUo/gDiIAPvuVRJkdQR/v/HAwEcHYwioptGms=;
        b=mkfQESetWZy6UssWhaOc+xUTJaiYkIGHXi/EP13FcW9kdRQzidAUz24dv98Invdp+E
         KnjLa0YhKpx1FYhIDmjwO0w7EigPOK4Mb+oWBqUeq4lfD06rcXgUFGezIjQE7sKoUcX6
         q1Wcz4Mca2T/dhW0AAC80YOjNoBVD4i+l9zGA62hknFIiVnASvwuSuRNi2Jk24LW30cF
         xtovH+KmDOBT4+9mYSgA+YxVQlhL28c3SBqo8wN6l22lnrOJy3X61IYwXGRHLltEFpsl
         evn4fNWkTa3LCuALgDDBaT2h3Xha41YbPanh4ZZD+NTSOtShZRtldedw5bshta7kCepC
         9m8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725322043; x=1725926843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eytnSzJUo/gDiIAPvuVRJkdQR/v/HAwEcHYwioptGms=;
        b=xSOiXVl4HZmD8GT4zSkMp17Qt+UQcdfRPKMOGaj9keraI94eRzEzz4IukTkPVdOTyC
         8DOhSm+tsGa0nPk8DQooyCVYXV0EjfVcN+RSmf6YdkKuopvayn9v3o6CORv3rCeAt97f
         3LlxcyFWkk4u9+WcjeljcJ7PapGDN+YmtdXsDTapRxqOcuZNiGasVMFtxMeP+1YT/wBt
         PtbYYgEy8H+e42HsfOe6KGtMAjl/+bsa286/MVWzCHnMtnmyRIgbrMCw7gWcA6/p7QDP
         kD2Phu6KQPEl8BkustrTxJWFkMbaP3Ni0aLBq7rHlWZrqzD43ZCt9yD7O0lBY4F4Ecxp
         QYgg==
X-Forwarded-Encrypted: i=1; AJvYcCWYk9efhH+r40oaw2jMizWLhX5cSaLBxZ5dvQQ4ccDvbUSckLb8IBDOw6HOCp7OM7EybrsFqiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI5kpX0PnxPUIalYz6ZgbwSNNU6t5mVYMAntbESiHLXEKkRzet
	GSSW7nqGaTnuno8KQguVd8vBxt6IKSvQKE/3zk3p1GMkolvDT8Gl
X-Google-Smtp-Source: AGHT+IFwDEcvsz4Zk8qOGSsTcxwodIQ9CkrdTAFNFhObiEkV9JZ6ztSimIx7zSltAyMsXjp3LdjG9g==
X-Received: by 2002:a05:6a21:60c4:b0:1c3:ba3d:3ec3 with SMTP id adf61e73a8af0-1cce109796cmr14104304637.36.1725322042768;
        Mon, 02 Sep 2024 17:07:22 -0700 (PDT)
Received: from localhost.localdomain (syn-104-035-026-140.res.spectrum.com. [104.35.26.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515556ebcsm70799715ad.285.2024.09.02.17.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 17:07:22 -0700 (PDT)
From: Eyal Birger <eyal.birger@gmail.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	paul.wouters@aiven.io,
	antony@phenome.org,
	horms@kernel.org
Cc: devel@linux-ipsec.org,
	netdev@vger.kernel.org,
	Eyal Birger <eyal.birger@gmail.com>
Subject: [PATCH ipsec,v3 2/2] xfrm: respect ip protocols rules criteria when performing dst lookups
Date: Mon,  2 Sep 2024 17:07:10 -0700
Message-Id: <20240903000710.3272505-3-eyal.birger@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903000710.3272505-1-eyal.birger@gmail.com>
References: <20240903000710.3272505-1-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series in the "fixes" tag added the ability to consider L4 attributes
in routing rules.

The dst lookup on the outer packet of encapsulated traffic in the xfrm
code was not adapted to this change, thus routing behavior that relies
on L4 information is not respected.

Pass the ip protocol information when performing dst lookups.

Fixes: a25724b05af0 ("Merge branch 'fib_rules-support-sport-dport-and-proto-match'")
Signed-off-by: Eyal Birger <eyal.birger@gmail.com>

---

v3: pass ipproto for non UDP/TCP encapsulated traffic as suggested by
    Antony Antony
---
 include/net/xfrm.h      |  2 ++
 net/ipv4/xfrm4_policy.c |  2 ++
 net/ipv6/xfrm6_policy.c |  3 +++
 net/xfrm/xfrm_policy.c  | 15 +++++++++++++++
 4 files changed, 22 insertions(+)

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
index 1025b5b3a1dd..d30a22cd5c62 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -312,6 +312,21 @@ static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
 	params.tos = tos;
 	params.oif = oif;
 	params.mark = mark;
+	params.ipproto = x->id.proto;
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


