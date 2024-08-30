Return-Path: <netdev+bounces-123551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C459654F5
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D4F4B22F21
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B30D7404E;
	Fri, 30 Aug 2024 02:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4rwHzCC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0348B71742;
	Fri, 30 Aug 2024 02:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983353; cv=none; b=I06i6mED2ku7E/Z0/CGixdfRJE7ZIS2gLfD56BfdAjBa+mJuz+//KELOQ5JKkpL3n422oCyh8GhGTHtTPZ78sLJqHp+8uuazI3YpVI5YM+eiMD7H+oRmR4UOWzoMKVuBxmoWJMKiLn2NmQS1zcKnH7CPo0uc+MhC7KuWWtfgQTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983353; c=relaxed/simple;
	bh=BjupJZu1E/fcfxWKlB66JWida6SqIOij/q7rMugI49E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c3kl5tv71vHBRGW4TyU1uLPrDOdHVnVgpfB6mnlTSbRy1u4BMNy6IVOnDOnGdiPoR17CsHA+Y0xDh3/v7ynliAPCgMJqZcgAqIGKlt1OXOKOyRN/CP/6rTDlNwWPrc5UKSSJCnj7XROPjUxxyx2oGLnzMJsdNdHMWP35vX3LhqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4rwHzCC; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-715e64ea7d1so1066442b3a.0;
        Thu, 29 Aug 2024 19:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724983351; x=1725588151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nl/wlYbJ8IhJjGotsXRWm/OkatmXtly5y1k+64ypkQ=;
        b=b4rwHzCCz1MCC6ZKCPOWS+iqZWhhOPoAHmSbTf7x7CYccp4a6LYLenJJvipSRJdCTv
         DVQkE3U9ld4KGByltxTT9Z9fjp84B/FDEobeUg5VbgKZ442uEV8I1lcX49sJAzK1HiFW
         Gxf25ncH2DRzjqD5LtHyXlAVMi3WGrco8ZHqe8O5j9O+3ZfykZpgDHzL2XQLxE6ZiFWh
         cLI4htRCWm0BAQr3L+ZmyduDsQEAWwjuCaezv/hMbzWiPaRz9OfK/qLmH17yIrErOiXs
         CZOTtVvMUQc1yY6FRBYP7FiSGkKyinbHVXi5qUCnM12HdbbD07DR1fq+M5gYXHrR6/Hl
         tVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724983351; x=1725588151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nl/wlYbJ8IhJjGotsXRWm/OkatmXtly5y1k+64ypkQ=;
        b=XQhaKMf7qAZPhdsOiPQqTNq0N7WCWkp1cT3Zs/X6YEsnS/rmj6GoMl8VtLgnppnhnt
         C0HGxoZhhMk6KkaEpHczaPcRTGiSUrmODxA5goFwpBb8vD+oFdJonoyoAC08tFOHzDD5
         dcPb1ZVuExn79QwvTDrXoVr3tJeCW5WsBKr/YYe3E5dhyJn6kVIJ/pTssRf7jc/RGK+k
         a3itwKdwewVKBpQ6h1cZY+W/Ie3P0yHMTNsdHU6ShHk6weyHG1czuzABEFVJZkh1SUvr
         E4p6DQGLBuQy6ArnO0lmpj8q3PRPH/bVFmYEO02p90mv4NVaQbJ5p2FoG6joL43NkXAU
         eK5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBqzB74NjpZCg7/VqIFYAIs3wuaAVi2dmgCPfB+e6n42SWi0+Wx7tCKnFV9snx9Z47xPMsfT3oA662ezM=@vger.kernel.org, AJvYcCWdxulVVRTpAtD9Ugqpc+5mbap8fLZSTaPPHF+9lWceWBdWkUrIPzFVL+PnLLBw8BAgHx/dfP9u@vger.kernel.org
X-Gm-Message-State: AOJu0YzdCw55ScADKvUBZe9wSU4CyoIEWLewDznO6A7KwSsbzi8Zgj/L
	alTPvtz9o680xgywltHrsKBoZalGsomIMFcl8W/XqIfcpMQF4i9H
X-Google-Smtp-Source: AGHT+IHDvvN8QviJNtA1TyJ59DoptfuF1c1cvOGiV9GfceeouVrlPsgaQP28qMxKWBm2Io/6CJ5Wkw==
X-Received: by 2002:a05:6a00:855:b0:714:25aa:e56b with SMTP id d2e1a72fcca58-715dfb2d890mr6862607b3a.8.1724983351161;
        Thu, 29 Aug 2024 19:02:31 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a6b60sm1764221b3a.87.2024.08.29.19.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 19:02:30 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org
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
Subject: [PATCH net-next v2 03/12] net: tunnel: add pskb_inet_may_pull_reason() helper
Date: Fri, 30 Aug 2024 09:59:52 +0800
Message-Id: <20240830020001.79377-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240830020001.79377-1-dongml2@chinatelecom.cn>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
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


