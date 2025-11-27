Return-Path: <netdev+bounces-242208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C79C8D760
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF4E3A9DAA
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 09:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACE6326D77;
	Thu, 27 Nov 2025 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEuZyDV+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963D132693C
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764234884; cv=none; b=eUr18iuTb9VXqSLct6yufgt257vDm9e30VgtFw73HmIHSLgy+xpgUcMijznK0l3woThlnVt8VBzbOpl6P/ga9cGkpeg7IWWziRNVzlEX2fxl6A/c3CI0veZ2d7cu5exVNRmsjAuPlu1D0tvJMV3O/2t0TwxDV5Bq+/ZOdhXVqoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764234884; c=relaxed/simple;
	bh=1CZu/EdpV8PmrZ/9MJ8Ck3qacqA+OvGnCwc1CmcaKSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWmNvTcejRRuD9DPeHj7LSr95bo0bK82Lz0GYHpKvPDxtOOoR8AEIcOHlcIQiwbRPeVXbAsEnlksdqZBo+8AWoy0shjR7veiM4YhL6/hkFO5eUYAEpA0x1OO7lqZR9isdn5YpKB0LKmD8Bni7aaV7/YhUArGBK790+IOIzu42sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEuZyDV+; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-64305af3dffso85967d50.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 01:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764234881; x=1764839681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENEdETDWcTBseXwQg0tcyt9J65YucuzpqwchphRcKzQ=;
        b=GEuZyDV+/MRYV3HH/X2WdPnKc2B4rS9ctkwy7qm7FizTcp8HZ9Nf6xgSgdkK0neXbu
         SgU5JOPxBpMcKS9nnPXoYUbW8Xhr4dEYqcdyon7raXa39+smzSb92c0dpmQjZwtrl9F5
         SGuOhfQeGV2C4sjsU+gvs/GKjMAzqvqVp5+5HB5Yas/MV2mP5PcIwFnO3g96jz/627k4
         mEr089OawDHdfIdQBdSynsVClFXieoA1SebfSndY8MDq2BSNmV+JqtLCq0/hMQ8uqHY6
         Xhxmz5WldyJLEyQl2eClFcGQihFvFMXvTUzxygJ8a1vSR8FbxOzmFJ80BKI0ufiScWJ3
         UVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764234881; x=1764839681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ENEdETDWcTBseXwQg0tcyt9J65YucuzpqwchphRcKzQ=;
        b=gwMFaZ5Z4BIs7+I12VBdeuI4OD4oD4vUtSWGJaFvOPOMYpROxcnfdDo2UokIzldECJ
         I51TBqj1RMUOkQ3lkN4vXfXJldJW0SOnS1MNR5sDj/5xqDRvoXsh8HHQkUVpAhLwdfKX
         HX7lQItGpi64LG2UEr/RqpIhB3zG23Osl4g1u0mvVRh9SOf581DZHwcdTgaFIvo8/Ctw
         t4bMWaUilVUgMfb6oc6uoub9jXtcZ0Ne6bTA/WL1TnwiziRKvCQJRkoQdpp43pv8j7E3
         WWbQbOG7h3zZTqku60/fldIj9/gq9i3sp2H94WfyCzLxZBoBk43KVY6aUXk0g+kteQJY
         wvzg==
X-Gm-Message-State: AOJu0YzP+SO+VyFVwqvFQTQ+f6FaAQHcSs7zOOD4/pFzabZpxwyYGzwJ
	cxztTRubQ3YTxOgb0sRNXF4otvzsEhSMSxeVLH5w3IxY0poNkXWacnVR3B7z8zGe
X-Gm-Gg: ASbGnctCAajFT3kNn0rPS/x2Qk+JMUL9ofsbD0psyRyjXAaL0bw/IcAEajWUUwnTLNf
	t8fe/rK0nxbNpsOGcoDY0dslaxhY3hI/UynvPfZOB5rEhDZmRonVvlDL5wHsADI7bLUCdUYopyT
	qRxcNBJx/uYh0MYrET/gCBTifO4G1gBVpCpdHEKmrvxwjNH1ZpW/8g3ce6bgR/+O31eJs1mPW+g
	A32wt8RoMMmyHeES/QQvalKiFepFqOvJI4lOFD27aysw+rMSQxeVVf2bi/cVdoQk0ZI8uw5RUlL
	Sc9BM73/EApXvEzVsttPp95JiPhfGPAEAgzppGbbuvrKaSw6ixbqkpTXyZLdTE2v8a6lVrn6vR0
	MhANIu3hfkWOaIR/rQxp4iJxJWVZy2uWyIG/FsBNJ19M8AHurDCWA03q4HSlSSizZ3pMJipUWoK
	BdJwwQuSYy
X-Google-Smtp-Source: AGHT+IGKsaxwKEPH7G6tZqBJ78Jnouxp8TMovNkEKpbtyfYctxsotYQEDctwQIaLOnrwWAbItyoW3g==
X-Received: by 2002:a05:690e:144a:b0:640:fbf3:5f9a with SMTP id 956f58d0204a3-643052d5a11mr11458567d50.5.1764234881429;
        Thu, 27 Nov 2025 01:14:41 -0800 (PST)
Received: from localhost ([104.28.225.185])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0d3f5bbsm3796167b3.7.2025.11.27.01.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 01:14:41 -0800 (PST)
From: Mariusz Klimek <maklimek97@gmail.com>
To: netdev@vger.kernel.org
Cc: Mariusz Klimek <maklimek97@gmail.com>
Subject: [PATCH net-next 2/3] ipv6: remove IP6SKB_FAKEJUMBO flag
Date: Thu, 27 Nov 2025 10:13:24 +0100
Message-ID: <20251127091325.7248-3-maklimek97@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251127091325.7248-1-maklimek97@gmail.com>
References: <20251127091325.7248-1-maklimek97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes the IP6SKB_FAKEJUMBO flag that is used as a work-around
to bypass MTU validation of BIG TCP jumbograms due to a bug in
skb_gso_network_seglen. This work-around is no longer required now that the
bug is fixed.

Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
---
 include/linux/ipv6.h  | 1 -
 net/ipv6/ip6_output.c | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 7294e4e89b79..9f076171106e 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -155,7 +155,6 @@ struct inet6_skb_parm {
 #define IP6SKB_L3SLAVE         64
 #define IP6SKB_JUMBOGRAM      128
 #define IP6SKB_SEG6	      256
-#define IP6SKB_FAKEJUMBO      512
 #define IP6SKB_MULTIPATH      1024
 #define IP6SKB_MCROUTE        2048
 };
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f904739e99b9..9af9ec6bdb8c 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -179,8 +179,7 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
 static int ip6_finish_output_gso(struct net *net, struct sock *sk,
 				 struct sk_buff *skb, unsigned int mtu)
 {
-	if (!(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
-	    !skb_gso_validate_network_len(skb, mtu))
+	if (!skb_gso_validate_network_len(skb, mtu))
 		return ip6_finish_output_gso_slowpath_drop(net, sk, skb, mtu);
 
 	return ip6_finish_output2(net, sk, skb);
@@ -323,7 +322,6 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 
 		proto = IPPROTO_HOPOPTS;
 		seg_len = 0;
-		IP6CB(skb)->flags |= IP6SKB_FAKEJUMBO;
 	}
 
 	skb_push(skb, sizeof(struct ipv6hdr));
-- 
2.47.3


