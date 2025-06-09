Return-Path: <netdev+bounces-195828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5DDAD25D1
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103CA3B1ECD
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 18:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B32221FA6;
	Mon,  9 Jun 2025 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vdJDD0qs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D123221DA6
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 18:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494448; cv=none; b=ffk8RJQtczHSi0RDdzfV5L9Z3N3r4IOfuDO+4LhDQ4dy85POwTeYxceOunX+04i7jbstZr8tZkQz6oaQEzUuG5J2S1J0ZGNkTnkkrD72nJ1i15ULzGM564cVFvHjM/1iTAvoAlSdCw6sM+Xs7r1kh7tTHijuy8WNuT2Y0bkJyas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494448; c=relaxed/simple;
	bh=boQTOjwX2c24Pfybgax6/PQtLcHgfszsI3qjmInlNss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=imjimX7jxX7sOa82UaGapc4noMLZbhb9Y+3lvBBGk4D0wrKhmPBA3Dvi6V6Q5Tk8dqD7Py7Vt0UlIXquqFc4NcikTULUFb5zVqAclfILHqEtvRIXwDgMjwrd8ihEEgIkbb8BWNOn8z4nlt5gEGfFTjeLYkAlZSBbFKKoI0Shp0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vdJDD0qs; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26e73d375aso5189112a12.2
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 11:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749494446; x=1750099246; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JQwIWqCovddalYZ+Q/3W9PbmXzGEa6NGqsKWKK++Z+Y=;
        b=vdJDD0qsNR/D29b3pr2csov13tWMefsAcf9mtjfCtJ+G+KlPSdAf7SDEG8n0idFmUo
         kim4LJmTlDCQAiDHkvGuACqeV2YFtStrayKgKV7XvyInRCGca+IK7oFwT3Bl7HS3GXRj
         HdDKAGq9cgkduB26LdUYsg9BUbcMisPqXn0/ZxgB20Ks5v8giO2BCFSRpg4ATySK419o
         VfDluDYJj1HZMD4fQMdrUyFQELjI0wUDoUkvmYETPaIx1dpI4NhJzIpN8n6uJ0pfMOQ4
         3XrKt6f+bqVNdkdBarhHb6RR1GvMcpnwIkypxpOo13YtulBdzS4w95c4l4L7mEl82oLI
         grFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749494446; x=1750099246;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQwIWqCovddalYZ+Q/3W9PbmXzGEa6NGqsKWKK++Z+Y=;
        b=kpsFqFRcckeeq4WpDS+lfmfJJnY67Qu9f44ivwfykJIrB4LFSm8xVd8DoOwf6nAAoj
         yKIHm0F4eSBfwEngWhdfMi6U2ZGUvBbuZlkJt9qx7/3UAb6se5bASPZdkdfwPBRn5gzz
         uyvLSiuv20HHHDDuNuqcCoiEC4lCQZIHaqkZJvCcGGlO6KLsHhVdR1xztglN7V3FRIuK
         vecqPr/8gmEV6/gwWf+1Dk8l6fUDmRdOqXOzDXSB4DgUD2SJM58Tt3hkpJu3jmFzG1jr
         GpEn6RJuCqTAAC7lkDtttVSf7fEWngQaZb0sUvZ47wSEjK5+b9GGWTHapZaHs0WeCza2
         LgRQ==
X-Gm-Message-State: AOJu0YwD3z/+XsGVWlneN/EY+ur4nyKcSerQVV+PjlDBpCL+M3V1ghf/
	i7keYJCWxaR/ZiVjIBt8+wUK82ziM4k31LR5EILjb6wu1aYOFRRbXPojQP96fmhYRJv1WTv6TcJ
	yVJmXOMiTQ44l+2zur1TZT5iB2UKhfklPDCvjg1uE4UAyutV1N/+XFpqgxTg5AqVal9A7GF7w9a
	5Smq1ybdU6hp4GXh5voBdK1uTmBONOtLq9L7d1hHQqNPPUOiWWgWdbB+TVdtf28eY=
X-Google-Smtp-Source: AGHT+IHeuoUadWEWKD3pSguppbjeD/22TcrgtZyG+qx5oXdrfnVBAmpamNsRrF2RlWf+7q5vo7WLI91ENJovTM6YPQ==
X-Received: from pfbcj6.prod.google.com ([2002:a05:6a00:2986:b0:746:2414:11ef])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:999c:b0:1f5:72eb:8b62 with SMTP id adf61e73a8af0-21ee68c8addmr20977983637.20.1749494446304;
 Mon, 09 Jun 2025 11:40:46 -0700 (PDT)
Date: Mon,  9 Jun 2025 18:40:29 +0000
In-Reply-To: <20250609184029.2634345-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250609184029.2634345-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250609184029.2634345-9-hramamurthy@google.com>
Subject: [PATCH net-next v4 8/8] gve: Advertise support for rx hardware timestamping
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com, 
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com, 
	shailend@google.com, linux@treblig.org, thostet@google.com, 
	jfraker@google.com, richardcochran@gmail.com, jdamato@fastly.com, 
	vadim.fedorenko@linux.dev, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: John Fraker <jfraker@google.com>

Expand the get_ts_info ethtool handler with the new gve_get_ts_info
which advertises support for rx hardware timestamping.

With this patch, the driver now fully supports rx hardware timestamping.

Signed-off-by: John Fraker <jfraker@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index d0628e25a82d..043d1959fb9d 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -929,6 +929,24 @@ static int gve_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rx
 	return 0;
 }
 
+static int gve_get_ts_info(struct net_device *netdev,
+			   struct kernel_ethtool_ts_info *info)
+{
+	struct gve_priv *priv = netdev_priv(netdev);
+
+	ethtool_op_get_ts_info(netdev, info);
+
+	if (priv->nic_timestamp_supported) {
+		info->so_timestamping |= SOF_TIMESTAMPING_RX_HARDWARE |
+					 SOF_TIMESTAMPING_RAW_HARDWARE;
+
+		info->rx_filters |= BIT(HWTSTAMP_FILTER_NONE) |
+				    BIT(HWTSTAMP_FILTER_ALL);
+	}
+
+	return 0;
+}
+
 const struct ethtool_ops gve_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS,
 	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
@@ -957,5 +975,5 @@ const struct ethtool_ops gve_ethtool_ops = {
 	.get_priv_flags = gve_get_priv_flags,
 	.set_priv_flags = gve_set_priv_flags,
 	.get_link_ksettings = gve_get_link_ksettings,
-	.get_ts_info = ethtool_op_get_ts_info,
+	.get_ts_info = gve_get_ts_info,
 };
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


