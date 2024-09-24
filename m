Return-Path: <netdev+bounces-129481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 216FB984169
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 11:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9C2285201
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 09:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA50170A26;
	Tue, 24 Sep 2024 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="k57lj3jB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78149161935
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168484; cv=none; b=jyWXa0PHWLANTpkdLo8TSWRNbaPeQ0VqWUnJDLPlNdomtAOaFAsuPaAf2h2z4gh4oSxFHPX07SxvSiLnaQY62wWpGLmQ9GhYyDPzIgoy/ARMUC3CEtJlxCcTqk6gzSC8H8dzC/Bp+4YWAvFXkAqAhiIJkb2uS8ljKxcZAEGkfjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168484; c=relaxed/simple;
	bh=jkhM+x9bNKZH2KnPiJz0Wz2oSY9j9Yf3OXEdL7BBvmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=G1icKRWCa4jk6S2hvGZ6d+vI2lasPVlinRURTJ2JpzUkGHsgH7QTuEpngFMbWiho587dbfGlUJLEAW96g6C4BDtfsV0t20R7WyYtnAYbb4abRu1kstiy+VFlb1DnHY3F8rslTw7qlxHLNW/Alw/6qsiBJ13Bt72gWyVyaa6RNhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=k57lj3jB; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d3cde1103so435981866b.2
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 02:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727168481; x=1727773281; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLQiR3TXPfmR5MbSmS8z1giBJhJI6LMQJhK91hzIYDE=;
        b=k57lj3jBp69KIozhassWH78oorROa4uhHREPUp2CfGvk6vxAIHrS0BlJRgQ1XmayGP
         mcmScrNoxXJVpG4GuFPjqsXVJ5xDRByVzfGBGMhH3KhC+MIVNxS39Tz3D6c7Sem8X3mi
         GoHHyC/hbVho4UlL/+z+bUk1E2NVPtj6hQEsAzYpTGLMwygzDUvqLipHM5G4OHMtupe6
         hbw06GJAeeNwfcUmDapami9DokdwolcpcFBiHGETY97FJ2buT32Ls2RTPfuN70KcbHkL
         vSIBtC/pvlCY3R1/0YBNQeblddriMbFOrZHqBHthzQUTziDNQfe/p2HtD0vQk3P2B/0h
         J/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168481; x=1727773281;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLQiR3TXPfmR5MbSmS8z1giBJhJI6LMQJhK91hzIYDE=;
        b=Ny0xhWQwSVJ3XWS992PfZjUjj2QzeUNXpOyQWe3H2sVbixlOwBWucbyaS3zVwxfyaZ
         5/wFehs9RVdG25SFDbfui1S3ZNutXqsd0yVRM6fmOSUrP5Zfl1TmCVoXWx7CcKzfvD3T
         EDvjof3gzKU5zkFAurtOSYpIySTBoO0essF3Ki4BwrkycVdTk9ZeWwpO2I9pPDOTTbH+
         iWp8ZbPG5NKwIqkQE6DKDVUmX9y/vxHc0O332EB1KnxoWhOJ7j1qB7qiI4Tlo52rcHcA
         ShAtdbccxmLbWnomCpmFJt0P0t8z2OtAHnXua+QcwNF7+CSAlu7mPS8bQBd6Xq5s4cqr
         AKeg==
X-Forwarded-Encrypted: i=1; AJvYcCUCGxH+kpv1YpVHEQH8dM4+LzoU6LA3/QwgmbMo2BJAzO1xmCu+2BBNuubA4pXfM+B2HYsCbD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa2zGVDCq53g+84USLQMvoNCuiBY//+Ar0hcFMAXYihZ8VNg5k
	szVmGnvOiiELtVWOkn7HpwOO0gB5US42uZmrpBsLticP1Xlu1VnQHnCAe2wY5jg=
X-Google-Smtp-Source: AGHT+IFpGV2s1+MT/Wmetrjt1jnUx/JVoB/QDy6LvgWwnmt/y8aBUWSPmWV8V/zA8CCvTi/SZQaLnw==
X-Received: by 2002:a17:906:6a22:b0:a8a:7b8e:fe52 with SMTP id a640c23a62f3a-a90d58c1039mr1494327966b.59.1727168480198;
        Tue, 24 Sep 2024 02:01:20 -0700 (PDT)
Received: from localhost ([193.32.29.227])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a93930f470asm58712666b.151.2024.09.24.02.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 02:01:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 24 Sep 2024 11:01:08 +0200
Subject: [PATCH RFC v4 3/9] net: flow_dissector: Export
 flow_keys_dissector_symmetric
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-rss-v4-3-84e932ec0e6c@daynix.com>
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
In-Reply-To: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

flow_keys_dissector_symmetric is useful to derive a symmetric hash
and to know its source such as IPv4, IPv6, TCP, and UDP.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/net/flow_dissector.h | 1 +
 net/core/flow_dissector.c    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index ced79dc8e856..d01c1ec77b7d 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -423,6 +423,7 @@ __be32 flow_get_u32_src(const struct flow_keys *flow);
 __be32 flow_get_u32_dst(const struct flow_keys *flow);
 
 extern struct flow_dissector flow_keys_dissector;
+extern struct flow_dissector flow_keys_dissector_symmetric;
 extern struct flow_dissector flow_keys_basic_dissector;
 
 /* struct flow_keys_digest:
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 0e638a37aa09..9822988f2d49 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1852,7 +1852,8 @@ void make_flow_keys_digest(struct flow_keys_digest *digest,
 }
 EXPORT_SYMBOL(make_flow_keys_digest);
 
-static struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
+struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
+EXPORT_SYMBOL(flow_keys_dissector_symmetric);
 
 u32 __skb_get_hash_symmetric_net(const struct net *net, const struct sk_buff *skb)
 {

-- 
2.46.0


