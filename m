Return-Path: <netdev+bounces-71381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCB6853223
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61ABD1C22597
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D8356468;
	Tue, 13 Feb 2024 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKXh3ffD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580EC56469
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831760; cv=none; b=JOQXI6RbH2QoWjTlOjkICBbMWpyM+WbKwB734Z0/YDiSX08/oBK+OMhGKqqkrUzq2O016P2MJrxwei6fzga4L4cI5FI33wy+pWkLGrvOMNutRFvlUsHpYcNoUmi3UjzryCPnm858S+Mc+9V9rms15MHsXZi0E9AitO9HmsKsGHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831760; c=relaxed/simple;
	bh=beTa8kvuVAR1xuuwoOtkmKnK0Wn7xIsrcdGr8CPSjQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NP0ftC7/UdxQ/MwyXQg2K1m1PzQ1cX3p4ycqUmK8/58cWnfgei5SwtB6iyqILc+cCsRiu0lI1YohzwXq9NL9wRCx/IGmwN8c4IHwDK/2gwYkmmm1xr7LGNw0SRQ5upsbJfnzvfpEkzIA76h/ZgWfjm2XWovQAn3ohmYZ0S2Q6vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKXh3ffD; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e0dcf0a936so1056456b3a.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 05:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707831758; x=1708436558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiHRSiDQCWhkRJWyWtx70sVdTRuKjyaav9BVyuxi7cY=;
        b=fKXh3ffD+IAyykMZq57xpefc6s3dd5g62ChJUFasxFEKMWWGYiGPfSBwKRImuDu/B+
         nqhKgianxBrxgXsThPdzLk5ERuKtEbaMH3SKhP6wVT9gTCu96py/xtQwyy1hFLS/a4Bj
         z30uPOzNr70LsV0CWzHYYmT8xizQuHPQW5XpSMLBDHeavmmVfnI1UR5qJ9ikMRGimOZE
         4o1Byjpj9sP5x6GUZWbTowv47xCvhducuokQitCTRM880y18K51rUnAOx44fkYrQFmJP
         iyXS1RztvXzyB/DbIrzEw6JnR1DZvRXkxoDlH6pjWv3Pd+B0Jl6kUH7oSWYm9DuzujgF
         J6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707831758; x=1708436558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiHRSiDQCWhkRJWyWtx70sVdTRuKjyaav9BVyuxi7cY=;
        b=XIc1C9zVSAwI5xBnnmHgKvtM5oj9p6AvAU6EW5BhSbn6vGXW2scNux6f3LUpZnSTVU
         ZRlTuPuROaK6ndhmD8lAwH8VWQ/YcImZo2/XYTnn4jreDM1tEovOXUOpw8Uc+zjm3pci
         m1os40aDJpzRB+63yiKYgv8EEdzgRiAzUmcZBXXQC9wqeRzdbyukZt9tSXfNEi2L+DW8
         d/NmOtxIEwZFncidX+jxzxr23s1J/8/v2gTYRNzEL5vkWV9w6yXLbUryaYbzsGWgwbpY
         m64dUTEZs113+5i7yx15HzEbW6Jx44nGn0OcLLrgjbNZUpDr9DHZsotV3HOJgCSlt/+r
         4byQ==
X-Gm-Message-State: AOJu0Ywi6thEOeW6Q+9hwQWorqK04mXJ2ISQVvmt+6vAd65YoVbpNvKv
	vs1HnUIN3H0y53l3Pr0wqsTB+MDZZI9whSTPKEHUwpufIEYYkKJ5
X-Google-Smtp-Source: AGHT+IFL+I8JQdX4Nm0I0xRU89aCCRBFUN+VfKPg0jli3Jhh7gASrBfVrypvaFA/UGPYi8Kw9xt90w==
X-Received: by 2002:a05:6a00:1394:b0:6e0:4e0f:62a8 with SMTP id t20-20020a056a00139400b006e04e0f62a8mr3446952pfg.2.1707831758563;
        Tue, 13 Feb 2024 05:42:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8BAGSWh9y5v/bH/d3rIvh3B1fBcwlMVb6gkvmrmdSUtjk2aYfGLG4aRXLNtdHvLhzo+U9X04c+CPNb/wwmwPew5c0Z3NCjLDcgyntXhv6CsMj7PM8Htyy7EWlXPBp1Rbf+dxiCVTnySjOI1+F+t2YV3NTqMBbul6ufzwec+lRj3DziFsl10aUIWf845fuN7fMLQ3EiwJ5kFh/oZ7v6ee59p8j2uK6x140LEfGlJTNt9I8m1ejBYn/NmgMOGAcJRQt
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id fa3-20020a056a002d0300b006e042e15589sm7323041pfb.133.2024.02.13.05.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:42:38 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 2/5] tcp: directly drop skb in cookie check for ipv4
Date: Tue, 13 Feb 2024 21:42:02 +0800
Message-Id: <20240213134205.8705-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240213134205.8705-1-kerneljasonxing@gmail.com>
References: <20240213134205.8705-1-kerneljasonxing@gmail.com>
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


