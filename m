Return-Path: <netdev+bounces-239395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DD9C67D66
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B34D354616
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 07:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B392FB97D;
	Tue, 18 Nov 2025 07:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5lGP3Td"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75AD2F531A
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 07:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763449634; cv=none; b=Z7XmwKytT6jaYdY/g8VkcSII9ANwNoTOPM5LY9DCd4Hjgyu+JNW0vi7TrzhVDnxE2GDPGl0E2iW5DvdMaeHVHC/JbQCRHiUgqgBXjVgoC6nStO4C+z0G1iLBRsDU1HgJskwb+xa982fVY7MGFckLWmCtlrqdPvG7w/sIp4K10iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763449634; c=relaxed/simple;
	bh=3RED3YqVVZqWfs4npKZKtaBwJGrtnDirzNNEGnJpL7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ik555bShIpf2XgbVswNdT77sqf3zoPGXJEZyhy7OLdzsdBoC3TKnPdBW+Cu8sozb7XkDwPki/O7A79kxM7iOY0NwMP3io0CtHd3Y6Xf201D09xFW/LfORDLgVgQwhZdOlnfvq+xK2gfIreLjxx7ZIIvtMgY1OJfJf5QqRaI4A6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5lGP3Td; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3410c86070dso3887772a91.1
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 23:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763449632; x=1764054432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cox+QGAKOZb0FZ+q6lv8UkSqGpKkoFZtrVzvrKo4ouQ=;
        b=c5lGP3TdXVH4Q5uoi8TZreYVNjMBniSbaKJYzlqQ2kyoGlQhitO4Jbda2LmXMxk5qV
         /y4ZKOhhnurSxGKvDXUN3OGr4h6HS/3eB16YI82zAuq58MuW5Ddr9UbZqTJoKUAlKN+p
         dDK6quGQ/kvr7ha2dzIXH9ziY7518vdmT4iwzxzaKa1yDJVn3YrGnUiqvk4es++2mRq3
         i3wqWhyoc+Cr0GNeJwdTlcDOd+4shjTzF3xUkBcU2YY7UPJbLmdQOWuAk022TrJSb0A/
         rgDMNIXXAMvxJU7A989Zgi7Pj0lHcWZ12kv79GryYMESdUKSUZErcy7YNwAPMfydes+b
         Vxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763449632; x=1764054432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cox+QGAKOZb0FZ+q6lv8UkSqGpKkoFZtrVzvrKo4ouQ=;
        b=iZy2cPbH8BP190Pc5+tA9vxOSEB2X4ed1ON83L20Q1dKPd36Wqf5pbYt+CVg12vldf
         iVv2sDAai7AA0dIIEPt73GvYX8gaSzPtBu4RUjlTfoxoBwFrVWSJRpQsGaqxItXqiUDv
         Wm1EP3mnLOblrfV80n/8KzFKnUk9KToz4RwZXKjWir2xBqMdFNi4q4m7weGmdQkln3Ey
         78VtgkmEES7ASqDeL3cfRHRr+rgfdsaBfGLqCTHOUyvpt3U9H6zlffOmWqJDeeOcxuog
         dbOG+jcXY5DqZexDOr9mJdkU8jUV06CPEZTUjUlTdN3R9om3wmLEV0+YRfGJsP+CR0o8
         /xfQ==
X-Gm-Message-State: AOJu0YwnvUCvs8ZNWr1JxZ+Z5KN/OC6TR0Y/VAgfSeIqN+JGFmj1i+x+
	7n5h+hoKcRc7BEDR4kV/uWwHnvJvbZfT6XMqj1TrqVrYrxlgYH3XlMGd
X-Gm-Gg: ASbGncuvFUOTfzVsJQBrdwoR37RmD1yHoFvF+8YeJ3BWQJrv5aUTgO0ROz4DDwL6qb4
	Co9yG4E8dHWEydY4OSBbbGx7AavDl/+inBTMkYIGNxGdm7uHQm4Ks0vOTXc4P/qdw2DLV7xNMhc
	kaia0iUt3jS6X/1dcWRMi1vcr33t9dIt97xyfGCkaa2qm6v3/ipXJJ/3oqBIl4mHCU5WRAawLLo
	tGk1nqM/mUqg23IlQAyNngvjHoT/stCq0o4KM6jSL6siW+mE6AB7z7IQEJqfOnGv2cllNrptQEE
	kTkEPvzO9urqg9sXjaKy+51MLlr8JcBHbxd0o+7c6k/sgyh4fuH8z32tOFTpXZJdLs8ycis58Ln
	5tqno+2LoWEYF1jtDKW+vEEnHfPPRHDx0EmaL1J1Y3CGT4VyK7QRDPORpPmTUSrlGpeRGj8dE95
	VQ76x/ciXLlXIPenjnhMMe5lk4DDJ2+mSdDEd3S9MhO6MNrdY=
X-Google-Smtp-Source: AGHT+IGhN6YS+jHampvyhEZt253P0eaNhUc1BOQA57xlR/xLHJdePDApMnfuel430mxolKjANOr7DQ==
X-Received: by 2002:a17:90b:1a8a:b0:341:69e3:785a with SMTP id 98e67ed59e1d1-343f9fdf8efmr20032430a91.16.1763449632102;
        Mon, 17 Nov 2025 23:07:12 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345651183b2sm11868494a91.2.2025.11.17.23.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:07:11 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 4/4] net: prefetch the next skb in napi_skb_cache_get()
Date: Tue, 18 Nov 2025 15:06:46 +0800
Message-Id: <20251118070646.61344-5-kerneljasonxing@gmail.com>
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

After getting the current skb in napi_skb_cache_get(), the next skb in
cache is highly likely to be used soon, so prefetch would be helpful.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/skbuff.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d81ac78c32ff..5a1d123e7ef7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -299,6 +299,8 @@ static struct sk_buff *napi_skb_cache_get(bool alloc)
 	}
 
 	skb = nc->skb_cache[--nc->skb_count];
+	if (nc->skb_count)
+		prefetch(nc->skb_cache[nc->skb_count - 1]);
 	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 	kasan_mempool_unpoison_object(skb, skbuff_cache_size);
 
-- 
2.41.3


