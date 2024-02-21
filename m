Return-Path: <netdev+bounces-73531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1096385CE63
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8111F233EB
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6153828374;
	Wed, 21 Feb 2024 02:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ct/3DKpR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27842B9C9
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484277; cv=none; b=E+keuuEhg1/NWYQ1Jtkv45Nqj6wGE2zNOwavxhb516DzAqG1lNRNJsxVn2iq5b0Z5H3cGPvi1VGJywIa6PwsC+ixWpV0EqD0r3i1oPIbnc1tbol201M2C2quHnzW3HmmGL92nEAja6xRuSjgy1RXaX0hluDxjJWY7XcrU5DTCFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484277; c=relaxed/simple;
	bh=KO/Uq3mQO1XJraHniwlOFBC7zFKM07YitqQ2YemP8Lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CP6RKFiu+smJyIGjw3t3DDyZ4km9qcgNneDcHUwSPwydsx2AwDtrILimXmxxSQFd8eZW4btPahyRDja4m8YufXv3lacwvSBbPGQSvfIeBbombTYNWbARAlTNTD6szgY0nIkH8hG4zALOLfFHER0vXSn4iZSlCAIL4nHtF85GHfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ct/3DKpR; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so4957145a12.1
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 18:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708484275; x=1709089075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jw3x8jQql+RYLB0UOson4PrcwBBf+xdErE/3o1PQt4I=;
        b=Ct/3DKpReJL4WOHoYNel+G/bFkjS3PiUrxsnkQ+Za5eLrIOOcG6dliFNvU0jp93J5h
         A4hev7FdrqikyXas5OwQAAkA1Wvu6lOKYVQj/Y9Z5SQsh0dJAjKxCZvOyPOb8Z3W2UTI
         5bBT2R+zeQFY/suSu6tmvZBxm/2TR4uICdSAuuwHt1BysOtqJb6gEf4lh/S5RU3xWgBo
         snlAEOdPTRw3eVDXuo2oh+yxBgj0PFw2VDkF0faAWetrGARiBtTTKHULiRNv9AmKxqKg
         P5oIskdIjMWWKvGgbSW8ZQvrJwYbEjrBGZ6RxrAVLJFy9mh1+hzW9upteIn25hRj3hMR
         VUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708484275; x=1709089075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jw3x8jQql+RYLB0UOson4PrcwBBf+xdErE/3o1PQt4I=;
        b=Uo3I/juDXS5/X/XjeabUiVBvspDrInMS/iX/0p/6ADOp3DVbpp0tGgUSMAdWrzv3uK
         9siDhsUzy1W/ga8tJYW4xAj5fm4ztD6ThEkALtQVHn+mYbbU88fAlsIl/g2l3sCeujzr
         dzTYPP4tBCQiq5W5TaakXb9VRjLJFb/8kfgjxLOA8QzEMtwTqkELvyZYR1BwLJ6GV4dD
         gE2c6yG6GpJMwf3Ibu7BlR6UyLN7JRn/UBFM9IHrx98zK9LZ4Yxv4zLjD6zE1mjjJRs8
         PPagFCAgTRbEXUTjoX6nY7M/KzfWTKNz9OmauqDzWxYvN4Z9eLA7qlxZrAtA4aWtLM0G
         hdhQ==
X-Gm-Message-State: AOJu0YwB08+OgQN8zWB0dGEhL+mdgRuxEpRE+Yw5peulJ/tCN6e4yX72
	sXhHWmGQB/d3S5ypHp4ZE6u5CMyCzGaJNJksaskibqKOKeasqNX/
X-Google-Smtp-Source: AGHT+IFIct7uc0+1D+6K1Yo2IEaKrjeScsssJjE6/HG6uIbgzHtnsEMeyyRzRo55poEfPnMlKtD3bw==
X-Received: by 2002:a17:90a:7e16:b0:299:b35e:84a with SMTP id i22-20020a17090a7e1600b00299b35e084amr9166372pjl.13.1708484275197;
        Tue, 20 Feb 2024 18:57:55 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id pv14-20020a17090b3c8e00b0029454cca5c3sm426467pjb.39.2024.02.20.18.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 18:57:54 -0800 (PST)
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
Subject: [PATCH net-next v7 02/11] tcp: directly drop skb in cookie check for ipv4
Date: Wed, 21 Feb 2024 10:57:22 +0800
Message-Id: <20240221025732.68157-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240221025732.68157-1-kerneljasonxing@gmail.com>
References: <20240221025732.68157-1-kerneljasonxing@gmail.com>
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
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
--
v7
Link: https://lore.kernel.org/all/20240219041350.95304-1-kuniyu@amazon.com/
1. add reviewed-by tag (Kuniyuki)
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


