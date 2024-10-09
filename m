Return-Path: <netdev+bounces-133432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E996995DD6
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 04:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5811F21311
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD2917F394;
	Wed,  9 Oct 2024 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaGTR18v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64B6152E02;
	Wed,  9 Oct 2024 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728441005; cv=none; b=NeKgcJdaiVWMoDz8a6oC2M9NjrIPK7U8waqFhdZthSI7FU/W+TCnyluAMUmpxlLH5WUKrEK+7xr2wJX9yWT7/uhFMXEK38wsiOEldB+iDClljgaFuenYk8ISfUFVJ8epqxaC+E4P9xJUZxxeO+3po90pNaBOTbjxaU8OQjLzZ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728441005; c=relaxed/simple;
	bh=dKbZM7+rvKdCAftLsIqRMrR/jd8BPaE4KCzu53bpfvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dJvtGRd5Bb7+nb6iwYe4lR4x5bDt7ORJ2iqM80aa/rHNdycDEUAPQ0vGHf3tOcrOx5y0cFkoyXjmitBfKUvF6yq1BoVsPD6yiUt6qgbqGYmMfj8kgKL26bbGRFERh/dExzP9jP8nvadxH9viap0rzOubVmObLagG3kMn0QOlJQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaGTR18v; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-20c693b68f5so1779405ad.1;
        Tue, 08 Oct 2024 19:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728441003; x=1729045803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwQKLkW+/qRHGLn4gTua8kQBWJmQk8KcS+aTLWa1XwA=;
        b=kaGTR18vBoHmkJeZFkYbC09fnpBd7nXgSjMDcW2EBUR6dlGSM+RmJHvs6URy/Hjorq
         w3ZAKqpuuJyppq/+pWOAmu7klRxJkwbAgfv1JXwW9FuMb2k1mwau6JSZEU9cdcxvCc4X
         iQqeMhs9RdFmLmBz4EO8rTs/zhOv9iLu4h2kXzedDLqdTpGNI2U8r0JtbBJm0zgOSqcm
         SncU9kWnphGbtwqVsAu0p5v3dd5oKEtQ6h90U1R4CX1LPnFBMlNXZi755qBQu6eTyDqx
         qv/REvCeHzKa4pjRQb55m4ud7duSzmIeouDvfnh8R2TgNrkyb3LUfslIr6+dYBC5MmZs
         EkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728441003; x=1729045803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwQKLkW+/qRHGLn4gTua8kQBWJmQk8KcS+aTLWa1XwA=;
        b=Bv4SScpC1XGHSssnlkAxEqovgi53vMEbk4ldT4ffDGACjJD63P3HGj68z9eiGDTVDn
         ijv013S+1DWSSEOAvirtc++DvRQtuKPo0x3wzwcdIa6Q7LQ4Ul/zy+Gi/tlNukCEURDN
         zbKfIP41iPJ1om09ejjfXieiRfOkDwUg9NfK2+P963RmQNhGopuC2s1e2oz0NSlYfGez
         TFpFXkffwqnVNBNIt6t9LhhPimd3NywfmGCg2bYfil8DXh92b4WHpHsHphSvqcqzHeBI
         7Yv3vkZMc9Dt89CTowyZvuCrHZ2bBZzee2BOjgFosCiw6nNXQnfIVrIIOTSWnfqPNtDl
         SJ/w==
X-Forwarded-Encrypted: i=1; AJvYcCV3bWs+D6GFO2sOIA2pUyjj3/9Xn2mXDfDJrmqFEB0fXJArScDeDrK8QJM3IdH5G6EJqJ0l1FpFw7tQ5DU=@vger.kernel.org, AJvYcCWkYdBn0mtIqo8nTDioiFEFfp3pawjA0SoSVVmHb5+2BqWaOo3G69gC0ro+v0Ei09VC4lFHbT8G@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqws3FUhoCr9i9hCZbV3jQiSOj41OIohkBUX2/CmEGIQc3GPdo
	dezjYXAUtZZvKIts+2NRPdH59DbH0es+oIHtlLk3VyRL5P3mK4lL
X-Google-Smtp-Source: AGHT+IEwVjJXtOtb8EqyvWRcdQ0mjFdDbsy4qfl1xKCyh//3oR4mPUP4YKlN2iEhcI4dlxILJ+h8wQ==
X-Received: by 2002:a05:6a21:9d91:b0:1d4:fb5b:bf44 with SMTP id adf61e73a8af0-1d8a3bc30f2mr1586721637.5.1728441003135;
        Tue, 08 Oct 2024 19:30:03 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5706e8bsm336202a91.18.2024.10.08.19.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 19:30:02 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v7 11/12] net: vxlan: use kfree_skb_reason() in vxlan_encap_bypass()
Date: Wed,  9 Oct 2024 10:28:29 +0800
Message-Id: <20241009022830.83949-12-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241009022830.83949-1-dongml2@chinatelecom.cn>
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree_skb with kfree_skb_reason in vxlan_encap_bypass, and no new
skb drop reason is added in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 508693fa4fd9..da4de19d0331 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2290,7 +2290,7 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 	rcu_read_lock();
 	dev = skb->dev;
 	if (unlikely(!(dev->flags & IFF_UP))) {
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
 		goto drop;
 	}
 
-- 
2.39.5


