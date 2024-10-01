Return-Path: <netdev+bounces-130730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A554B98B5AB
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9171F21D02
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804691BD4FF;
	Tue,  1 Oct 2024 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4yHDFsv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0379A1BD035;
	Tue,  1 Oct 2024 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768097; cv=none; b=Ilofymrp3kqEUuCHt4MZJ6ODuFC0fTZ64u5VSPeAUy9F2vBpPdZtpN8sT43J87rVz0arM6VfvIEd5z5VyWSilo8YJconphakmM7poPke3ueYZgAVtdO/wWYMEIqUzwUkr8FvUhb08Tz62CwYBx7oruKhNsqxUFobbQihvENhiDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768097; c=relaxed/simple;
	bh=2kAxEGjit4mtFH9V00w/Gm2iNB6oUkSEyEwW+ddERcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SHAOvQf+cKEwDbAfoPTHccQDe94arwTth8ANvAFQdQpgtWAU8w6uaIpR5nhLx3zivEqujuVYn6Q8RY6GhXNRpBJhgkNFpBZmUAOXMUCBvnkJipSEXpHgYvMW7YpomY5FnTAutPy6QHBHSM+OQg4Wl90aZnu6qHjYeIlXChaed9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4yHDFsv; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20b49ee353cso35397145ad.2;
        Tue, 01 Oct 2024 00:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727768095; x=1728372895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSsuSiiaj61uz7pRDUrPYhLqMHKa4jcQjUBCHvJMqsI=;
        b=R4yHDFsvHhaT5SesfCiKoWIyaz/kbNn3f7JhaxQQnMUzxDuz+miB2eJOykmbiWjRqG
         /8X70GdSSO7sqfb6sp95qAnY9a8PkbLO5t9zyzxiW6bMsNO9ZU2kv8slYoyNG+qkm9g0
         KWzOagJVGS5g5BqwjbGJ4W+4m4TS1sKSi55ojQCQvDxd6KLuI0FVeSVwB3p+BUtUU46T
         D/B+KLIyKAfpfDfuaUWx+RIeltroWtCYQAEMBHI2F3WFcz94h26KxYL5y+bVNXsAoxNq
         CBhM1uUxmcY6UgSFjtwmZTBa+JrT/crhQVudxNsY3ccNbps2BbTklX+GnUJDtWCMGY7u
         6pVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727768095; x=1728372895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSsuSiiaj61uz7pRDUrPYhLqMHKa4jcQjUBCHvJMqsI=;
        b=Q26afonJVBTt56Df9uU6gSdlFj/YrPsBpDuiVoneCQVQiUjDhYX7Zt6LpyKO9Vxdbj
         e+XKpn8sHVJr3BpKXMwXQC0RFMLVZ9Yl2HXFonVs1Mjd1GwqV4MgBmAsmuMRK9YZKbbl
         ahrLYhH7wApzv/lQK/WT6k1S2AtqoUwAl8nSsd1n1UBxlnAXHa8IQ3KVFjDE8qZZSJii
         p9o6yiD25TYzNYMVeXgCXa+arJqDN9JzijCLy+C14LlWfuf2TV0zUJyxeGXZQEOSm3nw
         Yi63OMxkUqEQWSkjekpByZ1ChiwXS5LFfKaZMPTKL5D+cklJbkdRvcSWWGOjB0ogWM5G
         k1kw==
X-Forwarded-Encrypted: i=1; AJvYcCUp0XkOYmrQLh5LbV1joIADwHIELiL+KqfrgEg8OVCd+EiQzH7moB5HNR5fjJx2LiPf/FIMdYVU7p05H4g=@vger.kernel.org, AJvYcCWCgsuupE34nEp6GuxDIwCZk/VIWrl6cZNTShKW29LNT+YDX/t8WLusFvhgK7HLzi5YdKI/igeV@vger.kernel.org
X-Gm-Message-State: AOJu0Yyevrb71FRJ+ki9rY/G0iU4a9HHmOoqass9hqtA2hfgZYKQTja+
	Q3qkuHz1SxwFW1tzOv9Tft8sg4mmoCfhlYfOPxdCTZt8RGO0n3mS
X-Google-Smtp-Source: AGHT+IFt89okGzSxlu3iPI8mycwt8wE6y2TvpVmjZcrm2u4AUAQ1j2Q286OoKFk7Yk5scsf5X61gVQ==
X-Received: by 2002:a17:902:c94a:b0:20b:9b07:7779 with SMTP id d9443c01a7336-20b9b077929mr70517835ad.15.1727768095207;
        Tue, 01 Oct 2024 00:34:55 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37da2667sm64545575ad.102.2024.10.01.00.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:34:54 -0700 (PDT)
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
Subject: [PATCH net-next v4 03/12] net: tunnel: add skb_vlan_inet_prepare_reason() helper
Date: Tue,  1 Oct 2024 15:32:16 +0800
Message-Id: <20241001073225.807419-4-dongml2@chinatelecom.cn>
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

Introduce the function skb_vlan_inet_prepare_reason() and make
skb_vlan_inet_prepare an inline call to it. The drop reasons of it just
come from pskb_may_pull_reason.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- fix some format problems,  as Alexander advised
---
 include/net/ip_tunnels.h | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 7fc2f7bf837a..d00d8835e789 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -465,13 +465,14 @@ static inline bool pskb_inet_may_pull(struct sk_buff *skb)
 	return pskb_inet_may_pull_reason(skb) == SKB_NOT_DROPPED_YET;
 }
 
-/* Variant of pskb_inet_may_pull().
+/* Variant of pskb_inet_may_pull_reason().
  */
-static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
-					 bool inner_proto_inherit)
+static inline enum skb_drop_reason
+skb_vlan_inet_prepare_reason(struct sk_buff *skb, bool inner_proto_inherit)
 {
 	int nhlen = 0, maclen = inner_proto_inherit ? 0 : ETH_HLEN;
 	__be16 type = skb->protocol;
+	enum skb_drop_reason reason;
 
 	/* Essentially this is skb_protocol(skb, true)
 	 * And we get MAC len.
@@ -492,11 +493,20 @@ static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
 	/* For ETH_P_IPV6/ETH_P_IP we make sure to pull
 	 * a base network header in skb->head.
 	 */
-	if (!pskb_may_pull(skb, maclen + nhlen))
-		return false;
+	reason = pskb_may_pull_reason(skb, maclen + nhlen);
+	if (reason)
+		return reason;
 
 	skb_set_network_header(skb, maclen);
-	return true;
+
+	return SKB_NOT_DROPPED_YET;
+}
+
+static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
+					 bool inner_proto_inherit)
+{
+	return skb_vlan_inet_prepare_reason(skb, inner_proto_inherit) ==
+	       SKB_NOT_DROPPED_YET;
 }
 
 static inline int ip_encap_hlen(struct ip_tunnel_encap *e)
-- 
2.39.5


