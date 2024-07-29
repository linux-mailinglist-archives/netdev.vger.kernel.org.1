Return-Path: <netdev+bounces-113767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7408893FD5E
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 20:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A422817DA
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 18:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D4C187850;
	Mon, 29 Jul 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0KijAof"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B498187845;
	Mon, 29 Jul 2024 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722277876; cv=none; b=KnOJhODsIfTdzO+y7yzelXennhZAQrWZNdAakSyRaJf08EvF2EIIAmXvuzL0MyB9UZDnG5wcqDhc1xqBjHhG6iCy8c7BwFG4dSORL8OboOb9zROJ4WYgGNsrHqjlbUWKaKS+73ya7Mzhdafac6g9IDzRWEScwEMh8lYAjsLTPX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722277876; c=relaxed/simple;
	bh=4v1JcM+xNdFDbTS+smgec2vJCq8myoE780AU0iX465Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8KiD34CvzIhhPaiDelibrtdMHOHl622xUHdec1gQKdKLazETd6s7X3EipXaherMQBj5p9nBCSXVi23ZqmYspcnJDUkeEVm3DWPzxG6tgefz17mshS5dvG2ZCcF7tpTnNn8rzYmVT5QrzXBbZ43Yuhz6f0Yy+8OYIRBLBTemQB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0KijAof; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4281abc64dfso12714555e9.3;
        Mon, 29 Jul 2024 11:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722277873; x=1722882673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIqKxSZyWTf/Z3V2HppYDKSRNXowgVnrZ6ay0XmhCCI=;
        b=d0KijAofECoy8PkFV3WL9sT8HXRMLxL2OlrqYsNd8HeMrXTy4D7T41xmQdm7z2w+O4
         kswQRLUlR+PwpnbDsYzWWyzl5SNMPMv+5ctQPssaXRpIjYZtAGHxpAYFrDYIJOvGXT1T
         NU+Hrg9eeA1+zEsNB7akPNXzr3coQgqRfloAd4vm8xpmxZogcFtvv0QybcIYxKeFzpfA
         Ll7ITwQey51N2jwk3Eb2iLTne0KKStaILUc4SgiR2vWOfRBjhvfduTmWgLqa4lNjHuak
         6982voVRmTJpD5MevP3PnQbfVyeZqdEdd37QYzrm/0OfFwvF2/4U+MrKSCz9SM2e0/nK
         BEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722277873; x=1722882673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIqKxSZyWTf/Z3V2HppYDKSRNXowgVnrZ6ay0XmhCCI=;
        b=uYvFfMBzj5uKO6N4kOkaMWpUVMXVrcBC8eXg5i+OsCF7GXB5dOFJPK3iMwpbNPqGhG
         xoD1oS9ujRKVOYmnrUlVvBHQRb/H335GlgjWUJejSbImjn3iGkGfV9hNO/XPNz5+jrNr
         p2Y+fySM8tH1dQL/g7UA7u/ayNwquEQ0Jtg8kpTH0I7usirA20NKHebAZVb6Wn/nluU5
         +0uHQ6/SrN6q4peOV/pWzIK6/gJVerBiWEw6IE616wFYzEqJimq7Q+2gz9zNjlLpBf6d
         VBJgASg4m7bvmQztZiID8iS3g7s0jIHrM2gNPJ0JtY3wybgnDBsNt0poJrGs93UxoqK8
         5GlA==
X-Forwarded-Encrypted: i=1; AJvYcCUouNuN8T1+eEH0ddcchIMWfpzT1K30Niz0l5Jmhk+3G9PiqbEV7L9BAaGf38AdrSFIouIU5YEj9bHXMH+XxBWguLI4WIMsn3ngu9TUiLlP1R5PtaeHjX9Vd7OqhPK6scdgqcrJ
X-Gm-Message-State: AOJu0Yx6NOUJAywGjNLJtaNpYl5Kh89rdw3c0cGygdaA9JiJMm3rlgON
	vdRTpSbeunzT2tXnmf8OjjV1XdJpE0uhqO2MGp8PlMCgyB8+wz8s
X-Google-Smtp-Source: AGHT+IHUcB8/KDGDXgq3kOKIaEI3RytM/LjgWsO98GOv2rYjFJYGwyqRRrzVWn4eD9YGmY7tMl40pw==
X-Received: by 2002:a05:6000:1542:b0:368:4e4f:cec5 with SMTP id ffacd0b85a97d-36b5cf25338mr7500104f8f.35.1722277873000;
        Mon, 29 Jul 2024 11:31:13 -0700 (PDT)
Received: from yifee.lan ([176.230.105.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0aa1sm12800165f8f.21.2024.07.29.11.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 11:31:12 -0700 (PDT)
From: Elad Yifee <eladwf@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Elad Yifee <eladwf@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH net-next v2 2/2] net: ethernet: mtk_eth_soc: use PP exclusively for XDP programs
Date: Mon, 29 Jul 2024 21:29:55 +0300
Message-ID: <20240729183038.1959-3-eladwf@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729183038.1959-1-eladwf@gmail.com>
References: <20240729183038.1959-1-eladwf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PP allocations and XDP code path traversal are unnecessary
when no XDP program is loaded.
Prevent that by simply not creating the pool.
This change boosts driver performance for this use case,
allowing the CPU to handle about 13% more packets/sec.

Signed-off-by: Elad Yifee <eladwf@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 4d0052dbe3f4..2d1a48287c73 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2644,7 +2644,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 	if (!ring->data)
 		return -ENOMEM;
 
-	if (mtk_page_pool_enabled(eth)) {
+	if (mtk_page_pool_enabled(eth) && rcu_access_pointer(eth->prog)) {
 		struct page_pool *pp;
 
 		pp = mtk_create_page_pool(eth, &ring->xdp_q, ring_no,
-- 
2.45.2


