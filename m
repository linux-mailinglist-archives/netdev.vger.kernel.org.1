Return-Path: <netdev+bounces-132971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92680993FFF
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E9D288D35
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 07:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9D51E5712;
	Tue,  8 Oct 2024 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="wmq6yPXP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D681E5015
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 06:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370496; cv=none; b=EaZs2u7P9NQFQDlGWGwhayYgin0whq1KCecFne2VWySdfIM1MTwcxjU1aqb8PcCEQb4muZAHWaIujOA+AJI6oirWpwJMhqYperK+btqTS7OxLPn3btRjqmjV0jYa7xTVIyY1pkJuLywXofsC84W9x3Lp3DKAkbnRjO2BcWde77Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370496; c=relaxed/simple;
	bh=GX7xNNedqmkBNoygMLXRBk8YNW8TUTKj2IdIaUHcsB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=NgGVE9NxZCf4mJtHjPoqVKIArZDkFx0xAuZOZxZ9qKqG9CWT4Vt20Y7jfM0nCN0rpUiII7rdAxhR0R/cgFi+jb10PdFM8MJ8IZr86EI96H2S/ZOQCCHDzr1/7aGcP0ONqtND7eUKbiB7onznXmidUScOUMv5nwlsw7VBeeygjgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=wmq6yPXP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b58f2e1f4so35280935ad.2
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 23:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728370494; x=1728975294; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61I8UVOx3KOO+grmBS2eNs+UXuu5q7xipsiBLUyhIxU=;
        b=wmq6yPXPRSEqM/tb9PmlS7HIcPpfk09lCAmS7zkuhDFvwK8g9X6m0ELFp3dfr0zFg5
         zyY3LOgttb+uAc6Mk5/DRLNHJBMUggPu0S6r1pVfWkPuS9nWad3i1RWSV9XOPn8qRT3P
         7SVhYEqtofujNQBA8ou7sbHrfcQrzTQERXORKzZixdjQM15LEpAYIbPLb9ujKGR/2EjG
         5dw4OjchKgxVOgdWP4o8xnMYMBuzK5KVWRWd3FY7BsAf5i5HR7AIf7WrRsaKomGp+3KT
         I2mVqZwVqdJybMlmUUNlQn3FXAb0BR0AnUBng6sXQMMvde7ICR2yVJkuHw0afL6mx246
         yYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370494; x=1728975294;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61I8UVOx3KOO+grmBS2eNs+UXuu5q7xipsiBLUyhIxU=;
        b=TwqGInl4zNFdj7uV7AC/dxmLK4d/Rcve6nGu0INAsOlidZ4NbQQy8w1THNOrzAhE4i
         R5NLksRJX1vPKdTuQK4Yv31dtlMWLEMUWxv6mbtkcp8EksuQ9B5+OJ6ba+N8tQ9QUj4I
         AK0QYmWUOR6y9IPE4omG2TVNIAJkztSRQCm56xLGZ4A8+2aDs+3L0Tbnhkt5qnbUsYom
         IkJz25EkDjAxC0vil7qiUtrLT7K7e7lgbyDiI4FbbS7V1ZFyamJlgCDNt3KzFPLS74Bd
         mAyV3U6snxNUMAAd5JpRGRLhGcsCNHPMUYajFuCjn3LCd4bWF1VRgF01pPWwvIa+OR/4
         y2YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbtgutwm3LRP0azmoHcs6ACu/S46D+Y2QkWyrUj9BxXoKZXF+E8iMAp3EL2Sw2Bg/qKJ6nRIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXGge3DPeTTKET3/kjg1On0AUcAZz6G9z2hDj3255SvIgwLwV0
	zgpDJmmspBE4VBk2S5pwjJ44lGCTMh3JXVhDVzFg2lIZN14oaeRNZHRWTBdiGQo=
X-Google-Smtp-Source: AGHT+IFQle2yzzR4dcGGT4YtYzeAeqeN1k82tWPpuGYLK1pMOd+gx8+tY2XKUq2OjAmapp2a+BI3iw==
X-Received: by 2002:a17:903:32c7:b0:20b:987b:e3a0 with SMTP id d9443c01a7336-20bfea56b19mr207151025ad.30.1728370494237;
        Mon, 07 Oct 2024 23:54:54 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20c139a2bbbsm49777315ad.294.2024.10.07.23.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 23:54:53 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 08 Oct 2024 15:54:23 +0900
Subject: [PATCH RFC v5 03/10] net: flow_dissector: Export
 flow_keys_dissector_symmetric
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-rss-v5-3-f3cf68df005d@daynix.com>
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
In-Reply-To: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
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
2.46.2


