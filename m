Return-Path: <netdev+bounces-227170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C79BA97D2
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 16:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14E5D4E02A2
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 14:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49CC309EEA;
	Mon, 29 Sep 2025 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dAnvrH4q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFC4309DCC
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154966; cv=none; b=ACGleV5MbrqXglFYsmp9aAqX5mjL2SkSMGlpuJZTVUItOTAQjyFKN84VSYDNfNI3heHM+QziXWyTtwzboo16llkqSmEbJXQmlFm8JhEXe0JnY4ho0KdFrFPfZglwNOzu7JFo0v9cq3FOw7Min2YaITdFZhVbWVg9GAveLF2+/I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154966; c=relaxed/simple;
	bh=jphV3hLYyJpq5wHhzxxIdaldllEhemXAkq3l8pQxo6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CTGF2LpXZFwHjADsuORqsdchqgimOOExWiAsE87EUiehpQHxoL4HyyHHznYHmWDuxVp3+4BDnIMEsnsBn+6KLIbZe4r8hYeMAq4CyR4rAwLsA2Qm6YCF7lXe/qcR09x7RWzVvkJSYa8xksNEdu9+Js131GJY9imEiuKxXT0L9nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dAnvrH4q; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so258262566b.2
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 07:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759154963; x=1759759763; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phiaj2apVtnJOs8yCgS1f4Ia15HnRGM+EMU3gmWsJiA=;
        b=dAnvrH4qGPtT4GTRf9NQxHOyCJxdbX8s+07GvPS9lWYMBr/q8ye8lsnV618l8a7yuM
         BVVOC0RY/JWkGISqYgmUB4RPnpSZzdTagIWFEQlTxnYOSf3uzDbwvPstKxzvsD1jma8B
         XL9dnV0LgrC7LBOcKaZrBdqu1q+IeMLbYrMctXkzineyIXcYXmEYOIWqtrWs/nfOTl4r
         Nz0gX5WkEuOimKg0B80pvoUNjzHxbzumXBjS+/nN/ByZmv5YMPUfShWUk1r+u/CymvQs
         4Vh8If+tD0xyzFEGKO0NIb+sesrvaLhS6O8DUZacvDVmEJOZRzfEzvZu3e1ci3y6L5LG
         GtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154963; x=1759759763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phiaj2apVtnJOs8yCgS1f4Ia15HnRGM+EMU3gmWsJiA=;
        b=nONLrwuQ2l3rEjnpx/+pdlmvFdnbhq2YPqLSggRfJ/VPfWt33PtnosWmYaxvnnT4eM
         NA0FVTKKX/hN4RaDwOWOiyGp1DL3KmLan+sgSPCOeMzyNVaveN3UBjXAcK9EwI7cVzuS
         7AIFdFaMyypmvzM1xSmb4NdnCHuVdB5iWPxue92+kYHWSOmmy9T4JduKjMAsb2II3+fa
         N1+DTQbPZ+ZFIHNrQdRmLJf2A+QIbdnUsZ0vJsYjxvKFoW/J7ycH5FZ/VOMOJkIxlnyR
         C2ld7QWcsFLR6PQ0DTKjCs+i6B9+vQaCvcbw53kWMTk7g81pYmsqXHllpt4XpaytdRJH
         /i9w==
X-Gm-Message-State: AOJu0YzMNKG9D8HQSKTQHqe0RPW2hDR5oOGYa+AkoNoAnOqf5hdOPDcD
	3c510TDKUectDMvkgyrUFZFSzhadNPLYeyFKu8RuMgGDTrCY25MvElrUgcHFgUuXS+aeNyhJv5u
	2dkxt
X-Gm-Gg: ASbGncu/K1FyPbxuHMjYrkoMZOdA3jsR2bKCrIBtF+Tl0nXia2eBq6OdfDNnhYndLBx
	ksdyKU6iuAMxOfvKDen4aFg0UbITtJs90AghIfozTLxS6PVc9LLDmFPD4M1f0JdqMEyYmlZlaEU
	hAHdo8hABr+TOxsEUYYPAa78Q+2VnCoOXTLQ2ks9t9PkVmS+VOd8XREuuyPiYHvitX0GkZNz+V4
	FPSiGrhhUwGElmGvaTUrDV7qOOcO/9hcR7tQzHuwhhPbsdq+W9l5V/lDM6Lo9IwAcGZfY3T2Voa
	uCL38o8/ajA5LmsmU1BmtcXQBrcXGdIVBg+VBRUIZ1N0R0xbMH5gLdWbkwC1hjIAjFE8IW/fRgV
	Iqj93ttGXbPyaF6AvR2M53leT7XjEOakQdoEGApVax2iEetDGDqozZ9JRPQhDDGAl6bz3LdcY3a
	PXXyIsOw==
X-Google-Smtp-Source: AGHT+IF4eH/unk1vgoVBN6X3ue+fuhzf0WaaTMslFL86MtHu8OVmK5qSN5+YJgEp6MXvduaOg4k8EQ==
X-Received: by 2002:a17:907:9713:b0:b40:cfe9:ed2c with SMTP id a640c23a62f3a-b40cfe9f8e1mr151533666b.64.1759154963281;
        Mon, 29 Sep 2025 07:09:23 -0700 (PDT)
Received: from cloudflare.com (79.184.145.122.ipv4.supernova.orange.pl. [79.184.145.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3d2801992csm309701166b.16.2025.09.29.07.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:09:22 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 29 Sep 2025 16:09:08 +0200
Subject: [PATCH RFC bpf-next 3/9] vlan: Make vlan_remove_tag return nothing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-skb-meta-rx-path-v1-3-de700a7ab1cb@cloudflare.com>
References: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
In-Reply-To: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

All callers ignore the return value.

Prepare to reorder memmove() after skb_pull() which is a common pattern.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/if_vlan.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 15e01935d3fa..afa5cc61a0fa 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -731,10 +731,8 @@ static inline void vlan_set_encap_proto(struct sk_buff *skb,
  *
  * Expects the skb to contain a VLAN tag in the payload, and to have skb->data
  * pointing at the MAC header.
- *
- * Returns: a new pointer to skb->data, or NULL on failure to pull.
  */
-static inline void *vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
+static inline void vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
 {
 	struct vlan_hdr *vhdr = (struct vlan_hdr *)(skb->data + ETH_HLEN);
 
@@ -742,7 +740,7 @@ static inline void *vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
 
 	memmove(skb->data + VLAN_HLEN, skb->data, 2 * ETH_ALEN);
 	vlan_set_encap_proto(skb, vhdr);
-	return __skb_pull(skb, VLAN_HLEN);
+	__skb_pull(skb, VLAN_HLEN);
 }
 
 /**

-- 
2.43.0


