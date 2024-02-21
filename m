Return-Path: <netdev+bounces-73540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA7B85CE6D
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48071F23031
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756A42E632;
	Wed, 21 Feb 2024 02:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/0bbvJt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A51D38FBA
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484303; cv=none; b=eSndfmzosCq5ZUuZgRt+TQfgMgTfFJCyQ+N2r6Enwo1i90gqhoLnyw9mHLmqovb6/KzebTN3bTnZp5LkzniulvnXuAuppzogf6iBibGzhEDMLOffwDF2MBmvX8yY95YzHbeJw6sqas44o49XOpLNgXNwS2GIM25JLCY5RTc5vI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484303; c=relaxed/simple;
	bh=UHHLE49iooiHY4vjPey6O8XYNle73cZCqSAhyE+EDP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vx9yfsYPKJ/YQ8hRdWPM8APLfMaN38ZqEksvfn9uHuY9ZczH4M7k6j7trWEYIjj6HkZ5wSfrewmRe2ucF/yt+aGoxnrzgZ603gKhGvU9+p7Ja7mh8/hBWpsztzSd+eguOQ5hji9N7xsS5YPzrsy7IZny9vobxENso/TsiW9BfgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/0bbvJt; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29938dcb711so2836005a91.0
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 18:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708484301; x=1709089101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQKphae6rZS2OgxQEvHNL6uRp2pRDqwCrN9aul+Noo8=;
        b=f/0bbvJtMFYXX+xIJEWMO7TFG64CyiNfyPdAeVwiubryn9L/2slQzvwmMhVrgsDTE4
         4WTGvSaaPxK5Tve/dbe/nfKvYP2eMtjsXpDjRzMBjvZv3bR9A3qMLiPE8VoGnTNxhjiq
         EQ/ubsJ4Z7CvJHsxwz15p2i5liU2UICz5kZMzVaPSNqUcKbkP+aMfe2pk5HjIzDU2fqi
         6sRLO35GCJlZfEkmFS/S/cuITXgK3g80HlJoVZl4UssOA0oMtzJdN5xebxk1j28dcKVp
         2DZpN+oeyH+ViQCbiKEelNIKmfCDaVNcNvbbmMK0zd5VH7EQhkqug7T3iB+EwHqLSZxz
         RJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708484301; x=1709089101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQKphae6rZS2OgxQEvHNL6uRp2pRDqwCrN9aul+Noo8=;
        b=lpcjgQAtk93D89ig+HY5VsWERt+Vr5p6YuSVaO1lvRJJF6s7kNBpa0Ba/LqdIrD7ff
         aKM8V/UoVMzDOJbmKXIbagqmtJlu0FN3VBQXKBzEtLaRNss/KK3EDSZ/DHsnI4qik7oW
         Z3sFyWPcAKidfG8qNyLJDj4zl7nzCb6LeglJEYeL1n2fxeeokG0knXwmOEYwL1ALxBjv
         jnWrc8RDu9ggFUWr/AFz61Cor6d3iH6NbY9igGi8PFMWIS2z69D3O8B6uq1W4Okb0IGB
         hgKD+jJLK14Y6hBn2PZoTsiCbg/2IT1gIXH0LMmFRwMVTv4SHBwa4BL80uvGArVUsrU9
         QbzA==
X-Gm-Message-State: AOJu0YziMbdRoaJXBmJLy81WibVxsM4vayBR8aAAFcEfV+gAx2ZAWFlG
	R/b0YILw4fSNj5trQUpbt2aHN5JZE36oVuZa0jL6d4vPLoax77jO
X-Google-Smtp-Source: AGHT+IEdUv5ClSAAp3qFpgg4nSzCstuUT0LmRw5VqQ5Tl1FE2TD3+QO4U63QIx7wZUIskSN0OQxcoA==
X-Received: by 2002:a17:90a:dc0a:b0:299:33c5:9583 with SMTP id i10-20020a17090adc0a00b0029933c59583mr10433204pjv.14.1708484301538;
        Tue, 20 Feb 2024 18:58:21 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id pv14-20020a17090b3c8e00b0029454cca5c3sm426467pjb.39.2024.02.20.18.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 18:58:21 -0800 (PST)
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
Subject: [PATCH net-next v7 11/11] tcp: get rid of NOT_SPECIFIED reason in tcp_v4/6_do_rcv
Date: Wed, 21 Feb 2024 10:57:31 +0800
Message-Id: <20240221025732.68157-12-kerneljasonxing@gmail.com>
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

Finally we can drop this obscure reason in receive path  because
we replaced with many other more accurate reasons before.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
--
v5:
1. change the misspelled word in the title
---
 net/ipv4/tcp_ipv4.c | 1 -
 net/ipv6/tcp_ipv6.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c886c671fae9..82e63f6af34b 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1907,7 +1907,6 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		return 0;
 	}
 
-	reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (tcp_checksum_complete(skb))
 		goto csum_err;
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index f260c28e5b18..56c3a3bf1323 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1623,7 +1623,6 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (np->rxopt.all)
 		opt_skb = skb_clone_and_charge_r(skb, sk);
 
-	reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
 		struct dst_entry *dst;
 
-- 
2.37.3


