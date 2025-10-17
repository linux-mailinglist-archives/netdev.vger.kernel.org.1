Return-Path: <netdev+bounces-230524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE418BEA275
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 17:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223807C3440
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 15:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F702F12AF;
	Fri, 17 Oct 2025 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LagN8xJN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E27219A7A
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714378; cv=none; b=FjKtE/GCz5qIfu3TFhk/j8R8dLMUfThlyTlLczR9XzJZu/zMGuJlTn74Noimeee1JvC8TgYjsaAyRZom0CmjIzRaq68Tk9hy9Xxo8dnBm2IkLEv9TkFQWZs+TTUQRnsLMBAS1ST7o5u76LnPWgOs4WEy9e76tKl7VXZRI3w3AqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714378; c=relaxed/simple;
	bh=30hY9VGZfgPtebi29fjNHxTGYZKsq/orJOz7VuvML8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNqnOL26VM5KCB29MWeBOeqW5zDGk4215Z0S2TTmzUQQFbNbnE+OX22sloejVB1fmhcyRKyt4rtFkvBRDhvrXC5q6F+kRkZGdakNURyR/MEzFhF9hyqsGLVpIYVPLrwtvFRx1tDNpkXnI9VBwDYJj2J3FDLRQaZELhMddUA3o/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LagN8xJN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-273a0aeed57so40957775ad.1
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 08:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760714376; x=1761319176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7I2zMxiqw9nCosgHfAG52KOx4TPHBq8RCQsUTlA/+E=;
        b=LagN8xJN898QlM/NaatEe3nqw8GLr2aFGZf0fyZx4rGbkvUSemCzrNSl1rl4eMUT76
         IAoYJTV+SpVh/ZEcVAu2dcp90yppUM+XnsfF97ef1zE2Kz7ykzuMTXaeMM1VFAMriu6Q
         EfcvlPwXXzzXuZyEHL5kgUYHcRK72X/T7MLaGFOoiQWRHzg4num4E3bOBn4BL89uNvai
         MsyjU32JZ9Mot8CX7LnJgKL6eK5RQJeIgqizWY/Lr6s4qg/Fa6TQEDuKUvKgYjeRVjxK
         rgmh7mkPeKcQ4EVxhXEv7gpOWvIkkAet+hlvVD6GVfL8MdtL9zpxdP/khBUcr8oXGXNM
         ZTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760714376; x=1761319176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7I2zMxiqw9nCosgHfAG52KOx4TPHBq8RCQsUTlA/+E=;
        b=NZBE3kJtxBvcN3uWmOUwJLD9Qc0Q3l2wNb2yMRGRcqK2jNPevWCJZgTp7hocxBEcGp
         niK3LwdK0NYHAD39oLtn3RO14TKsuVl4eJInYoy2fsjCtXdq0i1JJsNb/KOkk3W6/eUN
         ZejYw4dJZCUJ8DcwO3kmomKJ5gBnBfwKAWi9it1tXQTNjyESnMaVLvpEI4AIzyKzRknU
         CNl1XS/IFKKubQfn3NmWnH4vEQsZyKq31lttW/eIyQzA0Dc0+o4P+9cELPKC+Vf6vZng
         3H1XOTy5bLzGfF6/TZ08cF41CMnN7zrAjUIdWcV8pLqAQXedp05Kb1lKGFpbA8Ch62KR
         i4Vg==
X-Gm-Message-State: AOJu0YwKjN7V0JZGzKWekN+unR88Ya1OkeWMH+9osnggloi+VIXjReOZ
	5AKPPI6LuuKzmDLVL/fMhxp1X6s5RhN61HaZHeYGI5yaagdRQ9aUrS+9
X-Gm-Gg: ASbGnctdUTiqADLKQtxB6XkZFMLHUWnWKW1lvpshUA24q2h51xckHFqtr14ygMiuB5k
	KwQGdajtiOLVYkUF4yI5Pt//jzFF+vp3F435IgbmGBLNQ1anICRlHkJtX6wIA2rxYfhoeIyGo/c
	u8cL8S6us7KuN2HkAAmkxwqkx+Ju7WSoDmD7Qhqt5X052i13qK/B+3Oh7ywmMN5BeB4+iLa4XYr
	RtrTRzjUCguMmw71q1Y3sr6+xCgsfWYses7b47p+3EDz7YfxaH3DW7qhexf3ak1LUV2c7FWh/oH
	aEUz6RNzPH/E5N5ozyhbdpY1lq7u9MJUhG7gtktnrq6vkLmMF1+RqcyLIwpX3/JQo+ItObRP/3R
	l46tpaGWiqbs/ZDf9xK8Kp83LRReYvRa9gqNrHyB9qtxvvv32a+IYvW/TEXf292VMK1L4E2ELzH
	HSLHms9b2hkXwTLdI/3fHOYBH0kB+EduUp
X-Google-Smtp-Source: AGHT+IH0+48acCb/GQWZoQcUE6viuTtTcLkvy8Fj+MMDiu+Sba/GIsfY/hul5gd1I7tvE0KgRk6MoA==
X-Received: by 2002:a17:903:24f:b0:279:373b:407f with SMTP id d9443c01a7336-290918cbe15mr103570215ad.5.1760714376203;
        Fri, 17 Oct 2025 08:19:36 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:c7d3:fdc9:5e8f:28db:7f80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a756sm67193955ad.14.2025.10.17.08.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:19:35 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] net: ravb: Enforce descriptor type ordering
Date: Fri, 17 Oct 2025 16:18:29 +0100
Message-ID: <20251017151830.171062-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017151830.171062-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251017151830.171062-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Ensure the TX descriptor type fields are published in a safe order so the
DMA engine never begins processing a descriptor chain before all descriptor
fields are fully initialised.

For multi-descriptor transmits the driver writes DT_FEND into the last
descriptor and DT_FSTART into the first. The DMA engine begins processing
when it observes DT_FSTART. Move the dma_wmb() barrier so it executes
immediately after DT_FEND and immediately before writing DT_FSTART
(and before DT_FSINGLE in the single-descriptor case). This guarantees
that all prior CPU writes to the descriptor memory are visible to the
device before DT_FSTART is seen.

This avoids a situation where compiler/CPU reordering could publish
DT_FSTART ahead of DT_FEND or other descriptor fields, allowing the DMA to
start on a partially initialised chain and causing corrupted transmissions
or TX timeouts. Such a failure was observed on RZ/G2L with an RT kernel as
transmit queue timeouts and device resets.

Fixes: 2f45d1902acf ("ravb: minimize TX data copying")
Cc: stable@vger.kernel.org
Co-developed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- Reflowed the code and updated the comment to clarify the ordering
  requirements.
- Updated commit message.
- Split up adding memory barrier change before ringing doorbell
  into a separate patch.
---
 drivers/net/ethernet/renesas/ravb_main.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index a200e205825a..0e40001f64b4 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2211,13 +2211,25 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 		skb_tx_timestamp(skb);
 	}
-	/* Descriptor type must be set after all the above writes */
-	dma_wmb();
+
 	if (num_tx_desc > 1) {
 		desc->die_dt = DT_FEND;
 		desc--;
+		/* When using multi-descriptors, DT_FEND needs to get written
+		 * before DT_FSTART, but the compiler may reorder the memory
+		 * writes in an attempt to optimize the code.
+		 * Use a dma_wmb() barrier to make sure DT_FEND and DT_FSTART
+		 * are written exactly in the order shown in the code.
+		 * This is particularly important for cases where the DMA engine
+		 * is already running when we are running this code. If the DMA
+		 * sees DT_FSTART without the corresponding DT_FEND it will enter
+		 * an error condition.
+		 */
+		dma_wmb();
 		desc->die_dt = DT_FSTART;
 	} else {
+		/* Descriptor type must be set after all the above writes */
+		dma_wmb();
 		desc->die_dt = DT_FSINGLE;
 	}
 	ravb_modify(ndev, TCCR, TCCR_TSRQ0 << q, TCCR_TSRQ0 << q);
-- 
2.43.0


