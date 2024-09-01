Return-Path: <netdev+bounces-124065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8941D967CD9
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 01:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47AED281943
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 23:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE62185B68;
	Sun,  1 Sep 2024 23:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9hbkcXS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641D9185B5C
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 23:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725235093; cv=none; b=VS+lgN45JicBO3yXJtBVWIELziXqTarKEu8mnaPxpAWLJbF+89OZ0B1cW5B3N8fgUN3VLaTRyF/2SGWY6nh1lUjVEivsFlsuuiqmdkX+jnucNnXwQr/6IcDTTbAGH9as48HDPi+sRvC78SfPy2f2I2ni0JM3i+GniSPd8oLw8zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725235093; c=relaxed/simple;
	bh=nnbQ4hAYv4svB4ZN5g7vL6HuvgfVA2p1w0ThP7MSrac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ptpj4NxnR7n+ZCSZZJ55J1eVxmH1HvEqyCU3D4IsTXSmyOKRCmMxO7FjRFijg/+gFmXjMUhhhVcZvjO8cGCGlqbxYqhCvqLLnuVxCqoVamqLCdQc91ZZI4afc8LmBlyVenk0cGJant+pxfYUE4KB+L/kFZiLEDZS35dV/CFD3g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9hbkcXS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2057917c493so2344765ad.0
        for <netdev@vger.kernel.org>; Sun, 01 Sep 2024 16:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725235092; x=1725839892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GR+qg8E5oz/F7Sz16NKjtFfDTDL8eCh+C+1h4HT4wwg=;
        b=I9hbkcXSYBufjIRXHmMvfm7bPwzrCogjpTJwTfRMN/CEGhQOxDp+zk46QhmrFeyjXw
         FZJjnhO6KfC1X6C26dn6ien1CTKEgmmSTVs3JUJWVRisMewEyH+p6a4OGYUpDiYc7Uev
         EMxWXqVV7SpyCmXswcsnBz7o9Dvk7nsHA9/Xi17GPt6GxUkDh/Kv/HcQbfSc9E9id4EQ
         j73YOYZkF5a0+u30JmSlhuV83Fy3n6M2IctRzhBpvVIafhNHqwaaKleeRwRdrZQFETwS
         QBOLE4cukxL8ABrwoTesHIESMX3NKxBks8Ma3Wz+QdVnYT1epUYYvwSQ9GOMbu07dfiJ
         0c4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725235092; x=1725839892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GR+qg8E5oz/F7Sz16NKjtFfDTDL8eCh+C+1h4HT4wwg=;
        b=ZU4miLjGeONmWeL6D9UFOQjfGFlUszNhv75UM4sm2nqwWXHK73K5PAlRgjHAjDmJRd
         SoIEXobQkZ5nbgg+mV3QQAu7Z1OajT0nws7tFi+ZM/IiVHHVL/IEfFFvLthA/0eHcdGV
         50GepVBqKDWvq35eDKLPtz0eEYYB/WenHjgpYwz6kHaQilyRhYhmldmUQ35843eTBJfc
         tCB9j46svdSDEXLiukO3zoLUHRYc2AwdHBMUriavnZR/e5kqkJw/iMRXw6ic4xJmfG9p
         mIB3QNDMxxCTB0Wp6PsdGbA6/PA4WamRiuJBFzUGFPf9flRxsXTb0GQMwmasjMyKA27p
         /Kcg==
X-Gm-Message-State: AOJu0YyZt+DuqkLowU5ZIVaYhVB2EmguFAJZCLtMDWZYc/Y1tyRRRtdv
	CifBaltDP1pQ1coj+bsfkGPL58OXq6ZZaadaWJ+RA2ZCmPuqeaSM
X-Google-Smtp-Source: AGHT+IHAY+i18D7gFKd1paowHBL8aHwZnhMRv/Eo7pmHCVSD44yyMDOyiSmwbeKl19xP7EznOFII9Q==
X-Received: by 2002:a17:902:e54e:b0:205:6c15:7b75 with SMTP id d9443c01a7336-2056c157df2mr40240015ad.7.1725235091486;
        Sun, 01 Sep 2024 16:58:11 -0700 (PDT)
Received: from localhost.localdomain (syn-104-035-026-140.res.spectrum.com. [104.35.26.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2055012bbc1sm23848805ad.144.2024.09.01.16.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 16:58:11 -0700 (PDT)
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
Subject: [PATCH ipsec 2/2] xfrm: respect ip protocols rules criteria when performing dst lookups
Date: Sun,  1 Sep 2024 16:57:37 -0700
Message-Id: <20240901235737.2757335-3-eyal.birger@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901235737.2757335-1-eyal.birger@gmail.com>
References: <20240901235737.2757335-1-eyal.birger@gmail.com>
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
index c14c2be846f1..2928aeca0abf 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -352,6 +352,8 @@ struct xfrm_dst_lookup_params {
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
index 2ee18b739f4a..656e831edaec 100644
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
index f89b54da20c8..f93ffb827c69 100644
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


