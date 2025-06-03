Return-Path: <netdev+bounces-194839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77058ACCE68
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 22:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7353A5B51
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 20:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B14825332E;
	Tue,  3 Jun 2025 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJlkVr0h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B200022F766;
	Tue,  3 Jun 2025 20:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983753; cv=none; b=WKU+zNFAHgic3b3g2VrnQNnFjztxbvzMuzQnCiIcLO8rBalV2lGvC6HVSAuqzeYRQkjW0j6R5kphR4ze4BHS7/YkqK7VUVQcHQpFBpxsrwCcywiGlUVowBRq9bq/7O2ByEWPpBj6QZTmreG5e3Z4/PxD4kJ2zWaPaO4tpNrXA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983753; c=relaxed/simple;
	bh=n/bgIhFTed0kA+8ogu3e9r6YUkUg1esbTZK6SEVpDu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0ELej3+PQDOcLWPxSjYUab65OI8tfLOPzVj+l4UB5U2zKK+sD3Qa9YphUz51FhHdo0xkj1rn+8ciurafBdEtfMCJc2rEgPA6pHAWc61Aua6ELoHdXaxlKZ/D6KkcP6Dyvw6waWZn2MuRO0epymMbFj1I3UuIHVx1RUyFGG/h8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJlkVr0h; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450dd065828so31487875e9.2;
        Tue, 03 Jun 2025 13:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748983750; x=1749588550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEargT3P78owSoRseiMu/y0IGCgyp/+OmHkvu02Af0Y=;
        b=FJlkVr0hmwkA135JXuS2cqC16fM133poDYnZ2CkSjKn9d6cuexy8cdudP5W+4h7TBI
         uuelRY2qkZDac6GvLuAR2JGh8EE8ximRrEbbDs33XzHZYjiu87PvJnPKKLs3/hZM0G7j
         EQRoKOOHTPL8XzoSGo7SHtv4So3k0ahNVX0HBEGLA9EskGPf+2Vu5FlsA8OxLY2AWS3r
         +H2lTamZbzRHs3JA7wp/JnDZgKboNqkyN9+iJvR4ZK7AhmaBM+i+5Q+KNtepHWR0Mjtr
         +5Krf5+SfJ1HHr1BWYoVWXXKL29K/+0FEvRlwbMhYMwfTyPkZ/fEnv0zQoc/6r3CiE3U
         x0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748983750; x=1749588550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEargT3P78owSoRseiMu/y0IGCgyp/+OmHkvu02Af0Y=;
        b=WtxUdq+6WWHXF/xlYAlXRqxcLxBkvGvpJzySe3iuYsJuUVyspgRzUF5XftKDGKvaCF
         5e3s9QE88u7QQ9poCoVlnhizmlctzNBpwPgmyh2vpnCbtfQgAGEbARuaMhAZ+5K02gEx
         nvQn58yMMKIQG7tuGh/N9HdD1WKvtyk4FSNwoCXYm4BPp1HenrQTC4oY/+6IzYDsSFHn
         OdDlgEGc86fyzUyKYHE1VUT2w1Y2xP39egPSKCNh18F3fWyAAQ9LWkcK7E2490hzgE9G
         RAbnape1RxjTm9WWFdU//CRgQrcVbuy63s87xvljmYQUAK7l9yDvtAjnZ7xsOyDZdp+F
         VIZg==
X-Forwarded-Encrypted: i=1; AJvYcCUhx4nCpouK1ZleEfRtt479a1SvlWFpt477krU7XCqJ1j+zci0JdYbtkUU5Cg/Xak1qUDjbX61PTudMEYw=@vger.kernel.org, AJvYcCXspNeise+3aGIodo+MgsnJdZD1w10kbBe970oluMnZfyF4hs8mjnJvw19YW55QJXPSvvIElfZq@vger.kernel.org
X-Gm-Message-State: AOJu0YxZx6gWgePpEJ4CIODCmOqCS6Ug9h8rTRYPr1gJfUdnWeSOL+fD
	H6z/rmq/9X5FQDZdUPRsN7pVdYJx1dHO1l0FAvzslANLUyLztsQYZtwo
X-Gm-Gg: ASbGnctnCfnYD/K3AsI43vZgElU/pB6RFGKNRBoVg9c5NQiSTQ4ebRlNgtPNaAuU8C6
	8zU5/er2nHbS5XzzCRkRv0Ze3cq1jNxKtV6rIrso8YdLRd6EnWR2boKrqq+J7mQ3rLb8DESxaOl
	tJcnekXB5ECLX0JM6KxdWvF7xODN82/zrmiBgP5ab6QPVm1L+MVkHJR4ZGtom6jez4yOpMPUTxT
	WEzb/dHWQ1TPGTymiQJ0DCReaHUYfB2k/zkCeZPmAiC1iTmgR+AEoYwBX6K4dk7xXPsgtEtCtD4
	R1oRSwardQ8h+67G2qUeU4bUEF7LUrGCkQkGTKZx08WTlVk9bxjs96OpBayLOh8MW8yOdKys/wr
	IAQ0xq0JyVE2c9Pl7PASx1o0CBmRB656jUcoqVYPvDTnDZYjVGqu3
X-Google-Smtp-Source: AGHT+IFlG1kg/mtA/8RQANgL4qp3Z9sOTadgypTRyTbHD2RGlEWfxQgcccB7HKYUvkFzf5NuOPSjJg==
X-Received: by 2002:a05:600c:3e0a:b0:43d:fa5d:9314 with SMTP id 5b1f17b1804b1-451f0b3f30amr1082295e9.32.1748983749840;
        Tue, 03 Jun 2025 13:49:09 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1500-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1500::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451e58c348asm26258225e9.3.2025.06.03.13.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 13:49:09 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [RFC PATCH net-next v2 05/10] net: dsa: b53: prevent DIS_LEARNING access on BCM5325
Date: Tue,  3 Jun 2025 22:48:53 +0200
Message-Id: <20250603204858.72402-6-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250603204858.72402-1-noltari@gmail.com>
References: <20250603204858.72402-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BCM5325 doesn't implement DIS_LEARNING register so we should avoid reading
or writing it.

Fixes: f9b3827ee66c ("net: dsa: b53: Support setting learning on port")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

 v2: add changes proposed by Vladimir:
  - Disallow BR_LEARNING on b53_br_flags_pre() for BCM5325.

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index f1e82a0e84ea9..143c213a1992c 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -592,6 +592,9 @@ static void b53_port_set_learning(struct b53_device *dev, int port,
 {
 	u16 reg;
 
+	if (is5325(dev))
+		return;
+
 	b53_read16(dev, B53_CTRL_PAGE, B53_DIS_LEARNING, &reg);
 	if (learning)
 		reg &= ~BIT(port);
@@ -2264,7 +2267,13 @@ int b53_br_flags_pre(struct dsa_switch *ds, int port,
 		     struct switchdev_brport_flags flags,
 		     struct netlink_ext_ack *extack)
 {
-	if (flags.mask & ~(BR_FLOOD | BR_MCAST_FLOOD | BR_LEARNING))
+	struct b53_device *dev = ds->priv;
+	unsigned long mask = (BR_FLOOD | BR_MCAST_FLOOD);
+
+	if (!is5325(dev))
+		mask |= BR_LEARNING;
+
+	if (flags.mask & ~mask)
 		return -EINVAL;
 
 	return 0;
-- 
2.39.5


