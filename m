Return-Path: <netdev+bounces-239392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F577C67D63
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADA894EE44E
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 07:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE312F9985;
	Tue, 18 Nov 2025 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Plh8AkNW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE572F8BC8
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 07:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763449626; cv=none; b=Lc2OcqDt17q8hH6XWGi8RPP0kGfrP43D80+wUz9+OcmH7LeYQsgHPExqeqiQJEMEJmyo8RDNnVjivbwtrQPSxDOfccMI1KWTQustu7qOqnv0b9Ciy8OA3uXn/ShrWDSidrdUxbNKSj1hbCYMS0PR4S/GvqbWMskmderpddCjKmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763449626; c=relaxed/simple;
	bh=5g6k5BzwpuBqUFfvHmjlJC+7YxAPf4rt1rdJRr/37S4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tC6RngLZ+IEkZpJ3u8oqi3JNsPJrDHX5K6dPMa7twt6PSUQDosTBAprRLTJTCgQ7cAKFhk9WJvmM5pZfz5+VHwhihzoztDbgtvHJYxFYuoOaV8YJFczpE9dcM7iesG4ldpzhplUiOseUWRiVJFusT+l16FyUIIOuqU0bXR/AFmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Plh8AkNW; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-341988c720aso4368836a91.3
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 23:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763449624; x=1764054424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkB4RgDB5Bcj/2n23/sQis7qO/bn9myIhi8+KuQ4Huc=;
        b=Plh8AkNWw/wCooB/xSbv6PkYUy5nWViFJxUiG+vBCDX+9Pd+a4i5O262HszJsFpTKX
         IuuRyjVQREahmbrUnDL0DKIOjXoUSFKsLE6QWuF3HUp3FiL4YjY3mzwLZWQcWQzQ6ArC
         +Es4DqkQPpQXbmyH/V0eVKqz0ImRLO8fGNx9ZmtsUSrX0CIH3DaTMXI3ZnQRiwm6ShNQ
         Zr28+QcVCIYEnln/T/slCNeaNu/fCbn32+oiJCDHWmT/O8cATbVK7X1PvfPV68Fqgyi+
         DnrRvVJVxrRc67IMu0ryQdc7oWtZaECaQfRrKGrYI+nGMslmFYgjW9L1rgszGsalF23+
         48pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763449624; x=1764054424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HkB4RgDB5Bcj/2n23/sQis7qO/bn9myIhi8+KuQ4Huc=;
        b=g42M8d4l/9NcQ7NiDjsp3c2rf4Fwf79X1Ha5m59aObiaGin17bczzLMb52QnVtpci0
         44I9c7lGFfoDIQfleUxa/VpjqzBGAfLP7egAoocY/1SGfDd3ooxEN5hjZYsYHOKmdunD
         /2NsalQbq1Z1Snt+8bSJMuWxb/+y7CqOkOXWhsZBdI5Zm1OTDhUpKIR/MXIc84Uti8Er
         EO4iqABl2v7XSKB/+nPcY90TehcOWYbvZyTfgzGDRHgCwHnIJaEA02IAPXv1kOpJOmB3
         FDtC1GjKS7bjxwm68EyRsWhAbp73cFCwomlCLjn6ks6w7w4Yxc+OVs2tfnVc43WIj8sU
         WE/Q==
X-Gm-Message-State: AOJu0YzPyAK9Lrbn4ZFRRWGqfGifJDvGpe4RFXfRqimY3uEwY+5bAjR4
	rz7QJOynHSbF/sfaGyCJ4DdOoi6PfN+gmYOwUFddJj3IbnBvg/cT0Pf28gUOEq30
X-Gm-Gg: ASbGncvMj1BEevPnL9pPYGeiP2pvOx7fBnSrjWRvf5Krc7J6O+gdj4P2rV/E5R05w3O
	eCC5Lyy4lmy0+7gAaWhlQKTivQZOOsCNut+X31R0I8KTfVw4Cd469tWZKQ8YQ5oCo6IGaxCs4ps
	xMZtQhE90Eb4WQwQrEsMHv6FIKBwnwSHi6B0PDIDdFogwTkQ/0qt8+7h5GVQkbur5B58hkqD4tV
	nNw9mFbW4ljs7XE987gXMExyEC1BOw2515wbiIv2xUxs9Jnafn3MgBjhAbZ1RxbNtiPWgasUaJP
	y2Nx8wQi3+pJ1eP/USZ3pDUay37j7qMrFkjr3enhfJsU85Fw5g4W2z4zaemD2UpyLNoho5S4KpC
	NmB1Fs00e+RqCDPF+LEyXl+9OYn508Efn2pMPKp064NDX4IMGz+PP9G4rylCrKrIr7vevleKhe+
	1R84EUfwmzInrKcWuhx7kVuYwsaBdAALaP/CWkVCe8E5gpHiM=
X-Google-Smtp-Source: AGHT+IHJZ7lrQC24tar6rsiEV3MrjGZcHHBX7Lf2LxG9AxE9+VxeJKZ12Ba+ZKWK3bjEpfpT0wiGcA==
X-Received: by 2002:a17:90b:2f8c:b0:343:6c71:6d31 with SMTP id 98e67ed59e1d1-343f9ec8d2bmr17812450a91.11.1763449624109;
        Mon, 17 Nov 2025 23:07:04 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345651183b2sm11868494a91.2.2025.11.17.23.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:07:03 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 1/4] net: increase default NAPI_SKB_CACHE_SIZE to 128
Date: Tue, 18 Nov 2025 15:06:43 +0800
Message-Id: <20251118070646.61344-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251118070646.61344-1-kerneljasonxing@gmail.com>
References: <20251118070646.61344-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

After commit b61785852ed0 ("net: increase skb_defer_max default to 128")
changed the value sysctl_skb_defer_max to avoid many calls to
kick_defer_list_purge(), the same situation can be applied to
NAPI_SKB_CACHE_SIZE that was proposed in 2016. It's a trade-off between
using pre-allocated memory in skb_cache and saving more a bit heavy
function calls in the softirq context.

With this patch applied, we can have more skbs per-cpu to accelerate the
sending path that needs to acquire new skbs.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 9feea830a4db..e4abf0e56776 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -223,7 +223,7 @@ static void skb_under_panic(struct sk_buff *skb, unsigned int sz, void *addr)
 	skb_panic(skb, sz, addr, __func__);
 }
 
-#define NAPI_SKB_CACHE_SIZE	64
+#define NAPI_SKB_CACHE_SIZE	128
 #define NAPI_SKB_CACHE_BULK	16
 #define NAPI_SKB_CACHE_HALF	(NAPI_SKB_CACHE_SIZE / 2)
 
-- 
2.41.3


