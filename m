Return-Path: <netdev+bounces-70899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC28850FC0
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 10:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56501F22DAC
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 09:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9BA12B89;
	Mon, 12 Feb 2024 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmV3TiCd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057BD17550
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707730182; cv=none; b=qlPtQVdgew7wJ8Owf3yxkGETsoik5BBkyom1X3kzJe7bj/SvFo8ZwP04/uY+tuYhDm8/XPVjJnkLfLB1p+hbH+V6hFpwiSxamOgpFPRgJ+zYWYjU5hawAhTaTmaSBM/5lZhYXDkj29O0xZ7wkhaxEr1uS5+yiJ4tovo82Ea0oLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707730182; c=relaxed/simple;
	bh=pCagSynNTlKYe4dOVJc4kvI+REabpDXkUlwOFY0W05A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OjYsOmrw8B5h3AfbQoP+e8ybAbnxvUDj+576OX6YeKjI5IYN2SQGrSlp9V9+AJngXu1H3kMkaG282h5zpdRLMXzT9WomJkRCcFPU04P25pJ7d4DSipQWAOkjb0jCqUq7xlkgR7KoxtsAQ9fvN+d2HIRtGGvsn1/W3n5aBCL1cFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmV3TiCd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d76671e5a4so24604835ad.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 01:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707730180; x=1708334980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVGxAX3qXUDPz2EArYhykiFmDLyjoCvm6jnG/mRSUlM=;
        b=EmV3TiCdaqT9Dq9TfPPTWP+nC7BUJDuzP8BH0AzNgHFTk1pGhNHfOf1N2AiyKF3aQO
         T2ZFru4Gev/lPUZIuZasmH6eNO+QeGC5ZC29HDLoC6q8hD9EVEbVmqHDRMqNjrw6Ks9Q
         vtsS57faZQUXLK2QHj/HBZbRhZgMmTk2OvRVFg8yyvYYhql2I8Thxk1Knv+dwoe2LM3d
         4QjEZ6U57d4slVRnRPeiGaiagASg9T14JtsyVf6ZBzbzhCw/g3GO1UbXqoxbTr68M3J+
         MiC8k0Kq6bxlIUJXm/A9HPjwFdqZAKWrE/hP1d/SU0gJukHVMaFc7CnL9JYuvwcr5efK
         qu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707730180; x=1708334980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVGxAX3qXUDPz2EArYhykiFmDLyjoCvm6jnG/mRSUlM=;
        b=Uz3IlA8Q3HmRV3oHtQj8Zoa5cw/RtbnzAVkLsEow+mdX1O1tiTd8QRLuGCotD4fN2l
         gLsxTcqY/Wguatw+NhZRLRC9ZXfWZ/Xw+raefSZQrl8rCLjcsStaJ9AfJpQu8fAqfUvT
         tLajcE3I4wem+3vVtTRBfkUumvrJwrV79rOn3Al1ttYyUWf1AJbLrDTGBSuCNcHP/lc5
         foCBcpB7DJJ+IVR7zQeK2PU+mu47Xdstkrmgh6zHF+V7xJTe3WpjpG1BKLEMNtNrtC8R
         yHCWuUG031ua+yXO8auoVQUfYee289atBdOZxH8k+paMxE75RpVzLXZ6Ql/Uvd/ZwFtE
         EmAA==
X-Gm-Message-State: AOJu0YyoMcBiJ1BJBcF9AEQJ5HmLIO11He7+rE26c2BvYPHjc1tg1MNy
	NjbVfJjjITpm52VnjzUpJLzBqyfjtRv/qSLTSRY8y/DQULvjf009
X-Google-Smtp-Source: AGHT+IExbaGFe8Ma3lDyWxMdULSAPZq+7HhdkrQB26XZhGZXvpJhcpAZUKt6HEzlBd1OonvkKOio/A==
X-Received: by 2002:a17:902:ebc6:b0:1d9:1b80:8799 with SMTP id p6-20020a170902ebc600b001d91b808799mr8604536plg.41.1707730180384;
        Mon, 12 Feb 2024 01:29:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0XcfSxzAQW8JJ3Iu/W2e1U3LvfonxTcnL4mBG1J7UMauBkVW4U+di/nknjZBG6WKJ2c3nAQM/HL/UekGMk5Quh+VBosc6O00det+Alxro+A3RCAxLvEhOQvkEuSN7QZy7G7maUWx+SQltsXIHaOK5cKi9hC8n37BV7SUZVzGwm8qJi0BzSrwkOvUXZJnfnVo9JfFjHBPSkX6EuVRnAiCZa1Siu4/b1zl9n1o/wWs=
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id mg12-20020a170903348c00b001da18699120sm4220211plb.43.2024.02.12.01.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 01:29:39 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 2/6] tcp: add more specific possible drop reasons in tcp_rcv_synsent_state_process()
Date: Mon, 12 Feb 2024 17:28:23 +0800
Message-Id: <20240212092827.75378-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240212092827.75378-1-kerneljasonxing@gmail.com>
References: <20240212092827.75378-1-kerneljasonxing@gmail.com>
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
index 2d20edf652e6..bfaf98c1f0ea 100644
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


