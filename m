Return-Path: <netdev+bounces-245885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE12CD9EE9
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 17:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 481BD3003874
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 16:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A434344046;
	Tue, 23 Dec 2025 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b00OVBmk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A357337B9A
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766506991; cv=none; b=d4UA06lbthnjUOgmkRKVDqGngIWLBTWxs8M2S+sCGPnhd6jKrVB+MkGvYIoNJx9CyP0v4FEI/yPR65+XPJsc4KV5+VP8q8trdDH6aSi2up/esK20QKPCtakIUwjA2hBGnAvibQmVumcVLQ2TYHeZnTMfNY8rikrwl4GYkWgJSkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766506991; c=relaxed/simple;
	bh=WuBmP1upEgh6yq+m+Oua0OiQq6EfJYbEU9diqUGvT64=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDXXOlYEqJ0JsLPUxSjraNyS7oaUT5fwX8oAhZCnsmLt4CDGp2MmRFqipvuI2VhjOi7TKvS6YSSc34QN35SsQyL4CEjVIgFHRVLzEbunI0HFR0YKpGOzSisyUEni5rK8oA1uZvhkJnVh4zWVUV01I9JLVw0fqn4zzfLwQUlcOsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b00OVBmk; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78fc0f33998so29178157b3.0
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 08:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766506988; x=1767111788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NiVv4VG/swHKILAsJIpUoUQtmn8TsYBKMx+CuhseMNs=;
        b=b00OVBmkMipPgj1o3ZVySVeyEgwx4an1WfA9xkXmgRltkxEpN8Nr4bQoN7fIHFQSvV
         esbtsjDnrK+I7dvxWl7kGhFwoiMoB/csJe3TcXjwEuVtwKsF56dvjvGYM7ErxhtQUMUU
         TV2z46EMCcl8zQVh91jGOuIIq8/8KEu3gPtpUvYGxxF20JySYnA6Pxl1TnkI15UJ86gO
         97OhZKZF4khnm/T4/p18+6G+ppO2V6XfhY34R0xS+s36IeJxn2wuA3JOFHfMPS/XeOHb
         jr57ZZjrej5bnIizQfrKw25/OGNZqRrzctnEYXcN6sqDfI2UsmS8IwbwX2SzkxqGzl9N
         rV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766506988; x=1767111788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NiVv4VG/swHKILAsJIpUoUQtmn8TsYBKMx+CuhseMNs=;
        b=DFb+XyL0Qz+y306eBdmucoI3sBgW+3trxKxCNqop9AE7R2PitXcMMOz04rZuOmv36Y
         WMyTj85DQJv4q8pHIHZAXgcITTJquT71DFjoVX97xlp2dwMWwUoGNLKMgKpzIoHTNjtI
         qMywoP7pd/nWTdwxLx4OmcjHF1S9NTF9qImtfQRzYLyTTFaJ7cdN+Vl5xKwVB/pVuxGU
         CvSn+znDXxhmusAD0erxvBQkqc+vOc5josvB3U3H6W71bFMhcKaDEcYFCGubDCkbNq+t
         vFvErNG26pcncLi/abVIGMPwaXLMZSyR6N7XEGA2SUGvjB7txzdmMZmQm/9z89cXkcEN
         /pAA==
X-Forwarded-Encrypted: i=1; AJvYcCWZJfEStoBTRvP47EMQ8843u/xYFsz34yiPY4MvwtAETyjTDvZvzdiC8wFOk0WIXVuhwY3fy60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8BaCtXRdi39Ffucz8x1IQGFsIIzwO6QJ987gx1YCUS5eQiLr/
	631PmBc06aSupxAZniC+v1OZGmlFK4xvStsLca67zPp8iMkD9r4oNuz7
X-Gm-Gg: AY/fxX5FFZYT3BEjveTir0MEGZOA/7c2oaO7g/groKV+yNsIl87XclfZZ6n2M8JBlnU
	AW4dY1oxDMnBQXjwXiFFpVFkEI/S1qZn5G+KJOn3UiePtGj9oYTgsEbF/1X1Xzi551HqKzz3pdz
	yFf4mbuaXrsT4zwGAz06cZARLtYPUeA/2K8ood0+Eok01Xgs2BqN81t41NTLT33yCKL+5ah+7Ic
	5nZ4Xb/k8fPhdxlq5PQS/gV+2YpQICUMEak/EB+TRIsj2Q+MukuvBxif7WIz7NNefxDixpJytmF
	HlTLwOVpbfihJ4/INrlSgSoJfEPEIwpfDTkLiGUd66k/LvBuElMF5DcxE8t69CH/j//pEUXL4O4
	SMuw866G2uLKU5R4Or4lJcAZpUWXGvtT+kV8iWWNVNHy4x9ejjnpDXt1xYUcWTVlELREl/DhIX2
	nO1GYKmYI=
X-Google-Smtp-Source: AGHT+IEIDS9zMM50ZlFA5Hl9bR03FFoth14fmX1kch5FUlZ2LFbCe/5eRU4YNWQQOULng7e4U3/pdw==
X-Received: by 2002:a05:690c:4912:b0:78d:7307:769f with SMTP id 00721157ae682-78fb3f03ff1mr254742257b3.3.1766506988228;
        Tue, 23 Dec 2025 08:23:08 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:4913:14a4:1114:ff0d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43cfae9sm55561267b3.23.2025.12.23.08.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 08:23:08 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ice: use bitmap_empty() in ice_vf_has_no_qs_ena
Date: Tue, 23 Dec 2025 11:23:02 -0500
Message-ID: <20251223162303.434659-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223162303.434659-1-yury.norov@gmail.com>
References: <20251223162303.434659-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bitmap_empty() is more verbose and efficient, as it stops traversing
{r,t}xq_ena as soon as the 1st set bit found.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index de9e81ccee66..2b359752a158 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -1210,8 +1210,8 @@ bool ice_is_vf_trusted(struct ice_vf *vf)
  */
 bool ice_vf_has_no_qs_ena(struct ice_vf *vf)
 {
-	return (!bitmap_weight(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF) &&
-		!bitmap_weight(vf->txq_ena, ICE_MAX_RSS_QS_PER_VF));
+	return bitmap_empty(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF) &&
+		bitmap_empty(vf->txq_ena, ICE_MAX_RSS_QS_PER_VF);
 }
 
 /**
-- 
2.43.0


