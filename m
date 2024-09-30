Return-Path: <netdev+bounces-130541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1255A98ABEF
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4361C20D45
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7FB19B586;
	Mon, 30 Sep 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNuDdP2p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65B219ADB6;
	Mon, 30 Sep 2024 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720314; cv=none; b=JT2+cJwuy4DL4fEIxt/Dp+jvXmJK0aHhBkDwF5kV8gjJYrViMyR1lIEa4H9QJt1MPQgXwv5x6f82wdMDZqhaBjO3ow6uTkQOzRdSdEm2e771Jh2TUSxlvkJ25O5q3vxXceXliqJN9SxTHCMTy6Cnj2I6IOyR3ZIf2Hc6kIv6auk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720314; c=relaxed/simple;
	bh=5ozNaIGmskdHCWNw24hJsVQC/5dhOLjK/bmmgAkTjIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZGYHS7keiQAwjkTMp9Zy96q5feYteWNxLHGD0zk6CioswZkaRPxwrKOPUIXiT1k68QxjDo2Ywkjo6XPwXA1byJ7AnwDGDv7D+ewMBABOnbDelV4W4UsNNEuFCQ334+EmSFqQOMt28tBASWEnBCtHaoswd5+C0keDC+aNo6NI2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNuDdP2p; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20ba6b39a78so3870365ad.3;
        Mon, 30 Sep 2024 11:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727720312; x=1728325112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAMBZJ2HCcR6enXUwvhotyHNyYUBC52QPo0eDVNRKS8=;
        b=NNuDdP2pLLTH4ilV1+FKTXBWypJ4wo4DrwZ0vFjtd4Bk7N3uEanO/Ubrmy1pZzyFV6
         3EKkz42nAAupBAE8Di6U86J2+fqog7zSPlV9Mm7xo1ikI2OynJyKRs0eWZ8MogQwWFJ2
         b7UIhwjGyeSnu7JRreZnuAAUMROh6zhmYt+xO2mCPTk9eyX0tv4wYndfSvvaUfsuavlu
         BOqkYJccyRICd77RruSbuEHTnLRXsyYkgIoBiqTfABs+suc8fdRlaYETK2thUh75QHde
         rJGgxyOgZtc8D/N57svCnezen/qAzQhV6HFyf4UctnHsyQyd4gwVMaind6htbwJqHYuP
         e6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727720312; x=1728325112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAMBZJ2HCcR6enXUwvhotyHNyYUBC52QPo0eDVNRKS8=;
        b=eE5Dflp/TGvI/KqIkNJTnjPpK/PRRZoJpAuoa+TLeCsdXCqyaSVOtpiAGBUJpGQB1e
         LpuBipM8Ki+iqIPlyBkyjo72ibeYCCK0rk3R34iZ8u3Dzzi01ab9KZscyCI2lsHXQHvu
         INpFhLYhefx0KVNNqt1BCu8i92sNA2VgHfsIBpj7N4EtxXB0Hus3TvNfKHsb6n5Dfnai
         zmDn4vwSEvf/q0QK4oANwLrwXwIiXw0mjtA7SDtxBciCj+tGH6TiqpZ82pXzqkSU1vRg
         z1XX3xXxp6+GL0zFI/ntcrTGQeG1oO9kCxOoOhVesyW4F0Gy/o4PHe+ewLlw6YRfZW4o
         5sOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd/zwJ+GpaIOgPxZIr6SKoyJvgdUxVpFIpqm4Z0iJoe3WbbkMbtXeTKn1oZI56JQonyvANbz7jpdLXZrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMJ2tLyEvRgMn5/RN9ULq5emoMvOhYi1CYI167n0btLWHrufZp
	Hiw5ka9gOUPDHbELtXLarbXgIEtInZYR/huv3Dag34m0QkiFo8+cuXpWKRTY
X-Google-Smtp-Source: AGHT+IFguj+kjFghj/4/0r3q3ZY/SDKeExK2vlQYCJ3k/F0RSmS6N6xRsxbA8M5OP0HtD7xlD9wIUg==
X-Received: by 2002:a17:902:ec85:b0:20b:8a93:eeff with SMTP id d9443c01a7336-20b8a93f3e6mr46121365ad.37.1727720311911;
        Mon, 30 Sep 2024 11:18:31 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37db029csm57444365ad.106.2024.09.30.11.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:18:31 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCH net-next 4/5] net: ag71xx: replace INIT_LIST_HEAD
Date: Mon, 30 Sep 2024 11:18:22 -0700
Message-ID: <20240930181823.288892-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930181823.288892-1-rosenp@gmail.com>
References: <20240930181823.288892-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LIST_HEAD is a shorter macro. No real difference.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index ec360a3e9f0e..067a012a5799 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1598,8 +1598,8 @@ static int ag71xx_rx_packets(struct ag71xx *ag, int limit)
 	int ring_mask, ring_size, done = 0;
 	unsigned int pktlen_mask, offset;
 	struct ag71xx_ring *ring;
-	struct list_head rx_list;
 	struct sk_buff *skb;
+	LIST_HEAD(rx_list);
 
 	ring = &ag->rx_ring;
 	pktlen_mask = ag->dcfg->desc_pktlen_mask;
@@ -1610,8 +1610,6 @@ static int ag71xx_rx_packets(struct ag71xx *ag, int limit)
 	netif_dbg(ag, rx_status, ndev, "rx packets, limit=%d, curr=%u, dirty=%u\n",
 		  limit, ring->curr, ring->dirty);
 
-	INIT_LIST_HEAD(&rx_list);
-
 	while (done < limit) {
 		unsigned int i = ring->curr & ring_mask;
 		struct ag71xx_desc *desc = ag71xx_ring_desc(ring, i);
-- 
2.46.2


