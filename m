Return-Path: <netdev+bounces-133421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB02995DC0
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 04:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E572E1C217D7
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAE7143748;
	Wed,  9 Oct 2024 02:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ukw3WwtA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3239A1428E0;
	Wed,  9 Oct 2024 02:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728440956; cv=none; b=mHMipIIAp/KgqJzZZo1WFS4hQ8kmupG81SD9c1flhKyXzCRmPPNEjwjjbeHawnKtez5fsJJt9dPJqhTkbVog5xmQWFQUL/XkaLssLs8nzs/wLaeISA7Ju9gl87U1nMCykCSD1UMBzz9hcZR2svbVsoa/AeAPlNeeTXhj2MW9398=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728440956; c=relaxed/simple;
	bh=qDSFVKxj5P9OuUbcZh8vXPtfp9NKaBMFgSQrL48vbZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cVsl8pw7x2pfv5AWUxIRtJVWfRm6DcAjhzV+39rZsK14Az2t59GK+dMqctasfBbTiFw9SmBg18NCkogq0Ku5p7owFEfzJ3+jnGMz3JvaOxFW9ZiKCI8djHtxhTYFWx5X3+7NZt10NImKkhugRQU7nbVbOc2j6dIVoJfh8b+iQv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ukw3WwtA; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so5076880a12.2;
        Tue, 08 Oct 2024 19:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728440954; x=1729045754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLvKfqnfSpZ28mnT6KrdGxzwf8Ry3wsHVE17xRaKj5k=;
        b=Ukw3WwtAOO/GEVNJjz/58nuIgJDpw+AJ21TLgBrTCil9NINWDPeDYr+5mJZFuECXjs
         Qg1RMGfISLekNxlkkkcOOHfIk9PWUeWdMwlnmnWVa+/n47vWmgMBYv5JZkPilRWgiuSs
         jZewM13NRUBZXpvYM6nhKNYMvqtXLhCBt2LBjtge2oYiqriFvL2U/hiYjGLpfDxq2+jS
         HAM4TECyXU/rGXvBm5Oc1cJfBlULf1ywhDrUSaveHgpq24+sKlomomd1o/fBxB21KH1n
         d3QfzvG95UoA3+gOjFmFW1VZLYRRrW929nKxuZx7bmZy+6AJ09bqk8P9DPhelgimcPgZ
         dzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728440954; x=1729045754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLvKfqnfSpZ28mnT6KrdGxzwf8Ry3wsHVE17xRaKj5k=;
        b=JFg7xqMQPdWDnou/2V82wYbkhQOSUPfexIkPUu5azV9Il87FAcRKOnZVEI+5oe4I1S
         P4Cm+JyGGou3tFzKN+5YXfxV6R0YjANeHSrfaGYXp9QbkFpPq2Zx2LRad6YKstT4HQf7
         vuPZD5LXmIXtLssTxkEDc8WD13AE0ddZL2H4Ga6o1U6YN5I2aED6l/p+TedXYqIuRxKK
         DCYKOorRGoJRs92Rtaieasba8cv1nOjpZu2wWKAmHw3VYUrvxAxUq9KB1TBTZv+Tqc+6
         boWJSx1spEqNk9z7EGpJJjKR6wV/BHhRihJHPKB7GcWWVS6Hz3++8tpxdYvkMeclmzT3
         vL8w==
X-Forwarded-Encrypted: i=1; AJvYcCWcTVzcbeRrEpIXCKwWpRNPE5zyO9KfdRKeMK1XFFREx2sMzrGb8f1Dh3IIzpeQICcxT6oxMuk6Aa6LL5I=@vger.kernel.org, AJvYcCXFt0bHeBqxQtgSYDqNIdCu/gkCCUtJuBc4EqnxiilzL9Xa+aZBrjjXIHmXhH54/h7RnIKsULqI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt0zm752VDzepJFRKAR0lTNtMYBpNP3dDo1+rswGNUwLoeEbul
	dr0HA/086mRd0bgnaOJULcgz3GzgR/+zzRZ0fCd7SmTswvWp29CR
X-Google-Smtp-Source: AGHT+IGNsCMih/0x2kJSzp5T+rkVUOL2c5mZmOtIfCCSq2Q+bvBVe4k6NXxs/YrH7h9b7z+5BMRrGA==
X-Received: by 2002:a05:6a21:3a83:b0:1d6:e5ea:f985 with SMTP id adf61e73a8af0-1d8a3bf06cdmr1833623637.12.1728440954454;
        Tue, 08 Oct 2024 19:29:14 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5706e8bsm336202a91.18.2024.10.08.19.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 19:29:14 -0700 (PDT)
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
Subject: [PATCH net-next v7 01/12] net: skb: add pskb_network_may_pull_reason() helper
Date: Wed,  9 Oct 2024 10:28:19 +0800
Message-Id: <20241009022830.83949-2-dongml2@chinatelecom.cn>
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

Introduce the function pskb_network_may_pull_reason() and make
pskb_network_may_pull() a simple inline call to it. The drop reasons of
it just come from pskb_may_pull_reason.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 include/linux/skbuff.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 39f1d16f3628..48f1e0fa2a13 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3130,9 +3130,15 @@ static inline int skb_inner_network_offset(const struct sk_buff *skb)
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
2.39.5


