Return-Path: <netdev+bounces-108267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F314C91E8F5
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA33283072
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F856171094;
	Mon,  1 Jul 2024 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="D9KhVvZA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A053116FF4E
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 19:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863743; cv=none; b=Wj0IUdrj4KR5emVoXO7J92xliYjmHoiw7P43ggfmOnJ+hzcE4nuK/BaXenzmuAxJhiQ8ypN8RxohO0E1rmbfLjKAy5tav0YeR5QOLdk76I5GmzPvJkJK6sOwl0OnV/45h0T1KvpQZ/yRE+58YBhgx09TgEE0ZehhfN6fFfhEb7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863743; c=relaxed/simple;
	bh=wY9AAuF4FEm87P0bhytpAgogKE+ttOxkUg/JOWBRpF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y2kUaYOe/Gm3A+VuZxCVGk0TiwdYBaOXrcLKSBFCWGd3JobzzcGKl9ovep3AykT6M1s1OK5vk+pMdB7ihNqYyAJGoZUP1ZryblfySW8wclpvpBYRgeW5hReUWBBIj2di1ldxuVjPODrAXMQgeyvmpAqncrLISoTql24Pho2ueQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=D9KhVvZA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1faad2f1967so33572885ad.0
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 12:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1719863741; x=1720468541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+MUYNVtleEEkt8v4UAX8klVrIAJI/EYBs/Ma+PY/Rg=;
        b=D9KhVvZANJfdMmTF6gNmvcyhgPvoCFhbxHxn5XnnTgp3cB1OewJHaBdG+k5RU+TExE
         nyD0Kk+PE8Y0PWoCmzlsKR1FUUu4viUXwv/l1CphQtKYGRWdvNBR3D3s6lCFwMksANFX
         v2KIRTF4jkdaaYkX3FXdnnMbOSRNGI8d1NIw5W3icG3SsuiYYBOT/WCVnGAghaunDbAU
         mL/FU7N2FwY40KJOypHBT1uP996d6RkTKp0C1vvqoFrurfw7iIBv6/e+HqQvVluN5aXC
         zv7QKRQ9YeHEUUo4M6KWgOgiX9dx0AtyAvo6tLimw/y5eLjSA15iw8abNQU6vuAxciC1
         Q3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863741; x=1720468541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+MUYNVtleEEkt8v4UAX8klVrIAJI/EYBs/Ma+PY/Rg=;
        b=TxLvvJ36WuoWa6v8ug/ZznR18ZQSdKpUMRQKNmSZVVCYT2sQ5YZbN6uMadIWCUDx/4
         e7U7wApqzLTX3H2U3QrrsQLoMZAmFe+lKNCGwtMgENCmXdiM8ILGObyG4O+OV3d/XRwS
         JKrQzpVEGV6rgJqKM4jiqSssUI0PHMhXScL5KPVEpXqT6sQpPHeV/2gzp72wumndWX/x
         N8406acplLlmzukiZjAEM6MYeWhvMrq/S1eSdsFsyKEKh/p9qHIgufts4qfjwnkRS53S
         a6szISc4tH7IBPnZLri5XujHhUwh94bGsYk23ewLlFNnu2tB24DA7UtTgSDkZn8lH8d6
         IIHA==
X-Forwarded-Encrypted: i=1; AJvYcCUsELln9FmvwdT3XCJNI9GzT0/YQr/NE7lE7B5wIQ7gHhPdRkXe+MDijjJffqjSTsqVVea/LdbkOX1HTBLskEUbCOkD7do+
X-Gm-Message-State: AOJu0YwdBXbdB64+GzkadRqwwawTWR5EX+3DuD/7UZAwrSI4APlo8oS4
	eP9dj31nAXlt+T1rQFnYnzHCwhGDjdzOHbZJ0S8Tjm9N19h14uf0IL+BdSeryw==
X-Google-Smtp-Source: AGHT+IEUkxep1ozwUiaocR7v8iGkitxUKRQnp6Rzxqvr4UeMuh5P4ti648Zw050UuFUvdhux+IlllQ==
X-Received: by 2002:a17:902:d4cd:b0:1f7:1d71:25aa with SMTP id d9443c01a7336-1fadb42d78bmr112532305ad.6.1719863740997;
        Mon, 01 Jul 2024 12:55:40 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:56da:44f:4289:b808])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1599c44sm68785155ad.273.2024.07.01.12.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 12:55:40 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	cai.huoqing@linux.dev,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 6/7] hinic: Don't do TX csum offload with routing header present
Date: Mon,  1 Jul 2024 12:55:06 -0700
Message-Id: <20240701195507.256374-7-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701195507.256374-1-tom@herbertland.com>
References: <20240701195507.256374-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When determining if the L4 checksum in an IPv6 packet can be offloaded
on transmit, call ipv6_skip_exthdr_no_rthdr to check for the presence
of a routing header. If a routing header is present, that is the
function return less than zero, then don't offload checksum and call
skb_checksum_help instead.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_tx.c | 23 +++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_tx.c b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
index 9b60966736db..ba6b7481b6fa 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_tx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
@@ -357,8 +357,10 @@ static int offload_csum(struct hinic_sq_task *task, u32 *queue_info,
 	u32 offset, l4_len, network_hdr_len;
 	enum hinic_l3_offload_type l3_type;
 	u32 tunnel_type = NOT_TUNNEL;
+	unsigned char *exthdr;
 	union hinic_l3 ip;
 	union hinic_l4 l4;
+	__be16 frag_off;
 	u8 l4_proto;
 
 	if (skb->ip_summed != CHECKSUM_PARTIAL)
@@ -374,17 +376,15 @@ static int offload_csum(struct hinic_sq_task *task, u32 *queue_info,
 			l3_type = IPV4_PKT_NO_CHKSUM_OFFLOAD;
 			l4_proto = ip.v4->protocol;
 		} else if (ip.v4->version == 6) {
-			unsigned char *exthdr;
-			__be16 frag_off;
-
 			l3_type = IPV6_PKT;
 			tunnel_type = TUNNEL_UDP_CSUM;
 			exthdr = ip.hdr + sizeof(*ip.v6);
 			l4_proto = ip.v6->nexthdr;
 			l4.hdr = skb_transport_header(skb);
-			if (l4.hdr != exthdr)
-				ipv6_skip_exthdr(skb, exthdr - skb->data,
-						 &l4_proto, &frag_off);
+			if (l4.hdr != exthdr &&
+			    ipv6_skip_exthdr_no_rthdr(skb, exthdr - skb->data,
+						      &l4_proto, &frag_off) < 0)
+				goto no_csum_offload;
 		} else {
 			l3_type = L3TYPE_UNKNOWN;
 			l4_proto = IPPROTO_RAW;
@@ -411,6 +411,7 @@ static int offload_csum(struct hinic_sq_task *task, u32 *queue_info,
 			network_hdr_len = skb_network_header_len(skb);
 			break;
 		default:
+no_csum_offload:
 			/* Unsupported tunnel packet, disable csum offload */
 			skb_checksum_help(skb);
 			return 0;
@@ -421,6 +422,16 @@ static int offload_csum(struct hinic_sq_task *task, u32 *queue_info,
 		ip.hdr = skb_network_header(skb);
 		l4.hdr = skb_transport_header(skb);
 		network_hdr_len = skb_network_header_len(skb);
+
+		if (ip.v4->version == 6) {
+			exthdr = ip.hdr + sizeof(*ip.v6);
+			l4_proto = ip.v6->nexthdr;
+			l4.hdr = skb_transport_header(skb);
+			if (l4.hdr != exthdr &&
+			    ipv6_skip_exthdr_no_rthdr(skb, exthdr - skb->data,
+						      &l4_proto, &frag_off) < 0)
+				goto no_csum_offload;
+		}
 	}
 
 	get_inner_l3_l4_type(skb, &ip, &l4, TX_OFFLOAD_CSUM, &l3_type,
-- 
2.34.1


