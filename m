Return-Path: <netdev+bounces-232972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4CBC0A94B
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 15:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DBBD189C88D
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 14:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D312DC76C;
	Sun, 26 Oct 2025 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Sa2pA6wN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7044A26E70B
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488325; cv=none; b=NR0NF+MVbCTHUaVswvPFh2uis/BHYhgk0Ub3tXdcvxuX4kywG0pxANTrc2Eqc9bluXSkiyI00bUPD7FTV8I+wnDcSNXCSqFWxaFc1BdN5+u5F8ihoW13SrNMGX7AL1EW3hQ6a2Grj2Ph/FOr6JFmy308698SjhQ1vuGD8RZot24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488325; c=relaxed/simple;
	bh=jphV3hLYyJpq5wHhzxxIdaldllEhemXAkq3l8pQxo6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A4xrPzYUbkTIi2aAgI/4M1QDLIqeb07SZqaOlR+YaGbWIbJlr0dvtKpz0YUUZzxc0+SXX5y+dzsdj/BtpN7XrEwWareMuS+ZAgTo95STlKX1EzY4klg0HePeWBRKpHjKkv6FepkeQQqovtpIgH12sknPw9v0ONiDcBth8GGw01c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Sa2pA6wN; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so6584663a12.1
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 07:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488322; x=1762093122; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phiaj2apVtnJOs8yCgS1f4Ia15HnRGM+EMU3gmWsJiA=;
        b=Sa2pA6wNT37EOrzXIh3GWpFsVcL1jKxltmWJqzaH7lRmGNZAoVJvXMm9tH4i/8qUXP
         noNDXtrZWkcI7r/TfExV4K8mGuP0bu+TreMea7L+7ZVcRnTHvYXAV8HbntPL40mPfwa5
         2gX/8MaSn1FCu1uYVqxP1QFelLktbbpCD8CHhX1kuDHFILIGhlbVsNY25WqeJe+owTM8
         +UhxwzqeFfdX65+y1LYJNBhBYa9WRZTekV9RYY0ASFHuiVLwbgPsBOTWIazNCvVecX9T
         foMAWD6H1XGo3hpZsmPHp0aToc3GxVmBzSZPc1SkeRSGkIMlDNtiz9ncINALwZYp3H1q
         k45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488322; x=1762093122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phiaj2apVtnJOs8yCgS1f4Ia15HnRGM+EMU3gmWsJiA=;
        b=AdKKJXg9X3Ma2st21KNxW3uHreCZqajGuVKONso1mILOJLkguETF0eAxPRGyo+Sk+a
         tG9S2a01M5qFdYCw4tTPaptrhU4N7c8kpJc8sEldy8h9w227SKuR0UYQzeDmnWefgQ6A
         px5Stx+P+MUO26bhc5+hJB58O6/MiVgrjASeeMnEegaOs5Sa8uCKotA5aPxquw0xVQOw
         yMRh2whOc04R6c7rwukmdb9Vn2Fy3dasu6V7AtBRfMDgzHkdpDkuDz0oU5aS+LovVRx5
         QYLcjQHCPJmC0lj6BxlkCqQmqp8eGmlbhRb8H0b3jzIM41nqlUBl7g7VB09EYEi9CgJi
         Z6+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6uZEYfrWs9m876ze89TvKOtbXagnfbP9BL0jySLwgOhvajr5nJ9896iotK0LBOdzCvrVi3RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YypkRf7rizC4bAji4/LT7xiaNOQGJP//Swfk5wNKPJ9cKus2DXW
	uE6oGmbqwS5bLQa/K82arCOiXwpYA5aVUZ3gb9+nAcufqvfAn2wdqC1y2Yys0ryHv3s=
X-Gm-Gg: ASbGncsgclw0Ip4y6ezDL4BVGspW81uLaRkpBgi0iMRa7dmqkiBJe/5cdaVLW2Ef8Fm
	9GGCcGnwgRMn0BH3hbDYc3LPSFL4UBzLjriTtu6lO3cMRb2WlNPnIfYZCWjTpnRcxKpCNqofGDc
	pj1FGBnIE9W7UPFrJhdCJP4TTRciP8kQQDhP45WA46W9BfY07T96hDRkgbPCe3mHLzyl3qfAQKI
	LPp+oeSceLufw7POweg0fKmxBcnK9M8+iz68Yw7Fp/4rpijWoXa/IUS4sIpHcfjo/CK+rQK/62z
	HGvcYbAPGf3AjIC7CXKceSSyw1X6g95xgBQo6/LyQoSM56hY/Jx6tQrrK2G33J8TskGlIq7qCRE
	6/rtRyZiGcK/z4mrPCSXSir066TVLkieFE9qAAm0iNcnrL3Ngre1dSrkU8OA7jkQ+jwm4W1rVW5
	ujYibJs2MdDJy41B39D3CazEB/Wa2By2x5Kt83TRSdY94l3Q==
X-Google-Smtp-Source: AGHT+IHDoSQuLmZ0G85khQ3BcIwgUaCdIiwalX9UUVGR8MCUJTFHyK6jO5jCuCpAr4Jxxp35lurlsw==
X-Received: by 2002:a05:6402:51d1:b0:634:b4cb:c892 with SMTP id 4fb4d7f45d1cf-63e600995c8mr7196990a12.32.1761488321779;
        Sun, 26 Oct 2025 07:18:41 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef82b6esm4061891a12.11.2025.10.26.07.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:41 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:24 +0100
Subject: [PATCH bpf-next v3 04/16] vlan: Make vlan_remove_tag return
 nothing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-4-37cceebb95d3@cloudflare.com>
References: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
In-Reply-To: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
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


