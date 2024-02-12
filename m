Return-Path: <netdev+bounces-70862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B39850D62
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 06:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130572860CD
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 05:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633376D39;
	Mon, 12 Feb 2024 05:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PczQVilX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD3A6FB2
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 05:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707715559; cv=none; b=p7QEYg6ITox1bLGr/iAjmvoccZnf0rsr3sdIdjxY1be1e6mBgW4ctR+N2wx0qvFa2CDG+XaUo+M1PWiAcHK+kPcYkG71UCPsRLeMCGt+AsHWFB8dHIaDDI8si2bOgBOf1gn58UIDELwnVSxXxvT5dKyVW+e3lViG4UC39CcMxLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707715559; c=relaxed/simple;
	bh=eYcG00HxId5qCSyCPor9f11Ao0XyPy9N2cF4K2RNvrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MObl5L0A5hrrHaRGovmYl0E7hR7ZmuOa8e0pnwonLRbUoTVKbT/PWKHsBnmjJ5rxphg8lcS3/ykh9CQs79EneHG7kjt8P3GqNgA3B+SibhVjJG9EjDpD+jLME91vPQGA7V/xvkFH3ztgMhucX9qMLTXsP9GnFCzgNp4KNlERaSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PczQVilX; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59d11e0b9e1so1834234eaf.1
        for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 21:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707715557; x=1708320357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrkG6KKFmZqUyW8+kFpwqVtyXKxWI4aCH2q1MB9xVcU=;
        b=PczQVilXYNNgYsKvbGyDuBIchOEbz91hlEZID/UndKSEJZtX5iAJ3oGPx+qbEXclLN
         HcV/pvxFegA2kgGvqc3n4Nz2QHB+X53hRHD70ZUxcug5NKj2a7xT6OMMDDSDaz96dNGm
         Uwl5RdFtkvniFEAQbGfoKxssZXQePsSfFInpGtf4HPHX8NRYt2giZIwpCUqismx5Aesb
         cz6lJue9ycYFT6h+k1KS0dQ6RiPnrpVI12S4+1ui4A1jMix2RDZKN/xav9LY+GX+10ZM
         PHVFn/2bERBfjnn1Vny9XloPBxeGK1xFanxJZmZu88uKtDoBSheva8QnsLcNIMjMQeDx
         LK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707715557; x=1708320357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrkG6KKFmZqUyW8+kFpwqVtyXKxWI4aCH2q1MB9xVcU=;
        b=sNxIxOtCP6WA41lm7Hcd+YQJ0UA88zFmWNuZDK0YrBnynCDBbLlceIPTIP9Ce9sCtR
         ftwfVHOUJ/3vvLUjQ0CaNZ0IzppmYuU/aqPgUSACFh5DNeeM9Zc17WlP3Y885InxKKDV
         qiZ8U2gd/7d4m/WCMYlZ8Ydl5J8zFhcYIw00GpgKqFBQWg1gVQQQcKwcD5Z8RMgVR8jC
         /4GtWjm1OuRHdMC6JmdS3+IZiA9Iz9HFe9h1FtNFU2EadsKy6Z+XVWcMGsGUMEGBPOJD
         wGbNVe4Ycx5C+iRAyM2XHQeLIVGoZQ5tWXdPyXyzRVE0C/SbLTMeFjZaY+gZCqKEejFJ
         cUqw==
X-Gm-Message-State: AOJu0Yx+IP3h4/znbWn4WQ8PYqweZvxy6LOsBfWfnidMZsl/zJ76Bsf5
	lqALe428NyOm4z3SL8p7zS59+EnvqGtX5ynX/+Nv154aUirlHn8m
X-Google-Smtp-Source: AGHT+IE7nlF781/3cP2AEMQ2hLDiraedSpVUoqd56eiwW3vglDP6ysY2FevRR4ng5fIFkiMbadtMAQ==
X-Received: by 2002:a05:6358:d1e:b0:176:5a5e:4d85 with SMTP id v30-20020a0563580d1e00b001765a5e4d85mr7609401rwj.4.1707715556888;
        Sun, 11 Feb 2024 21:25:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVobU8xSi5DZ2fCttIuBg/JPFbWLqM6rf9HPBxsooUp2p5RTyMBBrejdRahHoxVBs5HuSXvQ+UKOl7YOlaDbN2F6TYsbGGT7/SaKucepn0STUYagb11esvd/PP8otUoJ8ggTsflSLPnfTZyEZ9dUc6A/s7l7e6JjekDemSkFYS0ZlHlrFd2IaBJrEB54d9inj9FExdY3X58BGCYG7apzg4pmcU7FCIZRE2sMCfdISc=
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id f10-20020a056a001aca00b006da2aad58adsm4725291pfv.176.2024.02.11.21.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 21:25:56 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 4/5] tcp: directly drop skb in cookie check for ipv6
Date: Mon, 12 Feb 2024 13:25:12 +0800
Message-Id: <20240212052513.37914-5-kerneljasonxing@gmail.com>
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

Like previous patch does, only moving skb drop logical code to
cookie_v6_check() for later refinement.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv6/syncookies.c | 4 ++++
 net/ipv6/tcp_ipv6.c   | 7 +++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 6b9c69278819..ea0d9954a29f 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -177,6 +177,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	struct sock *ret = sk;
 	__u8 rcv_wscale;
 	int full_space;
+	SKB_DR(reason);
 
 	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
 	    !th->ack || th->rst)
@@ -256,10 +257,13 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	ireq->ecn_ok &= cookie_ecn_ok(net, dst);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, dst);
+	if (!ret)
+		goto out_drop;
 out:
 	return ret;
 out_free:
 	reqsk_free(req);
 out_drop:
+	kfree_skb_reason(skb, reason);
 	return NULL;
 }
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 57b25b1fc9d9..27639ffcae2f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1653,8 +1653,11 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (sk->sk_state == TCP_LISTEN) {
 		struct sock *nsk = tcp_v6_cookie_check(sk, skb);
 
-		if (!nsk)
-			goto discard;
+		if (!nsk) {
+			if (opt_skb)
+				__kfree_skb(opt_skb);
+			return 0;
+		}
 
 		if (nsk != sk) {
 			if (tcp_child_process(sk, nsk, skb))
-- 
2.37.3


