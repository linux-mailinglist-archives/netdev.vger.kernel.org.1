Return-Path: <netdev+bounces-130594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227E998AE37
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACF76B24B01
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFB31A2554;
	Mon, 30 Sep 2024 20:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJaYdCD6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D65119F42E;
	Mon, 30 Sep 2024 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727879; cv=none; b=av47wLbAmPMl+eifRJOfBAzqhNTmux/LCAOIwnJDXW+WbKCCA6LVzna9+Vdp3EkoNBgD3mWipKXKz+Wgq4lEcQ1bYeElpODBakMXXo35eyLXWNU/GYC7TOqpiz1nRMtF++OvV8w5XWhiehCWZJGDilD/IAWFXn4GN04s+OISp4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727879; c=relaxed/simple;
	bh=QlbONOqz1K0XWEos9xTIVvmpV0mzdmbc6M33HeTBch0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icw/+QRnfGEJV+Mm/+uoiSytXflvFtXKHlSzG4g6qDTRoCtRwNBwmNchIHV/BttgkAVJPWgTKIw0tLXxnzX+24NEc8E+XvnPo0iWRKDI6Oc9shTQ4kC/arhFersaVY7z7a3PKsz4JYucOugFfIrws/UkiKbl3WT4B9ZS1nRlThA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJaYdCD6; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-717934728adso3650980b3a.2;
        Mon, 30 Sep 2024 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727727878; x=1728332678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzx552Qp8I6tvYVdnDmUIDQNHhaHMQHL12jQp5qE218=;
        b=MJaYdCD6gHIIt57wOVT2I1ncOlIW9rwO3yqmkBeh0zwsadDLfHS3ZDCtJL8uy0QFx+
         6LRkLzhFM6A864pSmQEBPhCoME9H7Xm1iqhr6J+zClsqoJKzLJXQ3fG8cAISZk4uWYA2
         Vmrd14+3WMw+GkOPzA3HPShtfSmmE6iUPLzDVitqS7NFhBNIj/fcrj2a42B/tXnOVii/
         EJNgLjYsPb1SESXWxXMpZoe1hPMezcXjd4UxbQzQI87+Fh2hFE9+maJbT8aLTOViIDuV
         RU8IGNjSz/Il5ifP7p7PU2Y5aRf4Mibik4l08OId7jvdYfyRXBP43MqGiKR9hmxN5P2R
         mTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727727878; x=1728332678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzx552Qp8I6tvYVdnDmUIDQNHhaHMQHL12jQp5qE218=;
        b=BQ8L3s524E2wleexJtdysntZs8bl3d0pYwXBqBsCsjeknjoou4upTLP22Uzwxmg36H
         GGUWb9F1VEd4wK18cBSKPrbpvz3aFgMDA0WMj6LfrCIyuHjJ2uChwYyITcjQN6fB1BZD
         LG1hMCvb2BZRttvttx/ooY0Fidc5AfhfGkisBA1r0Lqg+UBXWwW1kOUVrL0oIcavlSmM
         ySqqe5Yk/uW1o7dTOv1eJPc0/CZAW89c0MbKpcgRgtqvWXTxeXnEuG65CW6pvHb0+XEB
         9Na7OT+Nfn6SiSDVxo0geovCe/zotQUhftAy+QbY5gsdDOMct+y46rF/v52ULCJro1SK
         CPMw==
X-Forwarded-Encrypted: i=1; AJvYcCUFE5bNpRtSnpe5RuCHo3kecMLGRL/6s3GmZGG2YC5cUYFN6dVf2xS/hP54u42pm1vpJr+XMv234r3u+0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC7SPzBg67DHbIvZdmCKiq92HC23UrnfN0ujRnhGVlL05Kd3Fd
	lIkNMYG2CJ3cfkn+AiExAeeoMFt3WRhcnWsgtwloIwvsP7y5PA+rDw9vM2Ka
X-Google-Smtp-Source: AGHT+IF/gNOFFvcOrGW0xURPuzG12o30PppK4sbSjTPXG8TQN1pU2wAFd1y/odMUYCwBkgYr8SvFqw==
X-Received: by 2002:a05:6a00:228e:b0:70d:2708:d7ec with SMTP id d2e1a72fcca58-71b25f2aab9mr17767492b3a.5.1727727877573;
        Mon, 30 Sep 2024 13:24:37 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b265160a5sm6670623b3a.103.2024.09.30.13.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:24:37 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	olek2@wp.pl,
	shannon.nelson@amd.com
Subject: [PATCH net-next 1/9] net: lantiq_etop: use netif_receive_skb_list
Date: Mon, 30 Sep 2024 13:24:26 -0700
Message-ID: <20240930202434.296960-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930202434.296960-1-rosenp@gmail.com>
References: <20240930202434.296960-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improves cache efficiency by batching rx skb processing. Small
performance improvement on RX.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/lantiq_etop.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 3c289bfe0a09..94b37c12f3f7 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -122,8 +122,7 @@ ltq_etop_alloc_skb(struct ltq_etop_chan *ch)
 	return 0;
 }
 
-static void
-ltq_etop_hw_receive(struct ltq_etop_chan *ch)
+static void ltq_etop_hw_receive(struct ltq_etop_chan *ch, struct list_head *lh)
 {
 	struct ltq_etop_priv *priv = netdev_priv(ch->netdev);
 	struct ltq_dma_desc *desc = &ch->dma.desc_base[ch->dma.desc];
@@ -143,7 +142,7 @@ ltq_etop_hw_receive(struct ltq_etop_chan *ch)
 
 	skb_put(skb, len);
 	skb->protocol = eth_type_trans(skb, ch->netdev);
-	netif_receive_skb(skb);
+	list_add_tail(&skb->list, lh);
 }
 
 static int
@@ -151,6 +150,7 @@ ltq_etop_poll_rx(struct napi_struct *napi, int budget)
 {
 	struct ltq_etop_chan *ch = container_of(napi,
 				struct ltq_etop_chan, napi);
+	LIST_HEAD(rx_list);
 	int work_done = 0;
 
 	while (work_done < budget) {
@@ -158,9 +158,12 @@ ltq_etop_poll_rx(struct napi_struct *napi, int budget)
 
 		if ((desc->ctl & (LTQ_DMA_OWN | LTQ_DMA_C)) != LTQ_DMA_C)
 			break;
-		ltq_etop_hw_receive(ch);
+		ltq_etop_hw_receive(ch, &rx_list);
 		work_done++;
 	}
+
+	netif_receive_skb_list(&rx_list);
+
 	if (work_done < budget) {
 		napi_complete_done(&ch->napi, work_done);
 		ltq_dma_ack_irq(&ch->dma);
-- 
2.46.2


