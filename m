Return-Path: <netdev+bounces-130729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE96098B5A9
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF7028296F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD7D1BD4E2;
	Tue,  1 Oct 2024 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXMLIMFl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ED81BD035;
	Tue,  1 Oct 2024 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768092; cv=none; b=lB9diEOuC2qgL1n++NL9odFwHKu1UcmQRDV8Cyha+Gso9lZWNemwi6CFGty9wWmYNo8a+HewpISYFHM74cjatIUMc+5S6Q9EQRdE7Foq8BTwSSiAxpXat89IqMFAXpOnrCF7vuzmhP9En0DC1I8QHajwMwdJIGNUb7L4iF3mAO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768092; c=relaxed/simple;
	bh=SaptGihC86tNOvUkBDgiENqfMTP1m9x077S6luvzAhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XpMqC/5WIwSyL1/1TXGQa0XIjX5UwJOx0KPvM44Viux6ttOCNqbWtyhg10VhS6MhvwyBKWOZw4jM8mKhK2ie+j9Pv6EQIknlNC0MFU9P7J1aGIX7O0h1lwVeGbRd/qVX2vFbRcKcaZd8T/w0oovsaAW99a+JX0E7mHqa8yJEPao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXMLIMFl; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20b7463dd89so24385015ad.2;
        Tue, 01 Oct 2024 00:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727768090; x=1728372890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulwkzfKvIm0r01HmjWcKI2Wp5D2pvG8AiNMhaNAoG+M=;
        b=NXMLIMFlTitkSkokDLg/KrzCH7izE9TKAYoHp1pVM6q5gSdd5DntxOAfxyLHbyC5ZZ
         JJF+qLeDvFkjwGyMVSWBIlcQhNaYCvffKHUdUFcxXYTHmJswe2l4AYaVlCOfL39jYWkw
         VxPS75jkNNKeZE4TVUf0EjdpvMF4bSTvSxivVEJSsypaqMFO9/KBhFlFs8OK0mPbTkN9
         Wi1HaF8hyfVmqHh4Jx0JbsFspKG8ol9Y+oUJ6IWJXaJiaZHStLAoLlLaf2YrPjwRClW5
         u9Al6PZCRMZ+N0+ksKWeprfRVRqYKW9QUqZ0DdnfX3upAZUvoxQ7Fq+l4pj75Lzj6TL+
         m9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727768090; x=1728372890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulwkzfKvIm0r01HmjWcKI2Wp5D2pvG8AiNMhaNAoG+M=;
        b=PkUlHbOOuuwhff30gcHRAf5RWuIZD/e093nVGhhaeaZrzJIbGn5u2p3DB099J/oJ1S
         A1riPmYBEu83/sisPqAEh6moZsggjFe/Z81VcvlvmPN9NDH2KClK+72J4hZEyfVpEzrH
         IKEQ1Q4vafldiw1S1ObAS/6lRBZufspQkeozRubImAmVDJ5+nMC4k12oVVvMScnq2B6i
         RBIm1QVTGpwqN7BWy3RvL/n8kK+Y0FIh/3LYtHJsQ2WXPQaaNeNH+tQxRbx99i6ojlYW
         svxEzrl0w8ZAZnzDObn7zCQBVpIDWh0J1ym0rzAKmrhezh/D0qXB58H4Nc4kK/f27WSN
         y0hw==
X-Forwarded-Encrypted: i=1; AJvYcCUHD7RJXP4b9jVn/JZWi3yqGUjd1thOnYd2p3r09SI9EDNCrLlVPvjMOisUNma0YdIC30Nk+WFXeCPSSZM=@vger.kernel.org, AJvYcCUk+BEJqRKg2f7+rBct8Mwrtgdt5afnhLFAi0QBv9/y5Aj2saaIchJ3tNwhNhlLF/mDJEVX8OU5@vger.kernel.org
X-Gm-Message-State: AOJu0YziH60gu1eEte8wFir0E6lrT/oGecdIlYDhhKafKuIk1kbGD4et
	AxfosaeInIzk6GvWT6rxluYWUFuzeF57dVR2YwKB0O0+AccVZdcv
X-Google-Smtp-Source: AGHT+IH8Az7a8k5Esao0GHXTNIsZl4hGxmMm6MIGP+3XpccZGm3FQrnP+P5BbVrY1YFLsyODPbf5uA==
X-Received: by 2002:a17:902:d490:b0:20b:93be:a2b5 with SMTP id d9443c01a7336-20b93bea53bmr65337445ad.32.1727768090286;
        Tue, 01 Oct 2024 00:34:50 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37da2667sm64545575ad.102.2024.10.01.00.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:34:49 -0700 (PDT)
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
Subject: [PATCH net-next v4 02/12] net: tunnel: add pskb_inet_may_pull_reason() helper
Date: Tue,  1 Oct 2024 15:32:15 +0800
Message-Id: <20241001073225.807419-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001073225.807419-1-dongml2@chinatelecom.cn>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
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
2.39.5


