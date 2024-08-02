Return-Path: <netdev+bounces-115295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF97945BEB
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 12:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3C11C213BA
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEB81DD3AE;
	Fri,  2 Aug 2024 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQEa6q2y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E9F1DD38C
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722594102; cv=none; b=Tlrt3fyIWOUnWzmXK0h3wjNcdRrru48vcvMUJ2OWAvz2vF7dmJMibvcH/R/1KUM7DgHZhmsZv3sJB5N5zvtdIgM0NDrp7HeFv85FjadLeDIOu95/ofrvl68ExiYH5Tb1nTMYrUPrcTiuZBhxDL+j79Bkrg5W9NEjmhEgPdlCqeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722594102; c=relaxed/simple;
	bh=8me7hWGnMh/VI+UQkp9dSUxUyotRWeAqroXVQfOCJqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oTbXWtPu9Dsdfp5MJ0Cza9W2JgDrOKLTQn4ayPvtgfxNp6Nyhs8h2w+oVFe9iHezHmpamAYpFZdV1QBt/uLeAyHIi1tguIhp8vKyskpszAJqKsGbkr6UIhAgy5pBEXH1sp26bBH5An6POIZ5jk2HydAU452B0jUV4FuZNRbVf9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQEa6q2y; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7093705c708so8162809a34.1
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 03:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722594100; x=1723198900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+NqjpnrLZwyJlHFfnhFSzF8pukIZ9OTEsJHNfMKwUQ=;
        b=PQEa6q2ymYE0Fs+1DGvYR4DH0K0VdHCP9kciflB/PHHq4iBqP+lWO5RW3FS4CWiyf3
         5bqRG8pydFr+1xg2qiUfZLisGFbwlh8CsmIV25/JqMc3H9YeL90aUDFeeWYObaRZln1s
         xlokCCQYHrUKkk2wrif6JGoYzncRYxJ7dEymhwyGbfQvERIKTs2fYHzGsLyzlvo6veR9
         3cVRbOtfErAhzXijD6pAhCEB8AGLnmhM7ihkq7FJJdXYadgbNqdScmS6eeABRtrUgZaA
         I41iNHKsOaqM9ch4ohdMC0brIQIeIVFcmraZvKpSNklyN++6GlRzqM1TBl2vmPSh3QBw
         X3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722594100; x=1723198900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+NqjpnrLZwyJlHFfnhFSzF8pukIZ9OTEsJHNfMKwUQ=;
        b=aBhnHv58xVlu3hgXN5O9f7XYL5tmkbdkY0GT6hVOc7DqpKtOJ/SS6YoZPMwMVoBZyJ
         aqiKv/ZqnduLBdLP30sAd26oC4sSTaOk6KOMkOHff1s4/t7nlWMrmyHKXar7LCmE6tkB
         Y1ohWTR+j93wfIZx8PzZaqdFEovQ+O5XBBPEaJ8jEwm9fHc6fpoYnAhOeDPdBuQR0XdX
         Br72ojibdPVG+rvU8eheJQO4iF5ZsH1K0+/VtZF96p6AEwppZOLGd9ikXndqYTJ/90Au
         aQHMU3zmUT4PDoZa/ohUin0Cu/PV6BrhcXkUcdRuIKlb5oJxa6ZWluA4Y6Fn9WYHM1KC
         MKEw==
X-Gm-Message-State: AOJu0Yxafm96sLEisJGoC5jMKcIFvXMq0lSNGkZA8aqvp5r2E1rENF7a
	2DwE+EzRa3pKleT/9lrGiD9R/MF5SLdkgft2xfxtLWlG204FUrH/
X-Google-Smtp-Source: AGHT+IE6eZi93fKtOkzS/4J34wbHFwNuRaECCzbFVcHBmYwOxeAW9/eZekHepDUmtgb7hEpV2qN50g==
X-Received: by 2002:a05:6830:6dc5:b0:703:6311:7798 with SMTP id 46e09a7af769-709aa00b761mr3939285a34.5.1722594100338;
        Fri, 02 Aug 2024 03:21:40 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b763469e79sm1109050a12.26.2024.08.02.03.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:21:39 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 7/7] tcp: rstreason: let it work finally in tcp_send_active_reset()
Date: Fri,  2 Aug 2024 18:21:12 +0800
Message-Id: <20240802102112.9199-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240802102112.9199-1-kerneljasonxing@gmail.com>
References: <20240802102112.9199-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Now it's time to let it work by using the 'reason' parameter in
the trace world :)

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 16c48df8df4c..cdd0def14427 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3649,7 +3649,7 @@ void tcp_send_active_reset(struct sock *sk, gfp_t priority,
 	/* skb of trace_tcp_send_reset() keeps the skb that caused RST,
 	 * skb here is different to the troublesome skb, so use NULL
 	 */
-	trace_tcp_send_reset(sk, NULL, SK_RST_REASON_NOT_SPECIFIED);
+	trace_tcp_send_reset(sk, NULL, reason);
 }
 
 /* Send a crossed SYN-ACK during socket establishment.
-- 
2.37.3


