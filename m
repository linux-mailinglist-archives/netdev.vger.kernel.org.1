Return-Path: <netdev+bounces-71908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B63F8558B7
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 02:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4C84B280EA
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 01:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BB6523C;
	Thu, 15 Feb 2024 01:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWlguvsy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAAD539E
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 01:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707960090; cv=none; b=mrQ4XnGi8Q9zh431z9L59LtPjHDgyBSWoTo8jlZNhpNyLZ0Qt/auzYgFuWSXS9BBelvh07Pa7tJIRbNiGwQpOS44MeP3l2etcnz35xZeKhG8I84B3DmbrZKYZJPgyzuzdi+QqKg78hXoWr1nUP+IhuxzOZLNVJOxTysibcTFS1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707960090; c=relaxed/simple;
	bh=rEW5Vwut71YTBPM3C9RxGX1gVCXR9Z717roD7XmUMsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QYjJQRq4nSj1liVr9GnZjSN/wmuWALa6lS9YVBuUaulSJdCv9nzOIAk7/SY4fUbCm1nTwhVUwDkDedkC+v6cJLnp0HBHO5B5cOJ5qX3OCj72J905lLrHbPxuzt8lKR8HWR+KVLgM4MXRez93vUBe/z+Wt+E4QO0F1XGjnQOCSFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWlguvsy; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso271649a12.3
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707960088; x=1708564888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfjBiXg6ji3knq/2N2caALWiDDilcf/0uRMXQ/e3q4A=;
        b=lWlguvsy+M7xiwEDSqvd9UDL2SMmbj/epClfzxydnbCte0kmauA3IPt8OtC/ayXQxA
         m/F3KdMXVhJTahTyOtn6SPTu1bUsl7f5YIFTGpMVpS4AII/nQsLn3xrOUprcs4+g3Is4
         qUcQtB/vq/ysRG7MJQkWEEF2ny541SmBaKg7cBKrABdpoBqBluEETc9i191dAgcJEx8K
         RmAvYzg7Nl36cOBMwXzp2SjV398anUqVyQXllyEp2uRLtDbC5Y5ZFBeWrIRJplY9LX+c
         1flK01TxnXU5wqXCCzB9YApIrRdgk3vMVmNrOPjbDFxusfmhVKvSkO/rR2pLvhBxYII7
         DKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707960088; x=1708564888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfjBiXg6ji3knq/2N2caALWiDDilcf/0uRMXQ/e3q4A=;
        b=J1dj/qP5nea2xctILecwdm66h3wUZ4zPsdEIb0tRoXMo5IepBCPQ8YB0iVjxw7aBS9
         /bA7eNAtXLoEug+AszmmJNghX2hOgvNWGvFsEkMnyP28t6EOa9Xuo8/FydCTzSIoqCtZ
         86O3ILHktY1LsRbdJaUmF/RxSGhqt4WXA1mhDoF0rmWlmdovS9sJY+fG1y+5yuphJGst
         rnViO06F2Wk4JNrfyplT58P2BHCgpVSzib3BomfaSgGw5hNPR23gs4WNfAvtajPh+6Hn
         tBDpCla/F5JCW8vSDIDfTF2zB4UhIiGTgAOXWloXIJ2rJ7nxbtFQ1pLsit6XcsSiMQmK
         WSrA==
X-Gm-Message-State: AOJu0YwUVve9CrlaooOMdX8BAc8cXoVoPvFnnLrMCfV2heK+osN+feuG
	H2JXEDVPxWxU9P1IuqxMe46z2JoMIu15KTwaCq5i/RChLklOhdP/
X-Google-Smtp-Source: AGHT+IGF60M0lwt6yD8EUof+gPtAiA1j4f3dVAWudJyefb/0lZDgSB6CG8kU8Pcpc0rZn7sA0mANBA==
X-Received: by 2002:a17:90a:fb8e:b0:298:f8ed:40cb with SMTP id cp14-20020a17090afb8e00b00298f8ed40cbmr375363pjb.30.1707960088498;
        Wed, 14 Feb 2024 17:21:28 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([114.253.33.234])
        by smtp.gmail.com with ESMTPSA id x2-20020a17090a6c0200b00298ae12699csm163417pjj.12.2024.02.14.17.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 17:21:28 -0800 (PST)
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
Subject: [PATCH net-next v5 11/11] tcp: get rid of NOT_SPECIFIED reason in tcp_v4/6_do_rcv
Date: Thu, 15 Feb 2024 09:20:27 +0800
Message-Id: <20240215012027.11467-12-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240215012027.11467-1-kerneljasonxing@gmail.com>
References: <20240215012027.11467-1-kerneljasonxing@gmail.com>
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
index 4b2afb9fe293..4035cbee32cb 100644
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


