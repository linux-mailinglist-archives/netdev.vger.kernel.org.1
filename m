Return-Path: <netdev+bounces-227168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD2BBA97CC
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 16:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BCE7188DDC3
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 14:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BE23093A8;
	Mon, 29 Sep 2025 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GrXl4TFx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA0A3064AA
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154961; cv=none; b=lItX/3gRx0k0qYEAXrd+U3ngJImj9oZjD4V5KgiYl4leMSO9fpadpUsNSfhVanihRki8pICJcontLn6a/DDX6WMZwEgi3flPj7YbCkgiNc9xwPdxZBlcuEvmWXITCb2klw+O/6mfXrRIjD9J/2OoyBGKC3GSF1HTjXiyPMVq2p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154961; c=relaxed/simple;
	bh=cZPtm7mY9aZff/+Zp+0PNLXE0+5dqAo1/R/mB+FJx1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QOA9mNQVqhRdMyCEloeRU+1Ci8w6027/VgW1XLsZHwEXD09NjAMR0N5xsyCyUDPTqYWKQFM/0qWz7BDR6Lz/om0ds+ZzdVIJ1j1JQgLKS2qZj/VJB5O7zR8EiGUe5VyzrS/RDLv/X+FOtpoWWMCLOSHOhnqyRhaWxcSfLxsTMQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GrXl4TFx; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7322da8so919260766b.0
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 07:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759154957; x=1759759757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3T4hpqvjFYkRBESyoEKXynDUn9xooc0YNsSmvl0X2c=;
        b=GrXl4TFxL4mjvuc8f57b/0jafw6y2R0aoGgUFsR+BMiszd9iFXb7ONN7fxjQAYX3lo
         fDWh2m2wCkEd9yx8ofFG6h79ihyDb3bYIKErXyee4d/3BMCBrged/BavoI5mAAWtiB0x
         meqx+uNf7baGs8zV/AA3vaBwKvYZzWG1+j4gXftL9N8YM3+tlCw7nCLv9rBQGVhV7erN
         t7s5s/4ITgdEZzu/cgxdXhbEPqa+6zExnwzAe4Am7ch51QMykzz1NU99KM1u2HjgQMI3
         Zpj32m3BQYpcUstu4qd9eJQYfN2s4+jUYea9zZCo237wB+fqFMYqTHUpDUBuF4OTOtic
         oezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154957; x=1759759757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3T4hpqvjFYkRBESyoEKXynDUn9xooc0YNsSmvl0X2c=;
        b=kd8VcTg2tHTXfjmxdw4Opcf0hEAwP5FvxudG5c76t873leyln54sb6QFFQBHjeg0vH
         wPLfpQnuKn0DSCcZzQtcv88OtBcW84/1vyq/V2e4irNApl5oa5rFrfcHkBVpkJdGEbv6
         BeB4qAPWntR6pQutP555oCTTyPqsDsoBZ98PNXEmKPK8jw5N5wTYwatO/kZowf3CngiL
         coDDDUsd5sO3b8gfH9+oxx3DG9OOJ7KMthVtXs6PwZ5h7vG8tRiUBOXRvP1FKcGtAWQ9
         HpcMRbn5Iuaylmv9NA2hCRH/NOlWCSaDZjqWqbKew6bmuIh3bv5vYK+zYzHRV4XZtVzD
         od2Q==
X-Gm-Message-State: AOJu0YxBreRPHknqHBRFYr+Cjh80SPqifgZrvI9K6m8+bDkGI24gye5v
	Gon7UJSYsqjgC40sSviyFgf49G2zUcWenpc5Mx+E7PDjSGKzKKdCmAjdzhGISYuCIifCTVe+UUt
	cLpjL
X-Gm-Gg: ASbGncuRUnLxP8nKF0Ig6WDhNSbhiY5oUmQO3asOY7iPb114uuSMHjRzerHBxOIKh51
	UApKAYoMRru/HGvEV7OMzpMwrA8LnCdR/S34KJfY/WqveLZ0dGCUCBANlLEL/JbRirpli4SNCf+
	hWp3cYEfESm0VqRp4nRxjpP62pNnNcwudvKmlVeRxf6uT8JRISKCXjRwnqUMZvsQXAa4k4KGWqx
	3VRtBfTwTssiJWoFWhXcgKbF/k/h3fIq9HVUprScKmbz8ZYcm0fgKNJVNQsbpW5eT55KKfa2+Mn
	wfEnd9LpzD6idWG2WOZBYIFOci1iD0G6B5xzLJwShKdIUjhGFQ8Bbw3mfAQi+peHI72Ae+VnlHY
	hn363IL18hkMdCV7IlHeeVU4bjZvdj+/luVqgJSir0SgUDSZbvaqa4hD/EEnyeJh5iOTCDwutPZ
	zHogDzzw==
X-Google-Smtp-Source: AGHT+IHAVetCopmVRBD3UVVjjLGWuUD5FTUpk7ipzkmk+RRp7+O5PaSuaJ3llTBZ+1qCcucGsSyStQ==
X-Received: by 2002:a17:907:d90:b0:b40:e400:a3f6 with SMTP id a640c23a62f3a-b40e400ac3dmr124370066b.35.1759154957241;
        Mon, 29 Sep 2025 07:09:17 -0700 (PDT)
Received: from cloudflare.com (79.184.145.122.ipv4.supernova.orange.pl. [79.184.145.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3cf69ffef7sm320057866b.62.2025.09.29.07.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:09:16 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 29 Sep 2025 16:09:06 +0200
Subject: [PATCH RFC bpf-next 1/9] net: Preserve metadata on
 pskb_expand_head
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-skb-meta-rx-path-v1-1-de700a7ab1cb@cloudflare.com>
References: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
In-Reply-To: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

pskb_expand_head() copies headroom (including skb metadata) into the newly
allocated head, but then clears the metadata. As a result, metadata is lost
when BPF helpers trigger a headroom reallocation.

Let the skb metadata be in the newly created copy of head.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/skbuff.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ee0274417948..dd58cc9c997f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2288,8 +2288,6 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	skb->nohdr    = 0;
 	atomic_set(&skb_shinfo(skb)->dataref, 1);
 
-	skb_metadata_clear(skb);
-
 	/* It is not generally safe to change skb->truesize.
 	 * For the moment, we really care of rx path, or
 	 * when skb is orphaned (not attached to a socket).

-- 
2.43.0


