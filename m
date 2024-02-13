Return-Path: <netdev+bounces-71396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 885DB85329C
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FFE282046
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5685730A;
	Tue, 13 Feb 2024 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfOSlXN3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BF356B65
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833171; cv=none; b=ABqvmBJMZzV1C2goALW08H3YOIwoPQpUCy5phlAXLu6wwN1nVJTZic5ZBOcCLgGw2zNhD6LB96mDWrwXFoKAZqootdVdgnAhPqR537GNyf0vzNL4VpYx0FB8JMbooasxgnx8xF9o1vDOtvcnOkymQskDNF5bY7eDECQsoRCuiLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833171; c=relaxed/simple;
	bh=/N9m4JzzY4Og8houBpM4FYqjNvSreR2fN/mmtnP1Dgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UxVCSU/ni4FuTTi2HyeLa0UnmdNoepgfrcI9w3eNwwNPIYvEA3OgcU+ft0CndUUzKBF8K643RQxla8VH4A8wo8/zPUkVD6x4D+/8fxm29nN4q/wc2hPFYSX4aP6FhkUZ+pC8lAzh0LyHsPvcpY5p9d3iq6pKsvrtxQQ5Ztjg+gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfOSlXN3; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e0507eb60cso2808312b3a.3
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707833169; x=1708437969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2kud7U1xCPuFRH3Fod0cdrqRbt0/6Sra3JlljoFMKc=;
        b=CfOSlXN3fQG9Qzr5RGPMPEH4rOI0rIxaXOQ681J0GqdUGJfvIyZvR6z9ZUC2z4Lr5h
         1r3M6hYgpbQjMg/EuA69nAtxqGcXMMiBIwrKzKHFtvqVLNPn1zxQTrcgjhN/CnpyRAb8
         BzSxgDkFX1qu2FoMg9wy/SMp+QPRTYX7Hos2Oic0dxNBm1UF+IHQXVj+c6zKCT5Q6pYQ
         uKGHSdYWAY5ibYex+dIET8YYK/gos+lNBGs5eFCw22UOHu13eWSc4iwxZP+/e8fA1Iuf
         DOEa6JYF8l4krqVFzw+8smG+NOJagdu+KhyFgudrC8tLFSsqjpCbEu4iQsTNjrJiFUQ/
         TOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707833169; x=1708437969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2kud7U1xCPuFRH3Fod0cdrqRbt0/6Sra3JlljoFMKc=;
        b=hyINbCKZMefUSljGpg+lHm5n8zu+TyBL2x7x5uYZAfopCgNYxVHVDdH/3bX8G1ijOI
         Y39jU0oHQ0ew24fwiZUr1kxVOmn9EeF3Vtxs/rRLrBkc+x99uluKe9wfrVm1Oxv+/+DQ
         8oZ0Z/K9fNZpCEF64MQ9txLj37HxEK2RjSjexZextbZH4Z5LSjkTIIY3aO6uMS9BohmO
         n9TXgAgVCACaBKPNskGyRgZjdEsHPZ5R9V9bPCfTg30kUo7P0JfOfuVgjjMI4XXHFxxS
         5HcfPlcHDrVmIEF9IG6g11eKbX/W/Nh8U3jwb63dOljVAzLriXx784++1c/47gM0nI0L
         TuOQ==
X-Gm-Message-State: AOJu0YzU0rEnoBELjhI/aUnjTKp1gwfXs89kfX4nXIYCIRkHfh1joOWo
	nRb+4udj0JiyswHL/hb0xLE5hyuoIbOFUugoByivfeAGijaGmHeB
X-Google-Smtp-Source: AGHT+IHbeVvDAG3c1ovPSiPqCT/0TAccEI5THq1lRg6JLGKChE8IR2K/DTBFl32lqdWuhPRIM6QiGw==
X-Received: by 2002:a05:6a21:3489:b0:19e:b6c6:8f15 with SMTP id yo9-20020a056a21348900b0019eb6c68f15mr13395964pzb.25.1707833169161;
        Tue, 13 Feb 2024 06:06:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVkL/H1kxaEM2kSwwfPhY55taliSFSN6K/gcP4eauR2TRPfI8hbP8cUToWFE56/kSRLEUIYIFDeL+VSOP0Vi7LWxj0vY0U4ON6mDy4cyzC/12GPIX8q1YCbr9vJEvAzgAFpQ2l0eShkRiVvwfQ4bw3VTKoDn2zk7bd8g/gwlqRKneY3U4hsTsLmtyEE1VIPp1vD5jqLDjNM5850tp4AEFr/YeFRBGhvx4EPbaWwZKtwb35l/h0rETQwt5mhTn+QFONm
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id q19-20020a632a13000000b005dc8702f0a9sm1306247pgq.1.2024.02.13.06.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:06:08 -0800 (PST)
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
Subject: [PATCH net-next v4 2/6] tcp: add more specific possible drop reasons in tcp_rcv_synsent_state_process()
Date: Tue, 13 Feb 2024 22:05:04 +0800
Message-Id: <20240213140508.10878-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240213140508.10878-1-kerneljasonxing@gmail.com>
References: <20240213140508.10878-1-kerneljasonxing@gmail.com>
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
function in the subsequent patch in this serie.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_input.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index b1c4462a0798..43194918ab45 100644
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


