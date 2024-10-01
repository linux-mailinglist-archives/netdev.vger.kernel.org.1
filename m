Return-Path: <netdev+bounces-130992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1639A98C58E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17DC1F22B88
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B651CCB2C;
	Tue,  1 Oct 2024 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TufMjhQp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB891CB30F;
	Tue,  1 Oct 2024 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808372; cv=none; b=sLXt1d8F8HCZ8+ug83GWBaWA3PBXS1wC783IyLZKM5+y/mJjUPE3KHwXC1fHhlMrkH93TBGCpvOPpfideUOOzjj8sxnky6x0AUFX85HjSOlsyxjhero2iOQbxhkrEGxa2RfvqQqQqfZVtKOSyFLbY2W385GEHKuvGL3Ns5PNrz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808372; c=relaxed/simple;
	bh=V+I48YD8Y10rzK6qdZiK+Aso9HG/1PeUAGmHS/rAJgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ek2ZvNy/RwS1tHGQSKWKrMSVrkyZOV8wPJMeoFrpQnYxeX/jYR1+YS185AeUnyBk8b2crL1iT3NGQkPgKxT+5AhlQM1jYqq6CevMMIun/OgYy+zunMEphj0xJlN3Y8YIR0ohgakKnMLhjcUNVXv5ybfKuUl5efX5oHDVYX81Orc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TufMjhQp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b8be13cb1so26386495ad.1;
        Tue, 01 Oct 2024 11:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727808370; x=1728413170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUpXhS7ZVxil6l2rJnVVFZy6bfZdF72/d9g+8sUCIdI=;
        b=TufMjhQpJUt00ivcvlQnvJI4HB1rbIkyYbIrvvI7EGZMq6sDwJeMVQemufbjIOqYqL
         0/y3LNYJyKIxNK7lrfziA4tvMdmHSRBHpyvYH5oXyGkGp3y1zTpLUaOxK3v5dcR2obxJ
         fcvQpHNZ8ZEEfvvfjHWBsXM/pmPL8ATYcnO0i+DbYdjO89Pc+GuSBXi4XdaY0MgLpz9+
         oHlTudlY9tbOc605xj1czrRTrz62Ey1iJ5Z8dpLSyizvC3T5nf7K8t0RsRUkrcfESQ6S
         7fyonaTD5Tu0al6kUQBsfj8RDM5O5WoqsqKeq/AcY/HWE//JIPahJhBtiDNOoPTwU8tC
         O3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727808370; x=1728413170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUpXhS7ZVxil6l2rJnVVFZy6bfZdF72/d9g+8sUCIdI=;
        b=v4a0xI7UdgzssJuFvqpZNUde0FTfYfAQODjESD9kSmVFjdUDXVzIxQWfC1XhMcPNlr
         HUXlKq/NO+iRQGwQefniepHRYy+cpPybMX7ty3Vps/wkBiSBOQjZQVgovabwfo/tq2E0
         KFJavhsVn2lgtBF058giPi632kah3HbxKVQNwjowqUk/+29sG1Oi/l4aJwYdh9lQMffI
         evT83s6kpcISE7m0ul9gTrVgz3V3cVEIQuKgu+2ZpXx/A+/fi4hQRb9aPNZZq0Kh6CBN
         OQko7zJgAWKI4wx3GqXXQi8wDQuDpqNLJtNKFXHFYEsxb9mgNIAwQH0yAB/zBkfKQTGj
         RjSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhNAsyT+pJypqhl+JHIA/mL2LrX9hI/vMFjGRTbOdMrODYanniaGQvQXEidFQDFT6XEMfJykexe6T798g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7NCyZRBvwYkqxT5TwK0C/kSfWZxp8nSIX+NFUDPY20OFrjJj9
	446V4dKiFn7F1GjEd8wTNoKbPYiqASlv+KNnbPdEip7YTGAKKOje0r8CG37L
X-Google-Smtp-Source: AGHT+IG10/ec+ECOJ2DNeRyPlVttS+UPhhzYEiNa8g/4Z6dp+cxUxS0IO0/Uh5MO018ZMI4Fvcl3wQ==
X-Received: by 2002:a17:902:c946:b0:20b:5aff:dd50 with SMTP id d9443c01a7336-20bc5a1f1f8mr6790515ad.31.1727808370585;
        Tue, 01 Oct 2024 11:46:10 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e357absm72278965ad.190.2024.10.01.11.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:46:10 -0700 (PDT)
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
Subject: [PATCHv2 net-next 01/10] net: lantiq_etop: use netif_receive_skb_list
Date: Tue,  1 Oct 2024 11:45:58 -0700
Message-ID: <20241001184607.193461-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001184607.193461-1-rosenp@gmail.com>
References: <20241001184607.193461-1-rosenp@gmail.com>
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
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
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


