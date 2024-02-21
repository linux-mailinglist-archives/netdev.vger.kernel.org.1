Return-Path: <netdev+bounces-73536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6451385CE68
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F70D1C22492
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE7E2BAE7;
	Wed, 21 Feb 2024 02:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTZvGhEk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7327A2B9CC
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484291; cv=none; b=PjhVynH95ACSkbEw114uuJxZbL/YAd7tatjtXAZ6ZMD7rgTUb1fIVhBtxg0iTUEsGFlFYwi9EOp9DeDLYQNQKo8NQHPHjcwS/m2nF52DJioLS/PW1WJ40RudlEei/ImUFfW7jszhWIA+L2GcVZCufr5rSDQSun2/9PMyBx1cXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484291; c=relaxed/simple;
	bh=cW3e/HxRoerfB+CnSkxC6fP8IbXvOpf5u17yRRYGdyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CZmrMVN1NOaJ6Y1J2ejSt2PEn6d7F3zVkvSPpnTY+NjlN04hE7fEoEj2iYkCX4yovuiCHA2zgf1aOsIdQqjwNcgI18KBa2c8D3HOeEe9FQPD3QUZNQTrY8Hmci3TGnmDkE1VOgqILNJnRzbzdInBtrxqboMs6qinTwJr2lRZ7ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTZvGhEk; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso96412a12.2
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 18:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708484290; x=1709089090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tc4RsuO7ABCUQWRTU4WnZFcSZZnU1hvSvcjCAudBuTA=;
        b=hTZvGhEkozScpLZC0dRqVJBoaHl8zrtUZ/sHEZDJVdfAciaav5efcJ8tVzYBsJMMel
         zBt6jxIrMXINRXweaCEZ75RJ31s6seFxk60k6ZbD/WFwDGJ9hov8UpJZJJDGuOmYLlYZ
         PKcHV3yAH/Snu9+NXuLA5lxY+crc/u907lCVF1GFeS80Lr3AUpUy7dW/ljDoSNKOhKSc
         E2ScwrayBaDVC6z77F4MIFswJUr42d39Uuoozv3v9DuWNhbwipACiehVUkPKCsN2yLKU
         mVBshVEdH9p9eXVdzvcQLpGK+fDN9Z3NmcG7olHA0hNLH3rXWZNOss6TvKZ/rHtOh0Rd
         S8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708484290; x=1709089090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tc4RsuO7ABCUQWRTU4WnZFcSZZnU1hvSvcjCAudBuTA=;
        b=McisoJtGYiI9wFZgu+OuRgJkQ58tUL/Qh+BPlmDmIrG9oruPn4fkyAT6hOP+XVM3ym
         5cGFe8m4pDoAIPPWtj3rVV81l0ZWuVjCs/Ij1SF+2gqb5u99JKUvqZRtvi1joJwipA1c
         c+osaRoduTPPb9TFIy28E4PwzzcszmVirSEBWH/9kHOsgrfP95domzKoDvDZaK5MSLSN
         +NK3P0nxBj+HLn6+TfCMFBDsiJs4+dgRJjbdookVMFOrQi4St/KKKGs1yZS22EZzVWuG
         vbCfrOMrwqR3ESGMoRMLyHrjApn1Vd+bdAi25XgXkdEYHXB42ESuWZPEeD8NvKXQFObz
         IxdQ==
X-Gm-Message-State: AOJu0Yx0/IS4NjOryDr0+dgwFADnEi3hvi5OsIbR06ql9Y7MclmBzv77
	KAEc6BWCNA2DcMMthzSqStI4JKrS3/9WAsvoTCF2bbjwKXiUSU+o
X-Google-Smtp-Source: AGHT+IGnPXhNrOHaxmr3erQ4JghlrVaSOeHmRHkBVEmMOHqVHllk/KD3+3/2DVtUM8oFby1naxe/1Q==
X-Received: by 2002:a05:6a21:3409:b0:19e:4ed7:127a with SMTP id yn9-20020a056a21340900b0019e4ed7127amr21392515pzb.46.1708484289853;
        Tue, 20 Feb 2024 18:58:09 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id pv14-20020a17090b3c8e00b0029454cca5c3sm426467pjb.39.2024.02.20.18.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 18:58:09 -0800 (PST)
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
Subject: [PATCH net-next v7 07/11] tcp: add more specific possible drop reasons in tcp_rcv_synsent_state_process()
Date: Wed, 21 Feb 2024 10:57:27 +0800
Message-Id: <20240221025732.68157-8-kerneljasonxing@gmail.com>
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

This patch does two things:
1) add two more new reasons
2) only change the return value(1) to various drop reason values
for the future use

For now, we still cannot trace those two reasons. We'll implement the full
function in the subsequent patch in this series.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_input.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 74c03f0a6c0c..83308cca1610 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6361,6 +6361,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 				inet_csk_reset_xmit_timer(sk,
 						ICSK_TIME_RETRANS,
 						TCP_TIMEOUT_MIN, TCP_RTO_MAX);
+			SKB_DR_SET(reason, TCP_INVALID_ACK_SEQUENCE);
 			goto reset_and_undo;
 		}
 
@@ -6369,6 +6370,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 			     tcp_time_stamp_ts(tp))) {
 			NET_INC_STATS(sock_net(sk),
 					LINUX_MIB_PAWSACTIVEREJECTED);
+			SKB_DR_SET(reason, TCP_RFC7323_PAWS);
 			goto reset_and_undo;
 		}
 
@@ -6572,7 +6574,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 reset_and_undo:
 	tcp_clear_options(&tp->rx_opt);
 	tp->rx_opt.mss_clamp = saved_clamp;
-	return 1;
+	/* we can reuse/return @reason to its caller to handle the exception */
+	return reason;
 }
 
 static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
-- 
2.37.3


