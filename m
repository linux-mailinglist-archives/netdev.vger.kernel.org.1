Return-Path: <netdev+bounces-241210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F37C818F7
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D593A9F17
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14A0317700;
	Mon, 24 Nov 2025 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Z4rOKSzI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E508D3168EE
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001758; cv=none; b=Ufk13tr6eAmaAyGQZq5E6+J0Emza+I3iv7MoCXrQidQiA9XY+4pLlwglZhfUiUYcnCQhTOSkw6tleO+jxsVPX/aGJWzOXc2YezrE3bK8htcGwUGssK4lXlXKD5xGuatgXiGDDXngl4NBuReshc6cSnUpSBnlDFkgDGPMAwQTR7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001758; c=relaxed/simple;
	bh=dJFkpkcwul9i610GaMc0iRpa95RQYa6XEJjEHcyLu/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jFWDPElBO/MW/9eqBQvypqxNFvG+14VwKPXYuBgQ6n4MmsOb4T2XpB9NgJR8SteT9ueJiK8znuoweRedioyNRW9poSoyQpXuC2iLCqQoSP7rzuKGP1cN8PT5kneNGc2SP1F2HliAF2BoMKLprgNsj9vvfLuZRsd87Pm0810yHXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Z4rOKSzI; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64312565c10so21219a12.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 08:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001755; x=1764606555; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiaXl0XaQMH3wHsHRoU6x/IY28W2tFyVr1ezRe/dHPk=;
        b=Z4rOKSzIfrdJiBz8SBdDeECHNG4U5ehXFdzswTkJzUiNmpw03P5dQfkY3bD9BQDeqB
         SXMNv+qQbN7c5mPDOfgQitYJADBR6bdrD162VeV+uyFB8w6RXnpQo+Xzge+bz2LjWdmY
         17g+zou4NmyDjw4HSYrzLJNDW84A/SQL1dXwVrbnHOoPC3E/o+kSmsZ37JWEwcewRN+M
         0FvLdno1uGT7F2pSEo9OxjETgezuHA3h27+UPHfNZg0vNZNjC1Zg1niwtsFulbj9i8ua
         FPRex1auVfxdAXPFHifoRyj+gg6ufYgC6nhcSFqnJztRRAkQjx8GzmU0hfWn5uAnADln
         J9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001755; x=1764606555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LiaXl0XaQMH3wHsHRoU6x/IY28W2tFyVr1ezRe/dHPk=;
        b=HCoDvhH2N/AuNgqcs8+pGIPXXDlcfZIAXbNomdeC7nQVZMoAPOxlX0FWqzrG4AZsHY
         LcTCD7BbGC5Mn1cSMgX8U/aduyqY+ylaah8pMfA0ckoueqEnZGe7VOtxaMp43XlAE2s8
         MOzs9xD066/7sLEPQuyQ0naO917zsib3B1h7YBNZU+R8rGgHWLO5KoG26rWrws9jSv+h
         60iQpN2/H60WhapP013s60Eule0Q9u6z6+1CltArrqqgN+1YmsU65cUEh88TmoEdRZDi
         HdHaoK2nB1FeVzyP62j8XygMCrzbJ6SKEw/5cnO1Ip+8+Xxt6GGGNpyFJCRI7yPbPek1
         5JDw==
X-Gm-Message-State: AOJu0Yx+XfEJhHTiASrmygi/2sQ+gTLacVp94BHB8IEdc4bR7K7DOcCx
	+/Z+5knAbnP/pBZduU8WkbU6kzsOTqozDWL/Nn/hdF9WLPwgky5kYsaiwzGx4IfeSno=
X-Gm-Gg: ASbGnctdbb74txaQBOCJWBYYULk7mCAWYNP4h1iHJyp7xM5F9hJsmc4FZphbX9uVEYT
	7xpdNPQTZVOXt23rjJuNWELLcwsACep/6Wa6yNe5FX2zC+dh1/j4Ly6NPTeO22oHIwzmGtuEC0R
	xx/kXxrs3x2ZUwEt1II+qZEQIWrrzn1C/Ejt6StxiHElmhJZjSfFs7WOeq0UTLV1XIRGntEtWWP
	1a96wTtFT6oYZl2SwXmrbylXDwQV+L6a0VVbzMTqs+fCoVH902NPm2p6Z8CiUWS9fXB/9tFxQ5g
	CRRQ6E+ONr6pVBENfDtiPRNo11N7/+7aUQH6OvEZP0QmBt05CKlAg47Jq0f0ZOknDsCnUOTGw5C
	Bas3HWf6Of9NCeF1feyRJp9NOkfxoyWcZ0//G8JL0qRR8Wh07m7J30zeM+/9UKNPYLUR1fW681F
	YRf7Cq8cQv5ccZ5Qkk+2d4L3FCvJc7RMa2T+nu1BsMcSB4qfD3OPBWXjtp
X-Google-Smtp-Source: AGHT+IEQ8tBaq8vg4gTyTVnLeeMVJWCeb6J9z3gEDvxUDIry7aXMkwtIKfACrYHrJl8CUmKpyTWQaQ==
X-Received: by 2002:a17:907:94c8:b0:b76:4c16:6afe with SMTP id a640c23a62f3a-b767170abcbmr1361499566b.28.1764001754690;
        Mon, 24 Nov 2025 08:29:14 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d502cfsm1326841766b.19.2025.11.24.08.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:14 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:40 +0100
Subject: [PATCH RFC bpf-next 04/15] igc: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-4-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
already points past the metadata area.

Adjust the driver to pull from skb->data before calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 728d7ca5338b..426b2cef5a1c 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2024,8 +2024,8 @@ static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
 	       ALIGN(headlen + metasize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	/* update all of the pointers */
@@ -2752,8 +2752,8 @@ static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	if (ctx->rx_ts) {

-- 
2.43.0


