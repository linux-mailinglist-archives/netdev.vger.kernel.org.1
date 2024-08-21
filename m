Return-Path: <netdev+bounces-120730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DD895A67D
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 23:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E973A1F23733
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 21:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46506175D34;
	Wed, 21 Aug 2024 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="IexEB5VK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C849B17A582
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275371; cv=none; b=m3ns3tbqZBoMkdpP5NjxoYTD88/CXbr3gh3nHz4P/q/Rul2Aa6Cmvj7wEGFtsME1r1QtDn7vSy/2qkV63PLRlzrZy40n1MSiTLr+5VB8m5CxdC8gtpUfbqJPxV7zwduFEb+r4CK7K8CFMfsmL1nFMUnBgX7GCSSDvKpeSlaAJuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275371; c=relaxed/simple;
	bh=Twn1f5dgBXiN3Wmpt1KS7Q+IaWwLHYKUArTze0m9lQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J51U5sDhR2lnpVwZXdL4UYTiNY/lvjsDau7NKhCV0S6cPLTA5xPDpA7f+5i5Gv9RRfIV/eObBY5k1bmtGwIdHEqo2zWnwmcNBegu6iXZKOKOHlzz0ibDDDuST0Yy06sJ+c7JcnydJOwyq8HFWMMP9qXWKUgpjhaRmEWBzEO6N0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=IexEB5VK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-201fae21398so978955ad.1
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 14:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724275369; x=1724880169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5B0V4ZEdQrdtO9pb5selC4LqFAQxYkVgI02+uDp6NY=;
        b=IexEB5VKhnMMT3tXIf5s6tIpIBCLvUlY+BSd0DyvKnP3Wm335Sz3oNBUlVpyia0/gu
         U/Z+XwAZSSLUIY6eXZ8MlQRcBQv3zWHE9qa7Y8FAw5pHcHBcVxwGsJAWD8wknM1FP9ca
         R/nl7Aw+RRa+L2T7fsjIvkiTbv+9AvCW+RUPsRctIi8rO+r5jn6NtEATarRyaVvSy7W+
         F/zEFT2SEhpSexmkcH1QjQ0ixdWahjVgJSS1CsUnnp+O5dOHsWQ28wXRUlFx0bfUzM+T
         GnSXHnn86I/AxPQbKL1xKBQXeXRbBfQYSsFmXGE5TYNhwWJ6Rsoz4MtpTguTcUS6cDZZ
         1V3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275369; x=1724880169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5B0V4ZEdQrdtO9pb5selC4LqFAQxYkVgI02+uDp6NY=;
        b=ahrphlOlje2Gum751uIF6eKlT+791+SuBjbFVwJBpj1mUISdD4qkoTokV9mQGT8VoU
         cSpx/8qma30mQIiiVumoxwgDjJIXjLNvTdK6oVshodBdo64fGwgwpZr6z/W7A6gr4F+4
         U/28WVLD+Bi+HaqYkrfAxz/5bS+OWNSVitdujMvWvtYRaBL3JTwqrMn8+JfyzLEIuOpu
         ArqviqwlByrV1EIi1nDQII5cv4XJk7xzoQohGUibv23gAKK9ziEHt8SNjvrdEqOTkflo
         ASD4Vceo4GgnIS2davIhAoDtvqgMKpYJIyjS5y31z+wswrDFVqoHhdU6iwb/bdZel9oU
         BfCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX7Urlvuhh8bi7AlwVF0m3mEvjrpsMQvoLLcQ+g819Wnb5+n2T9Nzzm2K73RJOs3D8NEcmDBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOleGAHUoZ+bzwrKnUK0yI7tJfWM8h70JrySJIR9o1XZCo+uxF
	MgmbWJ6QqRFw2ghjdfqAioKdhbq3LBdw/sq2AcIGVUOU45Q8JfY8/U9ksb52GH7Bg6jH0rlXHzk
	=
X-Google-Smtp-Source: AGHT+IFJmiPBWsputoEAdkaoZ19DRRR5q9sLVaD1t528UjVcEKQybPEpl50dOZ0W2rkuTHUUj+bkkQ==
X-Received: by 2002:a17:902:e747:b0:202:463d:250c with SMTP id d9443c01a7336-20367f6bf9bmr38536435ad.37.1724275369027;
        Wed, 21 Aug 2024 14:22:49 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:7a19:cf52:b518:f0d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae701dsm388265ad.236.2024.08.21.14.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:22:48 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com,
	pablo@netfilter.org,
	laforge@gnumonks.org,
	xeb@mail.ru
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v3 09/13] flow_dissector: Parse Geneve in UDP
Date: Wed, 21 Aug 2024 14:22:08 -0700
Message-Id: <20240821212212.1795357-10-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821212212.1795357-1-tom@herbertland.com>
References: <20240821212212.1795357-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse Geneve in a UDP encapsulation

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 331848f90f78..307d4bb20e99 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -11,6 +11,7 @@
 #include <net/fou.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
+#include <net/geneve.h>
 #include <net/gre.h>
 #include <net/pptp.h>
 #include <net/tipc.h>
@@ -797,6 +798,29 @@ __skb_flow_dissect_vxlan(const struct sk_buff *skb,
 	return FLOW_DISSECT_RET_PROTO_AGAIN;
 }
 
+static enum flow_dissect_ret
+__skb_flow_dissect_geneve(const struct sk_buff *skb,
+			  struct flow_dissector *flow_dissector,
+			  void *target_container, const void *data,
+			  __be16 *p_proto, int *p_nhoff, int hlen,
+			  unsigned int flags)
+{
+	struct genevehdr *hdr, _hdr;
+
+	hdr = __skb_header_pointer(skb, *p_nhoff, sizeof(_hdr), data, hlen,
+				   &_hdr);
+	if (!hdr)
+		return FLOW_DISSECT_RET_OUT_BAD;
+
+	if (hdr->ver != 0)
+		return FLOW_DISSECT_RET_OUT_GOOD;
+
+	*p_proto = hdr->proto_type;
+	*p_nhoff += sizeof(struct genevehdr) + (hdr->opt_len * 4);
+
+	return FLOW_DISSECT_RET_PROTO_AGAIN;
+}
+
 /**
  * __skb_flow_dissect_batadv() - dissect batman-adv header
  * @skb: sk_buff to with the batman-adv header
@@ -987,6 +1011,11 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 					       p_proto, &nhoff, hlen, flags,
 					       encap_type == UDP_ENCAP_VXLAN_GPE);
 		break;
+	case UDP_ENCAP_GENEVE:
+		ret = __skb_flow_dissect_geneve(skb, flow_dissector,
+						target_container, data,
+						p_proto, &nhoff, hlen, flags);
+		break;
 	default:
 		break;
 	}
-- 
2.34.1


