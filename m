Return-Path: <netdev+bounces-108617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F299249C2
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 23:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241951C224AD
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 21:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDCC201260;
	Tue,  2 Jul 2024 21:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWKab6Rg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3053120125D
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 21:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719954528; cv=none; b=QdJ6160WN3WGaWvzL6WG6DJTNIVqwdSdNRXOO+oOesaUFbdKhJQaX9qLK44Zj0leFYWSrpPkJfvuHIXBQedWcJwbkVkCCwkbKtItkLIfqDfQ9ikXS32U9gnJTer3VgLPQoKLEtUWNxRu+wc36bKPu+E3+B0IOYV1qgot2b7qHnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719954528; c=relaxed/simple;
	bh=iQAoLd3zEtpYYbvVSah/d8jhIfMBMAETp2gljBGBXRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dXINhGM0SrOQHlwcWK6RK9kdtrZC15A0wDBLSdrGAOv/ucXfPTc93W+vfE8GSOWFWnv5ILM7xV2tseNSyjXu0k4MfOjyhjMFhGU3usHKxylNrhQ30MmUO8tAPplXpyWOKir+bGC78oSdRZ3U5B6auXbZzl6xA7JoFFeuNYL8xK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CWKab6Rg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719954526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=se85jQN04juZgRCOlUB8db7Xj7Z+u0P5SXHucncyZCM=;
	b=CWKab6RgZsPmpJpBX2bNELloLjvq5RganXR+oHCwF1umjLj0q/XK4CE74McF7POPUyQLAf
	sL35zeNPLCcBrX43n05WrELje7rKfRPjpExnKUrvSwVPnEgAGXGJhRepK5ATKZYY+BncnC
	6kaWq+z+hysxfJIsIeOCafYKRn0V0TQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-05UxgVulMDewBkClJivtEg-1; Tue, 02 Jul 2024 17:08:44 -0400
X-MC-Unique: 05UxgVulMDewBkClJivtEg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4464a6a2f23so59399491cf.3
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 14:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719954524; x=1720559324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=se85jQN04juZgRCOlUB8db7Xj7Z+u0P5SXHucncyZCM=;
        b=l5I4bVymdPnkZ/6FyP5MqcmFc7N/Spoymlb+du06he+AeAwVbQnBKogAULCV+JDhYq
         YWCkwOzpRR8kfxziMCiBKQZNKQhnZKLyOPwAScgiZzLmslLqfm2Jw6IaQu/idBkYnAOB
         wHclNVdpWYqvZXw4Buxl/czTsMIZ8uAem4r+88vjCYbtgbcCGgb81Z8VzyHdacl8prTY
         +8cXUNzqn9z1rd9OBIXa30H9D1kVqH5MIbt2GdtbXf6uZh4Jsj7xD0WvQ3xW9q/LlRr0
         g7M7pldALz2sKEFggJ5WLXuK5lF7kRlIl3nMHuuuvyB3XyeTAHgIHn46q2wAoM3tPGhQ
         zOiA==
X-Forwarded-Encrypted: i=1; AJvYcCVScy2WUtDWHgw3AZIXnIsGXM6guKyvbo+jInGgoJNpllJd7peVQIE/q6i4y5esbFjRtP5ddqhQCeAl+ePjWIPOK1a7ZtmV
X-Gm-Message-State: AOJu0Yy9F3vK/5aiDHZFuKTr5VHopBX77UBcjPPlnIm0wfFGK/1rjEoY
	jLShEeEL/6LfHeP1SRSbmFWdFqVy7xSyi0KJz3Ms2cNeef7UxoerpgXxkqHA9xn42oX6Nx4nO2m
	Oi83Js2SHnxxt2AX/inYCoWAvtyxTlMVoNtcQwLBz3pyxb9eDcEcb3g==
X-Received: by 2002:ac8:7c50:0:b0:446:5ee0:d1e with SMTP id d75a77b69052e-44662e31cefmr112423911cf.39.1719954524172;
        Tue, 02 Jul 2024 14:08:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbWzDKoO3DLysrqALy+oE4lA7uiaZ1zyzV/oKjhpoDTKDIA4cjZJMXRmR71FRAQA9DolwanA==
X-Received: by 2002:ac8:7c50:0:b0:446:5ee0:d1e with SMTP id d75a77b69052e-44662e31cefmr112423701cf.39.1719954523863;
        Tue, 02 Jul 2024 14:08:43 -0700 (PDT)
Received: from thinkpad-p1.localdomain.com (pool-174-112-193-187.cpe.net.cable.rogers.com. [174.112.193.187])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-446514b0b1dsm44452501cf.79.2024.07.02.14.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:08:43 -0700 (PDT)
From: Radu Rendec <rrendec@redhat.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] net: rswitch: Avoid use-after-free in rswitch_poll()
Date: Tue,  2 Jul 2024 17:08:37 -0400
Message-ID: <20240702210838.2703228-1-rrendec@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use-after-free is actually in rswitch_tx_free(), which is inlined in
rswitch_poll(). Since `skb` and `gq->skbs[gq->dirty]` are in fact the
same pointer, the skb is first freed using dev_kfree_skb_any(), then the
value in skb->len is used to update the interface statistics.

Let's move around the instructions to use skb->len before the skb is
freed.

This bug is trivial to reproduce using KFENCE. It will trigger a splat
every few packets. A simple ARP request or ICMP echo request is enough.

Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index dcab638c57fe8..24c90d8f5a442 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -871,13 +871,13 @@ static void rswitch_tx_free(struct net_device *ndev)
 		dma_rmb();
 		skb = gq->skbs[gq->dirty];
 		if (skb) {
+			rdev->ndev->stats.tx_packets++;
+			rdev->ndev->stats.tx_bytes += skb->len;
 			dma_unmap_single(ndev->dev.parent,
 					 gq->unmap_addrs[gq->dirty],
 					 skb->len, DMA_TO_DEVICE);
 			dev_kfree_skb_any(gq->skbs[gq->dirty]);
 			gq->skbs[gq->dirty] = NULL;
-			rdev->ndev->stats.tx_packets++;
-			rdev->ndev->stats.tx_bytes += skb->len;
 		}
 		desc->desc.die_dt = DT_EEMPTY;
 	}
-- 
2.45.2


