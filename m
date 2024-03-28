Return-Path: <netdev+bounces-83013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4019E8906C3
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 18:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5C82841BB
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 17:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971235A784;
	Thu, 28 Mar 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NtY2nOw0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064004436D
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645396; cv=none; b=lZixxEl8daCH135BfWKJclcO8ccdNYK086J+YbBTGNiVNGPb20XKd78eCXzkoTIgsp7mURTlVVSokEszX62EnPM6/3jQWYJscTyrGIHV0QmLPAA4OoSoxw1vQrusuM1SaFnzcKEiVJNno4kb/j9FIPav9NzVifn47SUtStqLikQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645396; c=relaxed/simple;
	bh=u6CKHjdRZ3Q3jFE+0JJbKpQLd3hkwh+kwA+sSojO8Vs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=USFPSvIVqZSX6PPMsFkp8vNwtPPkOuGp5/aSZriB7I3x4LaPCEdnz4qzOMrfpeo4/zLoCJijwmq4jbT5KYfcn87mkOdAKZ/2B2OySN7hf5fM1jzUNXZVICc4T8EhHK4BSjVsr3IpPfYHoaMxJfaeazKsnTBYknIl24iLA2+GPtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NtY2nOw0; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so1891297276.2
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 10:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711645394; x=1712250194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zkkkR4bJVGdAmtjki7FbOrCs0xkI3kc/cNsgAoiErHk=;
        b=NtY2nOw0nmHqIEXkS52pIfHOt8/hJX7x9xF2SY2rGqq7HgIjRlIMxvHTWhwZ8/QAog
         SCkQ3op82Ke3DNvwyEPxYcgK+ERNWks3yPp/9B5DGeX+2JXIcUy4O7vD7Wxi4P9+0qvt
         L1/hHlfjXjJE58P3ZrFrxXD8atSYHf0GF6xgopYESYtvDbY54CAczdYvB2twabm9n3yS
         det8caSOTXXM9b5ruwFA+erDVgC5ODcOIERLfk1GEmww5+OI6Z+4pzSXsn1Xy5YApwZF
         2heFr11Ef1ljIgFXxhn/K7D39Q7LgvOpI/+yycPZDGkrAGinuMuh7kq6Y/By37AxwhY/
         IaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711645394; x=1712250194;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkkkR4bJVGdAmtjki7FbOrCs0xkI3kc/cNsgAoiErHk=;
        b=X5D0rY8Hu/iiZZNSKPObZdHn9t+8TGPDXW3sT7xHYI/Xgh8q1T64d/pJ2ytZSm0OUG
         W2dp9frqwVCEzTVkcKHiMgjijnSrVmQOyoFndHoOSQOCr9oK7xQOHS2xKdyR1CZf7gA7
         c6U4JAUY5I8TlrFGSTS5hsj94Qz4F1rqOtV+i/yxiDFRysQ08+CIF/NhdwFv0M8GOj9U
         QG1tJgoDHSWJi1869McvCxNWS7oJNNyXQsZIcCzP9Qv2edKErnee+nRm2q2OPhUwlADz
         2DdafUTOt0mjuGkssgVeTkLEn1fmNbrLms8a4Wu/w+AvDT1Gs1UM06KZRvdkIaW7GVQr
         EyGg==
X-Gm-Message-State: AOJu0YyhFvCMlLVRP/FxwBDGE/WaFug4fJ6Jg7ix0NnQXq0bshfmj3kR
	Nq7HnQ0OajD43W8z50ixKMSjh8kp/3iiZa91VrGwvvh+fTcJ98TUNDHpGrEsMM4E/t3ChB5jtZ5
	M299DNnNUbg==
X-Google-Smtp-Source: AGHT+IEkDMdQwB28sjXqbQO6DPsBKrPbAJ86d1jrLX7OZqcPrx6CURW1BBpKVVOSGf8tTKhq7AJ/4pFN5ifMvQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:110c:b0:dcc:f01f:65e1 with SMTP
 id o12-20020a056902110c00b00dccf01f65e1mr1089559ybu.8.1711645394049; Thu, 28
 Mar 2024 10:03:14 -0700 (PDT)
Date: Thu, 28 Mar 2024 17:03:03 +0000
In-Reply-To: <20240328170309.2172584-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328170309.2172584-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240328170309.2172584-3-edumazet@google.com>
Subject: [PATCH net-next 2/8] net: move dev_xmit_recursion() helpers to net/core/dev.h
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Move dev_xmit_recursion() and friends to net/core/dev.h

They are only used from net/core/dev.c and net/core/filter.c.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h | 17 -----------------
 net/core/dev.h            | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cb37817d6382c29117afd8ce54db6dba94f8c930..70775021cc269e0983f538619115237b0067d408 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3270,23 +3270,6 @@ static inline int dev_recursion_level(void)
 	return this_cpu_read(softnet_data.xmit.recursion);
 }
 
-#define XMIT_RECURSION_LIMIT	8
-static inline bool dev_xmit_recursion(void)
-{
-	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
-			XMIT_RECURSION_LIMIT);
-}
-
-static inline void dev_xmit_recursion_inc(void)
-{
-	__this_cpu_inc(softnet_data.xmit.recursion);
-}
-
-static inline void dev_xmit_recursion_dec(void)
-{
-	__this_cpu_dec(softnet_data.xmit.recursion);
-}
-
 void __netif_schedule(struct Qdisc *q);
 void netif_schedule_queue(struct netdev_queue *txq);
 
diff --git a/net/core/dev.h b/net/core/dev.h
index 9d0f8b4587f81f4c12487f1783d8ba5cc49fc1d6..8572d2c8dc4adce75c98868c888363e6a32e0f52 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -150,4 +150,21 @@ static inline void xdp_do_check_flushed(struct napi_struct *napi) { }
 struct napi_struct *napi_by_id(unsigned int napi_id);
 void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
 
+#define XMIT_RECURSION_LIMIT	8
+static inline bool dev_xmit_recursion(void)
+{
+	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
+			XMIT_RECURSION_LIMIT);
+}
+
+static inline void dev_xmit_recursion_inc(void)
+{
+	__this_cpu_inc(softnet_data.xmit.recursion);
+}
+
+static inline void dev_xmit_recursion_dec(void)
+{
+	__this_cpu_dec(softnet_data.xmit.recursion);
+}
+
 #endif
-- 
2.44.0.478.gd926399ef9-goog


