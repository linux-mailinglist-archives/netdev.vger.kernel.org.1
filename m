Return-Path: <netdev+bounces-71907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8118558B6
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 02:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D255B27E7E
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 01:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568104A3C;
	Thu, 15 Feb 2024 01:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzYKGbp+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8414A15
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707960086; cv=none; b=KjMF9kEdS1wL/gICTyf1tk/PF4dLF90aC/9lH1wmtfLu3cy+vgvP2RjpJUBRxTPRCXT/2vD5l/nfurjv28R76CuuFHyHBOYXYDKeFhz+4lG2455snu4dp9UgFVqJg//M83xpCK8OBBs6hpPF5Im/lj9gsiKNZBAGpIXjUB3eQvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707960086; c=relaxed/simple;
	bh=5yDx68fejtjjEUmPuWGGZGp6VXTlGrWC6lzV9CEbw5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xtf6W7RI2nHaTAUBSHwu/MLdh4H9ESa5Vl01jjYwKQgslMs/GoJQiJiTmt/D8uWHDd2sB9F2s4yhaZZ/Y477jCg/EpBMiNvvL+MyBKjy9XM8hT3JmBXVawXNbw7bLCd0gsxD/HjBkbTu/XBNMLtaOBAeel0NglBrom3Snsj5UTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzYKGbp+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e10e50179bso365314b3a.1
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707960084; x=1708564884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qm+66lCXgiiZgBrTpb2mvnZ1QLV5OPKqaUpatKCvlCA=;
        b=HzYKGbp+vT+LBNTpYdxZaYEQ5eHLIxk2EZO/UA8JsAc4E77UZBoI3JSOHrDFxVJk2L
         l2Dq4X32+q0lqwWk7cLrpDow+Lxpe/Dt5T5u07oYbJtGzVlBnS5NixzRE/toI+30nyBd
         IBwrcZrHy0zCQJ2O42P0Nbhl9kE+gDpdIPujgWDiyIYTz7zQW3cBz4N/yVvTvR/RKEdC
         mFdf5kkR57uDceuhPxOWE36xIZEieitRnIfYaYoSFSP/CnDc27IoZF/oErbCItLpBPI1
         1pEXZFqEJmSbj5OsE2nwcdNqTSU3sQUaNhZ5eLuGXOUpu/D71UnktQF4b7HwbReNp4xd
         H/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707960084; x=1708564884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qm+66lCXgiiZgBrTpb2mvnZ1QLV5OPKqaUpatKCvlCA=;
        b=utEI72Nh0CNWHc6hBeNnHy4V7S/I0ZElphkyxEnBkEgfdK3/sef9r+chECrcwU9Oyk
         9gB7S3Fti8dK0L3dr++0SGlLdvf1mNH0j3s1SXH/ZncEZZ2/tVI7mTJGa5xyKP4BVpek
         a6fiG/1cCFoG5/v2iywsyYDtvCMGqOMiHPmM3y7yx2klyyPGztNi/E1POanElSd20M6p
         WVmhMNCA6CBq9mlnMc0AbE2TWdt/30oW9Am7ngmyxvzx/4wJlWpgS4bSyfT1PkpK8Ct8
         7+ZjbIuAnTirv/oGU84K8Vejo54tz+HZAfjcLS/zv0+wDf7NwMrIyteMu4UM3cT8ZEwq
         PXVQ==
X-Gm-Message-State: AOJu0YwAFigYD8ACyB9db6GEf13VFBMKXhqtVZg4dzoITkgxocPnbRlW
	RRpgPV3C8VVtJQJqDYp3Mdl9chVgqxYNbiWE+ZsFkT48D2vwzzBL
X-Google-Smtp-Source: AGHT+IHGB1DXilylhIoub45UJBT1ynI6a5MPjeBJXlqEMdZnbqe1jUp4hmOdLfu70cekjoxpxL6u3A==
X-Received: by 2002:a05:6a20:6f8e:b0:19e:4a68:46d0 with SMTP id gv14-20020a056a206f8e00b0019e4a6846d0mr503768pzb.60.1707960084227;
        Wed, 14 Feb 2024 17:21:24 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([114.253.33.234])
        by smtp.gmail.com with ESMTPSA id x2-20020a17090a6c0200b00298ae12699csm163417pjj.12.2024.02.14.17.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 17:21:23 -0800 (PST)
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
Subject: [PATCH net-next v5 10/11] tcp: make dropreason in tcp_child_process() work
Date: Thu, 15 Feb 2024 09:20:26 +0800
Message-Id: <20240215012027.11467-11-kerneljasonxing@gmail.com>
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

It's time to let it work right now. We've already prepared for this:)

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_ipv4.c | 16 ++++++++++------
 net/ipv6/tcp_ipv6.c | 16 ++++++++++------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c79e25549972..c886c671fae9 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1917,7 +1917,8 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		if (!nsk)
 			return 0;
 		if (nsk != sk) {
-			if (tcp_child_process(sk, nsk, skb)) {
+			reason = tcp_child_process(sk, nsk, skb);
+			if (reason) {
 				rsk = nsk;
 				goto reset;
 			}
@@ -2276,12 +2277,15 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 			tcp_v4_restore_cb(skb);
-		} else if (tcp_child_process(sk, nsk, skb)) {
-			tcp_v4_send_reset(nsk, skb);
-			goto discard_and_relse;
 		} else {
-			sock_put(sk);
-			return 0;
+			drop_reason = tcp_child_process(sk, nsk, skb);
+			if (drop_reason) {
+				tcp_v4_send_reset(nsk, skb);
+				goto discard_and_relse;
+			} else {
+				sock_put(sk);
+				return 0;
+			}
 		}
 	}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index b13eb4985152..4b2afb9fe293 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1654,7 +1654,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 		struct sock *nsk = tcp_v6_cookie_check(sk, skb);
 
 		if (nsk && nsk != sk) {
-			if (tcp_child_process(sk, nsk, skb))
+			reason = tcp_child_process(sk, nsk, skb);
+			if (reason)
 				goto reset;
 		}
 		if (opt_skb)
@@ -1854,12 +1855,15 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 			tcp_v6_restore_cb(skb);
-		} else if (tcp_child_process(sk, nsk, skb)) {
-			tcp_v6_send_reset(nsk, skb);
-			goto discard_and_relse;
 		} else {
-			sock_put(sk);
-			return 0;
+			drop_reason = tcp_child_process(sk, nsk, skb);
+			if (drop_reason) {
+				tcp_v6_send_reset(nsk, skb);
+				goto discard_and_relse;
+			} else {
+				sock_put(sk);
+				return 0;
+			}
 		}
 	}
 
-- 
2.37.3


