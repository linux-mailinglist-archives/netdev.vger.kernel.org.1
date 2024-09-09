Return-Path: <netdev+bounces-126380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DC1970F8F
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F1E1F222E0
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 07:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7060C1B1D40;
	Mon,  9 Sep 2024 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djme4q8i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD021AF4DC;
	Mon,  9 Sep 2024 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866595; cv=none; b=ofjdCGGSphx82yM+M5/9CV6rReSPLcsabVM0Jo/Sy3O8f8qiSTiaZtYDU7kodmzwfpJAWZ5nYBUSXBU/Q6lvbOJHyCOojUUpxG2ochuXmxHrP/AdBU5wG+3p01kLWjxtmBGiKcL6RjOgClitwx8L4wLI0yKB1tQ24d9gDobOd9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866595; c=relaxed/simple;
	bh=BjupJZu1E/fcfxWKlB66JWida6SqIOij/q7rMugI49E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y7TfglP1QRXmtiCU84/N17oHNmfuIjxABTrwwFzb1QYJyOCbmd++/jITiiotoh/u4uvlUbC956lFid0b2xuldLzVOaXrprGPCDjJTwXUsiSOoywd8AGwKqg6+SWPct9AkQwGBPZpnJIahA7ChM3LGSiYiYuWGDH6s2T/BEkxrc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djme4q8i; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7179802b91fso2368372b3a.3;
        Mon, 09 Sep 2024 00:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725866593; x=1726471393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nl/wlYbJ8IhJjGotsXRWm/OkatmXtly5y1k+64ypkQ=;
        b=djme4q8ihUd/050sl5T8PnK0FVpDqlJxs1u1YO1Cbkv1TH0atOEktYr4kvuvfsGJp9
         e/T7BWibQ6NfCu9hWlTdWyMGDA4YePIPHIXkmc0ZE+Rn3M6FXB8xecLYmhBB9jjjBP7K
         APP5WWvajskV2CfrvN66RDewZEh76c/c1whURcFQAZXRylt/v/LonhmmJ8JhQhsXOYtF
         /0WxUxlkUbA1HB3jYPCXum7QgtxL2RNCCb3Sz8t3q5pv0mo+4cVY7x9rBrywJ90i2jwj
         CsrFMeKrt90xrPTKOr/vw3RIzpKXS1gdli2mKFGo4na0KIZjyGWtfL/nybTo+kDSDLAL
         l4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866593; x=1726471393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nl/wlYbJ8IhJjGotsXRWm/OkatmXtly5y1k+64ypkQ=;
        b=B+HPVPvxnlqBPYniDwKQMos0Bc+coO3xryZGosqgjpSh0r/kGMJPwF2m7NGN/+Hfv0
         Ex48yF6Z4YBGscPmaRsrbrO0kUmr9cOTzjlhp/qmmLhUsJz1QbJKqStbB3KeCLwze/EQ
         Mgq3zoqa3mjmWKvhMqwzz2/RAbdzeyXeqxqvw7cdbl/y5PW8OAaqGoDlBpBS/oTavtCJ
         PKHfa42CbDTrA1tkDlfVJECpCQeVDk27Me780xOfW4DluyhLPbwW2SUcF39TWr8Pliwg
         uMJStoPvcbjJm9y//tbvjcr5Eepyro8ybFGzZiYqHeuCGJtovVzbFZF7ZsGwRAMqH6L+
         0i9w==
X-Forwarded-Encrypted: i=1; AJvYcCWyAoXHbefQ8jLZAXlHPrRyyv2axRXq5YXEwDfja8HHbsGYsup/csueRufbKs47owiknJ3BcpkSyjKiJlA=@vger.kernel.org, AJvYcCXVXLDxZ7YfIM9jcqHuo3zdt8fW//4L117pGKW1ULJs4BmjGZ3eQWQSmG73Op3PYg/lYG/yF78s@vger.kernel.org
X-Gm-Message-State: AOJu0YxygeIoD/MD2Q1mHdaCY5SM4K0lmqNMxMVhJNcmRa5o0RImOZJp
	HoC7hsK4m6Ntv9CpZ1VANOrcNyEw6WyIh4pdd2wt4RlHITSEdLbm
X-Google-Smtp-Source: AGHT+IE05wiNONegbt3qbKksEiCrsguphPea11DGOiINAiQpv7hzrT9bIan5AHR/kE7p9qMBd16Tgw==
X-Received: by 2002:a05:6a00:244e:b0:714:1a74:9953 with SMTP id d2e1a72fcca58-718d5e56277mr9144801b3a.16.1725866592936;
        Mon, 09 Sep 2024 00:23:12 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58965bdsm2962094b3a.29.2024.09.09.00.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:23:12 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 02/12] net: tunnel: add pskb_inet_may_pull_reason() helper
Date: Mon,  9 Sep 2024 15:16:42 +0800
Message-Id: <20240909071652.3349294-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
References: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function pskb_inet_may_pull_reason() and make
pskb_inet_may_pull a simple inline call to it. The drop reasons of it just
come from pskb_may_pull_reason().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/ip_tunnels.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 6194fbb564c6..7fc2f7bf837a 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -439,7 +439,8 @@ int ip_tunnel_encap_del_ops(const struct ip_tunnel_encap_ops *op,
 int ip_tunnel_encap_setup(struct ip_tunnel *t,
 			  struct ip_tunnel_encap *ipencap);
 
-static inline bool pskb_inet_may_pull(struct sk_buff *skb)
+static inline enum skb_drop_reason
+pskb_inet_may_pull_reason(struct sk_buff *skb)
 {
 	int nhlen;
 
@@ -456,7 +457,12 @@ static inline bool pskb_inet_may_pull(struct sk_buff *skb)
 		nhlen = 0;
 	}
 
-	return pskb_network_may_pull(skb, nhlen);
+	return pskb_network_may_pull_reason(skb, nhlen);
+}
+
+static inline bool pskb_inet_may_pull(struct sk_buff *skb)
+{
+	return pskb_inet_may_pull_reason(skb) == SKB_NOT_DROPPED_YET;
 }
 
 /* Variant of pskb_inet_may_pull().
-- 
2.39.2


