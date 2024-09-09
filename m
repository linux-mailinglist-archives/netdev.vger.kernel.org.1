Return-Path: <netdev+bounces-126379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCF2970F8D
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162421F22E19
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 07:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA01E1B1407;
	Mon,  9 Sep 2024 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzHedYo8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9851B1433;
	Mon,  9 Sep 2024 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866591; cv=none; b=F/tZ/NeGCOVCbCQXGGHMvLZO+ncbVnaWLm/8eAIfNSbhlvpU5HlZPjitMSYcwhq/VtHKNCIYUO58e7d9JddUVzuhv+Z8wOoZ+b3pT7yaN7Y3xYBr+d/+5sZ4AzBdMBVWE+hWEFa9Q3imV7wti/EcshT2h41oWZbfHwFdepK75/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866591; c=relaxed/simple;
	bh=OWM1Yfv0veEuuMTI6s3R2O/gIarAsPk1rPh9uwCGfKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QP3QeKgLa780Y43bXTSo5FYnOW5dLbJ5/k7xtefjVQgnYoda6irJpkwZtieIIz+ivNT40oNMc/raqbBySw5p2LXtoADWBR9REEdE/8NrfK1oWKEtKO7MsXLwYycgmPCd+nyLhig37gH4kqkSR2n2zuVwCJuFJAfNw1VBduWX3TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzHedYo8; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-277df202ca9so2223080fac.0;
        Mon, 09 Sep 2024 00:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725866588; x=1726471388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S15bsrAtKng24cEfr8xI1U+gVP6EbG/MdhFsVmoJxV8=;
        b=mzHedYo8fCj/RfkJC7nIzUw2SY4sZIF0WlQJABhlARyKTfF1IbF3INTve0a8IqBDC8
         ZaDQ7eSpzsNSkYQZjuj6yJGQHd7TF9ypBjV3PQcjZlVy8Oi8LLyUXYTjbGV756+EhnWu
         TVCt6d2r6sAX1ownm+g8G0hh/qr2PmdBePXAZTb2TAnKmO8fMeAcM/eX14v2K+x0OGt7
         6c6tPuOUHJ7N6IDQPB7XsJ2Z9CZ6yfdokD6UvWQAyS7mPttYP35n7+MXAVli/vY0y61/
         /VQ0QaqsZsU+Qp4vSuh26lMGBb5pC3jegGvMc+BaAntKMsv5WMbQ8JFFnkjGEhyR/ch6
         Y/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866588; x=1726471388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S15bsrAtKng24cEfr8xI1U+gVP6EbG/MdhFsVmoJxV8=;
        b=w/1xSn0gPQLvyeD7DgpHpH96pr8fH/FoZ6wEzQxtZKkL5briIk5E9kp7Txn60uZ2IT
         NhmJKE58hg7/Y4Hh33ixV9lAKBuLfVN7g000KDkDOjf0uOUJrfaP7Lu+iy68wrvx5xcv
         IXBnp9FMIpM7e6Rgr7bqr+9wRLdYKsuaX6qzNgpY06WL1Rx+PcapvYnvW12CziplPjff
         HUDsadFwPtxBAjPFkks9DipUj2ZE0/uPS1LEO3C3My9M9kM/Kd9rxLrD0lRha0uimc9R
         M/qAiEFuYDGvdE1FECu7rawMrorkT5AEnfYR5ZWaRwMThkG1J5jtPQ1GfRNLSK1dzVAZ
         1ZXA==
X-Forwarded-Encrypted: i=1; AJvYcCUX59czxNK1HHbouZre+p7Zchc0jHEAPP94jDNU48itIwiLcZLIclOReABleRsA6nLvJo+S2rk1@vger.kernel.org, AJvYcCXUAxKCiE5jjGD6rrb2yOoKM3NrhCdSCHjKdTSNGKV0kzjxYtL4KpBRn0xJpxAOzvNHrs3EhYbVqQ2QbzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Kt3jGAz5pf42TPLfr+a1HwHZsJqO8MyesuoPlK3cqkzUcAI7
	duQcAgdQxqmebXxA0KW92NHx0hunmuBspqZlkwvmcMvY66sZQuus
X-Google-Smtp-Source: AGHT+IEQXvn2SOwOm29+rtI6JhMQDL11GxzU3NymqcoXZabn/0JlDB/HAsAKTuaQukE+IyxWb3rj5w==
X-Received: by 2002:a05:6870:56a4:b0:27b:6267:61b0 with SMTP id 586e51a60fabf-27b9daece55mr3048986fac.32.1725866588424;
        Mon, 09 Sep 2024 00:23:08 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58965bdsm2962094b3a.29.2024.09.09.00.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:23:07 -0700 (PDT)
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
Subject: [PATCH net-next v3 01/12] net: skb: add pskb_network_may_pull_reason() helper
Date: Mon,  9 Sep 2024 15:16:41 +0800
Message-Id: <20240909071652.3349294-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
References: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function pskb_network_may_pull_reason() and make
pskb_network_may_pull() a simple inline call to it. The drop reasons of
it just come from pskb_may_pull_reason.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/skbuff.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index cf8f6ce06742..fe6f97b550fc 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3114,9 +3114,15 @@ static inline int skb_inner_network_offset(const struct sk_buff *skb)
 	return skb_inner_network_header(skb) - skb->data;
 }
 
+static inline enum skb_drop_reason
+pskb_network_may_pull_reason(struct sk_buff *skb, unsigned int len)
+{
+	return pskb_may_pull_reason(skb, skb_network_offset(skb) + len);
+}
+
 static inline int pskb_network_may_pull(struct sk_buff *skb, unsigned int len)
 {
-	return pskb_may_pull(skb, skb_network_offset(skb) + len);
+	return pskb_network_may_pull_reason(skb, len) == SKB_NOT_DROPPED_YET;
 }
 
 /*
-- 
2.39.2


