Return-Path: <netdev+bounces-73956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A942F85F6E0
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499FE1F23C16
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE5446426;
	Thu, 22 Feb 2024 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYMHinVi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1782E41776
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601423; cv=none; b=rfuJENUEAeA3cCPis70YOOi9LdxsKNe+ftQRCspo9252L8vdb5bqgmQgDhNQfWYMjxiuRmibsZDrfleKiWqOwQreIwVnxGCSjf0fcca/Urj3v0M/+Yzn59sT+Hx+fwyFs4bsmBZgqBaqmnF1S4TDmlhfjNx2ju35ErhzYD2fR70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601423; c=relaxed/simple;
	bh=KLYLTXmd94pBOd7bqzFcGZ+fqyclyeE3Uqs0XWwQg/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GFizpivM6mTX9strKnyG169U3OF0AGns75tMwTOC8U3bGbgYmHbnYdbg9epyx97R9SvCJpVMnvsTfmL3zviMV674Rw3lKomDi8dS6+tZQHki69r+cd7lAH/LbD07614iEO1znB1BlvgtGIGo2XJYuZrYiSqB9u3Di0d7LP14lxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYMHinVi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d71cb97937so76863795ad.3
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 03:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708601421; x=1709206221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wi3AtAzF9oVsyxIptdQo85kAQI6nXEbx1Fpjx51x9qk=;
        b=cYMHinVihd1xQJXKAjIZa3eHs0EaouihlpSoV5rJ2gyjgcIO4VGoU+rjIi5FuKQfuZ
         5hq6yZuBwBU/6UrNxTip7via/En1x3ZaW4gNdlNjDx9Q53k+jyQhhfC+5yHao7GXQGwA
         mINJhEptFIas027W/kaUL1J2VuZfw6/efEnI3u3NZyua9nPwCpX5RHnpxxk6fKtHFxnP
         FCjRmUwA/TMF9gkhw7AcDIiJR6ibhUZadztAtJhK2iS8k1uNB6ZLwvv0Qv9WjqaxYtHl
         uFSefu/JTcQXzYqhmmm7m2xzVlgobTjQNbYKvxc9OCz5Ge1EOTZ4vTXiO0d1MOY4TidQ
         jjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708601421; x=1709206221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wi3AtAzF9oVsyxIptdQo85kAQI6nXEbx1Fpjx51x9qk=;
        b=jZB2e/HrSxgm6jridfboOQ8+T+FxSuue+KnqgD7QwvMNPpjNnPFuX5ZmScyy7EVUqA
         JSfezjxgV2XmV4iiSkw/pFMa0lS60nuUTVDPgemUfJ0k25cPwhXvyXRAwyuVf4J7vSGg
         CHRsWv5BE7LFLi2gYpC2w95nzqVcRPgjB3XDNE8jHDmk2ly9EA+FIycIC0JHVmUYE/0n
         3iSqMdKEvLAhHlVe3LXEX15wjwoQVu7ZJyxmuVIj+PwhLfLnCc69wZyUJurSatI30f+K
         XFfaPt2QreciOU1nms7+okW1pWrHYKoyUftoXkSXL4CSpret6o/c6WAyQm5g5B4PHN6g
         yjxQ==
X-Gm-Message-State: AOJu0Yw4kbUStV0gTTTl218vB7kNQ1K5Qj0dcd7AbhBwBBIsAb2g2NnF
	j2Dsl7eNNT0bi2EuLbAtbjq0vBqyc6pMCbUcXG+MWAwqltAAfUKb
X-Google-Smtp-Source: AGHT+IFp8KzQxfpJT311C/zL7EcenE4WrNnbRsrsCgyQ3RNUl/tku1DVLhdF4SPLK2GkO7KvSZT61g==
X-Received: by 2002:a17:902:e843:b0:1db:ba1c:1b99 with SMTP id t3-20020a170902e84300b001dbba1c1b99mr16792479plg.37.1708601421445;
        Thu, 22 Feb 2024 03:30:21 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902a9c300b001dc0955c635sm5978637plr.244.2024.02.22.03.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:30:21 -0800 (PST)
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
Subject: [PATCH net-next v8 04/10] tcp: directly drop skb in cookie check for ipv6
Date: Thu, 22 Feb 2024 19:29:57 +0800
Message-Id: <20240222113003.67558-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240222113003.67558-1-kerneljasonxing@gmail.com>
References: <20240222113003.67558-1-kerneljasonxing@gmail.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
--
v8
Link: https://lore.kernel.org/netdev/CANn89iL8M=1vFdZ1hBb4POuz+MKQ50fmBAewfbowEH3jpEtpZQ@mail.gmail.com/
1. add reviewed-by tag (Eric)

v7:
Link: https://lore.kernel.org/all/20240219043815.98410-1-kuniyu@amazon.com/
1. refine the code (by removing redundant check), no functional changes. (Kuniyuki)

v6
Link: https://lore.kernel.org/all/c987d2c79e4a4655166eb8eafef473384edb37fb.camel@redhat.com/
Link: https://lore.kernel.org/all/CAL+tcoAgSjwsmFnDh_Gs9ZgMi-y5awtVx+4VhJPNRADjo7LLSA@mail.gmail.com/
1. take one case into consideration, behave like old days, or else it will trigger errors.

v5
Link: https://lore.kernel.org/netdev/CANn89iKz7=1q7e8KY57Dn3ED7O=RCOfLxoHQKO4eNXnZa1OPWg@mail.gmail.com/
1. avoid duplication of these opt_skb tests/actions (Eric)
---
 net/ipv6/syncookies.c | 4 ++++
 net/ipv6/tcp_ipv6.c   | 5 +----
 2 files changed, 5 insertions(+), 4 deletions(-)

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
index 57b25b1fc9d9..0c180bb8187f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1653,11 +1653,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (sk->sk_state == TCP_LISTEN) {
 		struct sock *nsk = tcp_v6_cookie_check(sk, skb);
 
-		if (!nsk)
-			goto discard;
-
 		if (nsk != sk) {
-			if (tcp_child_process(sk, nsk, skb))
+			if (nsk && tcp_child_process(sk, nsk, skb))
 				goto reset;
 			if (opt_skb)
 				__kfree_skb(opt_skb);
-- 
2.37.3


