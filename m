Return-Path: <netdev+bounces-223666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE9AB59DD1
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936241C01397
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8FF31E88A;
	Tue, 16 Sep 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lc4uTPT5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBD331E886
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040522; cv=none; b=CJ2J473ClL0kXC/v8R46x/gb4I33ffBdCfnS81lTqRzHR+klSDrDb+RI2qUwrAMp6YA/qsxdAehsspFBh0Jy3SjhKdzvEP0gyZCfOgJO0KT6PMFVKRngoIiTI3Ha6VbXU+NIcdY1UKaUnzUURil8Bc1i331C9OxxRMSGC9Kfswg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040522; c=relaxed/simple;
	bh=W9pIZSJJd90LkruG1/ysGwyisU1HWLXk6DyjzcXgGco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sSZrZSP5zhaAphIArBy6n2vihe4D16nclWIDe2SH+kYhlXp5eLzcbD7P/rFXpN8MMIMpnJcGugUZvGM8dJPuuRmahAX87TojB13LMJO0vQVV70JJfxHkuTJXQ/qcNDhWu2qX9E50+WZKKjQgt3i0KriNQ5hkNRb9F+6vqq25EuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lc4uTPT5; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d603b60cbso51343457b3.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758040519; x=1758645319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kuKVeqxC1e52+9KOcIW3A/OViu0706QA58Vh/Z8d+28=;
        b=lc4uTPT5iwLZIq6+Gfq0UVeORPzREqdfb1aSTO7FcygpGRNA8ncWVK7xfEII22VjLh
         G2yxwZge52CfSzodHF5RR53aTIo8/9zJK1Fo/dI8l6qh0yHlMUkjKjk0lSMJIFBVMn6K
         +UBnFZHhd8y5wZ4mNGTTYjYoiKXfj+Qlm5vW/V8CAJmWCRufyMcIsWIzVNaGG9jsAtYL
         v26JzRAQIN4nK2S98tSMXGPefHwOVWNnI3m5kelfJnSKIGpikBxdgnSwqYXgCjajOFhQ
         SkJLQcu7ld30R3q5sUYwfhDG7B/vd8D8Vj3SSCdeA1duVu6mzGhIw0F9nSXCKsHrQ0tD
         uu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758040519; x=1758645319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kuKVeqxC1e52+9KOcIW3A/OViu0706QA58Vh/Z8d+28=;
        b=ZtH5eXg4uilaassMJWkPv/1UNvEy0l7QmfCNqB48WVbhU1Ez5Pbq4X4ESnLl9V/ryK
         lx8ozbPMpXZvp+6w8+Ay5ouZd0RHMtGr+uqVjLcSHU4L81DgyWZOutwrd01uOsEARg5t
         iG9nQunyZdr9INGxQYuZCROzVHLaFQ69R5zcC3Is9jSHL9bTAtb7fg5+6D2RirsYPwAU
         TAVIehZETheDXimnkyMJFpgPdsESYbTpIecGo3BLa94VrtrjYWflpPdnRPxZaJs3PNg8
         GTOWg+j3ngZBFL+5T25o8dQyDPm/sj1M2b+vXtjKS4DZgn+DWtCtdMfjLHdGo4n4cziQ
         KjLg==
X-Gm-Message-State: AOJu0Yx2Ecn0er/dTJCIamgKnbhINVrAjlteNAzAn8XsYVJGuCsNhHxZ
	9Gq5ktoTNjq3TE188Hq1IhK8Jdfyc7JSDDl/5t+AcGPZ0Ei1THQx+hck
X-Gm-Gg: ASbGnctzSn9gCKPGMegnEVoWU3oOYHIHP8mfTxQWOgTrsgk6On/SGp0qPYXt6QiqG68
	AJmaOLULeOsWoReK7MEIGQfMFT0sAV9QW9Wrox+ahJgRfxVjX96ZIE8bGEDfRviGts+nF1JjIva
	iPtbd3Xsd+V3XDRj8OZ7+nLOtdMd8WIbn2E7lyjzvJO3nKoPVfxLWV/UfBXLEaZ4XSr5MlL80Da
	0JUGuSbHJem33f4nrmlYmwBqt/eV8S2ev0WkO6vKMZfZXMjXck1TRh0r1wz22BTHhydcSyKjn3b
	OwLhLlZnACPz2LZXX2EqEL6eBZ4W/oCfwqXXB6200nkxnfw9/s0c8zV6KHaxFN/RicCI5SiTyK9
	b1q5bmDVFHWEvCTWwULwY1gYiqjq/xQT3YdilBV+B+VOl7G0jtqYhSHSxdA==
X-Google-Smtp-Source: AGHT+IELK6d8jAkr7WzE3/g8PvsLx8V6BOoNS9QvY2+YNcoJ5bf+I2q1PR/+pmVM3steyyY7/7i/0A==
X-Received: by 2002:a05:690c:4912:b0:725:39d:a31a with SMTP id 00721157ae682-730652dd1dfmr178212297b3.27.1758040519218;
        Tue, 16 Sep 2025 09:35:19 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6247490a012sm4214557d50.0.2025.09.16.09.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 09:35:18 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND net-next v2] net: renesas: rswitch: simplify rswitch_stop()
Date: Tue, 16 Sep 2025 12:35:16 -0400
Message-ID: <20250916163516.486827-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rswitch_stop() opencodes for_each_set_bit().

CC: Simon Horman <horms@kernel.org>
Reviewed-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
v1: https://lore.kernel.org/all/20250913181345.204344-1-yury.norov@gmail.com/
v2: Rebase on top of net-next/main

 drivers/net/ethernet/renesas/rswitch_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
index ff5f966c98a9..69676db20fec 100644
--- a/drivers/net/ethernet/renesas/rswitch_main.c
+++ b/drivers/net/ethernet/renesas/rswitch_main.c
@@ -1656,9 +1656,7 @@ static int rswitch_stop(struct net_device *ndev)
 	if (bitmap_empty(rdev->priv->opened_ports, RSWITCH_NUM_PORTS))
 		iowrite32(GWCA_TS_IRQ_BIT, rdev->priv->addr + GWTSDID);
 
-	for (tag = find_first_bit(rdev->ts_skb_used, TS_TAGS_PER_PORT);
-	     tag < TS_TAGS_PER_PORT;
-	     tag = find_next_bit(rdev->ts_skb_used, TS_TAGS_PER_PORT, tag + 1)) {
+	for_each_set_bit(tag, rdev->ts_skb_used, TS_TAGS_PER_PORT) {
 		ts_skb = xchg(&rdev->ts_skb[tag], NULL);
 		clear_bit(tag, rdev->ts_skb_used);
 		if (ts_skb)
-- 
2.43.0


