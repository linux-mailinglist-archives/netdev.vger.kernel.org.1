Return-Path: <netdev+bounces-73954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA0E85F6DB
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD77C1C21293
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ACD4596F;
	Thu, 22 Feb 2024 11:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWH5cNfC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B3A45954
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601417; cv=none; b=AuZyPbMKInKX6IzBrVCKMlvTm/DCdDUp0Cd9U7CnDdxZdJ93GdK5zKN/exLVLwzrydaQTF1leSNJEFQD+e1HlJi6Tw6qKUBFfRO2vCg6v+gSiAUFbJuPRiX/BjuEivfcB2gAfUIbDXPqTd/eJoiJuwVAO949XF9HVH8z821xbJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601417; c=relaxed/simple;
	bh=mNZ4uLxqVYF4N8q2nJuzcbJsnbso2Zr7qvhro6oRD8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=agBGnOJAzRF8OmxWa9oTatz/amI+/jqf5Q/8/yXuDfSaRyjGVujEtyJRAM3pY9P2mlBgRnSqQsAWGB+ZPQImGopGNq/mc2Tbp+WfCPj5G/Ic5uLzfTXmS+0itW6U+yAW8JThQy5tj4XrVlUYrZx4KW7w3jbAb8IugYc3vHjgCns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWH5cNfC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so36604775ad.3
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 03:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708601416; x=1709206216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xbCX2oU32ZHdT+32RY7keid4MtkTex/fIjisfOmEw0=;
        b=QWH5cNfC4BWY9q+SnWlpVFGJ+5UE8xQMyYrj4IJtdvkX0YJ6DPkyVgmDBv12Riraeb
         cS6FlqpTGGWzAMP6m5oVQYYxexpzpPDsHO0Hh+2XNP2V5euuwuFD+MtObG+mhQNFz0wR
         pIkvXEaMIDadvNgf/iuCvS96WHb4D0tfC0cZV4hBmcCkE0cilqDZDik3HdPfgv1qBCiR
         ZuLJTPYsiqOR7MjB8QTQ5r02ecNW4HZFi/mL8HtXYol0NOyoNo7Iv19khTMv0DGMxZuz
         0V+1WXG8NV9ZDvy4f3GhyT0FarXXTIcLThFtMu+1uvpw0CJkGAI8tm4swxsG2XJXpR6q
         9EYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708601416; x=1709206216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xbCX2oU32ZHdT+32RY7keid4MtkTex/fIjisfOmEw0=;
        b=UQwEjNuKaVp45N8jB5PfJdcboONWe8lV2un7/4PIcL8vdoOwVIfJt3X+wKyawja4FS
         /gcxQarAafvsT4bGFdup4ZU4Ds7XtuKpAhNKolTYGo61Fl5txfafTFMpXHt8x11zvqxM
         1pfiuSII/D7aSqDIyb/TX5fT+blFEwQChchNqIK6J1EWR7PzidFBwCfFAjX+Wq6QKqKm
         /A147/zqUIkLiF7Q4F6Dy526qbK+L+DyzPWx/GVq0GsWAj+vVYm9VmzQnl44Qs2zLbkj
         j3Dsn2aQRDkRa1EvPjhPDOUVXx8zpFXatXjuQPrtmu3bkYPDNyv/4jARLXyMqE/T2JPe
         vbuw==
X-Gm-Message-State: AOJu0YwFFy8rIbzZxAYkENSR0lYB8YGWSXeF6fzJQ+XoMRj77KTCC632
	PF5EmQcFjevYR/M+Dhtb89W1tSopqgYT3gIYmZbTlWnaWy48Fow3bEb9CI1h7rE=
X-Google-Smtp-Source: AGHT+IHOtANA2fFGRFi6JQxebA8znPjodPcPGzbeJoPUD5xsxJY0cqAUoqD5mkCiPNrp7Jsud7KUQA==
X-Received: by 2002:a17:903:2b0d:b0:1dc:7ca:36de with SMTP id mc13-20020a1709032b0d00b001dc07ca36demr11622346plb.9.1708601415742;
        Thu, 22 Feb 2024 03:30:15 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902a9c300b001dc0955c635sm5978637plr.244.2024.02.22.03.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:30:15 -0800 (PST)
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
Subject: [PATCH net-next v8 02/10] tcp: directly drop skb in cookie check for ipv4
Date: Thu, 22 Feb 2024 19:29:55 +0800
Message-Id: <20240222113003.67558-3-kerneljasonxing@gmail.com>
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

Only move the skb drop from tcp_v4_do_rcv() to cookie_v4_check() itself,
no other changes made. It can help us refine the specific drop reasons
later.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
--
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


