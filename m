Return-Path: <netdev+bounces-74804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E84578668B3
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 04:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CC9281EAD
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 03:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D8314263;
	Mon, 26 Feb 2024 03:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWnw7kbn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7554517741
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 03:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708917776; cv=none; b=J36yBVhK3uKYDcb+G2ZLxwXoGlfAT51FqALD2izIP3VR3agZdi3pBBmH+/AL2Dz69+X1jHfXJF5Qze4sG1N+khbEBHBgY1pf3RjsfWaK2GW9Fv8E5VYRa6sMCOzRdzJjxHYET5t+4nOU4KhjGUzhIyhPNU1f1bZ2vzBcMM9EB+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708917776; c=relaxed/simple;
	bh=RTnwmupBOYfKe3zaPNw8b8LZ6kq8GKT/E/SmZKeIaZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N388VYQ18b8zkhM755Ge+3y/g+2w38oMqrF7/hvxqOn0W01TRr4a3T4LjHb+e0f2pF8wx+fbMVkY4aFV2/KGrzIrErYWvuDYik1PZZjSXZnOGvBR67zLS51ywxfehPt4RJjdWwJAY/tCsiddnx9FtTXcB++96J552+WgXkQ6o9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWnw7kbn; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so2733967a12.0
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 19:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708917775; x=1709522575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/qUIqzG6cW/AClaTA+wsAnlXkMG+HDloY0t3WTwDFI=;
        b=iWnw7kbn26tAiOw1R836qNFfXXGr49u25uLhztuLX6vlN0AVWqZ9RicBP78+NA17Eb
         accCkGBbpcnGIIX8UjUMc8CKmsGsyMTUS4u+CaYf9vEuYhJv3e93HvCB99L/Yjpyqeb8
         6HDraXfuR/rIeEYAjGCz2YqUNfx8l11RTElQliVYNitiQPyeQ8+73gyByeU9MKL2vkkn
         wdVH1Nac1hB3UqmXM5/gu4bFtsXzycAs3P0Q4wJi0rk1002iU1suhacPCn1/Z/4A7Scp
         y1JDAaiyp4E1fikTEbwFwjN7hvePjWg8YjDn9QJnbiwO8C5oCGeNxJ7DqhdghfygBVIV
         OfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708917775; x=1709522575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/qUIqzG6cW/AClaTA+wsAnlXkMG+HDloY0t3WTwDFI=;
        b=tHqnDxSvdCrdtF/ct+Qe2An9hZzvu+neFMJbIsOIR6ntmpbIIAp0ou0pVa8tduPSxl
         E+bcWljMsPUcMvYsIkCaTZrfGIbDkbUFlmpLeXvw7pN4JysOW+q80QCax4PwKi5he28t
         n0PkwzgNTBaEiHxMG/ZQ/mHk6mmcOiLrngCDxD34Itii9NZsiJEA/f5YrnaN1vvJYF2Y
         7LJh+Jpb1hYUzaJmFaE4+3Utj1LBtjU7z9kmIQifdV+LC+xwn/jOjmxl3RSYETaG/ewT
         EBCghVhwKr7wS6TDE5Isk9SStaVvhvIrw73GP6EpH+/Ju/0mesUhJ0hdsy4pHWI61ucv
         PZNw==
X-Gm-Message-State: AOJu0YyAgJ5mYGzvtvgnc2KOPxR88IREX/Cke58+DkPJOwjn+xvmi+OU
	ZDqvPp51GBq7kyg+z4p9+JjhVVSoOKswcstZejM42PNqmjpCQVXSDxfsjY+9Btw=
X-Google-Smtp-Source: AGHT+IGAjuCX7Y0cMm3BQAo7wpJ3L2JlOFV3caELXxV4lC6lUxUPrUZzcIS2l5mlsSWbIrDL7EBdJA==
X-Received: by 2002:a05:6a20:6f02:b0:1a0:5841:669d with SMTP id gt2-20020a056a206f0200b001a05841669dmr8164717pzb.39.1708917774754;
        Sun, 25 Feb 2024 19:22:54 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id fr12-20020a17090ae2cc00b0029a78f22bd2sm3262521pjb.33.2024.02.25.19.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:22:54 -0800 (PST)
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
Subject: [PATCH net-next v10 02/10] tcp: directly drop skb in cookie check for ipv4
Date: Mon, 26 Feb 2024 11:22:19 +0800
Message-Id: <20240226032227.15255-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240226032227.15255-1-kerneljasonxing@gmail.com>
References: <20240226032227.15255-1-kerneljasonxing@gmail.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
--
v9
Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
1. add reviewed-by tag (David)

v8
Link: https://lore.kernel.org/netdev/CANn89i+foA-AW3KCNw232eCC5GDi_3O0JG-mpvyiQJYuxKxnRA@mail.gmail.com/
1. add reviewed-by tag (Eric)

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


