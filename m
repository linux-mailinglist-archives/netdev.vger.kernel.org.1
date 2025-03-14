Return-Path: <netdev+bounces-174832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EB1A60E51
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 11:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2B91B60A5C
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 10:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7241F3D30;
	Fri, 14 Mar 2025 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KwvWjLAk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02CA1F30CC
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947064; cv=none; b=jjyXtAxtVKZmLoJH+LQ8jdsFruGPa28s7YC0wzxyN1X5x20iwtwAXgcGO8ikQZ2HI8B1YRpimqbJzMLpruKxDb984QFxcDDgHA2AZ5dS5Kfhy4zc4BjFAwxR6AC5yKgur2VcrRhHnNHtcSWNUlKBvy1ofzFgj910i3yaP8lrQvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947064; c=relaxed/simple;
	bh=Ha/KS+ElT7WtLbHsW5QrAN3KE92/i3cgTDDDhR21CLo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ScsgP44Us6OadogCiApsaAi+yS5OVqY/6SSLiu8vH89hDyiv644kR4UkfDPLL0k71BigSt3KoaIuBad/P3XUZNmMHJpZlWidLhj9ZXCcsu23e06J4wKkQbd1131OF5cgDTMIbLqYx34CB0AwNfBTwNLtcCIY+f7aX1vPIAN47w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KwvWjLAk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d0a5cfd7dso12723355e9.1
        for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 03:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741947061; x=1742551861; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fgud6hXh4dOzT1nJ8XNwGdjcgEPK4Gm9tj6MEJh365U=;
        b=KwvWjLAkJF2owAbDh6RxStqsWNxAWm4zXCtDa/+eAte1WJWGZ0wWbzWh0IZNw9gADV
         X9V3ykoqf/7sVGAidnQtRcDcYQJ2Yp9YR4utvqaR/6gXQyX+FlunGGbYluf/uG+/ejOr
         h1hF8P7C5YSz0x52hVeJf45czACkFuINm103b9LyJo75GOeKW1Z9eU7cpyRrpQMbRSFh
         Mi0g3kTdGDZSISHFawFuhqBXy4l1yyXgcHx3X5dZjYxpeefbHIz2NQq898Q30OjSBlkG
         0V1zNCXDPH3yxJpjnGI4B+J+1Au1+Q97BnEL5dKgJ+IqtkmvcgwGgDaSD21pxF9jNSY/
         DeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947061; x=1742551861;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgud6hXh4dOzT1nJ8XNwGdjcgEPK4Gm9tj6MEJh365U=;
        b=oARnV8/UAfYWaF6UV842qiFLaX1UyebbWTf7ldi8WFB4ZYkqipaQupwKEjCD9hzd0E
         EZbXRRNBrz6Q2qJa+bqVM+XI9t7C+Lsx6ORtrnCpXkTFDJOZdlC9ZbnmRFr8sf8Qje9y
         rs74elQkoBeOrablNsdlNicxESszazrwXUVGWG35NF/R1OaSMHemjpx90a4f7Yr6T+Kd
         uYh8mIZOzLRsAIi93+XhPM+inmwD9L2Hq9LBK3bE8TjQdDC/AkW4AV3496Z//0FtQRxL
         uafIOTYBo4rfqocmRRparwaxXyxlpRyGhaJ3DE4sLxGIHTL9+9y2tJ0xB0Ni+TmA49zk
         GwoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXepvvaJDID+yNXrgi2I9DNN8jBbPdpyx1QDxBZDXKxedHAyY+FvY5ydO5lrdbhHAMMNnxoCmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6y/3PrONWpEYLX7PFr/aFa8lTl/0JikUMHNySgovDkQSuycei
	zxYNYtQXSXYXUz6d5Xs/hZgrqYDHaHqp9oMtG5v+qExackLi06IBdzvnV+MsZOE=
X-Gm-Gg: ASbGnctVwCRZzmgN+GXFUzKZ0r/JqPt2vOk3Fz/0zeQpdGEihD1SYUVHuFFDcBqc608
	JOfwoeGiyKDcR6oyOxlukBXfFpUOjC4sJGWJW8r1juuigwAr6bnXXlgP4sXUOAVS+qdgLRIK7b5
	J7DqKisp4VtbLPCqbPRedufaAwhZrDZj3P9yL2i8RgkGi3GQWVuCJ2i5Gynxwr/55jurO9b59nD
	JF2BF1vGtozM+m/oyVjFUmFE/ZJKJsMjMXnFgskJqjuajjpEy1TC2TR1fEjk9Bw0Lo/CDaRU4Xw
	3YRVa2jbVxEYP+XT74mm7x1GRxne6lCuJfjnN7HTspI351lElA==
X-Google-Smtp-Source: AGHT+IGrqsA9/IFFX+VNcSF8RCUcUm/rFalF5L0nX24Ys1wiCIc0uaBlGoiwZeDMhGOrmCUK6wBs1A==
X-Received: by 2002:a05:600c:4fcc:b0:43c:fab3:4fad with SMTP id 5b1f17b1804b1-43d1ec80ebcmr26365605e9.16.1741947061151;
        Fri, 14 Mar 2025 03:11:01 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d200fae4asm12118455e9.27.2025.03.14.03.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:11:00 -0700 (PDT)
Date: Fri, 14 Mar 2025 13:10:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] net: atm: fix use after free in lec_send()
Message-ID: <c751531d-4af4-42fe-affe-6104b34b791d@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The ->send() operation frees skb so save the length before calling
->send() to avoid a use after free.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/atm/lec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/atm/lec.c b/net/atm/lec.c
index ffef658862db..a948dd47c3f3 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -181,6 +181,7 @@ static void
 lec_send(struct atm_vcc *vcc, struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dev;
+	unsigned int len = skb->len;
 
 	ATM_SKB(skb)->vcc = vcc;
 	atm_account_tx(vcc, skb);
@@ -191,7 +192,7 @@ lec_send(struct atm_vcc *vcc, struct sk_buff *skb)
 	}
 
 	dev->stats.tx_packets++;
-	dev->stats.tx_bytes += skb->len;
+	dev->stats.tx_bytes += len;
 }
 
 static void lec_tx_timeout(struct net_device *dev, unsigned int txqueue)
-- 
2.47.2


