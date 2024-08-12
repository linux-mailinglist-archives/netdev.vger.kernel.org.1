Return-Path: <netdev+bounces-117766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479CA94F1BE
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C781F248B0
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF2D18800C;
	Mon, 12 Aug 2024 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYWQGqAs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FB3187877;
	Mon, 12 Aug 2024 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476652; cv=none; b=hJSTg2OLv2zplFBSft/AB0QxRsih2isZbrTtR6pcsfZXXMGE7d0h+LLgOUxBnpZe8+y8/zig9Xd3a4ca+xcoArHEegyyTrnwxKHuHdOX5Dj5pGYFCTp2J3mifKGkTkO/IEEjOU/hlqf1/EbgEapqMjWU3bsNbknS2scFweDZTYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476652; c=relaxed/simple;
	bh=/694xjNaYe75aY6C7Vr2retEXvVxynOW1pGlj6x4h6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDZ1gN/1ZclH2Wxdyb27mRmZ/jXGaGepQf0iuHJpf89PwKXUMeD3n1b3qX7d61T4Nivgjrc2rH5cIzRHINL0PT8K7WKb0rW5ib8mZkG/UOERpXfYN16IkSpYrcY9i9V1ZJm1e4Bp0qzCDNR9nY4/YoDXE41eXYLzVlv9iDsGZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYWQGqAs; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa7bso5328825a12.1;
        Mon, 12 Aug 2024 08:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723476649; x=1724081449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3mEpl3gemolhJql0kO9GZwMm0STDd9PPdpHVFTjscQ=;
        b=hYWQGqAs63JxwWQGieZpom404OZpS7GLIEuwBg+VmsGd7VFGbPR9vBr4kEZpYItdZp
         sz0EV1lERI0sAM/UZgT2Jwz/JktWqmhuqwsDD0VgBY2qtKsodikKl2n1g1f2KswSk/Ru
         YuPwRYNcsZa5UZ+2MmeQspgRrXqQbInJTo5UXwJpOpAvaKVi3GVAVTRaPoM0KiurbXhj
         2g72GROXfYI8t6VuJXU/unIGL+fnXUm98SC5xxaDzQj2k1GQi4aOkO0HjTHkPB5/3HrC
         rpwlYBOevRCwRCdtPQ3k/yxJjB4KZymkbSs3i6AwmC50IQqKzjuvGkiFYG4mfzIbo+zW
         /bIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723476649; x=1724081449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3mEpl3gemolhJql0kO9GZwMm0STDd9PPdpHVFTjscQ=;
        b=dRMtLZj68oKKf6ET8OJdKmojzGUF8vAdREKqzHrwzi6D6/lbUBd7qtvfSA8qLeiyjy
         K7S6DYey9yWuRtdVoL8lJOqMa+J2p/gumDr2AsnxTOenDcDTSF7Fh6RS+fM/F35Mpt+V
         KLucfR4Lmh5yff9FlecF2Mvqkzi+rCYeW41mBiZjY6un4MqpqjCaq/8sZByGDzlhrkHJ
         Ab7oX3+Ai7prQDufqCxcjtJ8uy6qpl3XVLbJZ0KHECjT2mtxWJTs1TUMpPD3W9TPfUle
         RKJLRFrtLY7dUtqa7mQXo80jg3d8OoGeLR3keM9498kmXYDHIA3q5iPv/3sfndxB/Wnk
         7L1g==
X-Forwarded-Encrypted: i=1; AJvYcCXjVVL6sUzfI41eipB56eKjKOIZn0D5RUcA5ShBsn6Btm3aSC3uXH7Uz2OedJc4bCTQOHgGEtlzVqWsWnOEXAEjcv6dZm7gQ9+RcnhmGiHgzBVAOV7t4shqEwVARyt72Zq71jcM287ETYpp6zQUdsyZCYJd65lxzAvfVdPMrlWz9Q==
X-Gm-Message-State: AOJu0Yy/OzxyaKNd0xgTKeDnfI6RFs+mwGzIEsAEYe6I4jzqV65UXSN2
	vTiTcxLTn38dUrxAZMoqbWTEcr+5FDNrmlHdJ7hLrGs5pmZgDuKG
X-Google-Smtp-Source: AGHT+IHXfYbGN3gzx5xZ7yyca+anhNkEk7uILr9vttqcEULcdYoakS4nVxw2xsawcVcgF5/um0lldA==
X-Received: by 2002:a05:6402:1911:b0:5a1:c7d1:ec5f with SMTP id 4fb4d7f45d1cf-5bd44c7c5f5mr431154a12.35.1723476649472;
        Mon, 12 Aug 2024 08:30:49 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd196a666fsm2192535a12.46.2024.08.12.08.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:30:49 -0700 (PDT)
From: vtpieter@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David S Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marex@denx.de>
Cc: Woojung Huh <Woojung.Huh@microchip.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next v5 6/6] net: dsa: microchip: fix tag_ksz egress mask for KSZ8795 family
Date: Mon, 12 Aug 2024 17:29:57 +0200
Message-ID: <20240812153015.653044-7-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812153015.653044-1-vtpieter@gmail.com>
References: <20240812153015.653044-1-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Fix the tag_ksz egress mask for DSA_TAG_PROTO_KSZ8795, the port is
encoded in the two and not three LSB. This fix is for completeness,
for example the bug doesn't manifest itself on the KSZ8794 because bit
2 seems to be always zero.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 net/dsa/tag_ksz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index ee7b272ab715..15d9f8d28ffc 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -141,7 +141,7 @@ static struct sk_buff *ksz8795_rcv(struct sk_buff *skb, struct net_device *dev)
 {
 	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
 
-	return ksz_common_rcv(skb, dev, tag[0] & 7, KSZ_EGRESS_TAG_LEN);
+	return ksz_common_rcv(skb, dev, tag[0] & GENMASK(1, 0), KSZ_EGRESS_TAG_LEN);
 }
 
 static const struct dsa_device_ops ksz8795_netdev_ops = {
-- 
2.43.0


