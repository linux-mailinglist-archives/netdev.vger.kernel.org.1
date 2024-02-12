Return-Path: <netdev+bounces-70860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E7B850D60
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 06:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BD6286575
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 05:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2FA5680;
	Mon, 12 Feb 2024 05:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ7REjPL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143E915AB
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 05:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707715547; cv=none; b=Vr/Nwa/IB286+T2eImOLrXEBqgm8krrXJCRO0C9Wu80I+50uaqYEDdG6BAknNCCDUkVqtozcSZNZmdOOuqO7Spjyhq/gZ76w24034G2SQCLy/RKo7vU3iwfJ3YtDiSylcwLXBdWvxGUgNVr1GE4Da0QHe5mhrlOSvf2tpnH0jTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707715547; c=relaxed/simple;
	bh=beTa8kvuVAR1xuuwoOtkmKnK0Wn7xIsrcdGr8CPSjQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jgETQ1uNNxCz3RWZtJx9WFbcIpyxQvwzFchksf8hRQpgj7ZLCKZMX8iKGWC/RWF54KZicd231jfH/vTs84W9vUOS3SslRkCb6XuUfrj8w2NigOQF0sIMoRQyfZO4r+YD5v0aUBaP1/+9YA5MCNj4an9giJ1bQDMB8wc7rAcrqW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZ7REjPL; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso2822529276.3
        for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 21:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707715545; x=1708320345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiHRSiDQCWhkRJWyWtx70sVdTRuKjyaav9BVyuxi7cY=;
        b=PZ7REjPL6R/MYBX/uiiplYc94tEuXVeo/xygO8wbrugcySRJq4dYwbF++0v32x3C8T
         UWvIMy8f4V8K29NVzN3gk5uYaloYg1302kRWYcGNs3iN6mPivdQWyuJbx9JfdZYw9p+e
         vVeTxEzq/3eHXLaMZL3V0UNsUVgF0dFVD3Ke6/pxc0/jemrbVQWKMevRL1K8QYTdFflw
         aguV26j7e3vb83vFLp0XT5VqhiPKtsWJpDpcfB4p8TdGO8siy55CeOfBu3xPoHyZFHYu
         FlPG+r/JPJCNIM+U/rE06WF8SQlOzbXCBZXfcT7GEXSPaFghKTtxwwjHXaJ1jWZY5Z2H
         odEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707715545; x=1708320345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiHRSiDQCWhkRJWyWtx70sVdTRuKjyaav9BVyuxi7cY=;
        b=MqUgoyTNH7NpuHx1VttocZS67wz3puy/xFX3Dtb53yObYOP4oQD2UQnv2e7byiiFDT
         2ZZQED6mBHCLFDRyVyS78OGCiPeOScAs2ODvQIWVBbqd6bZjbNSJHP6ajvOehVLz4wNI
         /rqSfik9X78jmriCDQfdN7MPp241yFch8pjtboMQl6w7sH6ub4fN7ioI614ev5fUyNGm
         1OWNX7VoMzC9VePWFBoNtj8HNDbemr+t7CS5gtjIIpU7lKY4UNbeks0QtvkXhh8Umn+o
         UXd1BUaB4rC0iIHXaIv7pOtWCGEVrZeUoxsmk1U0pHoIEHDxC2GvCFJNg5Sw13u0z9Ae
         Rm0Q==
X-Gm-Message-State: AOJu0YxSlF8pCSTX/No9HvAeGrivDUDfCnoxvjva+qNEYFl1Xj3jFGKH
	exw7sWmipeamA+aruoGxVmsjPeJ/ZAfYCwFhLkJxM8SwbI39h1vO
X-Google-Smtp-Source: AGHT+IFlD+6dRsvXMLmSXUxyNVNsK5ZOfXEyEOWie6NsfyqpkCilbBOnwhXTyFWiSH494gI7mTt+jw==
X-Received: by 2002:a25:ef47:0:b0:dc9:51d8:d72c with SMTP id w7-20020a25ef47000000b00dc951d8d72cmr1787092ybm.63.1707715544939;
        Sun, 11 Feb 2024 21:25:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUil0QBuOcyYMcGMtYplP0v5nEQAJ1hEu+UQJdh8vSJbQOwVU+zkZMqe5id2oEjCT4lAJHe+AieOz2ZyL+rfNozrbn1dGjanZChQjAj48av+so5Nlj4n8hPqt0uwP0E6QOEXx0n8dkhJDHvZ1FJd76acghF2C3+UzA66zfk3lyaTeqocvBIw4nHWOv4/Tvbq46Un+yrzialBrYckGG8GTbrWKUIyBeTiXqgvb9SJrA=
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id f10-20020a056a001aca00b006da2aad58adsm4725291pfv.176.2024.02.11.21.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 21:25:44 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 2/5] tcp: directly drop skb in cookie check for ipv4
Date: Mon, 12 Feb 2024 13:25:10 +0800
Message-Id: <20240212052513.37914-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240212052513.37914-1-kerneljasonxing@gmail.com>
References: <20240212052513.37914-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Only move the skb drop from tcp_v4_do_rcv() to cookie_v4_check() itself,
no other changes made. It can help us refine the specific drop reasons
later.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/syncookies.c | 4 ++++
 net/ipv4/tcp_ipv4.c   | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index be88bf586ff9..38f331da6677 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -408,6 +408,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	struct rtable *rt;
 	__u8 rcv_wscale;
 	int full_space;
+	SKB_DR(reason);
 
 	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
 	    !th->ack || th->rst)
@@ -477,10 +478,13 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (ret)
 		inet_sk(ret)->cork.fl.u.ip4 = fl4;
+	else
+		goto out_drop;
 out:
 	return ret;
 out_free:
 	reqsk_free(req);
 out_drop:
+	kfree_skb_reason(skb, reason);
 	return NULL;
 }
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0c50c5a32b84..0a944e109088 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1915,7 +1915,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		struct sock *nsk = tcp_v4_cookie_check(sk, skb);
 
 		if (!nsk)
-			goto discard;
+			return 0;
 		if (nsk != sk) {
 			if (tcp_child_process(sk, nsk, skb)) {
 				rsk = nsk;
-- 
2.37.3


