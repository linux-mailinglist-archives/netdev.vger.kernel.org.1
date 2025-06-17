Return-Path: <netdev+bounces-198795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2375ADDD9F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920E33ACABD
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8894E2EAB62;
	Tue, 17 Jun 2025 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vp8MluEo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233A52E54DE
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 21:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750194597; cv=none; b=HYzsEPzMViAObLz2lI/yTPY8LfoYSh6iblWbbF+spTbuft5JAT0Pj8/wgxWBgfmq9jOkRC2FvZsyYqN0wMh6/k7ZYnwgGyqVHRPPJ3VqeoDld5s1qJOuYfMXdi3b09I0JSdsgVno5tvz+7kKKVWMhSmKc9TgYFHySzaA75TGic0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750194597; c=relaxed/simple;
	bh=l+gAYnVK3hmPAH+0q3x5oDcbd+to8+Y/w24p5fg7pLw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aoZEv1NhFU2xHi7LqILynycJPOL4jyRo7H1Do2ot4yay/DqITDfl5CWW1PRzFCRIfLgtvEL3yK9un5WR65Q+GrEK4LtW/AdX6ttb3Ce/mIkJ7+c16Fp0W1n5yUe8vSqpX0Mn+0cIwY8mVyKsXiyCwoJKsJtBH5m61zrcGNqjFo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vp8MluEo; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311ae2b6647so5318856a91.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750194595; x=1750799395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i/VGyywtV/bSSnR/m+LOohdoubGYGpC2/0l4w+x6gBw=;
        b=Vp8MluEo9lHM3F15rEtxRtKR9KQguhdDGUKu6B6KJmvY0equ7FZZbQjQ0bxmguunbx
         yghVwbEyTi+wJScsf0NfyUatieWEDUGamXU4KNFjEzsAIjB7RoFfyqake6QPWowXLc4o
         4cpLVpFYuVoE5KHIqdZkl9f/ivek7KUzU7jh9dcxzpmkgv9gqaDWFPF7nAGD9ViJOud8
         ZxJADZf5KvhbJjJ9pQC19yY6RSVcV/fvKHWSVhXweNtJA4Ofyc9SDPa5GS36KfdBRwcD
         QPNtawow41kFS2OB35n36S2DTPp2Cf8ONpeX1S3qspeJQj09r71JBEVs+avqz+cXZGgC
         dHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750194595; x=1750799395;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i/VGyywtV/bSSnR/m+LOohdoubGYGpC2/0l4w+x6gBw=;
        b=XW30yHrzIzGcP6VKk18Tjwin1fZnMN9+/iyGvjNqWCPiny97rTdwaHZrL1DswPot1l
         fW6wIEpT1shjgQX6axMzXx18mSv4qUoPbMv2QTzkY7SGU3S4daEDpmDRaYyVeqxh0aLc
         FUTYAenZtcIbChHFVsYNWFrIeoXHxdvEBE8o1mMxPiXPcNXeT2hBC71jJ8zAfS3LH6Wc
         iOai99SiA+TvUUBPfnG5FCQOE0InToym13JaAma33EfkmhtI0FsMKYUkqJ0HBBzagx+K
         6kjF/n/v8TKtKpEMomO0CMwRz8AAOdGPiwWxfOLb4dxXxCGG768dOVXSpXD7GBacDFKu
         n/Ww==
X-Gm-Message-State: AOJu0Yz52ziAHdOiqqOHZvxk4pww9mJBKwXMET2JngqGXAn6kKHwvhCw
	6ehPnSzTnKc+Yc3SnHXv3V0+31zIQtVSrzQAhhVGqnwGBd9LEhk4Lw+qgQ7+zGSIIxh2WHjTfPu
	MOK/Iv3v30b13E+MQDHJkJfql6EhasQB86S9ro65kKAb8PJxsBNZKE7pL3XsWskAEP9MeLa5tT8
	sRLw9fFXIG8jpZk9BS2KuZURCxSZHNscfNjbmYYkr7BE5Rc64soWoCqhbxWb3gtJ4=
X-Google-Smtp-Source: AGHT+IGwwf3BFhjYUIQUdJ7POIRGQ7r131ZO7hQf1HmFGKvNY0E42xdvnx+IXbs+DORFLXEGhl15NyJiGXis2ooPow==
X-Received: from pjbmw15.prod.google.com ([2002:a17:90b:4d0f:b0:314:2a3f:89c5])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:c107:b0:311:ad7f:3281 with SMTP id 98e67ed59e1d1-313f1ca70acmr27617519a91.12.1750194595273;
 Tue, 17 Jun 2025 14:09:55 -0700 (PDT)
Date: Tue, 17 Jun 2025 21:09:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
Message-ID: <20250617210950.1338107-1-almasrymina@google.com>
Subject: [PATCH net v1] netmem: fix skb_frag_address_safe with unreadable skbs
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"

skb_frag_address_safe() needs a check that the
skb_frag_page exists check similar to skb_frag_address().

Cc: ap420073@gmail.com

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/linux/skbuff.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 5520524c93bf..9d551845e517 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3665,7 +3665,12 @@ static inline void *skb_frag_address(const skb_frag_t *frag)
  */
 static inline void *skb_frag_address_safe(const skb_frag_t *frag)
 {
-	void *ptr = page_address(skb_frag_page(frag));
+	void *ptr;
+
+	if (!skb_frag_page(frag))
+		return NULL;
+
+	ptr = page_address(skb_frag_page(frag));
 	if (unlikely(!ptr))
 		return NULL;
 

base-commit: 7b4ac12cc929e281cf7edc22203e0533790ebc2b
-- 
2.50.0.rc2.696.g1fc2a0284f-goog


