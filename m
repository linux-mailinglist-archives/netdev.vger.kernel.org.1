Return-Path: <netdev+bounces-223215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E55DB5858B
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 21:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517511AA7505
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 19:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5AE29A323;
	Mon, 15 Sep 2025 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frWnZCxq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEA4298CA4
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965958; cv=none; b=P03zb1kGZlFx1z1Mrz6uKo0e8iyXOhDim3H23B61/LKUDY3xPODpw6hWx00v9YUH8xudEwEYRL1LTiMxfiiJWs9z64rXalqxvmzIR140S827IGQs2CH1rC6B1T9mzgl15YsEthm8twdyvnXuQvFYo96PxkPS/hXGTz6GAA70dA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965958; c=relaxed/simple;
	bh=rNdqYG04T8gFLQycibM7AbJbQyaoz+PiHssI+IbjctY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PeVRdqFuUml8FgKRHdGY2I2jdMn2PaGJdiI8tXaiRC4vSl+wboISDq0mPH9qAiwVFomQ6NSUsDA3Q4iQ/ovZ1AM+9Z8r3e6ha9Q7im5rc28MSRteTp7lSdHdX/JT8hqma/e3/uF1Yq2Ucs5FQNJeh3akRu1uPGL/42dLdvC5Ras=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frWnZCxq; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4355071b3a.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 12:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757965955; x=1758570755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hx/rCZsZx96u1s7oaybPrZ+MD9EqUx74622sy17JRpM=;
        b=frWnZCxqFfRFCSUbpHDoI6cMLkcO1jpxqZ7znTeX1SmxEv+WihL4Tadm0wtz+Y4S/Q
         /1QTdNoABV3PWPhOeuesiNauF6cY768SqPsL6oCnhWLtdgeAAdSD4GGioy3fOSgpsCNa
         uS/B214cwJQqEEUrGiaR31EU12c9GSu/L7XT8kXapV83cXPyTZhmj1ZapJmwc19x4N34
         Ro1YF/Ve9SSkvzaPId6zLUk4BVdzJRlq4ZvtpH6Xas7i4CaEoxP39UR1c5B+yGXIfx+E
         sEY4qKPWa2fCEG1ZnZWgeYWl0fsbNTRqbN6wf0dWuKVYGsWgkniwizDNDbaSfB5N6CNM
         mjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965955; x=1758570755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hx/rCZsZx96u1s7oaybPrZ+MD9EqUx74622sy17JRpM=;
        b=OLGfqwtj/XLL/z4mbk57TyX60SMnvndq4XGZS7Wt7bNHMD5ofMi83RmPvK1/8cVEr/
         Ql7dSomnTwApgPcMsYjAfYgRxc//DCU7CYmSEd3j61jZPtrctQfHgeEGcpmoO0MKRUdu
         1rs9TrrrJY8Ftu4L2g7pxCpBn+fv0FddbUwrdVavrjzq74Zg64HfxIyqDqP/P0LDQVF3
         BZwDrv753cNrRdm4QdlV/RCgk1IEwdLoDPmxZaY4qErm6r4R5wBIGXJwY4nnnhApz23Y
         +IqaKWa6CxvCYZXtq9RgkHT2UPZk0P8dMTLF+6MxhTul6Cq+AkhDM5zIZK589bjw3HqX
         ahKA==
X-Gm-Message-State: AOJu0Yw7wPRt71ArnjFOYTozjBrwAuzdow8lg2DjDhPc+4N6XhzFtEfC
	5I37ilBZZWCTfRHEGF9MOFxQoai65DxhfdoxdFmtmVfO2GsmJe8oqOkp
X-Gm-Gg: ASbGncvPEv994jgKOJesMZ1/ETizOansYhh/wfVVYI23h+s14NSGl6yVj+/hPun3IUC
	uZllh26beJUAXe8965dVNQt+JTcwmGGSEWge2VSefCAcQ8lhUd+Tb+LppIVmr5Gm7Gk0CakvNjo
	lEfhZh3Ekeib02W/5sxV+EWGQFFulsW6yPYrYgUrYkaj3ZWEOKlo4WrL+lPIz6E+oXvcCe5/wI5
	ma7ag2DAfgEYzoS5969d2gar4gBkeKYAJnSyQXbf2GZrNVDxJwAGnHfuzd+Ew04me0Vt6uVnwOy
	Pq99jsgfB1oo5xprbt2OArOdAykdh1CHqQS4uz+G3Itzda4QTIz61TyGBbqLE3q8dH4KB3347yW
	ZYpmoF9bY4krVcUm9EWsVACjsWvV4l4oR
X-Google-Smtp-Source: AGHT+IHjaw0ImYDF1+rZB0HCnboBsF9bM5bw2fct4iUtxTgaQ9grp6y3f9UVL787zENDOO/R2AG2LQ==
X-Received: by 2002:a05:6a20:7f98:b0:247:55a7:695a with SMTP id adf61e73a8af0-26029d93a09mr17582980637.15.1757965954673;
        Mon, 15 Sep 2025 12:52:34 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54b7192d6fsm7884808a12.36.2025.09.15.12.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 12:52:34 -0700 (PDT)
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
Subject: 
Date: Mon, 15 Sep 2025 15:52:31 -0400
Message-ID: <20250915195231.403865-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: [PATCH net-next v2] net: renesas: rswitch: simplify rswitch_stop()

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


